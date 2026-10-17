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

#if UDS == 32
// Call the public interface: lazy declarations are neither macros nor
// per-datatype builtins, so preprocessing queries cannot test result domains.
void invalid_result_domain(__riscv_ztt_f32_1x1_t src) {
  (void)__riscv_ztt_msqrt_ew_i32_1x1(src); // expected-error {{undeclared}}
  (void)__riscv_ztt_msqrt_ew_u32_1x1(src); // expected-error {{undeclared}}
}
#endif

// Every available numeric type and M shape, at every UDS where it is legal.
// This is a front-end type test, not a promise of a matrix argument ABI.
#define TEST(T, S) \
  __riscv_ztt_##T##_##S##_t valid_##T##_##S( \
      __riscv_ztt_##T##_##S##_t a) { \
    return __riscv_ztt_msqrt_ew_##T##_##S(a); \
  }

#if UDS <= 4 && 4 <= 32 * UDS
#endif

#if UDS <= 8 && 8 <= 32 * UDS
#endif

#if UDS <= 16 && 16 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 4 && 4 <= 32 * UDS
#endif

#if UDS <= 8 && 8 <= 32 * UDS
#endif

#if UDS <= 16 && 16 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 8 && 8 <= 32 * UDS
#endif

#if UDS <= 16 && 16 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 8 && 8 <= 32 * UDS
#endif

#if UDS <= 16 && 16 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 16 && 16 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 16 && 16 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
#endif

#if UDS <= 32 && 32 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
#endif

#if UDS <= 64 && 64 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
#endif

#if UDS <= 4096 && 4096 <= 32 * UDS
#endif

#if UDS <= 128 && 128 <= 32 * UDS
#endif

#if UDS <= 256 && 256 <= 32 * UDS
#endif

#if UDS <= 512 && 512 <= 32 * UDS
#endif

#if UDS <= 1024 && 1024 <= 32 * UDS
#endif

#if UDS <= 2048 && 2048 <= 32 * UDS
#endif

#if UDS <= 4096 && 4096 <= 32 * UDS
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
void invalid(__riscv_ztt_f32_1x2_t row, __riscv_ztt_f32_2x1_t col,
             __riscv_ztt_f32_1x1_t one, __riscv_ztt_i32_accx1_t acc, int scalar) {
  __riscv_ztt_msqrt_ew_f32_1x2(col); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_msqrt_ew_f32_1x2(one); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_msqrt_ew_f32_1x1(row); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_msqrt_ew_f32_2x1(row); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_msqrt_ew_f32_1x1(acc); // expected-error {{requires an M matrix type}}
  __riscv_ztt_msqrt_ew_f32_1x1(scalar); // expected-error {{requires an M matrix type}}
  __riscv_ztt_msqrt_ew_f32_1x1(); // expected-error {{too few arguments}}
  __riscv_ztt_msqrt_ew_f32_1x1(one, one); // expected-error {{too many arguments}}
}
void integer_rejected(__riscv_ztt_i32_1x1_t i, __riscv_ztt_u32_1x1_t u,
                      __riscv_ztt_f32_1x1_t f) {
  __riscv_ztt_msqrt_ew_f32_1x1(i); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_msqrt_ew_f32_1x1(u); // expected-error {{operands violate the required datatype or shape constraints}}
}
#else
// expected-no-diagnostics
#endif
#if UDS == 32

__riscv_ztt_f16_1x2_t test_0(__riscv_ztt_f16_1x2_t src) {
  return __riscv_ztt_msqrt_ew_f16_1x2(src);
}

__riscv_ztt_bf16_2x1_t test_1(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_msqrt_ew_bf16_2x1(src);
}

__riscv_ztt_f32_1x1_t test_2(__riscv_ztt_f32_1x1_t src) {
  return __riscv_ztt_msqrt_ew_f32_1x1(src);
}

__riscv_ztt_f64_1x1_t test_3(__riscv_ztt_f64_1x1_t src) {
  return __riscv_ztt_msqrt_ew_f64_1x1(src);
}

__riscv_ztt_bf16_1x2_t test_4(__riscv_ztt_f32_1x2_t src) {
  return __riscv_ztt_msqrt_ew_bf16_1x2(src);
}

__riscv_ztt_f64_2x1_t test_5(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_msqrt_ew_f64_2x1(src);
}

__riscv_ztt_f16_1x2_t test_6(__riscv_ztt_f64_1x2_t src) {
  return __riscv_ztt_msqrt_ew_f16_1x2(src);
}

__riscv_ztt_f32_2x1_t test_7(__riscv_ztt_f16_2x1_t src) {
  return __riscv_ztt_msqrt_ew_f32_2x1(src);
}

__riscv_ztt_bf16_1x2_t test_8(__riscv_ztt_f16_1x2_t src) {
  return __riscv_ztt_msqrt_ew_bf16_1x2(src);
}

__riscv_ztt_f64_2x1_t test_9(__riscv_ztt_f16_2x1_t src) {
  return __riscv_ztt_msqrt_ew_f64_2x1(src);
}

__riscv_ztt_f16_1x2_t test_10(__riscv_ztt_bf16_1x2_t src) {
  return __riscv_ztt_msqrt_ew_f16_1x2(src);
}

__riscv_ztt_f32_2x1_t test_11(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_msqrt_ew_f32_2x1(src);
}

__riscv_ztt_f16_1x2_t test_12(__riscv_ztt_f32_1x2_t src) {
  return __riscv_ztt_msqrt_ew_f16_1x2(src);
}

__riscv_ztt_f64_1x1_t test_13(__riscv_ztt_f32_1x1_t src) {
  return __riscv_ztt_msqrt_ew_f64_1x1(src);
}

__riscv_ztt_bf16_1x2_t test_14(__riscv_ztt_f64_1x2_t src) {
  return __riscv_ztt_msqrt_ew_bf16_1x2(src);
}

__riscv_ztt_f32_1x1_t test_15(__riscv_ztt_f64_1x1_t src) {
  return __riscv_ztt_msqrt_ew_f32_1x1(src);
}
#endif

// Illegal result types have neither public aliases nor builtins.
