// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_i8m1(int8_t *base, vint8m1_t value, size_t vl) {
  return __riscv_th_vse8_v_i8m1(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_i8m2(int8_t *base, vint8m2_t value, size_t vl) {
  return __riscv_th_vse8_v_i8m2(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_i8m4(int8_t *base, vint8m4_t value, size_t vl) {
  return __riscv_th_vse8_v_i8m4(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_i8m8(int8_t *base, vint8m8_t value, size_t vl) {
  return __riscv_th_vse8_v_i8m8(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_u8m1(uint8_t *base, vuint8m1_t value, size_t vl) {
  return __riscv_th_vse8_v_u8m1(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_u8m2(uint8_t *base, vuint8m2_t value, size_t vl) {
  return __riscv_th_vse8_v_u8m2(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_u8m4(uint8_t *base, vuint8m4_t value, size_t vl) {
  return __riscv_th_vse8_v_u8m4(base, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vse8_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vse.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vse8_v_u8m8(uint8_t *base, vuint8m8_t value, size_t vl) {
  return __riscv_th_vse8_v_u8m8(base, value, vl);
}
