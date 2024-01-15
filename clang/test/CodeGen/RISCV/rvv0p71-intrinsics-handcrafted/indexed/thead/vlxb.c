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
  return __riscv_th_vlxb_v_i8m1(base, index, vl);
}
