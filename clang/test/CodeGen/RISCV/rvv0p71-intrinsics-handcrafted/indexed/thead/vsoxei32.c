// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x half> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4f16.nxv4i32.i64(<vscale x 4 x half> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f16m1(_Float16 *base, vuint32m2_t bindex, vfloat16m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f16m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x half> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8f16.nxv8i32.i64(<vscale x 8 x half> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f16m2(_Float16 *base, vuint32m4_t bindex, vfloat16m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f16m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x half> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16f16.nxv16i32.i64(<vscale x 16 x half> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f16m4(_Float16 *base, vuint32m8_t bindex, vfloat16m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f16m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], <vscale x 2 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv2f32.nxv2i32.i64(<vscale x 2 x float> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f32m1(float *base, vuint32m1_t bindex, vfloat32m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f32m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4f32.nxv4i32.i64(<vscale x 4 x float> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f32m2(float *base, vuint32m2_t bindex, vfloat32m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f32m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8f32.nxv8i32.i64(<vscale x 8 x float> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f32m4(float *base, vuint32m4_t bindex, vfloat32m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f32m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x float> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16f32.nxv16i32.i64(<vscale x 16 x float> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f32m8(float *base, vuint32m8_t bindex, vfloat32m8_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f32m8(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], <vscale x 2 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv2f64.nxv2i32.i64(<vscale x 2 x double> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f64m2(double *base, vuint32m1_t bindex, vfloat64m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f64m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4f64.nxv4i32.i64(<vscale x 4 x double> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f64m4(double *base, vuint32m2_t bindex, vfloat64m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f64m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_f64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x double> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8f64.nxv8i32.i64(<vscale x 8 x double> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_f64m8(double *base, vuint32m4_t bindex, vfloat64m8_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_f64m8(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i8.nxv8i32.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i8m1(int8_t *base, vuint32m4_t bindex, vint8m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i8m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16i8.nxv16i32.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i8m2(int8_t *base, vuint32m8_t bindex, vint8m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i8m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4i16.nxv4i32.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i16m1(int16_t *base, vuint32m2_t bindex, vint16m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i16m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i16.nxv8i32.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i16m2(int16_t *base, vuint32m4_t bindex, vint16m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i16m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16i16.nxv16i32.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i16m4(int16_t *base, vuint32m8_t bindex, vint16m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i16m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i32m1(int32_t *base, vuint32m1_t bindex, vint32m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i32m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i32m2(int32_t *base, vuint32m2_t bindex, vint32m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i32m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i32m4(int32_t *base, vuint32m4_t bindex, vint32m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i32m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i32m8(int32_t *base, vuint32m8_t bindex, vint32m8_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i32m8(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv2i64.nxv2i32.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i64m2(int64_t *base, vuint32m1_t bindex, vint64m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i64m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4i64.nxv4i32.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i64m4(int64_t *base, vuint32m2_t bindex, vint64m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i64m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i64.nxv8i32.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_i64m8(int64_t *base, vuint32m4_t bindex, vint64m8_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_i64m8(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i8.nxv8i32.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u8m1(uint8_t *base, vuint32m4_t bindex, vuint8m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u8m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16i8.nxv16i32.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u8m2(uint8_t *base, vuint32m8_t bindex, vuint8m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u8m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4i16.nxv4i32.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u16m1(uint16_t *base, vuint32m2_t bindex, vuint16m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u16m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i16.nxv8i32.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u16m2(uint16_t *base, vuint32m4_t bindex, vuint16m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u16m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16i16.nxv16i32.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u16m4(uint16_t *base, vuint32m8_t bindex, vuint16m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u16m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u32m1(uint32_t *base, vuint32m1_t bindex, vuint32m1_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u32m1(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u32m2(uint32_t *base, vuint32m2_t bindex, vuint32m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u32m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u32m4(uint32_t *base, vuint32m4_t bindex, vuint32m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u32m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u32m8(uint32_t *base, vuint32m8_t bindex, vuint32m8_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u32m8(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv2i64.nxv2i32.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u64m2(uint64_t *base, vuint32m1_t bindex, vuint64m2_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u64m2(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv4i64.nxv4i32.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u64m4(uint64_t *base, vuint32m2_t bindex, vuint64m4_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u64m4(base, bindex, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsoxei32_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxe.nxv8i64.nxv8i32.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsoxei32_v_u64m8(uint64_t *base, vuint32m4_t bindex, vuint64m8_t value, size_t vl) {
  return __riscv_th_vsoxei32_v_u64m8(base, bindex, value, vl);
}

