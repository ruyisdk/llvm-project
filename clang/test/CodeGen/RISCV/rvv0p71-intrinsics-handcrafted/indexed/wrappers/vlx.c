// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlxb_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxb.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_th_vlxb_v_i8m1(const int8_t *base, vuint8m1_t index, size_t vl) {
  return __riscv_vlxb_v_i8m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlxb_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxb.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_th_vlxb_v_i8m2(const int8_t *base, vuint8m2_t index, size_t vl) {
  return __riscv_vlxb_v_i8m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlxb_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlxb.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_th_vlxb_v_i8m4(const int8_t *base, vuint8m4_t index, size_t vl) {
  return __riscv_vlxb_v_i8m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlxb_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlxb.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_th_vlxb_v_i8m8(const int8_t *base, vuint8m8_t index, size_t vl) {
  return __riscv_vlxb_v_i8m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlxb_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxb.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_th_vlxb_v_i16m1(const int16_t *base, vuint16m1_t index, size_t vl) {
  return __riscv_vlxb_v_i16m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlxb_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxb.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_th_vlxb_v_i16m2(const int16_t *base, vuint16m2_t index, size_t vl) {
  return __riscv_vlxb_v_i16m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlxb_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxb.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_th_vlxb_v_i16m4(const int16_t *base, vuint16m4_t index, size_t vl) {
  return __riscv_vlxb_v_i16m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlxb_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlxb.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_th_vlxb_v_i16m8(const int16_t *base, vuint16m8_t index, size_t vl) {
  return __riscv_vlxb_v_i16m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlxb_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxb.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_th_vlxb_v_i32m1(const int32_t *base, vuint32m1_t index, size_t vl) {
  return __riscv_vlxb_v_i32m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlxb_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxb.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_th_vlxb_v_i32m2(const int32_t *base, vuint32m2_t index, size_t vl) {
  return __riscv_vlxb_v_i32m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlxb_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxb.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_th_vlxb_v_i32m4(const int32_t *base, vuint32m4_t index, size_t vl) {
  return __riscv_vlxb_v_i32m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlxb_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxb.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_th_vlxb_v_i32m8(const int32_t *base, vuint32m8_t index, size_t vl) {
  return __riscv_vlxb_v_i32m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlxb_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlxb.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_th_vlxb_v_i64m1(const int64_t *base, vuint64m1_t index, size_t vl) {
  return __riscv_vlxb_v_i64m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlxb_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxb.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_th_vlxb_v_i64m2(const int64_t *base, vuint64m2_t index, size_t vl) {
  return __riscv_vlxb_v_i64m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlxb_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxb.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_th_vlxb_v_i64m4(const int64_t *base, vuint64m4_t index, size_t vl) {
  return __riscv_vlxb_v_i64m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlxb_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxb.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_th_vlxb_v_i64m8(const int64_t *base, vuint64m8_t index, size_t vl) {
  return __riscv_vlxb_v_i64m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlxh_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxh.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_th_vlxh_v_i8m1(const int8_t *base, vuint8m1_t index, size_t vl) {
  return __riscv_vlxh_v_i8m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlxh_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxh.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_th_vlxh_v_i8m2(const int8_t *base, vuint8m2_t index, size_t vl) {
  return __riscv_vlxh_v_i8m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlxh_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlxh.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_th_vlxh_v_i8m4(const int8_t *base, vuint8m4_t index, size_t vl) {
  return __riscv_vlxh_v_i8m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlxh_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlxh.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_th_vlxh_v_i8m8(const int8_t *base, vuint8m8_t index, size_t vl) {
  return __riscv_vlxh_v_i8m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlxh_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxh.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_th_vlxh_v_i16m1(const int16_t *base, vuint16m1_t index, size_t vl) {
  return __riscv_vlxh_v_i16m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlxh_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxh.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_th_vlxh_v_i16m2(const int16_t *base, vuint16m2_t index, size_t vl) {
  return __riscv_vlxh_v_i16m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlxh_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxh.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_th_vlxh_v_i16m4(const int16_t *base, vuint16m4_t index, size_t vl) {
  return __riscv_vlxh_v_i16m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlxh_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlxh.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_th_vlxh_v_i16m8(const int16_t *base, vuint16m8_t index, size_t vl) {
  return __riscv_vlxh_v_i16m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlxh_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxh.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_th_vlxh_v_i32m1(const int32_t *base, vuint32m1_t index, size_t vl) {
  return __riscv_vlxh_v_i32m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlxh_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxh.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_th_vlxh_v_i32m2(const int32_t *base, vuint32m2_t index, size_t vl) {
  return __riscv_vlxh_v_i32m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlxh_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxh.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_th_vlxh_v_i32m4(const int32_t *base, vuint32m4_t index, size_t vl) {
  return __riscv_vlxh_v_i32m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlxh_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxh.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_th_vlxh_v_i32m8(const int32_t *base, vuint32m8_t index, size_t vl) {
  return __riscv_vlxh_v_i32m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlxh_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlxh.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_th_vlxh_v_i64m1(const int64_t *base, vuint64m1_t index, size_t vl) {
  return __riscv_vlxh_v_i64m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlxh_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxh.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_th_vlxh_v_i64m2(const int64_t *base, vuint64m2_t index, size_t vl) {
  return __riscv_vlxh_v_i64m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlxh_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxh.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_th_vlxh_v_i64m4(const int64_t *base, vuint64m4_t index, size_t vl) {
  return __riscv_vlxh_v_i64m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlxh_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxh.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_th_vlxh_v_i64m8(const int64_t *base, vuint64m8_t index, size_t vl) {
  return __riscv_vlxh_v_i64m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlxw_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxw.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_th_vlxw_v_i8m1(const int8_t *base, vuint8m1_t index, size_t vl) {
  return __riscv_vlxw_v_i8m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlxw_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxw.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_th_vlxw_v_i8m2(const int8_t *base, vuint8m2_t index, size_t vl) {
  return __riscv_vlxw_v_i8m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlxw_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlxw.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_th_vlxw_v_i8m4(const int8_t *base, vuint8m4_t index, size_t vl) {
  return __riscv_vlxw_v_i8m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlxw_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlxw.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_th_vlxw_v_i8m8(const int8_t *base, vuint8m8_t index, size_t vl) {
  return __riscv_vlxw_v_i8m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlxw_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxw.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_th_vlxw_v_i16m1(const int16_t *base, vuint16m1_t index, size_t vl) {
  return __riscv_vlxw_v_i16m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlxw_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxw.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_th_vlxw_v_i16m2(const int16_t *base, vuint16m2_t index, size_t vl) {
  return __riscv_vlxw_v_i16m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlxw_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxw.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_th_vlxw_v_i16m4(const int16_t *base, vuint16m4_t index, size_t vl) {
  return __riscv_vlxw_v_i16m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlxw_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlxw.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_th_vlxw_v_i16m8(const int16_t *base, vuint16m8_t index, size_t vl) {
  return __riscv_vlxw_v_i16m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlxw_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxw.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_th_vlxw_v_i32m1(const int32_t *base, vuint32m1_t index, size_t vl) {
  return __riscv_vlxw_v_i32m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlxw_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxw.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_th_vlxw_v_i32m2(const int32_t *base, vuint32m2_t index, size_t vl) {
  return __riscv_vlxw_v_i32m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlxw_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxw.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_th_vlxw_v_i32m4(const int32_t *base, vuint32m4_t index, size_t vl) {
  return __riscv_vlxw_v_i32m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlxw_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxw.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_th_vlxw_v_i32m8(const int32_t *base, vuint32m8_t index, size_t vl) {
  return __riscv_vlxw_v_i32m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlxw_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlxw.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_th_vlxw_v_i64m1(const int64_t *base, vuint64m1_t index, size_t vl) {
  return __riscv_vlxw_v_i64m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlxw_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxw.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_th_vlxw_v_i64m2(const int64_t *base, vuint64m2_t index, size_t vl) {
  return __riscv_vlxw_v_i64m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlxw_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxw.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_th_vlxw_v_i64m4(const int64_t *base, vuint64m4_t index, size_t vl) {
  return __riscv_vlxw_v_i64m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlxw_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxw.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_th_vlxw_v_i64m8(const int64_t *base, vuint64m8_t index, size_t vl) {
  return __riscv_vlxw_v_i64m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlxbu_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxbu.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_th_vlxbu_v_u8m1(const uint8_t *base, vuint8m1_t index, size_t vl) {
  return __riscv_vlxbu_v_u8m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlxbu_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxbu.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_th_vlxbu_v_u8m2(const uint8_t *base, vuint8m2_t index, size_t vl) {
  return __riscv_vlxbu_v_u8m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlxbu_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlxbu.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_th_vlxbu_v_u8m4(const uint8_t *base, vuint8m4_t index, size_t vl) {
  return __riscv_vlxbu_v_u8m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlxbu_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlxbu.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_th_vlxbu_v_u8m8(const uint8_t *base, vuint8m8_t index, size_t vl) {
  return __riscv_vlxbu_v_u8m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlxbu_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxbu.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_th_vlxbu_v_u16m1(const uint16_t *base, vuint16m1_t index, size_t vl) {
  return __riscv_vlxbu_v_u16m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlxbu_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxbu.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_th_vlxbu_v_u16m2(const uint16_t *base, vuint16m2_t index, size_t vl) {
  return __riscv_vlxbu_v_u16m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlxbu_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxbu.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_th_vlxbu_v_u16m4(const uint16_t *base, vuint16m4_t index, size_t vl) {
  return __riscv_vlxbu_v_u16m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlxbu_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlxbu.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_th_vlxbu_v_u16m8(const uint16_t *base, vuint16m8_t index, size_t vl) {
  return __riscv_vlxbu_v_u16m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlxbu_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxbu.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_th_vlxbu_v_u32m1(const uint32_t *base, vuint32m1_t index, size_t vl) {
  return __riscv_vlxbu_v_u32m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlxbu_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxbu.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_th_vlxbu_v_u32m2(const uint32_t *base, vuint32m2_t index, size_t vl) {
  return __riscv_vlxbu_v_u32m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlxbu_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxbu.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_th_vlxbu_v_u32m4(const uint32_t *base, vuint32m4_t index, size_t vl) {
  return __riscv_vlxbu_v_u32m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlxbu_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxbu.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_th_vlxbu_v_u32m8(const uint32_t *base, vuint32m8_t index, size_t vl) {
  return __riscv_vlxbu_v_u32m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlxbu_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlxbu.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_th_vlxbu_v_u64m1(const uint64_t *base, vuint64m1_t index, size_t vl) {
  return __riscv_vlxbu_v_u64m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlxbu_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxbu.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_th_vlxbu_v_u64m2(const uint64_t *base, vuint64m2_t index, size_t vl) {
  return __riscv_vlxbu_v_u64m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlxbu_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxbu.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_th_vlxbu_v_u64m4(const uint64_t *base, vuint64m4_t index, size_t vl) {
  return __riscv_vlxbu_v_u64m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlxbu_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxbu.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_th_vlxbu_v_u64m8(const uint64_t *base, vuint64m8_t index, size_t vl) {
  return __riscv_vlxbu_v_u64m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlxhu_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxhu.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_th_vlxhu_v_u8m1(const uint8_t *base, vuint8m1_t index, size_t vl) {
  return __riscv_vlxhu_v_u8m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlxhu_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxhu.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_th_vlxhu_v_u8m2(const uint8_t *base, vuint8m2_t index, size_t vl) {
  return __riscv_vlxhu_v_u8m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlxhu_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlxhu.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_th_vlxhu_v_u8m4(const uint8_t *base, vuint8m4_t index, size_t vl) {
  return __riscv_vlxhu_v_u8m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlxhu_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlxhu.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_th_vlxhu_v_u8m8(const uint8_t *base, vuint8m8_t index, size_t vl) {
  return __riscv_vlxhu_v_u8m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlxhu_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxhu.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_th_vlxhu_v_u16m1(const uint16_t *base, vuint16m1_t index, size_t vl) {
  return __riscv_vlxhu_v_u16m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlxhu_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxhu.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_th_vlxhu_v_u16m2(const uint16_t *base, vuint16m2_t index, size_t vl) {
  return __riscv_vlxhu_v_u16m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlxhu_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxhu.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_th_vlxhu_v_u16m4(const uint16_t *base, vuint16m4_t index, size_t vl) {
  return __riscv_vlxhu_v_u16m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlxhu_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlxhu.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_th_vlxhu_v_u16m8(const uint16_t *base, vuint16m8_t index, size_t vl) {
  return __riscv_vlxhu_v_u16m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlxhu_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxhu.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_th_vlxhu_v_u32m1(const uint32_t *base, vuint32m1_t index, size_t vl) {
  return __riscv_vlxhu_v_u32m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlxhu_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxhu.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_th_vlxhu_v_u32m2(const uint32_t *base, vuint32m2_t index, size_t vl) {
  return __riscv_vlxhu_v_u32m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlxhu_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxhu.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_th_vlxhu_v_u32m4(const uint32_t *base, vuint32m4_t index, size_t vl) {
  return __riscv_vlxhu_v_u32m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlxhu_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxhu.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_th_vlxhu_v_u32m8(const uint32_t *base, vuint32m8_t index, size_t vl) {
  return __riscv_vlxhu_v_u32m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlxhu_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlxhu.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_th_vlxhu_v_u64m1(const uint64_t *base, vuint64m1_t index, size_t vl) {
  return __riscv_vlxhu_v_u64m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlxhu_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxhu.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_th_vlxhu_v_u64m2(const uint64_t *base, vuint64m2_t index, size_t vl) {
  return __riscv_vlxhu_v_u64m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlxhu_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxhu.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_th_vlxhu_v_u64m4(const uint64_t *base, vuint64m4_t index, size_t vl) {
  return __riscv_vlxhu_v_u64m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlxhu_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxhu.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_th_vlxhu_v_u64m8(const uint64_t *base, vuint64m8_t index, size_t vl) {
  return __riscv_vlxhu_v_u64m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlxwu_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlxwu.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_th_vlxwu_v_u8m1(const uint8_t *base, vuint8m1_t index, size_t vl) {
  return __riscv_vlxwu_v_u8m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlxwu_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlxwu.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_th_vlxwu_v_u8m2(const uint8_t *base, vuint8m2_t index, size_t vl) {
  return __riscv_vlxwu_v_u8m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlxwu_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlxwu.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_th_vlxwu_v_u8m4(const uint8_t *base, vuint8m4_t index, size_t vl) {
  return __riscv_vlxwu_v_u8m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlxwu_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlxwu.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_th_vlxwu_v_u8m8(const uint8_t *base, vuint8m8_t index, size_t vl) {
  return __riscv_vlxwu_v_u8m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlxwu_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlxwu.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_th_vlxwu_v_u16m1(const uint16_t *base, vuint16m1_t index, size_t vl) {
  return __riscv_vlxwu_v_u16m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlxwu_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlxwu.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_th_vlxwu_v_u16m2(const uint16_t *base, vuint16m2_t index, size_t vl) {
  return __riscv_vlxwu_v_u16m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlxwu_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlxwu.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_th_vlxwu_v_u16m4(const uint16_t *base, vuint16m4_t index, size_t vl) {
  return __riscv_vlxwu_v_u16m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlxwu_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlxwu.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_th_vlxwu_v_u16m8(const uint16_t *base, vuint16m8_t index, size_t vl) {
  return __riscv_vlxwu_v_u16m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlxwu_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlxwu.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_th_vlxwu_v_u32m1(const uint32_t *base, vuint32m1_t index, size_t vl) {
  return __riscv_vlxwu_v_u32m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlxwu_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlxwu.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_th_vlxwu_v_u32m2(const uint32_t *base, vuint32m2_t index, size_t vl) {
  return __riscv_vlxwu_v_u32m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlxwu_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlxwu.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_th_vlxwu_v_u32m4(const uint32_t *base, vuint32m4_t index, size_t vl) {
  return __riscv_vlxwu_v_u32m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlxwu_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlxwu.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_th_vlxwu_v_u32m8(const uint32_t *base, vuint32m8_t index, size_t vl) {
  return __riscv_vlxwu_v_u32m8(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlxwu_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlxwu.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_th_vlxwu_v_u64m1(const uint64_t *base, vuint64m1_t index, size_t vl) {
  return __riscv_vlxwu_v_u64m1(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlxwu_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlxwu.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_th_vlxwu_v_u64m2(const uint64_t *base, vuint64m2_t index, size_t vl) {
  return __riscv_vlxwu_v_u64m2(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlxwu_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlxwu.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_th_vlxwu_v_u64m4(const uint64_t *base, vuint64m4_t index, size_t vl) {
  return __riscv_vlxwu_v_u64m4(base, index, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlxwu_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlxwu.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_th_vlxwu_v_u64m8(const uint64_t *base, vuint64m8_t index, size_t vl) {
  return __riscv_vlxwu_v_u64m8(base, index, vl);
}
