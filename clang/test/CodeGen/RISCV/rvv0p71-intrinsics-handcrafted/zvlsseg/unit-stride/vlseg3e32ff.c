// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } @test_th_vlseg3e32ff_v_f32m1x3
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } @llvm.riscv.th.vlseg3eff.nxv2f32.i64(<vscale x 2 x float> poison, <vscale x 2 x float> poison, <vscale x 2 x float> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } poison, <vscale x 2 x float> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP2]], <vscale x 2 x float> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP4]], <vscale x 2 x float> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    store i64 [[TMP7]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]]
//
vfloat32m1x3_t test_th_vlseg3e32ff_v_f32m1x3(const float *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg3e32ff_v_f32m1x3(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } @test_th_vlseg3e32ff_v_f32m2x3
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } @llvm.riscv.th.vlseg3eff.nxv4f32.i64(<vscale x 4 x float> poison, <vscale x 4 x float> poison, <vscale x 4 x float> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } poison, <vscale x 4 x float> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP2]], <vscale x 4 x float> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP4]], <vscale x 4 x float> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    store i64 [[TMP7]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[TMP6]]
//
vfloat32m2x3_t test_th_vlseg3e32ff_v_f32m2x3(const float *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg3e32ff_v_f32m2x3(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @test_th_vlseg3e32ff_v_i32m1x3
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } @llvm.riscv.th.vlseg3eff.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> poison, <vscale x 2 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    store i64 [[TMP7]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]]
//
vint32m1x3_t test_th_vlseg3e32ff_v_i32m1x3(const int32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg3e32ff_v_i32m1x3(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @test_th_vlseg3e32ff_v_i32m2x3
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } @llvm.riscv.th.vlseg3eff.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> poison, <vscale x 4 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } poison, <vscale x 4 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP2]], <vscale x 4 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP4]], <vscale x 4 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    store i64 [[TMP7]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP6]]
//
vint32m2x3_t test_th_vlseg3e32ff_v_i32m2x3(const int32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg3e32ff_v_i32m2x3(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } @test_th_vlseg3e32ff_v_u32m1x3
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } @llvm.riscv.th.vlseg3eff.nxv2i32.i64(<vscale x 2 x i32> poison, <vscale x 2 x i32> poison, <vscale x 2 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    store i64 [[TMP7]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]]
//
vuint32m1x3_t test_th_vlseg3e32ff_v_u32m1x3(const uint32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg3e32ff_v_u32m1x3(base, new_vl, vl);
}

// CHECK-RV64-LABEL: define dso_local { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } @test_th_vlseg3e32ff_v_u32m2x3
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], ptr noundef [[NEW_VL:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = call { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } @llvm.riscv.th.vlseg3eff.nxv4i32.i64(<vscale x 4 x i32> poison, <vscale x 4 x i32> poison, <vscale x 4 x i32> poison, ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 0
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } poison, <vscale x 4 x i32> [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 1
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP2]], <vscale x 4 x i32> [[TMP3]], 1
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 2
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP4]], <vscale x 4 x i32> [[TMP5]], 2
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, i64 } [[TMP0]], 3
// CHECK-RV64-NEXT:    store i64 [[TMP7]], ptr [[NEW_VL]], align 8
// CHECK-RV64-NEXT:    ret { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[TMP6]]
//
vuint32m2x3_t test_th_vlseg3e32ff_v_u32m2x3(const uint32_t *base, size_t *new_vl, size_t vl) {
  return __riscv_th_vlseg3e32ff_v_u32m2x3(base, new_vl, vl);
}
