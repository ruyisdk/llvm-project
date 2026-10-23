// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i8_1x1_t test_2(__riscv_ztt_i8_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u8_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_i8_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 1, 1) %[[V2_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V2_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 1, 1) %[[V2_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 1) %[[V2_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V2_1]], target("riscv.ztt.m.u8", i8, 8, 1, 1) %[[V2_2]], i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 1)
__riscv_ztt_u8_1x1_t test_3(__riscv_ztt_u8_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u8_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_u8_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 1, 1) %[[V3_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V3_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 1, 1) %[[V3_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.u8", i8, 8, 1, 1) %[[V3_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V3_1]], target("riscv.ztt.m.u8", i8, 8, 1, 1) %[[V3_2]], i32 8, i32 1)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 1, 1)
__riscv_ztt_i16_1x1_t test_4(__riscv_ztt_i16_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u16_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_i16_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 1) %[[V4_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V4_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V4_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 1) %[[V4_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V4_1]], target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V4_2]], i32 1073741840, i32 1)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 1)
__riscv_ztt_u16_1x1_t test_5(__riscv_ztt_u16_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u16_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_u16_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V5_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V5_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V5_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V5_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V5_1]], target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V5_2]], i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 1, 1)
__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_i32_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u32_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_i32_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V6_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V6_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V6_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V6_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V6_1]], target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V6_2]], i32 1073741856, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)
__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_u32_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u32_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_u32_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V7_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V7_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V7_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V7_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V7_1]], target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V7_2]], i32 32, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)
__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_i64_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u64_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_i64_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[V8_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V8_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V8_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[V8_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V8_1]], target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V8_2]], i32 1073741888, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)
__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_u64_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u64_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_u64_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V9_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V9_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V9_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V9_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V9_1]], target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V9_2]], i32 64, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)
__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_i128_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u128_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_i128_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[V10_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V10_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[V10_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[V10_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V10_1]], target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[V10_2]], i32 1073741952, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)
__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_u128_1x1_t old, __riscv_ztt_f32_1x1_t s0, __riscv_ztt_u128_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_u128_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[V11_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V11_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[V11_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[V11_0]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V11_1]], target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[V11_2]], i32 128, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)
__riscv_ztt_f16_1x1_t test_12(__riscv_ztt_f16_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_u16_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_f16_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 1) %[[V12_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V12_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V12_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 1) %[[V12_0]], target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V12_1]], target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V12_2]], i32 338690320, i32 1)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 1)
__riscv_ztt_bf16_1x1_t test_13(__riscv_ztt_bf16_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_u16_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_bf16_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %[[V13_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V13_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V13_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %[[V13_0]], target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V13_1]], target("riscv.ztt.m.u16", i16, 16, 1, 1) %[[V13_2]], i32 540016912, i32 1)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1)
__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_f32_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_u32_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_f32_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_14(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V14_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V14_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V14_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V14_0]], target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V14_1]], target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[V14_2]], i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)
__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_f64_1x1_t old, __riscv_ztt_i32_1x1_t s0, __riscv_ztt_u64_1x1_t s1) { return __riscv_ztt_mcolscatmax_ew_f64_1x1(old, s0, s1); }
// CHECK-LABEL: define{{.*}} @test_15(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 1) %[[V15_0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V15_1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V15_2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolscatmax.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %[[V15_0]], target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V15_1]], target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[V15_2]], i32 741343552, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)
#ifdef __cplusplus
}
#endif
