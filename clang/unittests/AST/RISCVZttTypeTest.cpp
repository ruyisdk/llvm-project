//===- RISCVZttTypeTest.cpp - RISC-V Ztt builtin type tests ---------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/AST/ASTContext.h"
#include "clang/AST/ASTImporter.h"
#include "clang/AST/ASTStructuralEquivalence.h"
#include "clang/AST/Mangle.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Lex/HeaderSearchOptions.h"
#include "clang/Tooling/Tooling.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/ToolOutputFile.h"
#include "gtest/gtest.h"
#include <algorithm>
#include <string>
#include <utility>

using namespace clang;

namespace {

static SmallVector<QualType, 240>
getRISCVZttTypes(ASTContext &Ctx, bool IncludeOptions = false) {
  SmallVector<QualType, 240> Types;
  // Keep base-type tests separate from rounding/sat variants.
#define RISCV_ZTT_M_TYPE(Name, Id, SingletonId, Kind, Bits, Rows, Cols, Options) \
  if (IncludeOptions || Options == 0)                                        \
    Types.push_back(Ctx.SingletonId);
#define RISCV_ZTT_ACC_TYPE(Name, Id, SingletonId, Kind, Bits, Squares, Options) \
  if (IncludeOptions || Options == 0)                                        \
    Types.push_back(Ctx.SingletonId);
#include "clang/Basic/RISCVZttTypes.def"
  return Types;
}

class RISCVZttTypeTest : public testing::TestWithParam<const char *> {
protected:
  std::unique_ptr<ASTUnit> AST;

  bool isRV64() const { return StringRef(GetParam()).starts_with("riscv64"); }

  std::unique_ptr<ASTUnit> createAST(StringRef FileName = "input.c") {
    return tooling::buildASTFromCodeWithArgs(
        "",
        {"-target", GetParam(),
         isRV64() ? "-march=rv64gc_ztt" : "-march=rv32gc_ztt",
         "-mztt-profile=clang-runtime-u32-m16-a4"},
        FileName);
  }

  void SetUp() override {
    AST = createAST();
    ASSERT_TRUE(AST);
    ASSERT_FALSE(AST->getDiagnostics().hasErrorOccurred());
  }
};

TEST_P(RISCVZttTypeTest, BaseTypes) {
  ASTContext &Ctx = AST->getASTContext();
  llvm::StringMap<QualType> Types;
  llvm::DenseSet<const Type *> Identities;
  for (QualType Ty : getRISCVZttTypes(Ctx)) {
    ASSERT_FALSE(Ty.isNull());
    EXPECT_TRUE(Ty.isCanonical());
    EXPECT_TRUE(isa<BuiltinType>(Ty));
    EXPECT_TRUE(Identities.insert(Ty.getTypePtr()).second);
    EXPECT_TRUE(Types.try_emplace(Ty.getAsString(), Ty).second);
  }
  ASSERT_EQ(240u, Types.size());

  // Expected types and shapes are independent of RISCVZttTypes.def.
  struct {
    const char *Name;
    QualType Element;
    unsigned Bits;
  } Elements[] = {
      {"i4", Ctx.getBitIntType(false, 4), 4},
      {"u4", Ctx.getBitIntType(true, 4), 4},
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
  const std::pair<unsigned, unsigned> Shapes[] = {
      {1, 1},  {1, 2}, {1, 4}, {1, 8},  {1, 16}, {1, 32},
      {2, 1},  {4, 1}, {8, 1}, {16, 1}, {32, 1},
  };
  for (const auto &Element : Elements) {
    for (auto [Rows, Cols] : Shapes) {
      std::string Name = "__riscv_ztt_" + std::string(Element.Name) + "_" +
                         std::to_string(Rows) + "x" + std::to_string(Cols) +
                         "_t";
      SCOPED_TRACE(Name);
      auto It = Types.find(Name);
      ASSERT_NE(It, Types.end());
      auto Info = Ctx.getBuiltinRISCVZttTypeInfo(It->second->castAs<BuiltinType>());
      EXPECT_EQ(Element.Element, Info.ElementType);
      EXPECT_EQ(Element.Bits, Info.ElementBits);
      EXPECT_EQ(Rows, Info.NumRows);
      EXPECT_EQ(Cols, Info.NumColumns);
      EXPECT_EQ(0u, Info.NumACCRegisters);
      EXPECT_EQ(Rows * Cols, Info.getLogicalSquareCount());
      EXPECT_TRUE(Info.isMType());
      EXPECT_FALSE(Info.isACCType());
    }
    for (unsigned Squares : {1u, 2u, 4u, 8u}) {
      std::string Name = "__riscv_ztt_" + std::string(Element.Name) + "_accx" +
                         std::to_string(Squares) + "_t";
      SCOPED_TRACE(Name);
      auto It = Types.find(Name);
      ASSERT_NE(It, Types.end());
      auto Info = Ctx.getBuiltinRISCVZttTypeInfo(It->second->castAs<BuiltinType>());
      EXPECT_EQ(Element.Element, Info.ElementType);
      EXPECT_EQ(Element.Bits, Info.ElementBits);
      EXPECT_EQ(1u, Info.NumRows);
      EXPECT_EQ(1u, Info.NumColumns);
      EXPECT_EQ(Squares, Info.NumACCRegisters);
      EXPECT_EQ(Squares, Info.getLogicalSquareCount());
      EXPECT_FALSE(Info.isMType());
      EXPECT_TRUE(Info.isACCType());
    }
  }
}

TEST_P(RISCVZttTypeTest, ClassificationAndLayout) {
  ASTContext &Ctx = AST->getASTContext();
  for (QualType Ty : getRISCVZttTypes(Ctx)) {
    SCOPED_TRACE(Ty.getAsString());
    EXPECT_TRUE(Ty->isRISCVZttBuiltinType());
    EXPECT_TRUE(Ty->isSizelessBuiltinType());
    EXPECT_TRUE(Ty->isSizelessType());
    EXPECT_FALSE(Ty->isSizelessVectorType());
    EXPECT_FALSE(Ty->isRVVSizelessBuiltinType());
    EXPECT_FALSE(Ty->isScalarType());
    EXPECT_FALSE(Ty->isIntegerType());
    EXPECT_FALSE(Ty->isFloatingType());
    EXPECT_FALSE(Ty->isPlaceholderType());
    EXPECT_FALSE(Ty->canHaveNullability());
    EXPECT_EQ(0u, Ctx.getTypeSize(Ty));
    auto Info = Ctx.getBuiltinRISCVZttTypeInfo(Ty->castAs<BuiltinType>());
    EXPECT_EQ(std::max(8u, Info.ElementBits), Ctx.getTypeAlign(Ty));
    EXPECT_FALSE(Ctx.getPointerType(Ty)->isSizelessType());
  }
  EXPECT_FALSE(Ctx.IntTy.getTypePtr()->isRISCVZttBuiltinType());
  EXPECT_FALSE(Ctx.getPointerType(Ctx.RISCVZttInt16M1x2Ty)
                   .getTypePtr()
                   ->isRISCVZttBuiltinType());
}

TEST_P(RISCVZttTypeTest, TypedefAndTraversal) {
  struct Visitor : RecursiveASTVisitor<Visitor> {
    SmallVector<const Type *, 2> Types;
    bool VisitType(Type *T) {
      Types.push_back(T);
      return true;
    }
  };

  ASTContext &Ctx = AST->getASTContext();
  for (QualType Ty : {Ctx.RISCVZttInt16M1x2Ty, Ctx.RISCVZttInt16ACC2Ty}) {
    TypeSourceInfo *TSI = Ctx.getTrivialTypeSourceInfo(Ty);
    auto *TD = TypedefDecl::Create(Ctx, Ctx.getTranslationUnitDecl(), {}, {},
                                   &Ctx.Idents.get("Alias"), TSI);
    QualType Alias =
        Ctx.getTypedefType(ElaboratedTypeKeyword::None, std::nullopt, TD);
    EXPECT_EQ(Ty, Alias.getCanonicalType());
    EXPECT_TRUE(Alias->isRISCVZttBuiltinType());
    EXPECT_TRUE(Alias->isSizelessType());

    Visitor V;
    EXPECT_TRUE(V.TraverseType(Ty));
    ASSERT_EQ(1u, V.Types.size());
    EXPECT_EQ(Ty.getTypePtr(), V.Types[0]);

    TypeLoc TL = TSI->getTypeLoc();
    ASSERT_FALSE(TL.getAs<BuiltinTypeLoc>().isNull());
    EXPECT_EQ(TST_unspecified, TL.getAs<BuiltinTypeLoc>().getWrittenTypeSpec());
    Visitor LV;
    EXPECT_TRUE(LV.TraverseTypeLoc(TL));
    ASSERT_EQ(1u, LV.Types.size());
    EXPECT_EQ(Ty.getTypePtr(), LV.Types[0]);
  }
}

TEST_P(RISCVZttTypeTest, ImportAndStructuralEquivalence) {
  auto ToAST = createAST();
  ASSERT_TRUE(ToAST);
  ASTContext &From = AST->getASTContext();
  ASTContext &To = ToAST->getASTContext();
  ASTImporter Importer(To, ToAST->getFileManager(), From, AST->getFileManager(),
                       false);
  StructuralEquivalenceContext::NonEquivalentDeclSet NonEquivalentDecls;
  StructuralEquivalenceContext Equivalence(From.getLangOpts(), From, To,
                                           NonEquivalentDecls,
                                           StructuralEquivalenceKind::Default);
  auto FromTypes = getRISCVZttTypes(From);
  auto ToTypes = getRISCVZttTypes(To);
  for (unsigned I = 0; I < FromTypes.size(); ++I) {
    auto Imported = Importer.Import(FromTypes[I]);
    ASSERT_TRUE(static_cast<bool>(Imported))
        << llvm::toString(Imported.takeError());
    EXPECT_EQ(ToTypes[I], *Imported);
    EXPECT_TRUE(Equivalence.IsEquivalent(FromTypes[I], *Imported));
  }
  // Reject differences in signedness, element type, direction, and ACC size.
  for (QualType Other :
       {To.RISCVZttUint16M1x2Ty, To.RISCVZttInt32M1x2Ty, To.RISCVZttFloat16M1x2Ty,
        To.RISCVZttInt16M2x1Ty, To.RISCVZttInt16M1x4Ty, To.RISCVZttInt16ACC2Ty})
    EXPECT_FALSE(Equivalence.IsEquivalent(From.RISCVZttInt16M1x2Ty, Other));
  EXPECT_FALSE(
      Equivalence.IsEquivalent(From.RISCVZttInt16ACC2Ty, To.RISCVZttInt16ACC4Ty));
  EXPECT_FALSE(
      Equivalence.IsEquivalent(From.RISCVZttFloat16M1x1Ty, To.RISCVZttBFloat16M1x1Ty));
}

TEST_P(RISCVZttTypeTest, Serialization) {
  // The saved AST refers to its source file, which must survive the reload.
  int InputFD;
  llvm::SmallString<128> InputName;
  ASSERT_FALSE(llvm::sys::fs::createTemporaryFile("riscv-ztt-types", "c", InputFD,
                                                 InputName));
  llvm::ToolOutputFile InputFile(InputName, InputFD);
  AST = createAST(InputName);
  ASSERT_TRUE(AST);
  ASTContext &Ctx = AST->getASTContext();
  auto Types = getRISCVZttTypes(Ctx);
  for (unsigned I = 0; I < Types.size(); ++I) {
    auto *TD =
        TypedefDecl::Create(Ctx, Ctx.getTranslationUnitDecl(), {}, {},
                            &Ctx.Idents.get("RISCVZttType" + std::to_string(I)),
                            Ctx.getTrivialTypeSourceInfo(Types[I]));
    Ctx.getTranslationUnitDecl()->addDecl(TD);
  }

  int FD;
  llvm::SmallString<128> FileName;
  ASSERT_FALSE(
      llvm::sys::fs::createTemporaryFile("riscv-ztt-types", "ast", FD, FileName));
  llvm::ToolOutputFile File(FileName, FD);
  ASSERT_FALSE(AST->Save(FileName));
  auto VFS = llvm::vfs::getRealFileSystem();
  auto DiagOpts = std::make_shared<DiagnosticOptions>();
  auto Diags = CompilerInstance::createDiagnostics(*VFS, *DiagOpts);
  PCHContainerOperations PCHContainerOps;
  auto Loaded = ASTUnit::LoadFromASTFile(
      FileName, PCHContainerOps.getRawReader(), ASTUnit::LoadEverything, VFS,
      DiagOpts, Diags, FileSystemOptions(), HeaderSearchOptions());
  ASSERT_TRUE(Loaded);
  ASSERT_FALSE(Diags->hasErrorOccurred());
  ASTContext &To = Loaded->getASTContext();
  auto ToTypes = getRISCVZttTypes(To);
  for (unsigned I = 0; I < Types.size(); ++I) {
    auto Decls = To.getTranslationUnitDecl()->lookup(
        &To.Idents.get("RISCVZttType" + std::to_string(I)));
    ASSERT_TRUE(Decls.isSingleResult());
    EXPECT_EQ(ToTypes[I],
              cast<TypedefDecl>(Decls.front())->getUnderlyingType());
    EXPECT_EQ(Types[I].getAsString(), ToTypes[I].getAsString());
  }
}

TEST_P(RISCVZttTypeTest, Mangling) {
  ASTContext &Ctx = AST->getASTContext();
  std::unique_ptr<MangleContext> Itanium(
      ItaniumMangleContext::create(Ctx, Ctx.getDiagnostics()));
  std::unique_ptr<MangleContext> Microsoft(
      MicrosoftMangleContext::create(Ctx, Ctx.getDiagnostics()));
  for (QualType Ty : {Ctx.RISCVZttInt16M1x2Ty, Ctx.RISCVZttFloat32ACC4Ty}) {
    std::string Name = Ty.getAsString();
    std::string ItaniumName, MicrosoftName;
    llvm::raw_string_ostream ItaniumOS(ItaniumName), MicrosoftOS(MicrosoftName);
    Itanium->mangleCXXRTTIName(Ty, ItaniumOS);
    Microsoft->mangleCXXRTTIName(Ty, MicrosoftOS);
    EXPECT_EQ("_ZTSu" + std::to_string(Name.size()) + Name, ItaniumName);
    EXPECT_EQ(".U" + Name + "@__clang@@", MicrosoftName);
  }
  EXPECT_FALSE(Ctx.getDiagnostics().hasErrorOccurred());
}

TEST_P(RISCVZttTypeTest, RequiresRISCVZttFeature) {
  auto WithoutRISCVZtt =
      tooling::buildASTFromCodeWithArgs("", {"-target", GetParam()}, "input.c");
  ASSERT_TRUE(WithoutRISCVZtt);
  for (QualType Ty : getRISCVZttTypes(WithoutRISCVZtt->getASTContext()))
    EXPECT_TRUE(Ty.isNull());
}

TEST_P(RISCVZttTypeTest, DatatypeOptions) {
  ASTContext &Ctx = AST->getASTContext();
  llvm::StringMap<QualType> Types;
  llvm::DenseSet<const Type *> Identities;
  for (QualType Ty : getRISCVZttTypes(Ctx, true)) {
    ASSERT_FALSE(Ty.isNull());
    EXPECT_TRUE(Ty.isCanonical());
    EXPECT_TRUE(Identities.insert(Ty.getTypePtr()).second);
    EXPECT_TRUE(Types.try_emplace(Ty.getAsString(), Ty).second);
  }
  ASSERT_EQ(1800u, Types.size());

  // Expected suffixes and their option values are independent of the table.
  const char *IntegerModes[] = {"rnu", "rne", "rdn", "rod"};
  const char *FloatModes[] = {"rne", "rtz", "rdn", "rup", "rmm", "rno"};
  unsigned NumTypes = 0;
  for (QualType Base : getRISCVZttTypes(Ctx)) {
    auto BaseInfo = Ctx.getBuiltinRISCVZttTypeInfo(Base->castAs<BuiltinType>());
    bool Floating = BaseInfo.ElementType->isFloatingType();
    std::string BaseName = Base.getAsString();
    size_t SuffixPos = BaseName.find('_', sizeof("__riscv_ztt_") - 1);
    for (unsigned Mode = 0; Mode != (Floating ? 6u : 4u); ++Mode) {
      for (unsigned Sat = 0; Sat != (Floating ? 1u : 2u); ++Sat) {
        std::string Suffix =
            Mode ? "_" + std::string(Floating ? FloatModes[Mode]
                                             : IntegerModes[Mode])
                 : "";
        if (Sat)
          Suffix += "_sat";
        std::string Name = BaseName;
        Name.insert(SuffixPos, Suffix);
        SCOPED_TRACE(Name);
        auto It = Types.find(Name);
        ASSERT_NE(It, Types.end());
        QualType Ty = It->second;
        auto Info = Ctx.getBuiltinRISCVZttTypeInfo(Ty->castAs<BuiltinType>());
        EXPECT_EQ(BaseInfo.ElementType, Info.ElementType);
        EXPECT_EQ(BaseInfo.ElementBits, Info.ElementBits);
        EXPECT_EQ(BaseInfo.NumRows, Info.NumRows);
        EXPECT_EQ(BaseInfo.NumColumns, Info.NumColumns);
        EXPECT_EQ(BaseInfo.NumACCRegisters, Info.NumACCRegisters);
        EXPECT_EQ(Mode + 8 * Sat, Info.DatatypeOptions);
        EXPECT_TRUE(Ty->isRISCVZttBuiltinType());
        EXPECT_TRUE(Ty->isSizelessBuiltinType());
        EXPECT_FALSE(Ty->isScalarType());
        EXPECT_EQ(0u, Ctx.getTypeSize(Ty));
        EXPECT_EQ(Ctx.getTypeAlign(Base), Ctx.getTypeAlign(Ty));
        ++NumTypes;
      }
    }
  }
  EXPECT_EQ(1800u, NumTypes);
}

TEST_P(RISCVZttTypeTest, OptionsImportAndEquivalence) {
  auto ToAST = createAST();
  ASSERT_TRUE(ToAST);
  ASTContext &From = AST->getASTContext();
  ASTContext &To = ToAST->getASTContext();
  ASTImporter Importer(To, ToAST->getFileManager(), From, AST->getFileManager(),
                       false);
  StructuralEquivalenceContext::NonEquivalentDeclSet NonEquivalentDecls;
  StructuralEquivalenceContext Equivalence(From.getLangOpts(), From, To,
                                          NonEquivalentDecls,
                                          StructuralEquivalenceKind::Default);
  auto FromTypes = getRISCVZttTypes(From, true);
  auto ToTypes = getRISCVZttTypes(To, true);
  for (unsigned I = 0; I < FromTypes.size(); ++I) {
    auto Imported = Importer.Import(FromTypes[I]);
    ASSERT_TRUE(static_cast<bool>(Imported))
        << llvm::toString(Imported.takeError());
    EXPECT_EQ(ToTypes[I], *Imported);
    EXPECT_TRUE(Equivalence.IsEquivalent(FromTypes[I], *Imported));
  }
  EXPECT_FALSE(Equivalence.IsEquivalent(From.RISCVZttInt16M1x2Ty,
                                        To.RISCVZttInt16RneM1x2Ty));
  EXPECT_FALSE(Equivalence.IsEquivalent(From.RISCVZttInt16RneM1x2Ty,
                                        To.RISCVZttInt16RneSatM1x2Ty));
  EXPECT_FALSE(Equivalence.IsEquivalent(From.RISCVZttFloat32ACC4Ty,
                                        To.RISCVZttFloat32RnoACC4Ty));
}

TEST_P(RISCVZttTypeTest, OptionsSerialization) {
  int InputFD;
  llvm::SmallString<128> InputName;
  ASSERT_FALSE(llvm::sys::fs::createTemporaryFile("riscv-ztt-options", "c",
                                                  InputFD, InputName));
  llvm::ToolOutputFile InputFile(InputName, InputFD);
  AST = createAST(InputName);
  ASSERT_TRUE(AST);
  ASTContext &Ctx = AST->getASTContext();
  auto Types = getRISCVZttTypes(Ctx, true);
  for (unsigned I = 0; I < Types.size(); ++I) {
    auto *TD = TypedefDecl::Create(
        Ctx, Ctx.getTranslationUnitDecl(), {}, {},
        &Ctx.Idents.get("RISCVZttOptions" + std::to_string(I)),
        Ctx.getTrivialTypeSourceInfo(Types[I]));
    Ctx.getTranslationUnitDecl()->addDecl(TD);
  }

  int FD;
  llvm::SmallString<128> FileName;
  ASSERT_FALSE(llvm::sys::fs::createTemporaryFile("riscv-ztt-options", "ast",
                                                  FD, FileName));
  llvm::ToolOutputFile File(FileName, FD);
  ASSERT_FALSE(AST->Save(FileName));
  auto VFS = llvm::vfs::getRealFileSystem();
  auto DiagOpts = std::make_shared<DiagnosticOptions>();
  auto Diags = CompilerInstance::createDiagnostics(*VFS, *DiagOpts);
  PCHContainerOperations PCHContainerOps;
  auto Loaded = ASTUnit::LoadFromASTFile(
      FileName, PCHContainerOps.getRawReader(), ASTUnit::LoadEverything, VFS,
      DiagOpts, Diags, FileSystemOptions(), HeaderSearchOptions());
  ASSERT_TRUE(Loaded);
  ASSERT_FALSE(Diags->hasErrorOccurred());
  ASTContext &To = Loaded->getASTContext();
  auto ToTypes = getRISCVZttTypes(To, true);
  for (unsigned I = 0; I < Types.size(); ++I) {
    auto Decls = To.getTranslationUnitDecl()->lookup(
        &To.Idents.get("RISCVZttOptions" + std::to_string(I)));
    ASSERT_TRUE(Decls.isSingleResult());
    QualType Ty = cast<TypedefDecl>(Decls.front())->getUnderlyingType();
    EXPECT_EQ(ToTypes[I], Ty);
    EXPECT_EQ(Types[I].getAsString(), Ty.getAsString());
    EXPECT_EQ(Ctx.getBuiltinRISCVZttTypeInfo(Types[I]->castAs<BuiltinType>())
                  .DatatypeOptions,
              To.getBuiltinRISCVZttTypeInfo(Ty->castAs<BuiltinType>())
                  .DatatypeOptions);
  }
}

TEST_P(RISCVZttTypeTest, OptionsMangling) {
  ASTContext &Ctx = AST->getASTContext();
  std::unique_ptr<MangleContext> Itanium(
      ItaniumMangleContext::create(Ctx, Ctx.getDiagnostics()));
  std::unique_ptr<MangleContext> Microsoft(
      MicrosoftMangleContext::create(Ctx, Ctx.getDiagnostics()));
  for (QualType Ty : {Ctx.RISCVZttInt16RneM1x2Ty, Ctx.RISCVZttInt16RneSatM1x2Ty,
                      Ctx.RISCVZttFloat32RnoACC4Ty}) {
    std::string Name = Ty.getAsString();
    std::string ItaniumName, MicrosoftName;
    llvm::raw_string_ostream ItaniumOS(ItaniumName), MicrosoftOS(MicrosoftName);
    Itanium->mangleCXXRTTIName(Ty, ItaniumOS);
    Microsoft->mangleCXXRTTIName(Ty, MicrosoftOS);
    EXPECT_EQ("_ZTSu" + std::to_string(Name.size()) + Name, ItaniumName);
    EXPECT_EQ(".U" + Name + "@__clang@@", MicrosoftName);
  }
  EXPECT_FALSE(Ctx.getDiagnostics().hasErrorOccurred());
}

INSTANTIATE_TEST_SUITE_P(RISCV, RISCVZttTypeTest,
                         testing::Values("riscv32-unknown-linux-gnu",
                                         "riscv64-unknown-linux-gnu"));

} // namespace
