// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x i8>, <vscale x 8 x i8> } @test_th_vlseg2e8ff_v_i8m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } @llvm.riscv.th.vlseg2eff.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } poison, <vscale x 8 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP2]], <vscale x 8 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    store i64 [[TMP5]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP4]]
//
vint8m1x2_t test_th_vlseg2e8ff_v_i8m1x2(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg2e8ff_v_i8m1x2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x i8>, <vscale x 16 x i8> } @test_th_vlseg2e8ff_v_i8m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } @llvm.riscv.th.vlseg2eff.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } poison, <vscale x 16 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP2]], <vscale x 16 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    store i64 [[TMP5]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP4]]
//
vint8m2x2_t test_th_vlseg2e8ff_v_i8m2x2(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg2e8ff_v_i8m2x2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 32 x i8>, <vscale x 32 x i8> } @test_th_vlseg2e8ff_v_i8m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } @llvm.riscv.th.vlseg2eff.nxv32i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } poison, <vscale x 32 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP2]], <vscale x 32 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    store i64 [[TMP5]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP4]]
//
vint8m4x2_t test_th_vlseg2e8ff_v_i8m4x2(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg2e8ff_v_i8m4x2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x i8>, <vscale x 8 x i8> } @test_th_vlseg2e8ff_v_u8m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } @llvm.riscv.th.vlseg2eff.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } poison, <vscale x 8 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP2]], <vscale x 8 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    store i64 [[TMP5]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP4]]
//
vuint8m1x2_t test_th_vlseg2e8ff_v_u8m1x2(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg2e8ff_v_u8m1x2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x i8>, <vscale x 16 x i8> } @test_th_vlseg2e8ff_v_u8m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } @llvm.riscv.th.vlseg2eff.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } poison, <vscale x 16 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP2]], <vscale x 16 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    store i64 [[TMP5]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP4]]
//
vuint8m2x2_t test_th_vlseg2e8ff_v_u8m2x2(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg2e8ff_v_u8m2x2(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 32 x i8>, <vscale x 32 x i8> } @test_th_vlseg2e8ff_v_u8m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } @llvm.riscv.th.vlseg2eff.nxv32i8.i64(<vscale x 32 x i8> poison, <vscale x 32 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } poison, <vscale x 32 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP2]], <vscale x 32 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    store i64 [[TMP5]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 32 x i8>, <vscale x 32 x i8> } [[TMP4]]
//
vuint8m4x2_t test_th_vlseg2e8ff_v_u8m4x2(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg2e8ff_v_u8m4x2(base, new_vl, vl);
}
