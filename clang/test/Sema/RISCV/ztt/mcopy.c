// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -fsyntax-only -verify %s

// Matrix operands use the same target checks in C and C++, not ellipsis rules.
// RUN: %clang_cc1 -triple riscv32 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Isolate register category, direction and square count from datatype identity.
// All M layouts below are legal at UDS=32.
void m2m_type_mismatch(__riscv_ztt_i32_accx2_t acc,
                       __riscv_ztt_i32_2x1_t column,
                       __riscv_ztt_i32_1x4_t larger) {
  (void)__riscv_ztt_mcopy_m2m_i32_1x2(acc); // expected-error {{does not match destination type}}
  (void)__riscv_ztt_mcopy_m2m_i32_1x2(column); // expected-error {{does not match destination type}}
  (void)__riscv_ztt_mcopy_m2m_i32_1x2(larger); // expected-error {{does not match destination type}}
}

// Keep layouts valid so copy-specific diagnostics cannot be hidden by the
// common half-register check (covered in register-layout.c).
void test(__riscv_ztt_i16_1x2_t m2,
          __riscv_ztt_i32_1x2_t m32_2, __riscv_ztt_i16_accx1_t a1,
          __riscv_ztt_i16_accx2_t a2, __riscv_ztt_i32_accx2_t a32_2,
          __riscv_ztt_u16_1x2_t um2, __riscv_ztt_bf16_accx2_t ba2) {
  __riscv_ztt_mcopy_m2a_i16_accx1(a1); // expected-error {{Ztt M-to-Acc copy requires a M source type}}
  __riscv_ztt_mcopy_a2m_i16_1x2(m2);   // expected-error {{Ztt Acc-to-M copy requires a Acc source type}}
  __riscv_ztt_mcopy_m2a_i16_accx1(m2); // expected-error {{element type and square count must be identical}}
  __riscv_ztt_mcopy_a2m_i16_1x2(a1);   // expected-error {{element type and square count must be identical}}
  __riscv_ztt_mcopy_m2a_i16_accx2(m32_2); // expected-error {{element type and square count must be identical}}
  __riscv_ztt_mcopy_a2m_i16_1x2(a32_2);   // expected-error {{element type and square count must be identical}}
  __riscv_ztt_mcopy_m2a_i16_accx2(um2); // expected-error {{element type and square count must be identical}}
  __riscv_ztt_mcopy_a2m_f16_1x2(ba2); // expected-error {{element type and square count must be identical}}
  __riscv_ztt_mcopy_m2a_i16_accx1(); // expected-error {{too few arguments to function call}}
  __riscv_ztt_mcopy_a2m_i16_1x2(a2, a2); // expected-error {{too many arguments to function call}}
}

void valid_packed_and_concatenated(__riscv_ztt_i16_1x2_t packed,
                                 __riscv_ztt_i32_1x2_t concatenated,
                                 __riscv_ztt_i32_accx2_t acc) {
  (void)__riscv_ztt_mcopy_m2m_i16_1x2(packed);
  (void)__riscv_ztt_mcopy_m2a_i32_accx2(concatenated);
  (void)__riscv_ztt_mcopy_a2m_i32_2x1(acc);
}
