// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vsmul_vv_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[OP1:%.*]], <vscale x 8 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vsmul.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> [[OP1]], <vscale x 8 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vsmul_vv_i8m1(vint8m1_t op1, vint8m1_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i8m1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vsmul_vx_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vsmul.nxv8i8.i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vsmul_vx_i8m1(vint8m1_t op1, int8_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i8m1(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vsmul_vv_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vsmul.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> [[OP1]], <vscale x 16 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vsmul_vv_i8m2(vint8m2_t op1, vint8m2_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i8m2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vsmul_vx_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vsmul.nxv16i8.i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vsmul_vx_i8m2(vint8m2_t op1, int8_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i8m2(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vsmul_vv_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[OP1:%.*]], <vscale x 32 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vsmul.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> [[OP1]], <vscale x 32 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vsmul_vv_i8m4(vint8m4_t op1, vint8m4_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i8m4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vsmul_vx_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vsmul.nxv32i8.i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vsmul_vx_i8m4(vint8m4_t op1, int8_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i8m4(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vsmul_vv_i8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[OP1:%.*]], <vscale x 64 x i8> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vsmul.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> poison, <vscale x 64 x i8> [[OP1]], <vscale x 64 x i8> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vsmul_vv_i8m8(vint8m8_t op1, vint8m8_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i8m8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vsmul_vx_i8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[OP1:%.*]], i8 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vsmul.nxv64i8.i8.i64(<vscale x 64 x i8> poison, <vscale x 64 x i8> [[OP1]], i8 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vsmul_vx_i8m8(vint8m8_t op1, int8_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i8m8(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vsmul_vv_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[OP1:%.*]], <vscale x 4 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vsmul.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> [[OP1]], <vscale x 4 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vsmul_vv_i16m1(vint16m1_t op1, vint16m1_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i16m1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vsmul_vx_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vsmul.nxv4i16.i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vsmul_vx_i16m1(vint16m1_t op1, int16_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i16m1(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vsmul_vv_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vsmul.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> [[OP1]], <vscale x 8 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vsmul_vv_i16m2(vint16m2_t op1, vint16m2_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i16m2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vsmul_vx_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vsmul.nxv8i16.i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vsmul_vx_i16m2(vint16m2_t op1, int16_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i16m2(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vsmul_vv_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vsmul.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> [[OP1]], <vscale x 16 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vsmul_vv_i16m4(vint16m4_t op1, vint16m4_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i16m4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vsmul_vx_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vsmul.nxv16i16.i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vsmul_vx_i16m4(vint16m4_t op1, int16_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i16m4(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vsmul_vv_i16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i16> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vsmul.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> poison, <vscale x 32 x i16> [[OP1]], <vscale x 32 x i16> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vsmul_vv_i16m8(vint16m8_t op1, vint16m8_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i16m8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vsmul_vx_i16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], i16 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vsmul.nxv32i16.i16.i64(<vscale x 32 x i16> poison, <vscale x 32 x i16> [[OP1]], i16 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vsmul_vx_i16m8(vint16m8_t op1, int16_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i16m8(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vsmul_vv_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[OP1:%.*]], <vscale x 2 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vsmul.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> [[OP1]], <vscale x 2 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vsmul_vv_i32m1(vint32m1_t op1, vint32m1_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i32m1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vsmul_vx_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vsmul.nxv2i32.i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vsmul_vx_i32m1(vint32m1_t op1, int32_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i32m1(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vsmul_vv_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vsmul.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> [[OP1]], <vscale x 4 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vsmul_vv_i32m2(vint32m2_t op1, vint32m2_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i32m2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vsmul_vx_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vsmul.nxv4i32.i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vsmul_vx_i32m2(vint32m2_t op1, int32_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i32m2(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vsmul_vv_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vsmul.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i32> [[OP1]], <vscale x 8 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vsmul_vv_i32m4(vint32m4_t op1, vint32m4_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i32m4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vsmul_vx_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vsmul.nxv8i32.i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vsmul_vx_i32m4(vint32m4_t op1, int32_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i32m4(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vsmul_vv_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i32> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vsmul.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> poison, <vscale x 16 x i32> [[OP1]], <vscale x 16 x i32> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vsmul_vv_i32m8(vint32m8_t op1, vint32m8_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i32m8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vsmul_vx_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], i32 noundef signext [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vsmul.nxv16i32.i32.i64(<vscale x 16 x i32> poison, <vscale x 16 x i32> [[OP1]], i32 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vsmul_vx_i32m8(vint32m8_t op1, int32_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i32m8(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vsmul_vv_i64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[OP1:%.*]], <vscale x 1 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vsmul.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> [[OP1]], <vscale x 1 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vsmul_vv_i64m1(vint64m1_t op1, vint64m1_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i64m1(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vsmul_vx_i64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vsmul.nxv1i64.i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vsmul_vx_i64m1(vint64m1_t op1, int64_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i64m1(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vsmul_vv_i64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vsmul.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> [[OP1]], <vscale x 2 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vsmul_vv_i64m2(vint64m2_t op1, vint64m2_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i64m2(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vsmul_vx_i64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vsmul.nxv2i64.i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vsmul_vx_i64m2(vint64m2_t op1, int64_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i64m2(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vsmul_vv_i64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vsmul.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> [[OP1]], <vscale x 4 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vsmul_vv_i64m4(vint64m4_t op1, vint64m4_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i64m4(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vsmul_vx_i64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vsmul.nxv4i64.i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vsmul_vx_i64m4(vint64m4_t op1, int64_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i64m4(op1, op2, vl);
}


// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vsmul_vv_i64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i64> [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vsmul.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> poison, <vscale x 8 x i64> [[OP1]], <vscale x 8 x i64> [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vsmul_vv_i64m8(vint64m8_t op1, vint64m8_t op2, size_t vl) {
  return __riscv_th_vsmul_vv_i64m8(op1, op2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vsmul_vx_i64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[OP2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vsmul.nxv8i64.i64.i64(<vscale x 8 x i64> poison, <vscale x 8 x i64> [[OP1]], i64 [[OP2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vsmul_vx_i64m8(vint64m8_t op1, int64_t op2, size_t vl) {
  return __riscv_th_vsmul_vx_i64m8(op1, op2, vl);
}

