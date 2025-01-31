// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg7e32_v_f32m1x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE1:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE2:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE3:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE4:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE5:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE6:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } poison, <vscale x 2 x float> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP0]], <vscale x 2 x float> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP1]], <vscale x 2 x float> [[V_TUPLE_COERCE2]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP2]], <vscale x 2 x float> [[V_TUPLE_COERCE3]], 3
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP3]], <vscale x 2 x float> [[V_TUPLE_COERCE4]], 4
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP4]], <vscale x 2 x float> [[V_TUPLE_COERCE5]], 5
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP5]], <vscale x 2 x float> [[V_TUPLE_COERCE6]], 6
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 0
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 1
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 2
// CHECK-RV64-NEXT:    [[TMP10:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 3
// CHECK-RV64-NEXT:    [[TMP11:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 4
// CHECK-RV64-NEXT:    [[TMP12:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 5
// CHECK-RV64-NEXT:    [[TMP13:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 6
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg7e.nxv2f32.i64(<vscale x 2 x float> [[TMP7]], <vscale x 2 x float> [[TMP8]], <vscale x 2 x float> [[TMP9]], <vscale x 2 x float> [[TMP10]], <vscale x 2 x float> [[TMP11]], <vscale x 2 x float> [[TMP12]], <vscale x 2 x float> [[TMP13]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg7e32_v_f32m1x7(float *base, vfloat32m1x7_t v_tuple, size_t vl) {
  return __riscv_th_vsseg7e32_v_f32m1x7(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg7e32_v_i32m1x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE1:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE2:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE3:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE4:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE5:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE6:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP0]], <vscale x 2 x i32> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP1]], <vscale x 2 x i32> [[V_TUPLE_COERCE2]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[V_TUPLE_COERCE3]], 3
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP3]], <vscale x 2 x i32> [[V_TUPLE_COERCE4]], 4
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[V_TUPLE_COERCE5]], 5
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP5]], <vscale x 2 x i32> [[V_TUPLE_COERCE6]], 6
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 0
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 1
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 2
// CHECK-RV64-NEXT:    [[TMP10:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 3
// CHECK-RV64-NEXT:    [[TMP11:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 4
// CHECK-RV64-NEXT:    [[TMP12:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 5
// CHECK-RV64-NEXT:    [[TMP13:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 6
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg7e.nxv2i32.i64(<vscale x 2 x i32> [[TMP7]], <vscale x 2 x i32> [[TMP8]], <vscale x 2 x i32> [[TMP9]], <vscale x 2 x i32> [[TMP10]], <vscale x 2 x i32> [[TMP11]], <vscale x 2 x i32> [[TMP12]], <vscale x 2 x i32> [[TMP13]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg7e32_v_i32m1x7(int32_t *base, vint32m1x7_t v_tuple, size_t vl) {
  return __riscv_th_vsseg7e32_v_i32m1x7(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg7e32_v_u32m1x7
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE1:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE2:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE3:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE4:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE5:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE6:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP0]], <vscale x 2 x i32> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP1]], <vscale x 2 x i32> [[V_TUPLE_COERCE2]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[V_TUPLE_COERCE3]], 3
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP3]], <vscale x 2 x i32> [[V_TUPLE_COERCE4]], 4
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[V_TUPLE_COERCE5]], 5
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP5]], <vscale x 2 x i32> [[V_TUPLE_COERCE6]], 6
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 0
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 1
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 2
// CHECK-RV64-NEXT:    [[TMP10:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 3
// CHECK-RV64-NEXT:    [[TMP11:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 4
// CHECK-RV64-NEXT:    [[TMP12:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 5
// CHECK-RV64-NEXT:    [[TMP13:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 6
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg7e.nxv2i32.i64(<vscale x 2 x i32> [[TMP7]], <vscale x 2 x i32> [[TMP8]], <vscale x 2 x i32> [[TMP9]], <vscale x 2 x i32> [[TMP10]], <vscale x 2 x i32> [[TMP11]], <vscale x 2 x i32> [[TMP12]], <vscale x 2 x i32> [[TMP13]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg7e32_v_u32m1x7(uint32_t *base, vuint32m1x7_t v_tuple, size_t vl) {
  return __riscv_th_vsseg7e32_v_u32m1x7(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg7e32_v_f32m1x7_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE1:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE2:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE3:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE4:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE5:%.*]], <vscale x 2 x float> [[V_TUPLE_COERCE6:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } poison, <vscale x 2 x float> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP0]], <vscale x 2 x float> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP1]], <vscale x 2 x float> [[V_TUPLE_COERCE2]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP2]], <vscale x 2 x float> [[V_TUPLE_COERCE3]], 3
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP3]], <vscale x 2 x float> [[V_TUPLE_COERCE4]], 4
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP4]], <vscale x 2 x float> [[V_TUPLE_COERCE5]], 5
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP5]], <vscale x 2 x float> [[V_TUPLE_COERCE6]], 6
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 0
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 1
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 2
// CHECK-RV64-NEXT:    [[TMP10:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 3
// CHECK-RV64-NEXT:    [[TMP11:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 4
// CHECK-RV64-NEXT:    [[TMP12:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 5
// CHECK-RV64-NEXT:    [[TMP13:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[TMP6]], 6
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg7e.mask.nxv2f32.i64(<vscale x 2 x float> [[TMP7]], <vscale x 2 x float> [[TMP8]], <vscale x 2 x float> [[TMP9]], <vscale x 2 x float> [[TMP10]], <vscale x 2 x float> [[TMP11]], <vscale x 2 x float> [[TMP12]], <vscale x 2 x float> [[TMP13]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg7e32_v_f32m1x7_m(vbool32_t mask, float *base, vfloat32m1x7_t v_tuple, size_t vl) {
  return __riscv_th_vsseg7e32_v_f32m1x7_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg7e32_v_i32m1x7_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE1:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE2:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE3:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE4:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE5:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE6:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP0]], <vscale x 2 x i32> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP1]], <vscale x 2 x i32> [[V_TUPLE_COERCE2]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[V_TUPLE_COERCE3]], 3
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP3]], <vscale x 2 x i32> [[V_TUPLE_COERCE4]], 4
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[V_TUPLE_COERCE5]], 5
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP5]], <vscale x 2 x i32> [[V_TUPLE_COERCE6]], 6
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 0
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 1
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 2
// CHECK-RV64-NEXT:    [[TMP10:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 3
// CHECK-RV64-NEXT:    [[TMP11:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 4
// CHECK-RV64-NEXT:    [[TMP12:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 5
// CHECK-RV64-NEXT:    [[TMP13:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 6
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg7e.mask.nxv2i32.i64(<vscale x 2 x i32> [[TMP7]], <vscale x 2 x i32> [[TMP8]], <vscale x 2 x i32> [[TMP9]], <vscale x 2 x i32> [[TMP10]], <vscale x 2 x i32> [[TMP11]], <vscale x 2 x i32> [[TMP12]], <vscale x 2 x i32> [[TMP13]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg7e32_v_i32m1x7_m(vbool32_t mask, int32_t *base, vint32m1x7_t v_tuple, size_t vl) {
  return __riscv_th_vsseg7e32_v_i32m1x7_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg7e32_v_u32m1x7_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE1:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE2:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE3:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE4:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE5:%.*]], <vscale x 2 x i32> [[V_TUPLE_COERCE6:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } poison, <vscale x 2 x i32> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP0]], <vscale x 2 x i32> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP1]], <vscale x 2 x i32> [[V_TUPLE_COERCE2]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP2]], <vscale x 2 x i32> [[V_TUPLE_COERCE3]], 3
// CHECK-RV64-NEXT:    [[TMP4:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP3]], <vscale x 2 x i32> [[V_TUPLE_COERCE4]], 4
// CHECK-RV64-NEXT:    [[TMP5:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP4]], <vscale x 2 x i32> [[V_TUPLE_COERCE5]], 5
// CHECK-RV64-NEXT:    [[TMP6:%.*]] = insertvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP5]], <vscale x 2 x i32> [[V_TUPLE_COERCE6]], 6
// CHECK-RV64-NEXT:    [[TMP7:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 0
// CHECK-RV64-NEXT:    [[TMP8:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 1
// CHECK-RV64-NEXT:    [[TMP9:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 2
// CHECK-RV64-NEXT:    [[TMP10:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 3
// CHECK-RV64-NEXT:    [[TMP11:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 4
// CHECK-RV64-NEXT:    [[TMP12:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 5
// CHECK-RV64-NEXT:    [[TMP13:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[TMP6]], 6
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg7e.mask.nxv2i32.i64(<vscale x 2 x i32> [[TMP7]], <vscale x 2 x i32> [[TMP8]], <vscale x 2 x i32> [[TMP9]], <vscale x 2 x i32> [[TMP10]], <vscale x 2 x i32> [[TMP11]], <vscale x 2 x i32> [[TMP12]], <vscale x 2 x i32> [[TMP13]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg7e32_v_u32m1x7_m(vbool32_t mask, uint32_t *base, vuint32m1x7_t v_tuple, size_t vl) {
  return __riscv_th_vsseg7e32_v_u32m1x7_m(mask, base, v_tuple, vl);
}

