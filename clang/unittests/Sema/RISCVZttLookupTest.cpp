//===- RISCVZttLookupTest.cpp - RISC-V Ztt lookup tests ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/AST/ASTContext.h"
#include "clang/AST/Attr.h"
#include "clang/Basic/RISCVZttBuiltins.h"
#include "clang/Basic/TargetBuiltins.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/Sema/Lookup.h"
#include "clang/Sema/Sema.h"
#include "clang/Sema/SemaConsumer.h"
#include "clang/Sema/SemaRISCV.h"
#include "clang/Tooling/Tooling.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/STLFunctionalExtras.h"
#include "llvm/ADT/StringSet.h"
#include "gtest/gtest.h"

using namespace clang;
using namespace clang::RISCV;

namespace {

// Run lookup while the parser still has a translation-unit scope, for C and
// C++.
class LookupConsumer : public SemaConsumer {
  Sema *S = nullptr;
  llvm::function_ref<void(Sema &)> Check;

public:
  explicit LookupConsumer(llvm::function_ref<void(Sema &)> Check)
      : Check(Check) {}
  void InitializeSema(Sema &TheSema) override { S = &TheSema; }
  bool HandleTopLevelDecl(DeclGroupRef Decls) override {
    if (Decls.isSingleDecl())
      if (const auto *D = dyn_cast<VarDecl>(Decls.getSingleDecl()))
        if (D->getName() == "run_lookup_tests")
          Check(*S);
    return true;
  }
};

class LookupAction : public ASTFrontendAction {
  llvm::function_ref<void(Sema &)> Check;

public:
  explicit LookupAction(llvm::function_ref<void(Sema &)> Check)
      : Check(Check) {}
  std::unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &,
                                                 StringRef) override {
    return std::make_unique<LookupConsumer>(Check);
  }
};

class RISCVZttLookupTest : public testing::TestWithParam<const char *> {
protected:
  void withSema(llvm::function_ref<void(Sema &)> Check) {
    for (const char *FileName : {"input.c", "input.cpp"}) {
      SCOPED_TRACE(FileName);
      bool Ran = false;
      auto Run = [&](Sema &S) {
        Ran = true;
        ASSERT_NE(nullptr, S.TUScope);
        Check(S);
        EXPECT_FALSE(S.getDiagnostics().hasErrorOccurred());
      };
      EXPECT_TRUE(tooling::runToolOnCodeWithArgs(
          std::make_unique<LookupAction>(Run),
          "typedef __riscv_ztt_i16_1x2_t __riscv_ztt_custom_t;"
          "int run_lookup_tests;",
          {"-target", GetParam(),
           StringRef(GetParam()).starts_with("riscv64") ? "-march=rv64gc_ztt"
                                                        : "-march=rv32gc_ztt",
           "-mztt-profile=clang-runtime-u32-m16-a4"},
          FileName));
      EXPECT_TRUE(Ran);
    }
  }

  static FunctionDecl *lookup(Sema &S, StringRef Name) {
    auto &II = S.getASTContext().Idents.get(Name);
    LookupResult R(S, &II, SourceLocation(), Sema::LookupOrdinaryName);
    if (!S.LookupName(R, S.TUScope, /*AllowBuiltinCreation=*/true))
      return nullptr;
    return R.getAsSingle<FunctionDecl>();
  }

  static QualType matrixType(ASTContext &Ctx, StringRef Suffix) {
    auto &II = Ctx.Idents.get(("__riscv_ztt_" + Suffix + "_t").str());
    auto Decls = Ctx.getTranslationUnitDecl()->lookup(&II);
    if (!Decls.isSingleResult())
      return {};
    return cast<TypedefNameDecl>(Decls.front())->getUnderlyingType();
  }
};

TEST_P(RISCVZttLookupTest, RegistrationAndPrototypes) {
  withSema([&](Sema &S) {
    ASTContext &Ctx = S.getASTContext();
    auto Builtins = getRISCVZttBuiltins();
    ASSERT_EQ(133u, Builtins.size());
    llvm::DenseSet<unsigned> IDs;
    unsigned LastID = 0;
    for (const auto &Info : Builtins) {
      SCOPED_TRACE(Info.Name);
      EXPECT_TRUE(IDs.insert(Info.ID).second);
      EXPECT_GT(Info.ID, LastID);
      LastID = Info.ID;
      EXPECT_EQ(&Info, getRISCVZttBuiltinInfo(Info.ID));
      std::string Name = ("__builtin_riscv_ztt_" + Twine(Info.Name)).str();
      EXPECT_EQ(Info.ID, Ctx.Idents.get(Name).getBuiltinID());
      EXPECT_EQ(Name, Ctx.BuiltinInfo.getName(Info.ID));
      EXPECT_STREQ("ztt", Ctx.BuiltinInfo.getRequiredFeatures(Info.ID));
      EXPECT_TRUE(Ctx.BuiltinInfo.isNoThrow(Info.ID));
      EXPECT_FALSE(Ctx.BuiltinInfo.isConst(Info.ID));
      EXPECT_FALSE(Ctx.BuiltinInfo.isPure(Info.ID));

      StringRef Op = Info.Name;
      bool CSR = Op.starts_with("get_");
      bool Acquire = Op == "ame_acquire";
      bool Release = Op == "ame_release";
      EXPECT_EQ(!CSR && !Acquire && !Release,
                Ctx.BuiltinInfo.hasCustomTypechecking(Info.ID));
      ASTContext::GetBuiltinTypeError Error;
      QualType Ty = Ctx.GetBuiltinType(Info.ID, Error);
      ASSERT_EQ(ASTContext::GE_None, Error);
      ASSERT_FALSE(Ty.isNull());
      const auto *FT = Ty->castAs<FunctionType>();
      EXPECT_EQ(CSR || Acquire ? Ctx.getSizeType() : Ctx.VoidTy,
                FT->getReturnType());
      if (CSR || Acquire || Release) {
        const auto *Proto = Ty->getAs<FunctionProtoType>();
        ASSERT_NE(nullptr, Proto);
        EXPECT_FALSE(Proto->isVariadic());
        ASSERT_EQ(Acquire ? 1u : 0u, Proto->getNumParams());
        if (Acquire) {
          EXPECT_EQ(Ctx.getSizeType(), Proto->getParamType(0));
        }
      }
    }
    EXPECT_EQ(nullptr, getRISCVZttBuiltinInfo(0));
    EXPECT_EQ(nullptr, getRISCVZttBuiltinInfo(BI__builtin_riscv_orc_b_32));
    EXPECT_EQ(nullptr, getRISCVZttBuiltinInfo(LastTSBuiltin));
  });
}

TEST_P(RISCVZttLookupTest, BuiltinTableBoundaries) {
  withSema([&](Sema &S) {
    ASTContext &Ctx = S.getASTContext();
    auto Builtins = getRISCVZttBuiltins();
    ASSERT_EQ(unsigned(LastTSBuiltin - FirstRISCVZttBuiltin), Builtins.size());
    for (unsigned I = 0; I < Builtins.size(); ++I)
      EXPECT_EQ(FirstRISCVZttBuiltin + I, Builtins[I].ID);

    // Ordinary RISC-V builtins are outside the RISC-V Ztt table.
    for (unsigned ID = RISCVVector::FirstTSBuiltin; ID < FirstRISCVZttBuiltin;
         ++ID) {
      std::string Name = Ctx.BuiltinInfo.getName(ID);
      SCOPED_TRACE(Name);
      EXPECT_FALSE(StringRef(Name).starts_with("__builtin_riscv_ztt_"));
      EXPECT_EQ(ID, Ctx.Idents.get(Name).getBuiltinID());
      EXPECT_EQ(nullptr, getRISCVZttBuiltinInfo(ID));
    }
  });
}

TEST_P(RISCVZttLookupTest, ResultRules) {
  // Lists are independent of the generated metadata.
  const llvm::StringSet<> Integer = {
      "mand_ew",     "mand_ew_x", "mandnot_ew",  "mandnot_ew_x", "mcmpge_ew",
      "mcmpge_ew_x", "mcmplt_ew", "mcmplt_ew_x", "mcolid_ew",    "mor_ew",
      "mor_ew_x",    "mornot_ew", "mornot_ew_x", "mrowid_ew",    "msll_ew",
      "msll_ew_x",   "msra_ew",   "msra_ew_x",   "msrl_ew",      "msrl_ew_x",
      "mxor_ew",     "mxor_ew_x"};
  const llvm::StringSet<> Float = {
      "mcos_ew",       "mexp2_ew",    "mfrintm_ew",    "mfrintn_ew",
      "mfrintp_ew",    "mfrintz_ew",  "mlog2_ew",      "mlog2sub_ew",
      "mlog2sub_ew_x", "mrec_ew",     "mrsqrt_ew",     "msin_ew",
      "msqrt_ew",      "msublog2_ew", "msublog2_ew_x", "mtanh_ew"};
  const llvm::StringSet<> ACC = {
      "mclear_acc",      "mzero_acc",     "mcopy_m2a",
      "mmulacc_2d",      "mmulaccneg_2d", "mmulatacc_2d",
      "mmulataccneg_2d", "mmulbtacc_2d",  "mmulbtaccneg_2d"};
  const llvm::StringSet<> NonMatrix = {
      "ame_acquire", "ame_release",   "get_amefflags", "get_amenlen",
      "get_ameown",  "get_amestatus", "get_amestype",  "get_ameudsz",
      "get_amexsat", "mss_rm",        "mss_cm",        "mss_st",
      "mss_tst"};
  const llvm::StringSet<> Zip = {"mrowzip_ew", "mcolzip_ew", "mrowunzip_ew",
                                 "mcolunzip_ew"};
  const llvm::StringSet<> SingleSquare = {
      "mrowbcast_ew_x", "mcolbcast_ew_x", "mrowgather_ew", "mcolgather_ew",
      "mrowid_ew", "mcolid_ew", "mrowscatadd_ew", "mcolscatadd_ew",
      "mrowscatmax_ew", "mcolscatmax_ew", "mrowshift_ew_x", "mcolshift_ew_x"};
  withSema([&](Sema &S) {
    S.RISCV().DeclareRISCVZttBuiltins = true;
    for (const auto &Info : getRISCVZttBuiltins()) {
      StringRef Name = Info.Name;
      SCOPED_TRACE(Name);
      auto ExpectedKind = NonMatrix.contains(Name)
                              ? RISCVZttResultKind::NonMatrix
                          : ACC.contains(Name) ? RISCVZttResultKind::ACC
                                               : RISCVZttResultKind::M;
      auto ExpectedType =
          Integer.contains(Name) ? RISCVZttResultTypeKind::Integer
          : Float.contains(Name) ? RISCVZttResultTypeKind::Float
                                 : RISCVZttResultTypeKind::Numeric;
      EXPECT_EQ(ExpectedKind, Info.ResultKind);
      EXPECT_EQ(ExpectedType, Info.ResultTypeKind);
      unsigned MaxSquares = SingleSquare.contains(Name)                 ? 1
                            : Zip.contains(Name)                       ? 2
                            : Name == "mextract"                       ? 16
                            : ACC.contains(Name) || Name == "mcopy_a2m" ? 8
                                                                        : 32;
      EXPECT_EQ(MaxSquares, Info.MaxResultSquares);
      EXPECT_EQ(Zip.contains(Name) || Name == "mconcat_m" ? 2u : 1u,
                Info.MinResultSquares);

      std::string Prefix = ("__riscv_ztt_" + Name).str();
      for (const char *Element : {"i32", "f32"}) {
        StringRef Shape = ACC.contains(Name)            ? "_accx2"
                          : SingleSquare.contains(Name) ? "_1x1"
                                                        : "_1x2";
        std::string Suffix = (Twine(Element) + Shape).str();
        bool Expected = !NonMatrix.contains(Name) &&
                        (StringRef(Element) == "i32" ? !Float.contains(Name)
                                                     : !Integer.contains(Name));
        auto *FD = lookup(S, Prefix + "_" + Suffix);
        ASSERT_EQ(Expected, FD != nullptr);
        if (FD) {
          EXPECT_EQ(matrixType(S.getASTContext(), Suffix), FD->getReturnType());
        }
      }
      if (SingleSquare.contains(Name)) {
        EXPECT_EQ(nullptr, lookup(S, Prefix + "_i32_1x2"));
        EXPECT_EQ(nullptr, lookup(S, Prefix + "_i32_2x1"));
      }
      EXPECT_EQ(NonMatrix.contains(Name), lookup(S, Prefix) != nullptr);
    }
  });
}

TEST_P(RISCVZttLookupTest, LazyDeclarations) {
  withSema([&](Sema &S) {
    ASTContext &Ctx = S.getASTContext();
    EXPECT_FALSE(S.RISCV().DeclareRISCVZttBuiltins);
    EXPECT_EQ(nullptr, lookup(S, "__riscv_ztt_madd_ew_i32_1x2"));
    EXPECT_EQ(nullptr, lookup(S, "__riscv_ztt_ame_acquire"));
    S.RISCV().DeclareRISCVZttBuiltins = true;

    for (StringRef Suffix :
         {"i4_1x1", "u128_32x1", "i16_rne_sat_1x2", "i16_rnu_sat_1x2",
          "f32_rne_2x1", "bf16_rno_1x32"}) {
      SCOPED_TRACE(Suffix);
      auto *FD = lookup(S, ("__riscv_ztt_madd_ew_" + Suffix).str());
      ASSERT_NE(nullptr, FD);
      EXPECT_TRUE(FD->isImplicit());
      EXPECT_EQ(BI__builtin_riscv_ztt_madd_ew, FD->getBuiltinID());
      EXPECT_EQ(matrixType(Ctx, Suffix), FD->getReturnType());
      auto *Alias = FD->getAttr<BuiltinAliasAttr>();
      ASSERT_NE(nullptr, Alias);
      EXPECT_EQ("__builtin_riscv_ztt_madd_ew",
                Alias->getBuiltinName()->getName());
    }

    // Signed-source and scalar-width restrictions do not restrict the result.
    for (const char *Name :
         {"__riscv_ztt_msra_ew_u32_1x2", "__riscv_ztt_msra_ew_x_u32_1x2",
          "__riscv_ztt_madd_ew_x_i4_1x8", "__riscv_ztt_mbcast_m_x_u4_8x1"}) {
      SCOPED_TRACE(Name);
      EXPECT_NE(nullptr, lookup(S, Name));
    }

    // Rounding and saturation do not change the integer/float result rules.
    EXPECT_NE(nullptr, lookup(S, "__riscv_ztt_mand_ew_i32_rne_sat_1x1"));
    EXPECT_EQ(nullptr, lookup(S, "__riscv_ztt_mand_ew_f32_rtz_1x1"));
    EXPECT_NE(nullptr, lookup(S, "__riscv_ztt_msqrt_ew_f32_rtz_1x1"));
    EXPECT_EQ(nullptr, lookup(S, "__riscv_ztt_msqrt_ew_i32_rne_sat_1x1"));

    auto *Default = lookup(S, "__riscv_ztt_madd_ew_i16_1x2");
    auto *Alias = lookup(S, "__riscv_ztt_madd_ew_i16_rnu_1x2");
    ASSERT_NE(nullptr, Default);
    ASSERT_NE(nullptr, Alias);
    EXPECT_EQ(Default->getType(), Alias->getType());

    for (const char *Name :
         {"__riscv_ztt_unknown_i32_1x1", "__riscv_ztt_madd_ew_custom",
          "__riscv_ztt_madd_ew_i16_scalar", "__riscv_ztt_madd_ew_i16_3x1",
          "__riscv_ztt_madd_ew_i16_2x2", "__riscv_ztt_madd_ew_i16_accx2",
          "__riscv_ztt_mmulacc_2d_i16_1x2", "__riscv_ztt_mss_rm_i32_1x1",
          "__riscv_ztt_ame_acquire_i32_1x1",
          "__riscv_ztt_mclear_acc_i16_accx3",
          "__riscv_ztt_madd_ew_i16_rtz_1x2",
          "__riscv_ztt_madd_ew_f32_rnu_1x2",
          "__riscv_ztt_madd_ew_f32_sat_1x2",
          "__riscv_ztt_madd_ew_i16_sat_rne_1x2"}) {
      SCOPED_TRACE(Name);
      EXPECT_EQ(nullptr, lookup(S, Name));
    }
  });
}

TEST_P(RISCVZttLookupTest, ResultShapeBoundaries) {
  withSema([&](Sema &S) {
    S.RISCV().DeclareRISCVZttBuiltins = true;
    struct {
      const char *Operation;
      const char *Accepted;
      const char *Rejected;
    } Cases[] = {
        {"mls_rm", "i8_1x4", "i4_1x8"},
        {"mls_cm", "u8_4x1", "u4_8x1"},
        {"mls_st", "i8_1x4", "i4_1x8"},
        {"mls_tst", "u8_4x1", "u4_8x1"},
        {"mconcat_m", "i16_1x2", "i16_1x1"},
        {"mconcat_m", "i16_2x1", "i16_1x1"},
        {"mconcat_m", "i16_32x1", "i16_64x1"},
        {"mcopy_a2m", "i16_1x8", "i16_1x16"},
        {"mcopy_a2m", "i16_8x1", "i16_16x1"},
        {"mcopy_m2a", "i16_accx8", "i16_accx16"},
        {"mextract", "i16_1x1", "i16_1x32"},
        {"mextract", "i16_1x16", "i16_1x32"},
        {"mextract", "i16_16x1", "i16_32x1"},
        {"mrowzip_ew", "i16_1x2", "i16_1x1"},
        {"mcolzip_ew", "i16_1x2", "i16_1x4"},
        {"mrowunzip_ew", "i16_1x2", "i16_1x1"},
        {"mcolunzip_ew", "i16_1x2", "i16_1x4"},
        {"mrowzip_ew", "i16_1x2", "i16_2x1"},
        {"mcolzip_ew", "i16_1x2", "i16_2x1"},
        {"mrowunzip_ew", "i16_1x2", "i16_2x1"},
        {"mcolunzip_ew", "i16_1x2", "i16_2x1"},
    };
    for (const auto &C : Cases) {
      SCOPED_TRACE(C.Operation);
      std::string Prefix = ("__riscv_ztt_" + Twine(C.Operation) + "_").str();
      EXPECT_NE(nullptr, lookup(S, Prefix + C.Accepted));
      EXPECT_EQ(nullptr, lookup(S, Prefix + C.Rejected));
    }
  });
}

INSTANTIATE_TEST_SUITE_P(RISCV, RISCVZttLookupTest,
                         testing::Values("riscv32-unknown-linux-gnu",
                                         "riscv64-unknown-linux-gnu"));

} // namespace
