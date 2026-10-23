// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
#include <riscv_ztt.h>

void invalid_inputs(void) {
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_accx2_t acc2 = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_u32_accx1_t uacc = __riscv_ztt_mzero_acc_u32_accx1();
  __riscv_ztt_f32_accx1_t facc = __riscv_ztt_mzero_acc_f32_accx1();
  __riscv_ztt_i16_accx1_t narrow = __riscv_ztt_mzero_acc_i16_accx1();
  __riscv_ztt_i32_1x2_t row = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_2x1_t col = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_i32_1x1_t one = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc2, row, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(uacc, row, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(facc, row, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(narrow, row, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(row, row, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, col, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, row, col); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, row, one); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, one, col); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, acc, row); // expected-error {{requires two M source types}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, row, acc); // expected-error {{requires two M source types}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, 1, row); // expected-error {{requires two M source types}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, row); // expected-error {{too few arguments}}
  __riscv_ztt_mmulbtacc_2d_i32_accx1(acc, row, row, 0); // expected-error {{too many arguments}}
}
void result_i4_accx1(void) {
  __riscv_ztt_i4_accx1_t old = __riscv_ztt_mzero_acc_i4_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i4_accx1_t r = __riscv_ztt_mmulbtacc_2d_i4_accx1(old, a, b);
  (void)r;
}
void result_i4_accx2(void) {
  __riscv_ztt_i4_accx2_t old = __riscv_ztt_mzero_acc_i4_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i4_accx2_t r = __riscv_ztt_mmulbtacc_2d_i4_accx2(old, a, b);
  (void)r;
}
void result_i4_accx4(void) {
  __riscv_ztt_i4_accx4_t old = __riscv_ztt_mzero_acc_i4_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i4_accx4_t r = __riscv_ztt_mmulbtacc_2d_i4_accx4(old, a, b);
  (void)r;
}
void result_i4_accx8(void) {
  __riscv_ztt_i4_accx8_t old = __riscv_ztt_mzero_acc_i4_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i4_accx8_t r = __riscv_ztt_mmulbtacc_2d_i4_accx8(old, a, b);
  (void)r;
}
void result_u4_accx1(void) {
  __riscv_ztt_u4_accx1_t old = __riscv_ztt_mzero_acc_u4_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u4_accx1_t r = __riscv_ztt_mmulbtacc_2d_u4_accx1(old, a, b);
  (void)r;
}
void result_u4_accx2(void) {
  __riscv_ztt_u4_accx2_t old = __riscv_ztt_mzero_acc_u4_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u4_accx2_t r = __riscv_ztt_mmulbtacc_2d_u4_accx2(old, a, b);
  (void)r;
}
void result_u4_accx4(void) {
  __riscv_ztt_u4_accx4_t old = __riscv_ztt_mzero_acc_u4_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u4_accx4_t r = __riscv_ztt_mmulbtacc_2d_u4_accx4(old, a, b);
  (void)r;
}
void result_u4_accx8(void) {
  __riscv_ztt_u4_accx8_t old = __riscv_ztt_mzero_acc_u4_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u4_accx8_t r = __riscv_ztt_mmulbtacc_2d_u4_accx8(old, a, b);
  (void)r;
}
void result_i8_accx1(void) {
  __riscv_ztt_i8_accx1_t old = __riscv_ztt_mzero_acc_i8_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i8_accx1_t r = __riscv_ztt_mmulbtacc_2d_i8_accx1(old, a, b);
  (void)r;
}
void result_i8_accx2(void) {
  __riscv_ztt_i8_accx2_t old = __riscv_ztt_mzero_acc_i8_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i8_accx2_t r = __riscv_ztt_mmulbtacc_2d_i8_accx2(old, a, b);
  (void)r;
}
void result_i8_accx4(void) {
  __riscv_ztt_i8_accx4_t old = __riscv_ztt_mzero_acc_i8_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i8_accx4_t r = __riscv_ztt_mmulbtacc_2d_i8_accx4(old, a, b);
  (void)r;
}
void result_i8_accx8(void) {
  __riscv_ztt_i8_accx8_t old = __riscv_ztt_mzero_acc_i8_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i8_accx8_t r = __riscv_ztt_mmulbtacc_2d_i8_accx8(old, a, b);
  (void)r;
}
void result_u8_accx1(void) {
  __riscv_ztt_u8_accx1_t old = __riscv_ztt_mzero_acc_u8_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u8_accx1_t r = __riscv_ztt_mmulbtacc_2d_u8_accx1(old, a, b);
  (void)r;
}
void result_u8_accx2(void) {
  __riscv_ztt_u8_accx2_t old = __riscv_ztt_mzero_acc_u8_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u8_accx2_t r = __riscv_ztt_mmulbtacc_2d_u8_accx2(old, a, b);
  (void)r;
}
void result_u8_accx4(void) {
  __riscv_ztt_u8_accx4_t old = __riscv_ztt_mzero_acc_u8_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u8_accx4_t r = __riscv_ztt_mmulbtacc_2d_u8_accx4(old, a, b);
  (void)r;
}
void result_u8_accx8(void) {
  __riscv_ztt_u8_accx8_t old = __riscv_ztt_mzero_acc_u8_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u8_accx8_t r = __riscv_ztt_mmulbtacc_2d_u8_accx8(old, a, b);
  (void)r;
}
void result_i16_accx1(void) {
  __riscv_ztt_i16_accx1_t old = __riscv_ztt_mzero_acc_i16_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i16_accx1_t r = __riscv_ztt_mmulbtacc_2d_i16_accx1(old, a, b);
  (void)r;
}
void result_i16_accx2(void) {
  __riscv_ztt_i16_accx2_t old = __riscv_ztt_mzero_acc_i16_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i16_accx2_t r = __riscv_ztt_mmulbtacc_2d_i16_accx2(old, a, b);
  (void)r;
}
void result_i16_accx4(void) {
  __riscv_ztt_i16_accx4_t old = __riscv_ztt_mzero_acc_i16_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i16_accx4_t r = __riscv_ztt_mmulbtacc_2d_i16_accx4(old, a, b);
  (void)r;
}
void result_i16_accx8(void) {
  __riscv_ztt_i16_accx8_t old = __riscv_ztt_mzero_acc_i16_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i16_accx8_t r = __riscv_ztt_mmulbtacc_2d_i16_accx8(old, a, b);
  (void)r;
}
void result_u16_accx1(void) {
  __riscv_ztt_u16_accx1_t old = __riscv_ztt_mzero_acc_u16_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u16_accx1_t r = __riscv_ztt_mmulbtacc_2d_u16_accx1(old, a, b);
  (void)r;
}
void result_u16_accx2(void) {
  __riscv_ztt_u16_accx2_t old = __riscv_ztt_mzero_acc_u16_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u16_accx2_t r = __riscv_ztt_mmulbtacc_2d_u16_accx2(old, a, b);
  (void)r;
}
void result_u16_accx4(void) {
  __riscv_ztt_u16_accx4_t old = __riscv_ztt_mzero_acc_u16_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u16_accx4_t r = __riscv_ztt_mmulbtacc_2d_u16_accx4(old, a, b);
  (void)r;
}
void result_u16_accx8(void) {
  __riscv_ztt_u16_accx8_t old = __riscv_ztt_mzero_acc_u16_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u16_accx8_t r = __riscv_ztt_mmulbtacc_2d_u16_accx8(old, a, b);
  (void)r;
}
void result_i32_accx1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx1_t r = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)r;
}
void result_i32_accx2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx2_t r = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)r;
}
void result_i32_accx4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx4_t r = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)r;
}
void result_i32_accx8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx8_t r = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)r;
}
void result_u32_accx1(void) {
  __riscv_ztt_u32_accx1_t old = __riscv_ztt_mzero_acc_u32_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u32_accx1_t r = __riscv_ztt_mmulbtacc_2d_u32_accx1(old, a, b);
  (void)r;
}
void result_u32_accx2(void) {
  __riscv_ztt_u32_accx2_t old = __riscv_ztt_mzero_acc_u32_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u32_accx2_t r = __riscv_ztt_mmulbtacc_2d_u32_accx2(old, a, b);
  (void)r;
}
void result_u32_accx4(void) {
  __riscv_ztt_u32_accx4_t old = __riscv_ztt_mzero_acc_u32_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u32_accx4_t r = __riscv_ztt_mmulbtacc_2d_u32_accx4(old, a, b);
  (void)r;
}
void result_u32_accx8(void) {
  __riscv_ztt_u32_accx8_t old = __riscv_ztt_mzero_acc_u32_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u32_accx8_t r = __riscv_ztt_mmulbtacc_2d_u32_accx8(old, a, b);
  (void)r;
}
void result_i64_accx1(void) {
  __riscv_ztt_i64_accx1_t old = __riscv_ztt_mzero_acc_i64_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i64_accx1_t r = __riscv_ztt_mmulbtacc_2d_i64_accx1(old, a, b);
  (void)r;
}
void result_i64_accx2(void) {
  __riscv_ztt_i64_accx2_t old = __riscv_ztt_mzero_acc_i64_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i64_accx2_t r = __riscv_ztt_mmulbtacc_2d_i64_accx2(old, a, b);
  (void)r;
}
void result_i64_accx4(void) {
  __riscv_ztt_i64_accx4_t old = __riscv_ztt_mzero_acc_i64_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i64_accx4_t r = __riscv_ztt_mmulbtacc_2d_i64_accx4(old, a, b);
  (void)r;
}
void result_i64_accx8(void) {
  __riscv_ztt_i64_accx8_t old = __riscv_ztt_mzero_acc_i64_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i64_accx8_t r = __riscv_ztt_mmulbtacc_2d_i64_accx8(old, a, b);
  (void)r;
}
void result_u64_accx1(void) {
  __riscv_ztt_u64_accx1_t old = __riscv_ztt_mzero_acc_u64_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u64_accx1_t r = __riscv_ztt_mmulbtacc_2d_u64_accx1(old, a, b);
  (void)r;
}
void result_u64_accx2(void) {
  __riscv_ztt_u64_accx2_t old = __riscv_ztt_mzero_acc_u64_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u64_accx2_t r = __riscv_ztt_mmulbtacc_2d_u64_accx2(old, a, b);
  (void)r;
}
void result_u64_accx4(void) {
  __riscv_ztt_u64_accx4_t old = __riscv_ztt_mzero_acc_u64_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u64_accx4_t r = __riscv_ztt_mmulbtacc_2d_u64_accx4(old, a, b);
  (void)r;
}
void result_u64_accx8(void) {
  __riscv_ztt_u64_accx8_t old = __riscv_ztt_mzero_acc_u64_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u64_accx8_t r = __riscv_ztt_mmulbtacc_2d_u64_accx8(old, a, b);
  (void)r;
}
void result_i128_accx1(void) {
  __riscv_ztt_i128_accx1_t old = __riscv_ztt_mzero_acc_i128_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i128_accx1_t r = __riscv_ztt_mmulbtacc_2d_i128_accx1(old, a, b);
  (void)r;
}
void result_i128_accx2(void) {
  __riscv_ztt_i128_accx2_t old = __riscv_ztt_mzero_acc_i128_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i128_accx2_t r = __riscv_ztt_mmulbtacc_2d_i128_accx2(old, a, b);
  (void)r;
}
void result_i128_accx4(void) {
  __riscv_ztt_i128_accx4_t old = __riscv_ztt_mzero_acc_i128_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i128_accx4_t r = __riscv_ztt_mmulbtacc_2d_i128_accx4(old, a, b);
  (void)r;
}
void result_i128_accx8(void) {
  __riscv_ztt_i128_accx8_t old = __riscv_ztt_mzero_acc_i128_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i128_accx8_t r = __riscv_ztt_mmulbtacc_2d_i128_accx8(old, a, b);
  (void)r;
}
void result_u128_accx1(void) {
  __riscv_ztt_u128_accx1_t old = __riscv_ztt_mzero_acc_u128_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u128_accx1_t r = __riscv_ztt_mmulbtacc_2d_u128_accx1(old, a, b);
  (void)r;
}
void result_u128_accx2(void) {
  __riscv_ztt_u128_accx2_t old = __riscv_ztt_mzero_acc_u128_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u128_accx2_t r = __riscv_ztt_mmulbtacc_2d_u128_accx2(old, a, b);
  (void)r;
}
void result_u128_accx4(void) {
  __riscv_ztt_u128_accx4_t old = __riscv_ztt_mzero_acc_u128_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u128_accx4_t r = __riscv_ztt_mmulbtacc_2d_u128_accx4(old, a, b);
  (void)r;
}
void result_u128_accx8(void) {
  __riscv_ztt_u128_accx8_t old = __riscv_ztt_mzero_acc_u128_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_u128_accx8_t r = __riscv_ztt_mmulbtacc_2d_u128_accx8(old, a, b);
  (void)r;
}
void result_f16_accx1(void) {
  __riscv_ztt_f16_accx1_t old = __riscv_ztt_mzero_acc_f16_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f16_accx1_t r = __riscv_ztt_mmulbtacc_2d_f16_accx1(old, a, b);
  (void)r;
}
void result_f16_accx2(void) {
  __riscv_ztt_f16_accx2_t old = __riscv_ztt_mzero_acc_f16_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f16_accx2_t r = __riscv_ztt_mmulbtacc_2d_f16_accx2(old, a, b);
  (void)r;
}
void result_f16_accx4(void) {
  __riscv_ztt_f16_accx4_t old = __riscv_ztt_mzero_acc_f16_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f16_accx4_t r = __riscv_ztt_mmulbtacc_2d_f16_accx4(old, a, b);
  (void)r;
}
void result_f16_accx8(void) {
  __riscv_ztt_f16_accx8_t old = __riscv_ztt_mzero_acc_f16_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f16_accx8_t r = __riscv_ztt_mmulbtacc_2d_f16_accx8(old, a, b);
  (void)r;
}
void result_bf16_accx1(void) {
  __riscv_ztt_bf16_accx1_t old = __riscv_ztt_mzero_acc_bf16_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_bf16_accx1_t r = __riscv_ztt_mmulbtacc_2d_bf16_accx1(old, a, b);
  (void)r;
}
void result_bf16_accx2(void) {
  __riscv_ztt_bf16_accx2_t old = __riscv_ztt_mzero_acc_bf16_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_bf16_accx2_t r = __riscv_ztt_mmulbtacc_2d_bf16_accx2(old, a, b);
  (void)r;
}
void result_bf16_accx4(void) {
  __riscv_ztt_bf16_accx4_t old = __riscv_ztt_mzero_acc_bf16_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_bf16_accx4_t r = __riscv_ztt_mmulbtacc_2d_bf16_accx4(old, a, b);
  (void)r;
}
void result_bf16_accx8(void) {
  __riscv_ztt_bf16_accx8_t old = __riscv_ztt_mzero_acc_bf16_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_bf16_accx8_t r = __riscv_ztt_mmulbtacc_2d_bf16_accx8(old, a, b);
  (void)r;
}
void result_f32_accx1(void) {
  __riscv_ztt_f32_accx1_t old = __riscv_ztt_mzero_acc_f32_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_accx1_t r = __riscv_ztt_mmulbtacc_2d_f32_accx1(old, a, b);
  (void)r;
}
void result_f32_accx2(void) {
  __riscv_ztt_f32_accx2_t old = __riscv_ztt_mzero_acc_f32_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_accx2_t r = __riscv_ztt_mmulbtacc_2d_f32_accx2(old, a, b);
  (void)r;
}
void result_f32_accx4(void) {
  __riscv_ztt_f32_accx4_t old = __riscv_ztt_mzero_acc_f32_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_accx4_t r = __riscv_ztt_mmulbtacc_2d_f32_accx4(old, a, b);
  (void)r;
}
void result_f32_accx8(void) {
  __riscv_ztt_f32_accx8_t old = __riscv_ztt_mzero_acc_f32_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_accx8_t r = __riscv_ztt_mmulbtacc_2d_f32_accx8(old, a, b);
  (void)r;
}
void result_f64_accx1(void) {
  __riscv_ztt_f64_accx1_t old = __riscv_ztt_mzero_acc_f64_accx1();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f64_accx1_t r = __riscv_ztt_mmulbtacc_2d_f64_accx1(old, a, b);
  (void)r;
}
void result_f64_accx2(void) {
  __riscv_ztt_f64_accx2_t old = __riscv_ztt_mzero_acc_f64_accx2();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f64_accx2_t r = __riscv_ztt_mmulbtacc_2d_f64_accx2(old, a, b);
  (void)r;
}
void result_f64_accx4(void) {
  __riscv_ztt_f64_accx4_t old = __riscv_ztt_mzero_acc_f64_accx4();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f64_accx4_t r = __riscv_ztt_mmulbtacc_2d_f64_accx4(old, a, b);
  (void)r;
}
void result_f64_accx8(void) {
  __riscv_ztt_f64_accx8_t old = __riscv_ztt_mzero_acc_f64_accx8();
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f64_accx8_t r = __riscv_ztt_mmulbtacc_2d_f64_accx8(old, a, b);
  (void)r;
}
#ifdef __cplusplus
extern "C" {
#endif
void test_1_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_1_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_1_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_1_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_1_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_1_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_1_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_1_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_2_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_2_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_2_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_2_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_2_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_2_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_2_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_2_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_4_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_4_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_4_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_4_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_4_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_4_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_4_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_4_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_8_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_8_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_8_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_8_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
void test_8_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
void test_8_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
void test_8_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
void test_8_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulbtacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
#ifdef __cplusplus
}
#endif
