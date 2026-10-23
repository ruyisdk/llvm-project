// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i4_1x2_t test_0(__riscv_ztt_f32_1x2_t s0) { return __riscv_ztt_mprefixmax_row_i4_1x2(s0); }
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 2) %[[V0_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 2) %[[V0_0]], i32 1073741828, i32 2)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 1, 2)
__riscv_ztt_u4_2x1_t test_1(__riscv_ztt_f32_2x1_t s0) { return __riscv_ztt_mprefixmax_row_u4_2x1(s0); }
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 2, 1) %[[V1_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 2, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 2, 1) %[[V1_0]], i32 4, i32 2)
// CHECK: ret target("riscv.ztt.m.u4", i4, 4, 2, 1)
__riscv_ztt_i8_1x1_t test_2(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_i8_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V2_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V2_0]], i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 1)
__riscv_ztt_u8_1x1_t test_3(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_u8_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V3_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V3_0]], i32 8, i32 1)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 1, 1)
__riscv_ztt_i16_1x1_t test_4(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_i16_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V4_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V4_0]], i32 1073741840, i32 1)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 1)
__riscv_ztt_u16_1x1_t test_5(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_u16_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V5_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V5_0]], i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 1, 1)
__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_i32_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V6_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V6_0]], i32 1073741856, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)
__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_u32_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V7_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V7_0]], i32 32, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)
__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_i64_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V8_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V8_0]], i32 1073741888, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)
__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_u64_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V9_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V9_0]], i32 64, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)
__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_i128_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V10_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V10_0]], i32 1073741952, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)
__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_f32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_u128_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V11_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[V11_0]], i32 128, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)
__riscv_ztt_f16_1x1_t test_12(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_f16_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V12_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V12_0]], i32 338690320, i32 1)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 1)
__riscv_ztt_bf16_1x1_t test_13(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_bf16_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V13_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V13_0]], i32 540016912, i32 1)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1)
__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_f32_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_14(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V14_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V14_0]], i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)
__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_i32_1x1_t s0) { return __riscv_ztt_mprefixmax_row_f64_1x1(s0); }
// CHECK-LABEL: define{{.*}} @test_15(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V15_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mprefixmax.row{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[V15_0]], i32 741343552, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)
#ifdef __cplusplus
}
#endif
