// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 1 x double>, <vscale x 1 x double> } @test_th_vlseg2e64_v_f64m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x double>, <vscale x 1 x double> } @llvm.riscv.th.vlseg2e.nxv1f64.i64(<vscale x 1 x double> poison, <vscale x 1 x double> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP0]]
//
vfloat64m1x2_t test_th_vlseg2e64_v_f64m1x2(const double *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_f64m1x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x double>, <vscale x 2 x double> } @test_th_vlseg2e64_v_f64m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x double>, <vscale x 2 x double> } @llvm.riscv.th.vlseg2e.nxv2f64.i64(<vscale x 2 x double> poison, <vscale x 2 x double> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP0]]
//
vfloat64m2x2_t test_th_vlseg2e64_v_f64m2x2(const double *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_f64m2x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x double>, <vscale x 4 x double> } @test_th_vlseg2e64_v_f64m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x double>, <vscale x 4 x double> } @llvm.riscv.th.vlseg2e.nxv4f64.i64(<vscale x 4 x double> poison, <vscale x 4 x double> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP0]]
//
vfloat64m4x2_t test_th_vlseg2e64_v_f64m4x2(const double *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_f64m4x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 1 x i64>, <vscale x 1 x i64> } @test_th_vlseg2e64_v_i64m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.riscv.th.vlseg2e.nxv1i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP0]]
//
vint64m1x2_t test_th_vlseg2e64_v_i64m1x2(const int64_t *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_i64m1x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x i64>, <vscale x 2 x i64> } @test_th_vlseg2e64_v_i64m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.riscv.th.vlseg2e.nxv2i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
vint64m2x2_t test_th_vlseg2e64_v_i64m2x2(const int64_t *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_i64m2x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i64>, <vscale x 4 x i64> } @test_th_vlseg2e64_v_i64m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i64>, <vscale x 4 x i64> } @llvm.riscv.th.vlseg2e.nxv4i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP0]]
//
vint64m4x2_t test_th_vlseg2e64_v_i64m4x2(const int64_t *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_i64m4x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 1 x i64>, <vscale x 1 x i64> } @test_th_vlseg2e64_v_u64m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 1 x i64>, <vscale x 1 x i64> } @llvm.riscv.th.vlseg2e.nxv1i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP0]]
//
vuint64m1x2_t test_th_vlseg2e64_v_u64m1x2(const uint64_t *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_u64m1x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x i64>, <vscale x 2 x i64> } @test_th_vlseg2e64_v_u64m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i64>, <vscale x 2 x i64> } @llvm.riscv.th.vlseg2e.nxv2i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]]
//
vuint64m2x2_t test_th_vlseg2e64_v_u64m2x2(const uint64_t *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_u64m2x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i64>, <vscale x 4 x i64> } @test_th_vlseg2e64_v_u64m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i64>, <vscale x 4 x i64> } @llvm.riscv.th.vlseg2e.nxv4i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP0]]
//
vuint64m4x2_t test_th_vlseg2e64_v_u64m4x2(const uint64_t *base, size_t vl) {
  return __riscv_th_vlseg2e64_v_u64m4x2(base, vl);
}
