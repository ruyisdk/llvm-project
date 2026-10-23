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
void ok_i8_1x1(__riscv_ztt_i8_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i8_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i8_1x1(s0, scalar);
}
void ok_u8_1x1(__riscv_ztt_u8_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u8_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u8_1x1(s0, scalar);
}
void ok_i16_1x1(__riscv_ztt_i16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i16_1x1(s0, scalar);
}
void ok_u16_1x1(__riscv_ztt_u16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u16_1x1(s0, scalar);
}
void ok_i32_1x1(__riscv_ztt_i32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, scalar);
}
void ok_u32_1x1(__riscv_ztt_u32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u32_1x1(s0, scalar);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i64_1x1(s0, scalar);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u64_1x1(s0, scalar);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i128_1x1(s0, scalar);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u128_1x1(s0, scalar);
}
void ok_f16_1x1(__riscv_ztt_f16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f16_1x1(s0, scalar);
}
void ok_bf16_1x1(__riscv_ztt_bf16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_bf16_1x1(s0, scalar);
}
void ok_f32_1x1(__riscv_ztt_f32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f32_1x1(s0, scalar);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f64_1x1(s0, scalar);
}
#endif
#if UDS == 16
void ok_i16_1x1(__riscv_ztt_i16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i16_1x1(s0, scalar);
}
void ok_u16_1x1(__riscv_ztt_u16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u16_1x1(s0, scalar);
}
void ok_i32_1x1(__riscv_ztt_i32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, scalar);
}
void ok_u32_1x1(__riscv_ztt_u32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u32_1x1(s0, scalar);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i64_1x1(s0, scalar);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u64_1x1(s0, scalar);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i128_1x1(s0, scalar);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u128_1x1(s0, scalar);
}
void ok_f16_1x1(__riscv_ztt_f16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f16_1x1(s0, scalar);
}
void ok_bf16_1x1(__riscv_ztt_bf16_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mcolbcast_ew_x_bf16_1x1(s0, scalar);
}
void ok_f32_1x1(__riscv_ztt_f32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f32_1x1(s0, scalar);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f64_1x1(s0, scalar);
}
#endif
#if UDS == 32
void ok_i32_1x1(__riscv_ztt_i32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, scalar);
}
void ok_u32_1x1(__riscv_ztt_u32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u32_1x1(s0, scalar);
}
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i64_1x1(s0, scalar);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u64_1x1(s0, scalar);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i128_1x1(s0, scalar);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u128_1x1(s0, scalar);
}
void ok_f32_1x1(__riscv_ztt_f32_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f32_1x1(s0, scalar);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f64_1x1(s0, scalar);
}
#endif
#if UDS == 64
void ok_i64_1x1(__riscv_ztt_i64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i64_1x1(s0, scalar);
}
void ok_u64_1x1(__riscv_ztt_u64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u64_1x1(s0, scalar);
}
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i128_1x1(s0, scalar);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u128_1x1(s0, scalar);
}
void ok_f64_1x1(__riscv_ztt_f64_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mcolbcast_ew_x_f64_1x1(s0, scalar);
}
#endif
#if UDS == 128
void ok_i128_1x1(__riscv_ztt_i128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_i128_1x1(s0, scalar);
}
void ok_u128_1x1(__riscv_ztt_u128_1x1_t s0, __SIZE_TYPE__ scalar) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mcolbcast_ew_x_u128_1x1(s0, scalar);
}
#endif
#if UDS != 8 && UDS != 32
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
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(acc, 0); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(wrong_shape, 0); // expected-error {{RISC-V Ztt mcolbcast.ew.x operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(a0, 1.5); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(other_type, 0); // expected-error {{RISC-V Ztt mcolbcast.ew.x operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x4(wrong_shape, 0); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
void boundaries(__riscv_ztt_i32_1x1_t s0, __SIZE_TYPE__ scalar, __riscv_ztt_i32_1x2_t row, __riscv_ztt_i32_2x1_t col, __riscv_ztt_f32_1x1_t fp, __riscv_ztt_u32_1x1_t uns, __riscv_ztt_i32_accx1_t acc, __riscv_ztt_i32_scalar_t zs, float f, int *p) {
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(row, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(col, scalar); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, f); // expected-error {{must have integer type}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, p); // expected-error {{must have integer type}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, acc); // expected-error {{must have integer type}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, zs); // expected-error {{must have integer type}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0); // expected-error {{too few arguments}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, scalar, 1); // expected-error {{too many arguments}}
  __riscv_ztt_mcolbcast_ew_x_i32_1x2(row, scalar); // expected-error {{undeclared}}
  __riscv_ztt_mcolbcast_ew_x_i32_2x1(col, scalar); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
__riscv_ztt_i8_1x1_t test_2(__riscv_ztt_i8_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_i8_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_u8_1x1_t test_3(__riscv_ztt_u8_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_u8_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_i16_1x1_t test_4(__riscv_ztt_i16_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_i16_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_u16_1x1_t test_5(__riscv_ztt_u16_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_u16_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_i32_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_i32_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_u32_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_u32_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_i64_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_i64_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_u64_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_u64_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_i128_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_i128_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_u128_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_u128_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_f16_1x1_t test_12(__riscv_ztt_f16_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_f16_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_bf16_1x1_t test_13(__riscv_ztt_bf16_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_bf16_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_f32_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_f32_1x1(s0, scalar); }
#endif
#if UDS == 8
__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_f64_1x1_t s0, __SIZE_TYPE__ scalar) { return __riscv_ztt_mcolbcast_ew_x_f64_1x1(s0, scalar); }
#endif

#if UDS == 32
// These shapes fit a physical register but are packed, not basic squares.
void reject_packed_1x2(__riscv_ztt_i16_1x2_t a) {
  __riscv_ztt_mcolbcast_ew_x_i16_1x2(a, 0); // expected-error {{undeclared}}
}
void reject_packed_2x1(__riscv_ztt_i16_2x1_t a) {
  __riscv_ztt_mcolbcast_ew_x_i16_2x1(a, 0); // expected-error {{undeclared}}
}
#endif
