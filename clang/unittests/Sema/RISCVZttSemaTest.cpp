//===- RISCVZttSemaTest.cpp - RISC-V Ztt intrinsic checks --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "clang/Frontend/FrontendAction.h"
#include "clang/Sema/Sema.h"
#include "clang/Sema/SemaConsumer.h"
#include "clang/Sema/SemaRISCV.h"
#include "clang/Tooling/Tooling.h"
#include "gtest/gtest.h"

using namespace clang;

namespace {

// Enable public intrinsic lookup directly for these Sema tests.
class RISCVZttSemaConsumer : public SemaConsumer {
public:
  void InitializeSema(Sema &S) override {
    S.RISCV().DeclareRISCVZttBuiltins = true;
  }
};

class RISCVZttSemaAction : public ASTFrontendAction {
public:
  std::unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &,
                                               StringRef) override {
    return std::make_unique<RISCVZttSemaConsumer>();
  }
};

class RISCVZttSemaTest : public testing::TestWithParam<const char *> {
protected:
  void check(StringRef Code) {
    for (const char *FileName : {"input.c", "input.cpp"}) {
      SCOPED_TRACE(FileName);
      EXPECT_TRUE(tooling::runToolOnCodeWithArgs(
          std::make_unique<RISCVZttSemaAction>(), Code,
          {"-target", GetParam(),
           StringRef(GetParam()).starts_with("riscv64") ? "-march=rv64gc_ztt"
                                                       : "-march=rv32gc_ztt",
           "-mztt-profile=clang-runtime-u32-m16-a4", "-Xclang", "-verify"},
          FileName));
    }
  }
};

TEST_P(RISCVZttSemaTest, PublicCalls) {
  check(R"(
    // expected-no-diagnostics
    __riscv_ztt_i32_1x1_t compute(int *p) {
      __riscv_ztt_i32_scalar_t s = (int)3;
      __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
      __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(p);
      __riscv_ztt_i32_1x1_t c = __riscv_ztt_madd_ew_i32_1x1(a, b);
      (void)__riscv_ztt_mand_ew_i32_1x1(a, b);
      (void)__riscv_ztt_mand_ew_x_i32_1x1(a, s);
      __riscv_ztt_i32_1x1_t d = __riscv_ztt_madd_ew_x_i32_1x1(c, s);
      __riscv_ztt_i32_1x2_t e = __riscv_ztt_mconcat_m_i32_1x2(d, d);
      __riscv_ztt_i32_1x1_t f = __riscv_ztt_mextract_i32_1x1(e, 1);
      __riscv_ztt_i32_accx2_t acc = __riscv_ztt_mclear_acc_i32_accx2();
      __riscv_ztt_i32_accx2_t result =
          __riscv_ztt_mmulacc_2d_i32_accx2(acc, f, b);
      __riscv_ztt_i32_1x2_t stored = __riscv_ztt_mcopy_a2m_i32_1x2(result);
      __riscv_ztt_mss_rm(p, stored);
      return f;
    }
    void controls(__riscv_ztt_i32_1x1_t a) {
      (void)__riscv_ztt_msll_ew_x_i32_1x1(a, 0x100000001ULL);
      (void)__riscv_ztt_mrowshift_ew_x_i32_1x1(a, 0x100000001ULL);
      (void)__riscv_ztt_mldexp_ew_x_i32_1x1(a, 0x100000001ULL);
      (void)__riscv_ztt_ame_acquire(0x100000001ULL);
      (void)__riscv_ztt_get_amenlen();
      __riscv_ztt_ame_release();
    }
  )");
}

TEST_P(RISCVZttSemaTest, PublicOperandErrors) {
  check(R"(
    void check(__riscv_ztt_i32_1x1_t a, __riscv_ztt_i32_1x2_t row,
               __riscv_ztt_i32_accx1_t acc, __riscv_ztt_f32_1x1_t f,
               __riscv_ztt_f32_scalar_t scalar) {
      (void)__riscv_ztt_madd_ew_i32_1x1(a); // expected-error {{too few arguments}}
      (void)__riscv_ztt_madd_ew_i32_1x1(a, row); // expected-error {{madd.ew operands violate}}
      (void)__riscv_ztt_madd_ew_i32_1x1(acc, a); // expected-error {{requires an M matrix type}}
      (void)__riscv_ztt_mand_ew_i32_1x1(f, a); // expected-error {{mand.ew operands violate}}
      (void)__riscv_ztt_mand_ew_i32_1x1(a, f); // expected-error {{mand.ew operands violate}}
      (void)__riscv_ztt_mand_ew_x_i32_1x1(f, scalar); // expected-error {{mand.ew.x operands violate}}
      (void)__riscv_ztt_mand_ew_x_i32_1x1(a, scalar); // expected-error {{mand.ew.x operands violate}}
      (void)__riscv_ztt_mmulacc_2d_i32_accx2(acc, a, a); // expected-error {{requires an identical accumulator type}}
      (void)__riscv_ztt_mextract_i32_1x1(row, 2); // expected-error {{mextract operands violate}}
      (void)__riscv_ztt_mzero_m_i16_1x1(); // expected-error {{occupies only 16 bits}}
      (void)__riscv_ztt_ame_acquire(1.0f); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
    }
    // The __riscv_ztt_ prefix alone does not make a user function a builtin.
    int __riscv_ztt_user_function(int);
    int ordinary(void) { return __riscv_ztt_user_function(1); }
  )");
}

INSTANTIATE_TEST_SUITE_P(RISCV, RISCVZttSemaTest,
                        testing::Values("riscv32-unknown-linux-gnu",
                                        "riscv64-unknown-linux-gnu"));

} // namespace
