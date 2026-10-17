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
__riscv_ztt_i8_1x1_t ok_i8_1x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x1(base, stride); }
__riscv_ztt_i8_1x2_t ok_i8_1x2(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x2(base, stride); }
__riscv_ztt_i8_2x1_t ok_i8_2x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_2x1(base, stride); }
__riscv_ztt_u8_1x1_t ok_u8_1x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x1(base, stride); }
__riscv_ztt_u8_1x2_t ok_u8_1x2(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x2(base, stride); }
__riscv_ztt_u8_2x1_t ok_u8_2x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_2x1(base, stride); }
__riscv_ztt_i16_1x1_t ok_i16_1x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x1(base, stride); }
__riscv_ztt_i16_1x2_t ok_i16_1x2(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x2(base, stride); }
__riscv_ztt_i16_2x1_t ok_i16_2x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_2x1(base, stride); }
__riscv_ztt_u16_1x1_t ok_u16_1x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x1(base, stride); }
__riscv_ztt_u16_1x2_t ok_u16_1x2(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x2(base, stride); }
__riscv_ztt_u16_2x1_t ok_u16_2x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_2x1(base, stride); }
__riscv_ztt_i32_1x1_t ok_i32_1x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, stride); }
__riscv_ztt_i32_1x2_t ok_i32_1x2(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x2(base, stride); }
__riscv_ztt_i32_2x1_t ok_i32_2x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_2x1(base, stride); }
__riscv_ztt_u32_1x1_t ok_u32_1x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x1(base, stride); }
__riscv_ztt_u32_1x2_t ok_u32_1x2(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x2(base, stride); }
__riscv_ztt_u32_2x1_t ok_u32_2x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_2x1(base, stride); }
__riscv_ztt_i64_1x1_t ok_i64_1x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x1(base, stride); }
__riscv_ztt_i64_1x2_t ok_i64_1x2(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x2(base, stride); }
__riscv_ztt_i64_2x1_t ok_i64_2x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_2x1(base, stride); }
__riscv_ztt_u64_1x1_t ok_u64_1x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x1(base, stride); }
__riscv_ztt_u64_1x2_t ok_u64_1x2(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x2(base, stride); }
__riscv_ztt_u64_2x1_t ok_u64_2x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_2x1(base, stride); }
__riscv_ztt_i128_1x1_t ok_i128_1x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x1(base, stride); }
__riscv_ztt_i128_1x2_t ok_i128_1x2(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x2(base, stride); }
__riscv_ztt_i128_2x1_t ok_i128_2x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_2x1(base, stride); }
__riscv_ztt_u128_1x1_t ok_u128_1x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x1(base, stride); }
__riscv_ztt_u128_1x2_t ok_u128_1x2(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x2(base, stride); }
__riscv_ztt_u128_2x1_t ok_u128_2x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_2x1(base, stride); }
__riscv_ztt_f16_1x1_t ok_f16_1x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x1(base, stride); }
__riscv_ztt_f16_1x2_t ok_f16_1x2(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x2(base, stride); }
__riscv_ztt_f16_2x1_t ok_f16_2x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_2x1(base, stride); }
__riscv_ztt_bf16_1x1_t ok_bf16_1x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x1(base, stride); }
__riscv_ztt_bf16_1x2_t ok_bf16_1x2(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x2(base, stride); }
__riscv_ztt_bf16_2x1_t ok_bf16_2x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_2x1(base, stride); }
__riscv_ztt_f32_1x1_t ok_f32_1x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x1(base, stride); }
__riscv_ztt_f32_1x2_t ok_f32_1x2(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x2(base, stride); }
__riscv_ztt_f32_2x1_t ok_f32_2x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_2x1(base, stride); }
__riscv_ztt_f64_1x1_t ok_f64_1x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x1(base, stride); }
__riscv_ztt_f64_1x2_t ok_f64_1x2(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x2(base, stride); }
__riscv_ztt_f64_2x1_t ok_f64_2x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_2x1(base, stride); }
#endif
#if UDS == 16
__riscv_ztt_i8_1x2_t ok_i8_1x2(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x2(base, stride); }
__riscv_ztt_i8_2x1_t ok_i8_2x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_2x1(base, stride); }
__riscv_ztt_i8_1x4_t ok_i8_1x4(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x4(base, stride); }
__riscv_ztt_i8_4x1_t ok_i8_4x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_4x1(base, stride); }
__riscv_ztt_u8_1x2_t ok_u8_1x2(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x2(base, stride); }
__riscv_ztt_u8_2x1_t ok_u8_2x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_2x1(base, stride); }
__riscv_ztt_u8_1x4_t ok_u8_1x4(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x4(base, stride); }
__riscv_ztt_u8_4x1_t ok_u8_4x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_4x1(base, stride); }
__riscv_ztt_i16_1x1_t ok_i16_1x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x1(base, stride); }
__riscv_ztt_i16_1x2_t ok_i16_1x2(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x2(base, stride); }
__riscv_ztt_i16_2x1_t ok_i16_2x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_2x1(base, stride); }
__riscv_ztt_u16_1x1_t ok_u16_1x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x1(base, stride); }
__riscv_ztt_u16_1x2_t ok_u16_1x2(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x2(base, stride); }
__riscv_ztt_u16_2x1_t ok_u16_2x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_2x1(base, stride); }
__riscv_ztt_i32_1x1_t ok_i32_1x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, stride); }
__riscv_ztt_i32_1x2_t ok_i32_1x2(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x2(base, stride); }
__riscv_ztt_i32_2x1_t ok_i32_2x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_2x1(base, stride); }
__riscv_ztt_u32_1x1_t ok_u32_1x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x1(base, stride); }
__riscv_ztt_u32_1x2_t ok_u32_1x2(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x2(base, stride); }
__riscv_ztt_u32_2x1_t ok_u32_2x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_2x1(base, stride); }
__riscv_ztt_i64_1x1_t ok_i64_1x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x1(base, stride); }
__riscv_ztt_i64_1x2_t ok_i64_1x2(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x2(base, stride); }
__riscv_ztt_i64_2x1_t ok_i64_2x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_2x1(base, stride); }
__riscv_ztt_u64_1x1_t ok_u64_1x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x1(base, stride); }
__riscv_ztt_u64_1x2_t ok_u64_1x2(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x2(base, stride); }
__riscv_ztt_u64_2x1_t ok_u64_2x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_2x1(base, stride); }
__riscv_ztt_i128_1x1_t ok_i128_1x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x1(base, stride); }
__riscv_ztt_i128_1x2_t ok_i128_1x2(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x2(base, stride); }
__riscv_ztt_i128_2x1_t ok_i128_2x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_2x1(base, stride); }
__riscv_ztt_u128_1x1_t ok_u128_1x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x1(base, stride); }
__riscv_ztt_u128_1x2_t ok_u128_1x2(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x2(base, stride); }
__riscv_ztt_u128_2x1_t ok_u128_2x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_2x1(base, stride); }
__riscv_ztt_f16_1x1_t ok_f16_1x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x1(base, stride); }
__riscv_ztt_f16_1x2_t ok_f16_1x2(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x2(base, stride); }
__riscv_ztt_f16_2x1_t ok_f16_2x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_2x1(base, stride); }
__riscv_ztt_bf16_1x1_t ok_bf16_1x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x1(base, stride); }
__riscv_ztt_bf16_1x2_t ok_bf16_1x2(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x2(base, stride); }
__riscv_ztt_bf16_2x1_t ok_bf16_2x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_2x1(base, stride); }
__riscv_ztt_f32_1x1_t ok_f32_1x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x1(base, stride); }
__riscv_ztt_f32_1x2_t ok_f32_1x2(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x2(base, stride); }
__riscv_ztt_f32_2x1_t ok_f32_2x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_2x1(base, stride); }
__riscv_ztt_f64_1x1_t ok_f64_1x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x1(base, stride); }
__riscv_ztt_f64_1x2_t ok_f64_1x2(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x2(base, stride); }
__riscv_ztt_f64_2x1_t ok_f64_2x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_2x1(base, stride); }
#endif
#if UDS == 32
__riscv_ztt_i8_1x4_t ok_i8_1x4(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x4(base, stride); }
__riscv_ztt_i8_4x1_t ok_i8_4x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_4x1(base, stride); }
__riscv_ztt_i8_1x8_t ok_i8_1x8(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x8(base, stride); }
__riscv_ztt_i8_8x1_t ok_i8_8x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_8x1(base, stride); }
__riscv_ztt_u8_1x4_t ok_u8_1x4(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x4(base, stride); }
__riscv_ztt_u8_4x1_t ok_u8_4x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_4x1(base, stride); }
__riscv_ztt_u8_1x8_t ok_u8_1x8(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x8(base, stride); }
__riscv_ztt_u8_8x1_t ok_u8_8x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_8x1(base, stride); }
__riscv_ztt_i16_1x2_t ok_i16_1x2(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x2(base, stride); }
__riscv_ztt_i16_2x1_t ok_i16_2x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_2x1(base, stride); }
__riscv_ztt_i16_1x4_t ok_i16_1x4(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x4(base, stride); }
__riscv_ztt_i16_4x1_t ok_i16_4x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_4x1(base, stride); }
__riscv_ztt_u16_1x2_t ok_u16_1x2(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x2(base, stride); }
__riscv_ztt_u16_2x1_t ok_u16_2x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_2x1(base, stride); }
__riscv_ztt_u16_1x4_t ok_u16_1x4(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x4(base, stride); }
__riscv_ztt_u16_4x1_t ok_u16_4x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_4x1(base, stride); }
__riscv_ztt_i32_1x1_t ok_i32_1x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, stride); }
__riscv_ztt_i32_1x2_t ok_i32_1x2(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x2(base, stride); }
__riscv_ztt_i32_2x1_t ok_i32_2x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_2x1(base, stride); }
__riscv_ztt_u32_1x1_t ok_u32_1x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x1(base, stride); }
__riscv_ztt_u32_1x2_t ok_u32_1x2(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x2(base, stride); }
__riscv_ztt_u32_2x1_t ok_u32_2x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_2x1(base, stride); }
__riscv_ztt_i64_1x1_t ok_i64_1x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x1(base, stride); }
__riscv_ztt_i64_1x2_t ok_i64_1x2(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x2(base, stride); }
__riscv_ztt_i64_2x1_t ok_i64_2x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_2x1(base, stride); }
__riscv_ztt_u64_1x1_t ok_u64_1x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x1(base, stride); }
__riscv_ztt_u64_1x2_t ok_u64_1x2(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x2(base, stride); }
__riscv_ztt_u64_2x1_t ok_u64_2x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_2x1(base, stride); }
__riscv_ztt_i128_1x1_t ok_i128_1x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x1(base, stride); }
__riscv_ztt_i128_1x2_t ok_i128_1x2(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x2(base, stride); }
__riscv_ztt_i128_2x1_t ok_i128_2x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_2x1(base, stride); }
__riscv_ztt_u128_1x1_t ok_u128_1x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x1(base, stride); }
__riscv_ztt_u128_1x2_t ok_u128_1x2(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x2(base, stride); }
__riscv_ztt_u128_2x1_t ok_u128_2x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_2x1(base, stride); }
__riscv_ztt_f16_1x2_t ok_f16_1x2(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x2(base, stride); }
__riscv_ztt_f16_2x1_t ok_f16_2x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_2x1(base, stride); }
__riscv_ztt_f16_1x4_t ok_f16_1x4(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x4(base, stride); }
__riscv_ztt_f16_4x1_t ok_f16_4x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_4x1(base, stride); }
__riscv_ztt_bf16_1x2_t ok_bf16_1x2(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x2(base, stride); }
__riscv_ztt_bf16_2x1_t ok_bf16_2x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_2x1(base, stride); }
__riscv_ztt_bf16_1x4_t ok_bf16_1x4(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x4(base, stride); }
__riscv_ztt_bf16_4x1_t ok_bf16_4x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_4x1(base, stride); }
__riscv_ztt_f32_1x1_t ok_f32_1x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x1(base, stride); }
__riscv_ztt_f32_1x2_t ok_f32_1x2(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x2(base, stride); }
__riscv_ztt_f32_2x1_t ok_f32_2x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_2x1(base, stride); }
__riscv_ztt_f64_1x1_t ok_f64_1x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x1(base, stride); }
__riscv_ztt_f64_1x2_t ok_f64_1x2(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x2(base, stride); }
__riscv_ztt_f64_2x1_t ok_f64_2x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_2x1(base, stride); }
#endif
#if UDS == 64
__riscv_ztt_i8_1x8_t ok_i8_1x8(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x8(base, stride); }
__riscv_ztt_i8_8x1_t ok_i8_8x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_8x1(base, stride); }
__riscv_ztt_i8_1x16_t ok_i8_1x16(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x16(base, stride); }
__riscv_ztt_i8_16x1_t ok_i8_16x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_16x1(base, stride); }
__riscv_ztt_u8_1x8_t ok_u8_1x8(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x8(base, stride); }
__riscv_ztt_u8_8x1_t ok_u8_8x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_8x1(base, stride); }
__riscv_ztt_u8_1x16_t ok_u8_1x16(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x16(base, stride); }
__riscv_ztt_u8_16x1_t ok_u8_16x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_16x1(base, stride); }
__riscv_ztt_i16_1x4_t ok_i16_1x4(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x4(base, stride); }
__riscv_ztt_i16_4x1_t ok_i16_4x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_4x1(base, stride); }
__riscv_ztt_i16_1x8_t ok_i16_1x8(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x8(base, stride); }
__riscv_ztt_i16_8x1_t ok_i16_8x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_8x1(base, stride); }
__riscv_ztt_u16_1x4_t ok_u16_1x4(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x4(base, stride); }
__riscv_ztt_u16_4x1_t ok_u16_4x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_4x1(base, stride); }
__riscv_ztt_u16_1x8_t ok_u16_1x8(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x8(base, stride); }
__riscv_ztt_u16_8x1_t ok_u16_8x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_8x1(base, stride); }
__riscv_ztt_i32_1x2_t ok_i32_1x2(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x2(base, stride); }
__riscv_ztt_i32_2x1_t ok_i32_2x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_2x1(base, stride); }
__riscv_ztt_i32_1x4_t ok_i32_1x4(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x4(base, stride); }
__riscv_ztt_i32_4x1_t ok_i32_4x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_4x1(base, stride); }
__riscv_ztt_u32_1x2_t ok_u32_1x2(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x2(base, stride); }
__riscv_ztt_u32_2x1_t ok_u32_2x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_2x1(base, stride); }
__riscv_ztt_u32_1x4_t ok_u32_1x4(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x4(base, stride); }
__riscv_ztt_u32_4x1_t ok_u32_4x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_4x1(base, stride); }
__riscv_ztt_i64_1x1_t ok_i64_1x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x1(base, stride); }
__riscv_ztt_i64_1x2_t ok_i64_1x2(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x2(base, stride); }
__riscv_ztt_i64_2x1_t ok_i64_2x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_2x1(base, stride); }
__riscv_ztt_u64_1x1_t ok_u64_1x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x1(base, stride); }
__riscv_ztt_u64_1x2_t ok_u64_1x2(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x2(base, stride); }
__riscv_ztt_u64_2x1_t ok_u64_2x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_2x1(base, stride); }
__riscv_ztt_i128_1x1_t ok_i128_1x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x1(base, stride); }
__riscv_ztt_i128_1x2_t ok_i128_1x2(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x2(base, stride); }
__riscv_ztt_i128_2x1_t ok_i128_2x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_2x1(base, stride); }
__riscv_ztt_u128_1x1_t ok_u128_1x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x1(base, stride); }
__riscv_ztt_u128_1x2_t ok_u128_1x2(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x2(base, stride); }
__riscv_ztt_u128_2x1_t ok_u128_2x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_2x1(base, stride); }
__riscv_ztt_f16_1x4_t ok_f16_1x4(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x4(base, stride); }
__riscv_ztt_f16_4x1_t ok_f16_4x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_4x1(base, stride); }
__riscv_ztt_f16_1x8_t ok_f16_1x8(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x8(base, stride); }
__riscv_ztt_f16_8x1_t ok_f16_8x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_8x1(base, stride); }
__riscv_ztt_bf16_1x4_t ok_bf16_1x4(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x4(base, stride); }
__riscv_ztt_bf16_4x1_t ok_bf16_4x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_4x1(base, stride); }
__riscv_ztt_bf16_1x8_t ok_bf16_1x8(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x8(base, stride); }
__riscv_ztt_bf16_8x1_t ok_bf16_8x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_8x1(base, stride); }
__riscv_ztt_f32_1x2_t ok_f32_1x2(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x2(base, stride); }
__riscv_ztt_f32_2x1_t ok_f32_2x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_2x1(base, stride); }
__riscv_ztt_f32_1x4_t ok_f32_1x4(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x4(base, stride); }
__riscv_ztt_f32_4x1_t ok_f32_4x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_4x1(base, stride); }
__riscv_ztt_f64_1x1_t ok_f64_1x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x1(base, stride); }
__riscv_ztt_f64_1x2_t ok_f64_1x2(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x2(base, stride); }
__riscv_ztt_f64_2x1_t ok_f64_2x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_2x1(base, stride); }
#endif
#if UDS == 128
__riscv_ztt_i8_1x16_t ok_i8_1x16(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x16(base, stride); }
__riscv_ztt_i8_16x1_t ok_i8_16x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_16x1(base, stride); }
__riscv_ztt_i8_1x32_t ok_i8_1x32(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x32(base, stride); }
__riscv_ztt_i8_32x1_t ok_i8_32x1(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_32x1(base, stride); }
__riscv_ztt_u8_1x16_t ok_u8_1x16(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x16(base, stride); }
__riscv_ztt_u8_16x1_t ok_u8_16x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_16x1(base, stride); }
__riscv_ztt_u8_1x32_t ok_u8_1x32(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_1x32(base, stride); }
__riscv_ztt_u8_32x1_t ok_u8_32x1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_32x1(base, stride); }
__riscv_ztt_i16_1x8_t ok_i16_1x8(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x8(base, stride); }
__riscv_ztt_i16_8x1_t ok_i16_8x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_8x1(base, stride); }
__riscv_ztt_i16_1x16_t ok_i16_1x16(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x16(base, stride); }
__riscv_ztt_i16_16x1_t ok_i16_16x1(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_16x1(base, stride); }
__riscv_ztt_u16_1x8_t ok_u16_1x8(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x8(base, stride); }
__riscv_ztt_u16_8x1_t ok_u16_8x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_8x1(base, stride); }
__riscv_ztt_u16_1x16_t ok_u16_1x16(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_1x16(base, stride); }
__riscv_ztt_u16_16x1_t ok_u16_16x1(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_16x1(base, stride); }
__riscv_ztt_i32_1x4_t ok_i32_1x4(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x4(base, stride); }
__riscv_ztt_i32_4x1_t ok_i32_4x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_4x1(base, stride); }
__riscv_ztt_i32_1x8_t ok_i32_1x8(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x8(base, stride); }
__riscv_ztt_i32_8x1_t ok_i32_8x1(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_8x1(base, stride); }
__riscv_ztt_u32_1x4_t ok_u32_1x4(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x4(base, stride); }
__riscv_ztt_u32_4x1_t ok_u32_4x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_4x1(base, stride); }
__riscv_ztt_u32_1x8_t ok_u32_1x8(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_1x8(base, stride); }
__riscv_ztt_u32_8x1_t ok_u32_8x1(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_8x1(base, stride); }
__riscv_ztt_i64_1x2_t ok_i64_1x2(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x2(base, stride); }
__riscv_ztt_i64_2x1_t ok_i64_2x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_2x1(base, stride); }
__riscv_ztt_i64_1x4_t ok_i64_1x4(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x4(base, stride); }
__riscv_ztt_i64_4x1_t ok_i64_4x1(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_4x1(base, stride); }
__riscv_ztt_u64_1x2_t ok_u64_1x2(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x2(base, stride); }
__riscv_ztt_u64_2x1_t ok_u64_2x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_2x1(base, stride); }
__riscv_ztt_u64_1x4_t ok_u64_1x4(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_1x4(base, stride); }
__riscv_ztt_u64_4x1_t ok_u64_4x1(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_4x1(base, stride); }
__riscv_ztt_i128_1x1_t ok_i128_1x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x1(base, stride); }
__riscv_ztt_i128_1x2_t ok_i128_1x2(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x2(base, stride); }
__riscv_ztt_i128_2x1_t ok_i128_2x1(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_2x1(base, stride); }
__riscv_ztt_u128_1x1_t ok_u128_1x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x1(base, stride); }
__riscv_ztt_u128_1x2_t ok_u128_1x2(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_1x2(base, stride); }
__riscv_ztt_u128_2x1_t ok_u128_2x1(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_2x1(base, stride); }
__riscv_ztt_f16_1x8_t ok_f16_1x8(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x8(base, stride); }
__riscv_ztt_f16_8x1_t ok_f16_8x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_8x1(base, stride); }
__riscv_ztt_f16_1x16_t ok_f16_1x16(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x16(base, stride); }
__riscv_ztt_f16_16x1_t ok_f16_16x1(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_16x1(base, stride); }
__riscv_ztt_bf16_1x8_t ok_bf16_1x8(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x8(base, stride); }
__riscv_ztt_bf16_8x1_t ok_bf16_8x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_8x1(base, stride); }
__riscv_ztt_bf16_1x16_t ok_bf16_1x16(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_1x16(base, stride); }
__riscv_ztt_bf16_16x1_t ok_bf16_16x1(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_16x1(base, stride); }
__riscv_ztt_f32_1x4_t ok_f32_1x4(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x4(base, stride); }
__riscv_ztt_f32_4x1_t ok_f32_4x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_4x1(base, stride); }
__riscv_ztt_f32_1x8_t ok_f32_1x8(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x8(base, stride); }
__riscv_ztt_f32_8x1_t ok_f32_8x1(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_8x1(base, stride); }
__riscv_ztt_f64_1x2_t ok_f64_1x2(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x2(base, stride); }
__riscv_ztt_f64_2x1_t ok_f64_2x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_2x1(base, stride); }
__riscv_ztt_f64_1x4_t ok_f64_1x4(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_1x4(base, stride); }
__riscv_ztt_f64_4x1_t ok_f64_4x1(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_4x1(base, stride); }
#endif
#if UDS != 8
// expected-no-diagnostics
#endif
#if UDS == 8
void invalid(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src, const int *c, volatile int *v, void *p, unsigned int *u, short *h, char *ch, __riscv_ztt_i32_scalar_t zs, __riscv_ztt_i32_accx1_t acc) {
  __riscv_ztt_mls_st_i32_1x1(p, stride); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mls_st_i32_1x1(u, stride); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mls_st_i32_1x1(h, stride); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mls_st_i32_1x1(ch, stride); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mls_st_i32_1x1(1, stride); // expected-error {{must be a pointer}}
  __riscv_ztt_mls_st_i32_1x1(v, stride); // expected-error {{has invalid qualifiers}}
  __riscv_ztt_mls_st_i32_1x1(base, 1.5); // expected-error {{must have integer type}}
  __riscv_ztt_mls_st_i32_1x1(base, p); // expected-error {{must have integer type}}
  __riscv_ztt_mls_st_i32_1x1(base, zs); // expected-error {{must have integer type}}
  __riscv_ztt_mls_st_i32_1x1(base, src); // expected-error {{must have integer type}}
  __riscv_ztt_mls_st_i32_1x1(base, acc); // expected-error {{must have integer type}}
  __riscv_ztt_mls_st_i32_1x1(base, 0);
  __riscv_ztt_mls_st_i32_1x1(base, 1);
  __riscv_ztt_mls_st_i32_1x1(base, -1);
  __riscv_ztt_mls_st_i32_1x1(base, 4294967297ULL);
  __riscv_ztt_mls_st_i32_1x1(base); // expected-error {{too few arguments}}
  __riscv_ztt_mls_st_i32_1x1(base, stride, src, 1); // expected-error {{too many arguments}}
}
// Exercise lazy interface lookup with calls, not macro or typed builtin names.
void sub_byte_load(signed char *s, unsigned char *u, size_t stride) {
  __riscv_ztt_mls_st_i4_1x2(s, stride); // expected-error {{undeclared}}
  __riscv_ztt_mls_st_u4_1x2(u, stride); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
void c_identity(long *l, long long *ll, signed char *sc, char *ch, __riscv_ztt_i32_1x1_t i32, __riscv_ztt_i64_1x1_t i64, __riscv_ztt_i8_1x1_t i8) {
#if __riscv_xlen == 32
  __riscv_ztt_mls_st_i32_1x1(l, 0); // expected-error {{does not match matrix element type}}
  __riscv_ztt_mls_st_i64_1x1(ll, 1);
#else
  __riscv_ztt_mls_st_i64_1x1(l, 1);
  __riscv_ztt_mls_st_i64_1x1(ll, 0); // expected-error {{does not match matrix element type}}
#endif
  __riscv_ztt_mls_st_i8_1x1(sc, 1);
  __riscv_ztt_mls_st_i8_1x1(ch, 1); // expected-error {{does not match matrix element type}}
}
#endif
