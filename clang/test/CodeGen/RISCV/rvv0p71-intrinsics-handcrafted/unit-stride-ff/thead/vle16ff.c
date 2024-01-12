// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

typedef _Float16 float16_t;
typedef float float32_t;
typedef double float64_t;

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vle16ff_v_i16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i16>, i64 } @llvm.riscv.th.vleff.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP1]]
//
vint16m1_t test_th_vle16ff_v_i16m1(const int16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_i16m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vle16ff_v_i16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i16>, i64 } @llvm.riscv.th.vleff.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
vint16m2_t test_th_vle16ff_v_i16m2(const int16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_i16m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vle16ff_v_i16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i16>, i64 } @llvm.riscv.th.vleff.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP1]]
//
vint16m4_t test_th_vle16ff_v_i16m4(const int16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_i16m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vle16ff_v_i16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x i16>, i64 } @llvm.riscv.th.vleff.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP1]]
//
vint16m8_t test_th_vle16ff_v_i16m8(const int16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_i16m8(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x i16> @test_th_vle16ff_v_u16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i16>, i64 } @llvm.riscv.th.vleff.nxv4i16.i64(<vscale x 4 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 4 x i16> [[TMP1]]
//
vuint16m1_t test_th_vle16ff_v_u16m1(const uint16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_u16m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x i16> @test_th_vle16ff_v_u16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i16>, i64 } @llvm.riscv.th.vleff.nxv8i16.i64(<vscale x 8 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
vuint16m2_t test_th_vle16ff_v_u16m2(const uint16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_u16m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x i16> @test_th_vle16ff_v_u16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i16>, i64 } @llvm.riscv.th.vleff.nxv16i16.i64(<vscale x 16 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 16 x i16> [[TMP1]]
//
vuint16m4_t test_th_vle16ff_v_u16m4(const uint16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_u16m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x i16> @test_th_vle16ff_v_u16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x i16>, i64 } @llvm.riscv.th.vleff.nxv32i16.i64(<vscale x 32 x i16> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x i16>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x i16>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 32 x i16> [[TMP1]]
//
vuint16m8_t test_th_vle16ff_v_u16m8(const uint16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_u16m8(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 4 x half> @test_th_vle16ff_v_f16m1
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x half>, i64 } @llvm.riscv.th.vleff.nxv4f16.i64(<vscale x 4 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x half>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x half>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 4 x half> [[TMP1]]
//
vfloat16m1_t test_th_vle16ff_v_f16m1(const float16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_f16m1(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 8 x half> @test_th_vle16ff_v_f16m2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x half>, i64 } @llvm.riscv.th.vleff.nxv8f16.i64(<vscale x 8 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x half>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 8 x half>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 8 x half> [[TMP1]]
//
vfloat16m2_t test_th_vle16ff_v_f16m2(const float16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_f16m2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 16 x half> @test_th_vle16ff_v_f16m4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x half>, i64 } @llvm.riscv.th.vleff.nxv16f16.i64(<vscale x 16 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x half>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 16 x half>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 16 x half> [[TMP1]]
//
vfloat16m4_t test_th_vle16ff_v_f16m4(const float16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_f16m4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local <vscale x 32 x half> @test_th_vle16ff_v_f16m8
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x half>, i64 } @llvm.riscv.th.vleff.nxv32f16.i64(<vscale x 32 x half> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x half>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 32 x half>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    store i64 [[TMP2]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret <vscale x 32 x half> [[TMP1]]
//
vfloat16m8_t test_th_vle16ff_v_f16m8(const float16_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vle16ff_v_f16m8(base, new_vl, vl);
}
