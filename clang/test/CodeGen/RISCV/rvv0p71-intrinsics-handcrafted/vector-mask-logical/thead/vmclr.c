// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmclr_m_b1
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmclr.nxv64i1.i64(i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmclr_m_b1(size_t vl) {
  return __riscv_th_vmclr_m_b1(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmclr_m_b2
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmclr.nxv32i1.i64(i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmclr_m_b2(size_t vl) {
  return __riscv_th_vmclr_m_b2(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmclr_m_b4
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmclr.nxv16i1.i64(i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmclr_m_b4(size_t vl) {
  return __riscv_th_vmclr_m_b4(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmclr_m_b8
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmclr.nxv8i1.i64(i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmclr_m_b8(size_t vl) {
  return __riscv_th_vmclr_m_b8(vl);
}
