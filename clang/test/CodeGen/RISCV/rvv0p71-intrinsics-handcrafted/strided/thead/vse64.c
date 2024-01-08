// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_f64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 1 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv1f64.i64(<vscale x 1 x double> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_f64m1(double *base, ptrdiff_t stride, vfloat64m1_t value, size_t vl) {
  return __riscv_th_vsse64_v_f64m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_f64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv2f64.i64(<vscale x 2 x double> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_f64m2(double *base, ptrdiff_t stride, vfloat64m2_t value, size_t vl) {
  return __riscv_th_vsse64_v_f64m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_f64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv4f64.i64(<vscale x 4 x double> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_f64m4(double *base, ptrdiff_t stride, vfloat64m4_t value, size_t vl) {
  return __riscv_th_vsse64_v_f64m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_f64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv8f64.i64(<vscale x 8 x double> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_f64m8(double *base, ptrdiff_t stride, vfloat64m8_t value, size_t vl) {
  return __riscv_th_vsse64_v_f64m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_i64m1(int64_t *base, ptrdiff_t stride, vint64m1_t value, size_t vl) {
  return __riscv_th_vsse64_v_i64m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_i64m2(int64_t *base, ptrdiff_t stride, vint64m2_t value, size_t vl) {
  return __riscv_th_vsse64_v_i64m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_i64m4(int64_t *base, ptrdiff_t stride, vint64m4_t value, size_t vl) {
  return __riscv_th_vsse64_v_i64m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_i64m8(int64_t *base, ptrdiff_t stride, vint64m8_t value, size_t vl) {
  return __riscv_th_vsse64_v_i64m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_u64m1(uint64_t *base, ptrdiff_t stride, vuint64m1_t value, size_t vl) {
  return __riscv_th_vsse64_v_u64m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_u64m2(uint64_t *base, ptrdiff_t stride, vuint64m2_t value, size_t vl) {
  return __riscv_th_vsse64_v_u64m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_u64m4(uint64_t *base, ptrdiff_t stride, vuint64m4_t value, size_t vl) {
  return __riscv_th_vsse64_v_u64m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse64_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse64_v_u64m8(uint64_t *base, ptrdiff_t stride, vuint64m8_t value, size_t vl) {
  return __riscv_th_vsse64_v_u64m8(base, stride, value, vl);
}
