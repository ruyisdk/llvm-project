// RUN: %clang_cc1 %s -triple=riscv64 -target-feature +xtheadv -fsyntax-only -verify

void test(void) {
  __builtin_rvv_xvsetvl(1, 7, 0); // expected-error {{argument value 7 is outside the valid range [0, 3]}}
  __builtin_rvv_xvsetvlmax(-1, 0); // expected-error {{argument value 18446744073709551615 is outside the valid range [0, 3]}}
  __builtin_rvv_xvsetvl(1, 0, 4); // expected-error {{LMUL argument must be in the range [0,3]}}
  __builtin_rvv_xvsetvlmax(0, 4); // expected-error {{LMUL argument must be in the range [0,3]}}
  __builtin_rvv_xvsetvl(1, 0, 8); // expected-error {{LMUL argument must be in the range [0,3]}}
  __builtin_rvv_xvsetvlmax(0, -1); // expected-error {{LMUL argument must be in the range [0,3]}}
}
