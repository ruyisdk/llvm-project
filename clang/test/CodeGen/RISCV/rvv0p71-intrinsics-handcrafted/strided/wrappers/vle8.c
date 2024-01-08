// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vle8_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vle.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_th_vle8_v_i8m1(const int8_t *base, size_t vl) {
  return __riscv_vle8_v_i8m1(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vle8_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vle.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_th_vle8_v_i8m2(const int8_t *base, size_t vl) {
  return __riscv_vle8_v_i8m2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vle8_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vle.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_th_vle8_v_i8m4(const int8_t *base, size_t vl) {
  return __riscv_vle8_v_i8m4(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vle8_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vle.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_th_vle8_v_i8m8(const int8_t *base, size_t vl) {
  return __riscv_vle8_v_i8m8(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vle8_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vle.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_th_vle8_v_u8m1(const uint8_t *base, size_t vl) {
  return __riscv_vle8_v_u8m1(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vle8_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vle.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_th_vle8_v_u8m2(const uint8_t *base, size_t vl) {
  return __riscv_vle8_v_u8m2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vle8_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vle.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_th_vle8_v_u8m4(const uint8_t *base, size_t vl) {
  return __riscv_vle8_v_u8m4(base, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vle8_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vle.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_th_vle8_v_u8m8(const uint8_t *base, size_t vl) {
  return __riscv_vle8_v_u8m8(base, vl);
}
