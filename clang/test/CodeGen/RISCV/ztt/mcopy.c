// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_DATATYPE -O0 -emit-llvm -o - %s | FileCheck %s --check-prefix=DATATYPE
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_DATATYPE -O0 -emit-llvm -o - %s | FileCheck %s --check-prefix=DATATYPE
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a8 -DTEST_ROUNDTRIP -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=ROUNDTRIP
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a8 -DTEST_ROUNDTRIP -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=ROUNDTRIP
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_UDS128 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=UDS128
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_UDS128 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=UDS128
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -O1 -emit-llvm -o - %s | FileCheck %s

#include <riscv_ztt.h>

#if !defined(TEST_DATATYPE) && !defined(TEST_ROUNDTRIP) && !defined(TEST_UDS128)
__riscv_ztt_i16_1x2_t
test_mcopy_packed(__riscv_ztt_i16_1x2_t src) {
  return __riscv_ztt_mcopy_m2m_i16_1x2(src);
}

// CHECK-LABEL: define{{.*}} @test_mcopy_packed(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) %{{.*}}, i32 1073741840, i32 2)

__riscv_ztt_i32_1x1_t
test_mcopy_standard(__riscv_ztt_i32_1x1_t src) {
  return __riscv_ztt_mcopy_m2m_i32_1x1(src);
}

// CHECK-LABEL: define{{.*}} @test_mcopy_standard(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)

__riscv_ztt_i32_1x2_t
test_mcopy_concat(__riscv_ztt_i32_1x2_t src) {
  return __riscv_ztt_mcopy_m2m_i32_1x2(src);
}

// CHECK-LABEL: define{{.*}} @test_mcopy_concat(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 2) %{{.*}}, i32 1073741856, i32 2)

__riscv_ztt_u4_1x8_t test_mcopy_u4(__riscv_ztt_u4_1x8_t src) {
  return __riscv_ztt_mcopy_m2m_u4_1x8(src);
}

// CHECK-LABEL: define{{.*}} @test_mcopy_u4(
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 1, 8) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u4", i4, 4, 1, 8) %{{.*}}, i32 4, i32 8)

__riscv_ztt_f64_1x1_t test_mcopy_f64(__riscv_ztt_f64_1x1_t src) {
  return __riscv_ztt_mcopy_m2m_f64_1x1(src);
}

// CHECK-LABEL: define{{.*}} @test_mcopy_f64(
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, i32 741343552, i32 1)

// M/ACC copies preserve datatype identity and square count.
__riscv_ztt_i32_accx1_t
test_m2a_i32_accx1(__riscv_ztt_i32_1x1_t src) {
  return __riscv_ztt_mcopy_m2a_i32_accx1(src);
}

// CHECK-LABEL: define{{.*}} @test_m2a_i32_accx1(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)

__riscv_ztt_i16_accx2_t
test_m2a_i16_accx2_row(__riscv_ztt_i16_1x2_t src) {
  return __riscv_ztt_mcopy_m2a_i16_accx2(src);
}

// CHECK-LABEL: define{{.*}} @test_m2a_i16_accx2_row(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 2) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) %{{.*}}, i32 1073741840, i32 2)

__riscv_ztt_i16_accx2_t
test_m2a_i16_accx2_col(__riscv_ztt_i16_2x1_t src) {
  return __riscv_ztt_mcopy_m2a_i16_accx2(src);
}

// CHECK-LABEL: define{{.*}} @test_m2a_i16_accx2_col(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 2) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i16", i16, 16, 2, 1) %{{.*}}, i32 1073741840, i32 2)

__riscv_ztt_i32_4x1_t
test_a2m_i32_4x1(__riscv_ztt_i32_accx4_t src) {
  return __riscv_ztt_mcopy_a2m_i32_4x1(src);
}

// CHECK-LABEL: define{{.*}} @test_a2m_i32_4x1(
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i32", i32, 32, 4) %{{.*}}, i32 1073741856, i32 4)

__riscv_ztt_i16_accx8_t
test_m2a_i16_accx8(__riscv_ztt_i16_1x8_t src) {
  return __riscv_ztt_mcopy_m2a_i16_accx8(src);
}

// CHECK-LABEL: define{{.*}} @test_m2a_i16_accx8(
// CHECK: call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 8) %{{.*}}, i32 1073741840, i32 8)

__riscv_ztt_i16_8x1_t
test_a2m_i16_8x1(__riscv_ztt_i16_accx8_t src) {
  return __riscv_ztt_mcopy_a2m_i16_8x1(src);
}

// CHECK-LABEL: define{{.*}} @test_a2m_i16_8x1(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i16", i16, 16, 8) %{{.*}}, i32 1073741840, i32 8)

__riscv_ztt_u16_accx2_t test_m2a_u16_accx2(__riscv_ztt_u16_1x2_t src) {
  return __riscv_ztt_mcopy_m2a_u16_accx2(src);
}

// CHECK-LABEL: define{{.*}} @test_m2a_u16_accx2(
// CHECK: call target("riscv.ztt.acc.u16", i16, 16, 2) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u16", i16, 16, 1, 2) %{{.*}}, i32 16, i32 2)

__riscv_ztt_f32_4x1_t
test_a2m_f32_4x1(__riscv_ztt_f32_accx4_t src) {
  return __riscv_ztt_mcopy_a2m_f32_4x1(src);
}

// CHECK-LABEL: define{{.*}} @test_a2m_f32_4x1(
// CHECK: call target("riscv.ztt.m.f32", float, 32, 4, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.f32", float, 32, 4) %{{.*}}, i32 540016928, i32 4)

__riscv_ztt_i128_accx8_t
test_m2a_i128_accx8(__riscv_ztt_i128_8x1_t src) {
  return __riscv_ztt_mcopy_m2a_i128_accx8(src);
}

// CHECK-LABEL: define{{.*}} @test_m2a_i128_accx8(
// CHECK: call target("riscv.ztt.acc.i128", i128, 128, 8) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i128", i128, 128, 8, 1) %{{.*}}, i32 1073741952, i32 8)
#elif defined(TEST_UDS128)
// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i4", i4, 4, 1, 32) @copy_i4_1x32(
// UDS128: call target("riscv.ztt.m.i4", i4, 4, 1, 32) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 32) %{{.*}}, i32 1073741828, i32 32)
__riscv_ztt_i4_1x32_t copy_i4_1x32(__riscv_ztt_i4_1x32_t value) {
  return __riscv_ztt_mcopy_m2m_i4_1x32(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i8", i8, 8, 1, 16) @copy_i8_1x16(
// UDS128: call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 16) %{{.*}}, i32 1073741832, i32 16)
__riscv_ztt_i8_1x16_t copy_i8_1x16(__riscv_ztt_i8_1x16_t value) {
  return __riscv_ztt_mcopy_m2m_i8_1x16(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 8) @copy_i16_1x8(
// UDS128: call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 8) %{{.*}}, i32 1073741840, i32 8)
__riscv_ztt_i16_1x8_t copy_i16_1x8(__riscv_ztt_i16_1x8_t value) {
  return __riscv_ztt_mcopy_m2m_i16_1x8(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 4) @copy_i32_1x4(
// UDS128: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 4) %{{.*}}, i32 1073741856, i32 4)
__riscv_ztt_i32_1x4_t copy_i32_1x4(__riscv_ztt_i32_1x4_t value) {
  return __riscv_ztt_mcopy_m2m_i32_1x4(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i64", i64, 64, 1, 2) @copy_i64_1x2(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 2) %{{.*}}, i32 1073741888, i32 2)
__riscv_ztt_i64_1x2_t copy_i64_1x2(__riscv_ztt_i64_1x2_t value) {
  return __riscv_ztt_mcopy_m2m_i64_1x2(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @copy_i128_1x1(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
__riscv_ztt_i128_1x1_t copy_i128_1x1(__riscv_ztt_i128_1x1_t value) {
  return __riscv_ztt_mcopy_m2m_i128_1x1(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.u32", i32, 32, 1, 4) @copy_u32_1x4(
// UDS128: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 4) %{{.*}}, i32 32, i32 4)
__riscv_ztt_u32_1x4_t copy_u32_1x4(__riscv_ztt_u32_1x4_t value) {
  return __riscv_ztt_mcopy_m2m_u32_1x4(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @copy_bf16_1x8(
// UDS128: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %{{.*}}, i32 540016912, i32 8)
__riscv_ztt_bf16_1x8_t copy_bf16_1x8(__riscv_ztt_bf16_1x8_t value) {
  return __riscv_ztt_mcopy_m2m_bf16_1x8(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 4) @copy_f32_1x4(
// UDS128: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 4) %{{.*}}, i32 540016928, i32 4)
__riscv_ztt_f32_1x4_t copy_f32_1x4(__riscv_ztt_f32_1x4_t value) {
  return __riscv_ztt_mcopy_m2m_f32_1x4(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 1, 2) @copy_f64_1x2(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 2) %{{.*}}, i32 741343552, i32 2)
__riscv_ztt_f64_1x2_t copy_f64_1x2(__riscv_ztt_f64_1x2_t value) {
  return __riscv_ztt_mcopy_m2m_f64_1x2(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.acc.i128", i128, 128, 1) @m2a_i128
// UDS128: call target("riscv.ztt.acc.i128", i128, 128, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
__riscv_ztt_i128_accx1_t m2a_i128(__riscv_ztt_i128_1x1_t value) {
  return __riscv_ztt_mcopy_m2a_i128_accx1(value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @a2m_i128
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i128", i128, 128, 1) %{{.*}}, i32 1073741952, i32 1)
__riscv_ztt_i128_1x1_t a2m_i128(__riscv_ztt_i128_accx1_t value) {
  return __riscv_ztt_mcopy_a2m_i128_1x1(value);
}

#elif defined(TEST_ROUNDTRIP)
// Eight ACC squares round-trip through one packed M register.
// ROUNDTRIP-LABEL: define{{.*}} void @roundtrip_i16(
// ROUNDTRIP-SAME: ptr{{[^%]*}}[[SRC_PTR:%[^, )]+]], ptr{{[^%]*}}[[DST_PTR:%[^, )]+]])
// ROUNDTRIP: [[M:%.*]] = {{.*}}call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[SRC_PTR]], i32 1073741840, i32 8)
// ROUNDTRIP-NEXT: [[A:%.*]] = {{.*}}call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 8) [[M]], i32 1073741840, i32 8)
// ROUNDTRIP-NEXT: [[COPY:%.*]] = {{.*}}call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i16", i16, 16, 8) [[A]], i32 1073741840, i32 8)
// ROUNDTRIP-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[DST_PTR]], target("riscv.ztt.m.i16", i16, 16, 1, 8) [[COPY]], i32 1073741840, i32 8)
// ROUNDTRIP-NEXT: ret void
void roundtrip_i16(const short *src, short *dst) {
  __riscv_ztt_i16_1x8_t m = __riscv_ztt_mls_rm_i16_1x8(src);
  __riscv_ztt_i16_accx8_t acc = __riscv_ztt_mcopy_m2a_i16_accx8(m);
  __riscv_ztt_i16_1x8_t back = __riscv_ztt_mcopy_a2m_i16_1x8(acc);
  __riscv_ztt_mss_rm(dst, back);
}

// ROUNDTRIP-LABEL: define{{.*}} void @roundtrip_bf16(
// ROUNDTRIP-SAME: ptr{{[^%]*}}[[SRC_PTR:%[^, )]+]], ptr{{[^%]*}}[[DST_PTR:%[^, )]+]])
// ROUNDTRIP: [[M:%.*]] = {{.*}}call target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr [[SRC_PTR]], i32 540016912, i32 8)
// ROUNDTRIP-NEXT: [[A:%.*]] = {{.*}}call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) [[M]], i32 540016912, i32 8)
// ROUNDTRIP-NEXT: [[COPY:%.*]] = {{.*}}call target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.bf16", bfloat, 16, 8) [[A]], i32 540016912, i32 8)
// ROUNDTRIP-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr [[DST_PTR]], target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) [[COPY]], i32 540016912, i32 8)
// ROUNDTRIP-NEXT: ret void
void roundtrip_bf16(const __bf16 *src, __bf16 *dst) {
  __riscv_ztt_bf16_8x1_t m = __riscv_ztt_mls_cm_bf16_8x1(src);
  __riscv_ztt_bf16_accx8_t acc = __riscv_ztt_mcopy_m2a_bf16_accx8(m);
  __riscv_ztt_bf16_8x1_t back = __riscv_ztt_mcopy_a2m_bf16_8x1(acc);
  __riscv_ztt_mss_cm(dst, back);
}


#elif defined(TEST_DATATYPE)
// Complete descriptors must reach each metadata/element-pointer operand.
// DATATYPE-LABEL: @datatype_i4(
// DATATYPE: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741828, i32 2)
// DATATYPE: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 2) %{{.*}}, i32 1073741828, i32 2)
// DATATYPE: call target("riscv.ztt.acc.i4", i4, 4, 2) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 2) %{{.*}}, i32 1073741828, i32 2)
// DATATYPE: call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i4", i4, 4, 2) %{{.*}}, i32 1073741828, i32 2)
void datatype_i4(void) {
  __riscv_ztt_i4_1x2_t m = __riscv_ztt_mclear_m_i4_1x2();
  __riscv_ztt_i4_1x2_t copy = __riscv_ztt_mcopy_m2m_i4_1x2(m);
  __riscv_ztt_i4_accx2_t acc = __riscv_ztt_mcopy_m2a_i4_accx2(copy);
  __riscv_ztt_i4_1x2_t back = __riscv_ztt_mcopy_a2m_i4_1x2(acc);
}

// DATATYPE-LABEL: @datatype_u4(
// DATATYPE: call target("riscv.ztt.m.u4", i4, 4, 1, 2) @llvm.riscv.ztt.mclear.m{{.*}}(i32 4, i32 2)
// DATATYPE: call target("riscv.ztt.m.u4", i4, 4, 1, 2) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u4", i4, 4, 1, 2) %{{.*}}, i32 4, i32 2)
// DATATYPE: call target("riscv.ztt.acc.u4", i4, 4, 2) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u4", i4, 4, 1, 2) %{{.*}}, i32 4, i32 2)
// DATATYPE: call target("riscv.ztt.m.u4", i4, 4, 1, 2) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.u4", i4, 4, 2) %{{.*}}, i32 4, i32 2)
void datatype_u4(void) {
  __riscv_ztt_u4_1x2_t m = __riscv_ztt_mclear_m_u4_1x2();
  __riscv_ztt_u4_1x2_t copy = __riscv_ztt_mcopy_m2m_u4_1x2(m);
  __riscv_ztt_u4_accx2_t acc = __riscv_ztt_mcopy_m2a_u4_accx2(copy);
  __riscv_ztt_u4_1x2_t back = __riscv_ztt_mcopy_a2m_u4_1x2(acc);
}

// DATATYPE-LABEL: @datatype_i8(
// DATATYPE: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741832, i32 1)
// DATATYPE: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 1) %{{.*}}, i32 1073741832, i32 1)
// DATATYPE: call target("riscv.ztt.acc.i8", i8, 8, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 1) %{{.*}}, i32 1073741832, i32 1)
// DATATYPE: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i8", i8, 8, 1) %{{.*}}, i32 1073741832, i32 1)
void datatype_i8(void) {
  __riscv_ztt_i8_1x1_t m = __riscv_ztt_mclear_m_i8_1x1();
  __riscv_ztt_i8_1x1_t copy = __riscv_ztt_mcopy_m2m_i8_1x1(m);
  __riscv_ztt_i8_accx1_t acc = __riscv_ztt_mcopy_m2a_i8_accx1(copy);
  __riscv_ztt_i8_1x1_t back = __riscv_ztt_mcopy_a2m_i8_1x1(acc);
}

// DATATYPE-LABEL: @datatype_u8(
// DATATYPE: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 8, i32 1)
// DATATYPE: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u8", i8, 8, 1, 1) %{{.*}}, i32 8, i32 1)
// DATATYPE: call target("riscv.ztt.acc.u8", i8, 8, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u8", i8, 8, 1, 1) %{{.*}}, i32 8, i32 1)
// DATATYPE: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.u8", i8, 8, 1) %{{.*}}, i32 8, i32 1)
void datatype_u8(void) {
  __riscv_ztt_u8_1x1_t m = __riscv_ztt_mclear_m_u8_1x1();
  __riscv_ztt_u8_1x1_t copy = __riscv_ztt_mcopy_m2m_u8_1x1(m);
  __riscv_ztt_u8_accx1_t acc = __riscv_ztt_mcopy_m2a_u8_accx1(copy);
  __riscv_ztt_u8_1x1_t back = __riscv_ztt_mcopy_a2m_u8_1x1(acc);
}

// DATATYPE-LABEL: @datatype_i16(
// DATATYPE: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741840, i32 1)
// DATATYPE: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 1) %{{.*}}, i32 1073741840, i32 1)
// DATATYPE: call target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 1) %{{.*}}, i32 1073741840, i32 1)
// DATATYPE: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i16", i16, 16, 1) %{{.*}}, i32 1073741840, i32 1)
void datatype_i16(void) {
  __riscv_ztt_i16_1x1_t m = __riscv_ztt_mclear_m_i16_1x1();
  __riscv_ztt_i16_1x1_t copy = __riscv_ztt_mcopy_m2m_i16_1x1(m);
  __riscv_ztt_i16_accx1_t acc = __riscv_ztt_mcopy_m2a_i16_accx1(copy);
  __riscv_ztt_i16_1x1_t back = __riscv_ztt_mcopy_a2m_i16_1x1(acc);
}

// DATATYPE-LABEL: @datatype_u16(
// DATATYPE: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 16, i32 1)
// DATATYPE: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u16", i16, 16, 1, 1) %{{.*}}, i32 16, i32 1)
// DATATYPE: call target("riscv.ztt.acc.u16", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u16", i16, 16, 1, 1) %{{.*}}, i32 16, i32 1)
// DATATYPE: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.u16", i16, 16, 1) %{{.*}}, i32 16, i32 1)
void datatype_u16(void) {
  __riscv_ztt_u16_1x1_t m = __riscv_ztt_mclear_m_u16_1x1();
  __riscv_ztt_u16_1x1_t copy = __riscv_ztt_mcopy_m2m_u16_1x1(m);
  __riscv_ztt_u16_accx1_t acc = __riscv_ztt_mcopy_m2a_u16_accx1(copy);
  __riscv_ztt_u16_1x1_t back = __riscv_ztt_mcopy_a2m_u16_1x1(acc);
}

// DATATYPE-LABEL: @datatype_i32(
// DATATYPE: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741856, i32 1)
// DATATYPE: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)
// DATATYPE: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)
// DATATYPE: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i32", i32, 32, 1) %{{.*}}, i32 1073741856, i32 1)
void datatype_i32(void) {
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mclear_m_i32_1x1();
  __riscv_ztt_i32_1x1_t copy = __riscv_ztt_mcopy_m2m_i32_1x1(m);
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mcopy_m2a_i32_accx1(copy);
  __riscv_ztt_i32_1x1_t back = __riscv_ztt_mcopy_a2m_i32_1x1(acc);
}

// DATATYPE-LABEL: @datatype_u32(
// DATATYPE: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 32, i32 1)
// DATATYPE: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %{{.*}}, i32 32, i32 1)
// DATATYPE: call target("riscv.ztt.acc.u32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %{{.*}}, i32 32, i32 1)
// DATATYPE: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.u32", i32, 32, 1) %{{.*}}, i32 32, i32 1)
void datatype_u32(void) {
  __riscv_ztt_u32_1x1_t m = __riscv_ztt_mclear_m_u32_1x1();
  __riscv_ztt_u32_1x1_t copy = __riscv_ztt_mcopy_m2m_u32_1x1(m);
  __riscv_ztt_u32_accx1_t acc = __riscv_ztt_mcopy_m2a_u32_accx1(copy);
  __riscv_ztt_u32_1x1_t back = __riscv_ztt_mcopy_a2m_u32_1x1(acc);
}

// DATATYPE-LABEL: @datatype_i64(
// DATATYPE: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741888, i32 1)
// DATATYPE: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %{{.*}}, i32 1073741888, i32 1)
// DATATYPE: call target("riscv.ztt.acc.i64", i64, 64, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %{{.*}}, i32 1073741888, i32 1)
// DATATYPE: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i64", i64, 64, 1) %{{.*}}, i32 1073741888, i32 1)
void datatype_i64(void) {
  __riscv_ztt_i64_1x1_t m = __riscv_ztt_mclear_m_i64_1x1();
  __riscv_ztt_i64_1x1_t copy = __riscv_ztt_mcopy_m2m_i64_1x1(m);
  __riscv_ztt_i64_accx1_t acc = __riscv_ztt_mcopy_m2a_i64_accx1(copy);
  __riscv_ztt_i64_1x1_t back = __riscv_ztt_mcopy_a2m_i64_1x1(acc);
}

// DATATYPE-LABEL: @datatype_u64(
// DATATYPE: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 64, i32 1)
// DATATYPE: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %{{.*}}, i32 64, i32 1)
// DATATYPE: call target("riscv.ztt.acc.u64", i64, 64, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %{{.*}}, i32 64, i32 1)
// DATATYPE: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.u64", i64, 64, 1) %{{.*}}, i32 64, i32 1)
void datatype_u64(void) {
  __riscv_ztt_u64_1x1_t m = __riscv_ztt_mclear_m_u64_1x1();
  __riscv_ztt_u64_1x1_t copy = __riscv_ztt_mcopy_m2m_u64_1x1(m);
  __riscv_ztt_u64_accx1_t acc = __riscv_ztt_mcopy_m2a_u64_accx1(copy);
  __riscv_ztt_u64_1x1_t back = __riscv_ztt_mcopy_a2m_u64_1x1(acc);
}

// DATATYPE-LABEL: @datatype_i128(
// DATATYPE: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 1073741952, i32 1)
// DATATYPE: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
// DATATYPE: call target("riscv.ztt.acc.i128", i128, 128, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
// DATATYPE: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.i128", i128, 128, 1) %{{.*}}, i32 1073741952, i32 1)
void datatype_i128(void) {
  __riscv_ztt_i128_1x1_t m = __riscv_ztt_mclear_m_i128_1x1();
  __riscv_ztt_i128_1x1_t copy = __riscv_ztt_mcopy_m2m_i128_1x1(m);
  __riscv_ztt_i128_accx1_t acc = __riscv_ztt_mcopy_m2a_i128_accx1(copy);
  __riscv_ztt_i128_1x1_t back = __riscv_ztt_mcopy_a2m_i128_1x1(acc);
}

// DATATYPE-LABEL: @datatype_u128(
// DATATYPE: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 128, i32 1)
// DATATYPE: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, i32 128, i32 1)
// DATATYPE: call target("riscv.ztt.acc.u128", i128, 128, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, i32 128, i32 1)
// DATATYPE: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.u128", i128, 128, 1) %{{.*}}, i32 128, i32 1)
void datatype_u128(void) {
  __riscv_ztt_u128_1x1_t m = __riscv_ztt_mclear_m_u128_1x1();
  __riscv_ztt_u128_1x1_t copy = __riscv_ztt_mcopy_m2m_u128_1x1(m);
  __riscv_ztt_u128_accx1_t acc = __riscv_ztt_mcopy_m2a_u128_accx1(copy);
  __riscv_ztt_u128_1x1_t back = __riscv_ztt_mcopy_a2m_u128_1x1(acc);
}

// DATATYPE-LABEL: @datatype_f16(
// DATATYPE: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 338690320, i32 1)
// DATATYPE: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 1) %{{.*}}, i32 338690320, i32 1)
// DATATYPE: call target("riscv.ztt.acc.f16", half, 16, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 1) %{{.*}}, i32 338690320, i32 1)
// DATATYPE: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.f16", half, 16, 1) %{{.*}}, i32 338690320, i32 1)
void datatype_f16(void) {
  __riscv_ztt_f16_1x1_t m = __riscv_ztt_mclear_m_f16_1x1();
  __riscv_ztt_f16_1x1_t copy = __riscv_ztt_mcopy_m2m_f16_1x1(m);
  __riscv_ztt_f16_accx1_t acc = __riscv_ztt_mcopy_m2a_f16_accx1(copy);
  __riscv_ztt_f16_1x1_t back = __riscv_ztt_mcopy_a2m_f16_1x1(acc);
}

// DATATYPE-LABEL: @datatype_bf16(
// DATATYPE: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016912, i32 1)
// DATATYPE: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %{{.*}}, i32 540016912, i32 1)
// DATATYPE: call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %{{.*}}, i32 540016912, i32 1)
// DATATYPE: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.bf16", bfloat, 16, 1) %{{.*}}, i32 540016912, i32 1)
void datatype_bf16(void) {
  __riscv_ztt_bf16_1x1_t m = __riscv_ztt_mclear_m_bf16_1x1();
  __riscv_ztt_bf16_1x1_t copy = __riscv_ztt_mcopy_m2m_bf16_1x1(m);
  __riscv_ztt_bf16_accx1_t acc = __riscv_ztt_mcopy_m2a_bf16_accx1(copy);
  __riscv_ztt_bf16_1x1_t back = __riscv_ztt_mcopy_a2m_bf16_1x1(acc);
}

// DATATYPE-LABEL: @datatype_f32(
// DATATYPE: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 540016928, i32 1)
// DATATYPE: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %{{.*}}, i32 540016928, i32 1)
// DATATYPE: call target("riscv.ztt.acc.f32", float, 32, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %{{.*}}, i32 540016928, i32 1)
// DATATYPE: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.f32", float, 32, 1) %{{.*}}, i32 540016928, i32 1)
void datatype_f32(void) {
  __riscv_ztt_f32_1x1_t m = __riscv_ztt_mclear_m_f32_1x1();
  __riscv_ztt_f32_1x1_t copy = __riscv_ztt_mcopy_m2m_f32_1x1(m);
  __riscv_ztt_f32_accx1_t acc = __riscv_ztt_mcopy_m2a_f32_accx1(copy);
  __riscv_ztt_f32_1x1_t back = __riscv_ztt_mcopy_a2m_f32_1x1(acc);
}

// DATATYPE-LABEL: @datatype_f64(
// DATATYPE: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mclear.m{{.*}}(i32 741343552, i32 1)
// DATATYPE: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, i32 741343552, i32 1)
// DATATYPE: call target("riscv.ztt.acc.f64", double, 64, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, i32 741343552, i32 1)
// DATATYPE: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.a2m{{.*}}(target("riscv.ztt.acc.f64", double, 64, 1) %{{.*}}, i32 741343552, i32 1)
void datatype_f64(void) {
  __riscv_ztt_f64_1x1_t m = __riscv_ztt_mclear_m_f64_1x1();
  __riscv_ztt_f64_1x1_t copy = __riscv_ztt_mcopy_m2m_f64_1x1(m);
  __riscv_ztt_f64_accx1_t acc = __riscv_ztt_mcopy_m2a_f64_accx1(copy);
  __riscv_ztt_f64_1x1_t back = __riscv_ztt_mcopy_a2m_f64_1x1(acc);
}


#endif
