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
void invalid_result_domain(void) {
  (void)__riscv_ztt_mrowid_ew_f32_1x1(); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
void ok_i8_1x1(void) {
  __riscv_ztt_i8_1x1_t r = __riscv_ztt_mrowid_ew_i8_1x1();
}
void ok_u8_1x1(void) {
  __riscv_ztt_u8_1x1_t r = __riscv_ztt_mrowid_ew_u8_1x1();
}
void ok_i16_1x1(void) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mrowid_ew_i16_1x1();
}
void ok_u16_1x1(void) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mrowid_ew_u16_1x1();
}
void ok_i32_1x1(void) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mrowid_ew_i32_1x1();
}
void ok_u32_1x1(void) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mrowid_ew_u32_1x1();
}
void ok_i64_1x1(void) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mrowid_ew_i64_1x1();
}
void ok_u64_1x1(void) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mrowid_ew_u64_1x1();
}
void ok_i128_1x1(void) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mrowid_ew_i128_1x1();
}
void ok_u128_1x1(void) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mrowid_ew_u128_1x1();
}
#endif
#if UDS == 16
void ok_i16_1x1(void) {
  __riscv_ztt_i16_1x1_t r = __riscv_ztt_mrowid_ew_i16_1x1();
}
void ok_u16_1x1(void) {
  __riscv_ztt_u16_1x1_t r = __riscv_ztt_mrowid_ew_u16_1x1();
}
void ok_i32_1x1(void) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mrowid_ew_i32_1x1();
}
void ok_u32_1x1(void) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mrowid_ew_u32_1x1();
}
void ok_i64_1x1(void) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mrowid_ew_i64_1x1();
}
void ok_u64_1x1(void) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mrowid_ew_u64_1x1();
}
void ok_i128_1x1(void) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mrowid_ew_i128_1x1();
}
void ok_u128_1x1(void) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mrowid_ew_u128_1x1();
}
#endif
#if UDS == 32
void ok_i32_1x1(void) {
  __riscv_ztt_i32_1x1_t r = __riscv_ztt_mrowid_ew_i32_1x1();
}
void ok_u32_1x1(void) {
  __riscv_ztt_u32_1x1_t r = __riscv_ztt_mrowid_ew_u32_1x1();
}
void ok_i64_1x1(void) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mrowid_ew_i64_1x1();
}
void ok_u64_1x1(void) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mrowid_ew_u64_1x1();
}
void ok_i128_1x1(void) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mrowid_ew_i128_1x1();
}
void ok_u128_1x1(void) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mrowid_ew_u128_1x1();
}
#endif
#if UDS == 64
void ok_i64_1x1(void) {
  __riscv_ztt_i64_1x1_t r = __riscv_ztt_mrowid_ew_i64_1x1();
}
void ok_u64_1x1(void) {
  __riscv_ztt_u64_1x1_t r = __riscv_ztt_mrowid_ew_u64_1x1();
}
void ok_i128_1x1(void) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mrowid_ew_i128_1x1();
}
void ok_u128_1x1(void) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mrowid_ew_u128_1x1();
}
#endif
#if UDS == 128
void ok_i128_1x1(void) {
  __riscv_ztt_i128_1x1_t r = __riscv_ztt_mrowid_ew_i128_1x1();
}
void ok_u128_1x1(void) {
  __riscv_ztt_u128_1x1_t r = __riscv_ztt_mrowid_ew_u128_1x1();
}
#endif
#if UDS != 8 && UDS != 32
// expected-no-diagnostics
#endif

#if UDS == 8
void invalid_operands(void) {
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x4_t wrong_shape = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_u32_1x1_t other_type = __riscv_ztt_mzero_m_u32_1x1();
  __riscv_ztt_f32_1x1_t fp = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_1x1_t integer = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mrowid_ew_i32_1x4(); // expected-error {{undeclared}}
}
#endif

// Forbidden result datatypes must not expose aliases or builtins.
#if UDS == 8
void boundaries(__riscv_ztt_i32_1x2_t row, __riscv_ztt_i32_2x1_t col, __riscv_ztt_f32_1x1_t fp, __riscv_ztt_u32_1x1_t uns, __riscv_ztt_i32_accx1_t acc, __riscv_ztt_i32_scalar_t zs, float f, int *p) {
  __riscv_ztt_mrowid_ew_i32_1x1(1); // expected-error {{too many arguments}}
  __riscv_ztt_mrowid_ew_i32_1x2(); // expected-error {{undeclared}}
  __riscv_ztt_mrowid_ew_i32_2x1(); // expected-error {{undeclared}}
}
#endif
#if UDS == 8
__riscv_ztt_i8_1x1_t test_2(void) { return __riscv_ztt_mrowid_ew_i8_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_u8_1x1_t test_3(void) { return __riscv_ztt_mrowid_ew_u8_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_i16_1x1_t test_4(void) { return __riscv_ztt_mrowid_ew_i16_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_u16_1x1_t test_5(void) { return __riscv_ztt_mrowid_ew_u16_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_i32_1x1_t test_6(void) { return __riscv_ztt_mrowid_ew_i32_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_u32_1x1_t test_7(void) { return __riscv_ztt_mrowid_ew_u32_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_i64_1x1_t test_8(void) { return __riscv_ztt_mrowid_ew_i64_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_u64_1x1_t test_9(void) { return __riscv_ztt_mrowid_ew_u64_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_i128_1x1_t test_10(void) { return __riscv_ztt_mrowid_ew_i128_1x1(); }
#endif
#if UDS == 8
__riscv_ztt_u128_1x1_t test_11(void) { return __riscv_ztt_mrowid_ew_u128_1x1(); }
#endif

#if UDS == 32
// These shapes fit a physical register but are packed, not basic squares.
void reject_packed_1x2(__riscv_ztt_i16_1x2_t a) {
  __riscv_ztt_mrowid_ew_i16_1x2(); // expected-error {{undeclared}}
}
void reject_packed_2x1(__riscv_ztt_i16_2x1_t a) {
  __riscv_ztt_mrowid_ew_i16_2x1(); // expected-error {{undeclared}}
}
#endif
