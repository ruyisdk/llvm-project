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

#if UDS == 32
// Call the public interface: lazy declarations are neither macros nor
// per-datatype builtins, so preprocessing queries cannot test result domains.
void invalid_result_domain(__riscv_ztt_f32_1x1_t src, __riscv_ztt_f32_scalar_t scalar) {
  (void)__riscv_ztt_mcmpge_ew_x_f32_1x1(src, scalar); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
void ok_0_1x2(__riscv_ztt_i4_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x2_t r = __riscv_ztt_mcmpge_ew_x_i4_1x2(a, b);
}
void ok_0_2x1(__riscv_ztt_i4_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_2x1_t r = __riscv_ztt_mcmpge_ew_x_i4_2x1(a, b);
}
void ok_0_1x4(__riscv_ztt_i4_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x4_t r = __riscv_ztt_mcmpge_ew_x_i4_1x4(a, b);
}
void ok_1_1x2(__riscv_ztt_u4_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x2_t r = __riscv_ztt_mcmpge_ew_x_u4_1x2(a, b);
}
void ok_1_2x1(__riscv_ztt_u4_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_2x1_t r = __riscv_ztt_mcmpge_ew_x_u4_2x1(a, b);
}
void ok_1_1x4(__riscv_ztt_u4_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x4_t r = __riscv_ztt_mcmpge_ew_x_u4_1x4(a, b);
}
void ok_2_1x1(__riscv_ztt_i8_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x1_t r = __riscv_ztt_mcmpge_ew_x_i8_1x1(a, b);
}
void ok_2_1x2(__riscv_ztt_i8_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x2_t r = __riscv_ztt_mcmpge_ew_x_i8_1x2(a, b);
}
void ok_3_1x1(__riscv_ztt_u8_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x1_t r = __riscv_ztt_mcmpge_ew_x_u8_1x1(a, b);
}
void ok_3_1x2(__riscv_ztt_u8_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x2_t r = __riscv_ztt_mcmpge_ew_x_u8_1x2(a, b);
}
void ok_4_1x1(__riscv_ztt_i16_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mcmpge_ew_x_i16_1x1(a, b);
}
void ok_4_1x2(__riscv_ztt_i16_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mcmpge_ew_x_i16_1x2(a, b);
}
void ok_5_1x1(__riscv_ztt_u16_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mcmpge_ew_x_u16_1x1(a, b);
}
void ok_5_1x2(__riscv_ztt_u16_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mcmpge_ew_x_u16_1x2(a, b);
}
void ok_6_1x1(__riscv_ztt_i32_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mcmpge_ew_x_i32_1x1(a, b);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mcmpge_ew_x_i32_1x2(a, b);
}
void ok_7_1x1(__riscv_ztt_u32_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mcmpge_ew_x_u32_1x1(a, b);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mcmpge_ew_x_u32_1x2(a, b);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcmpge_ew_x_i64_1x1(a, b);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mcmpge_ew_x_i64_1x2(a, b);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcmpge_ew_x_u64_1x1(a, b);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mcmpge_ew_x_u64_1x2(a, b);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcmpge_ew_x_i128_1x1(a, b);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mcmpge_ew_x_i128_1x2(a, b);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcmpge_ew_x_u128_1x1(a, b);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mcmpge_ew_x_u128_1x2(a, b);
}
#endif
#if UDS == 16
void ok_0_1x4(__riscv_ztt_i4_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x4_t r = __riscv_ztt_mcmpge_ew_x_i4_1x4(a, b);
}
void ok_0_4x1(__riscv_ztt_i4_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_4x1_t r = __riscv_ztt_mcmpge_ew_x_i4_4x1(a, b);
}
void ok_0_1x8(__riscv_ztt_i4_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x8_t r = __riscv_ztt_mcmpge_ew_x_i4_1x8(a, b);
}
void ok_1_1x4(__riscv_ztt_u4_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x4_t r = __riscv_ztt_mcmpge_ew_x_u4_1x4(a, b);
}
void ok_1_4x1(__riscv_ztt_u4_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_4x1_t r = __riscv_ztt_mcmpge_ew_x_u4_4x1(a, b);
}
void ok_1_1x8(__riscv_ztt_u4_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x8_t r = __riscv_ztt_mcmpge_ew_x_u4_1x8(a, b);
}
void ok_2_1x2(__riscv_ztt_i8_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x2_t r = __riscv_ztt_mcmpge_ew_x_i8_1x2(a, b);
}
void ok_2_2x1(__riscv_ztt_i8_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_2x1_t r = __riscv_ztt_mcmpge_ew_x_i8_2x1(a, b);
}
void ok_2_1x4(__riscv_ztt_i8_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x4_t r = __riscv_ztt_mcmpge_ew_x_i8_1x4(a, b);
}
void ok_3_1x2(__riscv_ztt_u8_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x2_t r = __riscv_ztt_mcmpge_ew_x_u8_1x2(a, b);
}
void ok_3_2x1(__riscv_ztt_u8_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_2x1_t r = __riscv_ztt_mcmpge_ew_x_u8_2x1(a, b);
}
void ok_3_1x4(__riscv_ztt_u8_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x4_t r = __riscv_ztt_mcmpge_ew_x_u8_1x4(a, b);
}
void ok_4_1x1(__riscv_ztt_i16_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mcmpge_ew_x_i16_1x1(a, b);
}
void ok_4_1x2(__riscv_ztt_i16_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mcmpge_ew_x_i16_1x2(a, b);
}
void ok_5_1x1(__riscv_ztt_u16_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mcmpge_ew_x_u16_1x1(a, b);
}
void ok_5_1x2(__riscv_ztt_u16_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mcmpge_ew_x_u16_1x2(a, b);
}
void ok_6_1x1(__riscv_ztt_i32_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mcmpge_ew_x_i32_1x1(a, b);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mcmpge_ew_x_i32_1x2(a, b);
}
void ok_7_1x1(__riscv_ztt_u32_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mcmpge_ew_x_u32_1x1(a, b);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mcmpge_ew_x_u32_1x2(a, b);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcmpge_ew_x_i64_1x1(a, b);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mcmpge_ew_x_i64_1x2(a, b);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcmpge_ew_x_u64_1x1(a, b);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mcmpge_ew_x_u64_1x2(a, b);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcmpge_ew_x_i128_1x1(a, b);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mcmpge_ew_x_i128_1x2(a, b);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcmpge_ew_x_u128_1x1(a, b);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mcmpge_ew_x_u128_1x2(a, b);
}
#endif
#if UDS == 32
void ok_0_1x8(__riscv_ztt_i4_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x8_t r = __riscv_ztt_mcmpge_ew_x_i4_1x8(a, b);
}
void ok_0_8x1(__riscv_ztt_i4_8x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_8x1_t r = __riscv_ztt_mcmpge_ew_x_i4_8x1(a, b);
}
void ok_0_1x16(__riscv_ztt_i4_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x16_t r = __riscv_ztt_mcmpge_ew_x_i4_1x16(a, b);
}
void ok_1_1x8(__riscv_ztt_u4_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x8_t r = __riscv_ztt_mcmpge_ew_x_u4_1x8(a, b);
}
void ok_1_8x1(__riscv_ztt_u4_8x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_8x1_t r = __riscv_ztt_mcmpge_ew_x_u4_8x1(a, b);
}
void ok_1_1x16(__riscv_ztt_u4_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x16_t r = __riscv_ztt_mcmpge_ew_x_u4_1x16(a, b);
}
void ok_2_1x4(__riscv_ztt_i8_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x4_t r = __riscv_ztt_mcmpge_ew_x_i8_1x4(a, b);
}
void ok_2_4x1(__riscv_ztt_i8_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_4x1_t r = __riscv_ztt_mcmpge_ew_x_i8_4x1(a, b);
}
void ok_2_1x8(__riscv_ztt_i8_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x8_t r = __riscv_ztt_mcmpge_ew_x_i8_1x8(a, b);
}
void ok_3_1x4(__riscv_ztt_u8_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x4_t r = __riscv_ztt_mcmpge_ew_x_u8_1x4(a, b);
}
void ok_3_4x1(__riscv_ztt_u8_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_4x1_t r = __riscv_ztt_mcmpge_ew_x_u8_4x1(a, b);
}
void ok_3_1x8(__riscv_ztt_u8_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x8_t r = __riscv_ztt_mcmpge_ew_x_u8_1x8(a, b);
}
void ok_4_1x2(__riscv_ztt_i16_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x2_t r = __riscv_ztt_mcmpge_ew_x_i16_1x2(a, b);
}
void ok_4_2x1(__riscv_ztt_i16_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_2x1_t r = __riscv_ztt_mcmpge_ew_x_i16_2x1(a, b);
}
void ok_4_1x4(__riscv_ztt_i16_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x4_t r = __riscv_ztt_mcmpge_ew_x_i16_1x4(a, b);
}
void ok_5_1x2(__riscv_ztt_u16_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x2_t r = __riscv_ztt_mcmpge_ew_x_u16_1x2(a, b);
}
void ok_5_2x1(__riscv_ztt_u16_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_2x1_t r = __riscv_ztt_mcmpge_ew_x_u16_2x1(a, b);
}
void ok_5_1x4(__riscv_ztt_u16_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x4_t r = __riscv_ztt_mcmpge_ew_x_u16_1x4(a, b);
}
void ok_6_1x1(__riscv_ztt_i32_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mcmpge_ew_x_i32_1x1(a, b);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mcmpge_ew_x_i32_1x2(a, b);
}
void ok_7_1x1(__riscv_ztt_u32_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mcmpge_ew_x_u32_1x1(a, b);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mcmpge_ew_x_u32_1x2(a, b);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcmpge_ew_x_i64_1x1(a, b);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mcmpge_ew_x_i64_1x2(a, b);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcmpge_ew_x_u64_1x1(a, b);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mcmpge_ew_x_u64_1x2(a, b);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcmpge_ew_x_i128_1x1(a, b);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mcmpge_ew_x_i128_1x2(a, b);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcmpge_ew_x_u128_1x1(a, b);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mcmpge_ew_x_u128_1x2(a, b);
}
#endif
#if UDS == 64
void ok_0_1x16(__riscv_ztt_i4_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x16_t r = __riscv_ztt_mcmpge_ew_x_i4_1x16(a, b);
}
void ok_0_16x1(__riscv_ztt_i4_16x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_16x1_t r = __riscv_ztt_mcmpge_ew_x_i4_16x1(a, b);
}
void ok_0_1x32(__riscv_ztt_i4_1x32_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x32_t r = __riscv_ztt_mcmpge_ew_x_i4_1x32(a, b);
}
void ok_1_1x16(__riscv_ztt_u4_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x16_t r = __riscv_ztt_mcmpge_ew_x_u4_1x16(a, b);
}
void ok_1_16x1(__riscv_ztt_u4_16x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_16x1_t r = __riscv_ztt_mcmpge_ew_x_u4_16x1(a, b);
}
void ok_1_1x32(__riscv_ztt_u4_1x32_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x32_t r = __riscv_ztt_mcmpge_ew_x_u4_1x32(a, b);
}
void ok_2_1x8(__riscv_ztt_i8_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x8_t r = __riscv_ztt_mcmpge_ew_x_i8_1x8(a, b);
}
void ok_2_8x1(__riscv_ztt_i8_8x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_8x1_t r = __riscv_ztt_mcmpge_ew_x_i8_8x1(a, b);
}
void ok_2_1x16(__riscv_ztt_i8_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x16_t r = __riscv_ztt_mcmpge_ew_x_i8_1x16(a, b);
}
void ok_3_1x8(__riscv_ztt_u8_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x8_t r = __riscv_ztt_mcmpge_ew_x_u8_1x8(a, b);
}
void ok_3_8x1(__riscv_ztt_u8_8x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_8x1_t r = __riscv_ztt_mcmpge_ew_x_u8_8x1(a, b);
}
void ok_3_1x16(__riscv_ztt_u8_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x16_t r = __riscv_ztt_mcmpge_ew_x_u8_1x16(a, b);
}
void ok_4_1x4(__riscv_ztt_i16_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x4_t r = __riscv_ztt_mcmpge_ew_x_i16_1x4(a, b);
}
void ok_4_4x1(__riscv_ztt_i16_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_4x1_t r = __riscv_ztt_mcmpge_ew_x_i16_4x1(a, b);
}
void ok_4_1x8(__riscv_ztt_i16_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x8_t r = __riscv_ztt_mcmpge_ew_x_i16_1x8(a, b);
}
void ok_5_1x4(__riscv_ztt_u16_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x4_t r = __riscv_ztt_mcmpge_ew_x_u16_1x4(a, b);
}
void ok_5_4x1(__riscv_ztt_u16_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_4x1_t r = __riscv_ztt_mcmpge_ew_x_u16_4x1(a, b);
}
void ok_5_1x8(__riscv_ztt_u16_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x8_t r = __riscv_ztt_mcmpge_ew_x_u16_1x8(a, b);
}
void ok_6_1x2(__riscv_ztt_i32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x2_t r = __riscv_ztt_mcmpge_ew_x_i32_1x2(a, b);
}
void ok_6_2x1(__riscv_ztt_i32_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_2x1_t r = __riscv_ztt_mcmpge_ew_x_i32_2x1(a, b);
}
void ok_6_1x4(__riscv_ztt_i32_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x4_t r = __riscv_ztt_mcmpge_ew_x_i32_1x4(a, b);
}
void ok_7_1x2(__riscv_ztt_u32_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x2_t r = __riscv_ztt_mcmpge_ew_x_u32_1x2(a, b);
}
void ok_7_2x1(__riscv_ztt_u32_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_2x1_t r = __riscv_ztt_mcmpge_ew_x_u32_2x1(a, b);
}
void ok_7_1x4(__riscv_ztt_u32_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x4_t r = __riscv_ztt_mcmpge_ew_x_u32_1x4(a, b);
}
void ok_8_1x1(__riscv_ztt_i64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcmpge_ew_x_i64_1x1(a, b);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mcmpge_ew_x_i64_1x2(a, b);
}
void ok_9_1x1(__riscv_ztt_u64_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcmpge_ew_x_u64_1x1(a, b);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mcmpge_ew_x_u64_1x2(a, b);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcmpge_ew_x_i128_1x1(a, b);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mcmpge_ew_x_i128_1x2(a, b);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcmpge_ew_x_u128_1x1(a, b);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mcmpge_ew_x_u128_1x2(a, b);
}
#endif
#if UDS == 128
void ok_0_1x32(__riscv_ztt_i4_1x32_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_1x32_t r = __riscv_ztt_mcmpge_ew_x_i4_1x32(a, b);
}
void ok_0_32x1(__riscv_ztt_i4_32x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i4_32x1_t r = __riscv_ztt_mcmpge_ew_x_i4_32x1(a, b);
}
void ok_1_1x32(__riscv_ztt_u4_1x32_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_1x32_t r = __riscv_ztt_mcmpge_ew_x_u4_1x32(a, b);
}
void ok_1_32x1(__riscv_ztt_u4_32x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u4_32x1_t r = __riscv_ztt_mcmpge_ew_x_u4_32x1(a, b);
}
void ok_2_1x16(__riscv_ztt_i8_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x16_t r = __riscv_ztt_mcmpge_ew_x_i8_1x16(a, b);
}
void ok_2_16x1(__riscv_ztt_i8_16x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_16x1_t r = __riscv_ztt_mcmpge_ew_x_i8_16x1(a, b);
}
void ok_2_1x32(__riscv_ztt_i8_1x32_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i8_1x32_t r = __riscv_ztt_mcmpge_ew_x_i8_1x32(a, b);
}
void ok_3_1x16(__riscv_ztt_u8_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x16_t r = __riscv_ztt_mcmpge_ew_x_u8_1x16(a, b);
}
void ok_3_16x1(__riscv_ztt_u8_16x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_16x1_t r = __riscv_ztt_mcmpge_ew_x_u8_16x1(a, b);
}
void ok_3_1x32(__riscv_ztt_u8_1x32_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u8_1x32_t r = __riscv_ztt_mcmpge_ew_x_u8_1x32(a, b);
}
void ok_4_1x8(__riscv_ztt_i16_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x8_t r = __riscv_ztt_mcmpge_ew_x_i16_1x8(a, b);
}
void ok_4_8x1(__riscv_ztt_i16_8x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_8x1_t r = __riscv_ztt_mcmpge_ew_x_i16_8x1(a, b);
}
void ok_4_1x16(__riscv_ztt_i16_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i16_1x16_t r = __riscv_ztt_mcmpge_ew_x_i16_1x16(a, b);
}
void ok_5_1x8(__riscv_ztt_u16_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x8_t r = __riscv_ztt_mcmpge_ew_x_u16_1x8(a, b);
}
void ok_5_8x1(__riscv_ztt_u16_8x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_8x1_t r = __riscv_ztt_mcmpge_ew_x_u16_8x1(a, b);
}
void ok_5_1x16(__riscv_ztt_u16_1x16_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u16_1x16_t r = __riscv_ztt_mcmpge_ew_x_u16_1x16(a, b);
}
void ok_6_1x4(__riscv_ztt_i32_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x4_t r = __riscv_ztt_mcmpge_ew_x_i32_1x4(a, b);
}
void ok_6_4x1(__riscv_ztt_i32_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_4x1_t r = __riscv_ztt_mcmpge_ew_x_i32_4x1(a, b);
}
void ok_6_1x8(__riscv_ztt_i32_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i32_1x8_t r = __riscv_ztt_mcmpge_ew_x_i32_1x8(a, b);
}
void ok_7_1x4(__riscv_ztt_u32_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x4_t r = __riscv_ztt_mcmpge_ew_x_u32_1x4(a, b);
}
void ok_7_4x1(__riscv_ztt_u32_4x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_4x1_t r = __riscv_ztt_mcmpge_ew_x_u32_4x1(a, b);
}
void ok_7_1x8(__riscv_ztt_u32_1x8_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u32_1x8_t r = __riscv_ztt_mcmpge_ew_x_u32_1x8(a, b);
}
void ok_8_1x2(__riscv_ztt_i64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x2_t r = __riscv_ztt_mcmpge_ew_x_i64_1x2(a, b);
}
void ok_8_2x1(__riscv_ztt_i64_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_2x1_t r = __riscv_ztt_mcmpge_ew_x_i64_2x1(a, b);
}
void ok_8_1x4(__riscv_ztt_i64_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i64_1x4_t r = __riscv_ztt_mcmpge_ew_x_i64_1x4(a, b);
}
void ok_9_1x2(__riscv_ztt_u64_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x2_t r = __riscv_ztt_mcmpge_ew_x_u64_1x2(a, b);
}
void ok_9_2x1(__riscv_ztt_u64_2x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_2x1_t r = __riscv_ztt_mcmpge_ew_x_u64_2x1(a, b);
}
void ok_9_1x4(__riscv_ztt_u64_1x4_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u64_1x4_t r = __riscv_ztt_mcmpge_ew_x_u64_1x4(a, b);
}
void ok_10_1x1(__riscv_ztt_i128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcmpge_ew_x_i128_1x1(a, b);
}
void ok_10_1x2(__riscv_ztt_i128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_i128_1x2_t r = __riscv_ztt_mcmpge_ew_x_i128_1x2(a, b);
}
void ok_11_1x1(__riscv_ztt_u128_1x1_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcmpge_ew_x_u128_1x1(a, b);
}
void ok_11_1x2(__riscv_ztt_u128_1x2_t a, __riscv_ztt_f32_scalar_t b) {
  __riscv_ztt_u128_1x2_t r = __riscv_ztt_mcmpge_ew_x_u128_1x2(a, b);
}
#endif
#if UDS == 32
void bad(__riscv_ztt_i32_1x2_t a, __riscv_ztt_i32_2x1_t col, __riscv_ztt_i32_1x1_t one, __riscv_ztt_i32_accx2_t acc, __riscv_ztt_f32_scalar_t zs, int ordinary, float f, int *p) {
  __riscv_ztt_mcmpge_ew_x_i32_1x2(col, zs); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(one, zs); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(acc, zs); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(ordinary, zs); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(zs, zs); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, ordinary); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, 1); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, f); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, p); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, a); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, acc); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a); // expected-error {{too few arguments}}
  __riscv_ztt_mcmpge_ew_x_i32_1x2(a, zs, zs); // expected-error {{too many arguments}}
}
void numeric_i4_i8(__riscv_ztt_i4_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i4_u32(__riscv_ztt_i4_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i4_f16(__riscv_ztt_i4_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i4_bf16(__riscv_ztt_i4_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i4_f32(__riscv_ztt_i4_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u4_i8(__riscv_ztt_u4_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u4_u32(__riscv_ztt_u4_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u4_f16(__riscv_ztt_u4_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u4_bf16(__riscv_ztt_u4_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u4_f32(__riscv_ztt_u4_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i8_i8(__riscv_ztt_i8_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i8_u32(__riscv_ztt_i8_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i8_f16(__riscv_ztt_i8_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i8_bf16(__riscv_ztt_i8_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i8_f32(__riscv_ztt_i8_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u8_i8(__riscv_ztt_u8_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u8_u32(__riscv_ztt_u8_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u8_f16(__riscv_ztt_u8_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u8_bf16(__riscv_ztt_u8_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u8_f32(__riscv_ztt_u8_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i16_i8(__riscv_ztt_i16_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i16_u32(__riscv_ztt_i16_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i16_f16(__riscv_ztt_i16_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i16_bf16(__riscv_ztt_i16_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i16_f32(__riscv_ztt_i16_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u16_i8(__riscv_ztt_u16_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u16_u32(__riscv_ztt_u16_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u16_f16(__riscv_ztt_u16_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u16_bf16(__riscv_ztt_u16_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u16_f32(__riscv_ztt_u16_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i32_i8(__riscv_ztt_i32_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i32_u32(__riscv_ztt_i32_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i32_f16(__riscv_ztt_i32_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i32_bf16(__riscv_ztt_i32_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i32_f32(__riscv_ztt_i32_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u32_i8(__riscv_ztt_u32_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u32_u32(__riscv_ztt_u32_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u32_f16(__riscv_ztt_u32_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u32_bf16(__riscv_ztt_u32_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u32_f32(__riscv_ztt_u32_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i64_i8(__riscv_ztt_i64_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i64_u32(__riscv_ztt_i64_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i64_f16(__riscv_ztt_i64_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i64_bf16(__riscv_ztt_i64_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i64_f32(__riscv_ztt_i64_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u64_i8(__riscv_ztt_u64_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u64_u32(__riscv_ztt_u64_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u64_f16(__riscv_ztt_u64_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u64_bf16(__riscv_ztt_u64_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u64_f32(__riscv_ztt_u64_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i128_i8(__riscv_ztt_i128_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i128_u32(__riscv_ztt_i128_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i128_f16(__riscv_ztt_i128_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i128_bf16(__riscv_ztt_i128_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_i128_f32(__riscv_ztt_i128_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u128_i8(__riscv_ztt_u128_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u128_u32(__riscv_ztt_u128_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u128_f16(__riscv_ztt_u128_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u128_bf16(__riscv_ztt_u128_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_u128_f32(__riscv_ztt_u128_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f16_i8(__riscv_ztt_f16_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f16_u32(__riscv_ztt_f16_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f16_f16(__riscv_ztt_f16_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f16_bf16(__riscv_ztt_f16_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f16_f32(__riscv_ztt_f16_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_bf16_i8(__riscv_ztt_bf16_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_bf16_u32(__riscv_ztt_bf16_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_bf16_f16(__riscv_ztt_bf16_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_bf16_bf16(__riscv_ztt_bf16_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_bf16_f32(__riscv_ztt_bf16_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f32_i8(__riscv_ztt_f32_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f32_u32(__riscv_ztt_f32_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f32_f16(__riscv_ztt_f32_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f32_bf16(__riscv_ztt_f32_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f32_f32(__riscv_ztt_f32_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f64_i8(__riscv_ztt_f64_1x8_t a, __riscv_ztt_i8_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f64_u32(__riscv_ztt_f64_1x8_t a, __riscv_ztt_u32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f64_f16(__riscv_ztt_f64_1x8_t a, __riscv_ztt_f16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f64_bf16(__riscv_ztt_f64_1x8_t a, __riscv_ztt_bf16_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
void numeric_f64_f32(__riscv_ztt_f64_1x8_t a, __riscv_ztt_f32_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_u32_1x8(a, s);
}
#if __riscv_xlen == 64
void scalar_i64(__riscv_ztt_f32_1x2_t a, __riscv_ztt_i64_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_i16_1x2(a, s);
}
void scalar_u64(__riscv_ztt_f32_1x2_t a, __riscv_ztt_u64_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_i16_1x2(a, s);
}
void scalar_f64(__riscv_ztt_f32_1x2_t a, __riscv_ztt_f64_scalar_t s) {
  __riscv_ztt_mcmpge_ew_x_i16_1x2(a, s);
}
#endif
#else
// expected-no-diagnostics
#endif

// Forbidden result datatypes must not expose aliases or builtins.
