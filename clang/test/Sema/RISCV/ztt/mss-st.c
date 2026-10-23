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
void ok_i8_1x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_1x2(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_2x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x2(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_2x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x2(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_2x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x2(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_2x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x2(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_2x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x2(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_2x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x2(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_2x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x2(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_2x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x2(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_2x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x2(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_2x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x2(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_2x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x2(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_2x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x2(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_2x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x2(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_2x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
#endif
#if UDS == 16
void ok_i8_1x2(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_2x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_1x4(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_4x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x2(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_2x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x4(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_4x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x2(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_2x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x2(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_2x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x2(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_2x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x2(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_2x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x2(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_2x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x2(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_2x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x2(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_2x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x2(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_2x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x2(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_2x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x2(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_2x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x2(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_2x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x2(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_2x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
#endif
#if UDS == 32
void ok_i8_1x4(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_4x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_1x8(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_8x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x4(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_4x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x8(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_8x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x2(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_2x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x4(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_4x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x2(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_2x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x4(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_4x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x2(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_2x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x2(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_2x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x2(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_2x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x2(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_2x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x2(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_2x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x2(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_2x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x2(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_2x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x4(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_4x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x2(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_2x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x4(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_4x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x2(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_2x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x2(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_2x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
#endif
#if UDS == 64
void ok_i8_1x8(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_8x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_1x16(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_16x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x8(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_8x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x16(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_16x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x4(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_4x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x8(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_8x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x4(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_4x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x8(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_8x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x2(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_2x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x4(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_4x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x2(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_2x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x4(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_4x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x2(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_2x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x2(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_2x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x2(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_2x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x2(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_2x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x4(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_4x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x8(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_8x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x4(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_4x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x8(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_8x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x2(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_2x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x4(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_4x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x2(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_2x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
#endif
#if UDS == 128
void ok_i8_1x16(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_16x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_1x32(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x32_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i8_32x1(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_32x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x16(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_16x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_1x32(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_1x32_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u8_32x1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_32x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x8(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_8x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_1x16(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i16_16x1(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x8(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_8x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_1x16(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u16_16x1(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x4(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_4x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_1x8(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i32_8x1(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x4(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_4x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_1x8(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u32_8x1(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x2(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_2x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_1x4(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i64_4x1(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x2(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_2x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_1x4(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u64_4x1(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_1x2(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_i128_2x1(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_1x2(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_u128_2x1(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x8(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_8x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_1x16(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f16_16x1(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x8(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_8x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_1x16(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_1x16_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_bf16_16x1(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_16x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x4(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_4x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_1x8(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x8_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f32_8x1(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_8x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x2(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x2_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_2x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_2x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_1x4(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_1x4_t src) { __riscv_ztt_mss_st(base, stride, src); }
void ok_f64_4x1(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_4x1_t src) { __riscv_ztt_mss_st(base, stride, src); }
#endif
#if UDS != 8
// expected-no-diagnostics
#endif
#if UDS == 8
void invalid(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src, const int *c, volatile int *v, void *p, unsigned int *u, short *h, char *ch, __riscv_ztt_i32_scalar_t zs, __riscv_ztt_i32_accx1_t acc) {
  __riscv_ztt_mss_st(p, stride, src); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mss_st(u, stride, src); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mss_st(h, stride, src); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mss_st(ch, stride, src); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mss_st(1, stride, src); // expected-error {{must be a pointer}}
  __riscv_ztt_mss_st(v, stride, src); // expected-error {{has invalid qualifiers}}
  __riscv_ztt_mss_st(c, stride, src); // expected-error {{has invalid qualifiers}}
  __riscv_ztt_mss_st(base, 1.5, src); // expected-error {{must have integer type}}
  __riscv_ztt_mss_st(base, p, src); // expected-error {{must have integer type}}
  __riscv_ztt_mss_st(base, zs, src); // expected-error {{must have integer type}}
  __riscv_ztt_mss_st(base, src, src); // expected-error {{must have integer type}}
  __riscv_ztt_mss_st(base, acc, src); // expected-error {{must have integer type}}
  __riscv_ztt_mss_st(base, stride, acc); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mss_st(base, stride, 1); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mss_st(base, stride, zs); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mss_st(base, 0, src);
  __riscv_ztt_mss_st(base, 1, src);
  __riscv_ztt_mss_st(base, -1, src);
  __riscv_ztt_mss_st(base, 4294967297ULL, src);
  __riscv_ztt_mss_st(base); // expected-error {{too few arguments}}
  __riscv_ztt_mss_st(base, stride, src, 1); // expected-error {{too many arguments}}
}
void subbyte(_BitInt(4) *p, unsigned _BitInt(4) *q, __riscv_ztt_i4_1x2_t a, __riscv_ztt_u4_2x1_t b) {
  __riscv_ztt_mss_st(p, 1, a); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_st(q, 1, b); // expected-error {{sub-byte datatypes have no public C element carrier}}
}
#endif
#if UDS == 8
void c_identity(long *l, long long *ll, signed char *sc, char *ch, __riscv_ztt_i32_1x1_t i32, __riscv_ztt_i64_1x1_t i64, __riscv_ztt_i8_1x1_t i8) {
#if __riscv_xlen == 32
  __riscv_ztt_mss_st(l, 0, i32); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mss_st(ll, 1, i64);
#else
  __riscv_ztt_mss_st(l, 1, i64);
  __riscv_ztt_mss_st(ll, 0, i64); // expected-error {{does not match matrix element type}}
#endif
  __riscv_ztt_mss_st(sc, 1, i8);
  __riscv_ztt_mss_st(ch, 1, i8); // expected-error {{does not match matrix element type}}
}
#endif
