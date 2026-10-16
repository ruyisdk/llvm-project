// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
void test_1_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_row_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_row_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_row_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_row_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_col_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_col_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_col_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_1_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mzero_m_f32_1x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_1_col_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 1)
void test_2_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_row_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_row_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_row_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x2_t a = __riscv_ztt_mzero_m_i32_1x2();
  __riscv_ztt_f32_1x2_t b = __riscv_ztt_mzero_m_f32_1x2();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_row_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_col_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_col_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_col_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_2_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_2x1_t a = __riscv_ztt_mzero_m_i32_2x1();
  __riscv_ztt_f32_2x1_t b = __riscv_ztt_mzero_m_f32_2x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_2_col_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 2)
void test_4_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_row_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_row_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_row_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x4_t a = __riscv_ztt_mzero_m_i32_1x4();
  __riscv_ztt_f32_1x4_t b = __riscv_ztt_mzero_m_f32_1x4();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_row_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_col_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_col_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_col_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_4_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_4x1_t a = __riscv_ztt_mzero_m_i32_4x1();
  __riscv_ztt_f32_4x1_t b = __riscv_ztt_mzero_m_f32_4x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_4_col_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 4)
void test_8_row_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_row_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_row_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_row_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_row_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_row_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_row_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_1x8_t a = __riscv_ztt_mzero_m_i32_1x8();
  __riscv_ztt_f32_1x8_t b = __riscv_ztt_mzero_m_f32_1x8();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_row_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_col_1(void) {
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx1_t dst = __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_col_1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_col_2(void) {
  __riscv_ztt_i32_accx2_t old = __riscv_ztt_mzero_acc_i32_accx2();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx2_t dst = __riscv_ztt_mmulatacc_2d_i32_accx2(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_col_2(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_col_4(void) {
  __riscv_ztt_i32_accx4_t old = __riscv_ztt_mzero_acc_i32_accx4();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx4_t dst = __riscv_ztt_mmulatacc_2d_i32_accx4(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_col_4(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
void test_8_col_8(void) {
  __riscv_ztt_i32_accx8_t old = __riscv_ztt_mzero_acc_i32_accx8();
  __riscv_ztt_i32_8x1_t a = __riscv_ztt_mzero_m_i32_8x1();
  __riscv_ztt_f32_8x1_t b = __riscv_ztt_mzero_m_f32_8x1();
  __riscv_ztt_i32_accx8_t dst = __riscv_ztt_mmulatacc_2d_i32_accx8(old, a, b);
  (void)dst;
}
// CHECK-LABEL: define{{.*}} @test_8_col_8(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mmulatacc.2d{{.*}}i32 8)
#ifdef __cplusplus
}
#endif
