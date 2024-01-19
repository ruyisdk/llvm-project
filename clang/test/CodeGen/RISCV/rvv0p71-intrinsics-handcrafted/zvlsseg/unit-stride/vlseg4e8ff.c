// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } @test_th_vlseg4e8ff_v_i8m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } @llvm.riscv.th.vlseg4eff.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> poison, <vscale x 8 x i8> poison, <vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } poison, <vscale x 8 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP2]], <vscale x 8 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP4]], <vscale x 8 x i8> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP6]], <vscale x 8 x i8> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP8]]
//
vint8m1x4_t test_th_vlseg4e8ff_v_i8m1x4(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg4e8ff_v_i8m1x4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @test_th_vlseg4e8ff_v_i8m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } @llvm.riscv.th.vlseg4eff.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> poison, <vscale x 16 x i8> poison, <vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } poison, <vscale x 16 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP2]], <vscale x 16 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP4]], <vscale x 16 x i8> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP6]], <vscale x 16 x i8> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP8]]
//
vint8m2x4_t test_th_vlseg4e8ff_v_i8m2x4(const int8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg4e8ff_v_i8m2x4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } @test_th_vlseg4e8ff_v_u8m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } @llvm.riscv.th.vlseg4eff.nxv8i8.i64(<vscale x 8 x i8> poison, <vscale x 8 x i8> poison, <vscale x 8 x i8> poison, <vscale x 8 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } poison, <vscale x 8 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP2]], <vscale x 8 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP4]], <vscale x 8 x i8> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP6]], <vscale x 8 x i8> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> } [[TMP8]]
//
vuint8m1x4_t test_th_vlseg4e8ff_v_u8m1x4(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg4e8ff_v_u8m1x4(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } @test_th_vlseg4e8ff_v_u8m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } @llvm.riscv.th.vlseg4eff.nxv16i8.i64(<vscale x 16 x i8> poison, <vscale x 16 x i8> poison, <vscale x 16 x i8> poison, <vscale x 16 x i8> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } poison, <vscale x 16 x i8> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP2]], <vscale x 16 x i8> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP4]], <vscale x 16 x i8> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = insertvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP6]], <vscale x 16 x i8> [[TMP7]], 3
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i64 } [[TMP0]], 4
// CHECK-RV64-NEXT:    store i64 [[TMP9]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> } [[TMP8]]
//
vuint8m2x4_t test_th_vlseg4e8ff_v_u8m2x4(const uint8_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg4e8ff_v_u8m2x4(base, new_vl, vl);
}
