// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> } @test_th_vlseg8e16_v_f16m1x8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> } @llvm.riscv.th.vlseg8e.nxv4f16.i64(<vscale x 4 x half> poison, <vscale x 4 x half> poison, <vscale x 4 x half> poison, <vscale x 4 x half> poison, <vscale x 4 x half> poison, <vscale x 4 x half> poison, <vscale x 4 x half> poison, <vscale x 4 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> } [[TMP0]]
//
vfloat16m1x8_t test_th_vlseg8e16_v_f16m1x8(const _Float16 *base, size_t vl) {
  return __riscv_th_vlseg8e16_v_f16m1x8(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> } @test_th_vlseg8e16_v_i16m1x8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> } @llvm.riscv.th.vlseg8e.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> } [[TMP0]]
//
vint16m1x8_t test_th_vlseg8e16_v_i16m1x8(const int16_t *base, size_t vl) {
  return __riscv_th_vlseg8e16_v_i16m1x8(base, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> } @test_th_vlseg8e16_v_u16m1x8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> } @llvm.riscv.th.vlseg8e.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, <vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> } [[TMP0]]
//
vuint16m1x8_t test_th_vlseg8e16_v_u16m1x8(const uint16_t *base, size_t vl) {
  return __riscv_th_vlseg8e16_v_u16m1x8(base, vl);
}
