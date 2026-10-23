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
// Call the public interface: lazy declarations are neither macros nor
// per-datatype builtins, so preprocessing queries cannot test result domains.
void invalid_result_domain(__riscv_ztt_f32_1x1_t src) {
  (void)__riscv_ztt_mfrintz_ew_i32_1x1(src); // expected-error {{undeclared}}
  (void)__riscv_ztt_mfrintz_ew_u32_1x1(src); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
void ok_0_1x1(__riscv_ztt_f16_1x1_t s0) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mfrintz_ew_f16_1x1(s0);
}
void ok_0_1x2(__riscv_ztt_f16_1x2_t s0) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mfrintz_ew_f16_1x2(s0);
}
void ok_1_1x1(__riscv_ztt_bf16_1x1_t s0) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mfrintz_ew_bf16_1x1(s0);
}
void ok_1_1x2(__riscv_ztt_bf16_1x2_t s0) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mfrintz_ew_bf16_1x2(s0);
}
void ok_2_1x1(__riscv_ztt_f32_1x1_t s0) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mfrintz_ew_f32_1x1(s0);
}
void ok_2_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mfrintz_ew_f32_1x2(s0);
}
void ok_3_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mfrintz_ew_f64_1x1(s0);
}
void ok_3_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mfrintz_ew_f64_1x2(s0);
}
#endif
#if UDS == 16
void ok_0_1x1(__riscv_ztt_f16_1x1_t s0) {
  __riscv_ztt_f16_1x1_t r = __riscv_ztt_mfrintz_ew_f16_1x1(s0);
}
void ok_0_1x2(__riscv_ztt_f16_1x2_t s0) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mfrintz_ew_f16_1x2(s0);
}
void ok_1_1x1(__riscv_ztt_bf16_1x1_t s0) {
  __riscv_ztt_bf16_1x1_t r = __riscv_ztt_mfrintz_ew_bf16_1x1(s0);
}
void ok_1_1x2(__riscv_ztt_bf16_1x2_t s0) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mfrintz_ew_bf16_1x2(s0);
}
void ok_2_1x1(__riscv_ztt_f32_1x1_t s0) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mfrintz_ew_f32_1x1(s0);
}
void ok_2_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mfrintz_ew_f32_1x2(s0);
}
void ok_3_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mfrintz_ew_f64_1x1(s0);
}
void ok_3_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mfrintz_ew_f64_1x2(s0);
}
#endif
#if UDS == 32
void ok_0_1x2(__riscv_ztt_f16_1x2_t s0) {
  __riscv_ztt_f16_1x2_t r = __riscv_ztt_mfrintz_ew_f16_1x2(s0);
}
void ok_0_2x1(__riscv_ztt_f16_2x1_t s0) {
  __riscv_ztt_f16_2x1_t r = __riscv_ztt_mfrintz_ew_f16_2x1(s0);
}
void ok_0_1x4(__riscv_ztt_f16_1x4_t s0) {
  __riscv_ztt_f16_1x4_t r = __riscv_ztt_mfrintz_ew_f16_1x4(s0);
}
void ok_1_1x2(__riscv_ztt_bf16_1x2_t s0) {
  __riscv_ztt_bf16_1x2_t r = __riscv_ztt_mfrintz_ew_bf16_1x2(s0);
}
void ok_1_2x1(__riscv_ztt_bf16_2x1_t s0) {
  __riscv_ztt_bf16_2x1_t r = __riscv_ztt_mfrintz_ew_bf16_2x1(s0);
}
void ok_1_1x4(__riscv_ztt_bf16_1x4_t s0) {
  __riscv_ztt_bf16_1x4_t r = __riscv_ztt_mfrintz_ew_bf16_1x4(s0);
}
void ok_2_1x1(__riscv_ztt_f32_1x1_t s0) {
  __riscv_ztt_f32_1x1_t r = __riscv_ztt_mfrintz_ew_f32_1x1(s0);
}
void ok_2_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mfrintz_ew_f32_1x2(s0);
}
void ok_3_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mfrintz_ew_f64_1x1(s0);
}
void ok_3_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mfrintz_ew_f64_1x2(s0);
}
#endif
#if UDS == 64
void ok_0_1x4(__riscv_ztt_f16_1x4_t s0) {
  __riscv_ztt_f16_1x4_t r = __riscv_ztt_mfrintz_ew_f16_1x4(s0);
}
void ok_0_4x1(__riscv_ztt_f16_4x1_t s0) {
  __riscv_ztt_f16_4x1_t r = __riscv_ztt_mfrintz_ew_f16_4x1(s0);
}
void ok_0_1x8(__riscv_ztt_f16_1x8_t s0) {
  __riscv_ztt_f16_1x8_t r = __riscv_ztt_mfrintz_ew_f16_1x8(s0);
}
void ok_1_1x4(__riscv_ztt_bf16_1x4_t s0) {
  __riscv_ztt_bf16_1x4_t r = __riscv_ztt_mfrintz_ew_bf16_1x4(s0);
}
void ok_1_4x1(__riscv_ztt_bf16_4x1_t s0) {
  __riscv_ztt_bf16_4x1_t r = __riscv_ztt_mfrintz_ew_bf16_4x1(s0);
}
void ok_1_1x8(__riscv_ztt_bf16_1x8_t s0) {
  __riscv_ztt_bf16_1x8_t r = __riscv_ztt_mfrintz_ew_bf16_1x8(s0);
}
void ok_2_1x2(__riscv_ztt_f32_1x2_t s0) {
  __riscv_ztt_f32_1x2_t r = __riscv_ztt_mfrintz_ew_f32_1x2(s0);
}
void ok_2_2x1(__riscv_ztt_f32_2x1_t s0) {
  __riscv_ztt_f32_2x1_t r = __riscv_ztt_mfrintz_ew_f32_2x1(s0);
}
void ok_2_1x4(__riscv_ztt_f32_1x4_t s0) {
  __riscv_ztt_f32_1x4_t r = __riscv_ztt_mfrintz_ew_f32_1x4(s0);
}
void ok_3_1x1(__riscv_ztt_f64_1x1_t s0) {
  __riscv_ztt_f64_1x1_t r = __riscv_ztt_mfrintz_ew_f64_1x1(s0);
}
void ok_3_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mfrintz_ew_f64_1x2(s0);
}
#endif
#if UDS == 128
void ok_0_1x8(__riscv_ztt_f16_1x8_t s0) {
  __riscv_ztt_f16_1x8_t r = __riscv_ztt_mfrintz_ew_f16_1x8(s0);
}
void ok_0_8x1(__riscv_ztt_f16_8x1_t s0) {
  __riscv_ztt_f16_8x1_t r = __riscv_ztt_mfrintz_ew_f16_8x1(s0);
}
void ok_0_1x16(__riscv_ztt_f16_1x16_t s0) {
  __riscv_ztt_f16_1x16_t r = __riscv_ztt_mfrintz_ew_f16_1x16(s0);
}
void ok_1_1x8(__riscv_ztt_bf16_1x8_t s0) {
  __riscv_ztt_bf16_1x8_t r = __riscv_ztt_mfrintz_ew_bf16_1x8(s0);
}
void ok_1_8x1(__riscv_ztt_bf16_8x1_t s0) {
  __riscv_ztt_bf16_8x1_t r = __riscv_ztt_mfrintz_ew_bf16_8x1(s0);
}
void ok_1_1x16(__riscv_ztt_bf16_1x16_t s0) {
  __riscv_ztt_bf16_1x16_t r = __riscv_ztt_mfrintz_ew_bf16_1x16(s0);
}
void ok_2_1x4(__riscv_ztt_f32_1x4_t s0) {
  __riscv_ztt_f32_1x4_t r = __riscv_ztt_mfrintz_ew_f32_1x4(s0);
}
void ok_2_4x1(__riscv_ztt_f32_4x1_t s0) {
  __riscv_ztt_f32_4x1_t r = __riscv_ztt_mfrintz_ew_f32_4x1(s0);
}
void ok_2_1x8(__riscv_ztt_f32_1x8_t s0) {
  __riscv_ztt_f32_1x8_t r = __riscv_ztt_mfrintz_ew_f32_1x8(s0);
}
void ok_3_1x2(__riscv_ztt_f64_1x2_t s0) {
  __riscv_ztt_f64_1x2_t r = __riscv_ztt_mfrintz_ew_f64_1x2(s0);
}
void ok_3_2x1(__riscv_ztt_f64_2x1_t s0) {
  __riscv_ztt_f64_2x1_t r = __riscv_ztt_mfrintz_ew_f64_2x1(s0);
}
void ok_3_1x4(__riscv_ztt_f64_1x4_t s0) {
  __riscv_ztt_f64_1x4_t r = __riscv_ztt_mfrintz_ew_f64_1x4(s0);
}
#endif
#if UDS != 8
// expected-no-diagnostics
#endif

#if UDS == 8
void invalid_operands(void) {
  __riscv_ztt_f32_1x1_t a0 = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_f32_1x4_t wrong_shape = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_u32_1x1_t other_type = __riscv_ztt_mzero_m_u32_1x1();
  __riscv_ztt_f32_1x1_t fp = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_1x1_t integer = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mfrintz_ew_f32_1x1(acc); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mfrintz_ew_f32_1x1(wrong_shape); // expected-error {{RISC-V Ztt mfrintz.ew operands violate the required datatype or shape constraints}}
  __riscv_ztt_mfrintz_ew_f32_1x1(integer); // expected-error {{RISC-V Ztt mfrintz.ew operands violate the required datatype or shape constraints}}
}
#endif

// Forbidden result datatypes must not expose aliases or builtins.
#if UDS == 8
void boundary(__riscv_ztt_f32_1x2_t s0, __riscv_ztt_f32_2x1_t col, __riscv_ztt_f32_1x1_t one, __riscv_ztt_f32_1x2_t fp, __riscv_ztt_i32_1x2_t integer, __riscv_ztt_u32_1x2_t uns, __riscv_ztt_i32_accx2_t acc, float f, int *p) {
  __riscv_ztt_mfrintz_ew_f32_1x2(col); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mfrintz_ew_f32_1x2(one); // expected-error {{operands violate the required datatype or shape constraints}}
  __riscv_ztt_mfrintz_ew_f32_1x2(); // expected-error {{too few arguments}}
  __riscv_ztt_mfrintz_ew_f32_1x2(s0, 1); // expected-error {{too many arguments}}
}
#endif
#if UDS == 32
__riscv_ztt_f16_1x2_t mixed_0(__riscv_ztt_bf16_1x2_t s0) {
  return __riscv_ztt_mfrintz_ew_f16_1x2(s0);
}
#endif
#if UDS == 32
__riscv_ztt_bf16_2x1_t mixed_1(__riscv_ztt_bf16_2x1_t s0) {
  return __riscv_ztt_mfrintz_ew_bf16_2x1(s0);
}
#endif
#if UDS == 32
__riscv_ztt_f32_1x2_t mixed_2(__riscv_ztt_bf16_1x2_t s0) {
  return __riscv_ztt_mfrintz_ew_f32_1x2(s0);
}
#endif
#if UDS == 32
__riscv_ztt_f64_2x1_t mixed_3(__riscv_ztt_bf16_2x1_t s0) {
  return __riscv_ztt_mfrintz_ew_f64_2x1(s0);
}
#endif
