// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x half> @test_th_vloxei32_v_f16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x half> @llvm.riscv.th.vlxe.nxv4f16.nxv4i32.i64(<vscale x 4 x half> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x half> [[TMP0]]
//
vfloat16m1_t test_th_vloxei32_v_f16m1(const _Float16 *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f16m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x half> @test_th_vloxei32_v_f16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x half> @llvm.riscv.th.vlxe.nxv8f16.nxv8i32.i64(<vscale x 8 x half> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x half> [[TMP0]]
//
vfloat16m2_t test_th_vloxei32_v_f16m2(const _Float16 *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f16m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x half> @test_th_vloxei32_v_f16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x half> @llvm.riscv.th.vlxe.nxv16f16.nxv16i32.i64(<vscale x 16 x half> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x half> [[TMP0]]
//
vfloat16m4_t test_th_vloxei32_v_f16m4(const _Float16 *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f16m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x float> @test_th_vloxei32_v_f32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x float> @llvm.riscv.th.vlxe.nxv2f32.nxv2i32.i64(<vscale x 2 x float> poison, ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x float> [[TMP0]]
//
vfloat32m1_t test_th_vloxei32_v_f32m1(const float *base, vuint32m1_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f32m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x float> @test_th_vloxei32_v_f32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x float> @llvm.riscv.th.vlxe.nxv4f32.nxv4i32.i64(<vscale x 4 x float> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x float> [[TMP0]]
//
vfloat32m2_t test_th_vloxei32_v_f32m2(const float *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f32m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x float> @test_th_vloxei32_v_f32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x float> @llvm.riscv.th.vlxe.nxv8f32.nxv8i32.i64(<vscale x 8 x float> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x float> [[TMP0]]
//
vfloat32m4_t test_th_vloxei32_v_f32m4(const float *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f32m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x float> @test_th_vloxei32_v_f32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x float> @llvm.riscv.th.vlxe.nxv16f32.nxv16i32.i64(<vscale x 16 x float> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x float> [[TMP0]]
//
vfloat32m8_t test_th_vloxei32_v_f32m8(const float *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f32m8(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x double> @test_th_vloxei32_v_f64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x double> @llvm.riscv.th.vlxe.nxv2f64.nxv2i32.i64(<vscale x 2 x double> poison, ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x double> [[TMP0]]
//
vfloat64m2_t test_th_vloxei32_v_f64m2(const double *base, vuint32m1_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f64m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x double> @test_th_vloxei32_v_f64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x double> @llvm.riscv.th.vlxe.nxv4f64.nxv4i32.i64(<vscale x 4 x double> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x double> [[TMP0]]
//
vfloat64m4_t test_th_vloxei32_v_f64m4(const double *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f64m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x double> @test_th_vloxei32_v_f64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x double> @llvm.riscv.th.vlxe.nxv8f64.nxv8i32.i64(<vscale x 8 x double> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x double> [[TMP0]]
//
vfloat64m8_t test_th_vloxei32_v_f64m8(const double *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_f64m8(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vloxei32_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxe.nxv8i8.nxv8i32.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_th_vloxei32_v_i8m1(const int8_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i8m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vloxei32_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxe.nxv16i8.nxv16i32.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_th_vloxei32_v_i8m2(const int8_t *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i8m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vloxei32_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxe.nxv4i16.nxv4i32.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_th_vloxei32_v_i16m1(const int16_t *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i16m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vloxei32_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxe.nxv8i16.nxv8i32.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_th_vloxei32_v_i16m2(const int16_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i16m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vloxei32_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxe.nxv16i16.nxv16i32.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_th_vloxei32_v_i16m4(const int16_t *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i16m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vloxei32_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxe.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_th_vloxei32_v_i32m1(const int32_t *base, vuint32m1_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i32m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vloxei32_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxe.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_th_vloxei32_v_i32m2(const int32_t *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i32m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vloxei32_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxe.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_th_vloxei32_v_i32m4(const int32_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i32m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vloxei32_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxe.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_th_vloxei32_v_i32m8(const int32_t *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i32m8(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vloxei32_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxe.nxv2i64.nxv2i32.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_th_vloxei32_v_i64m2(const int64_t *base, vuint32m1_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i64m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vloxei32_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxe.nxv4i64.nxv4i32.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_th_vloxei32_v_i64m4(const int64_t *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i64m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vloxei32_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxe.nxv8i64.nxv8i32.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_th_vloxei32_v_i64m8(const int64_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_i64m8(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vloxei32_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxe.nxv8i8.nxv8i32.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_th_vloxei32_v_u8m1(const uint8_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u8m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vloxei32_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxe.nxv16i8.nxv16i32.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_th_vloxei32_v_u8m2(const uint8_t *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u8m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vloxei32_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxe.nxv4i16.nxv4i32.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_th_vloxei32_v_u16m1(const uint16_t *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u16m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vloxei32_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxe.nxv8i16.nxv8i32.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_th_vloxei32_v_u16m2(const uint16_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u16m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vloxei32_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxe.nxv16i16.nxv16i32.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_th_vloxei32_v_u16m4(const uint16_t *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u16m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vloxei32_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxe.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_th_vloxei32_v_u32m1(const uint32_t *base, vuint32m1_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u32m1(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vloxei32_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxe.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_th_vloxei32_v_u32m2(const uint32_t *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u32m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vloxei32_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxe.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_th_vloxei32_v_u32m4(const uint32_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u32m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vloxei32_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxe.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_th_vloxei32_v_u32m8(const uint32_t *base, vuint32m8_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u32m8(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vloxei32_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxe.nxv2i64.nxv2i32.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_th_vloxei32_v_u64m2(const uint64_t *base, vuint32m1_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u64m2(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vloxei32_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxe.nxv4i64.nxv4i32.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_th_vloxei32_v_u64m4(const uint64_t *base, vuint32m2_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u64m4(base, bindex, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vloxei32_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[BINDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxe.nxv8i64.nxv8i32.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i32> [[BINDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_th_vloxei32_v_u64m8(const uint64_t *base, vuint32m4_t bindex, size_t vl) {
  return __riscv_th_vloxei32_v_u64m8(base, bindex, vl);
}
