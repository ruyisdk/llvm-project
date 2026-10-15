//===- SemaRISCVZtt.cpp - RISC-V Ztt semantic checks ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/AST/ASTContext.h"
#include "clang/AST/Attr.h"
#include "clang/Basic/Builtins.h"
#include "clang/Basic/RISCVZttBuiltins.h"
#include "clang/Basic/TargetInfo.h"
#include "clang/Sema/Initialization.h"
#include "clang/Sema/Sema.h"
#include "clang/Sema/SemaRISCV.h"
#include "llvm/ADT/ScopeExit.h"

using namespace clang;
using namespace llvm;

namespace {
using MatrixInfo = ASTContext::BuiltinRISCVZttTypeInfo;
using clang::RISCV::RISCVZttBuiltinInfo;
using clang::RISCV::RISCVZttOperation;
using clang::RISCV::RISCVZttResultKind;

enum class RISCVZttSemaArgCheckKind {
#define GET_RISCV_ZTT_SEMA_ARG_CHECK_KINDS
#include "clang/Basic/riscv_ztt_builtins.inc"
#undef GET_RISCV_ZTT_SEMA_ARG_CHECK_KINDS
};

enum class RISCVZttComputeMatrixArgRule {
  Any,
  FirstFP,
  Select,
  SecondInt,
  AllSameAsRes,
  Gather,
  AllInt,
  AllSameIntAsRes
};

enum class RISCVZttComputeScalarArgRule {
  None,
  Any,
  Int,
  ControlSize,
  ControlInt,
  ControlLong
};

// Checks shared by all datatype and shape variants of an operation.
struct RISCVZttSemaInfo {
  RISCVZttSemaArgCheckKind ArgCheckKind;
  const char *Name;
  unsigned NumMatrixArgs;
  unsigned NumScalarArgs;
  bool HasOldResult;
  RISCVZttComputeScalarArgRule ComputeScalarArgRule;
  RISCVZttComputeMatrixArgRule ComputeMatrixArgRule;

  unsigned getNumArgs() const {
    return NumMatrixArgs + NumScalarArgs + unsigned(HasOldResult);
  }
};

static constexpr RISCVZttSemaInfo RISCVZttSemaTable[] = {
#define GET_RISCV_ZTT_SEMA_TABLE
#include "clang/Basic/riscv_ztt_builtins.inc"
#undef GET_RISCV_ZTT_SEMA_TABLE
};

// Return RISC-V Ztt matrix type information, or none for other types.
std::optional<MatrixInfo> getMatrixInfo(ASTContext &Context, QualType Ty) {
  if (Ty.isNull() || !Ty->isRISCVZttBuiltinType())
    return std::nullopt;
  return Context.getBuiltinRISCVZttTypeInfo(Ty->castAs<BuiltinType>());
}

// Datatype identity includes signedness, rounding and saturation.
bool hasSameElementType(const MatrixInfo &A, const MatrixInfo &B) {
  return A.ElementType == B.ElementType && A.ElementBits == B.ElementBits &&
         A.DatatypeOptions == B.DatatypeOptions;
}

bool hasSameShape(const MatrixInfo &A, const MatrixInfo &B) {
  return A.NumRows == B.NumRows && A.NumColumns == B.NumColumns;
}

// Double 1xK or Kx1; 1x1 may become 1x2 or 2x1.
bool isRISCVZttDoubleShape(const MatrixInfo &Large, const MatrixInfo &Small) {
  return (Small.NumRows == 1 && Large.NumRows == 1 &&
          Large.NumColumns == 2 * Small.NumColumns) ||
         (Small.NumColumns == 1 && Large.NumColumns == 1 &&
          Large.NumRows == 2 * Small.NumRows);
}

// Shared state and checks for one RISC-V Ztt intrinsic call.
class RISCVZttCallChecker : public SemaBase {
  ASTContext &Context;
  const TargetInfo &TI;
  const llvm::RISCV::ZttProfile &Profile;
  const RISCVZttBuiltinInfo &Builtin;
  const RISCVZttSemaInfo &Info;
  CallExpr *TheCall;
  std::optional<MatrixInfo> Result;

  // Check UDS and register limits; each ACC square uses one register.
  bool checkLayout(QualType Ty) {
    auto Matrix = getMatrixInfo(Context, Ty);
    if (!Matrix)
      return false;
    unsigned Limit = Matrix->isMType() ? Profile.MRegs : Profile.ARegs;
    unsigned LogicalBits =
        Matrix->ElementBits * Matrix->getLogicalSquareCount();
    unsigned Required = Matrix->isMType()
                            ? llvm::divideCeil(LogicalBits, Profile.UdsBits)
                            : Matrix->NumACCRegisters;
    if (Matrix->isMType()) {
      if (LogicalBits < Profile.UdsBits)
        return Diag(TheCall->getBeginLoc(),
                    diag::err_riscv_ztt_half_register_type)
               << Ty << LogicalBits << Profile.UdsBits;
      if (Required > 32)
        return Diag(TheCall->getBeginLoc(),
                    diag::err_riscv_ztt_too_many_m_registers)
               << Ty << Required;
      assert(llvm::isPowerOf2_32(Required) &&
             "RISC-V Ztt M-register group size must be a power of two");
    }
    if (Required > Limit)
      return Diag(TheCall->getBeginLoc(), diag::err_riscv_ztt_register_capacity)
             << Ty << Required << unsigned(!Matrix->isMType()) << Limit;
    return false;
  }

  // Report invalid operand types or shapes with the instruction name.
  bool diagnoseOperandTypes(SourceLocation Loc) {
    if (Info.ArgCheckKind == RISCVZttSemaArgCheckKind::Matmul)
      return Diag(Loc, diag::err_riscv_ztt_matmul_types) << Info.Name;
    return Diag(Loc, diag::err_riscv_ztt_operand_types) << Info.Name;
  }

  // Diagnose a non-M source; otherwise return its layout information.
  std::optional<MatrixInfo> getMSource(unsigned Index) {
    QualType Ty = TheCall->getArg(Index)->getType();
    auto Matrix = getMatrixInfo(Context, Ty);
    if (!Matrix || !Matrix->isMType()) {
      Diag(TheCall->getBeginLoc(), diag::err_riscv_ztt_builtin_requires_m_type)
          << Ty;
      return std::nullopt;
    }
    return Matrix;
  }

  // Check both M sources and return their layout information.
  bool checkTwoMSources(unsigned First, MatrixInfo &L, MatrixInfo &R) {
    QualType LTy = TheCall->getArg(First)->getType();
    QualType RTy = TheCall->getArg(First + 1)->getType();
    auto Left = getMatrixInfo(Context, LTy);
    auto Right = getMatrixInfo(Context, RTy);
    if (!Left || !Right || !Left->isMType() || !Right->isMType())
      return Diag(TheCall->getBeginLoc(),
                  diag::err_riscv_ztt_requires_two_m_types)
             << Info.Name << LTy << RTy;
    L = *Left;
    R = *Right;
    return false;
  }

  bool hasSameOldResultType() const {
    return !Info.HasOldResult ||
           Context.hasSameUnqualifiedType(TheCall->getArg(0)->getType(),
                                          TheCall->getType());
  }

  // Public interfaces use explicit casts for controls; raw builtins use
  // implicit casts.
  ExprResult convertControl(Expr *Arg, QualType Ty) {
    if (TheCall->getDirectCallee()->hasAttr<BuiltinAliasAttr>())
      return SemaRef.BuildCStyleCastExpr(Arg->getBeginLoc(),
                                         Context.getTrivialTypeSourceInfo(Ty),
                                         Arg->getEndLoc(), Arg);
    return SemaRef.ImpCastExprToType(Arg, Ty, CK_IntegralCast);
  }

  bool checkControl(unsigned Index, QualType Carrier) {
    Expr *Arg = TheCall->getArg(Index);
    if (!Arg->getType()->isIntegerType())
      return Diag(Arg->getBeginLoc(),
                  diag::err_riscv_ztt_control_requires_integer)
             << Arg->getType();
    ExprResult Converted = convertControl(Arg, Carrier);
    if (Converted.isInvalid())
      return true;
    TheCall->setArg(Index, Converted.get());
    return false;
  }

  // RISC-V Ztt scalars must fit a GPR; controls use C integer conversions.
  bool checkComputeScalarArg() {
    auto Rule = Info.ComputeScalarArgRule;
    if (Rule == RISCVZttComputeScalarArgRule::None)
      return false;
    unsigned Index = TheCall->getNumArgs() - 1;
    Expr *Arg = TheCall->getArg(Index);
    if (Rule == RISCVZttComputeScalarArgRule::Any ||
        Rule == RISCVZttComputeScalarArgRule::Int) {
      QualType Ty = Arg->getType();
      if (!Ty->isRISCVZttScalarBuiltinType())
        return diagnoseOperandTypes(Arg->getBeginLoc());
      auto Scalar =
          Context.getBuiltinRISCVZttScalarTypeInfo(Ty->castAs<BuiltinType>());
      if (Rule == RISCVZttComputeScalarArgRule::Int &&
          !Scalar.ValueType->isIntegerType())
        return diagnoseOperandTypes(Arg->getBeginLoc());
      unsigned XLen = TI.getPointerWidth(LangAS::Default);
      if (Scalar.ElementBits > XLen)
        return Diag(Arg->getBeginLoc(), diag::err_riscv_ztt_scalar_width)
               << Ty << Scalar.ElementBits << XLen;
      return false;
    }
    QualType ControlTy =
        Rule == RISCVZttComputeScalarArgRule::ControlSize
            ? Context.getSizeType()
        : Rule == RISCVZttComputeScalarArgRule::ControlInt ? Context.IntTy
                                                           : Context.LongTy;
    return checkControl(Index, ControlTy);
  }

  // Each source must be an M type with the result shape and allowed datatype.
  bool checkComputeMatrixArg(unsigned Index) {
    auto Src = getMSource(unsigned(Info.HasOldResult) + Index);
    if (!Src)
      return true;
    if (!hasSameShape(*Src, *Result))
      return diagnoseOperandTypes(TheCall->getBeginLoc());

    bool Matches;
    switch (Info.ComputeMatrixArgRule) {
    case RISCVZttComputeMatrixArgRule::Any:
      Matches = true;
      break;
    case RISCVZttComputeMatrixArgRule::FirstFP:
      Matches = Index != 0 || Src->ElementType->isRealFloatingType();
      break;
    case RISCVZttComputeMatrixArgRule::Select:
      Matches = Index != 1 || hasSameElementType(*Src, *Result);
      break;
    case RISCVZttComputeMatrixArgRule::SecondInt:
      Matches = Index != 1 || Src->ElementType->isIntegerType();
      break;
    case RISCVZttComputeMatrixArgRule::AllSameAsRes:
      Matches = hasSameElementType(*Src, *Result);
      break;
    case RISCVZttComputeMatrixArgRule::Gather:
      Matches = Index == 0 ? hasSameElementType(*Src, *Result)
                           : Index != 1 || Src->ElementType->isIntegerType();
      break;
    case RISCVZttComputeMatrixArgRule::AllInt:
      // Arithmetic right shift requires a signed data source.
      if (Index == 0 &&
          (Builtin.Operation == RISCVZttOperation::riscv_ztt_op_msra_ew ||
           Builtin.Operation == RISCVZttOperation::riscv_ztt_op_msra_ew_x))
        Matches = Src->ElementType->isSignedIntegerType();
      else
        Matches = Src->ElementType->isIntegerType();
      break;
    case RISCVZttComputeMatrixArgRule::AllSameIntAsRes:
      Matches = Src->ElementType->isIntegerType() &&
                hasSameElementType(*Src, *Result);
      break;
    default:
      llvm_unreachable("unknown RISC-V Ztt Compute matrix argument rule");
    }
    return !Matches && diagnoseOperandTypes(TheCall->getBeginLoc());
  }

  // Check input types and shapes; hardware checks datatype combinations.
  bool checkCompute() {
    if (!hasSameOldResultType())
      return diagnoseOperandTypes(TheCall->getBeginLoc());
    for (unsigned I = 0; I != Info.NumMatrixArgs; ++I)
      if (checkComputeMatrixArg(I))
        return true;
    return checkComputeScalarArg();
  }

  // Check the element pointer type, const/volatile and optional byte stride.
  bool checkLoadStore() {
    bool IsStore = Builtin.ResultKind == RISCVZttResultKind::NonMatrix;
    bool Strided = Info.NumScalarArgs == 2;
    unsigned MatrixIndex = Info.NumScalarArgs;
    auto Matrix = IsStore ? getMSource(MatrixIndex) : Result;
    if (!Matrix)
      return true;
    // Load return-type checks reject elements narrower than 8 bits.
    if (IsStore && Matrix->ElementBits < 8)
      return Diag(Strided ? TheCall->getBeginLoc()
                          : TheCall->getArg(MatrixIndex)->getBeginLoc(),
                  diag::err_riscv_ztt_memory_no_element_carrier)
             << TheCall->getArg(MatrixIndex)->getType();
    if (Strided && checkControl(1, Context.getSizeType()))
      return true;
    ExprResult Ptr =
        SemaRef.DefaultFunctionArrayLvalueConversion(TheCall->getArg(0));
    if (Ptr.isInvalid())
      return true;
    TheCall->setArg(0, Ptr.get());
    QualType PtrTy = Ptr.get()->getType();
    if (!PtrTy->isPointerType())
      return Diag(Ptr.get()->getBeginLoc(),
                  diag::err_riscv_ztt_memory_base_requires_pointer)
             << PtrTy;
    QualType PointeeTy = PtrTy->getPointeeType();
    if (!Context.hasSameUnqualifiedType(PointeeTy, Matrix->ElementType))
      return Diag(Ptr.get()->getBeginLoc(),
                  diag::err_riscv_ztt_memory_base_type_mismatch)
             << PointeeTy << Matrix->ElementType;
    if (PointeeTy.isVolatileQualified() ||
        (IsStore && PointeeTy.isConstQualified()))
      return Diag(Ptr.get()->getBeginLoc(),
                  diag::err_riscv_ztt_memory_base_qualifiers)
             << IsStore << PointeeTy;
    return false;
  }

  bool checkCopy() {
    QualType SrcTy = TheCall->getArg(0)->getType();
    bool Matches;
    if (Builtin.Operation == RISCVZttOperation::riscv_ztt_op_mcopy_m2m) {
      Matches = Context.hasSameUnqualifiedType(SrcTy, TheCall->getType());
    } else {
      bool SourceIsAcc = Builtin.ResultKind == RISCVZttResultKind::M;
      auto Src = getMatrixInfo(Context, SrcTy);
      if (!Src || (SourceIsAcc ? !Src->isACCType() : !Src->isMType()))
        return Diag(TheCall->getBeginLoc(),
                    diag::err_riscv_ztt_mcopy_requires_register_type)
               << unsigned(SourceIsAcc) << SrcTy;
      Matches = hasSameElementType(*Src, *Result) &&
                Src->getLogicalSquareCount() == Result->getLogicalSquareCount();
    }
    if (!Matches)
      return Diag(TheCall->getBeginLoc(),
                  diag::err_riscv_ztt_mcopy_type_mismatch)
             << SrcTy << TheCall->getType();
    return false;
  }

  bool checkConcat() {
    MatrixInfo L, R;
    if (checkTwoMSources(0, L, R))
      return true;
    QualType LTy = TheCall->getArg(0)->getType();
    QualType RTy = TheCall->getArg(1)->getType();
    if (!Context.hasSameType(LTy, RTy))
      return Diag(TheCall->getBeginLoc(),
                  diag::err_riscv_ztt_mconcat_source_mismatch)
             << LTy << RTy;
    if (!hasSameElementType(L, *Result) || !isRISCVZttDoubleShape(*Result, L))
      return Diag(TheCall->getBeginLoc(),
                  diag::err_riscv_ztt_mconcat_result_mismatch)
             << TheCall->getType() << LTy;
    return false;
  }

  bool checkExtract() {
    auto Src = getMSource(0);
    if (!Src)
      return true;
    if (!isRISCVZttDoubleShape(*Src, *Result) ||
        !hasSameElementType(*Src, *Result))
      return diagnoseOperandTypes(TheCall->getBeginLoc());
    llvm::APSInt Index;
    if (SemaRef.BuiltinConstantArg(TheCall, 1, Index))
      return true;
    if (Index.isNegative() || Index.ugt(1))
      return diagnoseOperandTypes(TheCall->getBeginLoc());
    return checkControl(1, Context.getSizeType());
  }

  bool checkMatmul() {
    MatrixInfo L, R;
    if (checkTwoMSources(1, L, R))
      return true;
    if (!hasSameOldResultType())
      return diagnoseOperandTypes(TheCall->getBeginLoc());
    bool ShapesMatch;
    switch (Builtin.Operation) {
    case RISCVZttOperation::riscv_ztt_op_mmulacc_2d:
    case RISCVZttOperation::riscv_ztt_op_mmulaccneg_2d:
      ShapesMatch =
          L.NumRows == 1 && R.NumColumns == 1 && L.NumColumns == R.NumRows;
      break;
    case RISCVZttOperation::riscv_ztt_op_mmulatacc_2d:
    case RISCVZttOperation::riscv_ztt_op_mmulataccneg_2d:
    case RISCVZttOperation::riscv_ztt_op_mmulbtacc_2d:
    case RISCVZttOperation::riscv_ztt_op_mmulbtaccneg_2d:
      ShapesMatch = hasSameShape(L, R);
      break;
    default:
      llvm_unreachable("unexpected RISC-V Ztt matmul operation");
    }
    return !ShapesMatch && diagnoseOperandTypes(TheCall->getBeginLoc());
  }

  bool checkAcquire() {
    // Check the argument type before its implicit conversion to size_t.
    Expr *Desc = TheCall->getArg(0)->IgnoreParenImpCasts();
    QualType Ty = Desc->getType().getAtomicUnqualifiedType();
    if (!Ty->isIntegralOrEnumerationType())
      return Diag(Desc->getBeginLoc(),
                  diag::err_riscv_ztt_control_requires_integer)
             << Ty;
    if (TheCall->getDirectCallee()->hasAttr<BuiltinAliasAttr>()) {
      ExprResult Converted = convertControl(Desc, Context.getSizeType());
      if (Converted.isInvalid())
        return true;
      TheCall->setArg(0, Converted.get());
    }
    return false;
  }

  bool checkZip() {
    // The two squares must start in different M registers.
    if (!hasSameOldResultType() || Result->ElementBits < Profile.UdsBits)
      return Diag(TheCall->getBeginLoc(), diag::err_riscv_ztt_zip_types);
    return false;
  }

  bool checkSpecial() {
    switch (Builtin.Operation) {
    case RISCVZttOperation::riscv_ztt_op_ame_acquire:
      return checkAcquire();
    case RISCVZttOperation::riscv_ztt_op_mconcat_m:
      return checkConcat();
    case RISCVZttOperation::riscv_ztt_op_mextract:
      return checkExtract();
    case RISCVZttOperation::riscv_ztt_op_mrowzip_ew:
    case RISCVZttOperation::riscv_ztt_op_mcolzip_ew:
    case RISCVZttOperation::riscv_ztt_op_mrowunzip_ew:
    case RISCVZttOperation::riscv_ztt_op_mcolunzip_ew:
      return checkZip();
    default:
      llvm_unreachable("unexpected RISC-V Ztt special operation");
    }
  }

public:
  RISCVZttCallChecker(Sema &S, const TargetInfo &TI,
                      const llvm::RISCV::ZttProfile &Profile,
                      const RISCVZttBuiltinInfo &Builtin,
                      const RISCVZttSemaInfo &Info, CallExpr *TheCall)
      : SemaBase(S), Context(getASTContext()), TI(TI), Profile(Profile),
        Builtin(Builtin), Info(Info), TheCall(TheCall),
        Result(getMatrixInfo(Context, TheCall->getType())) {}

  bool check() {
    if (checkLayout(TheCall->getType()))
      return true;
    for (const Expr *Arg : TheCall->arguments())
      if (checkLayout(Arg->getType()))
        return true;
    // Matrix-result argument counts are checked by the caller.
    if (Builtin.ResultKind == RISCVZttResultKind::NonMatrix &&
        SemaRef.checkArgCount(TheCall, Info.getNumArgs()))
      return true;
    // Read arguments without promoting small integers or floats.
    // Load/store bases and acquire use their own conversions.
    if (Info.ArgCheckKind != RISCVZttSemaArgCheckKind::None &&
        Builtin.Operation != RISCVZttOperation::riscv_ztt_op_ame_acquire) {
      unsigned Begin =
          Info.ArgCheckKind == RISCVZttSemaArgCheckKind::LoadStore ? 1 : 0;
      for (unsigned I = Begin; I != TheCall->getNumArgs(); ++I) {
        ExprResult Arg = SemaRef.DefaultLvalueConversion(TheCall->getArg(I));
        if (Arg.isInvalid())
          return true;
        TheCall->setArg(I, Arg.get());
      }
    }
    switch (Info.ArgCheckKind) {
    case RISCVZttSemaArgCheckKind::None:
      return false;
    case RISCVZttSemaArgCheckKind::LoadStore:
      return checkLoadStore();
    case RISCVZttSemaArgCheckKind::Compute:
      return checkCompute();
    case RISCVZttSemaArgCheckKind::Copy:
      return checkCopy();
    case RISCVZttSemaArgCheckKind::Matmul:
      return checkMatmul();
    case RISCVZttSemaArgCheckKind::Special:
      return checkSpecial();
    }
    llvm_unreachable("unknown RISC-V Ztt Sema argument check kind");
  }
};
} // namespace

bool SemaRISCV::CheckRISCVZttBuiltinFunctionCall(const TargetInfo &TI,
                                                 unsigned BuiltinID,
                                                 CallExpr *TheCall) {
  ASTContext &Context = getASTContext();
  const auto *Builtin = RISCV::getRISCVZttBuiltinInfo(BuiltinID);
  assert(Builtin && "expected RISC-V Ztt builtin");
  const auto &Info =
      RISCVZttSemaTable[static_cast<unsigned>(Builtin->Operation)];
  unsigned NumArgs = Info.getNumArgs();
  CallExpr *OriginalCall = TheCall;
  if (Builtin->ResultKind != RISCVZttResultKind::NonMatrix) {
    bool HasMarker = !TheCall->getDirectCallee()->hasAttr<BuiltinAliasAttr>();
    if (SemaRef.checkArgCount(TheCall, NumArgs + unsigned(HasMarker)))
      return true;
    Expr *Marker = HasMarker ? TheCall->getArg(NumArgs) : nullptr;
    QualType ResultTy = TheCall->getType();
    if (Marker) {
      const auto *Pointer = Marker->getType()->getAs<PointerType>();
      ResultTy =
          Pointer ? Pointer->getPointeeType().getUnqualifiedType() : QualType();
    }
    // Public names and raw result markers use the same return-type rules.
    auto Result = getMatrixInfo(Context, ResultTy);
    if (!Result ||
        !Builtin->acceptsResult(
            Result->isACCType(), Result->ElementType->isIntegerType(),
            Result->ElementBits, Result->NumRows, Result->NumColumns,
            Result->getLogicalSquareCount()) ||
        (Marker && (Marker->HasSideEffects(Context) ||
                    !Marker->IgnoreParenCasts()->isNullPointerConstant(
                        Context, Expr::NPC_ValueDependentIsNotNull))))
      return Diag(Marker ? Marker->getBeginLoc() : TheCall->getBeginLoc(),
                  diag::err_riscv_ztt_result_marker);
    if (Marker) {
      // Check operands without the marker; keep it in the AST for templates/PCH.
      auto Args = llvm::ArrayRef(TheCall->getArgs(), NumArgs);
      TheCall = CallExpr::Create(Context, TheCall->getCallee(), Args, ResultTy,
                                 VK_PRValue, TheCall->getRParenLoc(),
                                 TheCall->getFPFeatures());
    }
  }
  auto SyncArguments = llvm::scope_exit([&] {
    if (TheCall != OriginalCall) {
      for (unsigned I = 0; I != NumArgs; ++I)
        OriginalCall->setArg(I, TheCall->getArg(I));
      OriginalCall->setType(TheCall->getType());
    }
  });
  const auto &Profile = RISCV::getRISCVZttProfile(TI);
  // Every RISC-V Ztt builtin needs a profile, including state and CSR calls.
  if (!Profile)
    return Diag(TheCall->getBeginLoc(),
                diag::err_riscv_ztt_builtin_requires_profile);
  return RISCVZttCallChecker(SemaRef, TI, *Profile, *Builtin, Info, TheCall)
      .check();
}

bool SemaRISCV::isValidRISCVZttInitialization(
    const InitializedEntity &Entity, const InitializationKind &Kind,
    ArrayRef<Expr *> Args) {
  // Arguments and return values can use existing matrices.
  switch (Entity.getKind()) {
  case InitializedEntity::EK_Parameter:
  case InitializedEntity::EK_Parameter_CF_Audited:
  case InitializedEntity::EK_Result:
  case InitializedEntity::EK_RelatedResult:
  case InitializedEntity::EK_StmtExprResult:
    return true;
  default:
    break;
  }

  // Only parentheses may surround the call, not casts or other expressions.
  if (Kind.isExplicitCast() || Args.size() != 1)
    return false;
  const auto *Call = dyn_cast<CallExpr>(Args[0]->IgnoreParens());
  const auto *Callee = Call ? Call->getDirectCallee() : nullptr;
  return Callee && RISCV::getRISCVZttBuiltinInfo(Callee->getBuiltinID()) &&
         Call->getType()->isRISCVZttBuiltinType();
}
