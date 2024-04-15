// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vid_v_u8m1
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vid.nxv8i8.i64(<vscale x 8 x i8> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vid_v_u8m1(size_t vl) {
  return __riscv_th_vid_v_u8m1(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vid_v_u8m2
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vid.nxv16i8.i64(<vscale x 16 x i8> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vid_v_u8m2(size_t vl) {
  return __riscv_th_vid_v_u8m2(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vid_v_u8m4
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vid.nxv32i8.i64(<vscale x 32 x i8> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vid_v_u8m4(size_t vl) {
  return __riscv_th_vid_v_u8m4(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vid_v_u8m8
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vid.nxv64i8.i64(<vscale x 64 x i8> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vid_v_u8m8(size_t vl) {
  return __riscv_th_vid_v_u8m8(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vid_v_u16m1
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vid.nxv4i16.i64(<vscale x 4 x i16> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vid_v_u16m1(size_t vl) {
  return __riscv_th_vid_v_u16m1(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vid_v_u16m2
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vid.nxv8i16.i64(<vscale x 8 x i16> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vid_v_u16m2(size_t vl) {
  return __riscv_th_vid_v_u16m2(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vid_v_u16m4
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vid.nxv16i16.i64(<vscale x 16 x i16> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vid_v_u16m4(size_t vl) {
  return __riscv_th_vid_v_u16m4(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vid_v_u16m8
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vid.nxv32i16.i64(<vscale x 32 x i16> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vid_v_u16m8(size_t vl) {
  return __riscv_th_vid_v_u16m8(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vid_v_u32m1
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vid.nxv2i32.i64(<vscale x 2 x i32> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vid_v_u32m1(size_t vl) {
  return __riscv_th_vid_v_u32m1(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vid_v_u32m2
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vid.nxv4i32.i64(<vscale x 4 x i32> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vid_v_u32m2(size_t vl) {
  return __riscv_th_vid_v_u32m2(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vid_v_u32m4
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vid.nxv8i32.i64(<vscale x 8 x i32> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vid_v_u32m4(size_t vl) {
  return __riscv_th_vid_v_u32m4(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vid_v_u32m8
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vid.nxv16i32.i64(<vscale x 16 x i32> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vid_v_u32m8(size_t vl) {
  return __riscv_th_vid_v_u32m8(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vid_v_u64m1
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vid.nxv1i64.i64(<vscale x 1 x i64> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vid_v_u64m1(size_t vl) {
  return __riscv_th_vid_v_u64m1(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vid_v_u64m2
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vid.nxv2i64.i64(<vscale x 2 x i64> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vid_v_u64m2(size_t vl) {
  return __riscv_th_vid_v_u64m2(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vid_v_u64m4
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vid.nxv4i64.i64(<vscale x 4 x i64> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vid_v_u64m4(size_t vl) {
  return __riscv_th_vid_v_u64m4(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vid_v_u64m8
// CHECK-RV64-SAME: (i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vid.nxv8i64.i64(<vscale x 8 x i64> poison, i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vid_v_u64m8(size_t vl) {
  return __riscv_th_vid_v_u64m8(vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i8> @test_vid_v_u8m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i8> @llvm.riscv.th.vid.mask.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i8> [[TMP0]]
//
vuint8m1_t test_vid_v_u8m1_m(vbool8_t mask, size_t vl) {
  return __riscv_th_vid_v_u8m1_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i8> @test_vid_v_u8m2_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i8> @llvm.riscv.th.vid.mask.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
vuint8m2_t test_vid_v_u8m2_m(vbool4_t mask, size_t vl) {
  return __riscv_th_vid_v_u8m2_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i8> @test_vid_v_u8m4_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i8> @llvm.riscv.th.vid.mask.nxv32i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i8> [[TMP0]]
//
vuint8m4_t test_vid_v_u8m4_m(vbool2_t mask, size_t vl) {
  return __riscv_th_vid_v_u8m4_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 64 x i8> @test_vid_v_u8m8_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 64 x i8> @llvm.riscv.th.vid.mask.nxv64i8.i64(<vscale x 64 x i8> poison, <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 64 x i8> [[TMP0]]
//
vuint8m8_t test_vid_v_u8m8_m(vbool1_t mask, size_t vl) {
  return __riscv_th_vid_v_u8m8_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vid_v_u16m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vid.mask.nxv4i16.i64(<vscale x 4 x i16> poison, <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vuint16m1_t test_vid_v_u16m1_m(vbool16_t mask, size_t vl) {
  return __riscv_th_vid_v_u16m1_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_vid_v_u16m2_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i16> @llvm.riscv.th.vid.mask.nxv8i16.i64(<vscale x 8 x i16> poison, <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP0]]
//
vuint16m2_t test_vid_v_u16m2_m(vbool8_t mask, size_t vl) {
  return __riscv_th_vid_v_u16m2_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_vid_v_u16m4_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i16> @llvm.riscv.th.vid.mask.nxv16i16.i64(<vscale x 16 x i16> poison, <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP0]]
//
vuint16m4_t test_vid_v_u16m4_m(vbool4_t mask, size_t vl) {
  return __riscv_th_vid_v_u16m4_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_vid_v_u16m8_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 32 x i16> @llvm.riscv.th.vid.mask.nxv32i16.i64(<vscale x 32 x i16> poison, <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP0]]
//
vuint16m8_t test_vid_v_u16m8_m(vbool2_t mask, size_t vl) {
  return __riscv_th_vid_v_u16m8_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vid_v_u32m1_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vid.mask.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vuint32m1_t test_vid_v_u32m1_m(vbool32_t mask, size_t vl) {
  return __riscv_th_vid_v_u32m1_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i32> @test_vid_v_u32m2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i32> @llvm.riscv.th.vid.mask.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i32> [[TMP0]]
//
vuint32m2_t test_vid_v_u32m2_m(vbool16_t mask, size_t vl) {
  return __riscv_th_vid_v_u32m2_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i32> @test_vid_v_u32m4_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i32> @llvm.riscv.th.vid.mask.nxv8i32.i64(<vscale x 8 x i32> poison, <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i32> [[TMP0]]
//
vuint32m4_t test_vid_v_u32m4_m(vbool8_t mask, size_t vl) {
  return __riscv_th_vid_v_u32m4_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i32> @test_vid_v_u32m8_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 16 x i32> @llvm.riscv.th.vid.mask.nxv16i32.i64(<vscale x 16 x i32> poison, <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 16 x i32> [[TMP0]]
//
vuint32m8_t test_vid_v_u32m8_m(vbool4_t mask, size_t vl) {
  return __riscv_th_vid_v_u32m8_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vid_v_u64m1_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vid.mask.nxv1i64.i64(<vscale x 1 x i64> poison, <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vuint64m1_t test_vid_v_u64m1_m(vbool64_t mask, size_t vl) {
  return __riscv_th_vid_v_u64m1_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i64> @test_vid_v_u64m2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i64> @llvm.riscv.th.vid.mask.nxv2i64.i64(<vscale x 2 x i64> poison, <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i64> [[TMP0]]
//
vuint64m2_t test_vid_v_u64m2_m(vbool32_t mask, size_t vl) {
  return __riscv_th_vid_v_u64m2_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i64> @test_vid_v_u64m4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i64> @llvm.riscv.th.vid.mask.nxv4i64.i64(<vscale x 4 x i64> poison, <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i64> [[TMP0]]
//
vuint64m4_t test_vid_v_u64m4_m(vbool16_t mask, size_t vl) {
  return __riscv_th_vid_v_u64m4_m(mask, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i64> @test_vid_v_u64m8_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 8 x i64> @llvm.riscv.th.vid.mask.nxv8i64.i64(<vscale x 8 x i64> poison, <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 8 x i64> [[TMP0]]
//
vuint64m8_t test_vid_v_u64m8_m(vbool8_t mask, size_t vl) {
  return __riscv_th_vid_v_u64m8_m(mask, vl);
}

