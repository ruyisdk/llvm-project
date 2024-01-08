// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i8m1(int8_t *base, size_t stride, vint8m1_t value, size_t vl) {
  return __riscv_vssh_v_i8m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i8m2(int8_t *base, size_t stride, vint8m2_t value, size_t vl) {
  return __riscv_vssh_v_i8m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i8m4(int8_t *base, size_t stride, vint8m4_t value, size_t vl) {
  return __riscv_vssh_v_i8m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i8m8(int8_t *base, size_t stride, vint8m8_t value, size_t vl) {
  return __riscv_vssh_v_i8m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i16m1(int16_t *base, size_t stride, vint16m1_t value, size_t vl) {
  return __riscv_vssh_v_i16m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i16m2(int16_t *base, size_t stride, vint16m2_t value, size_t vl) {
  return __riscv_vssh_v_i16m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i16m4(int16_t *base, size_t stride, vint16m4_t value, size_t vl) {
  return __riscv_vssh_v_i16m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i16m8(int16_t *base, size_t stride, vint16m8_t value, size_t vl) {
  return __riscv_vssh_v_i16m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i32m1(int32_t *base, size_t stride, vint32m1_t value, size_t vl) {
  return __riscv_vssh_v_i32m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i32m2(int32_t *base, size_t stride, vint32m2_t value, size_t vl) {
  return __riscv_vssh_v_i32m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i32m4(int32_t *base, size_t stride, vint32m4_t value, size_t vl) {
  return __riscv_vssh_v_i32m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i32m8(int32_t *base, size_t stride, vint32m8_t value, size_t vl) {
  return __riscv_vssh_v_i32m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i64m1(int64_t *base, size_t stride, vint64m1_t value, size_t vl) {
  return __riscv_vssh_v_i64m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i64m2(int64_t *base, size_t stride, vint64m2_t value, size_t vl) {
  return __riscv_vssh_v_i64m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i64m4(int64_t *base, size_t stride, vint64m4_t value, size_t vl) {
  return __riscv_vssh_v_i64m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_i64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_i64m8(int64_t *base, size_t stride, vint64m8_t value, size_t vl) {
  return __riscv_vssh_v_i64m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u8m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i8.i64(<vscale x 8 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u8m1(uint8_t *base, size_t stride, vuint8m1_t value, size_t vl) {
  return __riscv_vssh_v_u8m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u8m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv16i8.i64(<vscale x 16 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u8m2(uint8_t *base, size_t stride, vuint8m2_t value, size_t vl) {
  return __riscv_vssh_v_u8m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u8m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 32 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv32i8.i64(<vscale x 32 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u8m4(uint8_t *base, size_t stride, vuint8m4_t value, size_t vl) {
  return __riscv_vssh_v_u8m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u8m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 64 x i8> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv64i8.i64(<vscale x 64 x i8> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u8m8(uint8_t *base, size_t stride, vuint8m8_t value, size_t vl) {
  return __riscv_vssh_v_u8m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv4i16.i64(<vscale x 4 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u16m1(uint16_t *base, size_t stride, vuint16m1_t value, size_t vl) {
  return __riscv_vssh_v_u16m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i16.i64(<vscale x 8 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u16m2(uint16_t *base, size_t stride, vuint16m2_t value, size_t vl) {
  return __riscv_vssh_v_u16m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv16i16.i64(<vscale x 16 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u16m4(uint16_t *base, size_t stride, vuint16m4_t value, size_t vl) {
  return __riscv_vssh_v_u16m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 32 x i16> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv32i16.i64(<vscale x 32 x i16> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u16m8(uint16_t *base, size_t stride, vuint16m8_t value, size_t vl) {
  return __riscv_vssh_v_u16m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u32m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv2i32.i64(<vscale x 2 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u32m1(uint32_t *base, size_t stride, vuint32m1_t value, size_t vl) {
  return __riscv_vssh_v_u32m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u32m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv4i32.i64(<vscale x 4 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u32m2(uint32_t *base, size_t stride, vuint32m2_t value, size_t vl) {
  return __riscv_vssh_v_u32m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u32m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i32.i64(<vscale x 8 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u32m4(uint32_t *base, size_t stride, vuint32m4_t value, size_t vl) {
  return __riscv_vssh_v_u32m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u32m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 16 x i32> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv16i32.i64(<vscale x 16 x i32> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u32m8(uint32_t *base, size_t stride, vuint32m8_t value, size_t vl) {
  return __riscv_vssh_v_u32m8(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u64m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 1 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv1i64.i64(<vscale x 1 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u64m1(uint64_t *base, size_t stride, vuint64m1_t value, size_t vl) {
  return __riscv_vssh_v_u64m1(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u64m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 2 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv2i64.i64(<vscale x 2 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u64m2(uint64_t *base, size_t stride, vuint64m2_t value, size_t vl) {
  return __riscv_vssh_v_u64m2(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u64m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 4 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv4i64.i64(<vscale x 4 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u64m4(uint64_t *base, size_t stride, vuint64m4_t value, size_t vl) {
  return __riscv_vssh_v_u64m4(base, stride, value, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vssh_v_u64m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[STRIDE:%.*]], <vscale x 8 x i64> [[VALUE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vssh.nxv8i64.i64(<vscale x 8 x i64> [[VALUE]], ptr [[BASE]], i64 [[STRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vssh_v_u64m8(uint64_t *base, size_t stride, vuint64m8_t value, size_t vl) {
  return __riscv_vssh_v_u64m8(base, stride, value, vl);
}
