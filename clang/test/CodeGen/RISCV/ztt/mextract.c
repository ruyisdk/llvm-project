// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS8
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS16
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS32
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS64
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS128
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS8
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS16
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS32
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS64
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS128
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS8
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS16
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS32
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS64
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS128
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS8
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS16
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS32
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS64
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -emit-llvm -o - %s | FileCheck %s --check-prefixes=COMMON,UDS128
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

#if UDS == 8
void test_0(void) {
  __riscv_ztt_i4_1x4_t s0 = __riscv_ztt_mzero_m_i4_1x4();
  __riscv_ztt_i4_1x2_t dst = __riscv_ztt_mextract_i4_1x2(s0, 0);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_0(
// UDS8: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mextract{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 4) {{%[^,]+}}, i{{32|64}} 0, i32 1073741828, i32 2)
#endif

#if UDS == 8
void test_1(void) {
  __riscv_ztt_i4_4x1_t s0 = __riscv_ztt_mzero_m_i4_4x1();
  __riscv_ztt_i4_2x1_t dst = __riscv_ztt_mextract_i4_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_1(
// UDS8: call target("riscv.ztt.m.i4", i4, 4, 2, 1) @llvm.riscv.ztt.mextract{{.*}}(target("riscv.ztt.m.i4", i4, 4, 4, 1) {{%[^,]+}}, i{{32|64}} 1, i32 1073741828, i32 2)
#endif

#if UDS == 8
void test_2(void) {
  __riscv_ztt_i4_1x8_t s0 = __riscv_ztt_mzero_m_i4_1x8();
  __riscv_ztt_i4_1x4_t dst = __riscv_ztt_mextract_i4_1x4(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_2(
// UDS8: call target("riscv.ztt.m.i4", i4, 4, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741828, i32 4)
#endif

#if UDS == 8
void test_3(void) {
  __riscv_ztt_i4_8x1_t s0 = __riscv_ztt_mzero_m_i4_8x1();
  __riscv_ztt_i4_4x1_t dst = __riscv_ztt_mextract_i4_4x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_3(
// UDS8: call target("riscv.ztt.m.i4", i4, 4, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741828, i32 4)
#endif

#if UDS == 8
void test_4(void) {
  __riscv_ztt_u4_1x4_t s0 = __riscv_ztt_mzero_m_u4_1x4();
  __riscv_ztt_u4_1x2_t dst = __riscv_ztt_mextract_u4_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_4(
// UDS8: call target("riscv.ztt.m.u4", i4, 4, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 4, i32 2)
#endif

#if UDS == 8
void test_5(void) {
  __riscv_ztt_u4_4x1_t s0 = __riscv_ztt_mzero_m_u4_4x1();
  __riscv_ztt_u4_2x1_t dst = __riscv_ztt_mextract_u4_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_5(
// UDS8: call target("riscv.ztt.m.u4", i4, 4, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 4, i32 2)
#endif

#if UDS == 8
void test_6(void) {
  __riscv_ztt_u4_1x8_t s0 = __riscv_ztt_mzero_m_u4_1x8();
  __riscv_ztt_u4_1x4_t dst = __riscv_ztt_mextract_u4_1x4(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_6(
// UDS8: call target("riscv.ztt.m.u4", i4, 4, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 4, i32 4)
#endif

#if UDS == 8
void test_7(void) {
  __riscv_ztt_u4_8x1_t s0 = __riscv_ztt_mzero_m_u4_8x1();
  __riscv_ztt_u4_4x1_t dst = __riscv_ztt_mextract_u4_4x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_7(
// UDS8: call target("riscv.ztt.m.u4", i4, 4, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 4, i32 4)
#endif

#if UDS == 8
void test_8(void) {
  __riscv_ztt_i8_1x2_t s0 = __riscv_ztt_mzero_m_i8_1x2();
  __riscv_ztt_i8_1x1_t dst = __riscv_ztt_mextract_i8_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_8(
// UDS8: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 1)
#endif

#if UDS == 8
void test_9(void) {
  __riscv_ztt_i8_1x4_t s0 = __riscv_ztt_mzero_m_i8_1x4();
  __riscv_ztt_i8_1x2_t dst = __riscv_ztt_mextract_i8_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_9(
// UDS8: call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 2)
#endif

#if UDS == 8
void test_10(void) {
  __riscv_ztt_i8_4x1_t s0 = __riscv_ztt_mzero_m_i8_4x1();
  __riscv_ztt_i8_2x1_t dst = __riscv_ztt_mextract_i8_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_10(
// UDS8: call target("riscv.ztt.m.i8", i8, 8, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 2)
#endif

#if UDS == 8
void test_11(void) {
  __riscv_ztt_i8_1x8_t s0 = __riscv_ztt_mzero_m_i8_1x8();
  __riscv_ztt_i8_1x4_t dst = __riscv_ztt_mextract_i8_1x4(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_11(
// UDS8: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 4)
#endif

#if UDS == 8
void test_12(void) {
  __riscv_ztt_i8_8x1_t s0 = __riscv_ztt_mzero_m_i8_8x1();
  __riscv_ztt_i8_4x1_t dst = __riscv_ztt_mextract_i8_4x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_12(
// UDS8: call target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 4)
#endif

#if UDS == 8
void test_13(void) {
  __riscv_ztt_u8_1x2_t s0 = __riscv_ztt_mzero_m_u8_1x2();
  __riscv_ztt_u8_1x1_t dst = __riscv_ztt_mextract_u8_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_13(
// UDS8: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 1)
#endif

#if UDS == 8
void test_14(void) {
  __riscv_ztt_u8_1x4_t s0 = __riscv_ztt_mzero_m_u8_1x4();
  __riscv_ztt_u8_1x2_t dst = __riscv_ztt_mextract_u8_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_14(
// UDS8: call target("riscv.ztt.m.u8", i8, 8, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 2)
#endif

#if UDS == 8
void test_15(void) {
  __riscv_ztt_u8_4x1_t s0 = __riscv_ztt_mzero_m_u8_4x1();
  __riscv_ztt_u8_2x1_t dst = __riscv_ztt_mextract_u8_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_15(
// UDS8: call target("riscv.ztt.m.u8", i8, 8, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 2)
#endif

#if UDS == 8
void test_16(void) {
  __riscv_ztt_u8_1x8_t s0 = __riscv_ztt_mzero_m_u8_1x8();
  __riscv_ztt_u8_1x4_t dst = __riscv_ztt_mextract_u8_1x4(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_16(
// UDS8: call target("riscv.ztt.m.u8", i8, 8, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 4)
#endif

#if UDS == 8
void test_17(void) {
  __riscv_ztt_u8_8x1_t s0 = __riscv_ztt_mzero_m_u8_8x1();
  __riscv_ztt_u8_4x1_t dst = __riscv_ztt_mextract_u8_4x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_17(
// UDS8: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 4)
#endif

#if UDS == 8
void test_18(void) {
  __riscv_ztt_i16_1x2_t s0 = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_i16_1x1_t dst = __riscv_ztt_mextract_i16_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_18(
// UDS8: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 1)
#endif

#if UDS == 8
void test_19(void) {
  __riscv_ztt_i16_1x4_t s0 = __riscv_ztt_mzero_m_i16_1x4();
  __riscv_ztt_i16_1x2_t dst = __riscv_ztt_mextract_i16_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_19(
// UDS8: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 2)
#endif

#if UDS == 8
void test_20(void) {
  __riscv_ztt_i16_4x1_t s0 = __riscv_ztt_mzero_m_i16_4x1();
  __riscv_ztt_i16_2x1_t dst = __riscv_ztt_mextract_i16_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_20(
// UDS8: call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 2)
#endif

#if UDS == 8
void test_21(void) {
  __riscv_ztt_u16_1x2_t s0 = __riscv_ztt_mzero_m_u16_1x2();
  __riscv_ztt_u16_1x1_t dst = __riscv_ztt_mextract_u16_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_21(
// UDS8: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 1)
#endif

#if UDS == 8
void test_22(void) {
  __riscv_ztt_u16_1x4_t s0 = __riscv_ztt_mzero_m_u16_1x4();
  __riscv_ztt_u16_1x2_t dst = __riscv_ztt_mextract_u16_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_22(
// UDS8: call target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 2)
#endif

#if UDS == 8
void test_23(void) {
  __riscv_ztt_u16_4x1_t s0 = __riscv_ztt_mzero_m_u16_4x1();
  __riscv_ztt_u16_2x1_t dst = __riscv_ztt_mextract_u16_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_23(
// UDS8: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 2)
#endif

#if UDS == 8
void test_24(void) {
  __riscv_ztt_i32_1x2_t s0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_mextract_i32_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_24(
// UDS8: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 1)
#endif

#if UDS == 8
void test_25(void) {
  __riscv_ztt_u32_1x2_t s0 = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_u32_1x1_t dst = __riscv_ztt_mextract_u32_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_25(
// UDS8: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 1)
#endif

#if UDS == 8
void test_26(void) {
  __riscv_ztt_f16_1x2_t s0 = __riscv_ztt_mzero_m_f16_1x2();
  __riscv_ztt_f16_1x1_t dst = __riscv_ztt_mextract_f16_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_26(
// UDS8: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 1)
#endif

#if UDS == 8
void test_27(void) {
  __riscv_ztt_f16_1x4_t s0 = __riscv_ztt_mzero_m_f16_1x4();
  __riscv_ztt_f16_1x2_t dst = __riscv_ztt_mextract_f16_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_27(
// UDS8: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 2)
#endif

#if UDS == 8
void test_28(void) {
  __riscv_ztt_f16_4x1_t s0 = __riscv_ztt_mzero_m_f16_4x1();
  __riscv_ztt_f16_2x1_t dst = __riscv_ztt_mextract_f16_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_28(
// UDS8: call target("riscv.ztt.m.f16", half, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 2)
#endif

#if UDS == 8
void test_29(void) {
  __riscv_ztt_bf16_1x2_t s0 = __riscv_ztt_mzero_m_bf16_1x2();
  __riscv_ztt_bf16_1x1_t dst = __riscv_ztt_mextract_bf16_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_29(
// UDS8: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 1)
#endif

#if UDS == 8
void test_30(void) {
  __riscv_ztt_bf16_1x4_t s0 = __riscv_ztt_mzero_m_bf16_1x4();
  __riscv_ztt_bf16_1x2_t dst = __riscv_ztt_mextract_bf16_1x2(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_30(
// UDS8: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 2)
#endif

#if UDS == 8
void test_31(void) {
  __riscv_ztt_bf16_4x1_t s0 = __riscv_ztt_mzero_m_bf16_4x1();
  __riscv_ztt_bf16_2x1_t dst = __riscv_ztt_mextract_bf16_2x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_31(
// UDS8: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 2)
#endif

#if UDS == 8
void test_32(void) {
  __riscv_ztt_f32_1x2_t s0 = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_1x1_t dst = __riscv_ztt_mextract_f32_1x1(s0, 1);
  (void)dst;
}
// UDS8-LABEL: define{{.*}} @test_32(
// UDS8: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 1)
#endif

#if UDS == 16
void test_33(void) {
  __riscv_ztt_i4_1x8_t s0 = __riscv_ztt_mzero_m_i4_1x8();
  __riscv_ztt_i4_1x4_t dst = __riscv_ztt_mextract_i4_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_33(
// UDS16: call target("riscv.ztt.m.i4", i4, 4, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741828, i32 4)
#endif

#if UDS == 16
void test_34(void) {
  __riscv_ztt_i4_8x1_t s0 = __riscv_ztt_mzero_m_i4_8x1();
  __riscv_ztt_i4_4x1_t dst = __riscv_ztt_mextract_i4_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_34(
// UDS16: call target("riscv.ztt.m.i4", i4, 4, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741828, i32 4)
#endif

#if UDS == 16
void test_35(void) {
  __riscv_ztt_u4_1x8_t s0 = __riscv_ztt_mzero_m_u4_1x8();
  __riscv_ztt_u4_1x4_t dst = __riscv_ztt_mextract_u4_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_35(
// UDS16: call target("riscv.ztt.m.u4", i4, 4, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 4, i32 4)
#endif

#if UDS == 16
void test_36(void) {
  __riscv_ztt_u4_8x1_t s0 = __riscv_ztt_mzero_m_u4_8x1();
  __riscv_ztt_u4_4x1_t dst = __riscv_ztt_mextract_u4_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_36(
// UDS16: call target("riscv.ztt.m.u4", i4, 4, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 4, i32 4)
#endif

#if UDS == 16
void test_37(void) {
  __riscv_ztt_i8_1x4_t s0 = __riscv_ztt_mzero_m_i8_1x4();
  __riscv_ztt_i8_1x2_t dst = __riscv_ztt_mextract_i8_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_37(
// UDS16: call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 2)
#endif

#if UDS == 16
void test_38(void) {
  __riscv_ztt_i8_4x1_t s0 = __riscv_ztt_mzero_m_i8_4x1();
  __riscv_ztt_i8_2x1_t dst = __riscv_ztt_mextract_i8_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_38(
// UDS16: call target("riscv.ztt.m.i8", i8, 8, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 2)
#endif

#if UDS == 16
void test_39(void) {
  __riscv_ztt_i8_1x8_t s0 = __riscv_ztt_mzero_m_i8_1x8();
  __riscv_ztt_i8_1x4_t dst = __riscv_ztt_mextract_i8_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_39(
// UDS16: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 4)
#endif

#if UDS == 16
void test_40(void) {
  __riscv_ztt_i8_8x1_t s0 = __riscv_ztt_mzero_m_i8_8x1();
  __riscv_ztt_i8_4x1_t dst = __riscv_ztt_mextract_i8_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_40(
// UDS16: call target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 4)
#endif

#if UDS == 16
void test_41(void) {
  __riscv_ztt_u8_1x4_t s0 = __riscv_ztt_mzero_m_u8_1x4();
  __riscv_ztt_u8_1x2_t dst = __riscv_ztt_mextract_u8_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_41(
// UDS16: call target("riscv.ztt.m.u8", i8, 8, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 2)
#endif

#if UDS == 16
void test_42(void) {
  __riscv_ztt_u8_4x1_t s0 = __riscv_ztt_mzero_m_u8_4x1();
  __riscv_ztt_u8_2x1_t dst = __riscv_ztt_mextract_u8_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_42(
// UDS16: call target("riscv.ztt.m.u8", i8, 8, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 2)
#endif

#if UDS == 16
void test_43(void) {
  __riscv_ztt_u8_1x8_t s0 = __riscv_ztt_mzero_m_u8_1x8();
  __riscv_ztt_u8_1x4_t dst = __riscv_ztt_mextract_u8_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_43(
// UDS16: call target("riscv.ztt.m.u8", i8, 8, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 4)
#endif

#if UDS == 16
void test_44(void) {
  __riscv_ztt_u8_8x1_t s0 = __riscv_ztt_mzero_m_u8_8x1();
  __riscv_ztt_u8_4x1_t dst = __riscv_ztt_mextract_u8_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_44(
// UDS16: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 4)
#endif

#if UDS == 16
void test_45(void) {
  __riscv_ztt_i16_1x2_t s0 = __riscv_ztt_mzero_m_i16_1x2();
  __riscv_ztt_i16_1x1_t dst = __riscv_ztt_mextract_i16_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_45(
// UDS16: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 1)
#endif

#if UDS == 16
void test_46(void) {
  __riscv_ztt_i16_1x4_t s0 = __riscv_ztt_mzero_m_i16_1x4();
  __riscv_ztt_i16_1x2_t dst = __riscv_ztt_mextract_i16_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_46(
// UDS16: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 2)
#endif

#if UDS == 16
void test_47(void) {
  __riscv_ztt_i16_4x1_t s0 = __riscv_ztt_mzero_m_i16_4x1();
  __riscv_ztt_i16_2x1_t dst = __riscv_ztt_mextract_i16_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_47(
// UDS16: call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 2)
#endif

#if UDS == 16
void test_48(void) {
  __riscv_ztt_i16_1x8_t s0 = __riscv_ztt_mzero_m_i16_1x8();
  __riscv_ztt_i16_1x4_t dst = __riscv_ztt_mextract_i16_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_48(
// UDS16: call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 4)
#endif

#if UDS == 16
void test_49(void) {
  __riscv_ztt_i16_8x1_t s0 = __riscv_ztt_mzero_m_i16_8x1();
  __riscv_ztt_i16_4x1_t dst = __riscv_ztt_mextract_i16_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_49(
// UDS16: call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 4)
#endif

#if UDS == 16
void test_50(void) {
  __riscv_ztt_u16_1x2_t s0 = __riscv_ztt_mzero_m_u16_1x2();
  __riscv_ztt_u16_1x1_t dst = __riscv_ztt_mextract_u16_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_50(
// UDS16: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 1)
#endif

#if UDS == 16
void test_51(void) {
  __riscv_ztt_u16_1x4_t s0 = __riscv_ztt_mzero_m_u16_1x4();
  __riscv_ztt_u16_1x2_t dst = __riscv_ztt_mextract_u16_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_51(
// UDS16: call target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 2)
#endif

#if UDS == 16
void test_52(void) {
  __riscv_ztt_u16_4x1_t s0 = __riscv_ztt_mzero_m_u16_4x1();
  __riscv_ztt_u16_2x1_t dst = __riscv_ztt_mextract_u16_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_52(
// UDS16: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 2)
#endif

#if UDS == 16
void test_53(void) {
  __riscv_ztt_u16_1x8_t s0 = __riscv_ztt_mzero_m_u16_1x8();
  __riscv_ztt_u16_1x4_t dst = __riscv_ztt_mextract_u16_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_53(
// UDS16: call target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 4)
#endif

#if UDS == 16
void test_54(void) {
  __riscv_ztt_u16_8x1_t s0 = __riscv_ztt_mzero_m_u16_8x1();
  __riscv_ztt_u16_4x1_t dst = __riscv_ztt_mextract_u16_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_54(
// UDS16: call target("riscv.ztt.m.u16", i16, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 4)
#endif

#if UDS == 16
void test_55(void) {
  __riscv_ztt_i32_1x2_t s0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_mextract_i32_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_55(
// UDS16: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 1)
#endif

#if UDS == 16
void test_56(void) {
  __riscv_ztt_i32_1x4_t s0 = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_i32_1x2_t dst = __riscv_ztt_mextract_i32_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_56(
// UDS16: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 2)
#endif

#if UDS == 16
void test_57(void) {
  __riscv_ztt_i32_4x1_t s0 = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_2x1_t dst = __riscv_ztt_mextract_i32_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_57(
// UDS16: call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 2)
#endif

#if UDS == 16
void test_58(void) {
  __riscv_ztt_u32_1x2_t s0 = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_u32_1x1_t dst = __riscv_ztt_mextract_u32_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_58(
// UDS16: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 1)
#endif

#if UDS == 16
void test_59(void) {
  __riscv_ztt_u32_1x4_t s0 = __riscv_ztt_mzero_m_u32_1x4();
  __riscv_ztt_u32_1x2_t dst = __riscv_ztt_mextract_u32_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_59(
// UDS16: call target("riscv.ztt.m.u32", i32, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 2)
#endif

#if UDS == 16
void test_60(void) {
  __riscv_ztt_u32_4x1_t s0 = __riscv_ztt_mzero_m_u32_4x1();
  __riscv_ztt_u32_2x1_t dst = __riscv_ztt_mextract_u32_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_60(
// UDS16: call target("riscv.ztt.m.u32", i32, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 2)
#endif

#if UDS == 16
void test_61(void) {
  __riscv_ztt_i64_1x2_t s0 = __riscv_ztt_mzero_m_i64_1x2();
  __riscv_ztt_i64_1x1_t dst = __riscv_ztt_mextract_i64_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_61(
// UDS16: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 1)
#endif

#if UDS == 16
void test_62(void) {
  __riscv_ztt_u64_1x2_t s0 = __riscv_ztt_mzero_m_u64_1x2();
  __riscv_ztt_u64_1x1_t dst = __riscv_ztt_mextract_u64_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_62(
// UDS16: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 1)
#endif

#if UDS == 16
void test_63(void) {
  __riscv_ztt_f16_1x2_t s0 = __riscv_ztt_mzero_m_f16_1x2();
  __riscv_ztt_f16_1x1_t dst = __riscv_ztt_mextract_f16_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_63(
// UDS16: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 1)
#endif

#if UDS == 16
void test_64(void) {
  __riscv_ztt_f16_1x4_t s0 = __riscv_ztt_mzero_m_f16_1x4();
  __riscv_ztt_f16_1x2_t dst = __riscv_ztt_mextract_f16_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_64(
// UDS16: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 2)
#endif

#if UDS == 16
void test_65(void) {
  __riscv_ztt_f16_4x1_t s0 = __riscv_ztt_mzero_m_f16_4x1();
  __riscv_ztt_f16_2x1_t dst = __riscv_ztt_mextract_f16_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_65(
// UDS16: call target("riscv.ztt.m.f16", half, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 2)
#endif

#if UDS == 16
void test_66(void) {
  __riscv_ztt_f16_1x8_t s0 = __riscv_ztt_mzero_m_f16_1x8();
  __riscv_ztt_f16_1x4_t dst = __riscv_ztt_mextract_f16_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_66(
// UDS16: call target("riscv.ztt.m.f16", half, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 4)
#endif

#if UDS == 16
void test_67(void) {
  __riscv_ztt_f16_8x1_t s0 = __riscv_ztt_mzero_m_f16_8x1();
  __riscv_ztt_f16_4x1_t dst = __riscv_ztt_mextract_f16_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_67(
// UDS16: call target("riscv.ztt.m.f16", half, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 4)
#endif

#if UDS == 16
void test_68(void) {
  __riscv_ztt_bf16_1x2_t s0 = __riscv_ztt_mzero_m_bf16_1x2();
  __riscv_ztt_bf16_1x1_t dst = __riscv_ztt_mextract_bf16_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_68(
// UDS16: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 1)
#endif

#if UDS == 16
void test_69(void) {
  __riscv_ztt_bf16_1x4_t s0 = __riscv_ztt_mzero_m_bf16_1x4();
  __riscv_ztt_bf16_1x2_t dst = __riscv_ztt_mextract_bf16_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_69(
// UDS16: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 2)
#endif

#if UDS == 16
void test_70(void) {
  __riscv_ztt_bf16_4x1_t s0 = __riscv_ztt_mzero_m_bf16_4x1();
  __riscv_ztt_bf16_2x1_t dst = __riscv_ztt_mextract_bf16_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_70(
// UDS16: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 2)
#endif

#if UDS == 16
void test_71(void) {
  __riscv_ztt_bf16_1x8_t s0 = __riscv_ztt_mzero_m_bf16_1x8();
  __riscv_ztt_bf16_1x4_t dst = __riscv_ztt_mextract_bf16_1x4(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_71(
// UDS16: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 4)
#endif

#if UDS == 16
void test_72(void) {
  __riscv_ztt_bf16_8x1_t s0 = __riscv_ztt_mzero_m_bf16_8x1();
  __riscv_ztt_bf16_4x1_t dst = __riscv_ztt_mextract_bf16_4x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_72(
// UDS16: call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 4)
#endif

#if UDS == 16
void test_73(void) {
  __riscv_ztt_f32_1x2_t s0 = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_1x1_t dst = __riscv_ztt_mextract_f32_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_73(
// UDS16: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 1)
#endif

#if UDS == 16
void test_74(void) {
  __riscv_ztt_f32_1x4_t s0 = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_f32_1x2_t dst = __riscv_ztt_mextract_f32_1x2(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_74(
// UDS16: call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 2)
#endif

#if UDS == 16
void test_75(void) {
  __riscv_ztt_f32_4x1_t s0 = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_f32_2x1_t dst = __riscv_ztt_mextract_f32_2x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_75(
// UDS16: call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 2)
#endif

#if UDS == 16
void test_76(void) {
  __riscv_ztt_f64_1x2_t s0 = __riscv_ztt_mzero_m_f64_1x2();
  __riscv_ztt_f64_1x1_t dst = __riscv_ztt_mextract_f64_1x1(s0, 1);
  (void)dst;
}
// UDS16-LABEL: define{{.*}} @test_76(
// UDS16: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 1)
#endif

#if UDS == 32
void test_77(void) {
  __riscv_ztt_i8_1x8_t s0 = __riscv_ztt_mzero_m_i8_1x8();
  __riscv_ztt_i8_1x4_t dst = __riscv_ztt_mextract_i8_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_77(
// UDS32: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 4)
#endif

#if UDS == 32
void test_78(void) {
  __riscv_ztt_i8_8x1_t s0 = __riscv_ztt_mzero_m_i8_8x1();
  __riscv_ztt_i8_4x1_t dst = __riscv_ztt_mextract_i8_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_78(
// UDS32: call target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741832, i32 4)
#endif

#if UDS == 32
void test_79(void) {
  __riscv_ztt_u8_1x8_t s0 = __riscv_ztt_mzero_m_u8_1x8();
  __riscv_ztt_u8_1x4_t dst = __riscv_ztt_mextract_u8_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_79(
// UDS32: call target("riscv.ztt.m.u8", i8, 8, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 4)
#endif

#if UDS == 32
void test_80(void) {
  __riscv_ztt_u8_8x1_t s0 = __riscv_ztt_mzero_m_u8_8x1();
  __riscv_ztt_u8_4x1_t dst = __riscv_ztt_mextract_u8_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_80(
// UDS32: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 8, i32 4)
#endif

#if UDS == 32
void test_81(void) {
  __riscv_ztt_i16_1x4_t s0 = __riscv_ztt_mzero_m_i16_1x4();
  __riscv_ztt_i16_1x2_t dst = __riscv_ztt_mextract_i16_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_81(
// UDS32: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 2)
#endif

#if UDS == 32
void test_82(void) {
  __riscv_ztt_i16_4x1_t s0 = __riscv_ztt_mzero_m_i16_4x1();
  __riscv_ztt_i16_2x1_t dst = __riscv_ztt_mextract_i16_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_82(
// UDS32: call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 2)
#endif

#if UDS == 32
void test_83(void) {
  __riscv_ztt_i16_1x8_t s0 = __riscv_ztt_mzero_m_i16_1x8();
  __riscv_ztt_i16_1x4_t dst = __riscv_ztt_mextract_i16_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_83(
// UDS32: call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 4)
#endif

#if UDS == 32
void test_84(void) {
  __riscv_ztt_i16_8x1_t s0 = __riscv_ztt_mzero_m_i16_8x1();
  __riscv_ztt_i16_4x1_t dst = __riscv_ztt_mextract_i16_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_84(
// UDS32: call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 4)
#endif

#if UDS == 32
void test_85(void) {
  __riscv_ztt_u16_1x4_t s0 = __riscv_ztt_mzero_m_u16_1x4();
  __riscv_ztt_u16_1x2_t dst = __riscv_ztt_mextract_u16_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_85(
// UDS32: call target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 2)
#endif

#if UDS == 32
void test_86(void) {
  __riscv_ztt_u16_4x1_t s0 = __riscv_ztt_mzero_m_u16_4x1();
  __riscv_ztt_u16_2x1_t dst = __riscv_ztt_mextract_u16_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_86(
// UDS32: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 2)
#endif

#if UDS == 32
void test_87(void) {
  __riscv_ztt_u16_1x8_t s0 = __riscv_ztt_mzero_m_u16_1x8();
  __riscv_ztt_u16_1x4_t dst = __riscv_ztt_mextract_u16_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_87(
// UDS32: call target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 4)
#endif

#if UDS == 32
void test_88(void) {
  __riscv_ztt_u16_8x1_t s0 = __riscv_ztt_mzero_m_u16_8x1();
  __riscv_ztt_u16_4x1_t dst = __riscv_ztt_mextract_u16_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_88(
// UDS32: call target("riscv.ztt.m.u16", i16, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 4)
#endif

#if UDS == 32
void test_89(void) {
  __riscv_ztt_i32_1x2_t s0 = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_mextract_i32_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_89(
// UDS32: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 1)
#endif

#if UDS == 32
void test_90(void) {
  __riscv_ztt_i32_1x4_t s0 = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_i32_1x2_t dst = __riscv_ztt_mextract_i32_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_90(
// UDS32: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 2)
#endif

#if UDS == 32
void test_91(void) {
  __riscv_ztt_i32_4x1_t s0 = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_2x1_t dst = __riscv_ztt_mextract_i32_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_91(
// UDS32: call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 2)
#endif

#if UDS == 32
void test_92(void) {
  __riscv_ztt_i32_1x8_t s0 = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_i32_1x4_t dst = __riscv_ztt_mextract_i32_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_92(
// UDS32: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 4)
#endif

#if UDS == 32
void test_93(void) {
  __riscv_ztt_i32_8x1_t s0 = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_i32_4x1_t dst = __riscv_ztt_mextract_i32_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_93(
// UDS32: call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 4)
#endif

#if UDS == 32
void test_94(void) {
  __riscv_ztt_u32_1x2_t s0 = __riscv_ztt_mzero_m_u32_1x2();
  __riscv_ztt_u32_1x1_t dst = __riscv_ztt_mextract_u32_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_94(
// UDS32: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 1)
#endif

#if UDS == 32
void test_95(void) {
  __riscv_ztt_u32_1x4_t s0 = __riscv_ztt_mzero_m_u32_1x4();
  __riscv_ztt_u32_1x2_t dst = __riscv_ztt_mextract_u32_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_95(
// UDS32: call target("riscv.ztt.m.u32", i32, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 2)
#endif

#if UDS == 32
void test_96(void) {
  __riscv_ztt_u32_4x1_t s0 = __riscv_ztt_mzero_m_u32_4x1();
  __riscv_ztt_u32_2x1_t dst = __riscv_ztt_mextract_u32_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_96(
// UDS32: call target("riscv.ztt.m.u32", i32, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 2)
#endif

#if UDS == 32
void test_97(void) {
  __riscv_ztt_u32_1x8_t s0 = __riscv_ztt_mzero_m_u32_1x8();
  __riscv_ztt_u32_1x4_t dst = __riscv_ztt_mextract_u32_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_97(
// UDS32: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 4)
#endif

#if UDS == 32
void test_98(void) {
  __riscv_ztt_u32_8x1_t s0 = __riscv_ztt_mzero_m_u32_8x1();
  __riscv_ztt_u32_4x1_t dst = __riscv_ztt_mextract_u32_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_98(
// UDS32: call target("riscv.ztt.m.u32", i32, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 4)
#endif

#if UDS == 32
void test_99(void) {
  __riscv_ztt_i64_1x2_t s0 = __riscv_ztt_mzero_m_i64_1x2();
  __riscv_ztt_i64_1x1_t dst = __riscv_ztt_mextract_i64_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_99(
// UDS32: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 1)
#endif

#if UDS == 32
void test_100(void) {
  __riscv_ztt_i64_1x4_t s0 = __riscv_ztt_mzero_m_i64_1x4();
  __riscv_ztt_i64_1x2_t dst = __riscv_ztt_mextract_i64_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_100(
// UDS32: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 2)
#endif

#if UDS == 32
void test_101(void) {
  __riscv_ztt_i64_4x1_t s0 = __riscv_ztt_mzero_m_i64_4x1();
  __riscv_ztt_i64_2x1_t dst = __riscv_ztt_mextract_i64_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_101(
// UDS32: call target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 2)
#endif

#if UDS == 32
void test_102(void) {
  __riscv_ztt_u64_1x2_t s0 = __riscv_ztt_mzero_m_u64_1x2();
  __riscv_ztt_u64_1x1_t dst = __riscv_ztt_mextract_u64_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_102(
// UDS32: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 1)
#endif

#if UDS == 32
void test_103(void) {
  __riscv_ztt_u64_1x4_t s0 = __riscv_ztt_mzero_m_u64_1x4();
  __riscv_ztt_u64_1x2_t dst = __riscv_ztt_mextract_u64_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_103(
// UDS32: call target("riscv.ztt.m.u64", i64, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 2)
#endif

#if UDS == 32
void test_104(void) {
  __riscv_ztt_u64_4x1_t s0 = __riscv_ztt_mzero_m_u64_4x1();
  __riscv_ztt_u64_2x1_t dst = __riscv_ztt_mextract_u64_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_104(
// UDS32: call target("riscv.ztt.m.u64", i64, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 2)
#endif

#if UDS == 32
void test_105(void) {
  __riscv_ztt_i128_1x2_t s0 = __riscv_ztt_mzero_m_i128_1x2();
  __riscv_ztt_i128_1x1_t dst = __riscv_ztt_mextract_i128_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_105(
// UDS32: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 1)
#endif

#if UDS == 32
void test_106(void) {
  __riscv_ztt_u128_1x2_t s0 = __riscv_ztt_mzero_m_u128_1x2();
  __riscv_ztt_u128_1x1_t dst = __riscv_ztt_mextract_u128_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_106(
// UDS32: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 1)
#endif

#if UDS == 32
void test_107(void) {
  __riscv_ztt_f16_1x4_t s0 = __riscv_ztt_mzero_m_f16_1x4();
  __riscv_ztt_f16_1x2_t dst = __riscv_ztt_mextract_f16_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_107(
// UDS32: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 2)
#endif

#if UDS == 32
void test_108(void) {
  __riscv_ztt_f16_4x1_t s0 = __riscv_ztt_mzero_m_f16_4x1();
  __riscv_ztt_f16_2x1_t dst = __riscv_ztt_mextract_f16_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_108(
// UDS32: call target("riscv.ztt.m.f16", half, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 2)
#endif

#if UDS == 32
void test_109(void) {
  __riscv_ztt_f16_1x8_t s0 = __riscv_ztt_mzero_m_f16_1x8();
  __riscv_ztt_f16_1x4_t dst = __riscv_ztt_mextract_f16_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_109(
// UDS32: call target("riscv.ztt.m.f16", half, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 4)
#endif

#if UDS == 32
void test_110(void) {
  __riscv_ztt_f16_8x1_t s0 = __riscv_ztt_mzero_m_f16_8x1();
  __riscv_ztt_f16_4x1_t dst = __riscv_ztt_mextract_f16_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_110(
// UDS32: call target("riscv.ztt.m.f16", half, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 4)
#endif

#if UDS == 32
void test_111(void) {
  __riscv_ztt_bf16_1x4_t s0 = __riscv_ztt_mzero_m_bf16_1x4();
  __riscv_ztt_bf16_1x2_t dst = __riscv_ztt_mextract_bf16_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_111(
// UDS32: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 2)
#endif

#if UDS == 32
void test_112(void) {
  __riscv_ztt_bf16_4x1_t s0 = __riscv_ztt_mzero_m_bf16_4x1();
  __riscv_ztt_bf16_2x1_t dst = __riscv_ztt_mextract_bf16_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_112(
// UDS32: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 2)
#endif

#if UDS == 32
void test_113(void) {
  __riscv_ztt_bf16_1x8_t s0 = __riscv_ztt_mzero_m_bf16_1x8();
  __riscv_ztt_bf16_1x4_t dst = __riscv_ztt_mextract_bf16_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_113(
// UDS32: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 4)
#endif

#if UDS == 32
void test_114(void) {
  __riscv_ztt_bf16_8x1_t s0 = __riscv_ztt_mzero_m_bf16_8x1();
  __riscv_ztt_bf16_4x1_t dst = __riscv_ztt_mextract_bf16_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_114(
// UDS32: call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 4)
#endif

#if UDS == 32
void test_115(void) {
  __riscv_ztt_f32_1x2_t s0 = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_f32_1x1_t dst = __riscv_ztt_mextract_f32_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_115(
// UDS32: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 1)
#endif

#if UDS == 32
void test_116(void) {
  __riscv_ztt_f32_1x4_t s0 = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_f32_1x2_t dst = __riscv_ztt_mextract_f32_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_116(
// UDS32: call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 2)
#endif

#if UDS == 32
void test_117(void) {
  __riscv_ztt_f32_4x1_t s0 = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_f32_2x1_t dst = __riscv_ztt_mextract_f32_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_117(
// UDS32: call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 2)
#endif

#if UDS == 32
void test_118(void) {
  __riscv_ztt_f32_1x8_t s0 = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_f32_1x4_t dst = __riscv_ztt_mextract_f32_1x4(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_118(
// UDS32: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 4)
#endif

#if UDS == 32
void test_119(void) {
  __riscv_ztt_f32_8x1_t s0 = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_f32_4x1_t dst = __riscv_ztt_mextract_f32_4x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_119(
// UDS32: call target("riscv.ztt.m.f32", float, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 4)
#endif

#if UDS == 32
void test_120(void) {
  __riscv_ztt_f64_1x2_t s0 = __riscv_ztt_mzero_m_f64_1x2();
  __riscv_ztt_f64_1x1_t dst = __riscv_ztt_mextract_f64_1x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_120(
// UDS32: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 1)
#endif

#if UDS == 32
void test_121(void) {
  __riscv_ztt_f64_1x4_t s0 = __riscv_ztt_mzero_m_f64_1x4();
  __riscv_ztt_f64_1x2_t dst = __riscv_ztt_mextract_f64_1x2(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_121(
// UDS32: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 2)
#endif

#if UDS == 32
void test_122(void) {
  __riscv_ztt_f64_4x1_t s0 = __riscv_ztt_mzero_m_f64_4x1();
  __riscv_ztt_f64_2x1_t dst = __riscv_ztt_mextract_f64_2x1(s0, 1);
  (void)dst;
}
// UDS32-LABEL: define{{.*}} @test_122(
// UDS32: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 2)
#endif

#if UDS == 64
void test_123(void) {
  __riscv_ztt_i16_1x8_t s0 = __riscv_ztt_mzero_m_i16_1x8();
  __riscv_ztt_i16_1x4_t dst = __riscv_ztt_mextract_i16_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_123(
// UDS64: call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 4)
#endif

#if UDS == 64
void test_124(void) {
  __riscv_ztt_i16_8x1_t s0 = __riscv_ztt_mzero_m_i16_8x1();
  __riscv_ztt_i16_4x1_t dst = __riscv_ztt_mextract_i16_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_124(
// UDS64: call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741840, i32 4)
#endif

#if UDS == 64
void test_125(void) {
  __riscv_ztt_u16_1x8_t s0 = __riscv_ztt_mzero_m_u16_1x8();
  __riscv_ztt_u16_1x4_t dst = __riscv_ztt_mextract_u16_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_125(
// UDS64: call target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 4)
#endif

#if UDS == 64
void test_126(void) {
  __riscv_ztt_u16_8x1_t s0 = __riscv_ztt_mzero_m_u16_8x1();
  __riscv_ztt_u16_4x1_t dst = __riscv_ztt_mextract_u16_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_126(
// UDS64: call target("riscv.ztt.m.u16", i16, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 16, i32 4)
#endif

#if UDS == 64
void test_127(void) {
  __riscv_ztt_i32_1x4_t s0 = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_i32_1x2_t dst = __riscv_ztt_mextract_i32_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_127(
// UDS64: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 2)
#endif

#if UDS == 64
void test_128(void) {
  __riscv_ztt_i32_4x1_t s0 = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_i32_2x1_t dst = __riscv_ztt_mextract_i32_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_128(
// UDS64: call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 2)
#endif

#if UDS == 64
void test_129(void) {
  __riscv_ztt_i32_1x8_t s0 = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_i32_1x4_t dst = __riscv_ztt_mextract_i32_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_129(
// UDS64: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 4)
#endif

#if UDS == 64
void test_130(void) {
  __riscv_ztt_i32_8x1_t s0 = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_i32_4x1_t dst = __riscv_ztt_mextract_i32_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_130(
// UDS64: call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 4)
#endif

#if UDS == 64
void test_131(void) {
  __riscv_ztt_u32_1x4_t s0 = __riscv_ztt_mzero_m_u32_1x4();
  __riscv_ztt_u32_1x2_t dst = __riscv_ztt_mextract_u32_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_131(
// UDS64: call target("riscv.ztt.m.u32", i32, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 2)
#endif

#if UDS == 64
void test_132(void) {
  __riscv_ztt_u32_4x1_t s0 = __riscv_ztt_mzero_m_u32_4x1();
  __riscv_ztt_u32_2x1_t dst = __riscv_ztt_mextract_u32_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_132(
// UDS64: call target("riscv.ztt.m.u32", i32, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 2)
#endif

#if UDS == 64
void test_133(void) {
  __riscv_ztt_u32_1x8_t s0 = __riscv_ztt_mzero_m_u32_1x8();
  __riscv_ztt_u32_1x4_t dst = __riscv_ztt_mextract_u32_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_133(
// UDS64: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 4)
#endif

#if UDS == 64
void test_134(void) {
  __riscv_ztt_u32_8x1_t s0 = __riscv_ztt_mzero_m_u32_8x1();
  __riscv_ztt_u32_4x1_t dst = __riscv_ztt_mextract_u32_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_134(
// UDS64: call target("riscv.ztt.m.u32", i32, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 4)
#endif

#if UDS == 64
void test_135(void) {
  __riscv_ztt_i64_1x2_t s0 = __riscv_ztt_mzero_m_i64_1x2();
  __riscv_ztt_i64_1x1_t dst = __riscv_ztt_mextract_i64_1x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_135(
// UDS64: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 1)
#endif

#if UDS == 64
void test_136(void) {
  __riscv_ztt_i64_1x4_t s0 = __riscv_ztt_mzero_m_i64_1x4();
  __riscv_ztt_i64_1x2_t dst = __riscv_ztt_mextract_i64_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_136(
// UDS64: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 2)
#endif

#if UDS == 64
void test_137(void) {
  __riscv_ztt_i64_4x1_t s0 = __riscv_ztt_mzero_m_i64_4x1();
  __riscv_ztt_i64_2x1_t dst = __riscv_ztt_mextract_i64_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_137(
// UDS64: call target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 2)
#endif

#if UDS == 64
void test_138(void) {
  __riscv_ztt_i64_1x8_t s0 = __riscv_ztt_mzero_m_i64_1x8();
  __riscv_ztt_i64_1x4_t dst = __riscv_ztt_mextract_i64_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_138(
// UDS64: call target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 4)
#endif

#if UDS == 64
void test_139(void) {
  __riscv_ztt_i64_8x1_t s0 = __riscv_ztt_mzero_m_i64_8x1();
  __riscv_ztt_i64_4x1_t dst = __riscv_ztt_mextract_i64_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_139(
// UDS64: call target("riscv.ztt.m.i64", i64, 64, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 4)
#endif

#if UDS == 64
void test_140(void) {
  __riscv_ztt_u64_1x2_t s0 = __riscv_ztt_mzero_m_u64_1x2();
  __riscv_ztt_u64_1x1_t dst = __riscv_ztt_mextract_u64_1x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_140(
// UDS64: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 1)
#endif

#if UDS == 64
void test_141(void) {
  __riscv_ztt_u64_1x4_t s0 = __riscv_ztt_mzero_m_u64_1x4();
  __riscv_ztt_u64_1x2_t dst = __riscv_ztt_mextract_u64_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_141(
// UDS64: call target("riscv.ztt.m.u64", i64, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 2)
#endif

#if UDS == 64
void test_142(void) {
  __riscv_ztt_u64_4x1_t s0 = __riscv_ztt_mzero_m_u64_4x1();
  __riscv_ztt_u64_2x1_t dst = __riscv_ztt_mextract_u64_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_142(
// UDS64: call target("riscv.ztt.m.u64", i64, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 2)
#endif

#if UDS == 64
void test_143(void) {
  __riscv_ztt_u64_1x8_t s0 = __riscv_ztt_mzero_m_u64_1x8();
  __riscv_ztt_u64_1x4_t dst = __riscv_ztt_mextract_u64_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_143(
// UDS64: call target("riscv.ztt.m.u64", i64, 64, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 4)
#endif

#if UDS == 64
void test_144(void) {
  __riscv_ztt_u64_8x1_t s0 = __riscv_ztt_mzero_m_u64_8x1();
  __riscv_ztt_u64_4x1_t dst = __riscv_ztt_mextract_u64_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_144(
// UDS64: call target("riscv.ztt.m.u64", i64, 64, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 4)
#endif

#if UDS == 64
void test_145(void) {
  __riscv_ztt_i128_1x2_t s0 = __riscv_ztt_mzero_m_i128_1x2();
  __riscv_ztt_i128_1x1_t dst = __riscv_ztt_mextract_i128_1x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_145(
// UDS64: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 1)
#endif

#if UDS == 64
void test_146(void) {
  __riscv_ztt_i128_1x4_t s0 = __riscv_ztt_mzero_m_i128_1x4();
  __riscv_ztt_i128_1x2_t dst = __riscv_ztt_mextract_i128_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_146(
// UDS64: call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 2)
#endif

#if UDS == 64
void test_147(void) {
  __riscv_ztt_i128_4x1_t s0 = __riscv_ztt_mzero_m_i128_4x1();
  __riscv_ztt_i128_2x1_t dst = __riscv_ztt_mextract_i128_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_147(
// UDS64: call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 2)
#endif

#if UDS == 64
void test_148(void) {
  __riscv_ztt_u128_1x2_t s0 = __riscv_ztt_mzero_m_u128_1x2();
  __riscv_ztt_u128_1x1_t dst = __riscv_ztt_mextract_u128_1x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_148(
// UDS64: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 1)
#endif

#if UDS == 64
void test_149(void) {
  __riscv_ztt_u128_1x4_t s0 = __riscv_ztt_mzero_m_u128_1x4();
  __riscv_ztt_u128_1x2_t dst = __riscv_ztt_mextract_u128_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_149(
// UDS64: call target("riscv.ztt.m.u128", i128, 128, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 2)
#endif

#if UDS == 64
void test_150(void) {
  __riscv_ztt_u128_4x1_t s0 = __riscv_ztt_mzero_m_u128_4x1();
  __riscv_ztt_u128_2x1_t dst = __riscv_ztt_mextract_u128_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_150(
// UDS64: call target("riscv.ztt.m.u128", i128, 128, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 2)
#endif

#if UDS == 64
void test_151(void) {
  __riscv_ztt_f16_1x8_t s0 = __riscv_ztt_mzero_m_f16_1x8();
  __riscv_ztt_f16_1x4_t dst = __riscv_ztt_mextract_f16_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_151(
// UDS64: call target("riscv.ztt.m.f16", half, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 4)
#endif

#if UDS == 64
void test_152(void) {
  __riscv_ztt_f16_8x1_t s0 = __riscv_ztt_mzero_m_f16_8x1();
  __riscv_ztt_f16_4x1_t dst = __riscv_ztt_mextract_f16_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_152(
// UDS64: call target("riscv.ztt.m.f16", half, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 338690320, i32 4)
#endif

#if UDS == 64
void test_153(void) {
  __riscv_ztt_bf16_1x8_t s0 = __riscv_ztt_mzero_m_bf16_1x8();
  __riscv_ztt_bf16_1x4_t dst = __riscv_ztt_mextract_bf16_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_153(
// UDS64: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 4)
#endif

#if UDS == 64
void test_154(void) {
  __riscv_ztt_bf16_8x1_t s0 = __riscv_ztt_mzero_m_bf16_8x1();
  __riscv_ztt_bf16_4x1_t dst = __riscv_ztt_mextract_bf16_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_154(
// UDS64: call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016912, i32 4)
#endif

#if UDS == 64
void test_155(void) {
  __riscv_ztt_f32_1x4_t s0 = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_f32_1x2_t dst = __riscv_ztt_mextract_f32_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_155(
// UDS64: call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 2)
#endif

#if UDS == 64
void test_156(void) {
  __riscv_ztt_f32_4x1_t s0 = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_f32_2x1_t dst = __riscv_ztt_mextract_f32_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_156(
// UDS64: call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 2)
#endif

#if UDS == 64
void test_157(void) {
  __riscv_ztt_f32_1x8_t s0 = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_f32_1x4_t dst = __riscv_ztt_mextract_f32_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_157(
// UDS64: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 4)
#endif

#if UDS == 64
void test_158(void) {
  __riscv_ztt_f32_8x1_t s0 = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_f32_4x1_t dst = __riscv_ztt_mextract_f32_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_158(
// UDS64: call target("riscv.ztt.m.f32", float, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 4)
#endif

#if UDS == 64
void test_159(void) {
  __riscv_ztt_f64_1x2_t s0 = __riscv_ztt_mzero_m_f64_1x2();
  __riscv_ztt_f64_1x1_t dst = __riscv_ztt_mextract_f64_1x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_159(
// UDS64: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 1)
#endif

#if UDS == 64
void test_160(void) {
  __riscv_ztt_f64_1x4_t s0 = __riscv_ztt_mzero_m_f64_1x4();
  __riscv_ztt_f64_1x2_t dst = __riscv_ztt_mextract_f64_1x2(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_160(
// UDS64: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 2)
#endif

#if UDS == 64
void test_161(void) {
  __riscv_ztt_f64_4x1_t s0 = __riscv_ztt_mzero_m_f64_4x1();
  __riscv_ztt_f64_2x1_t dst = __riscv_ztt_mextract_f64_2x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_161(
// UDS64: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 2)
#endif

#if UDS == 64
void test_162(void) {
  __riscv_ztt_f64_1x8_t s0 = __riscv_ztt_mzero_m_f64_1x8();
  __riscv_ztt_f64_1x4_t dst = __riscv_ztt_mextract_f64_1x4(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_162(
// UDS64: call target("riscv.ztt.m.f64", double, 64, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 4)
#endif

#if UDS == 64
void test_163(void) {
  __riscv_ztt_f64_8x1_t s0 = __riscv_ztt_mzero_m_f64_8x1();
  __riscv_ztt_f64_4x1_t dst = __riscv_ztt_mextract_f64_4x1(s0, 1);
  (void)dst;
}
// UDS64-LABEL: define{{.*}} @test_163(
// UDS64: call target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 4)
#endif

#if UDS == 128
void test_164(void) {
  __riscv_ztt_i32_1x8_t s0 = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_i32_1x4_t dst = __riscv_ztt_mextract_i32_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_164(
// UDS128: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 4)
#endif

#if UDS == 128
void test_165(void) {
  __riscv_ztt_i32_8x1_t s0 = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_i32_4x1_t dst = __riscv_ztt_mextract_i32_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_165(
// UDS128: call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741856, i32 4)
#endif

#if UDS == 128
void test_166(void) {
  __riscv_ztt_u32_1x8_t s0 = __riscv_ztt_mzero_m_u32_1x8();
  __riscv_ztt_u32_1x4_t dst = __riscv_ztt_mextract_u32_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_166(
// UDS128: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 4)
#endif

#if UDS == 128
void test_167(void) {
  __riscv_ztt_u32_8x1_t s0 = __riscv_ztt_mzero_m_u32_8x1();
  __riscv_ztt_u32_4x1_t dst = __riscv_ztt_mextract_u32_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_167(
// UDS128: call target("riscv.ztt.m.u32", i32, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 32, i32 4)
#endif

#if UDS == 128
void test_168(void) {
  __riscv_ztt_i64_1x4_t s0 = __riscv_ztt_mzero_m_i64_1x4();
  __riscv_ztt_i64_1x2_t dst = __riscv_ztt_mextract_i64_1x2(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_168(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 2)
#endif

#if UDS == 128
void test_169(void) {
  __riscv_ztt_i64_4x1_t s0 = __riscv_ztt_mzero_m_i64_4x1();
  __riscv_ztt_i64_2x1_t dst = __riscv_ztt_mextract_i64_2x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_169(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 2)
#endif

#if UDS == 128
void test_170(void) {
  __riscv_ztt_i64_1x8_t s0 = __riscv_ztt_mzero_m_i64_1x8();
  __riscv_ztt_i64_1x4_t dst = __riscv_ztt_mextract_i64_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_170(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 4)
#endif

#if UDS == 128
void test_171(void) {
  __riscv_ztt_i64_8x1_t s0 = __riscv_ztt_mzero_m_i64_8x1();
  __riscv_ztt_i64_4x1_t dst = __riscv_ztt_mextract_i64_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_171(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741888, i32 4)
#endif

#if UDS == 128
void test_172(void) {
  __riscv_ztt_u64_1x4_t s0 = __riscv_ztt_mzero_m_u64_1x4();
  __riscv_ztt_u64_1x2_t dst = __riscv_ztt_mextract_u64_1x2(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_172(
// UDS128: call target("riscv.ztt.m.u64", i64, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 2)
#endif

#if UDS == 128
void test_173(void) {
  __riscv_ztt_u64_4x1_t s0 = __riscv_ztt_mzero_m_u64_4x1();
  __riscv_ztt_u64_2x1_t dst = __riscv_ztt_mextract_u64_2x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_173(
// UDS128: call target("riscv.ztt.m.u64", i64, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 2)
#endif

#if UDS == 128
void test_174(void) {
  __riscv_ztt_u64_1x8_t s0 = __riscv_ztt_mzero_m_u64_1x8();
  __riscv_ztt_u64_1x4_t dst = __riscv_ztt_mextract_u64_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_174(
// UDS128: call target("riscv.ztt.m.u64", i64, 64, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 4)
#endif

#if UDS == 128
void test_175(void) {
  __riscv_ztt_u64_8x1_t s0 = __riscv_ztt_mzero_m_u64_8x1();
  __riscv_ztt_u64_4x1_t dst = __riscv_ztt_mextract_u64_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_175(
// UDS128: call target("riscv.ztt.m.u64", i64, 64, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 64, i32 4)
#endif

#if UDS == 128
void test_176(void) {
  __riscv_ztt_i128_1x2_t s0 = __riscv_ztt_mzero_m_i128_1x2();
  __riscv_ztt_i128_1x1_t dst = __riscv_ztt_mextract_i128_1x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_176(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 1)
#endif

#if UDS == 128
void test_177(void) {
  __riscv_ztt_i128_1x4_t s0 = __riscv_ztt_mzero_m_i128_1x4();
  __riscv_ztt_i128_1x2_t dst = __riscv_ztt_mextract_i128_1x2(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_177(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 2)
#endif

#if UDS == 128
void test_178(void) {
  __riscv_ztt_i128_4x1_t s0 = __riscv_ztt_mzero_m_i128_4x1();
  __riscv_ztt_i128_2x1_t dst = __riscv_ztt_mextract_i128_2x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_178(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 2)
#endif

#if UDS == 128
void test_179(void) {
  __riscv_ztt_i128_1x8_t s0 = __riscv_ztt_mzero_m_i128_1x8();
  __riscv_ztt_i128_1x4_t dst = __riscv_ztt_mextract_i128_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_179(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 4)
#endif

#if UDS == 128
void test_180(void) {
  __riscv_ztt_i128_8x1_t s0 = __riscv_ztt_mzero_m_i128_8x1();
  __riscv_ztt_i128_4x1_t dst = __riscv_ztt_mextract_i128_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_180(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 1073741952, i32 4)
#endif

#if UDS == 128
void test_181(void) {
  __riscv_ztt_u128_1x2_t s0 = __riscv_ztt_mzero_m_u128_1x2();
  __riscv_ztt_u128_1x1_t dst = __riscv_ztt_mextract_u128_1x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_181(
// UDS128: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 1)
#endif

#if UDS == 128
void test_182(void) {
  __riscv_ztt_u128_1x4_t s0 = __riscv_ztt_mzero_m_u128_1x4();
  __riscv_ztt_u128_1x2_t dst = __riscv_ztt_mextract_u128_1x2(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_182(
// UDS128: call target("riscv.ztt.m.u128", i128, 128, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 2)
#endif

#if UDS == 128
void test_183(void) {
  __riscv_ztt_u128_4x1_t s0 = __riscv_ztt_mzero_m_u128_4x1();
  __riscv_ztt_u128_2x1_t dst = __riscv_ztt_mextract_u128_2x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_183(
// UDS128: call target("riscv.ztt.m.u128", i128, 128, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 2)
#endif

#if UDS == 128
void test_184(void) {
  __riscv_ztt_u128_1x8_t s0 = __riscv_ztt_mzero_m_u128_1x8();
  __riscv_ztt_u128_1x4_t dst = __riscv_ztt_mextract_u128_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_184(
// UDS128: call target("riscv.ztt.m.u128", i128, 128, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 4)
#endif

#if UDS == 128
void test_185(void) {
  __riscv_ztt_u128_8x1_t s0 = __riscv_ztt_mzero_m_u128_8x1();
  __riscv_ztt_u128_4x1_t dst = __riscv_ztt_mextract_u128_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_185(
// UDS128: call target("riscv.ztt.m.u128", i128, 128, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 128, i32 4)
#endif

#if UDS == 128
void test_186(void) {
  __riscv_ztt_f32_1x8_t s0 = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_f32_1x4_t dst = __riscv_ztt_mextract_f32_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_186(
// UDS128: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 4)
#endif

#if UDS == 128
void test_187(void) {
  __riscv_ztt_f32_8x1_t s0 = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_f32_4x1_t dst = __riscv_ztt_mextract_f32_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_187(
// UDS128: call target("riscv.ztt.m.f32", float, 32, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 540016928, i32 4)
#endif

#if UDS == 128
void test_188(void) {
  __riscv_ztt_f64_1x4_t s0 = __riscv_ztt_mzero_m_f64_1x4();
  __riscv_ztt_f64_1x2_t dst = __riscv_ztt_mextract_f64_1x2(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_188(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 2)
#endif

#if UDS == 128
void test_189(void) {
  __riscv_ztt_f64_4x1_t s0 = __riscv_ztt_mzero_m_f64_4x1();
  __riscv_ztt_f64_2x1_t dst = __riscv_ztt_mextract_f64_2x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_189(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 2)
#endif

#if UDS == 128
void test_190(void) {
  __riscv_ztt_f64_1x8_t s0 = __riscv_ztt_mzero_m_f64_1x8();
  __riscv_ztt_f64_1x4_t dst = __riscv_ztt_mextract_f64_1x4(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_190(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 4)
#endif

#if UDS == 128
void test_191(void) {
  __riscv_ztt_f64_8x1_t s0 = __riscv_ztt_mzero_m_f64_8x1();
  __riscv_ztt_f64_4x1_t dst = __riscv_ztt_mextract_f64_4x1(s0, 1);
  (void)dst;
}
// UDS128-LABEL: define{{.*}} @test_191(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mextract{{.*}}({{.*}}i32 741343552, i32 4)
#endif
#ifdef __cplusplus
}
#endif

// Constant indices must be folded even at O0.
// COMMON-LABEL: @constant_index(
// COMMON: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mextract{{.*}}({{.*}}, i{{32|64}} 1, i32 1073741856, i32 4)
#ifdef __cplusplus
extern "C"
#endif
__riscv_ztt_i32_1x4_t constant_index(__riscv_ztt_i32_1x8_t src) {
#ifdef __cplusplus
  const unsigned index = 1;
#else
  enum { index = 1 };
#endif
  return __riscv_ztt_mextract_i32_1x4(src, index);
}
