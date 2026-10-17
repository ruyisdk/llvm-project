// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Public M interfaces at the legal UDS boundaries. These are instruction
// availability checks; common invalid layouts live in register-layout.c.
#define TEST_M(TYPE) \
  __riscv_ztt_##TYPE##_t m_##TYPE(void) { \
    return __riscv_ztt_mzero_m_##TYPE(); \
  }
#if UDS == 8
TEST_M(i16_1x1)
TEST_M(i32_8x1)
#elif UDS == 16
TEST_M(i16_1x1)
TEST_M(i32_1x16)
#elif UDS == 32
TEST_M(i16_1x2)
TEST_M(i32_32x1)
#elif UDS == 64
TEST_M(i16_4x1)
TEST_M(i32_32x1)
#elif UDS == 128
TEST_M(i128_1x1)
TEST_M(i128_32x1)
#endif

// Verify that the public header exposes every supported Acc-zero datatype and
// square count.  Acc legality is independent of whether an element would form
// a packed, standard, or wide M square for this UDS.
#define TEST_ACC_ZERO(TYPE)                                                  \
  __riscv_ztt_##TYPE##_accx1_t TYPE##_x1(void) {                             \
    return __riscv_ztt_mzero_acc_##TYPE##_accx1();                           \
  }                                                                          \
  __riscv_ztt_##TYPE##_accx2_t TYPE##_x2(void) {                             \
    return __riscv_ztt_mzero_acc_##TYPE##_accx2();                           \
  }                                                                          \
  __riscv_ztt_##TYPE##_accx4_t TYPE##_x4(void) {                             \
    return __riscv_ztt_mzero_acc_##TYPE##_accx4();                           \
  }                                                                          \
  __riscv_ztt_##TYPE##_accx8_t TYPE##_x8(void) {                             \
    return __riscv_ztt_mzero_acc_##TYPE##_accx8();                           \
  }

TEST_ACC_ZERO(i4)
TEST_ACC_ZERO(u4)
TEST_ACC_ZERO(i8)
TEST_ACC_ZERO(u8)
TEST_ACC_ZERO(i16)
TEST_ACC_ZERO(u16)
TEST_ACC_ZERO(i32)
TEST_ACC_ZERO(u32)
TEST_ACC_ZERO(i64)
TEST_ACC_ZERO(u64)
TEST_ACC_ZERO(i128)
TEST_ACC_ZERO(u128)
TEST_ACC_ZERO(f16)
TEST_ACC_ZERO(bf16)
TEST_ACC_ZERO(f32)
TEST_ACC_ZERO(f64)

// Use a layout legal for every UDS so only argument count is invalid.
void argument_count(void) {
  __riscv_ztt_mzero_m_i32_1x4(0); // expected-error {{too many arguments}}
  __riscv_ztt_mzero_acc_i32_accx1(0); // expected-error {{too many arguments}}
}
