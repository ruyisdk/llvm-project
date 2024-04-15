// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i8m1_b8
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[OP1:%.*]], <vscale x 8 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[OP1]], <vscale x 8 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i8m1_b8(vint8m1_t op1, vint8m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m1_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i8m1_b8
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i8.i8.i64(<vscale x 8 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i8m1_b8(vint8m1_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m1_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vv_i8m2_b4
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[OP1]], <vscale x 16 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vv_i8m2_b4(vint8m2_t op1, vint8m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m2_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vx_i8m2_b4
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.nxv16i8.i8.i64(<vscale x 16 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vx_i8m2_b4(vint8m2_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m2_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vv_i8m4_b2
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[OP1:%.*]], <vscale x 32 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[OP1]], <vscale x 32 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vv_i8m4_b2(vint8m4_t op1, vint8m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m4_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vx_i8m4_b2
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.nxv32i8.i8.i64(<vscale x 32 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vx_i8m4_b2(vint8m4_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m4_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsge_vv_i8m8_b1
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[OP1:%.*]], <vscale x 64 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmsge.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[OP1]], <vscale x 64 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsge_vv_i8m8_b1(vint8m8_t op1, vint8m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m8_b1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsge_vx_i8m8_b1
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmsge.nxv64i8.i8.i64(<vscale x 64 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsge_vx_i8m8_b1(vint8m8_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m8_b1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vv_i16m1_b16
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[OP1:%.*]], <vscale x 4 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[OP1]], <vscale x 4 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vv_i16m1_b16(vint16m1_t op1, vint16m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m1_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vx_i16m1_b16
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.nxv4i16.i16.i64(<vscale x 4 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vx_i16m1_b16(vint16m1_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m1_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i16m2_b8
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[OP1]], <vscale x 8 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i16m2_b8(vint16m2_t op1, vint16m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m2_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i16m2_b8
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i16.i16.i64(<vscale x 8 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i16m2_b8(vint16m2_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m2_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vv_i16m4_b4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[OP1]], <vscale x 16 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vv_i16m4_b4(vint16m4_t op1, vint16m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m4_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vx_i16m4_b4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.nxv16i16.i16.i64(<vscale x 16 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vx_i16m4_b4(vint16m4_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m4_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vv_i16m8_b2
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[OP1]], <vscale x 32 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vv_i16m8_b2(vint16m8_t op1, vint16m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m8_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vx_i16m8_b2
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.nxv32i16.i16.i64(<vscale x 32 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vx_i16m8_b2(vint16m8_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m8_b2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vv_i32m1_b32
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[OP1:%.*]], <vscale x 2 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[OP1]], <vscale x 2 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vv_i32m1_b32(vint32m1_t op1, vint32m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m1_b32(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vx_i32m1_b32
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.nxv2i32.i32.i64(<vscale x 2 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vx_i32m1_b32(vint32m1_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m1_b32(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vv_i32m2_b16
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[OP1]], <vscale x 4 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vv_i32m2_b16(vint32m2_t op1, vint32m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m2_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vx_i32m2_b16
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.nxv4i32.i32.i64(<vscale x 4 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vx_i32m2_b16(vint32m2_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m2_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i32m4_b8
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[OP1]], <vscale x 8 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i32m4_b8(vint32m4_t op1, vint32m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m4_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i32m4_b8
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i32.i32.i64(<vscale x 8 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i32m4_b8(vint32m4_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m4_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vv_i32m8_b4
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[OP1]], <vscale x 16 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vv_i32m8_b4(vint32m8_t op1, vint32m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m8_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vx_i32m8_b4
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.nxv16i32.i32.i64(<vscale x 16 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vx_i32m8_b4(vint32m8_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m8_b4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsge_vv_i64m1_b64
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.th.vmsge.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[OP1]], <vscale x 1 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsge_vv_i64m1_b64(vint64m1_t op1, vint64m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m1_b64(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsge_vx_i64m1_b64
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.th.vmsge.nxv1i64.i64.i64(<vscale x 1 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsge_vx_i64m1_b64(vint64m1_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m1_b64(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vv_i64m2_b32
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[OP1]], <vscale x 2 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vv_i64m2_b32(vint64m2_t op1, vint64m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m2_b32(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vx_i64m2_b32
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.nxv2i64.i64.i64(<vscale x 2 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vx_i64m2_b32(vint64m2_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m2_b32(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vv_i64m4_b16
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[OP1]], <vscale x 4 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vv_i64m4_b16(vint64m4_t op1, vint64m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m4_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vx_i64m4_b16
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.nxv4i64.i64.i64(<vscale x 4 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vx_i64m4_b16(vint64m4_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m4_b16(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i64m8_b8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[OP1]], <vscale x 8 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i64m8_b8(vint64m8_t op1, vint64m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m8_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i64m8_b8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.nxv8i64.i64.i64(<vscale x 8 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i64m8_b8(vint64m8_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m8_b8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i8m1_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[OP1:%.*]], <vscale x 8 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i8.nxv8i8.i64(<vscale x 8 x i1> poison, <vscale x 8 x i8> [[OP1]], <vscale x 8 x i8> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i8m1_b8_m(vbool8_t mask, vint8m1_t op1, vint8m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m1_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i8m1_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i8.i8.i64(<vscale x 8 x i1> poison, <vscale x 8 x i8> [[OP1]], i8 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i8m1_b8_m(vbool8_t mask, vint8m1_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m1_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vv_i8m2_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.mask.nxv16i8.nxv16i8.i64(<vscale x 16 x i1> poison, <vscale x 16 x i8> [[OP1]], <vscale x 16 x i8> [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vv_i8m2_b4_m(vbool4_t mask, vint8m2_t op1, vint8m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m2_b4_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vx_i8m2_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.mask.nxv16i8.i8.i64(<vscale x 16 x i1> poison, <vscale x 16 x i8> [[OP1]], i8 [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vx_i8m2_b4_m(vbool4_t mask, vint8m2_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m2_b4_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vv_i8m4_b2_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[OP1:%.*]], <vscale x 32 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.mask.nxv32i8.nxv32i8.i64(<vscale x 32 x i1> poison, <vscale x 32 x i8> [[OP1]], <vscale x 32 x i8> [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vv_i8m4_b2_m(vbool2_t mask, vint8m4_t op1, vint8m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m4_b2_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vx_i8m4_b2_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.mask.nxv32i8.i8.i64(<vscale x 32 x i1> poison, <vscale x 32 x i8> [[OP1]], i8 [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vx_i8m4_b2_m(vbool2_t mask, vint8m4_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m4_b2_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsge_vv_i8m8_b1_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[OP1:%.*]], <vscale x 64 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmsge.mask.nxv64i8.nxv64i8.i64(<vscale x 64 x i1> poison, <vscale x 64 x i8> [[OP1]], <vscale x 64 x i8> [[OP2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsge_vv_i8m8_b1_m(vbool1_t mask, vint8m8_t op1, vint8m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i8m8_b1_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i1> @test_vmsge_vx_i8m8_b1_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i1> @llvm.riscv.th.vmsge.mask.nxv64i8.i8.i64(<vscale x 64 x i1> poison, <vscale x 64 x i8> [[OP1]], i8 [[OP2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i1> [[TMP0]]
//
vbool1_t test_vmsge_vx_i8m8_b1_m(vbool1_t mask, vint8m8_t op1, int8_t op2, size_t vl) {
  return __riscv_vmsge_vx_i8m8_b1_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vv_i16m1_b16_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[OP1:%.*]], <vscale x 4 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.mask.nxv4i16.nxv4i16.i64(<vscale x 4 x i1> poison, <vscale x 4 x i16> [[OP1]], <vscale x 4 x i16> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vv_i16m1_b16_m(vbool16_t mask, vint16m1_t op1, vint16m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m1_b16_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vx_i16m1_b16_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.mask.nxv4i16.i16.i64(<vscale x 4 x i1> poison, <vscale x 4 x i16> [[OP1]], i16 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vx_i16m1_b16_m(vbool16_t mask, vint16m1_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m1_b16_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i16m2_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i16.nxv8i16.i64(<vscale x 8 x i1> poison, <vscale x 8 x i16> [[OP1]], <vscale x 8 x i16> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i16m2_b8_m(vbool8_t mask, vint16m2_t op1, vint16m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m2_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i16m2_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i16.i16.i64(<vscale x 8 x i1> poison, <vscale x 8 x i16> [[OP1]], i16 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i16m2_b8_m(vbool8_t mask, vint16m2_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m2_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vv_i16m4_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.mask.nxv16i16.nxv16i16.i64(<vscale x 16 x i1> poison, <vscale x 16 x i16> [[OP1]], <vscale x 16 x i16> [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vv_i16m4_b4_m(vbool4_t mask, vint16m4_t op1, vint16m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m4_b4_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vx_i16m4_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.mask.nxv16i16.i16.i64(<vscale x 16 x i1> poison, <vscale x 16 x i16> [[OP1]], i16 [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vx_i16m4_b4_m(vbool4_t mask, vint16m4_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m4_b4_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vv_i16m8_b2_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.mask.nxv32i16.nxv32i16.i64(<vscale x 32 x i1> poison, <vscale x 32 x i16> [[OP1]], <vscale x 32 x i16> [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vv_i16m8_b2_m(vbool2_t mask, vint16m8_t op1, vint16m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i16m8_b2_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i1> @test_vmsge_vx_i16m8_b2_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i1> @llvm.riscv.th.vmsge.mask.nxv32i16.i16.i64(<vscale x 32 x i1> poison, <vscale x 32 x i16> [[OP1]], i16 [[OP2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i1> [[TMP0]]
//
vbool2_t test_vmsge_vx_i16m8_b2_m(vbool2_t mask, vint16m8_t op1, int16_t op2, size_t vl) {
  return __riscv_vmsge_vx_i16m8_b2_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vv_i32m1_b32_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[OP1:%.*]], <vscale x 2 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.mask.nxv2i32.nxv2i32.i64(<vscale x 2 x i1> poison, <vscale x 2 x i32> [[OP1]], <vscale x 2 x i32> [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vv_i32m1_b32_m(vbool32_t mask, vint32m1_t op1, vint32m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m1_b32_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vx_i32m1_b32_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.mask.nxv2i32.i32.i64(<vscale x 2 x i1> poison, <vscale x 2 x i32> [[OP1]], i32 [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vx_i32m1_b32_m(vbool32_t mask, vint32m1_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m1_b32_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vv_i32m2_b16_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.mask.nxv4i32.nxv4i32.i64(<vscale x 4 x i1> poison, <vscale x 4 x i32> [[OP1]], <vscale x 4 x i32> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vv_i32m2_b16_m(vbool16_t mask, vint32m2_t op1, vint32m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m2_b16_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vx_i32m2_b16_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.mask.nxv4i32.i32.i64(<vscale x 4 x i1> poison, <vscale x 4 x i32> [[OP1]], i32 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vx_i32m2_b16_m(vbool16_t mask, vint32m2_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m2_b16_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i32m4_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i32.nxv8i32.i64(<vscale x 8 x i1> poison, <vscale x 8 x i32> [[OP1]], <vscale x 8 x i32> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i32m4_b8_m(vbool8_t mask, vint32m4_t op1, vint32m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m4_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i32m4_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i32.i32.i64(<vscale x 8 x i1> poison, <vscale x 8 x i32> [[OP1]], i32 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i32m4_b8_m(vbool8_t mask, vint32m4_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m4_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vv_i32m8_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.mask.nxv16i32.nxv16i32.i64(<vscale x 16 x i1> poison, <vscale x 16 x i32> [[OP1]], <vscale x 16 x i32> [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vv_i32m8_b4_m(vbool4_t mask, vint32m8_t op1, vint32m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i32m8_b4_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i1> @test_vmsge_vx_i32m8_b4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i1> @llvm.riscv.th.vmsge.mask.nxv16i32.i32.i64(<vscale x 16 x i1> poison, <vscale x 16 x i32> [[OP1]], i32 [[OP2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i1> [[TMP0]]
//
vbool4_t test_vmsge_vx_i32m8_b4_m(vbool4_t mask, vint32m8_t op1, int32_t op2, size_t vl) {
  return __riscv_vmsge_vx_i32m8_b4_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsge_vv_i64m1_b64_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.th.vmsge.mask.nxv1i64.nxv1i64.i64(<vscale x 1 x i1> poison, <vscale x 1 x i64> [[OP1]], <vscale x 1 x i64> [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsge_vv_i64m1_b64_m(vbool64_t mask, vint64m1_t op1, vint64m1_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m1_b64_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i1> @test_vmsge_vx_i64m1_b64_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i1> @llvm.riscv.th.vmsge.mask.nxv1i64.i64.i64(<vscale x 1 x i1> poison, <vscale x 1 x i64> [[OP1]], i64 [[OP2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i1> [[TMP0]]
//
vbool64_t test_vmsge_vx_i64m1_b64_m(vbool64_t mask, vint64m1_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m1_b64_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vv_i64m2_b32_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.mask.nxv2i64.nxv2i64.i64(<vscale x 2 x i1> poison, <vscale x 2 x i64> [[OP1]], <vscale x 2 x i64> [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vv_i64m2_b32_m(vbool32_t mask, vint64m2_t op1, vint64m2_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m2_b32_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i1> @test_vmsge_vx_i64m2_b32_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i1> @llvm.riscv.th.vmsge.mask.nxv2i64.i64.i64(<vscale x 2 x i1> poison, <vscale x 2 x i64> [[OP1]], i64 [[OP2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i1> [[TMP0]]
//
vbool32_t test_vmsge_vx_i64m2_b32_m(vbool32_t mask, vint64m2_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m2_b32_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vv_i64m4_b16_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.mask.nxv4i64.nxv4i64.i64(<vscale x 4 x i1> poison, <vscale x 4 x i64> [[OP1]], <vscale x 4 x i64> [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vv_i64m4_b16_m(vbool16_t mask, vint64m4_t op1, vint64m4_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m4_b16_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i1> @test_vmsge_vx_i64m4_b16_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i1> @llvm.riscv.th.vmsge.mask.nxv4i64.i64.i64(<vscale x 4 x i1> poison, <vscale x 4 x i64> [[OP1]], i64 [[OP2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i1> [[TMP0]]
//
vbool16_t test_vmsge_vx_i64m4_b16_m(vbool16_t mask, vint64m4_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m4_b16_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vv_i64m8_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i64.nxv8i64.i64(<vscale x 8 x i1> poison, <vscale x 8 x i64> [[OP1]], <vscale x 8 x i64> [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vv_i64m8_b8_m(vbool8_t mask, vint64m8_t op1, vint64m8_t op2, size_t vl) {
  return __riscv_vmsge_vv_i64m8_b8_m(mask, op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i1> @test_vmsge_vx_i64m8_b8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i1> @llvm.riscv.th.vmsge.mask.nxv8i64.i64.i64(<vscale x 8 x i1> poison, <vscale x 8 x i64> [[OP1]], i64 [[OP2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i1> [[TMP0]]
//
vbool8_t test_vmsge_vx_i64m8_b8_m(vbool8_t mask, vint64m8_t op1, int64_t op2, size_t vl) {
  return __riscv_vmsge_vx_i64m8_b8_m(mask, op1, op2, vl);
}

