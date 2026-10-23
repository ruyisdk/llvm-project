// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i4_1x8_t mixed_0(__riscv_ztt_i4_1x8_t old, __riscv_ztt_i16_1x8_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_i4_1x8(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_0(
// CHECK-SAME: target("riscv.ztt.m.i4", i4, 4, 1, 8) %[[V0_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 8) %[[V0_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 8) %[[V0_0]], target("riscv.ztt.m.i16", i16, 16, 1, 8) %[[V0_1]], i{{32|64}} %{{[^ ,)]+}}, i32 1073741828, i32 1073741832, i32 8)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 1, 8)
__riscv_ztt_u4_8x1_t mixed_1(__riscv_ztt_u4_8x1_t old, __riscv_ztt_i16_8x1_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_u4_8x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_1(
// CHECK-SAME: target("riscv.ztt.m.u4", i4, 4, 8, 1) %[[V1_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 8, 1) %[[V1_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.u4", i4, 4, 8, 1) %[[V1_0]], target("riscv.ztt.m.i16", i16, 16, 8, 1) %[[V1_1]], i{{32|64}} %{{[^ ,)]+}}, i32 4, i32 16, i32 8)
// CHECK: ret target("riscv.ztt.m.u4", i4, 4, 8, 1)
__riscv_ztt_i8_1x4_t mixed_2(__riscv_ztt_i8_1x4_t old, __riscv_ztt_i16_1x4_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_i8_1x4(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_2(
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[V2_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 4) %[[V2_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[V2_0]], target("riscv.ztt.m.i16", i16, 16, 1, 4) %[[V2_1]], i{{32|64}} %{{[^ ,)]+}}, i32 1073741832, i32 338690320, i32 4)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 4)
__riscv_ztt_u8_4x1_t mixed_3(__riscv_ztt_u8_4x1_t old, __riscv_ztt_i16_4x1_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_u8_4x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_3(
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[V3_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 4, 1) %[[V3_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[V3_0]], target("riscv.ztt.m.i16", i16, 16, 4, 1) %[[V3_1]], i{{32|64}} %{{[^ ,)]+}}, i32 8, i32 540016912, i32 4)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 4, 1)
__riscv_ztt_i16_1x2_t mixed_4(__riscv_ztt_i16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_f32_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_i16_1x2(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_4(
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V4_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V4_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V4_0]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V4_1]], i{{32|64}} %{{[^ ,)]+}}, i32 1073741840, i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 2)
__riscv_ztt_u16_2x1_t mixed_5(__riscv_ztt_u16_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_u16_2x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_5(
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 2, 1) %[[V5_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V5_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.u16", i16, 16, 2, 1) %[[V5_0]], target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V5_1]], i{{32|64}} %{{[^ ,)]+}}, i32 16, i32 1073741832, i32 2)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 2, 1)
__riscv_ztt_i32_1x2_t mixed_6(__riscv_ztt_i32_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_i32_1x2(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_6(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 2) %[[V6_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V6_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 2) %[[V6_0]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V6_1]], i{{32|64}} %{{[^ ,)]+}}, i32 1073741856, i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 2)
__riscv_ztt_u32_2x1_t mixed_7(__riscv_ztt_u32_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_u32_2x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_7(
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 2, 1) %[[V7_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V7_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 2, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.u32", i32, 32, 2, 1) %[[V7_0]], target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V7_1]], i{{32|64}} %{{[^ ,)]+}}, i32 32, i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 2, 1)
__riscv_ztt_i64_1x2_t mixed_8(__riscv_ztt_i64_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_i64_1x2(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_8(
// CHECK-SAME: target("riscv.ztt.m.i64", i64, 64, 1, 2) %[[V8_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V8_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 2) %[[V8_0]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V8_1]], i{{32|64}} %{{[^ ,)]+}}, i32 1073741888, i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 2)
__riscv_ztt_u64_2x1_t mixed_9(__riscv_ztt_u64_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_f32_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_u64_2x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_9(
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 2, 1) %[[V9_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V9_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 2, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.u64", i64, 64, 2, 1) %[[V9_0]], target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V9_1]], i{{32|64}} %{{[^ ,)]+}}, i32 64, i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 2, 1)
__riscv_ztt_i128_1x2_t mixed_10(__riscv_ztt_i128_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_i128_1x2(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_10(
// CHECK-SAME: target("riscv.ztt.m.i128", i128, 128, 1, 2) %[[V10_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V10_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 2) %[[V10_0]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V10_1]], i{{32|64}} %{{[^ ,)]+}}, i32 1073741952, i32 1073741832, i32 2)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 2)
__riscv_ztt_u128_2x1_t mixed_11(__riscv_ztt_u128_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_u128_2x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_11(
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 2, 1) %[[V11_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V11_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 2, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.u128", i128, 128, 2, 1) %[[V11_0]], target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V11_1]], i{{32|64}} %{{[^ ,)]+}}, i32 128, i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 2, 1)
__riscv_ztt_f16_1x2_t mixed_12(__riscv_ztt_f16_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_f16_1x2(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_12(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 2) %[[V12_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V12_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 2) %[[V12_0]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V12_1]], i{{32|64}} %{{[^ ,)]+}}, i32 338690320, i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)
__riscv_ztt_bf16_2x1_t mixed_13(__riscv_ztt_bf16_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_bf16_2x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_13(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[V13_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V13_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[V13_0]], target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V13_1]], i{{32|64}} %{{[^ ,)]+}}, i32 540016912, i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 2, 1)
__riscv_ztt_f32_1x2_t mixed_14(__riscv_ztt_f32_1x2_t old, __riscv_ztt_i16_1x2_t s0, __riscv_ztt_f32_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_f32_1x2(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_14(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 2) %[[V14_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V14_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 2) %[[V14_0]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[V14_1]], i{{32|64}} %{{[^ ,)]+}}, i32 540016928, i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 2)
__riscv_ztt_f64_2x1_t mixed_15(__riscv_ztt_f64_2x1_t old, __riscv_ztt_i16_2x1_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mmuladd_ew_x_f64_2x1(old, s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_15(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 2, 1) %[[V15_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V15_1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mmuladd.ew.x{{.*}}(target("riscv.ztt.m.f64", double, 64, 2, 1) %[[V15_0]], target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[V15_1]], i{{32|64}} %{{[^ ,)]+}}, i32 741343552, i32 1073741832, i32 2)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 2, 1)
#ifdef __cplusplus
}
#endif
