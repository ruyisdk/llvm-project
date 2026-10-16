// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_DATATYPE -O0 -emit-llvm -o - %s | FileCheck %s --check-prefix=DATATYPE
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_DATATYPE -O0 -emit-llvm -o - %s | FileCheck %s --check-prefix=DATATYPE
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_UDS128 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=UDS128
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_UDS128 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=UDS128
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -emit-llvm -o - %s \
// RUN: | FileCheck %s

#include <riscv_ztt.h>

#if !defined(TEST_DATATYPE) && !defined(TEST_UDS128)
#define TEST_MCLEAR(Type, Suffix)                                               \
  Type test_mclear_##Suffix(void) { return __riscv_ztt_mclear_m_##Suffix(); }

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 2) @test_mclear_i16_1x2(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 2)
TEST_MCLEAR(__riscv_ztt_i16_1x2_t, i16_1x2)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 4) @test_mclear_i16_1x4(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 4)
TEST_MCLEAR(__riscv_ztt_i16_1x4_t, i16_1x4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 8) @test_mclear_i16_1x8(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 8)
TEST_MCLEAR(__riscv_ztt_i16_1x8_t, i16_1x8)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 16) @test_mclear_i16_1x16(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 16)
TEST_MCLEAR(__riscv_ztt_i16_1x16_t, i16_1x16)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 32) @test_mclear_i16_1x32(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 32) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 32)
TEST_MCLEAR(__riscv_ztt_i16_1x32_t, i16_1x32)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 2, 1) @test_mclear_i16_2x1(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 2)
TEST_MCLEAR(__riscv_ztt_i16_2x1_t, i16_2x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 4, 1) @test_mclear_i16_4x1(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 4)
TEST_MCLEAR(__riscv_ztt_i16_4x1_t, i16_4x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 8, 1) @test_mclear_i16_8x1(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 8)
TEST_MCLEAR(__riscv_ztt_i16_8x1_t, i16_8x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 16, 1) @test_mclear_i16_16x1(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 16)
TEST_MCLEAR(__riscv_ztt_i16_16x1_t, i16_16x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 32, 1) @test_mclear_i16_32x1(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 32, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 32)
TEST_MCLEAR(__riscv_ztt_i16_32x1_t, i16_32x1)

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 1) @test_mclear_i32_1x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 1)
TEST_MCLEAR(__riscv_ztt_i32_1x1_t, i32_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 2) @test_mclear_i32_1x2(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 2)
TEST_MCLEAR(__riscv_ztt_i32_1x2_t, i32_1x2)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 4) @test_mclear_i32_1x4(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 4)
TEST_MCLEAR(__riscv_ztt_i32_1x4_t, i32_1x4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 8) @test_mclear_i32_1x8(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 8)
TEST_MCLEAR(__riscv_ztt_i32_1x8_t, i32_1x8)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 16) @test_mclear_i32_1x16(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 16) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 16)
TEST_MCLEAR(__riscv_ztt_i32_1x16_t, i32_1x16)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 32) @test_mclear_i32_1x32(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 32) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 32)
TEST_MCLEAR(__riscv_ztt_i32_1x32_t, i32_1x32)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 2, 1) @test_mclear_i32_2x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 2)
TEST_MCLEAR(__riscv_ztt_i32_2x1_t, i32_2x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 4, 1) @test_mclear_i32_4x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 4)
TEST_MCLEAR(__riscv_ztt_i32_4x1_t, i32_4x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 8, 1) @test_mclear_i32_8x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 8, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 8)
TEST_MCLEAR(__riscv_ztt_i32_8x1_t, i32_8x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 16, 1) @test_mclear_i32_16x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 16, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 16)
TEST_MCLEAR(__riscv_ztt_i32_16x1_t, i32_16x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 32, 1) @test_mclear_i32_32x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 32, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 32)
TEST_MCLEAR(__riscv_ztt_i32_32x1_t, i32_32x1)

// Check every newly supported datatype through the public header alias and
// builtin lowering. Shapes are chosen to occupy at least one 32-bit UDS.
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i4", i4, 4, 1, 8) @test_mclear_i4_1x8(
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741828, i32 8)
TEST_MCLEAR(__riscv_ztt_i4_1x8_t, i4_1x8)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u4", i4, 4, 1, 8) @test_mclear_u4_1x8(
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 1, 8) @llvm.riscv.ztt.mclear.m{{.*}}(i32 4, i32 8)
TEST_MCLEAR(__riscv_ztt_u4_1x8_t, u4_1x8)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i8", i8, 8, 1, 4) @test_mclear_i8_1x4(
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741832, i32 4)
TEST_MCLEAR(__riscv_ztt_i8_1x4_t, i8_1x4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u8", i8, 8, 1, 4) @test_mclear_u8_1x4(
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 8, i32 4)
TEST_MCLEAR(__riscv_ztt_u8_1x4_t, u8_1x4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u16", i16, 16, 1, 2) @test_mclear_u16_1x2(
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 16, i32 2)
TEST_MCLEAR(__riscv_ztt_u16_1x2_t, u16_1x2)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u32", i32, 32, 1, 1) @test_mclear_u32_1x1(
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 32, i32 1)
TEST_MCLEAR(__riscv_ztt_u32_1x1_t, u32_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i64", i64, 64, 1, 1) @test_mclear_i64_1x1(
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741888, i32 1)
TEST_MCLEAR(__riscv_ztt_i64_1x1_t, i64_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u64", i64, 64, 1, 1) @test_mclear_u64_1x1(
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 64, i32 1)
TEST_MCLEAR(__riscv_ztt_u64_1x1_t, u64_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @test_mclear_i128_1x1(
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741952, i32 1)
TEST_MCLEAR(__riscv_ztt_i128_1x1_t, i128_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u128", i128, 128, 1, 1) @test_mclear_u128_1x1(
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 128, i32 1)
TEST_MCLEAR(__riscv_ztt_u128_1x1_t, u128_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f16", half, 16, 1, 2) @test_mclear_f16_1x2(
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 338690320, i32 2)
TEST_MCLEAR(__riscv_ztt_f16_1x2_t, f16_1x2)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @test_mclear_bf16_1x2(
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016912, i32 2)
TEST_MCLEAR(__riscv_ztt_bf16_1x2_t, bf16_1x2)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 1) @test_mclear_f32_1x1(
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016928, i32 1)
TEST_MCLEAR(__riscv_ztt_f32_1x1_t, f32_1x1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 1, 1) @test_mclear_f64_1x1(
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 741343552, i32 1)
TEST_MCLEAR(__riscv_ztt_f64_1x1_t, f64_1x1)

#undef TEST_MCLEAR

#define TEST_ACLEAR(Type, Suffix)                                             \
  Type test_mclear_acc_##Suffix(void) {                                       \
    return __riscv_ztt_mclear_acc_##Suffix();                                 \
  }

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 1) @test_mclear_acc_i16_accx1(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741840, i32 1)
TEST_ACLEAR(__riscv_ztt_i16_accx1_t, i16_accx1)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 2) @test_mclear_acc_i16_accx2(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 2) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741840, i32 2)
TEST_ACLEAR(__riscv_ztt_i16_accx2_t, i16_accx2)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 4) @test_mclear_acc_i16_accx4(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 4) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741840, i32 4)
TEST_ACLEAR(__riscv_ztt_i16_accx4_t, i16_accx4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 8) @test_mclear_acc_i16_accx8(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741840, i32 8)
TEST_ACLEAR(__riscv_ztt_i16_accx8_t, i16_accx8)

// Cover every supported datatype through the public Acc-clear aliases.
// CHECK-LABEL: @test_mclear_acc_i4_accx1(
TEST_ACLEAR(__riscv_ztt_i4_accx1_t, i4_accx1)
// CHECK-LABEL: @test_mclear_acc_u4_accx1(
TEST_ACLEAR(__riscv_ztt_u4_accx1_t, u4_accx1)
// CHECK-LABEL: @test_mclear_acc_i8_accx1(
TEST_ACLEAR(__riscv_ztt_i8_accx1_t, i8_accx1)
// CHECK-LABEL: @test_mclear_acc_u8_accx1(
TEST_ACLEAR(__riscv_ztt_u8_accx1_t, u8_accx1)
// CHECK-LABEL: @test_mclear_acc_u16_accx1(
TEST_ACLEAR(__riscv_ztt_u16_accx1_t, u16_accx1)
// CHECK-LABEL: @test_mclear_acc_i32_accx1(
TEST_ACLEAR(__riscv_ztt_i32_accx1_t, i32_accx1)
// CHECK-LABEL: @test_mclear_acc_u32_accx1(
TEST_ACLEAR(__riscv_ztt_u32_accx1_t, u32_accx1)
// CHECK-LABEL: @test_mclear_acc_i64_accx1(
TEST_ACLEAR(__riscv_ztt_i64_accx1_t, i64_accx1)
// CHECK-LABEL: @test_mclear_acc_u64_accx1(
TEST_ACLEAR(__riscv_ztt_u64_accx1_t, u64_accx1)
// CHECK-LABEL: @test_mclear_acc_i128_accx1(
TEST_ACLEAR(__riscv_ztt_i128_accx1_t, i128_accx1)
// CHECK-LABEL: @test_mclear_acc_u128_accx1(
TEST_ACLEAR(__riscv_ztt_u128_accx1_t, u128_accx1)
// CHECK-LABEL: @test_mclear_acc_f16_accx1(
TEST_ACLEAR(__riscv_ztt_f16_accx1_t, f16_accx1)
// CHECK-LABEL: @test_mclear_acc_bf16_accx1(
TEST_ACLEAR(__riscv_ztt_bf16_accx1_t, bf16_accx1)
// CHECK-LABEL: @test_mclear_acc_f32_accx1(
TEST_ACLEAR(__riscv_ztt_f32_accx1_t, f32_accx1)
// CHECK-LABEL: @test_mclear_acc_f64_accx1(
TEST_ACLEAR(__riscv_ztt_f64_accx1_t, f64_accx1)

#undef TEST_ACLEAR
#elif defined(TEST_UDS128)
// Each type occupies one M register at UDS=128.
// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i4", i4, 4, 1, 32) @clear_i4_1x32(
// UDS128: call target("riscv.ztt.m.i4", i4, 4, 1, 32) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741828, i32 32)
__riscv_ztt_i4_1x32_t clear_i4_1x32(void) {
  return __riscv_ztt_mclear_m_i4_1x32();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i8", i8, 8, 1, 16) @clear_i8_1x16(
// UDS128: call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741832, i32 16)
__riscv_ztt_i8_1x16_t clear_i8_1x16(void) {
  return __riscv_ztt_mclear_m_i8_1x16();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 8) @clear_i16_1x8(
// UDS128: call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 8)
__riscv_ztt_i16_1x8_t clear_i16_1x8(void) {
  return __riscv_ztt_mclear_m_i16_1x8();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 4) @clear_i32_1x4(
// UDS128: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 4)
__riscv_ztt_i32_1x4_t clear_i32_1x4(void) {
  return __riscv_ztt_mclear_m_i32_1x4();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i64", i64, 64, 1, 2) @clear_i64_1x2(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741888, i32 2)
__riscv_ztt_i64_1x2_t clear_i64_1x2(void) {
  return __riscv_ztt_mclear_m_i64_1x2();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @clear_i128_1x1(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741952, i32 1)
__riscv_ztt_i128_1x1_t clear_i128_1x1(void) {
  return __riscv_ztt_mclear_m_i128_1x1();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.u32", i32, 32, 1, 4) @clear_u32_1x4(
// UDS128: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 32, i32 4)
__riscv_ztt_u32_1x4_t clear_u32_1x4(void) {
  return __riscv_ztt_mclear_m_u32_1x4();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @clear_bf16_1x8(
// UDS128: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016912, i32 8)
__riscv_ztt_bf16_1x8_t clear_bf16_1x8(void) {
  return __riscv_ztt_mclear_m_bf16_1x8();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 4) @clear_f32_1x4(
// UDS128: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016928, i32 4)
__riscv_ztt_f32_1x4_t clear_f32_1x4(void) {
  return __riscv_ztt_mclear_m_f32_1x4();
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 1, 2) @clear_f64_1x2(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 741343552, i32 2)
__riscv_ztt_f64_1x2_t clear_f64_1x2(void) {
  return __riscv_ztt_mclear_m_f64_1x2();
}


#elif defined(TEST_DATATYPE)
// Complete descriptors must reach each metadata/element-pointer operand.
// DATATYPE-LABEL: @datatype_i4(
// DATATYPE: call target("riscv.ztt.acc.i4", i4, 4, 2) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741828, i32 2)
void datatype_i4(void) {
  __riscv_ztt_i4_accx2_t zero = __riscv_ztt_mclear_acc_i4_accx2();
}

// DATATYPE-LABEL: @datatype_u4(
// DATATYPE: call target("riscv.ztt.acc.u4", i4, 4, 2) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 4, i32 2)
void datatype_u4(void) {
  __riscv_ztt_u4_accx2_t zero = __riscv_ztt_mclear_acc_u4_accx2();
}

// DATATYPE-LABEL: @datatype_i8(
// DATATYPE: call target("riscv.ztt.acc.i8", i8, 8, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741832, i32 1)
void datatype_i8(void) {
  __riscv_ztt_i8_accx1_t zero = __riscv_ztt_mclear_acc_i8_accx1();
}

// DATATYPE-LABEL: @datatype_u8(
// DATATYPE: call target("riscv.ztt.acc.u8", i8, 8, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 8, i32 1)
void datatype_u8(void) {
  __riscv_ztt_u8_accx1_t zero = __riscv_ztt_mclear_acc_u8_accx1();
}

// DATATYPE-LABEL: @datatype_i16(
// DATATYPE: call target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741840, i32 1)
void datatype_i16(void) {
  __riscv_ztt_i16_accx1_t zero = __riscv_ztt_mclear_acc_i16_accx1();
}

// DATATYPE-LABEL: @datatype_u16(
// DATATYPE: call target("riscv.ztt.acc.u16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 16, i32 1)
void datatype_u16(void) {
  __riscv_ztt_u16_accx1_t zero = __riscv_ztt_mclear_acc_u16_accx1();
}

// DATATYPE-LABEL: @datatype_i32(
// DATATYPE: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741856, i32 1)
void datatype_i32(void) {
  __riscv_ztt_i32_accx1_t zero = __riscv_ztt_mclear_acc_i32_accx1();
}

// DATATYPE-LABEL: @datatype_u32(
// DATATYPE: call target("riscv.ztt.acc.u32", i32, 32, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 32, i32 1)
void datatype_u32(void) {
  __riscv_ztt_u32_accx1_t zero = __riscv_ztt_mclear_acc_u32_accx1();
}

// DATATYPE-LABEL: @datatype_i64(
// DATATYPE: call target("riscv.ztt.acc.i64", i64, 64, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741888, i32 1)
void datatype_i64(void) {
  __riscv_ztt_i64_accx1_t zero = __riscv_ztt_mclear_acc_i64_accx1();
}

// DATATYPE-LABEL: @datatype_u64(
// DATATYPE: call target("riscv.ztt.acc.u64", i64, 64, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 64, i32 1)
void datatype_u64(void) {
  __riscv_ztt_u64_accx1_t zero = __riscv_ztt_mclear_acc_u64_accx1();
}

// DATATYPE-LABEL: @datatype_i128(
// DATATYPE: call target("riscv.ztt.acc.i128", i128, 128, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 1073741952, i32 1)
void datatype_i128(void) {
  __riscv_ztt_i128_accx1_t zero = __riscv_ztt_mclear_acc_i128_accx1();
}

// DATATYPE-LABEL: @datatype_u128(
// DATATYPE: call target("riscv.ztt.acc.u128", i128, 128, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 128, i32 1)
void datatype_u128(void) {
  __riscv_ztt_u128_accx1_t zero = __riscv_ztt_mclear_acc_u128_accx1();
}

// DATATYPE-LABEL: @datatype_f16(
// DATATYPE: call target("riscv.ztt.acc.f16", half, 16, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 338690320, i32 1)
void datatype_f16(void) {
  __riscv_ztt_f16_accx1_t zero = __riscv_ztt_mclear_acc_f16_accx1();
}

// DATATYPE-LABEL: @datatype_bf16(
// DATATYPE: call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 540016912, i32 1)
void datatype_bf16(void) {
  __riscv_ztt_bf16_accx1_t zero = __riscv_ztt_mclear_acc_bf16_accx1();
}

// DATATYPE-LABEL: @datatype_f32(
// DATATYPE: call target("riscv.ztt.acc.f32", float, 32, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 540016928, i32 1)
void datatype_f32(void) {
  __riscv_ztt_f32_accx1_t zero = __riscv_ztt_mclear_acc_f32_accx1();
}

// DATATYPE-LABEL: @datatype_f64(
// DATATYPE: call target("riscv.ztt.acc.f64", double, 64, 1) @llvm.riscv.ztt.mclear.acc{{.*}}(i32 741343552, i32 1)
void datatype_f64(void) {
  __riscv_ztt_f64_accx1_t zero = __riscv_ztt_mclear_acc_f64_accx1();
}


#endif
