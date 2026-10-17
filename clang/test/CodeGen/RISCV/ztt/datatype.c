// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -emit-llvm %s -o - | FileCheck %s

#include <riscv_ztt.h>

// Descriptor reference table: signed bit 30; floating exponent in 30:26,
// Inf/Denorm in 21/20, FP in 8; default rounding encodes as zero.
// One representative M producer exercises the shared encoder for every dtype.
// Operand forwarding by memory and copy families lives in their own tests.

// CHECK-LABEL: @datatype_i4(
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741828, i32 2)
void datatype_i4(void) {
  __riscv_ztt_i4_1x2_t m = __riscv_ztt_mclear_m_i4_1x2();
}

// CHECK-LABEL: @datatype_u4(
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 4, i32 2)
void datatype_u4(void) {
  __riscv_ztt_u4_1x2_t m = __riscv_ztt_mclear_m_u4_1x2();
}

// CHECK-LABEL: @datatype_i8(
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741832, i32 1)
void datatype_i8(void) {
  __riscv_ztt_i8_1x1_t m = __riscv_ztt_mclear_m_i8_1x1();
}

// CHECK-LABEL: @datatype_u8(
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 8, i32 1)
void datatype_u8(void) {
  __riscv_ztt_u8_1x1_t m = __riscv_ztt_mclear_m_u8_1x1();
}

// CHECK-LABEL: @datatype_i16(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 1)
void datatype_i16(void) {
  __riscv_ztt_i16_1x1_t m = __riscv_ztt_mclear_m_i16_1x1();
}

// CHECK-LABEL: @datatype_u16(
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 16, i32 1)
void datatype_u16(void) {
  __riscv_ztt_u16_1x1_t m = __riscv_ztt_mclear_m_u16_1x1();
}

// CHECK-LABEL: @datatype_i32(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 1)
void datatype_i32(void) {
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mclear_m_i32_1x1();
}

// CHECK-LABEL: @datatype_u32(
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 32, i32 1)
void datatype_u32(void) {
  __riscv_ztt_u32_1x1_t m = __riscv_ztt_mclear_m_u32_1x1();
}

// CHECK-LABEL: @datatype_i64(
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741888, i32 1)
void datatype_i64(void) {
  __riscv_ztt_i64_1x1_t m = __riscv_ztt_mclear_m_i64_1x1();
}

// CHECK-LABEL: @datatype_u64(
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 64, i32 1)
void datatype_u64(void) {
  __riscv_ztt_u64_1x1_t m = __riscv_ztt_mclear_m_u64_1x1();
}

// CHECK-LABEL: @datatype_i128(
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741952, i32 1)
void datatype_i128(void) {
  __riscv_ztt_i128_1x1_t m = __riscv_ztt_mclear_m_i128_1x1();
}

// CHECK-LABEL: @datatype_u128(
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 128, i32 1)
void datatype_u128(void) {
  __riscv_ztt_u128_1x1_t m = __riscv_ztt_mclear_m_u128_1x1();
}

// CHECK-LABEL: @datatype_f16(
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 338690320, i32 1)
void datatype_f16(void) {
  __riscv_ztt_f16_1x1_t m = __riscv_ztt_mclear_m_f16_1x1();
}

// CHECK-LABEL: @datatype_bf16(
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016912, i32 1)
void datatype_bf16(void) {
  __riscv_ztt_bf16_1x1_t m = __riscv_ztt_mclear_m_bf16_1x1();
}

// CHECK-LABEL: @datatype_f32(
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016928, i32 1)
void datatype_f32(void) {
  __riscv_ztt_f32_1x1_t m = __riscv_ztt_mclear_m_f32_1x1();
}

// CHECK-LABEL: @datatype_f64(
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 741343552, i32 1)
void datatype_f64(void) {
  __riscv_ztt_f64_1x1_t m = __riscv_ztt_mclear_m_f64_1x1();
}
