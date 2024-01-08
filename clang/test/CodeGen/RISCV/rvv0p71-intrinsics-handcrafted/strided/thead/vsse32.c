// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_f32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv2f32.i64(<vscale x 2 x float> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_f32m1(float *base, ptrdiff_t stride, vfloat32m1_t value, size_t vl) {
  return __riscv_th_vsse32_v_f32m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_f32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv4f32.i64(<vscale x 4 x float> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_f32m2(float *base, ptrdiff_t stride, vfloat32m2_t value, size_t vl) {
  return __riscv_th_vsse32_v_f32m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_f32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv8f32.i64(<vscale x 8 x float> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_f32m4(float *base, ptrdiff_t stride, vfloat32m4_t value, size_t vl) {
  return __riscv_th_vsse32_v_f32m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_f32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv16f32.i64(<vscale x 16 x float> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_f32m8(float *base, ptrdiff_t stride, vfloat32m8_t value, size_t vl) {
  return __riscv_th_vsse32_v_f32m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_i32m1(int32_t *base, ptrdiff_t stride, vint32m1_t value, size_t vl) {
  return __riscv_th_vsse32_v_i32m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_i32m2(int32_t *base, ptrdiff_t stride, vint32m2_t value, size_t vl) {
  return __riscv_th_vsse32_v_i32m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_i32m4(int32_t *base, ptrdiff_t stride, vint32m4_t value, size_t vl) {
  return __riscv_th_vsse32_v_i32m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_i32m8(int32_t *base, ptrdiff_t stride, vint32m8_t value, size_t vl) {
  return __riscv_th_vsse32_v_i32m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_u32m1(uint32_t *base, ptrdiff_t stride, vuint32m1_t value, size_t vl) {
  return __riscv_th_vsse32_v_u32m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_u32m2(uint32_t *base, ptrdiff_t stride, vuint32m2_t value, size_t vl) {
  return __riscv_th_vsse32_v_u32m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_u32m4(uint32_t *base, ptrdiff_t stride, vuint32m4_t value, size_t vl) {
  return __riscv_th_vsse32_v_u32m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsse32_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsse.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsse32_v_u32m8(uint32_t *base, ptrdiff_t stride, vuint32m8_t value, size_t vl) {
  return __riscv_th_vsse32_v_u32m8(base, stride, value, vl);
}
