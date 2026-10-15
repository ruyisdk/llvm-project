// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Layout and pointee compatibility have shared tests; these exercise the load
// signature itself with a legal result layout.
void argument_checks(void) {
  __riscv_ztt_mls_rm_i32_1x1(1); // expected-error {{first argument to RISC-V Ztt memory intrinsic must be a pointer}}
  __riscv_ztt_mls_cm_i32_1x1(); // expected-error {{too few arguments to function call}}
  __riscv_ztt_mls_rm_i32_1x1((int *)0, 1); // expected-error {{too many arguments to function call}}
}
