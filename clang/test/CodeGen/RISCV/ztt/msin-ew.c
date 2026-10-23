// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

__riscv_ztt_f16_1x2_t test_0(__riscv_ztt_f16_1x2_t src) {
  return __riscv_ztt_msin_ew_f16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC0:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC0]], i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_bf16_2x1_t test_1(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_msin_ew_bf16_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC1:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC1]], i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 2, 1)

__riscv_ztt_f32_1x1_t test_2(__riscv_ztt_f32_1x1_t src) {
  return __riscv_ztt_msin_ew_f32_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC2:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC2]], i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)

__riscv_ztt_f64_1x1_t test_3(__riscv_ztt_f64_1x1_t src) {
  return __riscv_ztt_msin_ew_f64_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 1) %[[SRC3:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %[[SRC3]], i32 741343552, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)

__riscv_ztt_bf16_1x2_t test_4(__riscv_ztt_f32_1x2_t src) {
  return __riscv_ztt_msin_ew_bf16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 2) %[[SRC4:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 2) %[[SRC4]], i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2)

__riscv_ztt_f64_2x1_t test_5(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_msin_ew_f64_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC5:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC5]], i32 741343552, i32 2)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 2, 1)

__riscv_ztt_f16_1x2_t test_6(__riscv_ztt_f64_1x2_t src) {
  return __riscv_ztt_msin_ew_f16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 2) %[[SRC6:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 2) %[[SRC6]], i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_f32_2x1_t test_7(__riscv_ztt_f16_2x1_t src) {
  return __riscv_ztt_msin_ew_f32_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 2, 1) %[[SRC7:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 2, 1) %[[SRC7]], i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 2, 1)

__riscv_ztt_bf16_1x2_t test_8(__riscv_ztt_f16_1x2_t src) {
  return __riscv_ztt_msin_ew_bf16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC8:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC8]], i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2)

__riscv_ztt_f64_2x1_t test_9(__riscv_ztt_f16_2x1_t src) {
  return __riscv_ztt_msin_ew_f64_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 2, 1) %[[SRC9:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 2, 1) %[[SRC9]], i32 741343552, i32 2)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 2, 1)

__riscv_ztt_f16_1x2_t test_10(__riscv_ztt_bf16_1x2_t src) {
  return __riscv_ztt_msin_ew_f16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %[[SRC10:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %[[SRC10]], i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_f32_2x1_t test_11(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_msin_ew_f32_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC11:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC11]], i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 2, 1)

__riscv_ztt_f16_1x2_t test_12(__riscv_ztt_f32_1x2_t src) {
  return __riscv_ztt_msin_ew_f16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 2) %[[SRC12:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 2) %[[SRC12]], i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_f64_1x1_t test_13(__riscv_ztt_f32_1x1_t src) {
  return __riscv_ztt_msin_ew_f64_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC13:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC13]], i32 741343552, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)

__riscv_ztt_bf16_1x2_t test_14(__riscv_ztt_f64_1x2_t src) {
  return __riscv_ztt_msin_ew_bf16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_14(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 2) %[[SRC14:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 2) %[[SRC14]], i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2)

__riscv_ztt_f32_1x1_t test_15(__riscv_ztt_f64_1x1_t src) {
  return __riscv_ztt_msin_ew_f32_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_15(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 1) %[[SRC15:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.msin.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %[[SRC15]], i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)
#ifdef __cplusplus
}
#endif
