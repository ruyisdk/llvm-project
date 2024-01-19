// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x half>, <vscale x 4 x half> } @test_th_vlseg2e16_v_f16m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x half>, <vscale x 4 x half> } @llvm.riscv.th.vlseg2e.nxv4f16.i64(<vscale x 4 x half> poison, <vscale x 4 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x half>, <vscale x 4 x half> } [[TMP0]]
//
vfloat16m1x2_t test_th_vlseg2e16_v_f16m1x2(const _Float16 *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_f16m1x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x half>, <vscale x 8 x half> } @test_th_vlseg2e16_v_f16m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x half>, <vscale x 8 x half> } @llvm.riscv.th.vlseg2e.nxv8f16.i64(<vscale x 8 x half> poison, <vscale x 8 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 8 x half>, <vscale x 8 x half> } [[TMP0]]
//
vfloat16m2x2_t test_th_vlseg2e16_v_f16m2x2(const _Float16 *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_f16m2x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x half>, <vscale x 16 x half> } @test_th_vlseg2e16_v_f16m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x half>, <vscale x 16 x half> } @llvm.riscv.th.vlseg2e.nxv16f16.i64(<vscale x 16 x half> poison, <vscale x 16 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 16 x half>, <vscale x 16 x half> } [[TMP0]]
//
vfloat16m4x2_t test_th_vlseg2e16_v_f16m4x2(const _Float16 *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_f16m4x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i16>, <vscale x 4 x i16> } @test_th_vlseg2e16_v_i16m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i16>, <vscale x 4 x i16> } @llvm.riscv.th.vlseg2e.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i16>, <vscale x 4 x i16> } [[TMP0]]
//
vint16m1x2_t test_th_vlseg2e16_v_i16m1x2(const int16_t *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_i16m1x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x i16>, <vscale x 8 x i16> } @test_th_vlseg2e16_v_i16m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.riscv.th.vlseg2e.nxv8i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
vint16m2x2_t test_th_vlseg2e16_v_i16m2x2(const int16_t *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_i16m2x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x i16>, <vscale x 16 x i16> } @test_th_vlseg2e16_v_i16m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i16>, <vscale x 16 x i16> } @llvm.riscv.th.vlseg2e.nxv16i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 16 x i16>, <vscale x 16 x i16> } [[TMP0]]
//
vint16m4x2_t test_th_vlseg2e16_v_i16m4x2(const int16_t *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_i16m4x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i16>, <vscale x 4 x i16> } @test_th_vlseg2e16_v_u16m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i16>, <vscale x 4 x i16> } @llvm.riscv.th.vlseg2e.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i16>, <vscale x 4 x i16> } [[TMP0]]
//
vuint16m1x2_t test_th_vlseg2e16_v_u16m1x2(const uint16_t *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_u16m1x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x i16>, <vscale x 8 x i16> } @test_th_vlseg2e16_v_u16m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i16>, <vscale x 8 x i16> } @llvm.riscv.th.vlseg2e.nxv8i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 8 x i16>, <vscale x 8 x i16> } [[TMP0]]
//
vuint16m2x2_t test_th_vlseg2e16_v_u16m2x2(const uint16_t *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_u16m2x2(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x i16>, <vscale x 16 x i16> } @test_th_vlseg2e16_v_u16m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i16>, <vscale x 16 x i16> } @llvm.riscv.th.vlseg2e.nxv16i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 16 x i16>, <vscale x 16 x i16> } [[TMP0]]
//
vuint16m4x2_t test_th_vlseg2e16_v_u16m4x2(const uint16_t *base, size_t vl) {
  return __riscv_th_vlseg2e16_v_u16m4x2(base, vl);
}
