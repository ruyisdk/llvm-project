// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-a4 -fsyntax-only %s 2>&1 | FileCheck %s --check-prefix=M
// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16 -fsyntax-only %s 2>&1 | FileCheck %s --check-prefix=A
// M: invalid Ztt profile 'clang-runtime-u16-a4'
// A: invalid Ztt profile 'clang-runtime-u16-m16'
// An incomplete profile is rejected before individual builtin calls are parsed.
#include <riscv_ztt.h>
void missing_config(void) {
  (void)__riscv_ztt_mclear_m_i16_1x1();
  (void)__riscv_ztt_get_ameown();
  (void)__riscv_ztt_ame_acquire(0);
  __riscv_ztt_ame_release();
}
