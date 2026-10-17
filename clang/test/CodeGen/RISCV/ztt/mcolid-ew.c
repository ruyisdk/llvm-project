// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i8_1x1_t test_2(void) { return __riscv_ztt_mcolid_ew_i8_1x1(); }
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 1073741832, i32 1)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 1)
__riscv_ztt_u8_1x1_t test_3(void) { return __riscv_ztt_mcolid_ew_u8_1x1(); }
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 8, i32 1)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 1, 1)
__riscv_ztt_i16_1x1_t test_4(void) { return __riscv_ztt_mcolid_ew_i16_1x1(); }
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 1073741840, i32 1)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 1)
__riscv_ztt_u16_1x1_t test_5(void) { return __riscv_ztt_mcolid_ew_u16_1x1(); }
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 16, i32 1)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 1, 1)
__riscv_ztt_i32_1x1_t test_6(void) { return __riscv_ztt_mcolid_ew_i32_1x1(); }
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 1073741856, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)
__riscv_ztt_u32_1x1_t test_7(void) { return __riscv_ztt_mcolid_ew_u32_1x1(); }
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 32, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)
__riscv_ztt_i64_1x1_t test_8(void) { return __riscv_ztt_mcolid_ew_i64_1x1(); }
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 1073741888, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)
__riscv_ztt_u64_1x1_t test_9(void) { return __riscv_ztt_mcolid_ew_u64_1x1(); }
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 64, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)
__riscv_ztt_i128_1x1_t test_10(void) { return __riscv_ztt_mcolid_ew_i128_1x1(); }
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 1073741952, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)
__riscv_ztt_u128_1x1_t test_11(void) { return __riscv_ztt_mcolid_ew_u128_1x1(); }
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolid.ew{{.*}}(i32 128, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)
#ifdef __cplusplus
}
#endif
