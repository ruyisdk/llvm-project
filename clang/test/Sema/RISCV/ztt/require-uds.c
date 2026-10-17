// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -fsyntax-only -verify %s
// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-u64-m32-a16 -fsyntax-only %s 2>&1 | FileCheck %s --check-prefix=MULTI
// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-m32-a16 -fsyntax-only %s 2>&1 | FileCheck %s --check-prefix=MISSING
// MULTI: invalid Ztt profile 'clang-runtime-u32-u64-m32-a16'
// MISSING: invalid Ztt profile 'clang-runtime-m32-a16'

#include <riscv_ztt.h>

// Configuration is checked before instruction-specific rules. Representatives
// cover M/ACC results, a void matrix consumer, and the scalar/void interfaces
// that previously bypassed UDS checking. Do not enumerate every instruction.
void require_uds(int *p, __riscv_ztt_i32_1x1_t m) {
  __riscv_ztt_mclear_m_i32_1x1(); // expected-error {{Ztt builtin requires a Ztt profile}}
  __riscv_ztt_mclear_acc_i32_accx1(); // expected-error {{Ztt builtin requires a Ztt profile}}
  __riscv_ztt_mss_rm(p, m); // expected-error {{Ztt builtin requires a Ztt profile}}
  __riscv_ztt_get_ameown(); // expected-error {{Ztt builtin requires a Ztt profile}}
  __riscv_ztt_ame_acquire(0); // expected-error {{Ztt builtin requires a Ztt profile}}
  __riscv_ztt_ame_release(); // expected-error {{Ztt builtin requires a Ztt profile}}
}
