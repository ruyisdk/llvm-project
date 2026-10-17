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
void ok_0_1x2(__riscv_ztt_i4_1x2_t old, __riscv_ztt_i4_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x2_t r = __riscv_ztt_mmulacc_ew_x_i4_1x2(old, s0, scalar);
}
void ok_0_2x1(__riscv_ztt_i4_2x1_t old, __riscv_ztt_i4_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_2x1_t r = __riscv_ztt_mmulacc_ew_x_i4_2x1(old, s0, scalar);
}
void ok_0_1x4(__riscv_ztt_i4_1x4_t old, __riscv_ztt_i4_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x4_t r = __riscv_ztt_mmulacc_ew_x_i4_1x4(old, s0, scalar);
}
void ok_1_1x2(__riscv_ztt_u4_1x2_t old, __riscv_ztt_u4_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x2_t r = __riscv_ztt_mmulacc_ew_x_u4_1x2(old, s0, scalar);
}
void ok_1_2x1(__riscv_ztt_u4_2x1_t old, __riscv_ztt_u4_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_2x1_t r = __riscv_ztt_mmulacc_ew_x_u4_2x1(old, s0, scalar);
}
void ok_1_1x4(__riscv_ztt_u4_1x4_t old, __riscv_ztt_u4_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x4_t r = __riscv_ztt_mmulacc_ew_x_u4_1x4(old, s0, scalar);
}
void ok_2_1x1(__riscv_ztt_i8_1x1_t old, __riscv_ztt_i8_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x1_t r = __riscv_ztt_mmulacc_ew_x_i8_1x1(old, s0, scalar);
}
void ok_2_1x2(__riscv_ztt_i8_1x2_t old, __riscv_ztt_i8_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x2_t r = __riscv_ztt_mmulacc_ew_x_i8_1x2(old, s0, scalar);
}
void ok_3_1x1(__riscv_ztt_u8_1x1_t old, __riscv_ztt_u8_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x1_t r = __riscv_ztt_mmulacc_ew_x_u8_1x1(old, s0, scalar);
}
void ok_3_1x2(__riscv_ztt_u8_1x2_t old, __riscv_ztt_u8_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x2_t r = __riscv_ztt_mmulacc_ew_x_u8_1x2(old, s0, scalar);
}
void ok_4_1x1(__riscv_ztt_i16_1x1_t old, __riscv_ztt_i16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mmulacc_ew_x_i16_1x1(old, s0, scalar);
}
void ok_4_1x2(__riscv_ztt_i16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mmulacc_ew_x_i16_1x2(old, s0, scalar);
}
void ok_5_1x1(__riscv_ztt_u16_1x1_t old, __riscv_ztt_u16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mmulacc_ew_x_u16_1x1(old, s0, scalar);
}
void ok_5_1x2(__riscv_ztt_u16_1x2_t old, __riscv_ztt_u16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mmulacc_ew_x_u16_1x2(old, s0, scalar);
}
void ok_6_1x1(__riscv_ztt_i32_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mmulacc_ew_x_i32_1x1(old, s0, scalar);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, scalar);
}
void ok_7_1x1(__riscv_ztt_u32_1x1_t old, __riscv_ztt_u32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mmulacc_ew_x_u32_1x1(old, s0, scalar);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t old, __riscv_ztt_u32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mmulacc_ew_x_u32_1x2(old, s0, scalar);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t old, __riscv_ztt_i64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mmulacc_ew_x_i64_1x1(old, s0, scalar);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mmulacc_ew_x_i64_1x2(old, s0, scalar);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t old, __riscv_ztt_u64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mmulacc_ew_x_u64_1x1(old, s0, scalar);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t old, __riscv_ztt_u64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mmulacc_ew_x_u64_1x2(old, s0, scalar);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t old, __riscv_ztt_i128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mmulacc_ew_x_i128_1x1(old, s0, scalar);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mmulacc_ew_x_i128_1x2(old, s0, scalar);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t old, __riscv_ztt_u128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mmulacc_ew_x_u128_1x1(old, s0, scalar);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t old, __riscv_ztt_u128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mmulacc_ew_x_u128_1x2(old, s0, scalar);
}
void ok_12_1x1(__riscv_ztt_f16_1x1_t old, __riscv_ztt_f16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mmulacc_ew_x_f16_1x1(old, s0, scalar);
}
void ok_12_1x2(__riscv_ztt_f16_1x2_t old, __riscv_ztt_f16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mmulacc_ew_x_f16_1x2(old, s0, scalar);
}
void ok_13_1x1(__riscv_ztt_bf16_1x1_t old, __riscv_ztt_bf16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x1(old, s0, scalar);
}
void ok_13_1x2(__riscv_ztt_bf16_1x2_t old, __riscv_ztt_bf16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x2(old, s0, scalar);
}
void ok_14_1x1(__riscv_ztt_f32_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mmulacc_ew_x_f32_1x1(old, s0, scalar);
}
void ok_14_1x2(__riscv_ztt_f32_1x2_t old, __riscv_ztt_f32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mmulacc_ew_x_f32_1x2(old, s0, scalar);
}
void ok_15_1x1(__riscv_ztt_f64_1x1_t old, __riscv_ztt_f64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mmulacc_ew_x_f64_1x1(old, s0, scalar);
}
void ok_15_1x2(__riscv_ztt_f64_1x2_t old, __riscv_ztt_f64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mmulacc_ew_x_f64_1x2(old, s0, scalar);
}
#endif
#if UDS == 16
void ok_0_1x4(__riscv_ztt_i4_1x4_t old, __riscv_ztt_i4_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x4_t r = __riscv_ztt_mmulacc_ew_x_i4_1x4(old, s0, scalar);
}
void ok_0_4x1(__riscv_ztt_i4_4x1_t old, __riscv_ztt_i4_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_4x1_t r = __riscv_ztt_mmulacc_ew_x_i4_4x1(old, s0, scalar);
}
void ok_0_1x8(__riscv_ztt_i4_1x8_t old, __riscv_ztt_i4_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x8_t r = __riscv_ztt_mmulacc_ew_x_i4_1x8(old, s0, scalar);
}
void ok_1_1x4(__riscv_ztt_u4_1x4_t old, __riscv_ztt_u4_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x4_t r = __riscv_ztt_mmulacc_ew_x_u4_1x4(old, s0, scalar);
}
void ok_1_4x1(__riscv_ztt_u4_4x1_t old, __riscv_ztt_u4_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_4x1_t r = __riscv_ztt_mmulacc_ew_x_u4_4x1(old, s0, scalar);
}
void ok_1_1x8(__riscv_ztt_u4_1x8_t old, __riscv_ztt_u4_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x8_t r = __riscv_ztt_mmulacc_ew_x_u4_1x8(old, s0, scalar);
}
void ok_2_1x2(__riscv_ztt_i8_1x2_t old, __riscv_ztt_i8_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x2_t r = __riscv_ztt_mmulacc_ew_x_i8_1x2(old, s0, scalar);
}
void ok_2_2x1(__riscv_ztt_i8_2x1_t old, __riscv_ztt_i8_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_2x1_t r = __riscv_ztt_mmulacc_ew_x_i8_2x1(old, s0, scalar);
}
void ok_2_1x4(__riscv_ztt_i8_1x4_t old, __riscv_ztt_i8_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x4_t r = __riscv_ztt_mmulacc_ew_x_i8_1x4(old, s0, scalar);
}
void ok_3_1x2(__riscv_ztt_u8_1x2_t old, __riscv_ztt_u8_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x2_t r = __riscv_ztt_mmulacc_ew_x_u8_1x2(old, s0, scalar);
}
void ok_3_2x1(__riscv_ztt_u8_2x1_t old, __riscv_ztt_u8_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_2x1_t r = __riscv_ztt_mmulacc_ew_x_u8_2x1(old, s0, scalar);
}
void ok_3_1x4(__riscv_ztt_u8_1x4_t old, __riscv_ztt_u8_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x4_t r = __riscv_ztt_mmulacc_ew_x_u8_1x4(old, s0, scalar);
}
void ok_4_1x1(__riscv_ztt_i16_1x1_t old, __riscv_ztt_i16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mmulacc_ew_x_i16_1x1(old, s0, scalar);
}
void ok_4_1x2(__riscv_ztt_i16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mmulacc_ew_x_i16_1x2(old, s0, scalar);
}
void ok_5_1x1(__riscv_ztt_u16_1x1_t old, __riscv_ztt_u16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mmulacc_ew_x_u16_1x1(old, s0, scalar);
}
void ok_5_1x2(__riscv_ztt_u16_1x2_t old, __riscv_ztt_u16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mmulacc_ew_x_u16_1x2(old, s0, scalar);
}
void ok_6_1x1(__riscv_ztt_i32_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mmulacc_ew_x_i32_1x1(old, s0, scalar);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, scalar);
}
void ok_7_1x1(__riscv_ztt_u32_1x1_t old, __riscv_ztt_u32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mmulacc_ew_x_u32_1x1(old, s0, scalar);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t old, __riscv_ztt_u32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mmulacc_ew_x_u32_1x2(old, s0, scalar);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t old, __riscv_ztt_i64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mmulacc_ew_x_i64_1x1(old, s0, scalar);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mmulacc_ew_x_i64_1x2(old, s0, scalar);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t old, __riscv_ztt_u64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mmulacc_ew_x_u64_1x1(old, s0, scalar);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t old, __riscv_ztt_u64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mmulacc_ew_x_u64_1x2(old, s0, scalar);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t old, __riscv_ztt_i128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mmulacc_ew_x_i128_1x1(old, s0, scalar);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mmulacc_ew_x_i128_1x2(old, s0, scalar);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t old, __riscv_ztt_u128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mmulacc_ew_x_u128_1x1(old, s0, scalar);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t old, __riscv_ztt_u128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mmulacc_ew_x_u128_1x2(old, s0, scalar);
}
void ok_12_1x1(__riscv_ztt_f16_1x1_t old, __riscv_ztt_f16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mmulacc_ew_x_f16_1x1(old, s0, scalar);
}
void ok_12_1x2(__riscv_ztt_f16_1x2_t old, __riscv_ztt_f16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mmulacc_ew_x_f16_1x2(old, s0, scalar);
}
void ok_13_1x1(__riscv_ztt_bf16_1x1_t old, __riscv_ztt_bf16_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x1(old, s0, scalar);
}
void ok_13_1x2(__riscv_ztt_bf16_1x2_t old, __riscv_ztt_bf16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x2(old, s0, scalar);
}
void ok_14_1x1(__riscv_ztt_f32_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mmulacc_ew_x_f32_1x1(old, s0, scalar);
}
void ok_14_1x2(__riscv_ztt_f32_1x2_t old, __riscv_ztt_f32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mmulacc_ew_x_f32_1x2(old, s0, scalar);
}
void ok_15_1x1(__riscv_ztt_f64_1x1_t old, __riscv_ztt_f64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mmulacc_ew_x_f64_1x1(old, s0, scalar);
}
void ok_15_1x2(__riscv_ztt_f64_1x2_t old, __riscv_ztt_f64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mmulacc_ew_x_f64_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
void ok_0_1x8(__riscv_ztt_i4_1x8_t old, __riscv_ztt_i4_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x8_t r = __riscv_ztt_mmulacc_ew_x_i4_1x8(old, s0, scalar);
}
void ok_0_8x1(__riscv_ztt_i4_8x1_t old, __riscv_ztt_i4_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_8x1_t r = __riscv_ztt_mmulacc_ew_x_i4_8x1(old, s0, scalar);
}
void ok_0_1x16(__riscv_ztt_i4_1x16_t old, __riscv_ztt_i4_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x16_t r = __riscv_ztt_mmulacc_ew_x_i4_1x16(old, s0, scalar);
}
void ok_1_1x8(__riscv_ztt_u4_1x8_t old, __riscv_ztt_u4_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x8_t r = __riscv_ztt_mmulacc_ew_x_u4_1x8(old, s0, scalar);
}
void ok_1_8x1(__riscv_ztt_u4_8x1_t old, __riscv_ztt_u4_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_8x1_t r = __riscv_ztt_mmulacc_ew_x_u4_8x1(old, s0, scalar);
}
void ok_1_1x16(__riscv_ztt_u4_1x16_t old, __riscv_ztt_u4_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x16_t r = __riscv_ztt_mmulacc_ew_x_u4_1x16(old, s0, scalar);
}
void ok_2_1x4(__riscv_ztt_i8_1x4_t old, __riscv_ztt_i8_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x4_t r = __riscv_ztt_mmulacc_ew_x_i8_1x4(old, s0, scalar);
}
void ok_2_4x1(__riscv_ztt_i8_4x1_t old, __riscv_ztt_i8_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_4x1_t r = __riscv_ztt_mmulacc_ew_x_i8_4x1(old, s0, scalar);
}
void ok_2_1x8(__riscv_ztt_i8_1x8_t old, __riscv_ztt_i8_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x8_t r = __riscv_ztt_mmulacc_ew_x_i8_1x8(old, s0, scalar);
}
void ok_3_1x4(__riscv_ztt_u8_1x4_t old, __riscv_ztt_u8_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x4_t r = __riscv_ztt_mmulacc_ew_x_u8_1x4(old, s0, scalar);
}
void ok_3_4x1(__riscv_ztt_u8_4x1_t old, __riscv_ztt_u8_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_4x1_t r = __riscv_ztt_mmulacc_ew_x_u8_4x1(old, s0, scalar);
}
void ok_3_1x8(__riscv_ztt_u8_1x8_t old, __riscv_ztt_u8_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x8_t r = __riscv_ztt_mmulacc_ew_x_u8_1x8(old, s0, scalar);
}
void ok_4_1x2(__riscv_ztt_i16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mmulacc_ew_x_i16_1x2(old, s0, scalar);
}
void ok_4_2x1(__riscv_ztt_i16_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_2x1_t r = __riscv_ztt_mmulacc_ew_x_i16_2x1(old, s0, scalar);
}
void ok_4_1x4(__riscv_ztt_i16_1x4_t old, __riscv_ztt_i16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x4_t r = __riscv_ztt_mmulacc_ew_x_i16_1x4(old, s0, scalar);
}
void ok_5_1x2(__riscv_ztt_u16_1x2_t old, __riscv_ztt_u16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mmulacc_ew_x_u16_1x2(old, s0, scalar);
}
void ok_5_2x1(__riscv_ztt_u16_2x1_t old, __riscv_ztt_u16_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_2x1_t r = __riscv_ztt_mmulacc_ew_x_u16_2x1(old, s0, scalar);
}
void ok_5_1x4(__riscv_ztt_u16_1x4_t old, __riscv_ztt_u16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x4_t r = __riscv_ztt_mmulacc_ew_x_u16_1x4(old, s0, scalar);
}
void ok_6_1x1(__riscv_ztt_i32_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mmulacc_ew_x_i32_1x1(old, s0, scalar);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, scalar);
}
void ok_7_1x1(__riscv_ztt_u32_1x1_t old, __riscv_ztt_u32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mmulacc_ew_x_u32_1x1(old, s0, scalar);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t old, __riscv_ztt_u32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mmulacc_ew_x_u32_1x2(old, s0, scalar);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t old, __riscv_ztt_i64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mmulacc_ew_x_i64_1x1(old, s0, scalar);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mmulacc_ew_x_i64_1x2(old, s0, scalar);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t old, __riscv_ztt_u64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mmulacc_ew_x_u64_1x1(old, s0, scalar);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t old, __riscv_ztt_u64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mmulacc_ew_x_u64_1x2(old, s0, scalar);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t old, __riscv_ztt_i128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mmulacc_ew_x_i128_1x1(old, s0, scalar);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mmulacc_ew_x_i128_1x2(old, s0, scalar);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t old, __riscv_ztt_u128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mmulacc_ew_x_u128_1x1(old, s0, scalar);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t old, __riscv_ztt_u128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mmulacc_ew_x_u128_1x2(old, s0, scalar);
}
void ok_12_1x2(__riscv_ztt_f16_1x2_t old, __riscv_ztt_f16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mmulacc_ew_x_f16_1x2(old, s0, scalar);
}
void ok_12_2x1(__riscv_ztt_f16_2x1_t old, __riscv_ztt_f16_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_2x1_t r = __riscv_ztt_mmulacc_ew_x_f16_2x1(old, s0, scalar);
}
void ok_12_1x4(__riscv_ztt_f16_1x4_t old, __riscv_ztt_f16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x4_t r = __riscv_ztt_mmulacc_ew_x_f16_1x4(old, s0, scalar);
}
void ok_13_1x2(__riscv_ztt_bf16_1x2_t old, __riscv_ztt_bf16_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x2(old, s0, scalar);
}
void ok_13_2x1(__riscv_ztt_bf16_2x1_t old, __riscv_ztt_bf16_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_2x1_t r = __riscv_ztt_mmulacc_ew_x_bf16_2x1(old, s0, scalar);
}
void ok_13_1x4(__riscv_ztt_bf16_1x4_t old, __riscv_ztt_bf16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x4_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x4(old, s0, scalar);
}
void ok_14_1x1(__riscv_ztt_f32_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mmulacc_ew_x_f32_1x1(old, s0, scalar);
}
void ok_14_1x2(__riscv_ztt_f32_1x2_t old, __riscv_ztt_f32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mmulacc_ew_x_f32_1x2(old, s0, scalar);
}
void ok_15_1x1(__riscv_ztt_f64_1x1_t old, __riscv_ztt_f64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mmulacc_ew_x_f64_1x1(old, s0, scalar);
}
void ok_15_1x2(__riscv_ztt_f64_1x2_t old, __riscv_ztt_f64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mmulacc_ew_x_f64_1x2(old, s0, scalar);
}
#endif
#if UDS == 64
void ok_0_1x16(__riscv_ztt_i4_1x16_t old, __riscv_ztt_i4_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x16_t r = __riscv_ztt_mmulacc_ew_x_i4_1x16(old, s0, scalar);
}
void ok_0_16x1(__riscv_ztt_i4_16x1_t old, __riscv_ztt_i4_16x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_16x1_t r = __riscv_ztt_mmulacc_ew_x_i4_16x1(old, s0, scalar);
}
void ok_0_1x32(__riscv_ztt_i4_1x32_t old, __riscv_ztt_i4_1x32_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x32_t r = __riscv_ztt_mmulacc_ew_x_i4_1x32(old, s0, scalar);
}
void ok_1_1x16(__riscv_ztt_u4_1x16_t old, __riscv_ztt_u4_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x16_t r = __riscv_ztt_mmulacc_ew_x_u4_1x16(old, s0, scalar);
}
void ok_1_16x1(__riscv_ztt_u4_16x1_t old, __riscv_ztt_u4_16x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_16x1_t r = __riscv_ztt_mmulacc_ew_x_u4_16x1(old, s0, scalar);
}
void ok_1_1x32(__riscv_ztt_u4_1x32_t old, __riscv_ztt_u4_1x32_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x32_t r = __riscv_ztt_mmulacc_ew_x_u4_1x32(old, s0, scalar);
}
void ok_2_1x8(__riscv_ztt_i8_1x8_t old, __riscv_ztt_i8_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x8_t r = __riscv_ztt_mmulacc_ew_x_i8_1x8(old, s0, scalar);
}
void ok_2_8x1(__riscv_ztt_i8_8x1_t old, __riscv_ztt_i8_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_8x1_t r = __riscv_ztt_mmulacc_ew_x_i8_8x1(old, s0, scalar);
}
void ok_2_1x16(__riscv_ztt_i8_1x16_t old, __riscv_ztt_i8_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x16_t r = __riscv_ztt_mmulacc_ew_x_i8_1x16(old, s0, scalar);
}
void ok_3_1x8(__riscv_ztt_u8_1x8_t old, __riscv_ztt_u8_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x8_t r = __riscv_ztt_mmulacc_ew_x_u8_1x8(old, s0, scalar);
}
void ok_3_8x1(__riscv_ztt_u8_8x1_t old, __riscv_ztt_u8_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_8x1_t r = __riscv_ztt_mmulacc_ew_x_u8_8x1(old, s0, scalar);
}
void ok_3_1x16(__riscv_ztt_u8_1x16_t old, __riscv_ztt_u8_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x16_t r = __riscv_ztt_mmulacc_ew_x_u8_1x16(old, s0, scalar);
}
void ok_4_1x4(__riscv_ztt_i16_1x4_t old, __riscv_ztt_i16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x4_t r = __riscv_ztt_mmulacc_ew_x_i16_1x4(old, s0, scalar);
}
void ok_4_4x1(__riscv_ztt_i16_4x1_t old, __riscv_ztt_i16_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_4x1_t r = __riscv_ztt_mmulacc_ew_x_i16_4x1(old, s0, scalar);
}
void ok_4_1x8(__riscv_ztt_i16_1x8_t old, __riscv_ztt_i16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x8_t r = __riscv_ztt_mmulacc_ew_x_i16_1x8(old, s0, scalar);
}
void ok_5_1x4(__riscv_ztt_u16_1x4_t old, __riscv_ztt_u16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x4_t r = __riscv_ztt_mmulacc_ew_x_u16_1x4(old, s0, scalar);
}
void ok_5_4x1(__riscv_ztt_u16_4x1_t old, __riscv_ztt_u16_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_4x1_t r = __riscv_ztt_mmulacc_ew_x_u16_4x1(old, s0, scalar);
}
void ok_5_1x8(__riscv_ztt_u16_1x8_t old, __riscv_ztt_u16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x8_t r = __riscv_ztt_mmulacc_ew_x_u16_1x8(old, s0, scalar);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, scalar);
}
void ok_6_2x1(__riscv_ztt_i32_2x1_t old, __riscv_ztt_i32_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_2x1_t r = __riscv_ztt_mmulacc_ew_x_i32_2x1(old, s0, scalar);
}
void ok_6_1x4(__riscv_ztt_i32_1x4_t old, __riscv_ztt_i32_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x4_t r = __riscv_ztt_mmulacc_ew_x_i32_1x4(old, s0, scalar);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t old, __riscv_ztt_u32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mmulacc_ew_x_u32_1x2(old, s0, scalar);
}
void ok_7_2x1(__riscv_ztt_u32_2x1_t old, __riscv_ztt_u32_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_2x1_t r = __riscv_ztt_mmulacc_ew_x_u32_2x1(old, s0, scalar);
}
void ok_7_1x4(__riscv_ztt_u32_1x4_t old, __riscv_ztt_u32_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x4_t r = __riscv_ztt_mmulacc_ew_x_u32_1x4(old, s0, scalar);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t old, __riscv_ztt_i64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mmulacc_ew_x_i64_1x1(old, s0, scalar);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mmulacc_ew_x_i64_1x2(old, s0, scalar);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t old, __riscv_ztt_u64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mmulacc_ew_x_u64_1x1(old, s0, scalar);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t old, __riscv_ztt_u64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mmulacc_ew_x_u64_1x2(old, s0, scalar);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t old, __riscv_ztt_i128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mmulacc_ew_x_i128_1x1(old, s0, scalar);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mmulacc_ew_x_i128_1x2(old, s0, scalar);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t old, __riscv_ztt_u128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mmulacc_ew_x_u128_1x1(old, s0, scalar);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t old, __riscv_ztt_u128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mmulacc_ew_x_u128_1x2(old, s0, scalar);
}
void ok_12_1x4(__riscv_ztt_f16_1x4_t old, __riscv_ztt_f16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x4_t r = __riscv_ztt_mmulacc_ew_x_f16_1x4(old, s0, scalar);
}
void ok_12_4x1(__riscv_ztt_f16_4x1_t old, __riscv_ztt_f16_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_4x1_t r = __riscv_ztt_mmulacc_ew_x_f16_4x1(old, s0, scalar);
}
void ok_12_1x8(__riscv_ztt_f16_1x8_t old, __riscv_ztt_f16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x8_t r = __riscv_ztt_mmulacc_ew_x_f16_1x8(old, s0, scalar);
}
void ok_13_1x4(__riscv_ztt_bf16_1x4_t old, __riscv_ztt_bf16_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x4_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x4(old, s0, scalar);
}
void ok_13_4x1(__riscv_ztt_bf16_4x1_t old, __riscv_ztt_bf16_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_4x1_t r = __riscv_ztt_mmulacc_ew_x_bf16_4x1(old, s0, scalar);
}
void ok_13_1x8(__riscv_ztt_bf16_1x8_t old, __riscv_ztt_bf16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x8_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x8(old, s0, scalar);
}
void ok_14_1x2(__riscv_ztt_f32_1x2_t old, __riscv_ztt_f32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mmulacc_ew_x_f32_1x2(old, s0, scalar);
}
void ok_14_2x1(__riscv_ztt_f32_2x1_t old, __riscv_ztt_f32_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_2x1_t r = __riscv_ztt_mmulacc_ew_x_f32_2x1(old, s0, scalar);
}
void ok_14_1x4(__riscv_ztt_f32_1x4_t old, __riscv_ztt_f32_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x4_t r = __riscv_ztt_mmulacc_ew_x_f32_1x4(old, s0, scalar);
}
void ok_15_1x1(__riscv_ztt_f64_1x1_t old, __riscv_ztt_f64_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mmulacc_ew_x_f64_1x1(old, s0, scalar);
}
void ok_15_1x2(__riscv_ztt_f64_1x2_t old, __riscv_ztt_f64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mmulacc_ew_x_f64_1x2(old, s0, scalar);
}
#endif
#if UDS == 128
void ok_0_1x32(__riscv_ztt_i4_1x32_t old, __riscv_ztt_i4_1x32_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_1x32_t r = __riscv_ztt_mmulacc_ew_x_i4_1x32(old, s0, scalar);
}
void ok_0_32x1(__riscv_ztt_i4_32x1_t old, __riscv_ztt_i4_32x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i4_32x1_t r = __riscv_ztt_mmulacc_ew_x_i4_32x1(old, s0, scalar);
}
void ok_1_1x32(__riscv_ztt_u4_1x32_t old, __riscv_ztt_u4_1x32_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_1x32_t r = __riscv_ztt_mmulacc_ew_x_u4_1x32(old, s0, scalar);
}
void ok_1_32x1(__riscv_ztt_u4_32x1_t old, __riscv_ztt_u4_32x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u4_32x1_t r = __riscv_ztt_mmulacc_ew_x_u4_32x1(old, s0, scalar);
}
void ok_2_1x16(__riscv_ztt_i8_1x16_t old, __riscv_ztt_i8_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x16_t r = __riscv_ztt_mmulacc_ew_x_i8_1x16(old, s0, scalar);
}
void ok_2_16x1(__riscv_ztt_i8_16x1_t old, __riscv_ztt_i8_16x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_16x1_t r = __riscv_ztt_mmulacc_ew_x_i8_16x1(old, s0, scalar);
}
void ok_2_1x32(__riscv_ztt_i8_1x32_t old, __riscv_ztt_i8_1x32_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i8_1x32_t r = __riscv_ztt_mmulacc_ew_x_i8_1x32(old, s0, scalar);
}
void ok_3_1x16(__riscv_ztt_u8_1x16_t old, __riscv_ztt_u8_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x16_t r = __riscv_ztt_mmulacc_ew_x_u8_1x16(old, s0, scalar);
}
void ok_3_16x1(__riscv_ztt_u8_16x1_t old, __riscv_ztt_u8_16x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_16x1_t r = __riscv_ztt_mmulacc_ew_x_u8_16x1(old, s0, scalar);
}
void ok_3_1x32(__riscv_ztt_u8_1x32_t old, __riscv_ztt_u8_1x32_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u8_1x32_t r = __riscv_ztt_mmulacc_ew_x_u8_1x32(old, s0, scalar);
}
void ok_4_1x8(__riscv_ztt_i16_1x8_t old, __riscv_ztt_i16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x8_t r = __riscv_ztt_mmulacc_ew_x_i16_1x8(old, s0, scalar);
}
void ok_4_8x1(__riscv_ztt_i16_8x1_t old, __riscv_ztt_i16_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_8x1_t r = __riscv_ztt_mmulacc_ew_x_i16_8x1(old, s0, scalar);
}
void ok_4_1x16(__riscv_ztt_i16_1x16_t old, __riscv_ztt_i16_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i16_1x16_t r = __riscv_ztt_mmulacc_ew_x_i16_1x16(old, s0, scalar);
}
void ok_5_1x8(__riscv_ztt_u16_1x8_t old, __riscv_ztt_u16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x8_t r = __riscv_ztt_mmulacc_ew_x_u16_1x8(old, s0, scalar);
}
void ok_5_8x1(__riscv_ztt_u16_8x1_t old, __riscv_ztt_u16_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_8x1_t r = __riscv_ztt_mmulacc_ew_x_u16_8x1(old, s0, scalar);
}
void ok_5_1x16(__riscv_ztt_u16_1x16_t old, __riscv_ztt_u16_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u16_1x16_t r = __riscv_ztt_mmulacc_ew_x_u16_1x16(old, s0, scalar);
}
void ok_6_1x4(__riscv_ztt_i32_1x4_t old, __riscv_ztt_i32_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x4_t r = __riscv_ztt_mmulacc_ew_x_i32_1x4(old, s0, scalar);
}
void ok_6_4x1(__riscv_ztt_i32_4x1_t old, __riscv_ztt_i32_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_4x1_t r = __riscv_ztt_mmulacc_ew_x_i32_4x1(old, s0, scalar);
}
void ok_6_1x8(__riscv_ztt_i32_1x8_t old, __riscv_ztt_i32_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i32_1x8_t r = __riscv_ztt_mmulacc_ew_x_i32_1x8(old, s0, scalar);
}
void ok_7_1x4(__riscv_ztt_u32_1x4_t old, __riscv_ztt_u32_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x4_t r = __riscv_ztt_mmulacc_ew_x_u32_1x4(old, s0, scalar);
}
void ok_7_4x1(__riscv_ztt_u32_4x1_t old, __riscv_ztt_u32_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_4x1_t r = __riscv_ztt_mmulacc_ew_x_u32_4x1(old, s0, scalar);
}
void ok_7_1x8(__riscv_ztt_u32_1x8_t old, __riscv_ztt_u32_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u32_1x8_t r = __riscv_ztt_mmulacc_ew_x_u32_1x8(old, s0, scalar);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mmulacc_ew_x_i64_1x2(old, s0, scalar);
}
void ok_8_2x1(__riscv_ztt_i64_2x1_t old, __riscv_ztt_i64_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mmulacc_ew_x_i64_2x1(old, s0, scalar);
}
void ok_8_1x4(__riscv_ztt_i64_1x4_t old, __riscv_ztt_i64_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i64_1x4_t r = __riscv_ztt_mmulacc_ew_x_i64_1x4(old, s0, scalar);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t old, __riscv_ztt_u64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mmulacc_ew_x_u64_1x2(old, s0, scalar);
}
void ok_9_2x1(__riscv_ztt_u64_2x1_t old, __riscv_ztt_u64_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mmulacc_ew_x_u64_2x1(old, s0, scalar);
}
void ok_9_1x4(__riscv_ztt_u64_1x4_t old, __riscv_ztt_u64_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u64_1x4_t r = __riscv_ztt_mmulacc_ew_x_u64_1x4(old, s0, scalar);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t old, __riscv_ztt_i128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mmulacc_ew_x_i128_1x1(old, s0, scalar);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mmulacc_ew_x_i128_1x2(old, s0, scalar);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t old, __riscv_ztt_u128_1x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mmulacc_ew_x_u128_1x1(old, s0, scalar);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t old, __riscv_ztt_u128_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mmulacc_ew_x_u128_1x2(old, s0, scalar);
}
void ok_12_1x8(__riscv_ztt_f16_1x8_t old, __riscv_ztt_f16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x8_t r = __riscv_ztt_mmulacc_ew_x_f16_1x8(old, s0, scalar);
}
void ok_12_8x1(__riscv_ztt_f16_8x1_t old, __riscv_ztt_f16_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_8x1_t r = __riscv_ztt_mmulacc_ew_x_f16_8x1(old, s0, scalar);
}
void ok_12_1x16(__riscv_ztt_f16_1x16_t old, __riscv_ztt_f16_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f16_1x16_t r = __riscv_ztt_mmulacc_ew_x_f16_1x16(old, s0, scalar);
}
void ok_13_1x8(__riscv_ztt_bf16_1x8_t old, __riscv_ztt_bf16_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x8_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x8(old, s0, scalar);
}
void ok_13_8x1(__riscv_ztt_bf16_8x1_t old, __riscv_ztt_bf16_8x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_8x1_t r = __riscv_ztt_mmulacc_ew_x_bf16_8x1(old, s0, scalar);
}
void ok_13_1x16(__riscv_ztt_bf16_1x16_t old, __riscv_ztt_bf16_1x16_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_bf16_1x16_t r = __riscv_ztt_mmulacc_ew_x_bf16_1x16(old, s0, scalar);
}
void ok_14_1x4(__riscv_ztt_f32_1x4_t old, __riscv_ztt_f32_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x4_t r = __riscv_ztt_mmulacc_ew_x_f32_1x4(old, s0, scalar);
}
void ok_14_4x1(__riscv_ztt_f32_4x1_t old, __riscv_ztt_f32_4x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_4x1_t r = __riscv_ztt_mmulacc_ew_x_f32_4x1(old, s0, scalar);
}
void ok_14_1x8(__riscv_ztt_f32_1x8_t old, __riscv_ztt_f32_1x8_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f32_1x8_t r = __riscv_ztt_mmulacc_ew_x_f32_1x8(old, s0, scalar);
}
void ok_15_1x2(__riscv_ztt_f64_1x2_t old, __riscv_ztt_f64_1x2_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mmulacc_ew_x_f64_1x2(old, s0, scalar);
}
void ok_15_2x1(__riscv_ztt_f64_2x1_t old, __riscv_ztt_f64_2x1_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mmulacc_ew_x_f64_2x1(old, s0, scalar);
}
void ok_15_1x4(__riscv_ztt_f64_1x4_t old, __riscv_ztt_f64_1x4_t s0, __riscv_ztt_i32_scalar_t scalar) {
  __riscv_ztt_f64_1x4_t r = __riscv_ztt_mmulacc_ew_x_f64_1x4(old, s0, scalar);
}
#endif
#if UDS != 8
// expected-no-diagnostics
#endif

#if UDS == 8
void invalid_operands(void) {
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t a0 = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_scalar_t scalar = 1;
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x4_t wrong_shape = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_u32_1x1_t other_type = __riscv_ztt_mzero_m_u32_1x1();
  __riscv_ztt_f32_1x1_t fp = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_1x1_t integer = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mmulacc_ew_x_i32_1x1(old, acc, scalar); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mmulacc_ew_x_i32_1x1(old, wrong_shape, scalar); // expected-error {{RISC-V Ztt mmulacc.ew.x operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x1(other_type, a0, scalar); // expected-error {{RISC-V Ztt mmulacc.ew.x operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x1(old, a0, 1); // expected-error {{RISC-V Ztt mmulacc.ew.x operands violate the required datatype or shape constraints}}
}
#endif
#if UDS == 8
void boundary(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i32_1x2_t s0, __riscv_ztt_i32_scalar_t scalar, __riscv_ztt_i32_2x1_t col, __riscv_ztt_i32_1x1_t one, __riscv_ztt_f32_1x2_t fp, __riscv_ztt_i32_1x2_t integer, __riscv_ztt_u32_1x2_t uns, __riscv_ztt_i32_accx2_t acc, float f, int *p) {
  __riscv_ztt_mmulacc_ew_x_i32_1x2(col, s0, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(one, s0, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, col, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, one, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(fp, s0, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(uns, s0, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(acc, s0, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(1, s0, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0); // expected-error {{too few arguments}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, scalar, 1); // expected-error {{too many arguments}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, f); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, p); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, integer); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, acc); // expected-error {{operands violate the required datatype or shape constraints}}
}
#endif
#if UDS == 32
__riscv_ztt_i4_1x8_t mixed_0(__riscv_ztt_i4_1x8_t old, __riscv_ztt_i16_1x8_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_i4_1x8(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_u4_8x1_t mixed_1(__riscv_ztt_u4_8x1_t old, __riscv_ztt_i16_8x1_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_u4_8x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_i8_1x4_t mixed_2(__riscv_ztt_i8_1x4_t old, __riscv_ztt_i16_1x4_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_i8_1x4(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_u8_4x1_t mixed_3(__riscv_ztt_u8_4x1_t old, __riscv_ztt_i16_4x1_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_u8_4x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_i16_1x2_t mixed_4(__riscv_ztt_i16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_f32_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_i16_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_u16_2x1_t mixed_5(__riscv_ztt_u16_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_u16_2x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_i32_1x2_t mixed_6(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_i32_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_u32_2x1_t mixed_7(__riscv_ztt_u32_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_u32_2x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_i64_1x2_t mixed_8(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_i64_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_u64_2x1_t mixed_9(__riscv_ztt_u64_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_f32_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_u64_2x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_i128_1x2_t mixed_10(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_i128_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_u128_2x1_t mixed_11(__riscv_ztt_u128_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_u128_2x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_f16_1x2_t mixed_12(__riscv_ztt_f16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_f16_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_bf16_2x1_t mixed_13(__riscv_ztt_bf16_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_bf16_2x1(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_f32_1x2_t mixed_14(__riscv_ztt_f32_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_f32_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_f32_1x2(old, s0, scalar);
}
#endif
#if UDS == 32
__riscv_ztt_f64_2x1_t mixed_15(__riscv_ztt_f64_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmulacc_ew_x_f64_2x1(old, s0, scalar);
}
#endif
