// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
#include <riscv_ztt.h>
#if UDS == 8
void ok_i4_1x2(__riscv_ztt_i4_1x2_t s0) {
  __riscv_ztt_i4_1x2_t r = __riscv_ztt_mreducemax_row_i4_1x2(s0);
}
void ok_i4_2x1(__riscv_ztt_i4_2x1_t s0) {
  __riscv_ztt_i4_2x1_t r = __riscv_ztt_mreducemax_row_i4_2x1(s0);
}
void ok_i4_1x4(__riscv_ztt_i4_1x4_t s0) {
  __riscv_ztt_i4_1x4_t r = __riscv_ztt_mreducemax_row_i4_1x4(s0);
}
void ok_i4_4x1(__riscv_ztt_i4_4x1_t s0) {
  __riscv_ztt_i4_4x1_t r = __riscv_ztt_mreducemax_row_i4_4x1(s0);
}
void ok_u4_1x2(__riscv_ztt_u4_1x2_t s0) {
  __riscv_ztt_u4_1x2_t r = __riscv_ztt_mreducemax_row_u4_1x2(s0);
}
void ok_u4_2x1(__riscv_ztt_u4_2x1_t s0) {
  __riscv_ztt_u4_2x1_t r = __riscv_ztt_mreducemax_row_u4_2x1(s0);
}
void ok_u4_1x4(__riscv_ztt_u4_1x4_t s0) {
  __riscv_ztt_u4_1x4_t r = __riscv_ztt_mreducemax_row_u4_1x4(s0);
}
void ok_u4_4x1(__riscv_ztt_u4_4x1_t s0) {
  __riscv_ztt_u4_4x1_t r = __riscv_ztt_mreducemax_row_u4_4x1(s0);
}
void ok_i8_1x1(__riscv_ztt_i8_1x1_t s0) {
  __riscv_ztt_i8_1x1_t r = __riscv_ztt_mreducemax_row_i8_1x1(s0);
}
void ok_i8_1x2(__riscv_ztt_i8_1x2_t s0) {
  __riscv_ztt_i8_1x2_t r = __riscv_ztt_mreducemax_row_i8_1x2(s0);
}
void ok_i8_2x1(__riscv_ztt_i8_2x1_t s0) {
  __riscv_ztt_i8_2x1_t r = __riscv_ztt_mreducemax_row_i8_2x1(s0);
}
void ok_u8_1x1(__riscv_ztt_u8_1x1_t s0) {
  __riscv_ztt_u8_1x1_t r = __riscv_ztt_mreducemax_row_u8_1x1(s0);
}
void ok_u8_1x2(__riscv_ztt_u8_1x2_t s0) {
  __riscv_ztt_u8_1x2_t r = __riscv_ztt_mreducemax_row_u8_1x2(s0);
}
void ok_u8_2x1(__riscv_ztt_u8_2x1_t s0) {
  __riscv_ztt_u8_2x1_t r = __riscv_ztt_mreducemax_row_u8_2x1(s0);
}
void ok_i16_1x1(__riscv_ztt_i16_1x1_t s0) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mreducemax_row_i16_1x1(s0);
}
void ok_i16_1x2(__riscv_ztt_i16_1x2_t s0) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mreducemax_row_i16_1x2(s0);
}
void ok_i16_2x1(__riscv_ztt_i16_2x1_t s0) {
  __riscv_ztt_i16_2x1_t r = __riscv_ztt_mreducemax_row_i16_2x1(s0);
}
void ok_u16_1x1(__riscv_ztt_u16_1x1_t s0) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mreducemax_row_u16_1x1(s0);
}
void ok_u16_1x2(__riscv_ztt_u16_1x2_t s0) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mreducemax_row_u16_1x2(s0);
}
void ok_u16_2x1(__riscv_ztt_u16_2x1_t s0) {
  __riscv_ztt_u16_2x1_t r = __riscv_ztt_mreducemax_row_u16_2x1(s0);
}
void ok_i32_1x1(__riscv_ztt_i32_1x1_t s0) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mreducemax_row_i32_1x1(s0);
}
void ok_i32_1x2(__riscv_ztt_i32_1x2_t s0) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mreducemax_row_i32_1x2(s0);
}
void ok_i32_2x1(__riscv_ztt_i32_2x1_t s0) {
  __riscv_ztt_i32_2x1_t r = __riscv_ztt_mreducemax_row_i32_2x1(s0);
}
void ok_u32_1x1(__riscv_ztt_u32_1x1_t s0) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mreducemax_row_u32_1x1(s0);
}
void ok_u32_1x2(__riscv_ztt_u32_1x2_t s0) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mreducemax_row_u32_1x2(s0);
}
void ok_u32_2x1(__riscv_ztt_u32_2x1_t s0) {
  __riscv_ztt_u32_2x1_t r = __riscv_ztt_mreducemax_row_u32_2x1(s0);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mreducemax_row_i64_1x1(s0);
}
void ok_i64_1x2(__riscv_ztt_i64_1x2_t s0) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mreducemax_row_i64_1x2(s0);
}
void ok_i64_2x1(__riscv_ztt_i64_2x1_t s0) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mreducemax_row_i64_2x1(s0);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mreducemax_row_u64_1x1(s0);
}
void ok_u64_1x2(__riscv_ztt_u64_1x2_t s0) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mreducemax_row_u64_1x2(s0);
}
void ok_u64_2x1(__riscv_ztt_u64_2x1_t s0) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mreducemax_row_u64_2x1(s0);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mreducemax_row_i128_1x1(s0);
}
void ok_i128_1x2(__riscv_ztt_i128_1x2_t s0) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mreducemax_row_i128_1x2(s0);
}
void ok_i128_2x1(__riscv_ztt_i128_2x1_t s0) {
  __riscv_ztt_i128_2x1_t r = __riscv_ztt_mreducemax_row_i128_2x1(s0);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mreducemax_row_u128_1x1(s0);
}
void ok_u128_1x2(__riscv_ztt_u128_1x2_t s0) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mreducemax_row_u128_1x2(s0);
}
void ok_u128_2x1(__riscv_ztt_u128_2x1_t s0) {
  __riscv_ztt_u128_2x1_t r = __riscv_ztt_mreducemax_row_u128_2x1(s0);
}
void ok_f16_1x1(__riscv_ztt_f16_1x1_t s0) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mreducemax_row_f16_1x1(s0);
}
void ok_f16_1x2(__riscv_ztt_f16_1x2_t s0) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mreducemax_row_f16_1x2(s0);
}
void ok_f16_2x1(__riscv_ztt_f16_2x1_t s0) {
  __riscv_ztt_f16_2x1_t r = __riscv_ztt_mreducemax_row_f16_2x1(s0);
}
void ok_bf16_1x1(__riscv_ztt_bf16_1x1_t s0) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mreducemax_row_bf16_1x1(s0);
}
void ok_bf16_1x2(__riscv_ztt_bf16_1x2_t s0) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mreducemax_row_bf16_1x2(s0);
}
void ok_bf16_2x1(__riscv_ztt_bf16_2x1_t s0) {
  __riscv_ztt_bf16_2x1_t r = __riscv_ztt_mreducemax_row_bf16_2x1(s0);
}
void ok_f32_1x1(__riscv_ztt_f32_1x1_t s0) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mreducemax_row_f32_1x1(s0);
}
void ok_f32_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mreducemax_row_f32_1x2(s0);
}
void ok_f32_2x1(__riscv_ztt_f32_2x1_t s0) {
  __riscv_ztt_f32_2x1_t r = __riscv_ztt_mreducemax_row_f32_2x1(s0);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mreducemax_row_f64_1x1(s0);
}
void ok_f64_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mreducemax_row_f64_1x2(s0);
}
void ok_f64_2x1(__riscv_ztt_f64_2x1_t s0) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mreducemax_row_f64_2x1(s0);
}
#endif
#if UDS == 16
void ok_i4_1x4(__riscv_ztt_i4_1x4_t s0) {
  __riscv_ztt_i4_1x4_t r = __riscv_ztt_mreducemax_row_i4_1x4(s0);
}
void ok_i4_4x1(__riscv_ztt_i4_4x1_t s0) {
  __riscv_ztt_i4_4x1_t r = __riscv_ztt_mreducemax_row_i4_4x1(s0);
}
void ok_i4_1x8(__riscv_ztt_i4_1x8_t s0) {
  __riscv_ztt_i4_1x8_t r = __riscv_ztt_mreducemax_row_i4_1x8(s0);
}
void ok_i4_8x1(__riscv_ztt_i4_8x1_t s0) {
  __riscv_ztt_i4_8x1_t r = __riscv_ztt_mreducemax_row_i4_8x1(s0);
}
void ok_u4_1x4(__riscv_ztt_u4_1x4_t s0) {
  __riscv_ztt_u4_1x4_t r = __riscv_ztt_mreducemax_row_u4_1x4(s0);
}
void ok_u4_4x1(__riscv_ztt_u4_4x1_t s0) {
  __riscv_ztt_u4_4x1_t r = __riscv_ztt_mreducemax_row_u4_4x1(s0);
}
void ok_u4_1x8(__riscv_ztt_u4_1x8_t s0) {
  __riscv_ztt_u4_1x8_t r = __riscv_ztt_mreducemax_row_u4_1x8(s0);
}
void ok_u4_8x1(__riscv_ztt_u4_8x1_t s0) {
  __riscv_ztt_u4_8x1_t r = __riscv_ztt_mreducemax_row_u4_8x1(s0);
}
void ok_i8_1x2(__riscv_ztt_i8_1x2_t s0) {
  __riscv_ztt_i8_1x2_t r = __riscv_ztt_mreducemax_row_i8_1x2(s0);
}
void ok_i8_2x1(__riscv_ztt_i8_2x1_t s0) {
  __riscv_ztt_i8_2x1_t r = __riscv_ztt_mreducemax_row_i8_2x1(s0);
}
void ok_i8_1x4(__riscv_ztt_i8_1x4_t s0) {
  __riscv_ztt_i8_1x4_t r = __riscv_ztt_mreducemax_row_i8_1x4(s0);
}
void ok_i8_4x1(__riscv_ztt_i8_4x1_t s0) {
  __riscv_ztt_i8_4x1_t r = __riscv_ztt_mreducemax_row_i8_4x1(s0);
}
void ok_u8_1x2(__riscv_ztt_u8_1x2_t s0) {
  __riscv_ztt_u8_1x2_t r = __riscv_ztt_mreducemax_row_u8_1x2(s0);
}
void ok_u8_2x1(__riscv_ztt_u8_2x1_t s0) {
  __riscv_ztt_u8_2x1_t r = __riscv_ztt_mreducemax_row_u8_2x1(s0);
}
void ok_u8_1x4(__riscv_ztt_u8_1x4_t s0) {
  __riscv_ztt_u8_1x4_t r = __riscv_ztt_mreducemax_row_u8_1x4(s0);
}
void ok_u8_4x1(__riscv_ztt_u8_4x1_t s0) {
  __riscv_ztt_u8_4x1_t r = __riscv_ztt_mreducemax_row_u8_4x1(s0);
}
void ok_i16_1x1(__riscv_ztt_i16_1x1_t s0) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mreducemax_row_i16_1x1(s0);
}
void ok_i16_1x2(__riscv_ztt_i16_1x2_t s0) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mreducemax_row_i16_1x2(s0);
}
void ok_i16_2x1(__riscv_ztt_i16_2x1_t s0) {
  __riscv_ztt_i16_2x1_t r = __riscv_ztt_mreducemax_row_i16_2x1(s0);
}
void ok_u16_1x1(__riscv_ztt_u16_1x1_t s0) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mreducemax_row_u16_1x1(s0);
}
void ok_u16_1x2(__riscv_ztt_u16_1x2_t s0) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mreducemax_row_u16_1x2(s0);
}
void ok_u16_2x1(__riscv_ztt_u16_2x1_t s0) {
  __riscv_ztt_u16_2x1_t r = __riscv_ztt_mreducemax_row_u16_2x1(s0);
}
void ok_i32_1x1(__riscv_ztt_i32_1x1_t s0) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mreducemax_row_i32_1x1(s0);
}
void ok_i32_1x2(__riscv_ztt_i32_1x2_t s0) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mreducemax_row_i32_1x2(s0);
}
void ok_i32_2x1(__riscv_ztt_i32_2x1_t s0) {
  __riscv_ztt_i32_2x1_t r = __riscv_ztt_mreducemax_row_i32_2x1(s0);
}
void ok_u32_1x1(__riscv_ztt_u32_1x1_t s0) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mreducemax_row_u32_1x1(s0);
}
void ok_u32_1x2(__riscv_ztt_u32_1x2_t s0) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mreducemax_row_u32_1x2(s0);
}
void ok_u32_2x1(__riscv_ztt_u32_2x1_t s0) {
  __riscv_ztt_u32_2x1_t r = __riscv_ztt_mreducemax_row_u32_2x1(s0);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mreducemax_row_i64_1x1(s0);
}
void ok_i64_1x2(__riscv_ztt_i64_1x2_t s0) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mreducemax_row_i64_1x2(s0);
}
void ok_i64_2x1(__riscv_ztt_i64_2x1_t s0) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mreducemax_row_i64_2x1(s0);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mreducemax_row_u64_1x1(s0);
}
void ok_u64_1x2(__riscv_ztt_u64_1x2_t s0) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mreducemax_row_u64_1x2(s0);
}
void ok_u64_2x1(__riscv_ztt_u64_2x1_t s0) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mreducemax_row_u64_2x1(s0);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mreducemax_row_i128_1x1(s0);
}
void ok_i128_1x2(__riscv_ztt_i128_1x2_t s0) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mreducemax_row_i128_1x2(s0);
}
void ok_i128_2x1(__riscv_ztt_i128_2x1_t s0) {
  __riscv_ztt_i128_2x1_t r = __riscv_ztt_mreducemax_row_i128_2x1(s0);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mreducemax_row_u128_1x1(s0);
}
void ok_u128_1x2(__riscv_ztt_u128_1x2_t s0) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mreducemax_row_u128_1x2(s0);
}
void ok_u128_2x1(__riscv_ztt_u128_2x1_t s0) {
  __riscv_ztt_u128_2x1_t r = __riscv_ztt_mreducemax_row_u128_2x1(s0);
}
void ok_f16_1x1(__riscv_ztt_f16_1x1_t s0) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mreducemax_row_f16_1x1(s0);
}
void ok_f16_1x2(__riscv_ztt_f16_1x2_t s0) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mreducemax_row_f16_1x2(s0);
}
void ok_f16_2x1(__riscv_ztt_f16_2x1_t s0) {
  __riscv_ztt_f16_2x1_t r = __riscv_ztt_mreducemax_row_f16_2x1(s0);
}
void ok_bf16_1x1(__riscv_ztt_bf16_1x1_t s0) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mreducemax_row_bf16_1x1(s0);
}
void ok_bf16_1x2(__riscv_ztt_bf16_1x2_t s0) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mreducemax_row_bf16_1x2(s0);
}
void ok_bf16_2x1(__riscv_ztt_bf16_2x1_t s0) {
  __riscv_ztt_bf16_2x1_t r = __riscv_ztt_mreducemax_row_bf16_2x1(s0);
}
void ok_f32_1x1(__riscv_ztt_f32_1x1_t s0) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mreducemax_row_f32_1x1(s0);
}
void ok_f32_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mreducemax_row_f32_1x2(s0);
}
void ok_f32_2x1(__riscv_ztt_f32_2x1_t s0) {
  __riscv_ztt_f32_2x1_t r = __riscv_ztt_mreducemax_row_f32_2x1(s0);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mreducemax_row_f64_1x1(s0);
}
void ok_f64_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mreducemax_row_f64_1x2(s0);
}
void ok_f64_2x1(__riscv_ztt_f64_2x1_t s0) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mreducemax_row_f64_2x1(s0);
}
#endif
#if UDS == 32
void ok_i4_1x8(__riscv_ztt_i4_1x8_t s0) {
  __riscv_ztt_i4_1x8_t r = __riscv_ztt_mreducemax_row_i4_1x8(s0);
}
void ok_i4_8x1(__riscv_ztt_i4_8x1_t s0) {
  __riscv_ztt_i4_8x1_t r = __riscv_ztt_mreducemax_row_i4_8x1(s0);
}
void ok_i4_1x16(__riscv_ztt_i4_1x16_t s0) {
  __riscv_ztt_i4_1x16_t r = __riscv_ztt_mreducemax_row_i4_1x16(s0);
}
void ok_i4_16x1(__riscv_ztt_i4_16x1_t s0) {
  __riscv_ztt_i4_16x1_t r = __riscv_ztt_mreducemax_row_i4_16x1(s0);
}
void ok_u4_1x8(__riscv_ztt_u4_1x8_t s0) {
  __riscv_ztt_u4_1x8_t r = __riscv_ztt_mreducemax_row_u4_1x8(s0);
}
void ok_u4_8x1(__riscv_ztt_u4_8x1_t s0) {
  __riscv_ztt_u4_8x1_t r = __riscv_ztt_mreducemax_row_u4_8x1(s0);
}
void ok_u4_1x16(__riscv_ztt_u4_1x16_t s0) {
  __riscv_ztt_u4_1x16_t r = __riscv_ztt_mreducemax_row_u4_1x16(s0);
}
void ok_u4_16x1(__riscv_ztt_u4_16x1_t s0) {
  __riscv_ztt_u4_16x1_t r = __riscv_ztt_mreducemax_row_u4_16x1(s0);
}
void ok_i8_1x4(__riscv_ztt_i8_1x4_t s0) {
  __riscv_ztt_i8_1x4_t r = __riscv_ztt_mreducemax_row_i8_1x4(s0);
}
void ok_i8_4x1(__riscv_ztt_i8_4x1_t s0) {
  __riscv_ztt_i8_4x1_t r = __riscv_ztt_mreducemax_row_i8_4x1(s0);
}
void ok_i8_1x8(__riscv_ztt_i8_1x8_t s0) {
  __riscv_ztt_i8_1x8_t r = __riscv_ztt_mreducemax_row_i8_1x8(s0);
}
void ok_i8_8x1(__riscv_ztt_i8_8x1_t s0) {
  __riscv_ztt_i8_8x1_t r = __riscv_ztt_mreducemax_row_i8_8x1(s0);
}
void ok_u8_1x4(__riscv_ztt_u8_1x4_t s0) {
  __riscv_ztt_u8_1x4_t r = __riscv_ztt_mreducemax_row_u8_1x4(s0);
}
void ok_u8_4x1(__riscv_ztt_u8_4x1_t s0) {
  __riscv_ztt_u8_4x1_t r = __riscv_ztt_mreducemax_row_u8_4x1(s0);
}
void ok_u8_1x8(__riscv_ztt_u8_1x8_t s0) {
  __riscv_ztt_u8_1x8_t r = __riscv_ztt_mreducemax_row_u8_1x8(s0);
}
void ok_u8_8x1(__riscv_ztt_u8_8x1_t s0) {
  __riscv_ztt_u8_8x1_t r = __riscv_ztt_mreducemax_row_u8_8x1(s0);
}
void ok_i16_1x2(__riscv_ztt_i16_1x2_t s0) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mreducemax_row_i16_1x2(s0);
}
void ok_i16_2x1(__riscv_ztt_i16_2x1_t s0) {
  __riscv_ztt_i16_2x1_t r = __riscv_ztt_mreducemax_row_i16_2x1(s0);
}
void ok_i16_1x4(__riscv_ztt_i16_1x4_t s0) {
  __riscv_ztt_i16_1x4_t r = __riscv_ztt_mreducemax_row_i16_1x4(s0);
}
void ok_i16_4x1(__riscv_ztt_i16_4x1_t s0) {
  __riscv_ztt_i16_4x1_t r = __riscv_ztt_mreducemax_row_i16_4x1(s0);
}
void ok_u16_1x2(__riscv_ztt_u16_1x2_t s0) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mreducemax_row_u16_1x2(s0);
}
void ok_u16_2x1(__riscv_ztt_u16_2x1_t s0) {
  __riscv_ztt_u16_2x1_t r = __riscv_ztt_mreducemax_row_u16_2x1(s0);
}
void ok_u16_1x4(__riscv_ztt_u16_1x4_t s0) {
  __riscv_ztt_u16_1x4_t r = __riscv_ztt_mreducemax_row_u16_1x4(s0);
}
void ok_u16_4x1(__riscv_ztt_u16_4x1_t s0) {
  __riscv_ztt_u16_4x1_t r = __riscv_ztt_mreducemax_row_u16_4x1(s0);
}
void ok_i32_1x1(__riscv_ztt_i32_1x1_t s0) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mreducemax_row_i32_1x1(s0);
}
void ok_i32_1x2(__riscv_ztt_i32_1x2_t s0) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mreducemax_row_i32_1x2(s0);
}
void ok_i32_2x1(__riscv_ztt_i32_2x1_t s0) {
  __riscv_ztt_i32_2x1_t r = __riscv_ztt_mreducemax_row_i32_2x1(s0);
}
void ok_u32_1x1(__riscv_ztt_u32_1x1_t s0) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mreducemax_row_u32_1x1(s0);
}
void ok_u32_1x2(__riscv_ztt_u32_1x2_t s0) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mreducemax_row_u32_1x2(s0);
}
void ok_u32_2x1(__riscv_ztt_u32_2x1_t s0) {
  __riscv_ztt_u32_2x1_t r = __riscv_ztt_mreducemax_row_u32_2x1(s0);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mreducemax_row_i64_1x1(s0);
}
void ok_i64_1x2(__riscv_ztt_i64_1x2_t s0) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mreducemax_row_i64_1x2(s0);
}
void ok_i64_2x1(__riscv_ztt_i64_2x1_t s0) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mreducemax_row_i64_2x1(s0);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mreducemax_row_u64_1x1(s0);
}
void ok_u64_1x2(__riscv_ztt_u64_1x2_t s0) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mreducemax_row_u64_1x2(s0);
}
void ok_u64_2x1(__riscv_ztt_u64_2x1_t s0) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mreducemax_row_u64_2x1(s0);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mreducemax_row_i128_1x1(s0);
}
void ok_i128_1x2(__riscv_ztt_i128_1x2_t s0) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mreducemax_row_i128_1x2(s0);
}
void ok_i128_2x1(__riscv_ztt_i128_2x1_t s0) {
  __riscv_ztt_i128_2x1_t r = __riscv_ztt_mreducemax_row_i128_2x1(s0);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mreducemax_row_u128_1x1(s0);
}
void ok_u128_1x2(__riscv_ztt_u128_1x2_t s0) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mreducemax_row_u128_1x2(s0);
}
void ok_u128_2x1(__riscv_ztt_u128_2x1_t s0) {
  __riscv_ztt_u128_2x1_t r = __riscv_ztt_mreducemax_row_u128_2x1(s0);
}
void ok_f16_1x2(__riscv_ztt_f16_1x2_t s0) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mreducemax_row_f16_1x2(s0);
}
void ok_f16_2x1(__riscv_ztt_f16_2x1_t s0) {
  __riscv_ztt_f16_2x1_t r = __riscv_ztt_mreducemax_row_f16_2x1(s0);
}
void ok_f16_1x4(__riscv_ztt_f16_1x4_t s0) {
  __riscv_ztt_f16_1x4_t r = __riscv_ztt_mreducemax_row_f16_1x4(s0);
}
void ok_f16_4x1(__riscv_ztt_f16_4x1_t s0) {
  __riscv_ztt_f16_4x1_t r = __riscv_ztt_mreducemax_row_f16_4x1(s0);
}
void ok_bf16_1x2(__riscv_ztt_bf16_1x2_t s0) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mreducemax_row_bf16_1x2(s0);
}
void ok_bf16_2x1(__riscv_ztt_bf16_2x1_t s0) {
  __riscv_ztt_bf16_2x1_t r = __riscv_ztt_mreducemax_row_bf16_2x1(s0);
}
void ok_bf16_1x4(__riscv_ztt_bf16_1x4_t s0) {
  __riscv_ztt_bf16_1x4_t r = __riscv_ztt_mreducemax_row_bf16_1x4(s0);
}
void ok_bf16_4x1(__riscv_ztt_bf16_4x1_t s0) {
  __riscv_ztt_bf16_4x1_t r = __riscv_ztt_mreducemax_row_bf16_4x1(s0);
}
void ok_f32_1x1(__riscv_ztt_f32_1x1_t s0) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mreducemax_row_f32_1x1(s0);
}
void ok_f32_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mreducemax_row_f32_1x2(s0);
}
void ok_f32_2x1(__riscv_ztt_f32_2x1_t s0) {
  __riscv_ztt_f32_2x1_t r = __riscv_ztt_mreducemax_row_f32_2x1(s0);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mreducemax_row_f64_1x1(s0);
}
void ok_f64_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mreducemax_row_f64_1x2(s0);
}
void ok_f64_2x1(__riscv_ztt_f64_2x1_t s0) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mreducemax_row_f64_2x1(s0);
}
#endif
#if UDS == 64
void ok_i4_1x16(__riscv_ztt_i4_1x16_t s0) {
  __riscv_ztt_i4_1x16_t r = __riscv_ztt_mreducemax_row_i4_1x16(s0);
}
void ok_i4_16x1(__riscv_ztt_i4_16x1_t s0) {
  __riscv_ztt_i4_16x1_t r = __riscv_ztt_mreducemax_row_i4_16x1(s0);
}
void ok_i4_1x32(__riscv_ztt_i4_1x32_t s0) {
  __riscv_ztt_i4_1x32_t r = __riscv_ztt_mreducemax_row_i4_1x32(s0);
}
void ok_i4_32x1(__riscv_ztt_i4_32x1_t s0) {
  __riscv_ztt_i4_32x1_t r = __riscv_ztt_mreducemax_row_i4_32x1(s0);
}
void ok_u4_1x16(__riscv_ztt_u4_1x16_t s0) {
  __riscv_ztt_u4_1x16_t r = __riscv_ztt_mreducemax_row_u4_1x16(s0);
}
void ok_u4_16x1(__riscv_ztt_u4_16x1_t s0) {
  __riscv_ztt_u4_16x1_t r = __riscv_ztt_mreducemax_row_u4_16x1(s0);
}
void ok_u4_1x32(__riscv_ztt_u4_1x32_t s0) {
  __riscv_ztt_u4_1x32_t r = __riscv_ztt_mreducemax_row_u4_1x32(s0);
}
void ok_u4_32x1(__riscv_ztt_u4_32x1_t s0) {
  __riscv_ztt_u4_32x1_t r = __riscv_ztt_mreducemax_row_u4_32x1(s0);
}
void ok_i8_1x8(__riscv_ztt_i8_1x8_t s0) {
  __riscv_ztt_i8_1x8_t r = __riscv_ztt_mreducemax_row_i8_1x8(s0);
}
void ok_i8_8x1(__riscv_ztt_i8_8x1_t s0) {
  __riscv_ztt_i8_8x1_t r = __riscv_ztt_mreducemax_row_i8_8x1(s0);
}
void ok_i8_1x16(__riscv_ztt_i8_1x16_t s0) {
  __riscv_ztt_i8_1x16_t r = __riscv_ztt_mreducemax_row_i8_1x16(s0);
}
void ok_i8_16x1(__riscv_ztt_i8_16x1_t s0) {
  __riscv_ztt_i8_16x1_t r = __riscv_ztt_mreducemax_row_i8_16x1(s0);
}
void ok_u8_1x8(__riscv_ztt_u8_1x8_t s0) {
  __riscv_ztt_u8_1x8_t r = __riscv_ztt_mreducemax_row_u8_1x8(s0);
}
void ok_u8_8x1(__riscv_ztt_u8_8x1_t s0) {
  __riscv_ztt_u8_8x1_t r = __riscv_ztt_mreducemax_row_u8_8x1(s0);
}
void ok_u8_1x16(__riscv_ztt_u8_1x16_t s0) {
  __riscv_ztt_u8_1x16_t r = __riscv_ztt_mreducemax_row_u8_1x16(s0);
}
void ok_u8_16x1(__riscv_ztt_u8_16x1_t s0) {
  __riscv_ztt_u8_16x1_t r = __riscv_ztt_mreducemax_row_u8_16x1(s0);
}
void ok_i16_1x4(__riscv_ztt_i16_1x4_t s0) {
  __riscv_ztt_i16_1x4_t r = __riscv_ztt_mreducemax_row_i16_1x4(s0);
}
void ok_i16_4x1(__riscv_ztt_i16_4x1_t s0) {
  __riscv_ztt_i16_4x1_t r = __riscv_ztt_mreducemax_row_i16_4x1(s0);
}
void ok_i16_1x8(__riscv_ztt_i16_1x8_t s0) {
  __riscv_ztt_i16_1x8_t r = __riscv_ztt_mreducemax_row_i16_1x8(s0);
}
void ok_i16_8x1(__riscv_ztt_i16_8x1_t s0) {
  __riscv_ztt_i16_8x1_t r = __riscv_ztt_mreducemax_row_i16_8x1(s0);
}
void ok_u16_1x4(__riscv_ztt_u16_1x4_t s0) {
  __riscv_ztt_u16_1x4_t r = __riscv_ztt_mreducemax_row_u16_1x4(s0);
}
void ok_u16_4x1(__riscv_ztt_u16_4x1_t s0) {
  __riscv_ztt_u16_4x1_t r = __riscv_ztt_mreducemax_row_u16_4x1(s0);
}
void ok_u16_1x8(__riscv_ztt_u16_1x8_t s0) {
  __riscv_ztt_u16_1x8_t r = __riscv_ztt_mreducemax_row_u16_1x8(s0);
}
void ok_u16_8x1(__riscv_ztt_u16_8x1_t s0) {
  __riscv_ztt_u16_8x1_t r = __riscv_ztt_mreducemax_row_u16_8x1(s0);
}
void ok_i32_1x2(__riscv_ztt_i32_1x2_t s0) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mreducemax_row_i32_1x2(s0);
}
void ok_i32_2x1(__riscv_ztt_i32_2x1_t s0) {
  __riscv_ztt_i32_2x1_t r = __riscv_ztt_mreducemax_row_i32_2x1(s0);
}
void ok_i32_1x4(__riscv_ztt_i32_1x4_t s0) {
  __riscv_ztt_i32_1x4_t r = __riscv_ztt_mreducemax_row_i32_1x4(s0);
}
void ok_i32_4x1(__riscv_ztt_i32_4x1_t s0) {
  __riscv_ztt_i32_4x1_t r = __riscv_ztt_mreducemax_row_i32_4x1(s0);
}
void ok_u32_1x2(__riscv_ztt_u32_1x2_t s0) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mreducemax_row_u32_1x2(s0);
}
void ok_u32_2x1(__riscv_ztt_u32_2x1_t s0) {
  __riscv_ztt_u32_2x1_t r = __riscv_ztt_mreducemax_row_u32_2x1(s0);
}
void ok_u32_1x4(__riscv_ztt_u32_1x4_t s0) {
  __riscv_ztt_u32_1x4_t r = __riscv_ztt_mreducemax_row_u32_1x4(s0);
}
void ok_u32_4x1(__riscv_ztt_u32_4x1_t s0) {
  __riscv_ztt_u32_4x1_t r = __riscv_ztt_mreducemax_row_u32_4x1(s0);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mreducemax_row_i64_1x1(s0);
}
void ok_i64_1x2(__riscv_ztt_i64_1x2_t s0) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mreducemax_row_i64_1x2(s0);
}
void ok_i64_2x1(__riscv_ztt_i64_2x1_t s0) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mreducemax_row_i64_2x1(s0);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mreducemax_row_u64_1x1(s0);
}
void ok_u64_1x2(__riscv_ztt_u64_1x2_t s0) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mreducemax_row_u64_1x2(s0);
}
void ok_u64_2x1(__riscv_ztt_u64_2x1_t s0) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mreducemax_row_u64_2x1(s0);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mreducemax_row_i128_1x1(s0);
}
void ok_i128_1x2(__riscv_ztt_i128_1x2_t s0) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mreducemax_row_i128_1x2(s0);
}
void ok_i128_2x1(__riscv_ztt_i128_2x1_t s0) {
  __riscv_ztt_i128_2x1_t r = __riscv_ztt_mreducemax_row_i128_2x1(s0);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mreducemax_row_u128_1x1(s0);
}
void ok_u128_1x2(__riscv_ztt_u128_1x2_t s0) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mreducemax_row_u128_1x2(s0);
}
void ok_u128_2x1(__riscv_ztt_u128_2x1_t s0) {
  __riscv_ztt_u128_2x1_t r = __riscv_ztt_mreducemax_row_u128_2x1(s0);
}
void ok_f16_1x4(__riscv_ztt_f16_1x4_t s0) {
  __riscv_ztt_f16_1x4_t r = __riscv_ztt_mreducemax_row_f16_1x4(s0);
}
void ok_f16_4x1(__riscv_ztt_f16_4x1_t s0) {
  __riscv_ztt_f16_4x1_t r = __riscv_ztt_mreducemax_row_f16_4x1(s0);
}
void ok_f16_1x8(__riscv_ztt_f16_1x8_t s0) {
  __riscv_ztt_f16_1x8_t r = __riscv_ztt_mreducemax_row_f16_1x8(s0);
}
void ok_f16_8x1(__riscv_ztt_f16_8x1_t s0) {
  __riscv_ztt_f16_8x1_t r = __riscv_ztt_mreducemax_row_f16_8x1(s0);
}
void ok_bf16_1x4(__riscv_ztt_bf16_1x4_t s0) {
  __riscv_ztt_bf16_1x4_t r = __riscv_ztt_mreducemax_row_bf16_1x4(s0);
}
void ok_bf16_4x1(__riscv_ztt_bf16_4x1_t s0) {
  __riscv_ztt_bf16_4x1_t r = __riscv_ztt_mreducemax_row_bf16_4x1(s0);
}
void ok_bf16_1x8(__riscv_ztt_bf16_1x8_t s0) {
  __riscv_ztt_bf16_1x8_t r = __riscv_ztt_mreducemax_row_bf16_1x8(s0);
}
void ok_bf16_8x1(__riscv_ztt_bf16_8x1_t s0) {
  __riscv_ztt_bf16_8x1_t r = __riscv_ztt_mreducemax_row_bf16_8x1(s0);
}
void ok_f32_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mreducemax_row_f32_1x2(s0);
}
void ok_f32_2x1(__riscv_ztt_f32_2x1_t s0) {
  __riscv_ztt_f32_2x1_t r = __riscv_ztt_mreducemax_row_f32_2x1(s0);
}
void ok_f32_1x4(__riscv_ztt_f32_1x4_t s0) {
  __riscv_ztt_f32_1x4_t r = __riscv_ztt_mreducemax_row_f32_1x4(s0);
}
void ok_f32_4x1(__riscv_ztt_f32_4x1_t s0) {
  __riscv_ztt_f32_4x1_t r = __riscv_ztt_mreducemax_row_f32_4x1(s0);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mreducemax_row_f64_1x1(s0);
}
void ok_f64_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mreducemax_row_f64_1x2(s0);
}
void ok_f64_2x1(__riscv_ztt_f64_2x1_t s0) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mreducemax_row_f64_2x1(s0);
}
#endif
#if UDS == 128
void ok_i4_1x32(__riscv_ztt_i4_1x32_t s0) {
  __riscv_ztt_i4_1x32_t r = __riscv_ztt_mreducemax_row_i4_1x32(s0);
}
void ok_i4_32x1(__riscv_ztt_i4_32x1_t s0) {
  __riscv_ztt_i4_32x1_t r = __riscv_ztt_mreducemax_row_i4_32x1(s0);
}
void ok_u4_1x32(__riscv_ztt_u4_1x32_t s0) {
  __riscv_ztt_u4_1x32_t r = __riscv_ztt_mreducemax_row_u4_1x32(s0);
}
void ok_u4_32x1(__riscv_ztt_u4_32x1_t s0) {
  __riscv_ztt_u4_32x1_t r = __riscv_ztt_mreducemax_row_u4_32x1(s0);
}
void ok_i8_1x16(__riscv_ztt_i8_1x16_t s0) {
  __riscv_ztt_i8_1x16_t r = __riscv_ztt_mreducemax_row_i8_1x16(s0);
}
void ok_i8_16x1(__riscv_ztt_i8_16x1_t s0) {
  __riscv_ztt_i8_16x1_t r = __riscv_ztt_mreducemax_row_i8_16x1(s0);
}
void ok_i8_1x32(__riscv_ztt_i8_1x32_t s0) {
  __riscv_ztt_i8_1x32_t r = __riscv_ztt_mreducemax_row_i8_1x32(s0);
}
void ok_i8_32x1(__riscv_ztt_i8_32x1_t s0) {
  __riscv_ztt_i8_32x1_t r = __riscv_ztt_mreducemax_row_i8_32x1(s0);
}
void ok_u8_1x16(__riscv_ztt_u8_1x16_t s0) {
  __riscv_ztt_u8_1x16_t r = __riscv_ztt_mreducemax_row_u8_1x16(s0);
}
void ok_u8_16x1(__riscv_ztt_u8_16x1_t s0) {
  __riscv_ztt_u8_16x1_t r = __riscv_ztt_mreducemax_row_u8_16x1(s0);
}
void ok_u8_1x32(__riscv_ztt_u8_1x32_t s0) {
  __riscv_ztt_u8_1x32_t r = __riscv_ztt_mreducemax_row_u8_1x32(s0);
}
void ok_u8_32x1(__riscv_ztt_u8_32x1_t s0) {
  __riscv_ztt_u8_32x1_t r = __riscv_ztt_mreducemax_row_u8_32x1(s0);
}
void ok_i16_1x8(__riscv_ztt_i16_1x8_t s0) {
  __riscv_ztt_i16_1x8_t r = __riscv_ztt_mreducemax_row_i16_1x8(s0);
}
void ok_i16_8x1(__riscv_ztt_i16_8x1_t s0) {
  __riscv_ztt_i16_8x1_t r = __riscv_ztt_mreducemax_row_i16_8x1(s0);
}
void ok_i16_1x16(__riscv_ztt_i16_1x16_t s0) {
  __riscv_ztt_i16_1x16_t r = __riscv_ztt_mreducemax_row_i16_1x16(s0);
}
void ok_i16_16x1(__riscv_ztt_i16_16x1_t s0) {
  __riscv_ztt_i16_16x1_t r = __riscv_ztt_mreducemax_row_i16_16x1(s0);
}
void ok_u16_1x8(__riscv_ztt_u16_1x8_t s0) {
  __riscv_ztt_u16_1x8_t r = __riscv_ztt_mreducemax_row_u16_1x8(s0);
}
void ok_u16_8x1(__riscv_ztt_u16_8x1_t s0) {
  __riscv_ztt_u16_8x1_t r = __riscv_ztt_mreducemax_row_u16_8x1(s0);
}
void ok_u16_1x16(__riscv_ztt_u16_1x16_t s0) {
  __riscv_ztt_u16_1x16_t r = __riscv_ztt_mreducemax_row_u16_1x16(s0);
}
void ok_u16_16x1(__riscv_ztt_u16_16x1_t s0) {
  __riscv_ztt_u16_16x1_t r = __riscv_ztt_mreducemax_row_u16_16x1(s0);
}
void ok_i32_1x4(__riscv_ztt_i32_1x4_t s0) {
  __riscv_ztt_i32_1x4_t r = __riscv_ztt_mreducemax_row_i32_1x4(s0);
}
void ok_i32_4x1(__riscv_ztt_i32_4x1_t s0) {
  __riscv_ztt_i32_4x1_t r = __riscv_ztt_mreducemax_row_i32_4x1(s0);
}
void ok_i32_1x8(__riscv_ztt_i32_1x8_t s0) {
  __riscv_ztt_i32_1x8_t r = __riscv_ztt_mreducemax_row_i32_1x8(s0);
}
void ok_i32_8x1(__riscv_ztt_i32_8x1_t s0) {
  __riscv_ztt_i32_8x1_t r = __riscv_ztt_mreducemax_row_i32_8x1(s0);
}
void ok_u32_1x4(__riscv_ztt_u32_1x4_t s0) {
  __riscv_ztt_u32_1x4_t r = __riscv_ztt_mreducemax_row_u32_1x4(s0);
}
void ok_u32_4x1(__riscv_ztt_u32_4x1_t s0) {
  __riscv_ztt_u32_4x1_t r = __riscv_ztt_mreducemax_row_u32_4x1(s0);
}
void ok_u32_1x8(__riscv_ztt_u32_1x8_t s0) {
  __riscv_ztt_u32_1x8_t r = __riscv_ztt_mreducemax_row_u32_1x8(s0);
}
void ok_u32_8x1(__riscv_ztt_u32_8x1_t s0) {
  __riscv_ztt_u32_8x1_t r = __riscv_ztt_mreducemax_row_u32_8x1(s0);
}
void ok_i64_1x2(__riscv_ztt_i64_1x2_t s0) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mreducemax_row_i64_1x2(s0);
}
void ok_i64_2x1(__riscv_ztt_i64_2x1_t s0) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mreducemax_row_i64_2x1(s0);
}
void ok_i64_1x4(__riscv_ztt_i64_1x4_t s0) {
  __riscv_ztt_i64_1x4_t r = __riscv_ztt_mreducemax_row_i64_1x4(s0);
}
void ok_i64_4x1(__riscv_ztt_i64_4x1_t s0) {
  __riscv_ztt_i64_4x1_t r = __riscv_ztt_mreducemax_row_i64_4x1(s0);
}
void ok_u64_1x2(__riscv_ztt_u64_1x2_t s0) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mreducemax_row_u64_1x2(s0);
}
void ok_u64_2x1(__riscv_ztt_u64_2x1_t s0) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mreducemax_row_u64_2x1(s0);
}
void ok_u64_1x4(__riscv_ztt_u64_1x4_t s0) {
  __riscv_ztt_u64_1x4_t r = __riscv_ztt_mreducemax_row_u64_1x4(s0);
}
void ok_u64_4x1(__riscv_ztt_u64_4x1_t s0) {
  __riscv_ztt_u64_4x1_t r = __riscv_ztt_mreducemax_row_u64_4x1(s0);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mreducemax_row_i128_1x1(s0);
}
void ok_i128_1x2(__riscv_ztt_i128_1x2_t s0) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mreducemax_row_i128_1x2(s0);
}
void ok_i128_2x1(__riscv_ztt_i128_2x1_t s0) {
  __riscv_ztt_i128_2x1_t r = __riscv_ztt_mreducemax_row_i128_2x1(s0);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mreducemax_row_u128_1x1(s0);
}
void ok_u128_1x2(__riscv_ztt_u128_1x2_t s0) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mreducemax_row_u128_1x2(s0);
}
void ok_u128_2x1(__riscv_ztt_u128_2x1_t s0) {
  __riscv_ztt_u128_2x1_t r = __riscv_ztt_mreducemax_row_u128_2x1(s0);
}
void ok_f16_1x8(__riscv_ztt_f16_1x8_t s0) {
  __riscv_ztt_f16_1x8_t r = __riscv_ztt_mreducemax_row_f16_1x8(s0);
}
void ok_f16_8x1(__riscv_ztt_f16_8x1_t s0) {
  __riscv_ztt_f16_8x1_t r = __riscv_ztt_mreducemax_row_f16_8x1(s0);
}
void ok_f16_1x16(__riscv_ztt_f16_1x16_t s0) {
  __riscv_ztt_f16_1x16_t r = __riscv_ztt_mreducemax_row_f16_1x16(s0);
}
void ok_f16_16x1(__riscv_ztt_f16_16x1_t s0) {
  __riscv_ztt_f16_16x1_t r = __riscv_ztt_mreducemax_row_f16_16x1(s0);
}
void ok_bf16_1x8(__riscv_ztt_bf16_1x8_t s0) {
  __riscv_ztt_bf16_1x8_t r = __riscv_ztt_mreducemax_row_bf16_1x8(s0);
}
void ok_bf16_8x1(__riscv_ztt_bf16_8x1_t s0) {
  __riscv_ztt_bf16_8x1_t r = __riscv_ztt_mreducemax_row_bf16_8x1(s0);
}
void ok_bf16_1x16(__riscv_ztt_bf16_1x16_t s0) {
  __riscv_ztt_bf16_1x16_t r = __riscv_ztt_mreducemax_row_bf16_1x16(s0);
}
void ok_bf16_16x1(__riscv_ztt_bf16_16x1_t s0) {
  __riscv_ztt_bf16_16x1_t r = __riscv_ztt_mreducemax_row_bf16_16x1(s0);
}
void ok_f32_1x4(__riscv_ztt_f32_1x4_t s0) {
  __riscv_ztt_f32_1x4_t r = __riscv_ztt_mreducemax_row_f32_1x4(s0);
}
void ok_f32_4x1(__riscv_ztt_f32_4x1_t s0) {
  __riscv_ztt_f32_4x1_t r = __riscv_ztt_mreducemax_row_f32_4x1(s0);
}
void ok_f32_1x8(__riscv_ztt_f32_1x8_t s0) {
  __riscv_ztt_f32_1x8_t r = __riscv_ztt_mreducemax_row_f32_1x8(s0);
}
void ok_f32_8x1(__riscv_ztt_f32_8x1_t s0) {
  __riscv_ztt_f32_8x1_t r = __riscv_ztt_mreducemax_row_f32_8x1(s0);
}
void ok_f64_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mreducemax_row_f64_1x2(s0);
}
void ok_f64_2x1(__riscv_ztt_f64_2x1_t s0) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mreducemax_row_f64_2x1(s0);
}
void ok_f64_1x4(__riscv_ztt_f64_1x4_t s0) {
  __riscv_ztt_f64_1x4_t r = __riscv_ztt_mreducemax_row_f64_1x4(s0);
}
void ok_f64_4x1(__riscv_ztt_f64_4x1_t s0) {
  __riscv_ztt_f64_4x1_t r = __riscv_ztt_mreducemax_row_f64_4x1(s0);
}
#endif
#if UDS != 8
// expected-no-diagnostics
#endif

#if UDS == 8
void invalid_operands(void) {
  __riscv_ztt_i32_1x1_t a0 = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x4_t wrong_shape = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_u32_1x1_t other_type = __riscv_ztt_mzero_m_u32_1x1();
  __riscv_ztt_f32_1x1_t fp = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_1x1_t integer = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mreducemax_row_i32_1x1(acc); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mreducemax_row_i32_1x1(wrong_shape); // expected-error {{RISC-V Ztt mreducemax.row operands violate the required datatype or shape constraints}}
}
#endif
#if UDS == 8
void boundaries(__riscv_ztt_i32_1x1_t s0, __riscv_ztt_i32_1x2_t row, __riscv_ztt_i32_2x1_t col, __riscv_ztt_f32_1x1_t fp, __riscv_ztt_u32_1x1_t uns, __riscv_ztt_i32_accx1_t acc, __riscv_ztt_i32_scalar_t zs, float f, int *p) {
  // Equal square counts must not hide an orientation mismatch.
  __riscv_ztt_mreducemax_row_i32_1x2(col); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mreducemax_row_i32_2x1(row); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mreducemax_row_i32_1x1(row); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mreducemax_row_i32_1x1(col); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mreducemax_row_i32_1x1(); // expected-error {{too few arguments}}
  __riscv_ztt_mreducemax_row_i32_1x1(s0, 1); // expected-error {{too many arguments}}
}
#endif
#if UDS == 8
__riscv_ztt_i4_1x2_t test_0(__riscv_ztt_f32_1x2_t s0) { return __riscv_ztt_mreducemax_row_i4_1x2(s0); }
#endif
#if UDS == 8
__riscv_ztt_u4_2x1_t test_1(__riscv_ztt_f32_2x1_t s0) { return __riscv_ztt_mreducemax_row_u4_2x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_i8_1x1_t test_2(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_i8_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_u8_1x1_t test_3(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_u8_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_i16_1x1_t test_4(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_i16_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_u16_1x1_t test_5(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_u16_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_i32_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_u32_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_i64_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_u64_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_i128_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mreducemax_row_u128_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_f16_1x1_t test_12(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mreducemax_row_f16_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_bf16_1x1_t test_13(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mreducemax_row_bf16_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mreducemax_row_f32_1x1(s0); }
#endif
#if UDS == 8
__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mreducemax_row_f64_1x1(s0); }
#endif
