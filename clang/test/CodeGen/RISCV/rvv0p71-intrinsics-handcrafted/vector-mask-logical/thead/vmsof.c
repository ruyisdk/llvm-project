// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsof_m_b1
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmsof.nxv64i1.i64(<vscale x 64 x i1> [[OP1]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsof_m_b1(vbool1_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsof_m_b2
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsof.nxv32i1.i64(<vscale x 32 x i1> [[OP1]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsof_m_b2(vbool2_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsof_m_b4
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsof.nxv16i1.i64(<vscale x 16 x i1> [[OP1]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsof_m_b4(vbool4_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsof_m_b8
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsof.nxv8i1.i64(<vscale x 8 x i1> [[OP1]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsof_m_b8(vbool8_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsof_m_b1_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmsof.mask.nxv64i1.i64(<vscale x 64 x i1> poison, <vscale x 64 x i1> [[OP1]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsof_m_b1_m(vbool1_t mask, vbool1_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b1_m(mask, op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsof_m_b2_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsof.mask.nxv32i1.i64(<vscale x 32 x i1> poison, <vscale x 32 x i1> [[OP1]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsof_m_b2_m(vbool2_t mask, vbool2_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b2_m(mask, op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsof_m_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsof.mask.nxv16i1.i64(<vscale x 16 x i1> poison, <vscale x 16 x i1> [[OP1]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsof_m_b4_m(vbool4_t mask, vbool4_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b4_m(mask, op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsof_m_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i1> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsof.mask.nxv8i1.i64(<vscale x 8 x i1> poison, <vscale x 8 x i1> [[OP1]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsof_m_b8_m(vbool8_t mask, vbool8_t op1, size_t vl) {
  return __riscv_th_vmsof_m_b8_m(mask, op1, vl);
}
