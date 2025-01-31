// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN:   -disable-O0-optnone -emit-llvm %s -o - | \
// RUN:   opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_f64m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x double> [[V_TUPLE_COERCE0:%.*]], <vscale x 1 x double> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 1 x double>, <vscale x 1 x double> } poison, <vscale x 1 x double> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP0]], <vscale x 1 x double> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv1f64.i64(<vscale x 1 x double> [[TMP2]], <vscale x 1 x double> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_f64m1x2(double *base, vfloat64m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_f64m1x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_f64m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x double> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x double> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x double>, <vscale x 2 x double> } poison, <vscale x 2 x double> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP0]], <vscale x 2 x double> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv2f64.i64(<vscale x 2 x double> [[TMP2]], <vscale x 2 x double> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_f64m2x2(double *base, vfloat64m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_f64m2x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_f64m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x double> [[V_TUPLE_COERCE0:%.*]], <vscale x 4 x double> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 4 x double>, <vscale x 4 x double> } poison, <vscale x 4 x double> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP0]], <vscale x 4 x double> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv4f64.i64(<vscale x 4 x double> [[TMP2]], <vscale x 4 x double> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_f64m4x2(double *base, vfloat64m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_f64m4x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_i64m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } poison, <vscale x 1 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP0]], <vscale x 1 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv1i64.i64(<vscale x 1 x i64> [[TMP2]], <vscale x 1 x i64> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_i64m1x2(int64_t *base, vint64m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_i64m1x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_i64m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } poison, <vscale x 2 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], <vscale x 2 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv2i64.i64(<vscale x 2 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_i64m2x2(int64_t *base, vint64m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_i64m2x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_i64m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } poison, <vscale x 4 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP0]], <vscale x 4 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv4i64.i64(<vscale x 4 x i64> [[TMP2]], <vscale x 4 x i64> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_i64m4x2(int64_t *base, vint64m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_i64m4x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_u64m1x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } poison, <vscale x 1 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP0]], <vscale x 1 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv1i64.i64(<vscale x 1 x i64> [[TMP2]], <vscale x 1 x i64> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_u64m1x2(uint64_t *base, vuint64m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_u64m1x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_u64m2x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } poison, <vscale x 2 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], <vscale x 2 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv2i64.i64(<vscale x 2 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_u64m2x2(uint64_t *base, vuint64m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_u64m2x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_u64m4x2
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } poison, <vscale x 4 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP0]], <vscale x 4 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.nxv4i64.i64(<vscale x 4 x i64> [[TMP2]], <vscale x 4 x i64> [[TMP3]], ptr [[BASE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_u64m4x2(uint64_t *base, vuint64m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_u64m4x2(base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_f64m1x2_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 1 x double> [[V_TUPLE_COERCE0:%.*]], <vscale x 1 x double> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 1 x double>, <vscale x 1 x double> } poison, <vscale x 1 x double> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP0]], <vscale x 1 x double> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x double>, <vscale x 1 x double> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv1f64.i64(<vscale x 1 x double> [[TMP2]], <vscale x 1 x double> [[TMP3]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_f64m1x2_m(vbool64_t mask, double *base, vfloat64m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_f64m1x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_f64m2x2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 2 x double> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x double> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x double>, <vscale x 2 x double> } poison, <vscale x 2 x double> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP0]], <vscale x 2 x double> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x double>, <vscale x 2 x double> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv2f64.i64(<vscale x 2 x double> [[TMP2]], <vscale x 2 x double> [[TMP3]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_f64m2x2_m(vbool32_t mask, double *base, vfloat64m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_f64m2x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_f64m4x2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 4 x double> [[V_TUPLE_COERCE0:%.*]], <vscale x 4 x double> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 4 x double>, <vscale x 4 x double> } poison, <vscale x 4 x double> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP0]], <vscale x 4 x double> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x double>, <vscale x 4 x double> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv4f64.i64(<vscale x 4 x double> [[TMP2]], <vscale x 4 x double> [[TMP3]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_f64m4x2_m(vbool16_t mask, double *base, vfloat64m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_f64m4x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_i64m1x2_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } poison, <vscale x 1 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP0]], <vscale x 1 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv1i64.i64(<vscale x 1 x i64> [[TMP2]], <vscale x 1 x i64> [[TMP3]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_i64m1x2_m(vbool64_t mask, int64_t *base, vint64m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_i64m1x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_i64m2x2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } poison, <vscale x 2 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], <vscale x 2 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv2i64.i64(<vscale x 2 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_i64m2x2_m(vbool32_t mask, int64_t *base, vint64m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_i64m2x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_i64m4x2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } poison, <vscale x 4 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP0]], <vscale x 4 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv4i64.i64(<vscale x 4 x i64> [[TMP2]], <vscale x 4 x i64> [[TMP3]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_i64m4x2_m(vbool16_t mask, int64_t *base, vint64m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_i64m4x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_u64m1x2_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 1 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } poison, <vscale x 1 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP0]], <vscale x 1 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i64>, <vscale x 1 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv1i64.i64(<vscale x 1 x i64> [[TMP2]], <vscale x 1 x i64> [[TMP3]], ptr [[BASE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_u64m1x2_m(vbool64_t mask, uint64_t *base, vuint64m1x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_u64m1x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_u64m2x2_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 2 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } poison, <vscale x 2 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP0]], <vscale x 2 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv2i64.i64(<vscale x 2 x i64> [[TMP2]], <vscale x 2 x i64> [[TMP3]], ptr [[BASE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_u64m2x2_m(vbool32_t mask, uint64_t *base, vuint64m2x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_u64m2x2_m(mask, base, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_th_vsseg2e64_v_u64m4x2_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE0:%.*]], <vscale x 4 x i64> [[V_TUPLE_COERCE1:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } poison, <vscale x 4 x i64> [[V_TUPLE_COERCE0]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = insertvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP0]], <vscale x 4 x i64> [[V_TUPLE_COERCE1]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 0
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i64> } [[TMP1]], 1
// CHECK-RV64-NEXT:    call void @llvm.riscv.th.vsseg2e.mask.nxv4i64.i64(<vscale x 4 x i64> [[TMP2]], <vscale x 4 x i64> [[TMP3]], ptr [[BASE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_th_vsseg2e64_v_u64m4x2_m(vbool16_t mask, uint64_t *base, vuint64m4x2_t v_tuple, size_t vl) {
  return __riscv_th_vsseg2e64_v_u64m4x2_m(mask, base, v_tuple, vl);
}

