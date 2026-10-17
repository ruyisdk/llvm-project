//===- RISCVZttScalarTest.cpp - RISC-V Ztt scalar tests ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/AST/ASTContext.h"
#include "clang/AST/ASTImporter.h"
#include "clang/AST/Mangle.h"
#include "clang/Sema/Sema.h"
#include "clang/Sema/SemaRISCV.h"
#include "clang/Tooling/Tooling.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/StringMap.h"
#include "gtest/gtest.h"

using namespace clang;

namespace {

TEST(RISCVZttScalarTest, OrdinaryTypes) {
  auto AST = tooling::buildASTFromCodeWithArgs(
      "", {"-target", "x86_64-unknown-linux-gnu"}, "input.c");
  ASSERT_TRUE(AST);
  ASSERT_FALSE(AST->getDiagnostics().hasErrorOccurred());
  ASTContext &Ctx = AST->getASTContext();
  struct {
    QualType Ty;
    std::optional<Type::ScalarTypeKind> Kind;
  } Types[] = {
      {Ctx.BoolTy, Type::STK_Bool},
      {Ctx.IntTy, Type::STK_Integral},
      {Ctx.UnsignedIntTy, Type::STK_Integral},
      {Ctx.FloatTy, Type::STK_Floating},
      {Ctx.DoubleTy, Type::STK_Floating},
      {Ctx.getPointerType(Ctx.IntTy), Type::STK_CPointer},
      {Ctx.getComplexType(Ctx.FloatTy), Type::STK_FloatingComplex},
      {Ctx.getBitIntType(false, 17), Type::STK_Integral},
      {Ctx.VoidTy, std::nullopt},
      {Ctx.getVectorType(Ctx.IntTy, 4, VectorKind::Generic), std::nullopt},
      {Ctx.getAtomicType(Ctx.IntTy), std::nullopt},
  };
  for (const auto &From : Types) {
    SCOPED_TRACE(From.Ty.getAsString());
    EXPECT_FALSE(From.Ty->isRISCVZttScalarBuiltinType());
    EXPECT_EQ(From.Kind.has_value(), From.Ty->isScalarType());
    if (From.Kind)
      EXPECT_EQ(*From.Kind, From.Ty->getScalarTypeKind());
  }
}

TEST(RISCVZttScalarTest, OrdinaryConversions) {
  for (const char *FileName : {"input.c", "input.cpp"}) {
    SCOPED_TRACE(FileName);
    auto AST = tooling::buildASTFromCodeWithArgs(
        R"(
          int integer = (int)3.75;
          double floating = 4;
          int from_double(double x) { int n = x; n = (int)x; return n; }
          double from_int(int n) { double x = n; x = (double)n; return x; }
        )",
        {"-target", "x86_64-unknown-linux-gnu"}, FileName);
    ASSERT_TRUE(AST);
    ASSERT_FALSE(AST->getDiagnostics().hasErrorOccurred());
    ASTContext &Ctx = AST->getASTContext();
    unsigned NumValues = 0;
    for (Decl *D : Ctx.getTranslationUnitDecl()->decls()) {
      const auto *VD = dyn_cast<VarDecl>(D);
      if (!VD)
        continue;
      Expr::EvalResult Result;
      ASSERT_TRUE(VD->getInit()->EvaluateAsRValue(Result, Ctx));
      if (VD->getName() == "integer") {
        ASSERT_TRUE(Result.Val.isInt());
        EXPECT_EQ(3, Result.Val.getInt());
      } else {
        ASSERT_EQ("floating", VD->getName());
        ASSERT_TRUE(Result.Val.isFloat());
        EXPECT_TRUE(Result.Val.getFloat().bitwiseIsEqual(llvm::APFloat(4.0)));
      }
      ++NumValues;
    }
    EXPECT_EQ(2u, NumValues);
  }
}

static SmallVector<QualType, 104> getScalarTypes(ASTContext &Ctx) {
  return {
#define RISCV_ZTT_TYPE(Name, Id, SingletonId) Ctx.SingletonId,
#include "clang/Basic/RISCVZttScalarTypes.def"
  };
}

class RISCVZttScalarTypeTest : public testing::TestWithParam<const char *> {
protected:
  std::unique_ptr<ASTUnit> AST;

  bool isRV64() const { return StringRef(GetParam()).starts_with("riscv64"); }

  std::unique_ptr<ASTUnit> createAST() {
    return tooling::buildASTFromCodeWithArgs(
        "",
        {"-target", GetParam(),
         isRV64() ? "-march=rv64gc_ztt" : "-march=rv32gc_ztt",
         "-mztt-profile=clang-runtime-u32-m16-a4"},
        "input.c");
  }

  void SetUp() override {
    AST = createAST();
    ASSERT_TRUE(AST);
    ASSERT_FALSE(AST->getDiagnostics().hasErrorOccurred());
  }
};

TEST_P(RISCVZttScalarTypeTest, TypesAndNames) {
  ASTContext &Ctx = AST->getASTContext();
  llvm::StringMap<QualType> Types;
  llvm::DenseSet<const Type *> Identities;
  for (QualType Ty : getScalarTypes(Ctx)) {
    ASSERT_FALSE(Ty.isNull());
    EXPECT_TRUE(Ty.isCanonical());
    EXPECT_TRUE(isa<BuiltinType>(Ty));
    EXPECT_TRUE(Identities.insert(Ty.getTypePtr()).second);
    EXPECT_TRUE(Types.try_emplace(Ty.getAsString(), Ty).second);
  }
  ASSERT_EQ(104u, Types.size());

  // Expected formats and options are independent of the builtin definition.
  struct {
    const char *Name;
    QualType Value;
    unsigned Bits;
  } Formats[] = {
      {"i8", Ctx.SignedCharTy, 8},
      {"u8", Ctx.UnsignedCharTy, 8},
      {"i16", Ctx.ShortTy, 16},
      {"u16", Ctx.UnsignedShortTy, 16},
      {"i32", Ctx.IntTy, 32},
      {"u32", Ctx.UnsignedIntTy, 32},
      {"i64", isRV64() ? Ctx.LongTy : Ctx.LongLongTy, 64},
      {"u64", isRV64() ? Ctx.UnsignedLongTy : Ctx.UnsignedLongLongTy, 64},
      {"i128", Ctx.getBitIntType(false, 128), 128},
      {"u128", Ctx.getBitIntType(true, 128), 128},
      {"f16", Ctx.Float16Ty, 16},
      {"bf16", Ctx.BFloat16Ty, 16},
      {"f32", Ctx.FloatTy, 32},
      {"f64", Ctx.DoubleTy, 64},
  };
  const char *IntegerModes[] = {"", "_rne", "_rdn", "_rod"};
  const char *FloatModes[] = {"", "_rtz", "_rdn", "_rup", "_rmm", "_rno"};
  unsigned Checked = 0, Aliases = 0;
  for (const auto &Format : Formats) {
    bool Floating = Format.Value->isFloatingType();
    ArrayRef<const char *> Modes =
        Floating ? ArrayRef(FloatModes) : ArrayRef(IntegerModes);
    for (unsigned Sat = 0; Sat < (Floating ? 1u : 2u); ++Sat) {
      for (unsigned Mode = 0; Mode < Modes.size(); ++Mode) {
        std::string Prefix = "__riscv_ztt_" + std::string(Format.Name);
        std::string Tail = std::string(Sat ? "_sat" : "") + "_scalar_t";
        std::string Name = Prefix + Modes[Mode] + Tail;
        SCOPED_TRACE(Name);
        auto It = Types.find(Name);
        ASSERT_NE(It, Types.end());
        QualType Ty = It->second;
        auto Info =
            Ctx.getBuiltinRISCVZttScalarTypeInfo(Ty->castAs<BuiltinType>());
        EXPECT_EQ(Format.Value, Info.ValueType);
        EXPECT_EQ(Format.Bits, Info.ElementBits);
        EXPECT_EQ(Mode | (Sat << 3), Info.DatatypeOptions);
        EXPECT_NE(Ty, Format.Value);
        EXPECT_TRUE(Ty->isRISCVZttScalarBuiltinType());
        EXPECT_TRUE(Ty->isScalarType());
        EXPECT_FALSE(Ty->isArithmeticType());
        EXPECT_FALSE(Ty->isIntegerType());
        EXPECT_FALSE(Ty->isRealFloatingType());
        EXPECT_FALSE(Ty->isSizelessType());
        EXPECT_FALSE(Ty->isRISCVZttBuiltinType());
        EXPECT_EQ(Floating ? Type::STK_Floating : Type::STK_Integral,
                  Ty->getScalarTypeKind());
        EXPECT_EQ(Ctx.getTypeSize(Format.Value), Ctx.getTypeSize(Ty));
        EXPECT_EQ(Ctx.getTypeAlign(Format.Value), Ctx.getTypeAlign(Ty));
        auto Decls =
            Ctx.getTranslationUnitDecl()->lookup(&Ctx.Idents.get(Name));
        ASSERT_TRUE(Decls.isSingleResult());
        const auto *TD = cast<TypedefDecl>(Decls.front());
        EXPECT_TRUE(TD->isImplicit());
        EXPECT_EQ(Ty, TD->getUnderlyingType());
        ++Checked;
        if (Mode == 0) {
          std::string Alias = Prefix + (Floating ? "_rne" : "_rnu") + Tail;
          auto AliasDecls =
              Ctx.getTranslationUnitDecl()->lookup(&Ctx.Idents.get(Alias));
          ASSERT_TRUE(AliasDecls.isSingleResult());
          EXPECT_EQ(Ty,
                    cast<TypedefDecl>(AliasDecls.front())->getUnderlyingType());
          ++Aliases;
        }
      }
    }
  }
  EXPECT_EQ(104u, Checked);
  EXPECT_EQ(24u, Aliases);
}

TEST_P(RISCVZttScalarTypeTest, ExactConversions) {
  ASTContext &Ctx = AST->getASTContext();
  SemaRISCV &S = AST->getSema().RISCV();
  auto Types = getScalarTypes(Ctx);
  for (QualType Ty : Types) {
    SCOPED_TRACE(Ty.getAsString());
    auto Info = Ctx.getBuiltinRISCVZttScalarTypeInfo(Ty->castAs<BuiltinType>());
    EXPECT_TRUE(S.isValidRISCVZttScalarConversion(Info.ValueType, Ty));
    EXPECT_TRUE(S.isValidRISCVZttScalarConversion(Ty, Info.ValueType));
    EXPECT_TRUE(S.isValidRISCVZttScalarConversion(Ty.withConst(), Ty));
    for (QualType Other : Types) {
      SCOPED_TRACE(Other.getAsString());
      EXPECT_EQ(Ty == Other, S.isValidRISCVZttScalarConversion(Ty, Other));
      QualType C =
          Ctx.getBuiltinRISCVZttScalarTypeInfo(Other->castAs<BuiltinType>())
              .ValueType;
      EXPECT_EQ(C == Info.ValueType, S.isValidRISCVZttScalarConversion(C, Ty));
      EXPECT_EQ(C == Info.ValueType, S.isValidRISCVZttScalarConversion(Ty, C));
    }
    EXPECT_FALSE(S.isValidRISCVZttScalarConversion(Ctx.BoolTy, Ty));
    EXPECT_FALSE(S.isValidRISCVZttScalarConversion(Ctx.CharTy, Ty));
    EXPECT_FALSE(S.isValidRISCVZttScalarConversion(Ctx.VoidPtrTy, Ty));
    EXPECT_FALSE(
        S.isValidRISCVZttScalarConversion(Ctx.RISCVZttInt32M1x1Ty, Ty));
  }
}

TEST_P(RISCVZttScalarTypeTest, ImportAndMangling) {
  auto ToAST = createAST();
  ASSERT_TRUE(ToAST);
  ASTContext &From = AST->getASTContext();
  ASTContext &To = ToAST->getASTContext();
  ASTImporter Importer(To, ToAST->getFileManager(), From, AST->getFileManager(),
                       false);
  auto Types = getScalarTypes(From);
  auto ToTypes = getScalarTypes(To);
  std::unique_ptr<MangleContext> Itanium(
      ItaniumMangleContext::create(From, From.getDiagnostics()));
  std::unique_ptr<MangleContext> Microsoft(
      MicrosoftMangleContext::create(From, From.getDiagnostics()));
  for (unsigned I = 0; I < Types.size(); ++I) {
    QualType Ty = Types[I];
    std::string Name = Ty.getAsString();
    SCOPED_TRACE(Name);
    auto Imported = Importer.Import(Ty);
    ASSERT_TRUE(static_cast<bool>(Imported));
    EXPECT_EQ(ToTypes[I], *Imported);
    std::string ItaniumName, MicrosoftName;
    llvm::raw_string_ostream ItaniumOS(ItaniumName), MicrosoftOS(MicrosoftName);
    Itanium->mangleCXXRTTIName(Ty, ItaniumOS);
    Microsoft->mangleCXXRTTIName(Ty, MicrosoftOS);
    EXPECT_EQ("_ZTSu" + std::to_string(Name.size()) + Name, ItaniumName);
    EXPECT_EQ(".U" + Name + "@__clang@@", MicrosoftName);
  }
}

TEST_P(RISCVZttScalarTypeTest, RequiresFeature) {
  auto Without =
      tooling::buildASTFromCodeWithArgs("", {"-target", GetParam()}, "input.c");
  ASSERT_TRUE(Without);
  for (QualType Ty : getScalarTypes(Without->getASTContext()))
    EXPECT_TRUE(Ty.isNull());
}

INSTANTIATE_TEST_SUITE_P(RISCV, RISCVZttScalarTypeTest,
                         testing::Values("riscv32-unknown-linux-gnu",
                                         "riscv64-unknown-linux-gnu"));

} // namespace
