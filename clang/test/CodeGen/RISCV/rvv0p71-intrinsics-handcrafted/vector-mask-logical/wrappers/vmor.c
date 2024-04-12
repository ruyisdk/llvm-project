// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmor_mm_b1
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[OP1:%.*]], <vscale x 64 x i1> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmor.nxv64i1.i64(<vscale x 64 x i1> [[OP1]], <vscale x 64 x i1> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmor_mm_b1(vbool1_t op1, vbool1_t op2, size_t vl) {
  return __riscv_vmor_mm_b1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmor_mm_b2
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[OP1:%.*]], <vscale x 32 x i1> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmor.nxv32i1.i64(<vscale x 32 x i1> [[OP1]], <vscale x 32 x i1> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmor_mm_b2(vbool2_t op1, vbool2_t op2, size_t vl) {
  return __riscv_vmor_mm_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmor_mm_b4
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[OP1:%.*]], <vscale x 16 x i1> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmor.nxv16i1.i64(<vscale x 16 x i1> [[OP1]], <vscale x 16 x i1> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmor_mm_b4(vbool4_t op1, vbool4_t op2, size_t vl) {
  return __riscv_vmor_mm_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmor_mm_b8
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[OP1:%.*]], <vscale x 8 x i1> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmor.nxv8i1.i64(<vscale x 8 x i1> [[OP1]], <vscale x 8 x i1> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmor_mm_b8(vbool8_t op1, vbool8_t op2, size_t vl) {
  return __riscv_vmor_mm_b8(op1, op2, vl);
}
