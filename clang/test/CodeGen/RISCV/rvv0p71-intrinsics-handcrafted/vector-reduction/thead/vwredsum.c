// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -target-feature +d -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m1_i16m1
// CHECK-RV64-SAME: (<vscale x 8 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.nxv4i16.nxv8i8.i64(<vscale x 4 x i16> poison, <vscale x 8 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m1_i16m1(vint8m1_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m1_i16m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m2_i16m1
// CHECK-RV64-SAME: (<vscale x 16 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.nxv4i16.nxv16i8.i64(<vscale x 4 x i16> poison, <vscale x 16 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m2_i16m1(vint8m2_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m2_i16m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m4_i16m1
// CHECK-RV64-SAME: (<vscale x 32 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.nxv4i16.nxv32i8.i64(<vscale x 4 x i16> poison, <vscale x 32 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m4_i16m1(vint8m4_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m4_i16m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m8_i16m1
// CHECK-RV64-SAME: (<vscale x 64 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.nxv4i16.nxv64i8.i64(<vscale x 4 x i16> poison, <vscale x 64 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m8_i16m1(vint8m8_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m8_i16m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m1_i32m1
// CHECK-RV64-SAME: (<vscale x 4 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.nxv2i32.nxv4i16.i64(<vscale x 2 x i32> poison, <vscale x 4 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m1_i32m1(vint16m1_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m1_i32m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m2_i32m1
// CHECK-RV64-SAME: (<vscale x 8 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.nxv2i32.nxv8i16.i64(<vscale x 2 x i32> poison, <vscale x 8 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m2_i32m1(vint16m2_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m2_i32m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m4_i32m1
// CHECK-RV64-SAME: (<vscale x 16 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.nxv2i32.nxv16i16.i64(<vscale x 2 x i32> poison, <vscale x 16 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m4_i32m1(vint16m4_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m4_i32m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m8_i32m1
// CHECK-RV64-SAME: (<vscale x 32 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.nxv2i32.nxv32i16.i64(<vscale x 2 x i32> poison, <vscale x 32 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m8_i32m1(vint16m8_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m8_i32m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m1_i64m1
// CHECK-RV64-SAME: (<vscale x 2 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.nxv1i64.nxv2i32.i64(<vscale x 1 x i64> poison, <vscale x 2 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m1_i64m1(vint32m1_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m1_i64m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m2_i64m1
// CHECK-RV64-SAME: (<vscale x 4 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.nxv1i64.nxv4i32.i64(<vscale x 1 x i64> poison, <vscale x 4 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m2_i64m1(vint32m2_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m2_i64m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m4_i64m1
// CHECK-RV64-SAME: (<vscale x 8 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.nxv1i64.nxv8i32.i64(<vscale x 1 x i64> poison, <vscale x 8 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m4_i64m1(vint32m4_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m4_i64m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m8_i64m1
// CHECK-RV64-SAME: (<vscale x 16 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.nxv1i64.nxv16i32.i64(<vscale x 1 x i64> poison, <vscale x 16 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m8_i64m1(vint32m8_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m8_i64m1(vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m1_i16m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.mask.nxv4i16.nxv8i8.i64(<vscale x 4 x i16> poison, <vscale x 8 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m1_i16m1_m(vbool8_t mask, vint8m1_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m1_i16m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m2_i16m1_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.mask.nxv4i16.nxv16i8.i64(<vscale x 4 x i16> poison, <vscale x 16 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m2_i16m1_m(vbool4_t mask, vint8m2_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m2_i16m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m4_i16m1_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.mask.nxv4i16.nxv32i8.i64(<vscale x 4 x i16> poison, <vscale x 32 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m4_i16m1_m(vbool2_t mask, vint8m4_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m4_i16m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_vwredsum_vs_i8m8_i16m1_m
// CHECK-RV64-SAME: (<vscale x 64 x i1> [[MASK:%.*]], <vscale x 64 x i8> [[VECTOR:%.*]], <vscale x 4 x i16> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 4 x i16> @llvm.riscv.th.vwredsum.mask.nxv4i16.nxv64i8.i64(<vscale x 4 x i16> poison, <vscale x 64 x i8> [[VECTOR]], <vscale x 4 x i16> [[SCALAR]], <vscale x 64 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP0]]
//
vint16m1_t test_vwredsum_vs_i8m8_i16m1_m(vbool1_t mask, vint8m8_t vector, vint16m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i8m8_i16m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m1_i32m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.mask.nxv2i32.nxv4i16.i64(<vscale x 2 x i32> poison, <vscale x 4 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m1_i32m1_m(vbool16_t mask, vint16m1_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m1_i32m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m2_i32m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.mask.nxv2i32.nxv8i16.i64(<vscale x 2 x i32> poison, <vscale x 8 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m2_i32m1_m(vbool8_t mask, vint16m2_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m2_i32m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m4_i32m1_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.mask.nxv2i32.nxv16i16.i64(<vscale x 2 x i32> poison, <vscale x 16 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m4_i32m1_m(vbool4_t mask, vint16m4_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m4_i32m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 2 x i32> @test_vwredsum_vs_i16m8_i32m1_m
// CHECK-RV64-SAME: (<vscale x 32 x i1> [[MASK:%.*]], <vscale x 32 x i16> [[VECTOR:%.*]], <vscale x 2 x i32> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 2 x i32> @llvm.riscv.th.vwredsum.mask.nxv2i32.nxv32i16.i64(<vscale x 2 x i32> poison, <vscale x 32 x i16> [[VECTOR]], <vscale x 2 x i32> [[SCALAR]], <vscale x 32 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 2 x i32> [[TMP0]]
//
vint32m1_t test_vwredsum_vs_i16m8_i32m1_m(vbool2_t mask, vint16m8_t vector, vint32m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i16m8_i32m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m1_i64m1_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], <vscale x 2 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.mask.nxv1i64.nxv2i32.i64(<vscale x 1 x i64> poison, <vscale x 2 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m1_i64m1_m(vbool32_t mask, vint32m1_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m1_i64m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m2_i64m1_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], <vscale x 4 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.mask.nxv1i64.nxv4i32.i64(<vscale x 1 x i64> poison, <vscale x 4 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m2_i64m1_m(vbool16_t mask, vint32m2_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m2_i64m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m4_i64m1_m
// CHECK-RV64-SAME: (<vscale x 8 x i1> [[MASK:%.*]], <vscale x 8 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.mask.nxv1i64.nxv8i32.i64(<vscale x 1 x i64> poison, <vscale x 8 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], <vscale x 8 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m4_i64m1_m(vbool8_t mask, vint32m4_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m4_i64m1_m(mask, vector, scalar, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 1 x i64> @test_vwredsum_vs_i32m8_i64m1_m
// CHECK-RV64-SAME: (<vscale x 16 x i1> [[MASK:%.*]], <vscale x 16 x i32> [[VECTOR:%.*]], <vscale x 1 x i64> [[SCALAR:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call <vscale x 1 x i64> @llvm.riscv.th.vwredsum.mask.nxv1i64.nxv16i32.i64(<vscale x 1 x i64> poison, <vscale x 16 x i32> [[VECTOR]], <vscale x 1 x i64> [[SCALAR]], <vscale x 16 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret <vscale x 1 x i64> [[TMP0]]
//
vint64m1_t test_vwredsum_vs_i32m8_i64m1_m(vbool4_t mask, vint32m8_t vector, vint64m1_t scalar, size_t vl) {
  return __riscv_th_vwredsum_vs_i32m8_i64m1_m(mask, vector, scalar, vl);
}

