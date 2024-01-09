// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vle64ff_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x i64>, i64 } @llvm.riscv.th.vleff.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP1]]
//
vint64m1_t test_th_vle64ff_v_i64m1(const int64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_i64m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vle64ff_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i64>, i64 } @llvm.riscv.th.vleff.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
vint64m2_t test_th_vle64ff_v_i64m2(const int64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_i64m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vle64ff_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i64>, i64 } @llvm.riscv.th.vleff.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP1]]
//
vint64m4_t test_th_vle64ff_v_i64m4(const int64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_i64m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vle64ff_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i64>, i64 } @llvm.riscv.th.vleff.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP1]]
//
vint64m8_t test_th_vle64ff_v_i64m8(const int64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_i64m8(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_th_vle64ff_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x i64>, i64 } @llvm.riscv.th.vleff.nxv1i64.i64(<vscale x 1 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP1]]
//
vuint64m1_t test_th_vle64ff_v_u64m1(const uint64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_u64m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_th_vle64ff_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i64>, i64 } @llvm.riscv.th.vleff.nxv2i64.i64(<vscale x 2 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
vuint64m2_t test_th_vle64ff_v_u64m2(const uint64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_u64m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_th_vle64ff_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i64>, i64 } @llvm.riscv.th.vleff.nxv4i64.i64(<vscale x 4 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP1]]
//
vuint64m4_t test_th_vle64ff_v_u64m4(const uint64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_u64m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_th_vle64ff_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i64>, i64 } @llvm.riscv.th.vleff.nxv8i64.i64(<vscale x 8 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i64>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i64>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP1]]
//
vuint64m8_t test_th_vle64ff_v_u64m8(const uint64_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle64ff_v_u64m8(base, new_vl, vl);
}
