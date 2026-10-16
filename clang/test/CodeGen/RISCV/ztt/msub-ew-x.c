// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

void test_i8(__INT8_TYPE__ value, int *out) {
  __riscv_ztt_i8_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_i8(
// CHECK: zext i8 %{{.*}} to i{{32|64}}
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 1073741832, i32 1)

void test_u8(__UINT8_TYPE__ value, int *out) {
  __riscv_ztt_u8_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_u8(
// CHECK: zext i8 %{{.*}} to i{{32|64}}
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 8, i32 1)

void test_i16(__INT16_TYPE__ value, int *out) {
  __riscv_ztt_i16_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_i16(
// CHECK: zext i16 %{{.*}} to i{{32|64}}
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 1073741840, i32 1)

void test_u16(__UINT16_TYPE__ value, int *out) {
  __riscv_ztt_u16_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_u16(
// CHECK: zext i16 %{{.*}} to i{{32|64}}
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 16, i32 1)

void test_i32(__INT32_TYPE__ value, int *out) {
  __riscv_ztt_i32_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_i32(
// RV64: zext i32 %{{.*}} to i64
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 1073741856, i32 1)

void test_u32(__UINT32_TYPE__ value, int *out) {
  __riscv_ztt_u32_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_u32(
// RV64: zext i32 %{{.*}} to i64
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 32, i32 1)

void test_f16(_Float16 value, int *out) {
  __riscv_ztt_f16_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_f16(
// CHECK: bitcast half %{{.*}} to i16
// CHECK: zext i16 %{{.*}} to i{{32|64}}
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 338690320, i32 1)

void test_bf16(__bf16 value, int *out) {
  __riscv_ztt_bf16_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_bf16(
// CHECK: bitcast bfloat %{{.*}} to i16
// CHECK: zext i16 %{{.*}} to i{{32|64}}
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 540016912, i32 1)

void test_f32(float value, int *out) {
  __riscv_ztt_f32_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @test_f32(
// CHECK: bitcast float %{{.*}} to i32
// RV64: zext i32 %{{.*}} to i64
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 540016928, i32 1)

#if __riscv_xlen == 64
void test_i64(__INT64_TYPE__ value, int *out) {
  __riscv_ztt_i64_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// RV64-LABEL: define{{.*}} @test_i64(
// RV64: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 1073741888, i32 1)
#endif

#if __riscv_xlen == 64
void test_u64(__UINT64_TYPE__ value, int *out) {
  __riscv_ztt_u64_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// RV64-LABEL: define{{.*}} @test_u64(
// RV64: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 64, i32 1)
#endif

#if __riscv_xlen == 64
void test_f64(double value, int *out) {
  __riscv_ztt_f64_scalar_t scalar = value;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// RV64-LABEL: define{{.*}} @test_f64(
// RV64: bitcast double %{{.*}} to i64
// RV64: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msub.ew.x.{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1073741856, i32 741343552, i32 1)
#endif

// Values use their bit pattern, not a numerical float-to-integer conversion.
void constants(int *out) {
  __riscv_ztt_f32_scalar_t scalar = (float)-1.0f;
  __riscv_ztt_i32_1x1_t src = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_i32_1x1_t dst = __riscv_ztt_msub_ew_x_i32_1x1(src, scalar);
  __riscv_ztt_mss_rm(out, dst);
}
// CHECK-LABEL: define{{.*}} @constants(
// RV32: @llvm.riscv.ztt.msub.ew.x.{{.*}}i32 -1082130432, i32 1073741856, i32 540016928, i32 1)
// RV64: @llvm.riscv.ztt.msub.ew.x.{{.*}}i64 3212836864, i32 1073741856, i32 540016928, i32 1)

#ifdef __cplusplus
}
#endif
