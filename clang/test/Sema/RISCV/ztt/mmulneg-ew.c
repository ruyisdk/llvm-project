// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Every available numeric type and M shape, at every UDS where it is legal.
// This is a front-end type test, not a promise of a matrix argument ABI.
#define TEST(T, S) \
  __riscv_ztt_##T##_##S##_t valid_##T##_##S( \
      __riscv_ztt_##T##_##S##_t a, __riscv_ztt_##T##_##S##_t b) { \
    return __riscv_ztt_mmulneg_ew_##T##_##S(a, b); \
  }

#if UDS <= 4 && 4 <= 32 * UDS
TEST(i4, 1x1)
#endif

#if UDS <= 8 && 8 <= 32 * UDS
TEST(i4, 1x2)
TEST(i4, 2x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(i4, 1x4)
TEST(i4, 4x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(i4, 1x8)
TEST(i4, 8x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(i4, 1x16)
TEST(i4, 16x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(i4, 1x32)
TEST(i4, 32x1)
#endif

#if UDS <= 4 && 4 <= 32 * UDS
TEST(u4, 1x1)
#endif

#if UDS <= 8 && 8 <= 32 * UDS
TEST(u4, 1x2)
TEST(u4, 2x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(u4, 1x4)
TEST(u4, 4x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(u4, 1x8)
TEST(u4, 8x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(u4, 1x16)
TEST(u4, 16x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(u4, 1x32)
TEST(u4, 32x1)
#endif

#if UDS <= 8 && 8 <= 32 * UDS
TEST(i8, 1x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(i8, 1x2)
TEST(i8, 2x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(i8, 1x4)
TEST(i8, 4x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(i8, 1x8)
TEST(i8, 8x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(i8, 1x16)
TEST(i8, 16x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(i8, 1x32)
TEST(i8, 32x1)
#endif

#if UDS <= 8 && 8 <= 32 * UDS
TEST(u8, 1x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(u8, 1x2)
TEST(u8, 2x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(u8, 1x4)
TEST(u8, 4x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(u8, 1x8)
TEST(u8, 8x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(u8, 1x16)
TEST(u8, 16x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(u8, 1x32)
TEST(u8, 32x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(i16, 1x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(i16, 1x2)
TEST(i16, 2x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(i16, 1x4)
TEST(i16, 4x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(i16, 1x8)
TEST(i16, 8x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(i16, 1x16)
TEST(i16, 16x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(i16, 1x32)
TEST(i16, 32x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(u16, 1x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(u16, 1x2)
TEST(u16, 2x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(u16, 1x4)
TEST(u16, 4x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(u16, 1x8)
TEST(u16, 8x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(u16, 1x16)
TEST(u16, 16x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(u16, 1x32)
TEST(u16, 32x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(i32, 1x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(i32, 1x2)
TEST(i32, 2x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(i32, 1x4)
TEST(i32, 4x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(i32, 1x8)
TEST(i32, 8x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(i32, 1x16)
TEST(i32, 16x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(i32, 1x32)
TEST(i32, 32x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(u32, 1x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(u32, 1x2)
TEST(u32, 2x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(u32, 1x4)
TEST(u32, 4x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(u32, 1x8)
TEST(u32, 8x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(u32, 1x16)
TEST(u32, 16x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(u32, 1x32)
TEST(u32, 32x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(i64, 1x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(i64, 1x2)
TEST(i64, 2x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(i64, 1x4)
TEST(i64, 4x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(i64, 1x8)
TEST(i64, 8x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(i64, 1x16)
TEST(i64, 16x1)
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
TEST(i64, 1x32)
TEST(i64, 32x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(u64, 1x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(u64, 1x2)
TEST(u64, 2x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(u64, 1x4)
TEST(u64, 4x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(u64, 1x8)
TEST(u64, 8x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(u64, 1x16)
TEST(u64, 16x1)
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
TEST(u64, 1x32)
TEST(u64, 32x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(i128, 1x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(i128, 1x2)
TEST(i128, 2x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(i128, 1x4)
TEST(i128, 4x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(i128, 1x8)
TEST(i128, 8x1)
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
TEST(i128, 1x16)
TEST(i128, 16x1)
#endif

#if UDS <= 4096 && 4096 <= 32 * UDS
TEST(i128, 1x32)
TEST(i128, 32x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(u128, 1x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(u128, 1x2)
TEST(u128, 2x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(u128, 1x4)
TEST(u128, 4x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(u128, 1x8)
TEST(u128, 8x1)
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
TEST(u128, 1x16)
TEST(u128, 16x1)
#endif

#if UDS <= 4096 && 4096 <= 32 * UDS
TEST(u128, 1x32)
TEST(u128, 32x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(f16, 1x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(f16, 1x2)
TEST(f16, 2x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(f16, 1x4)
TEST(f16, 4x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(f16, 1x8)
TEST(f16, 8x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(f16, 1x16)
TEST(f16, 16x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(f16, 1x32)
TEST(f16, 32x1)
#endif

#if UDS <= 16 && 16 <= 32 * UDS
TEST(bf16, 1x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(bf16, 1x2)
TEST(bf16, 2x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(bf16, 1x4)
TEST(bf16, 4x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(bf16, 1x8)
TEST(bf16, 8x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(bf16, 1x16)
TEST(bf16, 16x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(bf16, 1x32)
TEST(bf16, 32x1)
#endif

#if UDS <= 32 && 32 <= 32 * UDS
TEST(f32, 1x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(f32, 1x2)
TEST(f32, 2x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(f32, 1x4)
TEST(f32, 4x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(f32, 1x8)
TEST(f32, 8x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(f32, 1x16)
TEST(f32, 16x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(f32, 1x32)
TEST(f32, 32x1)
#endif

#if UDS <= 64 && 64 <= 32 * UDS
TEST(f64, 1x1)
#endif

#if UDS <= 128 && 128 <= 32 * UDS
TEST(f64, 1x2)
TEST(f64, 2x1)
#endif

#if UDS <= 256 && 256 <= 32 * UDS
TEST(f64, 1x4)
TEST(f64, 4x1)
#endif

#if UDS <= 512 && 512 <= 32 * UDS
TEST(f64, 1x8)
TEST(f64, 8x1)
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
TEST(f64, 1x16)
TEST(f64, 16x1)
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
TEST(f64, 1x32)
TEST(f64, 32x1)
#endif

#if UDS == 32
// Both mixed tuples and integer/float crossings are accepted.
__riscv_ztt_bf16_1x2_t mixed(__riscv_ztt_f16_1x2_t a,
                            __riscv_ztt_u32_1x2_t b) {
  return __riscv_ztt_mmulneg_ew_bf16_1x2(a, b);
}
void invalid(__riscv_ztt_i32_1x2_t a, __riscv_ztt_i32_2x1_t b,
             __riscv_ztt_i32_1x1_t c, __riscv_ztt_i32_accx2_t acc,
             int scalar, void *ptr) {
  __riscv_ztt_mmulneg_ew_i32_1x2(a, b); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulneg_ew_i32_1x2(c, a); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulneg_ew_i32_2x1(a, a); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulneg_ew_i32_1x2(acc, a); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mmulneg_ew_i32_1x2(a, acc); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mmulneg_ew_i32_1x2(scalar, a); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mmulneg_ew_i32_1x2(a, ptr); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mmulneg_ew_i32_1x2(a); // expected-error {{too few arguments}}
  __riscv_ztt_mmulneg_ew_i32_1x2(a, a, a); // expected-error {{too many arguments}}
}
#else
// expected-no-diagnostics
#endif
