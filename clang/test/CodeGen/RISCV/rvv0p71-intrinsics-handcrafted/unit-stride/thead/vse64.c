// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_f64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv1f64.i64(<vscale x 1 x double> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_f64m1(double *base, vfloat64m1_t value, size_t vl) {
  return __riscv_th_vse64_v_f64m1(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_f64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv2f64.i64(<vscale x 2 x double> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_f64m2(double *base, vfloat64m2_t value, size_t vl) {
  return __riscv_th_vse64_v_f64m2(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_f64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv4f64.i64(<vscale x 4 x double> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_f64m4(double *base, vfloat64m4_t value, size_t vl) {
  return __riscv_th_vse64_v_f64m4(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_f64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv8f64.i64(<vscale x 8 x double> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_f64m8(double *base, vfloat64m8_t value, size_t vl) {
  return __riscv_th_vse64_v_f64m8(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_i64m1(int64_t *base, vint64m1_t value, size_t vl) {
  return __riscv_th_vse64_v_i64m1(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_i64m2(int64_t *base, vint64m2_t value, size_t vl) {
  return __riscv_th_vse64_v_i64m2(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_i64m4(int64_t *base, vint64m4_t value, size_t vl) {
  return __riscv_th_vse64_v_i64m4(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_i64m8(int64_t *base, vint64m8_t value, size_t vl) {
  return __riscv_th_vse64_v_i64m8(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_u64m1(uint64_t *base, vuint64m1_t value, size_t vl) {
  return __riscv_th_vse64_v_u64m1(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_u64m2(uint64_t *base, vuint64m2_t value, size_t vl) {
  return __riscv_th_vse64_v_u64m2(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_u64m4(uint64_t *base, vuint64m4_t value, size_t vl) {
  return __riscv_th_vse64_v_u64m4(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse64_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse64_v_u64m8(uint64_t *base, vuint64m8_t value, size_t vl) {
  return __riscv_th_vse64_v_u64m8(base, value, vl);
}
