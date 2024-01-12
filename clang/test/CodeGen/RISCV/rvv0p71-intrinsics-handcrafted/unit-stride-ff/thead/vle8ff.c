// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vle8ff_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i8>, i64 } @llvm.riscv.th.vleff.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP1]]
//
vint8m1_t test_th_vle8ff_v_i8m1(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_i8m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vle8ff_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i8>, i64 } @llvm.riscv.th.vleff.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
vint8m2_t test_th_vle8ff_v_i8m2(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_i8m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vle8ff_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x i8>, i64 } @llvm.riscv.th.vleff.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP1]]
//
vint8m4_t test_th_vle8ff_v_i8m4(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_i8m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vle8ff_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 64 x i8>, i64 } @llvm.riscv.th.vleff.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 64 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 64 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP1]]
//
vint8m8_t test_th_vle8ff_v_i8m8(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_i8m8(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_th_vle8ff_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i8>, i64 } @llvm.riscv.th.vleff.nxv8i8.i64(<vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP1]]
//
vuint8m1_t test_th_vle8ff_v_u8m1(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_u8m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_th_vle8ff_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i8>, i64 } @llvm.riscv.th.vleff.nxv16i8.i64(<vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
vuint8m2_t test_th_vle8ff_v_u8m2(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_u8m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_th_vle8ff_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x i8>, i64 } @llvm.riscv.th.vleff.nxv32i8.i64(<vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP1]]
//
vuint8m4_t test_th_vle8ff_v_u8m4(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_u8m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_th_vle8ff_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 64 x i8>, i64 } @llvm.riscv.th.vleff.nxv64i8.i64(<vscale x 64 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 64 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 64 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP1]]
//
vuint8m8_t test_th_vle8ff_v_u8m8(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle8ff_v_u8m8(base, new_vl, vl);
}
