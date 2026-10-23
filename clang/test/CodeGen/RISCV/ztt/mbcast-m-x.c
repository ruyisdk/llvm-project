// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i4_1x2_t test_0(__riscv_ztt_i8_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_i4_1x2(scalar); }
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 1073741828, i32 1073741832, i32 2)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 1, 2)
__riscv_ztt_u4_2x1_t test_1(__riscv_ztt_u16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_u4_2x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 2, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 4, i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.u4", i4, 4, 2, 1)
__riscv_ztt_i8_1x1_t test_2(__riscv_ztt_f16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_i8_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 1073741832, i32 338690320, i32 1)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 1)
__riscv_ztt_u8_1x1_t test_3(__riscv_ztt_bf16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_u8_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 8, i32 540016912, i32 1)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 1, 1)
__riscv_ztt_i16_1x1_t test_4(__riscv_ztt_f32_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_i16_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 1073741840, i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 1)
__riscv_ztt_u16_1x1_t test_5(__riscv_ztt_i8_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_u16_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 16, i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 1, 1)
__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_u16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_i32_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 1073741856, i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)
__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_f16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_u32_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 32, i32 338690320, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)
__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_bf16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_i64_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 1073741888, i32 540016912, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)
__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_f32_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_u64_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 64, i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)
__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_i8_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_i128_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 1073741952, i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)
__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_u16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_u128_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 128, i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)
__riscv_ztt_f16_1x1_t test_12(__riscv_ztt_f16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_f16_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 338690320, i32 338690320, i32 1)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 1)
__riscv_ztt_bf16_1x1_t test_13(__riscv_ztt_bf16_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_bf16_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 540016912, i32 540016912, i32 1)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1)
__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_f32_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_f32_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_14(
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 540016928, i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)
__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_i8_scalar_t scalar) { return __riscv_ztt_mbcast_m_x_f64_1x1(scalar); }
// CHECK-LABEL: define{{.*}} @test_15(
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mbcast.m.x{{.*}}(i{{32|64}} %{{[^ ,)]+}}, i32 741343552, i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)
#ifdef __cplusplus
}
#endif
