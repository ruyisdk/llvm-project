// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fno-spell-checking -fsyntax-only -verify=expected,ztt %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fno-spell-checking -fsyntax-only -verify=expected,ztt %s
// RUN: %clang_cc1 -triple riscv64 -fsyntax-only -verify=expected,noztt %s

#pragma clang riscv wrong ztt // expected-warning {{expected 'intrinsic'}}
#pragma clang riscv intrinsic wrong // ztt-warning {{expected 'vector', 'sifive_vector', 'andes_vector' or 'ztt'}} noztt-warning {{expected 'vector', 'sifive_vector' or 'andes_vector'}}
#pragma clang riscv intrinsic ztt extra // expected-warning {{extra tokens at end of '#pragma clang riscv intrinsic'}}

#ifdef __riscv_ztt
void before(void) {
  __riscv_ztt_ame_release(); // ztt-error {{undeclared}}
}

#pragma clang riscv intrinsic ztt
#pragma clang riscv intrinsic ztt

void after(void) {
  __riscv_ztt_ame_release();
}

#include <riscv_ztt.h>
#include <riscv_ztt.h>

size_t header_types(size_t n) {
  return __riscv_ztt_ame_acquire(n);
}
#endif
