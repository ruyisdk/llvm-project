// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x float> @test_th_vlse32_v_f32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x float> @llvm.riscv.th.vlse.nxv2f32.i64(<vscale x 2 x float> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x float> [[TMP0]]
//
vfloat32m1_t test_th_vlse32_v_f32m1(const float *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_f32m1(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x float> @test_th_vlse32_v_f32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.riscv.th.vlse.nxv4f32.i64(<vscale x 4 x float> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
vfloat32m2_t test_th_vlse32_v_f32m2(const float *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_f32m2(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x float> @test_th_vlse32_v_f32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x float> @llvm.riscv.th.vlse.nxv8f32.i64(<vscale x 8 x float> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x float> [[TMP0]]
//
vfloat32m4_t test_th_vlse32_v_f32m4(const float *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_f32m4(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x float> @test_th_vlse32_v_f32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x float> @llvm.riscv.th.vlse.nxv16f32.i64(<vscale x 16 x float> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x float> [[TMP0]]
//
vfloat32m8_t test_th_vlse32_v_f32m8(const float *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_f32m8(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlse32_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlse.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_th_vlse32_v_i32m1(const int32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_i32m1(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlse32_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlse.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_th_vlse32_v_i32m2(const int32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_i32m2(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlse32_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlse.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_th_vlse32_v_i32m4(const int32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_i32m4(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlse32_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlse.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_th_vlse32_v_i32m8(const int32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_i32m8(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlse32_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlse.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_th_vlse32_v_u32m1(const uint32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_u32m1(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlse32_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlse.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_th_vlse32_v_u32m2(const uint32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_u32m2(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlse32_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlse.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_th_vlse32_v_u32m4(const uint32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_u32m4(base, stride, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlse32_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlse.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_th_vlse32_v_u32m8(const uint32_t *base, ptrdiff_t stride, size_t vl) {
  return __riscv_vlse32_v_u32m8(base, stride, vl);
}
