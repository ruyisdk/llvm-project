// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a16 -DSMALL_PROFILE -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a16 -DSMALL_PROFILE -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Layout checks are independent of the opcode: cover results, both operand
// positions, a void consumer and M input to an ACC-producing operation.
void half_register(short *p, __riscv_ztt_i16_1x1_t half,
                   __riscv_ztt_i32_1x1_t full) {
  __riscv_ztt_mclear_m_i16_1x1(); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
  __riscv_ztt_madd_ew_i32_1x1(half, full); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
  __riscv_ztt_madd_ew_i32_1x1(full, half); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
  __riscv_ztt_mss_rm(p, half); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
  __riscv_ztt_mcopy_m2a_i16_accx1(half); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
}

// Architectural overflow is distinct from a valid group exceeding M16.
// The configured M16/M32 and ACC4/8/16 boundaries are in register-counts.c.
void architectural_limit(__INT64_TYPE__ *p, __riscv_ztt_i64_32x1_t huge) {
  __riscv_ztt_mclear_m_i64_32x1(); // expected-error {{requires 64 M registers, exceeding the architectural limit of 32}}
  __riscv_ztt_mss_cm(p, huge); // expected-error {{requires 64 M registers, exceeding the architectural limit of 32}}
}

void legal_boundaries(void) {
  __riscv_ztt_mclear_m_i32_1x1();
#ifndef SMALL_PROFILE
  __riscv_ztt_mclear_m_i32_32x1();
#endif
  __riscv_ztt_mclear_m_i16_1x2(); // Packed, but a complete M register.
  __riscv_ztt_mclear_m_i64_1x1(); // Wide: two M registers.
  __riscv_ztt_mclear_acc_i16_accx1(); // ACC is never a half M register.
  __riscv_ztt_mclear_acc_i16_accx8();
}
