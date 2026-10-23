// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 \
// RUN: -fsyntax-only -verify %s

// Matrix operands use the same target checks in C and C++, not ellipsis rules.
// RUN: %clang_cc1 -triple riscv32 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

void bad_value(void *p, int value) {
  __riscv_ztt_mss_rm(p, value); // expected-error {{Ztt intrinsic requires an M matrix type (was 'int')}}
}

void bad_register_file(int *p, __riscv_ztt_i32_accx1_t acc) {
  __riscv_ztt_mss_rm(p, acc); // expected-error {{Ztt intrinsic requires an M matrix type}}
}

void bad_pointer(__riscv_ztt_i16_1x1_t value) {
  __riscv_ztt_mss_cm(1, value); // expected-error {{first argument to RISC-V Ztt memory intrinsic must be a pointer (was 'int')}}
}

void too_few(void *p) {
  __riscv_ztt_mss_rm(p); // expected-error {{too few arguments to function call, expected 2, have 1}}
}

void too_many(void *p, __riscv_ztt_i16_1x1_t value) {
  __riscv_ztt_mss_cm(p, value, 0); // expected-error {{too many arguments to function call, expected 2, have 3}}
}

void qualifiers(short *p, const short *cp, volatile short *vp,
                unsigned short *up, const __riscv_ztt_i16_1x1_t value) {
  __riscv_ztt_mss_rm(p, value);
  short array[16];
  __riscv_ztt_mss_cm(array, value);
  __riscv_ztt_mss_rm(cp, value); // expected-error {{the store destination must be writable and non-volatile}}
  __riscv_ztt_mss_cm(vp, value); // expected-error {{the store destination must be writable and non-volatile}}
  __riscv_ztt_mss_rm(up, value); // expected-error {{does not match matrix element type 'short'}}
}
