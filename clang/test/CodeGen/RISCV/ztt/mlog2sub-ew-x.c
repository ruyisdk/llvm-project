// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_f16_1x2_t mixed_0(__riscv_ztt_bf16_1x2_t s0, __riscv_ztt_i8_scalar_t scalar) {
  return __riscv_ztt_mlog2sub_ew_x_f16_1x2(s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_0(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %[[V0_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mlog2sub.ew.x{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %[[V0_0]], i{{32|64}} %{{[^ ,)]+}}, i32 338690320, i32 1073741832, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)
__riscv_ztt_bf16_2x1_t mixed_1(__riscv_ztt_bf16_2x1_t s0, __riscv_ztt_u16_scalar_t scalar) {
  return __riscv_ztt_mlog2sub_ew_x_bf16_2x1(s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_1(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[V1_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mlog2sub.ew.x{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[V1_0]], i{{32|64}} %{{[^ ,)]+}}, i32 540016912, i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 2, 1)
__riscv_ztt_f32_1x2_t mixed_2(__riscv_ztt_bf16_1x2_t s0, __riscv_ztt_f16_scalar_t scalar) {
  return __riscv_ztt_mlog2sub_ew_x_f32_1x2(s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_2(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %[[V2_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mlog2sub.ew.x{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %[[V2_0]], i{{32|64}} %{{[^ ,)]+}}, i32 540016928, i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 2)
__riscv_ztt_f64_2x1_t mixed_3(__riscv_ztt_bf16_2x1_t s0, __riscv_ztt_bf16_scalar_t scalar) {
  return __riscv_ztt_mlog2sub_ew_x_f64_2x1(s0, scalar);
}
// CHECK-LABEL: define{{.*}} @mixed_3(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[V3_0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mlog2sub.ew.x{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[V3_0]], i{{32|64}} %{{[^ ,)]+}}, i32 741343552, i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 2, 1)
#ifdef __cplusplus
}
#endif
