// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -fsyntax-only -verify=m16,a4,smallacc %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a8 -fsyntax-only -verify=m16,smallacc %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a16 -fsyntax-only -verify=m16 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a4 -fsyntax-only -verify=a4,smallacc %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a8 -fsyntax-only -verify=smallacc %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify=full %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -fsyntax-only -verify=m16,a4,smallacc %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a8 -fsyntax-only -verify=m16,smallacc %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a16 -fsyntax-only -verify=m16 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a4 -fsyntax-only -verify=a4,smallacc %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a8 -fsyntax-only -verify=smallacc %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify=full %s
// full-no-diagnostics
#include <riscv_ztt.h>

// Capacity is a shared builtin check. Cover M and ACC inputs/results without
// repeating this profile matrix for each instruction. At UDS16, i32_1x16
// occupies 32 M registers, while i16_1x16 occupies 16.
void capacity(__riscv_ztt_i16_accx8_t acc) {
  (void)__riscv_ztt_mclear_m_i16_1x16();
  (void)__riscv_ztt_mclear_m_i16_1x32(); // m16-error {{requires 32 M registers, exceeding the configured limit of 16}}
  (void)__riscv_ztt_mclear_acc_i16_accx4();
  (void)__riscv_ztt_mclear_acc_i16_accx8(); // a4-error {{requires 8 ACC registers, exceeding the configured limit of 4}}
  (void)__riscv_ztt_mcopy_a2m_i16_1x8(acc); // a4-error {{requires 8 ACC registers, exceeding the configured limit of 4}}
}

void acc16_capacity(__riscv_ztt_i16_accx16_t acc) {
  (void)__riscv_ztt_mclear_acc_i16_accx16(); // smallacc-error {{requires 16 ACC registers, exceeding the configured limit of}}
  (void)__riscv_ztt_mcopy_a2m_i16_1x16(acc); // smallacc-error {{requires 16 ACC registers, exceeding the configured limit of}}
}

void m_operand_capacity(__riscv_ztt_i32_1x16_t large,
                        __riscv_ztt_i16_1x16_t small,
                        __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_madd_ew_x_i16_1x16(large, scalar); // m16-error {{requires 32 M registers, exceeding the configured limit of 16}}
  __riscv_ztt_madd_ew_x_i32_1x16(small, scalar); // m16-error {{requires 32 M registers, exceeding the configured limit of 16}}
}
