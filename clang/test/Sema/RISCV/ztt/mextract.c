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
#if UDS != 8
// expected-no-diagnostics
#endif
#include <riscv_ztt.h>

#if UDS == 8
void test_0(void) {
  __riscv_ztt_i4_1x4_t s0 = __riscv_ztt_mzero_m_i4_1x4();
  __riscv_ztt_i4_1x2_t dst = __riscv_ztt_mextract_i4_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_1(void) {
  __riscv_ztt_i4_4x1_t s0 = __riscv_ztt_mzero_m_i4_4x1();
  __riscv_ztt_i4_2x1_t dst = __riscv_ztt_mextract_i4_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_2(void) {
  __riscv_ztt_i4_1x8_t s0 = __riscv_ztt_mzero_m_i4_1x8();
  __riscv_ztt_i4_1x4_t dst = __riscv_ztt_mextract_i4_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_3(void) {
  __riscv_ztt_i4_8x1_t s0 = __riscv_ztt_mzero_m_i4_8x1();
  __riscv_ztt_i4_4x1_t dst = __riscv_ztt_mextract_i4_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_4(void) {
  __riscv_ztt_u4_1x4_t s0 = __riscv_ztt_mzero_m_u4_1x4();
  __riscv_ztt_u4_1x2_t dst = __riscv_ztt_mextract_u4_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_5(void) {
  __riscv_ztt_u4_4x1_t s0 = __riscv_ztt_mzero_m_u4_4x1();
  __riscv_ztt_u4_2x1_t dst = __riscv_ztt_mextract_u4_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_6(void) {
  __riscv_ztt_u4_1x8_t s0 = __riscv_ztt_mzero_m_u4_1x8();
  __riscv_ztt_u4_1x4_t dst = __riscv_ztt_mextract_u4_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_7(void) {
  __riscv_ztt_u4_8x1_t s0 = __riscv_ztt_mzero_m_u4_8x1();
  __riscv_ztt_u4_4x1_t dst = __riscv_ztt_mextract_u4_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_8(void) {
  __riscv_ztt_i8_1x2_t s0 = __riscv_ztt_mzero_m_i8_1x2();
  __riscv_ztt_i8_1x1_t dst = __riscv_ztt_mextract_i8_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_9(void) {
  __riscv_ztt_i8_1x4_t s0 = __riscv_ztt_mzero_m_i8_1x4();
  __riscv_ztt_i8_1x2_t dst = __riscv_ztt_mextract_i8_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_10(void) {
  __riscv_ztt_i8_4x1_t s0 = __riscv_ztt_mzero_m_i8_4x1();
  __riscv_ztt_i8_2x1_t dst = __riscv_ztt_mextract_i8_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_11(void) {
  __riscv_ztt_i8_1x8_t s0 = __riscv_ztt_mzero_m_i8_1x8();
  __riscv_ztt_i8_1x4_t dst = __riscv_ztt_mextract_i8_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_12(void) {
  __riscv_ztt_i8_8x1_t s0 = __riscv_ztt_mzero_m_i8_8x1();
  __riscv_ztt_i8_4x1_t dst = __riscv_ztt_mextract_i8_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_13(void) {
  __riscv_ztt_u8_1x2_t s0 = __riscv_ztt_mzero_m_u8_1x2();
  __riscv_ztt_u8_1x1_t dst = __riscv_ztt_mextract_u8_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_14(void) {
  __riscv_ztt_u8_1x4_t s0 = __riscv_ztt_mzero_m_u8_1x4();
  __riscv_ztt_u8_1x2_t dst = __riscv_ztt_mextract_u8_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_15(void) {
  __riscv_ztt_u8_4x1_t s0 = __riscv_ztt_mzero_m_u8_4x1();
  __riscv_ztt_u8_2x1_t dst = __riscv_ztt_mextract_u8_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_16(void) {
  __riscv_ztt_u8_1x8_t s0 = __riscv_ztt_mzero_m_u8_1x8();
  __riscv_ztt_u8_1x4_t dst = __riscv_ztt_mextract_u8_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_17(void) {
  __riscv_ztt_u8_8x1_t s0 = __riscv_ztt_mzero_m_u8_8x1();
  __riscv_ztt_u8_4x1_t dst = __riscv_ztt_mextract_u8_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_18(void) {
  __riscv_ztt_i16_1x2_t s0 = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_i16_1x1_t dst = __riscv_ztt_mextract_i16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_19(void) {
  __riscv_ztt_i16_1x4_t s0 = __riscv_ztt_mzero_m_i16_1x4();
  __riscv_ztt_i16_1x2_t dst = __riscv_ztt_mextract_i16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_20(void) {
  __riscv_ztt_i16_4x1_t s0 = __riscv_ztt_mzero_m_i16_4x1();
  __riscv_ztt_i16_2x1_t dst = __riscv_ztt_mextract_i16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_21(void) {
  __riscv_ztt_u16_1x2_t s0 = __riscv_ztt_mzero_m_u16_1x2();
  __riscv_ztt_u16_1x1_t dst = __riscv_ztt_mextract_u16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_22(void) {
  __riscv_ztt_u16_1x4_t s0 = __riscv_ztt_mzero_m_u16_1x4();
  __riscv_ztt_u16_1x2_t dst = __riscv_ztt_mextract_u16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_23(void) {
  __riscv_ztt_u16_4x1_t s0 = __riscv_ztt_mzero_m_u16_4x1();
  __riscv_ztt_u16_2x1_t dst = __riscv_ztt_mextract_u16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_24(void) {
  __riscv_ztt_i32_1x2_t s0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_mextract_i32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_25(void) {
  __riscv_ztt_u32_1x2_t s0 = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_u32_1x1_t dst = __riscv_ztt_mextract_u32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_26(void) {
  __riscv_ztt_f16_1x2_t s0 = __riscv_ztt_mzero_m_f16_1x2();
  __riscv_ztt_f16_1x1_t dst = __riscv_ztt_mextract_f16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_27(void) {
  __riscv_ztt_f16_1x4_t s0 = __riscv_ztt_mzero_m_f16_1x4();
  __riscv_ztt_f16_1x2_t dst = __riscv_ztt_mextract_f16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_28(void) {
  __riscv_ztt_f16_4x1_t s0 = __riscv_ztt_mzero_m_f16_4x1();
  __riscv_ztt_f16_2x1_t dst = __riscv_ztt_mextract_f16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_29(void) {
  __riscv_ztt_bf16_1x2_t s0 = __riscv_ztt_mzero_m_bf16_1x2();
  __riscv_ztt_bf16_1x1_t dst = __riscv_ztt_mextract_bf16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_30(void) {
  __riscv_ztt_bf16_1x4_t s0 = __riscv_ztt_mzero_m_bf16_1x4();
  __riscv_ztt_bf16_1x2_t dst = __riscv_ztt_mextract_bf16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_31(void) {
  __riscv_ztt_bf16_4x1_t s0 = __riscv_ztt_mzero_m_bf16_4x1();
  __riscv_ztt_bf16_2x1_t dst = __riscv_ztt_mextract_bf16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void test_32(void) {
  __riscv_ztt_f32_1x2_t s0 = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_1x1_t dst = __riscv_ztt_mextract_f32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_33(void) {
  __riscv_ztt_i4_1x8_t s0 = __riscv_ztt_mzero_m_i4_1x8();
  __riscv_ztt_i4_1x4_t dst = __riscv_ztt_mextract_i4_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_34(void) {
  __riscv_ztt_i4_8x1_t s0 = __riscv_ztt_mzero_m_i4_8x1();
  __riscv_ztt_i4_4x1_t dst = __riscv_ztt_mextract_i4_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_35(void) {
  __riscv_ztt_u4_1x8_t s0 = __riscv_ztt_mzero_m_u4_1x8();
  __riscv_ztt_u4_1x4_t dst = __riscv_ztt_mextract_u4_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_36(void) {
  __riscv_ztt_u4_8x1_t s0 = __riscv_ztt_mzero_m_u4_8x1();
  __riscv_ztt_u4_4x1_t dst = __riscv_ztt_mextract_u4_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_37(void) {
  __riscv_ztt_i8_1x4_t s0 = __riscv_ztt_mzero_m_i8_1x4();
  __riscv_ztt_i8_1x2_t dst = __riscv_ztt_mextract_i8_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_38(void) {
  __riscv_ztt_i8_4x1_t s0 = __riscv_ztt_mzero_m_i8_4x1();
  __riscv_ztt_i8_2x1_t dst = __riscv_ztt_mextract_i8_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_39(void) {
  __riscv_ztt_i8_1x8_t s0 = __riscv_ztt_mzero_m_i8_1x8();
  __riscv_ztt_i8_1x4_t dst = __riscv_ztt_mextract_i8_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_40(void) {
  __riscv_ztt_i8_8x1_t s0 = __riscv_ztt_mzero_m_i8_8x1();
  __riscv_ztt_i8_4x1_t dst = __riscv_ztt_mextract_i8_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_41(void) {
  __riscv_ztt_u8_1x4_t s0 = __riscv_ztt_mzero_m_u8_1x4();
  __riscv_ztt_u8_1x2_t dst = __riscv_ztt_mextract_u8_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_42(void) {
  __riscv_ztt_u8_4x1_t s0 = __riscv_ztt_mzero_m_u8_4x1();
  __riscv_ztt_u8_2x1_t dst = __riscv_ztt_mextract_u8_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_43(void) {
  __riscv_ztt_u8_1x8_t s0 = __riscv_ztt_mzero_m_u8_1x8();
  __riscv_ztt_u8_1x4_t dst = __riscv_ztt_mextract_u8_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_44(void) {
  __riscv_ztt_u8_8x1_t s0 = __riscv_ztt_mzero_m_u8_8x1();
  __riscv_ztt_u8_4x1_t dst = __riscv_ztt_mextract_u8_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_45(void) {
  __riscv_ztt_i16_1x2_t s0 = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_i16_1x1_t dst = __riscv_ztt_mextract_i16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_46(void) {
  __riscv_ztt_i16_1x4_t s0 = __riscv_ztt_mzero_m_i16_1x4();
  __riscv_ztt_i16_1x2_t dst = __riscv_ztt_mextract_i16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_47(void) {
  __riscv_ztt_i16_4x1_t s0 = __riscv_ztt_mzero_m_i16_4x1();
  __riscv_ztt_i16_2x1_t dst = __riscv_ztt_mextract_i16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_48(void) {
  __riscv_ztt_i16_1x8_t s0 = __riscv_ztt_mzero_m_i16_1x8();
  __riscv_ztt_i16_1x4_t dst = __riscv_ztt_mextract_i16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_49(void) {
  __riscv_ztt_i16_8x1_t s0 = __riscv_ztt_mzero_m_i16_8x1();
  __riscv_ztt_i16_4x1_t dst = __riscv_ztt_mextract_i16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_50(void) {
  __riscv_ztt_u16_1x2_t s0 = __riscv_ztt_mzero_m_u16_1x2();
  __riscv_ztt_u16_1x1_t dst = __riscv_ztt_mextract_u16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_51(void) {
  __riscv_ztt_u16_1x4_t s0 = __riscv_ztt_mzero_m_u16_1x4();
  __riscv_ztt_u16_1x2_t dst = __riscv_ztt_mextract_u16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_52(void) {
  __riscv_ztt_u16_4x1_t s0 = __riscv_ztt_mzero_m_u16_4x1();
  __riscv_ztt_u16_2x1_t dst = __riscv_ztt_mextract_u16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_53(void) {
  __riscv_ztt_u16_1x8_t s0 = __riscv_ztt_mzero_m_u16_1x8();
  __riscv_ztt_u16_1x4_t dst = __riscv_ztt_mextract_u16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_54(void) {
  __riscv_ztt_u16_8x1_t s0 = __riscv_ztt_mzero_m_u16_8x1();
  __riscv_ztt_u16_4x1_t dst = __riscv_ztt_mextract_u16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_55(void) {
  __riscv_ztt_i32_1x2_t s0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_mextract_i32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_56(void) {
  __riscv_ztt_i32_1x4_t s0 = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_i32_1x2_t dst = __riscv_ztt_mextract_i32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_57(void) {
  __riscv_ztt_i32_4x1_t s0 = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_2x1_t dst = __riscv_ztt_mextract_i32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_58(void) {
  __riscv_ztt_u32_1x2_t s0 = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_u32_1x1_t dst = __riscv_ztt_mextract_u32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_59(void) {
  __riscv_ztt_u32_1x4_t s0 = __riscv_ztt_mzero_m_u32_1x4();
  __riscv_ztt_u32_1x2_t dst = __riscv_ztt_mextract_u32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_60(void) {
  __riscv_ztt_u32_4x1_t s0 = __riscv_ztt_mzero_m_u32_4x1();
  __riscv_ztt_u32_2x1_t dst = __riscv_ztt_mextract_u32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_61(void) {
  __riscv_ztt_i64_1x2_t s0 = __riscv_ztt_mzero_m_i64_1x2();
  __riscv_ztt_i64_1x1_t dst = __riscv_ztt_mextract_i64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_62(void) {
  __riscv_ztt_u64_1x2_t s0 = __riscv_ztt_mzero_m_u64_1x2();
  __riscv_ztt_u64_1x1_t dst = __riscv_ztt_mextract_u64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_63(void) {
  __riscv_ztt_f16_1x2_t s0 = __riscv_ztt_mzero_m_f16_1x2();
  __riscv_ztt_f16_1x1_t dst = __riscv_ztt_mextract_f16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_64(void) {
  __riscv_ztt_f16_1x4_t s0 = __riscv_ztt_mzero_m_f16_1x4();
  __riscv_ztt_f16_1x2_t dst = __riscv_ztt_mextract_f16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_65(void) {
  __riscv_ztt_f16_4x1_t s0 = __riscv_ztt_mzero_m_f16_4x1();
  __riscv_ztt_f16_2x1_t dst = __riscv_ztt_mextract_f16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_66(void) {
  __riscv_ztt_f16_1x8_t s0 = __riscv_ztt_mzero_m_f16_1x8();
  __riscv_ztt_f16_1x4_t dst = __riscv_ztt_mextract_f16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_67(void) {
  __riscv_ztt_f16_8x1_t s0 = __riscv_ztt_mzero_m_f16_8x1();
  __riscv_ztt_f16_4x1_t dst = __riscv_ztt_mextract_f16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_68(void) {
  __riscv_ztt_bf16_1x2_t s0 = __riscv_ztt_mzero_m_bf16_1x2();
  __riscv_ztt_bf16_1x1_t dst = __riscv_ztt_mextract_bf16_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_69(void) {
  __riscv_ztt_bf16_1x4_t s0 = __riscv_ztt_mzero_m_bf16_1x4();
  __riscv_ztt_bf16_1x2_t dst = __riscv_ztt_mextract_bf16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_70(void) {
  __riscv_ztt_bf16_4x1_t s0 = __riscv_ztt_mzero_m_bf16_4x1();
  __riscv_ztt_bf16_2x1_t dst = __riscv_ztt_mextract_bf16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_71(void) {
  __riscv_ztt_bf16_1x8_t s0 = __riscv_ztt_mzero_m_bf16_1x8();
  __riscv_ztt_bf16_1x4_t dst = __riscv_ztt_mextract_bf16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_72(void) {
  __riscv_ztt_bf16_8x1_t s0 = __riscv_ztt_mzero_m_bf16_8x1();
  __riscv_ztt_bf16_4x1_t dst = __riscv_ztt_mextract_bf16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_73(void) {
  __riscv_ztt_f32_1x2_t s0 = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_1x1_t dst = __riscv_ztt_mextract_f32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_74(void) {
  __riscv_ztt_f32_1x4_t s0 = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_f32_1x2_t dst = __riscv_ztt_mextract_f32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_75(void) {
  __riscv_ztt_f32_4x1_t s0 = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_f32_2x1_t dst = __riscv_ztt_mextract_f32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 16
void test_76(void) {
  __riscv_ztt_f64_1x2_t s0 = __riscv_ztt_mzero_m_f64_1x2();
  __riscv_ztt_f64_1x1_t dst = __riscv_ztt_mextract_f64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_77(void) {
  __riscv_ztt_i8_1x8_t s0 = __riscv_ztt_mzero_m_i8_1x8();
  __riscv_ztt_i8_1x4_t dst = __riscv_ztt_mextract_i8_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_78(void) {
  __riscv_ztt_i8_8x1_t s0 = __riscv_ztt_mzero_m_i8_8x1();
  __riscv_ztt_i8_4x1_t dst = __riscv_ztt_mextract_i8_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_79(void) {
  __riscv_ztt_u8_1x8_t s0 = __riscv_ztt_mzero_m_u8_1x8();
  __riscv_ztt_u8_1x4_t dst = __riscv_ztt_mextract_u8_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_80(void) {
  __riscv_ztt_u8_8x1_t s0 = __riscv_ztt_mzero_m_u8_8x1();
  __riscv_ztt_u8_4x1_t dst = __riscv_ztt_mextract_u8_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_81(void) {
  __riscv_ztt_i16_1x4_t s0 = __riscv_ztt_mzero_m_i16_1x4();
  __riscv_ztt_i16_1x2_t dst = __riscv_ztt_mextract_i16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_82(void) {
  __riscv_ztt_i16_4x1_t s0 = __riscv_ztt_mzero_m_i16_4x1();
  __riscv_ztt_i16_2x1_t dst = __riscv_ztt_mextract_i16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_83(void) {
  __riscv_ztt_i16_1x8_t s0 = __riscv_ztt_mzero_m_i16_1x8();
  __riscv_ztt_i16_1x4_t dst = __riscv_ztt_mextract_i16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_84(void) {
  __riscv_ztt_i16_8x1_t s0 = __riscv_ztt_mzero_m_i16_8x1();
  __riscv_ztt_i16_4x1_t dst = __riscv_ztt_mextract_i16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_85(void) {
  __riscv_ztt_u16_1x4_t s0 = __riscv_ztt_mzero_m_u16_1x4();
  __riscv_ztt_u16_1x2_t dst = __riscv_ztt_mextract_u16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_86(void) {
  __riscv_ztt_u16_4x1_t s0 = __riscv_ztt_mzero_m_u16_4x1();
  __riscv_ztt_u16_2x1_t dst = __riscv_ztt_mextract_u16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_87(void) {
  __riscv_ztt_u16_1x8_t s0 = __riscv_ztt_mzero_m_u16_1x8();
  __riscv_ztt_u16_1x4_t dst = __riscv_ztt_mextract_u16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_88(void) {
  __riscv_ztt_u16_8x1_t s0 = __riscv_ztt_mzero_m_u16_8x1();
  __riscv_ztt_u16_4x1_t dst = __riscv_ztt_mextract_u16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_89(void) {
  __riscv_ztt_i32_1x2_t s0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_mextract_i32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_90(void) {
  __riscv_ztt_i32_1x4_t s0 = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_i32_1x2_t dst = __riscv_ztt_mextract_i32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_91(void) {
  __riscv_ztt_i32_4x1_t s0 = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_2x1_t dst = __riscv_ztt_mextract_i32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_92(void) {
  __riscv_ztt_i32_1x8_t s0 = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_i32_1x4_t dst = __riscv_ztt_mextract_i32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_93(void) {
  __riscv_ztt_i32_8x1_t s0 = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_i32_4x1_t dst = __riscv_ztt_mextract_i32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_94(void) {
  __riscv_ztt_u32_1x2_t s0 = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_u32_1x1_t dst = __riscv_ztt_mextract_u32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_95(void) {
  __riscv_ztt_u32_1x4_t s0 = __riscv_ztt_mzero_m_u32_1x4();
  __riscv_ztt_u32_1x2_t dst = __riscv_ztt_mextract_u32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_96(void) {
  __riscv_ztt_u32_4x1_t s0 = __riscv_ztt_mzero_m_u32_4x1();
  __riscv_ztt_u32_2x1_t dst = __riscv_ztt_mextract_u32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_97(void) {
  __riscv_ztt_u32_1x8_t s0 = __riscv_ztt_mzero_m_u32_1x8();
  __riscv_ztt_u32_1x4_t dst = __riscv_ztt_mextract_u32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_98(void) {
  __riscv_ztt_u32_8x1_t s0 = __riscv_ztt_mzero_m_u32_8x1();
  __riscv_ztt_u32_4x1_t dst = __riscv_ztt_mextract_u32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_99(void) {
  __riscv_ztt_i64_1x2_t s0 = __riscv_ztt_mzero_m_i64_1x2();
  __riscv_ztt_i64_1x1_t dst = __riscv_ztt_mextract_i64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_100(void) {
  __riscv_ztt_i64_1x4_t s0 = __riscv_ztt_mzero_m_i64_1x4();
  __riscv_ztt_i64_1x2_t dst = __riscv_ztt_mextract_i64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_101(void) {
  __riscv_ztt_i64_4x1_t s0 = __riscv_ztt_mzero_m_i64_4x1();
  __riscv_ztt_i64_2x1_t dst = __riscv_ztt_mextract_i64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_102(void) {
  __riscv_ztt_u64_1x2_t s0 = __riscv_ztt_mzero_m_u64_1x2();
  __riscv_ztt_u64_1x1_t dst = __riscv_ztt_mextract_u64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_103(void) {
  __riscv_ztt_u64_1x4_t s0 = __riscv_ztt_mzero_m_u64_1x4();
  __riscv_ztt_u64_1x2_t dst = __riscv_ztt_mextract_u64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_104(void) {
  __riscv_ztt_u64_4x1_t s0 = __riscv_ztt_mzero_m_u64_4x1();
  __riscv_ztt_u64_2x1_t dst = __riscv_ztt_mextract_u64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_105(void) {
  __riscv_ztt_i128_1x2_t s0 = __riscv_ztt_mzero_m_i128_1x2();
  __riscv_ztt_i128_1x1_t dst = __riscv_ztt_mextract_i128_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_106(void) {
  __riscv_ztt_u128_1x2_t s0 = __riscv_ztt_mzero_m_u128_1x2();
  __riscv_ztt_u128_1x1_t dst = __riscv_ztt_mextract_u128_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_107(void) {
  __riscv_ztt_f16_1x4_t s0 = __riscv_ztt_mzero_m_f16_1x4();
  __riscv_ztt_f16_1x2_t dst = __riscv_ztt_mextract_f16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_108(void) {
  __riscv_ztt_f16_4x1_t s0 = __riscv_ztt_mzero_m_f16_4x1();
  __riscv_ztt_f16_2x1_t dst = __riscv_ztt_mextract_f16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_109(void) {
  __riscv_ztt_f16_1x8_t s0 = __riscv_ztt_mzero_m_f16_1x8();
  __riscv_ztt_f16_1x4_t dst = __riscv_ztt_mextract_f16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_110(void) {
  __riscv_ztt_f16_8x1_t s0 = __riscv_ztt_mzero_m_f16_8x1();
  __riscv_ztt_f16_4x1_t dst = __riscv_ztt_mextract_f16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_111(void) {
  __riscv_ztt_bf16_1x4_t s0 = __riscv_ztt_mzero_m_bf16_1x4();
  __riscv_ztt_bf16_1x2_t dst = __riscv_ztt_mextract_bf16_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_112(void) {
  __riscv_ztt_bf16_4x1_t s0 = __riscv_ztt_mzero_m_bf16_4x1();
  __riscv_ztt_bf16_2x1_t dst = __riscv_ztt_mextract_bf16_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_113(void) {
  __riscv_ztt_bf16_1x8_t s0 = __riscv_ztt_mzero_m_bf16_1x8();
  __riscv_ztt_bf16_1x4_t dst = __riscv_ztt_mextract_bf16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_114(void) {
  __riscv_ztt_bf16_8x1_t s0 = __riscv_ztt_mzero_m_bf16_8x1();
  __riscv_ztt_bf16_4x1_t dst = __riscv_ztt_mextract_bf16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_115(void) {
  __riscv_ztt_f32_1x2_t s0 = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_1x1_t dst = __riscv_ztt_mextract_f32_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_116(void) {
  __riscv_ztt_f32_1x4_t s0 = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_f32_1x2_t dst = __riscv_ztt_mextract_f32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_117(void) {
  __riscv_ztt_f32_4x1_t s0 = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_f32_2x1_t dst = __riscv_ztt_mextract_f32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_118(void) {
  __riscv_ztt_f32_1x8_t s0 = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_f32_1x4_t dst = __riscv_ztt_mextract_f32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_119(void) {
  __riscv_ztt_f32_8x1_t s0 = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_f32_4x1_t dst = __riscv_ztt_mextract_f32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_120(void) {
  __riscv_ztt_f64_1x2_t s0 = __riscv_ztt_mzero_m_f64_1x2();
  __riscv_ztt_f64_1x1_t dst = __riscv_ztt_mextract_f64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_121(void) {
  __riscv_ztt_f64_1x4_t s0 = __riscv_ztt_mzero_m_f64_1x4();
  __riscv_ztt_f64_1x2_t dst = __riscv_ztt_mextract_f64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 32
void test_122(void) {
  __riscv_ztt_f64_4x1_t s0 = __riscv_ztt_mzero_m_f64_4x1();
  __riscv_ztt_f64_2x1_t dst = __riscv_ztt_mextract_f64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_123(void) {
  __riscv_ztt_i16_1x8_t s0 = __riscv_ztt_mzero_m_i16_1x8();
  __riscv_ztt_i16_1x4_t dst = __riscv_ztt_mextract_i16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_124(void) {
  __riscv_ztt_i16_8x1_t s0 = __riscv_ztt_mzero_m_i16_8x1();
  __riscv_ztt_i16_4x1_t dst = __riscv_ztt_mextract_i16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_125(void) {
  __riscv_ztt_u16_1x8_t s0 = __riscv_ztt_mzero_m_u16_1x8();
  __riscv_ztt_u16_1x4_t dst = __riscv_ztt_mextract_u16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_126(void) {
  __riscv_ztt_u16_8x1_t s0 = __riscv_ztt_mzero_m_u16_8x1();
  __riscv_ztt_u16_4x1_t dst = __riscv_ztt_mextract_u16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_127(void) {
  __riscv_ztt_i32_1x4_t s0 = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_i32_1x2_t dst = __riscv_ztt_mextract_i32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_128(void) {
  __riscv_ztt_i32_4x1_t s0 = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_2x1_t dst = __riscv_ztt_mextract_i32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_129(void) {
  __riscv_ztt_i32_1x8_t s0 = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_i32_1x4_t dst = __riscv_ztt_mextract_i32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_130(void) {
  __riscv_ztt_i32_8x1_t s0 = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_i32_4x1_t dst = __riscv_ztt_mextract_i32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_131(void) {
  __riscv_ztt_u32_1x4_t s0 = __riscv_ztt_mzero_m_u32_1x4();
  __riscv_ztt_u32_1x2_t dst = __riscv_ztt_mextract_u32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_132(void) {
  __riscv_ztt_u32_4x1_t s0 = __riscv_ztt_mzero_m_u32_4x1();
  __riscv_ztt_u32_2x1_t dst = __riscv_ztt_mextract_u32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_133(void) {
  __riscv_ztt_u32_1x8_t s0 = __riscv_ztt_mzero_m_u32_1x8();
  __riscv_ztt_u32_1x4_t dst = __riscv_ztt_mextract_u32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_134(void) {
  __riscv_ztt_u32_8x1_t s0 = __riscv_ztt_mzero_m_u32_8x1();
  __riscv_ztt_u32_4x1_t dst = __riscv_ztt_mextract_u32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_135(void) {
  __riscv_ztt_i64_1x2_t s0 = __riscv_ztt_mzero_m_i64_1x2();
  __riscv_ztt_i64_1x1_t dst = __riscv_ztt_mextract_i64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_136(void) {
  __riscv_ztt_i64_1x4_t s0 = __riscv_ztt_mzero_m_i64_1x4();
  __riscv_ztt_i64_1x2_t dst = __riscv_ztt_mextract_i64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_137(void) {
  __riscv_ztt_i64_4x1_t s0 = __riscv_ztt_mzero_m_i64_4x1();
  __riscv_ztt_i64_2x1_t dst = __riscv_ztt_mextract_i64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_138(void) {
  __riscv_ztt_i64_1x8_t s0 = __riscv_ztt_mzero_m_i64_1x8();
  __riscv_ztt_i64_1x4_t dst = __riscv_ztt_mextract_i64_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_139(void) {
  __riscv_ztt_i64_8x1_t s0 = __riscv_ztt_mzero_m_i64_8x1();
  __riscv_ztt_i64_4x1_t dst = __riscv_ztt_mextract_i64_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_140(void) {
  __riscv_ztt_u64_1x2_t s0 = __riscv_ztt_mzero_m_u64_1x2();
  __riscv_ztt_u64_1x1_t dst = __riscv_ztt_mextract_u64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_141(void) {
  __riscv_ztt_u64_1x4_t s0 = __riscv_ztt_mzero_m_u64_1x4();
  __riscv_ztt_u64_1x2_t dst = __riscv_ztt_mextract_u64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_142(void) {
  __riscv_ztt_u64_4x1_t s0 = __riscv_ztt_mzero_m_u64_4x1();
  __riscv_ztt_u64_2x1_t dst = __riscv_ztt_mextract_u64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_143(void) {
  __riscv_ztt_u64_1x8_t s0 = __riscv_ztt_mzero_m_u64_1x8();
  __riscv_ztt_u64_1x4_t dst = __riscv_ztt_mextract_u64_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_144(void) {
  __riscv_ztt_u64_8x1_t s0 = __riscv_ztt_mzero_m_u64_8x1();
  __riscv_ztt_u64_4x1_t dst = __riscv_ztt_mextract_u64_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_145(void) {
  __riscv_ztt_i128_1x2_t s0 = __riscv_ztt_mzero_m_i128_1x2();
  __riscv_ztt_i128_1x1_t dst = __riscv_ztt_mextract_i128_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_146(void) {
  __riscv_ztt_i128_1x4_t s0 = __riscv_ztt_mzero_m_i128_1x4();
  __riscv_ztt_i128_1x2_t dst = __riscv_ztt_mextract_i128_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_147(void) {
  __riscv_ztt_i128_4x1_t s0 = __riscv_ztt_mzero_m_i128_4x1();
  __riscv_ztt_i128_2x1_t dst = __riscv_ztt_mextract_i128_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_148(void) {
  __riscv_ztt_u128_1x2_t s0 = __riscv_ztt_mzero_m_u128_1x2();
  __riscv_ztt_u128_1x1_t dst = __riscv_ztt_mextract_u128_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_149(void) {
  __riscv_ztt_u128_1x4_t s0 = __riscv_ztt_mzero_m_u128_1x4();
  __riscv_ztt_u128_1x2_t dst = __riscv_ztt_mextract_u128_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_150(void) {
  __riscv_ztt_u128_4x1_t s0 = __riscv_ztt_mzero_m_u128_4x1();
  __riscv_ztt_u128_2x1_t dst = __riscv_ztt_mextract_u128_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_151(void) {
  __riscv_ztt_f16_1x8_t s0 = __riscv_ztt_mzero_m_f16_1x8();
  __riscv_ztt_f16_1x4_t dst = __riscv_ztt_mextract_f16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_152(void) {
  __riscv_ztt_f16_8x1_t s0 = __riscv_ztt_mzero_m_f16_8x1();
  __riscv_ztt_f16_4x1_t dst = __riscv_ztt_mextract_f16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_153(void) {
  __riscv_ztt_bf16_1x8_t s0 = __riscv_ztt_mzero_m_bf16_1x8();
  __riscv_ztt_bf16_1x4_t dst = __riscv_ztt_mextract_bf16_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_154(void) {
  __riscv_ztt_bf16_8x1_t s0 = __riscv_ztt_mzero_m_bf16_8x1();
  __riscv_ztt_bf16_4x1_t dst = __riscv_ztt_mextract_bf16_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_155(void) {
  __riscv_ztt_f32_1x4_t s0 = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_f32_1x2_t dst = __riscv_ztt_mextract_f32_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_156(void) {
  __riscv_ztt_f32_4x1_t s0 = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_f32_2x1_t dst = __riscv_ztt_mextract_f32_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_157(void) {
  __riscv_ztt_f32_1x8_t s0 = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_f32_1x4_t dst = __riscv_ztt_mextract_f32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_158(void) {
  __riscv_ztt_f32_8x1_t s0 = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_f32_4x1_t dst = __riscv_ztt_mextract_f32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_159(void) {
  __riscv_ztt_f64_1x2_t s0 = __riscv_ztt_mzero_m_f64_1x2();
  __riscv_ztt_f64_1x1_t dst = __riscv_ztt_mextract_f64_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_160(void) {
  __riscv_ztt_f64_1x4_t s0 = __riscv_ztt_mzero_m_f64_1x4();
  __riscv_ztt_f64_1x2_t dst = __riscv_ztt_mextract_f64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_161(void) {
  __riscv_ztt_f64_4x1_t s0 = __riscv_ztt_mzero_m_f64_4x1();
  __riscv_ztt_f64_2x1_t dst = __riscv_ztt_mextract_f64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_162(void) {
  __riscv_ztt_f64_1x8_t s0 = __riscv_ztt_mzero_m_f64_1x8();
  __riscv_ztt_f64_1x4_t dst = __riscv_ztt_mextract_f64_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 64
void test_163(void) {
  __riscv_ztt_f64_8x1_t s0 = __riscv_ztt_mzero_m_f64_8x1();
  __riscv_ztt_f64_4x1_t dst = __riscv_ztt_mextract_f64_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_164(void) {
  __riscv_ztt_i32_1x8_t s0 = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_i32_1x4_t dst = __riscv_ztt_mextract_i32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_165(void) {
  __riscv_ztt_i32_8x1_t s0 = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_i32_4x1_t dst = __riscv_ztt_mextract_i32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_166(void) {
  __riscv_ztt_u32_1x8_t s0 = __riscv_ztt_mzero_m_u32_1x8();
  __riscv_ztt_u32_1x4_t dst = __riscv_ztt_mextract_u32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_167(void) {
  __riscv_ztt_u32_8x1_t s0 = __riscv_ztt_mzero_m_u32_8x1();
  __riscv_ztt_u32_4x1_t dst = __riscv_ztt_mextract_u32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_168(void) {
  __riscv_ztt_i64_1x4_t s0 = __riscv_ztt_mzero_m_i64_1x4();
  __riscv_ztt_i64_1x2_t dst = __riscv_ztt_mextract_i64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_169(void) {
  __riscv_ztt_i64_4x1_t s0 = __riscv_ztt_mzero_m_i64_4x1();
  __riscv_ztt_i64_2x1_t dst = __riscv_ztt_mextract_i64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_170(void) {
  __riscv_ztt_i64_1x8_t s0 = __riscv_ztt_mzero_m_i64_1x8();
  __riscv_ztt_i64_1x4_t dst = __riscv_ztt_mextract_i64_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_171(void) {
  __riscv_ztt_i64_8x1_t s0 = __riscv_ztt_mzero_m_i64_8x1();
  __riscv_ztt_i64_4x1_t dst = __riscv_ztt_mextract_i64_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_172(void) {
  __riscv_ztt_u64_1x4_t s0 = __riscv_ztt_mzero_m_u64_1x4();
  __riscv_ztt_u64_1x2_t dst = __riscv_ztt_mextract_u64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_173(void) {
  __riscv_ztt_u64_4x1_t s0 = __riscv_ztt_mzero_m_u64_4x1();
  __riscv_ztt_u64_2x1_t dst = __riscv_ztt_mextract_u64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_174(void) {
  __riscv_ztt_u64_1x8_t s0 = __riscv_ztt_mzero_m_u64_1x8();
  __riscv_ztt_u64_1x4_t dst = __riscv_ztt_mextract_u64_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_175(void) {
  __riscv_ztt_u64_8x1_t s0 = __riscv_ztt_mzero_m_u64_8x1();
  __riscv_ztt_u64_4x1_t dst = __riscv_ztt_mextract_u64_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_176(void) {
  __riscv_ztt_i128_1x2_t s0 = __riscv_ztt_mzero_m_i128_1x2();
  __riscv_ztt_i128_1x1_t dst = __riscv_ztt_mextract_i128_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_177(void) {
  __riscv_ztt_i128_1x4_t s0 = __riscv_ztt_mzero_m_i128_1x4();
  __riscv_ztt_i128_1x2_t dst = __riscv_ztt_mextract_i128_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_178(void) {
  __riscv_ztt_i128_4x1_t s0 = __riscv_ztt_mzero_m_i128_4x1();
  __riscv_ztt_i128_2x1_t dst = __riscv_ztt_mextract_i128_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_179(void) {
  __riscv_ztt_i128_1x8_t s0 = __riscv_ztt_mzero_m_i128_1x8();
  __riscv_ztt_i128_1x4_t dst = __riscv_ztt_mextract_i128_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_180(void) {
  __riscv_ztt_i128_8x1_t s0 = __riscv_ztt_mzero_m_i128_8x1();
  __riscv_ztt_i128_4x1_t dst = __riscv_ztt_mextract_i128_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_181(void) {
  __riscv_ztt_u128_1x2_t s0 = __riscv_ztt_mzero_m_u128_1x2();
  __riscv_ztt_u128_1x1_t dst = __riscv_ztt_mextract_u128_1x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_182(void) {
  __riscv_ztt_u128_1x4_t s0 = __riscv_ztt_mzero_m_u128_1x4();
  __riscv_ztt_u128_1x2_t dst = __riscv_ztt_mextract_u128_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_183(void) {
  __riscv_ztt_u128_4x1_t s0 = __riscv_ztt_mzero_m_u128_4x1();
  __riscv_ztt_u128_2x1_t dst = __riscv_ztt_mextract_u128_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_184(void) {
  __riscv_ztt_u128_1x8_t s0 = __riscv_ztt_mzero_m_u128_1x8();
  __riscv_ztt_u128_1x4_t dst = __riscv_ztt_mextract_u128_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_185(void) {
  __riscv_ztt_u128_8x1_t s0 = __riscv_ztt_mzero_m_u128_8x1();
  __riscv_ztt_u128_4x1_t dst = __riscv_ztt_mextract_u128_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_186(void) {
  __riscv_ztt_f32_1x8_t s0 = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_f32_1x4_t dst = __riscv_ztt_mextract_f32_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_187(void) {
  __riscv_ztt_f32_8x1_t s0 = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_f32_4x1_t dst = __riscv_ztt_mextract_f32_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_188(void) {
  __riscv_ztt_f64_1x4_t s0 = __riscv_ztt_mzero_m_f64_1x4();
  __riscv_ztt_f64_1x2_t dst = __riscv_ztt_mextract_f64_1x2(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_189(void) {
  __riscv_ztt_f64_4x1_t s0 = __riscv_ztt_mzero_m_f64_4x1();
  __riscv_ztt_f64_2x1_t dst = __riscv_ztt_mextract_f64_2x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_190(void) {
  __riscv_ztt_f64_1x8_t s0 = __riscv_ztt_mzero_m_f64_1x8();
  __riscv_ztt_f64_1x4_t dst = __riscv_ztt_mextract_f64_1x4(s0, 1);
  (void)dst;
}
#endif

#if UDS == 128
void test_191(void) {
  __riscv_ztt_f64_8x1_t s0 = __riscv_ztt_mzero_m_f64_8x1();
  __riscv_ztt_f64_4x1_t dst = __riscv_ztt_mextract_f64_4x1(s0, 1);
  (void)dst;
}
#endif

#if UDS == 8
void invalid_operands(int index) {
  __riscv_ztt_i32_1x2_t a0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x4_t wrong_shape = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_u32_1x2_t other_type = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_f32_1x2_t fp = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i16_1x2_t narrow = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_bf16_1x2_t bf = __riscv_ztt_mzero_m_bf16_1x2();
  __riscv_ztt_i32_4x1_t column = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_1x1_t integer = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mextract_i32_1x1(acc, 0); // expected-error {{requires an M matrix type}}
  __riscv_ztt_mextract_i32_1x1(wrong_shape, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(a0, 2); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(a0, -1); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(other_type, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  // Isolate datatype identity from shape, including signedness and float format.
  __riscv_ztt_mextract_i32_1x1(fp, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(narrow, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_f16_1x1(bf, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  // Same area is insufficient: the concatenation direction must agree.
  __riscv_ztt_mextract_i32_1x2(column, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_2x1(wrong_shape, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(integer, 0); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(a0, index); // expected-error {{must be a constant integer}}
  __riscv_ztt_mextract_i32_1x1(a0, 0x100000000ULL); // expected-error {{RISC-V Ztt mextract operands violate the required datatype or shape constraints}}
  __riscv_ztt_mextract_i32_1x1(a0); // expected-error {{too few arguments}}
  __riscv_ztt_mextract_i32_1x1(a0, 0, 1); // expected-error {{too many arguments}}
  __riscv_ztt_i32_1x1_t first = __riscv_ztt_mextract_i32_1x1(a0, 0);
  __riscv_ztt_i32_1x1_t second = __riscv_ztt_mextract_i32_1x1(a0, 2 - 1);
  __riscv_ztt_i32_2x1_t upper = __riscv_ztt_mextract_i32_2x1(column, 0);
  __riscv_ztt_i32_2x1_t lower = __riscv_ztt_mextract_i32_2x1(column, 1);
  __riscv_ztt_i32_2x1_t vertical = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_i32_1x1_t top = __riscv_ztt_mextract_i32_1x1(vertical, 0);
  __riscv_ztt_i32_1x1_t bottom = __riscv_ztt_mextract_i32_1x1(vertical, 1);
}
#endif
