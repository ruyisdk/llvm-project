// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vlhu_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vlhu.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_th_vlhu_v_u8m1(const uint8_t *base, size_t vl) {
  return __riscv_vlhu_v_u8m1(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vlhu_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vlhu.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_th_vlhu_v_u8m2(const uint8_t *base, size_t vl) {
  return __riscv_vlhu_v_u8m2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vlhu_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vlhu.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_th_vlhu_v_u8m4(const uint8_t *base, size_t vl) {
  return __riscv_vlhu_v_u8m4(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vlhu_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vlhu.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_th_vlhu_v_u8m8(const uint8_t *base, size_t vl) {
  return __riscv_vlhu_v_u8m8(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vlhu_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vlhu.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_th_vlhu_v_u16m1(const uint16_t *base, size_t vl) {
  return __riscv_vlhu_v_u16m1(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vlhu_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vlhu.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_th_vlhu_v_u16m2(const uint16_t *base, size_t vl) {
  return __riscv_vlhu_v_u16m2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vlhu_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vlhu.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_th_vlhu_v_u16m4(const uint16_t *base, size_t vl) {
  return __riscv_vlhu_v_u16m4(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vlhu_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vlhu.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_th_vlhu_v_u16m8(const uint16_t *base, size_t vl) {
  return __riscv_vlhu_v_u16m8(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_th_vlhu_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vlhu.nxv2i32.i64(<vscale x 2 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_th_vlhu_v_u32m1(const uint32_t *base, size_t vl) {
  return __riscv_vlhu_v_u32m1(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_th_vlhu_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vlhu.nxv4i32.i64(<vscale x 4 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_th_vlhu_v_u32m2(const uint32_t *base, size_t vl) {
  return __riscv_vlhu_v_u32m2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_th_vlhu_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vlhu.nxv8i32.i64(<vscale x 8 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_th_vlhu_v_u32m4(const uint32_t *base, size_t vl) {
  return __riscv_vlhu_v_u32m4(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_th_vlhu_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vlhu.nxv16i32.i64(<vscale x 16 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_th_vlhu_v_u32m8(const uint32_t *base, size_t vl) {
  return __riscv_vlhu_v_u32m8(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vlhu_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vlhu.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_th_vlhu_v_u64m1(const uint64_t *base, size_t vl) {
  return __riscv_vlhu_v_u64m1(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vlhu_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vlhu.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_th_vlhu_v_u64m2(const uint64_t *base, size_t vl) {
  return __riscv_vlhu_v_u64m2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vlhu_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vlhu.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_th_vlhu_v_u64m4(const uint64_t *base, size_t vl) {
  return __riscv_vlhu_v_u64m4(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vlhu_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vlhu.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_th_vlhu_v_u64m8(const uint64_t *base, size_t vl) {
  return __riscv_vlhu_v_u64m8(base, vl);
}
