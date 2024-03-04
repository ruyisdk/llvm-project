// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vnsra_wv_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i8> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vnsra.nxv8i8.nxv8i16.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i16> [[OP1]], <vscale x 8 x i8> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vnsra_wv_i8m1(vint16m2_t op1, vuint8m1_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i8m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vnsra_wx_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vnsra.nxv8i8.nxv8i16.i64.i64(<vscale x 8 x i8> poison, <vscale x 8 x i16> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vnsra_wx_i8m1(vint16m2_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i8m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vnsra_wv_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], <vscale x 16 x i8> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vnsra.nxv16i8.nxv16i16.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i16> [[OP1]], <vscale x 16 x i8> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vnsra_wv_i8m2(vint16m4_t op1, vuint8m2_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i8m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vnsra_wx_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vnsra.nxv16i8.nxv16i16.i64.i64(<vscale x 16 x i8> poison, <vscale x 16 x i16> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vnsra_wx_i8m2(vint16m4_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i8m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vnsra_wv_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], <vscale x 32 x i8> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vnsra.nxv32i8.nxv32i16.nxv32i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i16> [[OP1]], <vscale x 32 x i8> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vnsra_wv_i8m4(vint16m8_t op1, vuint8m4_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i8m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vnsra_wx_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vnsra.nxv32i8.nxv32i16.i64.i64(<vscale x 32 x i8> poison, <vscale x 32 x i16> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vnsra_wx_i8m4(vint16m8_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i8m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vnsra_wv_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i16> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vnsra.nxv4i16.nxv4i32.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i32> [[OP1]], <vscale x 4 x i16> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vnsra_wv_i16m1(vint32m2_t op1, vuint16m1_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i16m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vnsra_wx_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vnsra.nxv4i16.nxv4i32.i64.i64(<vscale x 4 x i16> poison, <vscale x 4 x i32> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vnsra_wx_i16m1(vint32m2_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i16m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vnsra_wv_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], <vscale x 8 x i16> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vnsra.nxv8i16.nxv8i32.nxv8i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i32> [[OP1]], <vscale x 8 x i16> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vnsra_wv_i16m2(vint32m4_t op1, vuint16m2_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i16m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vnsra_wx_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vnsra.nxv8i16.nxv8i32.i64.i64(<vscale x 8 x i16> poison, <vscale x 8 x i32> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vnsra_wx_i16m2(vint32m4_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i16m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vnsra_wv_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], <vscale x 16 x i16> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vnsra.nxv16i16.nxv16i32.nxv16i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i32> [[OP1]], <vscale x 16 x i16> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vnsra_wv_i16m4(vint32m8_t op1, vuint16m4_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i16m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vnsra_wx_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vnsra.nxv16i16.nxv16i32.i64.i64(<vscale x 16 x i16> poison, <vscale x 16 x i32> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vnsra_wx_i16m4(vint32m8_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i16m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vnsra_wv_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i32> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vnsra.nxv2i32.nxv2i64.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i64> [[OP1]], <vscale x 2 x i32> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vnsra_wv_i32m1(vint64m2_t op1, vuint32m1_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i32m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vnsra_wx_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vnsra.nxv2i32.nxv2i64.i64.i64(<vscale x 2 x i32> poison, <vscale x 2 x i64> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vnsra_wx_i32m1(vint64m2_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i32m1(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vnsra_wv_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], <vscale x 4 x i32> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vnsra.nxv4i32.nxv4i64.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i64> [[OP1]], <vscale x 4 x i32> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vnsra_wv_i32m2(vint64m4_t op1, vuint32m2_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i32m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vnsra_wx_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vnsra.nxv4i32.nxv4i64.i64.i64(<vscale x 4 x i32> poison, <vscale x 4 x i64> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vnsra_wx_i32m2(vint64m4_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i32m2(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vnsra_wv_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], <vscale x 8 x i32> [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vnsra.nxv8i32.nxv8i64.nxv8i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i64> [[OP1]], <vscale x 8 x i32> [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vnsra_wv_i32m4(vint64m8_t op1, vuint32m4_t shift, size_t vl) {
  return __riscv_th_vnsra_wv_i32m4(op1, shift, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vnsra_wx_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[OP1:%.*]], i64 noundef [[SHIFT:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vnsra.nxv8i32.nxv8i64.i64.i64(<vscale x 8 x i32> poison, <vscale x 8 x i64> [[OP1]], i64 [[SHIFT]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vnsra_wx_i32m4(vint64m8_t op1, size_t shift, size_t vl) {
  return __riscv_th_vnsra_wx_i32m4(op1, shift, vl);
}
