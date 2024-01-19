// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e8_v_i8m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[TUPLE0:%.*]], <vscale x 8 x i8> [[TUPLE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } poison, <vscale x 8 x i8> [[TUPLE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP0]], <vscale x 8 x i8> [[TUPLE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv8i8.i64(<vscale x 8 x i8> [[TMP2]], <vscale x 8 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e8_v_i8m1x2(int8_t *base, vint8m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e8_v_i8m1x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e8_v_i8m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[TUPLE0:%.*]], <vscale x 16 x i8> [[TUPLE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } poison, <vscale x 16 x i8> [[TUPLE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], <vscale x 16 x i8> [[TUPLE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv16i8.i64(<vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e8_v_i8m2x2(int8_t *base, vint8m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e8_v_i8m2x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e8_v_i8m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[TUPLE0:%.*]], <vscale x 32 x i8> [[TUPLE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } poison, <vscale x 32 x i8> [[TUPLE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP0]], <vscale x 32 x i8> [[TUPLE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv32i8.i64(<vscale x 32 x i8> [[TMP2]], <vscale x 32 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e8_v_i8m4x2(int8_t *base, vint8m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e8_v_i8m4x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e8_v_u8m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 8 x i8> [[TUPLE0:%.*]], <vscale x 8 x i8> [[TUPLE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } poison, <vscale x 8 x i8> [[TUPLE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP0]], <vscale x 8 x i8> [[TUPLE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv8i8.i64(<vscale x 8 x i8> [[TMP2]], <vscale x 8 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e8_v_u8m1x2(uint8_t *base, vuint8m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e8_v_u8m1x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e8_v_u8m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 16 x i8> [[TUPLE0:%.*]], <vscale x 16 x i8> [[TUPLE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } poison, <vscale x 16 x i8> [[TUPLE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP0]], <vscale x 16 x i8> [[TUPLE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv16i8.i64(<vscale x 16 x i8> [[TMP2]], <vscale x 16 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e8_v_u8m2x2(uint8_t *base, vuint8m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e8_v_u8m2x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e8_v_u8m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 32 x i8> [[TUPLE0:%.*]], <vscale x 32 x i8> [[TUPLE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } poison, <vscale x 32 x i8> [[TUPLE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP0]], <vscale x 32 x i8> [[TUPLE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv32i8.i64(<vscale x 32 x i8> [[TMP2]], <vscale x 32 x i8> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e8_v_u8m4x2(uint8_t *base, vuint8m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e8_v_u8m4x2(base, v_tuple, vl);
}
