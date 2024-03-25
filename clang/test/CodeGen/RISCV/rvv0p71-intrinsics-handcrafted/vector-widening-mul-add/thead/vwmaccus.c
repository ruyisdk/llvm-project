// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vwmaccus_vx_i16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vwmaccus.nxv8i16.i8.nxv8i8.i64(<vscale x 8 x i16> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vwmaccus_vx_i16m2(vint16m2_t vd, uint8_t rs1, vint8m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i16m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vwmaccus_vx_i16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vwmaccus.nxv16i16.i8.nxv16i8.i64(<vscale x 16 x i16> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vwmaccus_vx_i16m4(vint16m4_t vd, uint8_t rs1, vint8m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i16m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vwmaccus_vx_i16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vwmaccus.nxv32i16.i8.nxv32i8.i64(<vscale x 32 x i16> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vwmaccus_vx_i16m8(vint16m8_t vd, uint8_t rs1, vint8m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i16m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vwmaccus_vx_i32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vwmaccus.nxv4i32.i16.nxv4i16.i64(<vscale x 4 x i32> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vwmaccus_vx_i32m2(vint32m2_t vd, uint16_t rs1, vint16m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i32m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vwmaccus_vx_i32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vwmaccus.nxv8i32.i16.nxv8i16.i64(<vscale x 8 x i32> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vwmaccus_vx_i32m4(vint32m4_t vd, uint16_t rs1, vint16m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i32m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vwmaccus_vx_i32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vwmaccus.nxv16i32.i16.nxv16i16.i64(<vscale x 16 x i32> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vwmaccus_vx_i32m8(vint32m8_t vd, uint16_t rs1, vint16m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i32m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vwmaccus_vx_i64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vwmaccus.nxv2i64.i32.nxv2i32.i64(<vscale x 2 x i64> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vwmaccus_vx_i64m2(vint64m2_t vd, uint32_t rs1, vint32m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i64m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vwmaccus_vx_i64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vwmaccus.nxv4i64.i32.nxv4i32.i64(<vscale x 4 x i64> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vwmaccus_vx_i64m4(vint64m4_t vd, uint32_t rs1, vint32m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i64m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vwmaccus_vx_i64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vwmaccus.nxv8i64.i32.nxv8i32.i64(<vscale x 8 x i64> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vwmaccus_vx_i64m8(vint64m8_t vd, uint32_t rs1, vint32m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i64m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vwmaccus_vx_i16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vwmaccus.mask.nxv8i16.i8.nxv8i8.i64(<vscale x 8 x i16> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vint16m2_t test_vwmaccus_vx_i16m2_m(vbool8_t mask, vint16m2_t vd, uint8_t rs1, vint8m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i16m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vwmaccus_vx_i16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vwmaccus.mask.nxv16i16.i8.nxv16i8.i64(<vscale x 16 x i16> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vint16m4_t test_vwmaccus_vx_i16m4_m(vbool4_t mask, vint16m4_t vd, uint8_t rs1, vint8m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i16m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vwmaccus_vx_i16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vwmaccus.mask.nxv32i16.i8.nxv32i8.i64(<vscale x 32 x i16> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vint16m8_t test_vwmaccus_vx_i16m8_m(vbool2_t mask, vint16m8_t vd, uint8_t rs1, vint8m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i16m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vwmaccus_vx_i32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vwmaccus.mask.nxv4i32.i16.nxv4i16.i64(<vscale x 4 x i32> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vint32m2_t test_vwmaccus_vx_i32m2_m(vbool16_t mask, vint32m2_t vd, uint16_t rs1, vint16m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i32m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vwmaccus_vx_i32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vwmaccus.mask.nxv8i32.i16.nxv8i16.i64(<vscale x 8 x i32> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vint32m4_t test_vwmaccus_vx_i32m4_m(vbool8_t mask, vint32m4_t vd, uint16_t rs1, vint16m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i32m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vwmaccus_vx_i32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vwmaccus.mask.nxv16i32.i16.nxv16i16.i64(<vscale x 16 x i32> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vint32m8_t test_vwmaccus_vx_i32m8_m(vbool4_t mask, vint32m8_t vd, uint16_t rs1, vint16m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i32m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vwmaccus_vx_i64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vwmaccus.mask.nxv2i64.i32.nxv2i32.i64(<vscale x 2 x i64> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vint64m2_t test_vwmaccus_vx_i64m2_m(vbool32_t mask, vint64m2_t vd, uint32_t rs1, vint32m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i64m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vwmaccus_vx_i64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vwmaccus.mask.nxv4i64.i32.nxv4i32.i64(<vscale x 4 x i64> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vint64m4_t test_vwmaccus_vx_i64m4_m(vbool16_t mask, vint64m4_t vd, uint32_t rs1, vint32m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i64m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vwmaccus_vx_i64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vwmaccus.mask.nxv8i64.i32.nxv8i32.i64(<vscale x 8 x i64> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vint64m8_t test_vwmaccus_vx_i64m8_m(vbool8_t mask, vint64m8_t vd, uint32_t rs1, vint32m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccus_vx_i64m8_m(mask, vd, rs1, vs2, vl);
}

