// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vwmaccu_vv_u16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vwmaccu.nxv8i16.nxv8i8.nxv8i8.i64(<vscale x 8 x i16> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vwmaccu_vv_u16m2(vuint16m2_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u16m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vwmaccu_vx_u16m2
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vwmaccu.nxv8i16.i8.nxv8i8.i64(<vscale x 8 x i16> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vwmaccu_vx_u16m2(vuint16m2_t vd, uint8_t rs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u16m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vwmaccu_vv_u16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], <vscale x 16 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vwmaccu.nxv16i16.nxv16i8.nxv16i8.i64(<vscale x 16 x i16> [[VD]], <vscale x 16 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vwmaccu_vv_u16m4(vuint16m4_t vd, vuint8m2_t vs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u16m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vwmaccu_vx_u16m4
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vwmaccu.nxv16i16.i8.nxv16i8.i64(<vscale x 16 x i16> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vwmaccu_vx_u16m4(vuint16m4_t vd, uint8_t rs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u16m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vwmaccu_vv_u16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], <vscale x 32 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vwmaccu.nxv32i16.nxv32i8.nxv32i8.i64(<vscale x 32 x i16> [[VD]], <vscale x 32 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vwmaccu_vv_u16m8(vuint16m8_t vd, vuint8m4_t vs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u16m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vwmaccu_vx_u16m8
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vwmaccu.nxv32i16.i8.nxv32i8.i64(<vscale x 32 x i16> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vwmaccu_vx_u16m8(vuint16m8_t vd, uint8_t rs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u16m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vwmaccu_vv_u32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], <vscale x 4 x i16> [[VS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vwmaccu.nxv4i32.nxv4i16.nxv4i16.i64(<vscale x 4 x i32> [[VD]], <vscale x 4 x i16> [[VS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vwmaccu_vv_u32m2(vuint32m2_t vd, vuint16m1_t vs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u32m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vwmaccu_vx_u32m2
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vwmaccu.nxv4i32.i16.nxv4i16.i64(<vscale x 4 x i32> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vwmaccu_vx_u32m2(vuint32m2_t vd, uint16_t rs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u32m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vwmaccu_vv_u32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i16> [[VS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vwmaccu.nxv8i32.nxv8i16.nxv8i16.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i16> [[VS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vwmaccu_vv_u32m4(vuint32m4_t vd, vuint16m2_t vs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u32m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vwmaccu_vx_u32m4
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vwmaccu.nxv8i32.i16.nxv8i16.i64(<vscale x 8 x i32> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vwmaccu_vx_u32m4(vuint32m4_t vd, uint16_t rs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u32m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vwmaccu_vv_u32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], <vscale x 16 x i16> [[VS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vwmaccu.nxv16i32.nxv16i16.nxv16i16.i64(<vscale x 16 x i32> [[VD]], <vscale x 16 x i16> [[VS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vwmaccu_vv_u32m8(vuint32m8_t vd, vuint16m4_t vs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u32m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vwmaccu_vx_u32m8
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vwmaccu.nxv16i32.i16.nxv16i16.i64(<vscale x 16 x i32> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vwmaccu_vx_u32m8(vuint32m8_t vd, uint16_t rs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u32m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vwmaccu_vv_u64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], <vscale x 2 x i32> [[VS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vwmaccu.nxv2i64.nxv2i32.nxv2i32.i64(<vscale x 2 x i64> [[VD]], <vscale x 2 x i32> [[VS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vwmaccu_vv_u64m2(vuint64m2_t vd, vuint32m1_t vs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u64m2(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vwmaccu_vx_u64m2
// CHECK-RV64-SAME: (<vscale x 2 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vwmaccu.nxv2i64.i32.nxv2i32.i64(<vscale x 2 x i64> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vwmaccu_vx_u64m2(vuint64m2_t vd, uint32_t rs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u64m2(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vwmaccu_vv_u64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], <vscale x 4 x i32> [[VS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vwmaccu.nxv4i64.nxv4i32.nxv4i32.i64(<vscale x 4 x i64> [[VD]], <vscale x 4 x i32> [[VS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vwmaccu_vv_u64m4(vuint64m4_t vd, vuint32m2_t vs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u64m4(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vwmaccu_vx_u64m4
// CHECK-RV64-SAME: (<vscale x 4 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vwmaccu.nxv4i64.i32.nxv4i32.i64(<vscale x 4 x i64> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vwmaccu_vx_u64m4(vuint64m4_t vd, uint32_t rs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u64m4(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vwmaccu_vv_u64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], <vscale x 8 x i32> [[VS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vwmaccu.nxv8i64.nxv8i32.nxv8i32.i64(<vscale x 8 x i64> [[VD]], <vscale x 8 x i32> [[VS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vwmaccu_vv_u64m8(vuint64m8_t vd, vuint32m4_t vs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u64m8(vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vwmaccu_vx_u64m8
// CHECK-RV64-SAME: (<vscale x 8 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vwmaccu.nxv8i64.i32.nxv8i32.i64(<vscale x 8 x i64> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vwmaccu_vx_u64m8(vuint64m8_t vd, uint32_t rs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u64m8(vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vwmaccu_vv_u16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], <vscale x 8 x i8> [[VS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vwmaccu.mask.nxv8i16.nxv8i8.nxv8i8.i64(<vscale x 8 x i16> [[VD]], <vscale x 8 x i8> [[VS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vwmaccu_vv_u16m2_m(vbool8_t mask, vuint16m2_t vd, vuint8m1_t vs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u16m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vwmaccu_vx_u16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 8 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vwmaccu.mask.nxv8i16.i8.nxv8i8.i64(<vscale x 8 x i16> [[VD]], i8 [[RS1]], <vscale x 8 x i8> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vwmaccu_vx_u16m2_m(vbool8_t mask, vuint16m2_t vd, uint8_t rs1, vuint8m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u16m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vwmaccu_vv_u16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], <vscale x 16 x i8> [[VS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vwmaccu.mask.nxv16i16.nxv16i8.nxv16i8.i64(<vscale x 16 x i16> [[VD]], <vscale x 16 x i8> [[VS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vwmaccu_vv_u16m4_m(vbool4_t mask, vuint16m4_t vd, vuint8m2_t vs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u16m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vwmaccu_vx_u16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 16 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vwmaccu.mask.nxv16i16.i8.nxv16i8.i64(<vscale x 16 x i16> [[VD]], i8 [[RS1]], <vscale x 16 x i8> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vwmaccu_vx_u16m4_m(vbool4_t mask, vuint16m4_t vd, uint8_t rs1, vuint8m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u16m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vwmaccu_vv_u16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], <vscale x 32 x i8> [[VS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vwmaccu.mask.nxv32i16.nxv32i8.nxv32i8.i64(<vscale x 32 x i16> [[VD]], <vscale x 32 x i8> [[VS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vwmaccu_vv_u16m8_m(vbool2_t mask, vuint16m8_t vd, vuint8m4_t vs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u16m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vwmaccu_vx_u16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VD:%.*]], i8 noundef zeroext [[RS1:%.*]], <vscale x 32 x i8> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vwmaccu.mask.nxv32i16.i8.nxv32i8.i64(<vscale x 32 x i16> [[VD]], i8 [[RS1]], <vscale x 32 x i8> [[VS2]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vwmaccu_vx_u16m8_m(vbool2_t mask, vuint16m8_t vd, uint8_t rs1, vuint8m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u16m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vwmaccu_vv_u32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], <vscale x 4 x i16> [[VS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vwmaccu.mask.nxv4i32.nxv4i16.nxv4i16.i64(<vscale x 4 x i32> [[VD]], <vscale x 4 x i16> [[VS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vwmaccu_vv_u32m2_m(vbool16_t mask, vuint32m2_t vd, vuint16m1_t vs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u32m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vwmaccu_vx_u32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 4 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vwmaccu.mask.nxv4i32.i16.nxv4i16.i64(<vscale x 4 x i32> [[VD]], i16 [[RS1]], <vscale x 4 x i16> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vwmaccu_vx_u32m2_m(vbool16_t mask, vuint32m2_t vd, uint16_t rs1, vuint16m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u32m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vwmaccu_vv_u32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], <vscale x 8 x i16> [[VS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vwmaccu.mask.nxv8i32.nxv8i16.nxv8i16.i64(<vscale x 8 x i32> [[VD]], <vscale x 8 x i16> [[VS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vwmaccu_vv_u32m4_m(vbool8_t mask, vuint32m4_t vd, vuint16m2_t vs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u32m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vwmaccu_vx_u32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 8 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vwmaccu.mask.nxv8i32.i16.nxv8i16.i64(<vscale x 8 x i32> [[VD]], i16 [[RS1]], <vscale x 8 x i16> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vwmaccu_vx_u32m4_m(vbool8_t mask, vuint32m4_t vd, uint16_t rs1, vuint16m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u32m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vwmaccu_vv_u32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], <vscale x 16 x i16> [[VS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vwmaccu.mask.nxv16i32.nxv16i16.nxv16i16.i64(<vscale x 16 x i32> [[VD]], <vscale x 16 x i16> [[VS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vwmaccu_vv_u32m8_m(vbool4_t mask, vuint32m8_t vd, vuint16m4_t vs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u32m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vwmaccu_vx_u32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VD:%.*]], i16 noundef zeroext [[RS1:%.*]], <vscale x 16 x i16> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vwmaccu.mask.nxv16i32.i16.nxv16i16.i64(<vscale x 16 x i32> [[VD]], i16 [[RS1]], <vscale x 16 x i16> [[VS2]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vwmaccu_vx_u32m8_m(vbool4_t mask, vuint32m8_t vd, uint16_t rs1, vuint16m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u32m8_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vwmaccu_vv_u64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], <vscale x 2 x i32> [[VS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vwmaccu.mask.nxv2i64.nxv2i32.nxv2i32.i64(<vscale x 2 x i64> [[VD]], <vscale x 2 x i32> [[VS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vwmaccu_vv_u64m2_m(vbool32_t mask, vuint64m2_t vd, vuint32m1_t vs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u64m2_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vwmaccu_vx_u64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 2 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vwmaccu.mask.nxv2i64.i32.nxv2i32.i64(<vscale x 2 x i64> [[VD]], i32 [[RS1]], <vscale x 2 x i32> [[VS2]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vwmaccu_vx_u64m2_m(vbool32_t mask, vuint64m2_t vd, uint32_t rs1, vuint32m1_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u64m2_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vwmaccu_vv_u64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], <vscale x 4 x i32> [[VS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vwmaccu.mask.nxv4i64.nxv4i32.nxv4i32.i64(<vscale x 4 x i64> [[VD]], <vscale x 4 x i32> [[VS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vwmaccu_vv_u64m4_m(vbool16_t mask, vuint64m4_t vd, vuint32m2_t vs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u64m4_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vwmaccu_vx_u64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 4 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vwmaccu.mask.nxv4i64.i32.nxv4i32.i64(<vscale x 4 x i64> [[VD]], i32 [[RS1]], <vscale x 4 x i32> [[VS2]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vwmaccu_vx_u64m4_m(vbool16_t mask, vuint64m4_t vd, uint32_t rs1, vuint32m2_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u64m4_m(mask, vd, rs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vwmaccu_vv_u64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], <vscale x 8 x i32> [[VS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vwmaccu.mask.nxv8i64.nxv8i32.nxv8i32.i64(<vscale x 8 x i64> [[VD]], <vscale x 8 x i32> [[VS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vwmaccu_vv_u64m8_m(vbool8_t mask, vuint64m8_t vd, vuint32m4_t vs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vv_u64m8_m(mask, vd, vs1, vs2, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vwmaccu_vx_u64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i64> [[VD:%.*]], i32 noundef signext [[RS1:%.*]], <vscale x 8 x i32> [[VS2:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vwmaccu.mask.nxv8i64.i32.nxv8i32.i64(<vscale x 8 x i64> [[VD]], i32 [[RS1]], <vscale x 8 x i32> [[VS2]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vwmaccu_vx_u64m8_m(vbool8_t mask, vuint64m8_t vd, uint32_t rs1, vuint32m4_t vs2, size_t vl) {
  return __riscv_th_vwmaccu_vx_u64m8_m(mask, vd, rs1, vs2, vl);
}

