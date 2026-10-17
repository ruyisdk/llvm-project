// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

__riscv_ztt_i4_1x8_t test_0(__riscv_ztt_i4_1x8_t a, signed char value) {
  __riscv_ztt_i8_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_i4_1x8(a, s);
}
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: target("riscv.ztt.m.i4", i4, 4, 1, 8) %[[A0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 8) %[[A0]], i{{32|64}} %{{[^ ,]+}}, i32 1073741828, i32 1073741832, i32 8)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 1, 8)

__riscv_ztt_u4_8x1_t test_1(__riscv_ztt_u4_8x1_t a, unsigned short value) {
  __riscv_ztt_u16_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_u4_8x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: target("riscv.ztt.m.u4", i4, 4, 8, 1) %[[A1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.u4", i4, 4, 8, 1) %[[A1]], i{{32|64}} %{{[^ ,]+}}, i32 4, i32 16, i32 8)
// CHECK: ret target("riscv.ztt.m.u4", i4, 4, 8, 1)

__riscv_ztt_i8_1x4_t test_2(__riscv_ztt_i8_1x4_t a, float value) {
  __riscv_ztt_f32_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_i8_1x4(a, s);
}
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[A2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[A2]], i{{32|64}} %{{[^ ,]+}}, i32 1073741832, i32 540016928, i32 4)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 4)

__riscv_ztt_u8_4x1_t test_3(__riscv_ztt_u8_4x1_t a, signed char value) {
  __riscv_ztt_i8_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_u8_4x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[A3:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[A3]], i{{32|64}} %{{[^ ,]+}}, i32 8, i32 1073741832, i32 4)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 4, 1)

__riscv_ztt_i16_1x2_t test_4(__riscv_ztt_i16_1x2_t a, unsigned short value) {
  __riscv_ztt_u16_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_i16_1x2(a, s);
}
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[A4:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[A4]], i{{32|64}} %{{[^ ,]+}}, i32 1073741840, i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 2)

__riscv_ztt_u16_2x1_t test_5(__riscv_ztt_u16_2x1_t a, float value) {
  __riscv_ztt_f32_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_u16_2x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 2, 1) %[[A5:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.u16", i16, 16, 2, 1) %[[A5]], i{{32|64}} %{{[^ ,]+}}, i32 16, i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 2, 1)

__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_i32_1x1_t a, signed char value) {
  __riscv_ztt_i8_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_i32_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[A6:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[A6]], i{{32|64}} %{{[^ ,]+}}, i32 1073741856, i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)

__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_u32_1x1_t a, unsigned short value) {
  __riscv_ztt_u16_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_u32_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[A7:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[A7]], i{{32|64}} %{{[^ ,]+}}, i32 32, i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)

__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_i64_1x1_t a, float value) {
  __riscv_ztt_f32_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_i64_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[A8:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[A8]], i{{32|64}} %{{[^ ,]+}}, i32 1073741888, i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)

__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_u64_1x1_t a, signed char value) {
  __riscv_ztt_i8_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_u64_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[A9:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[A9]], i{{32|64}} %{{[^ ,]+}}, i32 64, i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)

__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_i128_1x1_t a, unsigned short value) {
  __riscv_ztt_u16_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_i128_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[A10:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[A10]], i{{32|64}} %{{[^ ,]+}}, i32 1073741952, i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)

__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_u128_1x1_t a, float value) {
  __riscv_ztt_f32_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_u128_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[A11:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[A11]], i{{32|64}} %{{[^ ,]+}}, i32 128, i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)

__riscv_ztt_f16_1x2_t test_12(__riscv_ztt_f16_1x2_t a, signed char value) {
  __riscv_ztt_i8_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_f16_1x2(a, s);
}
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 2) %[[A12:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 2) %[[A12]], i{{32|64}} %{{[^ ,]+}}, i32 338690320, i32 1073741832, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_bf16_2x1_t test_13(__riscv_ztt_bf16_2x1_t a, unsigned short value) {
  __riscv_ztt_u16_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_bf16_2x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[A13:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[A13]], i{{32|64}} %{{[^ ,]+}}, i32 540016912, i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 2, 1)

__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_f32_1x1_t a, float value) {
  __riscv_ztt_f32_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_f32_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_14(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[A14:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[A14]], i{{32|64}} %{{[^ ,]+}}, i32 540016928, i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)

__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_f64_1x1_t a, signed char value) {
  __riscv_ztt_i8_scalar_t s = value;
  return __riscv_ztt_mmax_ew_x_f64_1x1(a, s);
}
// CHECK-LABEL: define{{.*}} @test_15(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 1) %[[A15:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mmax.ew.x{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %[[A15]], i{{32|64}} %{{[^ ,]+}}, i32 741343552, i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)
#ifdef __cplusplus
}
#endif
