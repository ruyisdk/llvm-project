//===- SemaRISCVZttLookup.cpp - RISC-V Ztt builtin lookup --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/AST/ASTContext.h"
#include "clang/AST/Attr.h"
#include "clang/Basic/RISCVZttBuiltins.h"
#include "clang/Sema/Lookup.h"
#include "clang/Sema/Sema.h"
#include "clang/Sema/SemaRISCV.h"

bool clang::SemaRISCV::CreateRISCVZttIntrinsicIfFound(LookupResult &R,
                                                      IdentifierInfo *II) {
  StringRef Name = II->getName();
  if (!Name.consume_front("__riscv_ztt_"))
    return false;

  ASTContext &Context = getASTContext();
  auto &BuiltinII = Context.Idents.get(("__builtin_riscv_ztt_" + Name).str());
  unsigned ID = BuiltinII.getBuiltinID();
  QualType ResultTy;
  if (!ID) {
    // Match the operation first, then resolve its return-type suffix.
    for (const auto &Info : RISCV::getRISCVZttBuiltins()) {
      if (Info.ResultKind == RISCV::RISCVZttResultKind::NonMatrix)
        continue;
      StringRef Suffix = Name;
      if (!Suffix.consume_front(Info.Name) || !Suffix.consume_front("_"))
        continue;

      auto &TypeII = Context.Idents.get(("__riscv_ztt_" + Suffix + "_t").str());
      auto *TD = dyn_cast_or_null<TypedefNameDecl>(SemaRef.LookupSingleName(
          SemaRef.TUScope, &TypeII, R.getNameLoc(), Sema::LookupOrdinaryName));
      // User typedefs must not create additional intrinsic spellings.
      if (!TD || !TD->isImplicit())
        continue;
      QualType Ty = TD->getUnderlyingType();
      if (!Ty->isRISCVZttBuiltinType())
        continue;
      auto TypeInfo =
          Context.getBuiltinRISCVZttTypeInfo(Ty->castAs<BuiltinType>());
      if (!Info.acceptsResult(
              TypeInfo.isACCType(), TypeInfo.ElementType->isIntegerType(),
              TypeInfo.ElementBits, TypeInfo.NumRows, TypeInfo.NumColumns,
              TypeInfo.getLogicalSquareCount()))
        continue;
      ID = Info.ID;
      ResultTy = Ty;
      break;
    }
    if (!ID)
      return false;
  }

  ASTContext::GetBuiltinTypeError Error;
  QualType FnTy = Context.GetBuiltinType(ID, Error);
  if (Error != ASTContext::GE_None)
    return false;
  if (!ResultTy.isNull()) {
    if (const auto *Proto = FnTy->getAs<FunctionProtoType>())
      FnTy = Context.getFunctionType(ResultTy, Proto->getParamTypes(),
                                     Proto->getExtProtoInfo());
    else
      FnTy = Context.getFunctionNoProtoType(
          ResultTy, FnTy->castAs<FunctionType>()->getExtInfo());
  } else if (RISCV::getRISCVZttBuiltinInfo(ID)->ResultKind !=
             RISCV::RISCVZttResultKind::NonMatrix) {
    // Matrix-returning public names always need a return-type suffix.
    return false;
  }

  FunctionDecl *FD = SemaRef.CreateBuiltin(II, FnTy, ID, R.getNameLoc());
  IdentifierInfo &AliasII = Context.Idents.get(Context.BuiltinInfo.getName(ID));
  FD->addAttr(BuiltinAliasAttr::CreateImplicit(Context, &AliasII));
  R.addDecl(FD);
  return true;
}
