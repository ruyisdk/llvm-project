// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i8m1(int8_t *base, vuint8m1_t index, vint8m1_t value, size_t vl) {
  return __riscv_vsxb_v_i8m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i8m2(int8_t *base, vuint8m2_t index, vint8m2_t value, size_t vl) {
  return __riscv_vsxb_v_i8m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i8m4(int8_t *base, vuint8m4_t index, vint8m4_t value, size_t vl) {
  return __riscv_vsxb_v_i8m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i8m8(int8_t *base, vuint8m8_t index, vint8m8_t value, size_t vl) {
  return __riscv_vsxb_v_i8m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i16m1(int16_t *base, vuint16m1_t index, vint16m1_t value, size_t vl) {
  return __riscv_vsxb_v_i16m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i16m2(int16_t *base, vuint16m2_t index, vint16m2_t value, size_t vl) {
  return __riscv_vsxb_v_i16m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i16m4(int16_t *base, vuint16m4_t index, vint16m4_t value, size_t vl) {
  return __riscv_vsxb_v_i16m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i16m8(int16_t *base, vuint16m8_t index, vint16m8_t value, size_t vl) {
  return __riscv_vsxb_v_i16m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i32m1(int32_t *base, vuint32m1_t index, vint32m1_t value, size_t vl) {
  return __riscv_vsxb_v_i32m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i32m2(int32_t *base, vuint32m2_t index, vint32m2_t value, size_t vl) {
  return __riscv_vsxb_v_i32m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i32m4(int32_t *base, vuint32m4_t index, vint32m4_t value, size_t vl) {
  return __riscv_vsxb_v_i32m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i32m8(int32_t *base, vuint32m8_t index, vint32m8_t value, size_t vl) {
  return __riscv_vsxb_v_i32m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i64m1(int64_t *base, vuint64m1_t index, vint64m1_t value, size_t vl) {
  return __riscv_vsxb_v_i64m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i64m2(int64_t *base, vuint64m2_t index, vint64m2_t value, size_t vl) {
  return __riscv_vsxb_v_i64m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i64m4(int64_t *base, vuint64m4_t index, vint64m4_t value, size_t vl) {
  return __riscv_vsxb_v_i64m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_i64m8(int64_t *base, vuint64m8_t index, vint64m8_t value, size_t vl) {
  return __riscv_vsxb_v_i64m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i8m1(int8_t *base, vuint8m1_t index, vint8m1_t value, size_t vl) {
  return __riscv_vsxh_v_i8m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i8m2(int8_t *base, vuint8m2_t index, vint8m2_t value, size_t vl) {
  return __riscv_vsxh_v_i8m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i8m4(int8_t *base, vuint8m4_t index, vint8m4_t value, size_t vl) {
  return __riscv_vsxh_v_i8m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i8m8(int8_t *base, vuint8m8_t index, vint8m8_t value, size_t vl) {
  return __riscv_vsxh_v_i8m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i16m1(int16_t *base, vuint16m1_t index, vint16m1_t value, size_t vl) {
  return __riscv_vsxh_v_i16m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i16m2(int16_t *base, vuint16m2_t index, vint16m2_t value, size_t vl) {
  return __riscv_vsxh_v_i16m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i16m4(int16_t *base, vuint16m4_t index, vint16m4_t value, size_t vl) {
  return __riscv_vsxh_v_i16m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i16m8(int16_t *base, vuint16m8_t index, vint16m8_t value, size_t vl) {
  return __riscv_vsxh_v_i16m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i32m1(int32_t *base, vuint32m1_t index, vint32m1_t value, size_t vl) {
  return __riscv_vsxh_v_i32m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i32m2(int32_t *base, vuint32m2_t index, vint32m2_t value, size_t vl) {
  return __riscv_vsxh_v_i32m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i32m4(int32_t *base, vuint32m4_t index, vint32m4_t value, size_t vl) {
  return __riscv_vsxh_v_i32m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i32m8(int32_t *base, vuint32m8_t index, vint32m8_t value, size_t vl) {
  return __riscv_vsxh_v_i32m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i64m1(int64_t *base, vuint64m1_t index, vint64m1_t value, size_t vl) {
  return __riscv_vsxh_v_i64m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i64m2(int64_t *base, vuint64m2_t index, vint64m2_t value, size_t vl) {
  return __riscv_vsxh_v_i64m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i64m4(int64_t *base, vuint64m4_t index, vint64m4_t value, size_t vl) {
  return __riscv_vsxh_v_i64m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_i64m8(int64_t *base, vuint64m8_t index, vint64m8_t value, size_t vl) {
  return __riscv_vsxh_v_i64m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i8m1(int8_t *base, vuint8m1_t index, vint8m1_t value, size_t vl) {
  return __riscv_vsxw_v_i8m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i8m2(int8_t *base, vuint8m2_t index, vint8m2_t value, size_t vl) {
  return __riscv_vsxw_v_i8m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i8m4(int8_t *base, vuint8m4_t index, vint8m4_t value, size_t vl) {
  return __riscv_vsxw_v_i8m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i8m8(int8_t *base, vuint8m8_t index, vint8m8_t value, size_t vl) {
  return __riscv_vsxw_v_i8m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i16m1(int16_t *base, vuint16m1_t index, vint16m1_t value, size_t vl) {
  return __riscv_vsxw_v_i16m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i16m2(int16_t *base, vuint16m2_t index, vint16m2_t value, size_t vl) {
  return __riscv_vsxw_v_i16m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i16m4(int16_t *base, vuint16m4_t index, vint16m4_t value, size_t vl) {
  return __riscv_vsxw_v_i16m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i16m8(int16_t *base, vuint16m8_t index, vint16m8_t value, size_t vl) {
  return __riscv_vsxw_v_i16m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i32m1(int32_t *base, vuint32m1_t index, vint32m1_t value, size_t vl) {
  return __riscv_vsxw_v_i32m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i32m2(int32_t *base, vuint32m2_t index, vint32m2_t value, size_t vl) {
  return __riscv_vsxw_v_i32m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i32m4(int32_t *base, vuint32m4_t index, vint32m4_t value, size_t vl) {
  return __riscv_vsxw_v_i32m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i32m8(int32_t *base, vuint32m8_t index, vint32m8_t value, size_t vl) {
  return __riscv_vsxw_v_i32m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i64m1(int64_t *base, vuint64m1_t index, vint64m1_t value, size_t vl) {
  return __riscv_vsxw_v_i64m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i64m2(int64_t *base, vuint64m2_t index, vint64m2_t value, size_t vl) {
  return __riscv_vsxw_v_i64m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i64m4(int64_t *base, vuint64m4_t index, vint64m4_t value, size_t vl) {
  return __riscv_vsxw_v_i64m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_i64m8(int64_t *base, vuint64m8_t index, vint64m8_t value, size_t vl) {
  return __riscv_vsxw_v_i64m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u8m1(uint8_t *base, vuint8m1_t index, vuint8m1_t value, size_t vl) {
  return __riscv_vsxb_v_u8m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u8m2(uint8_t *base, vuint8m2_t index, vuint8m2_t value, size_t vl) {
  return __riscv_vsxb_v_u8m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u8m4(uint8_t *base, vuint8m4_t index, vuint8m4_t value, size_t vl) {
  return __riscv_vsxb_v_u8m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u8m8(uint8_t *base, vuint8m8_t index, vuint8m8_t value, size_t vl) {
  return __riscv_vsxb_v_u8m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u16m1(uint16_t *base, vuint16m1_t index, vuint16m1_t value, size_t vl) {
  return __riscv_vsxb_v_u16m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u16m2(uint16_t *base, vuint16m2_t index, vuint16m2_t value, size_t vl) {
  return __riscv_vsxb_v_u16m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u16m4(uint16_t *base, vuint16m4_t index, vuint16m4_t value, size_t vl) {
  return __riscv_vsxb_v_u16m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u16m8(uint16_t *base, vuint16m8_t index, vuint16m8_t value, size_t vl) {
  return __riscv_vsxb_v_u16m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u32m1(uint32_t *base, vuint32m1_t index, vuint32m1_t value, size_t vl) {
  return __riscv_vsxb_v_u32m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u32m2(uint32_t *base, vuint32m2_t index, vuint32m2_t value, size_t vl) {
  return __riscv_vsxb_v_u32m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u32m4(uint32_t *base, vuint32m4_t index, vuint32m4_t value, size_t vl) {
  return __riscv_vsxb_v_u32m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u32m8(uint32_t *base, vuint32m8_t index, vuint32m8_t value, size_t vl) {
  return __riscv_vsxb_v_u32m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u64m1(uint64_t *base, vuint64m1_t index, vuint64m1_t value, size_t vl) {
  return __riscv_vsxb_v_u64m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u64m2(uint64_t *base, vuint64m2_t index, vuint64m2_t value, size_t vl) {
  return __riscv_vsxb_v_u64m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u64m4(uint64_t *base, vuint64m4_t index, vuint64m4_t value, size_t vl) {
  return __riscv_vsxb_v_u64m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxb_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxb.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxb_v_u64m8(uint64_t *base, vuint64m8_t index, vuint64m8_t value, size_t vl) {
  return __riscv_vsxb_v_u64m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u8m1(uint8_t *base, vuint8m1_t index, vuint8m1_t value, size_t vl) {
  return __riscv_vsxh_v_u8m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u8m2(uint8_t *base, vuint8m2_t index, vuint8m2_t value, size_t vl) {
  return __riscv_vsxh_v_u8m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u8m4(uint8_t *base, vuint8m4_t index, vuint8m4_t value, size_t vl) {
  return __riscv_vsxh_v_u8m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u8m8(uint8_t *base, vuint8m8_t index, vuint8m8_t value, size_t vl) {
  return __riscv_vsxh_v_u8m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u16m1(uint16_t *base, vuint16m1_t index, vuint16m1_t value, size_t vl) {
  return __riscv_vsxh_v_u16m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u16m2(uint16_t *base, vuint16m2_t index, vuint16m2_t value, size_t vl) {
  return __riscv_vsxh_v_u16m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u16m4(uint16_t *base, vuint16m4_t index, vuint16m4_t value, size_t vl) {
  return __riscv_vsxh_v_u16m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u16m8(uint16_t *base, vuint16m8_t index, vuint16m8_t value, size_t vl) {
  return __riscv_vsxh_v_u16m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u32m1(uint32_t *base, vuint32m1_t index, vuint32m1_t value, size_t vl) {
  return __riscv_vsxh_v_u32m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u32m2(uint32_t *base, vuint32m2_t index, vuint32m2_t value, size_t vl) {
  return __riscv_vsxh_v_u32m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u32m4(uint32_t *base, vuint32m4_t index, vuint32m4_t value, size_t vl) {
  return __riscv_vsxh_v_u32m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u32m8(uint32_t *base, vuint32m8_t index, vuint32m8_t value, size_t vl) {
  return __riscv_vsxh_v_u32m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u64m1(uint64_t *base, vuint64m1_t index, vuint64m1_t value, size_t vl) {
  return __riscv_vsxh_v_u64m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u64m2(uint64_t *base, vuint64m2_t index, vuint64m2_t value, size_t vl) {
  return __riscv_vsxh_v_u64m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u64m4(uint64_t *base, vuint64m4_t index, vuint64m4_t value, size_t vl) {
  return __riscv_vsxh_v_u64m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxh_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxh.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxh_v_u64m8(uint64_t *base, vuint64m8_t index, vuint64m8_t value, size_t vl) {
  return __riscv_vsxh_v_u64m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[INDEX:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i8.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], <vscale x 8 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u8m1(uint8_t *base, vuint8m1_t index, vuint8m1_t value, size_t vl) {
  return __riscv_vsxw_v_u8m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[INDEX:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv16i8.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], <vscale x 16 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u8m2(uint8_t *base, vuint8m2_t index, vuint8m2_t value, size_t vl) {
  return __riscv_vsxw_v_u8m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[INDEX:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv32i8.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], <vscale x 32 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u8m4(uint8_t *base, vuint8m4_t index, vuint8m4_t value, size_t vl) {
  return __riscv_vsxw_v_u8m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[INDEX:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv64i8.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], <vscale x 64 x i8> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u8m8(uint8_t *base, vuint8m8_t index, vuint8m8_t value, size_t vl) {
  return __riscv_vsxw_v_u8m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i16> [[INDEX:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv4i16.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], <vscale x 4 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u16m1(uint16_t *base, vuint16m1_t index, vuint16m1_t value, size_t vl) {
  return __riscv_vsxw_v_u16m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i16> [[INDEX:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i16.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], <vscale x 8 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u16m2(uint16_t *base, vuint16m2_t index, vuint16m2_t value, size_t vl) {
  return __riscv_vsxw_v_u16m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i16> [[INDEX:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv16i16.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], <vscale x 16 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u16m4(uint16_t *base, vuint16m4_t index, vuint16m4_t value, size_t vl) {
  return __riscv_vsxw_v_u16m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i16> [[INDEX:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv32i16.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], <vscale x 32 x i16> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u16m8(uint16_t *base, vuint16m8_t index, vuint16m8_t value, size_t vl) {
  return __riscv_vsxw_v_u16m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[INDEX:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv2i32.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], <vscale x 2 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u32m1(uint32_t *base, vuint32m1_t index, vuint32m1_t value, size_t vl) {
  return __riscv_vsxw_v_u32m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i32> [[INDEX:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv4i32.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], <vscale x 4 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u32m2(uint32_t *base, vuint32m2_t index, vuint32m2_t value, size_t vl) {
  return __riscv_vsxw_v_u32m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i32> [[INDEX:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i32.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], <vscale x 8 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u32m4(uint32_t *base, vuint32m4_t index, vuint32m4_t value, size_t vl) {
  return __riscv_vsxw_v_u32m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i32> [[INDEX:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv16i32.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], <vscale x 16 x i32> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u32m8(uint32_t *base, vuint32m8_t index, vuint32m8_t value, size_t vl) {
  return __riscv_vsxw_v_u32m8(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[INDEX:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv1i64.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], <vscale x 1 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u64m1(uint64_t *base, vuint64m1_t index, vuint64m1_t value, size_t vl) {
  return __riscv_vsxw_v_u64m1(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[INDEX:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv2i64.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], <vscale x 2 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u64m2(uint64_t *base, vuint64m2_t index, vuint64m2_t value, size_t vl) {
  return __riscv_vsxw_v_u64m2(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[INDEX:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv4i64.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], <vscale x 4 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u64m4(uint64_t *base, vuint64m4_t index, vuint64m4_t value, size_t vl) {
  return __riscv_vsxw_v_u64m4(base, index, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsxw_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i64> [[INDEX:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsxw.nxv8i64.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], <vscale x 8 x i64> [[INDEX]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsxw_v_u64m8(uint64_t *base, vuint64m8_t index, vuint64m8_t value, size_t vl) {
  return __riscv_vsxw_v_u64m8(base, index, value, vl);
}
