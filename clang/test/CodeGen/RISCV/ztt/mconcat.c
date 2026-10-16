// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -O1 -emit-llvm -o - %s | FileCheck %s

#include <riscv_ztt.h>

__riscv_ztt_i32_1x2_t row(__riscv_ztt_i32_1x1_t a,
                           __riscv_ztt_i32_1x1_t b) {
  return __riscv_ztt_mconcat_m_i32_1x2(a, b);
}
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 2) @row(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)

__riscv_ztt_f64_4x1_t column(__riscv_ztt_f64_2x1_t a,
                             __riscv_ztt_f64_2x1_t b) {
  return __riscv_ztt_mconcat_m_f64_4x1(a, b);
}
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 4, 1) @column(
// CHECK: call target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.f64", double, 64, 2, 1) %{{.*}}, target("riscv.ztt.m.f64", double, 64, 2, 1) %{{.*}}, i32 741343552, i32 2)

// Check the complete descriptor for every currently supported datatype.

// CHECK-LABEL: @concat_i4(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 8) %{{.*}}, target("riscv.ztt.m.i4", i4, 4, 1, 8) %{{.*}}, i32 1073741828, i32 8)
__riscv_ztt_i4_1x16_t concat_i4(__riscv_ztt_i4_1x8_t a, __riscv_ztt_i4_1x8_t b) {
  return __riscv_ztt_mconcat_m_i4_1x16(a, b);
}

// CHECK-LABEL: @concat_u4(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.u4", i4, 4, 1, 8) %{{.*}}, target("riscv.ztt.m.u4", i4, 4, 1, 8) %{{.*}}, i32 4, i32 8)
__riscv_ztt_u4_1x16_t concat_u4(__riscv_ztt_u4_1x8_t a, __riscv_ztt_u4_1x8_t b) {
  return __riscv_ztt_mconcat_m_u4_1x16(a, b);
}

// CHECK-LABEL: @concat_i8(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 4) %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 4) %{{.*}}, i32 1073741832, i32 4)
__riscv_ztt_i8_1x8_t concat_i8(__riscv_ztt_i8_1x4_t a, __riscv_ztt_i8_1x4_t b) {
  return __riscv_ztt_mconcat_m_i8_1x8(a, b);
}

// CHECK-LABEL: @concat_u8(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.u8", i8, 8, 1, 4) %{{.*}}, target("riscv.ztt.m.u8", i8, 8, 1, 4) %{{.*}}, i32 8, i32 4)
__riscv_ztt_u8_1x8_t concat_u8(__riscv_ztt_u8_1x4_t a, __riscv_ztt_u8_1x4_t b) {
  return __riscv_ztt_mconcat_m_u8_1x8(a, b);
}

// CHECK-LABEL: @concat_i16(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 2) %{{.*}}, i32 1073741840, i32 2)
__riscv_ztt_i16_1x4_t concat_i16(__riscv_ztt_i16_1x2_t a, __riscv_ztt_i16_1x2_t b) {
  return __riscv_ztt_mconcat_m_i16_1x4(a, b);
}

// CHECK-LABEL: @concat_u16(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.u16", i16, 16, 1, 2) %{{.*}}, target("riscv.ztt.m.u16", i16, 16, 1, 2) %{{.*}}, i32 16, i32 2)
__riscv_ztt_u16_1x4_t concat_u16(__riscv_ztt_u16_1x2_t a, __riscv_ztt_u16_1x2_t b) {
  return __riscv_ztt_mconcat_m_u16_1x4(a, b);
}

// CHECK-LABEL: @concat_i32(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)
__riscv_ztt_i32_1x2_t concat_i32(__riscv_ztt_i32_1x1_t a, __riscv_ztt_i32_1x1_t b) {
  return __riscv_ztt_mconcat_m_i32_1x2(a, b);
}

// CHECK-LABEL: @concat_u32(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %{{.*}}, target("riscv.ztt.m.u32", i32, 32, 1, 1) %{{.*}}, i32 32, i32 1)
__riscv_ztt_u32_1x2_t concat_u32(__riscv_ztt_u32_1x1_t a, __riscv_ztt_u32_1x1_t b) {
  return __riscv_ztt_mconcat_m_u32_1x2(a, b);
}

// CHECK-LABEL: @concat_i64(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %{{.*}}, target("riscv.ztt.m.i64", i64, 64, 1, 1) %{{.*}}, i32 1073741888, i32 1)
__riscv_ztt_i64_1x2_t concat_i64(__riscv_ztt_i64_1x1_t a, __riscv_ztt_i64_1x1_t b) {
  return __riscv_ztt_mconcat_m_i64_1x2(a, b);
}

// CHECK-LABEL: @concat_u64(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %{{.*}}, target("riscv.ztt.m.u64", i64, 64, 1, 1) %{{.*}}, i32 64, i32 1)
__riscv_ztt_u64_1x2_t concat_u64(__riscv_ztt_u64_1x1_t a, __riscv_ztt_u64_1x1_t b) {
  return __riscv_ztt_mconcat_m_u64_1x2(a, b);
}

// CHECK-LABEL: @concat_i128(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
__riscv_ztt_i128_1x2_t concat_i128(__riscv_ztt_i128_1x1_t a, __riscv_ztt_i128_1x1_t b) {
  return __riscv_ztt_mconcat_m_i128_1x2(a, b);
}

// CHECK-LABEL: @concat_u128(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, i32 128, i32 1)
__riscv_ztt_u128_1x2_t concat_u128(__riscv_ztt_u128_1x1_t a, __riscv_ztt_u128_1x1_t b) {
  return __riscv_ztt_mconcat_m_u128_1x2(a, b);
}

// CHECK-LABEL: @concat_f16(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 2) %{{.*}}, target("riscv.ztt.m.f16", half, 16, 1, 2) %{{.*}}, i32 338690320, i32 2)
__riscv_ztt_f16_1x4_t concat_f16(__riscv_ztt_f16_1x2_t a, __riscv_ztt_f16_1x2_t b) {
  return __riscv_ztt_mconcat_m_f16_1x4(a, b);
}

// CHECK-LABEL: @concat_bf16(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %{{.*}}, i32 540016912, i32 2)
__riscv_ztt_bf16_1x4_t concat_bf16(__riscv_ztt_bf16_1x2_t a, __riscv_ztt_bf16_1x2_t b) {
  return __riscv_ztt_mconcat_m_bf16_1x4(a, b);
}

// CHECK-LABEL: @concat_f32(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %{{.*}}, target("riscv.ztt.m.f32", float, 32, 1, 1) %{{.*}}, i32 540016928, i32 1)
__riscv_ztt_f32_1x2_t concat_f32(__riscv_ztt_f32_1x1_t a, __riscv_ztt_f32_1x1_t b) {
  return __riscv_ztt_mconcat_m_f32_1x2(a, b);
}

// CHECK-LABEL: @concat_f64(
// CHECK: @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, i32 741343552, i32 1)
__riscv_ztt_f64_1x2_t concat_f64(__riscv_ztt_f64_1x1_t a, __riscv_ztt_f64_1x1_t b) {
  return __riscv_ztt_mconcat_m_f64_1x2(a, b);
}
