// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vv_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vmacc_vv_i8m1(vint8m1_t vd, vint8m1_t vs1, vint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vx_i8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.nxv8i8.i8.i64(<vscale x 8 x i8> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vmacc_vx_i8m1(vint8m1_t vd, int8_t rs1, vint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vv_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[VD:%.*]], <vscale x 16 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VD]], <vscale x 16 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vmacc_vv_i8m2(vint8m2_t vd, vint8m2_t vs1, vint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vx_i8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.nxv16i8.i8.i64(<vscale x 16 x i8> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vmacc_vx_i8m2(vint8m2_t vd, int8_t rs1, vint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vv_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[VD:%.*]], <vscale x 32 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VD]], <vscale x 32 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vmacc_vv_i8m4(vint8m4_t vd, vint8m4_t vs1, vint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vx_i8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.nxv32i8.i8.i64(<vscale x 32 x i8> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vmacc_vx_i8m4(vint8m4_t vd, int8_t rs1, vint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vv_i8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[VD:%.*]], <vscale x 64 x i8> [[VS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VD]], <vscale x 64 x i8> [[VS1]], <vscale x 64 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vmacc_vv_i8m8(vint8m8_t vd, vint8m8_t vs1, vint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vx_i8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.nxv64i8.i8.i64(<vscale x 64 x i8> [[VD]], i8 [[RS1]], <vscale x 64 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vmacc_vx_i8m8(vint8m8_t vd, int8_t rs1, vint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vv_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[VD:%.*]], <vscale x 4 x i16> [[VS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VD]], <vscale x 4 x i16> [[VS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vmacc_vv_i16m1(vint16m1_t vd, vint16m1_t vs1, vint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vx_i16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.nxv4i16.i16.i64(<vscale x 4 x i16> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vmacc_vx_i16m1(vint16m1_t vd, int16_t rs1, vint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vv_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], <vscale x 8 x i16> [[VS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VD]], <vscale x 8 x i16> [[VS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vmacc_vv_i16m2(vint16m2_t vd, vint16m2_t vs1, vint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vx_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.nxv8i16.i16.i64(<vscale x 8 x i16> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vmacc_vx_i16m2(vint16m2_t vd, int16_t rs1, vint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vv_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], <vscale x 16 x i16> [[VS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VD]], <vscale x 16 x i16> [[VS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vmacc_vv_i16m4(vint16m4_t vd, vint16m4_t vs1, vint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vx_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.nxv16i16.i16.i64(<vscale x 16 x i16> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vmacc_vx_i16m4(vint16m4_t vd, int16_t rs1, vint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vv_i16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], <vscale x 32 x i16> [[VS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VD]], <vscale x 32 x i16> [[VS1]], <vscale x 32 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vmacc_vv_i16m8(vint16m8_t vd, vint16m8_t vs1, vint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vx_i16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.nxv32i16.i16.i64(<vscale x 32 x i16> [[VD]], i16 [[RS1]], <vscale x 32 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vmacc_vx_i16m8(vint16m8_t vd, int16_t rs1, vint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vv_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[VD:%.*]], <vscale x 2 x i32> [[VS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VD]], <vscale x 2 x i32> [[VS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vmacc_vv_i32m1(vint32m1_t vd, vint32m1_t vs1, vint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vx_i32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.nxv2i32.i32.i64(<vscale x 2 x i32> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vmacc_vx_i32m1(vint32m1_t vd, int32_t rs1, vint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vv_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], <vscale x 4 x i32> [[VS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VD]], <vscale x 4 x i32> [[VS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vmacc_vv_i32m2(vint32m2_t vd, vint32m2_t vs1, vint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vx_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.nxv4i32.i32.i64(<vscale x 4 x i32> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vmacc_vx_i32m2(vint32m2_t vd, int32_t rs1, vint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vv_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i32> [[VS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i32> [[VS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vmacc_vv_i32m4(vint32m4_t vd, vint32m4_t vs1, vint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vx_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.nxv8i32.i32.i64(<vscale x 8 x i32> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vmacc_vx_i32m4(vint32m4_t vd, int32_t rs1, vint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vv_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], <vscale x 16 x i32> [[VS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VD]], <vscale x 16 x i32> [[VS1]], <vscale x 16 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vmacc_vv_i32m8(vint32m8_t vd, vint32m8_t vs1, vint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vx_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.nxv16i32.i32.i64(<vscale x 16 x i32> [[VD]], i32 [[RS1]], <vscale x 16 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vmacc_vx_i32m8(vint32m8_t vd, int32_t rs1, vint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vv_i64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[VD:%.*]], <vscale x 1 x i64> [[VS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VD]], <vscale x 1 x i64> [[VS1]], <vscale x 1 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vmacc_vv_i64m1(vint64m1_t vd, vint64m1_t vs1, vint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vx_i64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.nxv1i64.i64.i64(<vscale x 1 x i64> [[VD]], i64 [[RS1]], <vscale x 1 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vmacc_vx_i64m1(vint64m1_t vd, int64_t rs1, vint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vv_i64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], <vscale x 2 x i64> [[VS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VD]], <vscale x 2 x i64> [[VS1]], <vscale x 2 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vmacc_vv_i64m2(vint64m2_t vd, vint64m2_t vs1, vint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vx_i64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.nxv2i64.i64.i64(<vscale x 2 x i64> [[VD]], i64 [[RS1]], <vscale x 2 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vmacc_vx_i64m2(vint64m2_t vd, int64_t rs1, vint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vv_i64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], <vscale x 4 x i64> [[VS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VD]], <vscale x 4 x i64> [[VS1]], <vscale x 4 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vmacc_vv_i64m4(vint64m4_t vd, vint64m4_t vs1, vint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vx_i64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.nxv4i64.i64.i64(<vscale x 4 x i64> [[VD]], i64 [[RS1]], <vscale x 4 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vmacc_vx_i64m4(vint64m4_t vd, int64_t rs1, vint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vv_i64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], <vscale x 8 x i64> [[VS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VD]], <vscale x 8 x i64> [[VS1]], <vscale x 8 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vmacc_vv_i64m8(vint64m8_t vd, vint64m8_t vs1, vint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vx_i64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.nxv8i64.i64.i64(<vscale x 8 x i64> [[VD]], i64 [[RS1]], <vscale x 8 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vmacc_vx_i64m8(vint64m8_t vd, int64_t rs1, vint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vv_u8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vmacc_vv_u8m1(vuint8m1_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vx_u8m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.nxv8i8.i8.i64(<vscale x 8 x i8> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vmacc_vx_u8m1(vuint8m1_t vd, uint8_t rs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vv_u8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[VD:%.*]], <vscale x 16 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VD]], <vscale x 16 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vmacc_vv_u8m2(vuint8m2_t vd, vuint8m2_t vs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vx_u8m2
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.nxv16i8.i8.i64(<vscale x 16 x i8> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vmacc_vx_u8m2(vuint8m2_t vd, uint8_t rs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vv_u8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[VD:%.*]], <vscale x 32 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VD]], <vscale x 32 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vmacc_vv_u8m4(vuint8m4_t vd, vuint8m4_t vs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vx_u8m4
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.nxv32i8.i8.i64(<vscale x 32 x i8> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vmacc_vx_u8m4(vuint8m4_t vd, uint8_t rs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vv_u8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[VD:%.*]], <vscale x 64 x i8> [[VS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VD]], <vscale x 64 x i8> [[VS1]], <vscale x 64 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vmacc_vv_u8m8(vuint8m8_t vd, vuint8m8_t vs1, vuint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vx_u8m8
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.nxv64i8.i8.i64(<vscale x 64 x i8> [[VD]], i8 [[RS1]], <vscale x 64 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vmacc_vx_u8m8(vuint8m8_t vd, uint8_t rs1, vuint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vv_u16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[VD:%.*]], <vscale x 4 x i16> [[VS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VD]], <vscale x 4 x i16> [[VS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vmacc_vv_u16m1(vuint16m1_t vd, vuint16m1_t vs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vx_u16m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.nxv4i16.i16.i64(<vscale x 4 x i16> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vmacc_vx_u16m1(vuint16m1_t vd, uint16_t rs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vv_u16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], <vscale x 8 x i16> [[VS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VD]], <vscale x 8 x i16> [[VS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vmacc_vv_u16m2(vuint16m2_t vd, vuint16m2_t vs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vx_u16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.nxv8i16.i16.i64(<vscale x 8 x i16> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vmacc_vx_u16m2(vuint16m2_t vd, uint16_t rs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vv_u16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], <vscale x 16 x i16> [[VS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VD]], <vscale x 16 x i16> [[VS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vmacc_vv_u16m4(vuint16m4_t vd, vuint16m4_t vs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vx_u16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.nxv16i16.i16.i64(<vscale x 16 x i16> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vmacc_vx_u16m4(vuint16m4_t vd, uint16_t rs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vv_u16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], <vscale x 32 x i16> [[VS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VD]], <vscale x 32 x i16> [[VS1]], <vscale x 32 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vmacc_vv_u16m8(vuint16m8_t vd, vuint16m8_t vs1, vuint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vx_u16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.nxv32i16.i16.i64(<vscale x 32 x i16> [[VD]], i16 [[RS1]], <vscale x 32 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vmacc_vx_u16m8(vuint16m8_t vd, uint16_t rs1, vuint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vv_u32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[VD:%.*]], <vscale x 2 x i32> [[VS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VD]], <vscale x 2 x i32> [[VS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vmacc_vv_u32m1(vuint32m1_t vd, vuint32m1_t vs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vx_u32m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.nxv2i32.i32.i64(<vscale x 2 x i32> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vmacc_vx_u32m1(vuint32m1_t vd, uint32_t rs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vv_u32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], <vscale x 4 x i32> [[VS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VD]], <vscale x 4 x i32> [[VS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vmacc_vv_u32m2(vuint32m2_t vd, vuint32m2_t vs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vx_u32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.nxv4i32.i32.i64(<vscale x 4 x i32> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vmacc_vx_u32m2(vuint32m2_t vd, uint32_t rs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vv_u32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i32> [[VS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i32> [[VS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vmacc_vv_u32m4(vuint32m4_t vd, vuint32m4_t vs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vx_u32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.nxv8i32.i32.i64(<vscale x 8 x i32> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vmacc_vx_u32m4(vuint32m4_t vd, uint32_t rs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vv_u32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], <vscale x 16 x i32> [[VS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VD]], <vscale x 16 x i32> [[VS1]], <vscale x 16 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vmacc_vv_u32m8(vuint32m8_t vd, vuint32m8_t vs1, vuint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vx_u32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.nxv16i32.i32.i64(<vscale x 16 x i32> [[VD]], i32 [[RS1]], <vscale x 16 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vmacc_vx_u32m8(vuint32m8_t vd, uint32_t rs1, vuint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vv_u64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[VD:%.*]], <vscale x 1 x i64> [[VS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VD]], <vscale x 1 x i64> [[VS1]], <vscale x 1 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vmacc_vv_u64m1(vuint64m1_t vd, vuint64m1_t vs1, vuint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m1(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vx_u64m1
// CHECK-RV64-SAME: (<vscale x 1 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.nxv1i64.i64.i64(<vscale x 1 x i64> [[VD]], i64 [[RS1]], <vscale x 1 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vmacc_vx_u64m1(vuint64m1_t vd, uint64_t rs1, vuint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m1(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vv_u64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], <vscale x 2 x i64> [[VS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VD]], <vscale x 2 x i64> [[VS1]], <vscale x 2 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vmacc_vv_u64m2(vuint64m2_t vd, vuint64m2_t vs1, vuint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vx_u64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.nxv2i64.i64.i64(<vscale x 2 x i64> [[VD]], i64 [[RS1]], <vscale x 2 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vmacc_vx_u64m2(vuint64m2_t vd, uint64_t rs1, vuint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vv_u64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], <vscale x 4 x i64> [[VS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VD]], <vscale x 4 x i64> [[VS1]], <vscale x 4 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vmacc_vv_u64m4(vuint64m4_t vd, vuint64m4_t vs1, vuint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vx_u64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.nxv4i64.i64.i64(<vscale x 4 x i64> [[VD]], i64 [[RS1]], <vscale x 4 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vmacc_vx_u64m4(vuint64m4_t vd, uint64_t rs1, vuint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vv_u64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], <vscale x 8 x i64> [[VS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VD]], <vscale x 8 x i64> [[VS1]], <vscale x 8 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vmacc_vv_u64m8(vuint64m8_t vd, vuint64m8_t vs1, vuint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vx_u64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.nxv8i64.i64.i64(<vscale x 8 x i64> [[VD]], i64 [[RS1]], <vscale x 8 x i64> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vmacc_vx_u64m8(vuint64m8_t vd, uint64_t rs1, vuint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vv_i8m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.mask.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vmacc_vv_i8m1_m(vbool8_t mask, vint8m1_t vd, vint8m1_t vs1, vint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vx_i8m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.mask.nxv8i8.i8.i64(<vscale x 8 x i8> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vint8m1_t test_vmacc_vx_i8m1_m(vbool8_t mask, vint8m1_t vd, int8_t rs1, vint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vv_i8m2_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[VD:%.*]], <vscale x 16 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.mask.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VD]], <vscale x 16 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vmacc_vv_i8m2_m(vbool4_t mask, vint8m2_t vd, vint8m2_t vs1, vint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vx_i8m2_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.mask.nxv16i8.i8.i64(<vscale x 16 x i8> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vint8m2_t test_vmacc_vx_i8m2_m(vbool4_t mask, vint8m2_t vd, int8_t rs1, vint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vv_i8m4_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[VD:%.*]], <vscale x 32 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.mask.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VD]], <vscale x 32 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vmacc_vv_i8m4_m(vbool2_t mask, vint8m4_t vd, vint8m4_t vs1, vint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vx_i8m4_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.mask.nxv32i8.i8.i64(<vscale x 32 x i8> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vint8m4_t test_vmacc_vx_i8m4_m(vbool2_t mask, vint8m4_t vd, int8_t rs1, vint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vv_i8m8_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[VD:%.*]], <vscale x 64 x i8> [[VS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.mask.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VD]], <vscale x 64 x i8> [[VS1]], <vscale x 64 x i8> [[VS2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vmacc_vv_i8m8_m(vbool1_t mask, vint8m8_t vd, vint8m8_t vs1, vint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i8m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vx_i8m8_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[VD:%.*]], i8 noundef signext [[RS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.mask.nxv64i8.i8.i64(<vscale x 64 x i8> [[VD]], i8 [[RS1]], <vscale x 64 x i8> [[VS2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vint8m8_t test_vmacc_vx_i8m8_m(vbool1_t mask, vint8m8_t vd, int8_t rs1, vint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i8m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vv_i16m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[VD:%.*]], <vscale x 4 x i16> [[VS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.mask.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VD]], <vscale x 4 x i16> [[VS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vmacc_vv_i16m1_m(vbool16_t mask, vint16m1_t vd, vint16m1_t vs1, vint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vx_i16m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.mask.nxv4i16.i16.i64(<vscale x 4 x i16> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vmacc_vx_i16m1_m(vbool16_t mask, vint16m1_t vd, int16_t rs1, vint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vv_i16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], <vscale x 8 x i16> [[VS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.mask.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VD]], <vscale x 8 x i16> [[VS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vmacc_vv_i16m2_m(vbool8_t mask, vint16m2_t vd, vint16m2_t vs1, vint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vx_i16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.mask.nxv8i16.i16.i64(<vscale x 8 x i16> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vmacc_vx_i16m2_m(vbool8_t mask, vint16m2_t vd, int16_t rs1, vint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vv_i16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], <vscale x 16 x i16> [[VS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.mask.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VD]], <vscale x 16 x i16> [[VS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vmacc_vv_i16m4_m(vbool4_t mask, vint16m4_t vd, vint16m4_t vs1, vint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vx_i16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.mask.nxv16i16.i16.i64(<vscale x 16 x i16> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vmacc_vx_i16m4_m(vbool4_t mask, vint16m4_t vd, int16_t rs1, vint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vv_i16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], <vscale x 32 x i16> [[VS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.mask.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VD]], <vscale x 32 x i16> [[VS1]], <vscale x 32 x i16> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vmacc_vv_i16m8_m(vbool2_t mask, vint16m8_t vd, vint16m8_t vs1, vint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i16m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vx_i16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], i16 noundef signext [[RS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.mask.nxv32i16.i16.i64(<vscale x 32 x i16> [[VD]], i16 [[RS1]], <vscale x 32 x i16> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vmacc_vx_i16m8_m(vbool2_t mask, vint16m8_t vd, int16_t rs1, vint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i16m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vv_i32m1_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[VD:%.*]], <vscale x 2 x i32> [[VS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.mask.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VD]], <vscale x 2 x i32> [[VS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vmacc_vv_i32m1_m(vbool32_t mask, vint32m1_t vd, vint32m1_t vs1, vint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vx_i32m1_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.mask.nxv2i32.i32.i64(<vscale x 2 x i32> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vmacc_vx_i32m1_m(vbool32_t mask, vint32m1_t vd, int32_t rs1, vint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vv_i32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], <vscale x 4 x i32> [[VS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.mask.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VD]], <vscale x 4 x i32> [[VS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vmacc_vv_i32m2_m(vbool16_t mask, vint32m2_t vd, vint32m2_t vs1, vint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vx_i32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.mask.nxv4i32.i32.i64(<vscale x 4 x i32> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vmacc_vx_i32m2_m(vbool16_t mask, vint32m2_t vd, int32_t rs1, vint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vv_i32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i32> [[VS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.mask.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i32> [[VS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vmacc_vv_i32m4_m(vbool8_t mask, vint32m4_t vd, vint32m4_t vs1, vint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vx_i32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.mask.nxv8i32.i32.i64(<vscale x 8 x i32> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vmacc_vx_i32m4_m(vbool8_t mask, vint32m4_t vd, int32_t rs1, vint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vv_i32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], <vscale x 16 x i32> [[VS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.mask.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VD]], <vscale x 16 x i32> [[VS1]], <vscale x 16 x i32> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vmacc_vv_i32m8_m(vbool4_t mask, vint32m8_t vd, vint32m8_t vs1, vint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i32m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vx_i32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.mask.nxv16i32.i32.i64(<vscale x 16 x i32> [[VD]], i32 [[RS1]], <vscale x 16 x i32> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vmacc_vx_i32m8_m(vbool4_t mask, vint32m8_t vd, int32_t rs1, vint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i32m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vv_i64m1_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i64> [[VD:%.*]], <vscale x 1 x i64> [[VS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.mask.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VD]], <vscale x 1 x i64> [[VS1]], <vscale x 1 x i64> [[VS2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vmacc_vv_i64m1_m(vbool64_t mask, vint64m1_t vd, vint64m1_t vs1, vint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vx_i64m1_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.mask.nxv1i64.i64.i64(<vscale x 1 x i64> [[VD]], i64 [[RS1]], <vscale x 1 x i64> [[VS2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vmacc_vx_i64m1_m(vbool64_t mask, vint64m1_t vd, int64_t rs1, vint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vv_i64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], <vscale x 2 x i64> [[VS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.mask.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VD]], <vscale x 2 x i64> [[VS1]], <vscale x 2 x i64> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vmacc_vv_i64m2_m(vbool32_t mask, vint64m2_t vd, vint64m2_t vs1, vint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vx_i64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.mask.nxv2i64.i64.i64(<vscale x 2 x i64> [[VD]], i64 [[RS1]], <vscale x 2 x i64> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vmacc_vx_i64m2_m(vbool32_t mask, vint64m2_t vd, int64_t rs1, vint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vv_i64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], <vscale x 4 x i64> [[VS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.mask.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VD]], <vscale x 4 x i64> [[VS1]], <vscale x 4 x i64> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vmacc_vv_i64m4_m(vbool16_t mask, vint64m4_t vd, vint64m4_t vs1, vint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vx_i64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.mask.nxv4i64.i64.i64(<vscale x 4 x i64> [[VD]], i64 [[RS1]], <vscale x 4 x i64> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vmacc_vx_i64m4_m(vbool16_t mask, vint64m4_t vd, int64_t rs1, vint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vv_i64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], <vscale x 8 x i64> [[VS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.mask.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VD]], <vscale x 8 x i64> [[VS1]], <vscale x 8 x i64> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vmacc_vv_i64m8_m(vbool8_t mask, vint64m8_t vd, vint64m8_t vs1, vint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_i64m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vx_i64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.mask.nxv8i64.i64.i64(<vscale x 8 x i64> [[VD]], i64 [[RS1]], <vscale x 8 x i64> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vmacc_vx_i64m8_m(vbool8_t mask, vint64m8_t vd, int64_t rs1, vint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_i64m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vv_u8m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.mask.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vmacc_vv_u8m1_m(vbool8_t mask, vuint8m1_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vmacc_vx_u8m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vmacc.mask.nxv8i8.i8.i64(<vscale x 8 x i8> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vmacc_vx_u8m1_m(vbool8_t mask, vuint8m1_t vd, uint8_t rs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vv_u8m2_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[VD:%.*]], <vscale x 16 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.mask.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VD]], <vscale x 16 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vmacc_vv_u8m2_m(vbool4_t mask, vuint8m2_t vd, vuint8m2_t vs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vmacc_vx_u8m2_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vmacc.mask.nxv16i8.i8.i64(<vscale x 16 x i8> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vmacc_vx_u8m2_m(vbool4_t mask, vuint8m2_t vd, uint8_t rs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vv_u8m4_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[VD:%.*]], <vscale x 32 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.mask.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VD]], <vscale x 32 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vmacc_vv_u8m4_m(vbool2_t mask, vuint8m4_t vd, vuint8m4_t vs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vmacc_vx_u8m4_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vmacc.mask.nxv32i8.i8.i64(<vscale x 32 x i8> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vmacc_vx_u8m4_m(vbool2_t mask, vuint8m4_t vd, uint8_t rs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vv_u8m8_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[VD:%.*]], <vscale x 64 x i8> [[VS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.mask.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VD]], <vscale x 64 x i8> [[VS1]], <vscale x 64 x i8> [[VS2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vmacc_vv_u8m8_m(vbool1_t mask, vuint8m8_t vd, vuint8m8_t vs1, vuint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u8m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vmacc_vx_u8m8_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 64 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vmacc.mask.nxv64i8.i8.i64(<vscale x 64 x i8> [[VD]], i8 [[RS1]], <vscale x 64 x i8> [[VS2]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vmacc_vx_u8m8_m(vbool1_t mask, vuint8m8_t vd, uint8_t rs1, vuint8m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u8m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vv_u16m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[VD:%.*]], <vscale x 4 x i16> [[VS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.mask.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VD]], <vscale x 4 x i16> [[VS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vmacc_vv_u16m1_m(vbool16_t mask, vuint16m1_t vd, vuint16m1_t vs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vmacc_vx_u16m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vmacc.mask.nxv4i16.i16.i64(<vscale x 4 x i16> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vmacc_vx_u16m1_m(vbool16_t mask, vuint16m1_t vd, uint16_t rs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vv_u16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], <vscale x 8 x i16> [[VS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.mask.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VD]], <vscale x 8 x i16> [[VS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vmacc_vv_u16m2_m(vbool8_t mask, vuint16m2_t vd, vuint16m2_t vs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vmacc_vx_u16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vmacc.mask.nxv8i16.i16.i64(<vscale x 8 x i16> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vmacc_vx_u16m2_m(vbool8_t mask, vuint16m2_t vd, uint16_t rs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vv_u16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], <vscale x 16 x i16> [[VS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.mask.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VD]], <vscale x 16 x i16> [[VS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vmacc_vv_u16m4_m(vbool4_t mask, vuint16m4_t vd, vuint16m4_t vs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vmacc_vx_u16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vmacc.mask.nxv16i16.i16.i64(<vscale x 16 x i16> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vmacc_vx_u16m4_m(vbool4_t mask, vuint16m4_t vd, uint16_t rs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vv_u16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], <vscale x 32 x i16> [[VS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.mask.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VD]], <vscale x 32 x i16> [[VS1]], <vscale x 32 x i16> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vmacc_vv_u16m8_m(vbool2_t mask, vuint16m8_t vd, vuint16m8_t vs1, vuint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u16m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vmacc_vx_u16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 32 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vmacc.mask.nxv32i16.i16.i64(<vscale x 32 x i16> [[VD]], i16 [[RS1]], <vscale x 32 x i16> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vmacc_vx_u16m8_m(vbool2_t mask, vuint16m8_t vd, uint16_t rs1, vuint16m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u16m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vv_u32m1_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[VD:%.*]], <vscale x 2 x i32> [[VS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.mask.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VD]], <vscale x 2 x i32> [[VS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vmacc_vv_u32m1_m(vbool32_t mask, vuint32m1_t vd, vuint32m1_t vs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vmacc_vx_u32m1_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vmacc.mask.nxv2i32.i32.i64(<vscale x 2 x i32> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vmacc_vx_u32m1_m(vbool32_t mask, vuint32m1_t vd, uint32_t rs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vv_u32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], <vscale x 4 x i32> [[VS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.mask.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VD]], <vscale x 4 x i32> [[VS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vmacc_vv_u32m2_m(vbool16_t mask, vuint32m2_t vd, vuint32m2_t vs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vmacc_vx_u32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vmacc.mask.nxv4i32.i32.i64(<vscale x 4 x i32> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vmacc_vx_u32m2_m(vbool16_t mask, vuint32m2_t vd, uint32_t rs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vv_u32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i32> [[VS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.mask.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i32> [[VS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vmacc_vv_u32m4_m(vbool8_t mask, vuint32m4_t vd, vuint32m4_t vs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vmacc_vx_u32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vmacc.mask.nxv8i32.i32.i64(<vscale x 8 x i32> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vmacc_vx_u32m4_m(vbool8_t mask, vuint32m4_t vd, uint32_t rs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vv_u32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], <vscale x 16 x i32> [[VS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.mask.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VD]], <vscale x 16 x i32> [[VS1]], <vscale x 16 x i32> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vmacc_vv_u32m8_m(vbool4_t mask, vuint32m8_t vd, vuint32m8_t vs1, vuint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u32m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vmacc_vx_u32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 16 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vmacc.mask.nxv16i32.i32.i64(<vscale x 16 x i32> [[VD]], i32 [[RS1]], <vscale x 16 x i32> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vmacc_vx_u32m8_m(vbool4_t mask, vuint32m8_t vd, uint32_t rs1, vuint32m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u32m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vv_u64m1_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i64> [[VD:%.*]], <vscale x 1 x i64> [[VS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.mask.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VD]], <vscale x 1 x i64> [[VS1]], <vscale x 1 x i64> [[VS2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vmacc_vv_u64m1_m(vbool64_t mask, vuint64m1_t vd, vuint64m1_t vs1, vuint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m1_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vmacc_vx_u64m1_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], <vscale x 1 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 1 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vmacc.mask.nxv1i64.i64.i64(<vscale x 1 x i64> [[VD]], i64 [[RS1]], <vscale x 1 x i64> [[VS2]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vmacc_vx_u64m1_m(vbool64_t mask, vuint64m1_t vd, uint64_t rs1, vuint64m1_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m1_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vv_u64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], <vscale x 2 x i64> [[VS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.mask.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VD]], <vscale x 2 x i64> [[VS1]], <vscale x 2 x i64> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vmacc_vv_u64m2_m(vbool32_t mask, vuint64m2_t vd, vuint64m2_t vs1, vuint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vmacc_vx_u64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 2 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vmacc.mask.nxv2i64.i64.i64(<vscale x 2 x i64> [[VD]], i64 [[RS1]], <vscale x 2 x i64> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vmacc_vx_u64m2_m(vbool32_t mask, vuint64m2_t vd, uint64_t rs1, vuint64m2_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vv_u64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], <vscale x 4 x i64> [[VS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.mask.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VD]], <vscale x 4 x i64> [[VS1]], <vscale x 4 x i64> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vmacc_vv_u64m4_m(vbool16_t mask, vuint64m4_t vd, vuint64m4_t vs1, vuint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vmacc_vx_u64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 4 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vmacc.mask.nxv4i64.i64.i64(<vscale x 4 x i64> [[VD]], i64 [[RS1]], <vscale x 4 x i64> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vmacc_vx_u64m4_m(vbool16_t mask, vuint64m4_t vd, uint64_t rs1, vuint64m4_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vv_u64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], <vscale x 8 x i64> [[VS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.mask.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VD]], <vscale x 8 x i64> [[VS1]], <vscale x 8 x i64> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vmacc_vv_u64m8_m(vbool8_t mask, vuint64m8_t vd, vuint64m8_t vs1, vuint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vv_u64m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vmacc_vx_u64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], i64 noundef [[RS1:%.*]], <vscale x 8 x i64> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vmacc.mask.nxv8i64.i64.i64(<vscale x 8 x i64> [[VD]], i64 [[RS1]], <vscale x 8 x i64> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vmacc_vx_u64m8_m(vbool8_t mask, vuint64m8_t vd, uint64_t rs1, vuint64m8_t vs2, size_t vl) {
  return __riscv_th_vmacc_vx_u64m8_m(mask, vd, rs1, vs2, vl);
}

