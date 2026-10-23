// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

__riscv_ztt_i32_1x2_t test_i32(__riscv_ztt_i32_1x2_t src) {
  return __riscv_ztt_mrowzip_ew_i32_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_i32(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mrowzip.ew{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 2) %{{[^ ,)]+}}, i32 1073741856, i32 2)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 2)

__riscv_ztt_f32_1x2_t test_f32(__riscv_ztt_f32_1x2_t src) {
  return __riscv_ztt_mrowzip_ew_f32_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_f32(
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mrowzip.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 2) %{{[^ ,)]+}}, i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 2)

__riscv_ztt_u64_1x2_t test_u64(__riscv_ztt_u64_1x2_t src) {
  return __riscv_ztt_mrowzip_ew_u64_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_u64(
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 2) @llvm.riscv.ztt.mrowzip.ew{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 2) %{{[^ ,)]+}}, i32 64, i32 2)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 2)

#ifdef __cplusplus
}
#endif
