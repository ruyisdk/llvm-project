// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i4_1x8_t test_0(__riscv_ztt_u4_1x8_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_i4_1x8(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: target("riscv.ztt.m.u4", i4, 4, 1, 8) %[[A0:[^ ,)]+]], i{{32|64}} noundef %[[B0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.u4", i4, 4, 1, 8) %[[A0]], i{{32|64}} %[[B0]], i32 1073741828, i32 8)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 1, 8)
__riscv_ztt_u4_8x1_t test_1(__riscv_ztt_i4_8x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u4_8x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: target("riscv.ztt.m.i4", i4, 4, 8, 1) %[[A1:[^ ,)]+]], i{{32|64}} noundef %[[B1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i4", i4, 4, 8, 1) %[[A1]], i{{32|64}} %[[B1]], i32 4, i32 8)
// CHECK: ret target("riscv.ztt.m.u4", i4, 4, 8, 1)
__riscv_ztt_i8_1x4_t test_2(__riscv_ztt_u8_1x4_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_i8_1x4(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 1, 4) %[[A2:[^ ,)]+]], i{{32|64}} noundef %[[B2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.u8", i8, 8, 1, 4) %[[A2]], i{{32|64}} %[[B2]], i32 1073741832, i32 4)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 4)
__riscv_ztt_u8_4x1_t test_3(__riscv_ztt_i8_4x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u8_4x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 4, 1) %[[A3:[^ ,)]+]], i{{32|64}} noundef %[[B3:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i8", i8, 8, 4, 1) %[[A3]], i{{32|64}} %[[B3]], i32 8, i32 4)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 4, 1)
__riscv_ztt_i16_1x2_t test_4(__riscv_ztt_u16_1x2_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_i16_1x2(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 1, 2) %[[A4:[^ ,)]+]], i{{32|64}} noundef %[[B4:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.u16", i16, 16, 1, 2) %[[A4]], i{{32|64}} %[[B4]], i32 1073741840, i32 2)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 2)
__riscv_ztt_u16_2x1_t test_5(__riscv_ztt_i16_2x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u16_2x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[A5:[^ ,)]+]], i{{32|64}} noundef %[[B5:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i16", i16, 16, 2, 1) %[[A5]], i{{32|64}} %[[B5]], i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 2, 1)
__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_u32_1x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_i32_1x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[A6:[^ ,)]+]], i{{32|64}} noundef %[[B6:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[A6]], i{{32|64}} %[[B6]], i32 1073741856, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)
__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_i32_1x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u32_1x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[A7:[^ ,)]+]], i{{32|64}} noundef %[[B7:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[A7]], i{{32|64}} %[[B7]], i32 32, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)
__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_u64_1x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_i64_1x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[A8:[^ ,)]+]], i{{32|64}} noundef %[[B8:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[A8]], i{{32|64}} %[[B8]], i32 1073741888, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)
__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_i64_1x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u64_1x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[A9:[^ ,)]+]], i{{32|64}} noundef %[[B9:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[A9]], i{{32|64}} %[[B9]], i32 64, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)
__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_u128_1x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_i128_1x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[A10:[^ ,)]+]], i{{32|64}} noundef %[[B10:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[A10]], i{{32|64}} %[[B10]], i32 1073741952, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)
__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_i128_1x1_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u128_1x1(a, sh);
}
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[A11:[^ ,)]+]], i{{32|64}} noundef %[[B11:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[A11]], i{{32|64}} %[[B11]], i32 128, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)
__riscv_ztt_i32_1x1_t trunc_control(__riscv_ztt_i32_1x1_t a) {
  return __riscv_ztt_msrl_ew_x_i32_1x1(a, 4294967297ULL);
}
// CHECK-LABEL: @trunc_control(
// RV32: @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^,]+}}, i32 1, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^,]+}}, i64 4294967297, i32 1073741856, i32 1)
// A signed C constant is converted to size_t before lowering.
__riscv_ztt_i32_1x1_t negative_control(__riscv_ztt_i32_1x1_t a) {
  return __riscv_ztt_msrl_ew_x_i32_1x1(a, -1);
}
// CHECK-LABEL: @negative_control(
// CHECK: @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^,]+}}, i{{32|64}} -1, i32 1073741856, i32 1)
__riscv_ztt_u16_1x2_t mixed_widths(__riscv_ztt_i32_1x2_t a, size_t sh) {
  return __riscv_ztt_msrl_ew_x_u16_1x2(a, sh);
}
// CHECK-LABEL: @mixed_widths(
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.msrl.ew.x{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 2) %{{[^,]+}}, i{{32|64}} %{{[^,]+}}, i32 16, i32 2)

#ifdef __cplusplus
}
#endif
