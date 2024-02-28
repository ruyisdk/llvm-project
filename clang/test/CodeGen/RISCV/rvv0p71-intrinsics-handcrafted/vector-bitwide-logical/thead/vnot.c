// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vnot_v_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vxor.nxv8i8.i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vnot_v_i8m1(vint8m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_i8m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vnot_v_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vxor.nxv16i8.i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vnot_v_i8m2(vint8m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_i8m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vnot_v_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vxor.nxv32i8.i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vnot_v_i8m4(vint8m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_i8m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vnot_v_i8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vxor.nxv64i8.i8.i64(<vscale x 64 x i8> poison, <vscale x 64 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vnot_v_i8m8(vint8m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_i8m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vnot_v_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vxor.nxv4i16.i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vnot_v_i16m1(vint16m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_i16m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vnot_v_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vxor.nxv8i16.i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vnot_v_i16m2(vint16m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_i16m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vnot_v_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vxor.nxv16i16.i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vnot_v_i16m4(vint16m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_i16m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vnot_v_i16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vxor.nxv32i16.i16.i64(<vscale x 32 x i16> poison, <vscale x 32 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vnot_v_i16m8(vint16m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_i16m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vnot_v_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vxor.nxv2i32.i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vnot_v_i32m1(vint32m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_i32m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vnot_v_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vxor.nxv4i32.i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vnot_v_i32m2(vint32m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_i32m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vnot_v_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vxor.nxv8i32.i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vnot_v_i32m4(vint32m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_i32m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vnot_v_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vxor.nxv16i32.i32.i64(<vscale x 16 x i32> poison, <vscale x 16 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vnot_v_i32m8(vint32m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_i32m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vnot_v_i64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vxor.nxv1i64.i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vnot_v_i64m1(vint64m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_i64m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vnot_v_i64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vxor.nxv2i64.i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vnot_v_i64m2(vint64m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_i64m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vnot_v_i64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vxor.nxv4i64.i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vnot_v_i64m4(vint64m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_i64m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vnot_v_i64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vxor.nxv8i64.i64.i64(<vscale x 8 x i64> poison, <vscale x 8 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vnot_v_i64m8(vint64m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_i64m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vnot_v_u8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vxor.nxv8i8.i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vnot_v_u8m1(vuint8m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_u8m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vnot_v_u8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vxor.nxv16i8.i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vnot_v_u8m2(vuint8m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_u8m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vnot_v_u8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vxor.nxv32i8.i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vnot_v_u8m4(vuint8m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_u8m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vnot_v_u8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vxor.nxv64i8.i8.i64(<vscale x 64 x i8> poison, <vscale x 64 x i8> [[OP1]], i8 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vnot_v_u8m8(vuint8m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_u8m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vnot_v_u16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vxor.nxv4i16.i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vnot_v_u16m1(vuint16m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_u16m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vnot_v_u16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vxor.nxv8i16.i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vnot_v_u16m2(vuint16m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_u16m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vnot_v_u16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vxor.nxv16i16.i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vnot_v_u16m4(vuint16m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_u16m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vnot_v_u16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vxor.nxv32i16.i16.i64(<vscale x 32 x i16> poison, <vscale x 32 x i16> [[OP1]], i16 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vnot_v_u16m8(vuint16m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_u16m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vnot_v_u32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vxor.nxv2i32.i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vnot_v_u32m1(vuint32m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_u32m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vnot_v_u32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vxor.nxv4i32.i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vnot_v_u32m2(vuint32m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_u32m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vnot_v_u32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vxor.nxv8i32.i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vnot_v_u32m4(vuint32m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_u32m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vnot_v_u32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vxor.nxv16i32.i32.i64(<vscale x 16 x i32> poison, <vscale x 16 x i32> [[OP1]], i32 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vnot_v_u32m8(vuint32m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_u32m8(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vnot_v_u64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vxor.nxv1i64.i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vnot_v_u64m1(vuint64m1_t op1, size_t vl) {
  return __riscv_th_vnot_v_u64m1(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vnot_v_u64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vxor.nxv2i64.i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vnot_v_u64m2(vuint64m2_t op1, size_t vl) {
  return __riscv_th_vnot_v_u64m2(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vnot_v_u64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vxor.nxv4i64.i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vnot_v_u64m4(vuint64m4_t op1, size_t vl) {
  return __riscv_th_vnot_v_u64m4(op1, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vnot_v_u64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vxor.nxv8i64.i64.i64(<vscale x 8 x i64> poison, <vscale x 8 x i64> [[OP1]], i64 -1, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vnot_v_u64m8(vuint64m8_t op1, size_t vl) {
  return __riscv_th_vnot_v_u64m8(op1, vl);
}
