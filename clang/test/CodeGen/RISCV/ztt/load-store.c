// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_DATATYPE -O0 -emit-llvm -o - %s | FileCheck %s --check-prefix=DATATYPE
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_DATATYPE -O0 -emit-llvm -o - %s | FileCheck %s --check-prefix=DATATYPE
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DTEST_PACKED -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=PACKED
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DTEST_PACKED -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=PACKED
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_UDS128 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=UDS128
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_UDS128 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=UDS128
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 \
// RUN: -O1 -emit-llvm %s -o - | FileCheck %s --check-prefix=IR
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 \
// RUN: -O1 -emit-llvm %s -o - | FileCheck %s --check-prefix=IR

#include <riscv_ztt.h>

#if !defined(TEST_DATATYPE) && !defined(TEST_PACKED) && !defined(TEST_UDS128)
// IR-LABEL: @load_rm_i16(
// IR: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm
__riscv_ztt_i16_1x1_t load_rm_i16(const short *p) {
  return __riscv_ztt_mls_rm_i16_1x1(p);
}

// IR-LABEL: @load_rm_i16_1x2(
// IR: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm
__riscv_ztt_i16_1x2_t load_rm_i16_1x2(const short *p) {
  return __riscv_ztt_mls_rm_i16_1x2(p);
}

// IR-LABEL: @load_cm_i32(
// IR: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.cm
__riscv_ztt_i32_1x1_t load_cm_i32(const int *p) {
  return __riscv_ztt_mls_cm_i32_1x1(p);
}

// IR-LABEL: @store_rm_i16(
// IR: call void @llvm.riscv.ztt.mss.rm
void store_rm_i16(short *p, __riscv_ztt_i16_1x1_t v) {
  __riscv_ztt_mss_rm(p, v);
}

// IR-LABEL: @store_cm_i32(
// IR: call void @llvm.riscv.ztt.mss.cm
void store_cm_i32(int *p, __riscv_ztt_i32_1x1_t v) {
  __riscv_ztt_mss_cm(p, v);
}

// Verify that the generic store infers a multi-square i16 type.
// IR-LABEL: @store_rm_i16_1x2(
// IR: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 2) %{{.*}}, i32 1073741840, i32 2)
void store_rm_i16_1x2(short *p, __riscv_ztt_i16_1x2_t v) {
  __riscv_ztt_mss_rm(p, v);
}

// Verify that rows and columns are taken from the argument type.
// IR-LABEL: @store_cm_i32_4x1(
// IR: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 4, 1) %{{.*}}, i32 1073741856, i32 4)
void store_cm_i32_4x1(int *p, __riscv_ztt_i32_4x1_t v) {
  __riscv_ztt_mss_cm(p, v);
}

// Cover unsigned, floating-point, and 128-bit public load aliases.
// IR-LABEL: @load_rm_u8_1x2(
// IR: call target("riscv.ztt.m.u8", i8, 8, 1, 2) @llvm.riscv.ztt.mls.rm
__riscv_ztt_u8_1x2_t load_rm_u8_1x2(const unsigned char *p) {
  return __riscv_ztt_mls_rm_u8_1x2(p);
}

// IR-LABEL: @load_cm_f32(
// IR: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mls.cm
__riscv_ztt_f32_1x1_t load_cm_f32(const float *p) {
  return __riscv_ztt_mls_cm_f32_1x1(p);
}

// IR-LABEL: @load_rm_i128(
// IR: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.rm
__riscv_ztt_i128_1x1_t load_rm_i128(const signed _BitInt(128) *p) {
  return __riscv_ztt_mls_rm_i128_1x1(p);
}

// The generic stores infer the complete source datatype from the C type.
// IR-LABEL: @store_rm_bf16(
// IR: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %{{.*}}, i32 540016912, i32 1)
void store_rm_bf16(__bf16 *p, __riscv_ztt_bf16_1x1_t v) {
  __riscv_ztt_mss_rm(p, v);
}

// IR-LABEL: @store_cm_u128(
// IR: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, i32 128, i32 1)
void store_cm_u128(unsigned _BitInt(128) *p, __riscv_ztt_u128_1x1_t v) {
  __riscv_ztt_mss_cm(p, v);
}

// Cover additional element datatypes. __INT64_TYPE__ is long long on RV32
// ILP32 and long on RV64 LP64, matching the target-dependent Ztt i64 element
// type on both targets.
// IR-LABEL: @load_cm_i64(
// IR: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mls.cm
__riscv_ztt_i64_1x1_t load_cm_i64(const __INT64_TYPE__ *p) {
  return __riscv_ztt_mls_cm_i64_1x1(p);
}

// IR-LABEL: @store_rm_i8_1x2(
// IR: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 2)
void store_rm_i8_1x2(signed char *p, __riscv_ztt_i8_1x2_t v) {
  __riscv_ztt_mss_rm(p, v);
}

// IR-LABEL: @store_cm_i64(
// IR: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i64", i64, 64, 1, 1)
void store_cm_i64(__INT64_TYPE__ *p, __riscv_ztt_i64_1x1_t v) {
  __riscv_ztt_mss_cm(p, v);
}
#elif defined(TEST_UDS128)
// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i8", i8, 8, 1, 16) @load_rm_i8_1x16(
// UDS128: call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741832, i32 16)
__riscv_ztt_i8_1x16_t load_rm_i8_1x16(const signed char *p) {
  return __riscv_ztt_mls_rm_i8_1x16(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_i8_1x16(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 16) %{{.*}}, i32 1073741832, i32 16)
void store_rm_i8_1x16(signed char *p, __riscv_ztt_i8_1x16_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i8", i8, 8, 1, 16) @load_cm_i8_1x16(
// UDS128: call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741832, i32 16)
__riscv_ztt_i8_1x16_t load_cm_i8_1x16(const signed char *p) {
  return __riscv_ztt_mls_cm_i8_1x16(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_i8_1x16(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 16) %{{.*}}, i32 1073741832, i32 16)
void store_cm_i8_1x16(signed char *p, __riscv_ztt_i8_1x16_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 8) @load_rm_i16_1x8(
// UDS128: call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741840, i32 8)
__riscv_ztt_i16_1x8_t load_rm_i16_1x8(const short *p) {
  return __riscv_ztt_mls_rm_i16_1x8(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_i16_1x8(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 8) %{{.*}}, i32 1073741840, i32 8)
void store_rm_i16_1x8(short *p, __riscv_ztt_i16_1x8_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 8) @load_cm_i16_1x8(
// UDS128: call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741840, i32 8)
__riscv_ztt_i16_1x8_t load_cm_i16_1x8(const short *p) {
  return __riscv_ztt_mls_cm_i16_1x8(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_i16_1x8(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 8) %{{.*}}, i32 1073741840, i32 8)
void store_cm_i16_1x8(short *p, __riscv_ztt_i16_1x8_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 4) @load_rm_i32_1x4(
// UDS128: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741856, i32 4)
__riscv_ztt_i32_1x4_t load_rm_i32_1x4(const int *p) {
  return __riscv_ztt_mls_rm_i32_1x4(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_i32_1x4(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 1, 4) %{{.*}}, i32 1073741856, i32 4)
void store_rm_i32_1x4(int *p, __riscv_ztt_i32_1x4_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 4) @load_cm_i32_1x4(
// UDS128: call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741856, i32 4)
__riscv_ztt_i32_1x4_t load_cm_i32_1x4(const int *p) {
  return __riscv_ztt_mls_cm_i32_1x4(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_i32_1x4(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 1, 4) %{{.*}}, i32 1073741856, i32 4)
void store_cm_i32_1x4(int *p, __riscv_ztt_i32_1x4_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i64", i64, 64, 1, 2) @load_rm_i64_1x2(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741888, i32 2)
__riscv_ztt_i64_1x2_t load_rm_i64_1x2(const __INT64_TYPE__ *p) {
  return __riscv_ztt_mls_rm_i64_1x2(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_i64_1x2(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i64", i64, 64, 1, 2) %{{.*}}, i32 1073741888, i32 2)
void store_rm_i64_1x2(__INT64_TYPE__ *p, __riscv_ztt_i64_1x2_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i64", i64, 64, 1, 2) @load_cm_i64_1x2(
// UDS128: call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741888, i32 2)
__riscv_ztt_i64_1x2_t load_cm_i64_1x2(const __INT64_TYPE__ *p) {
  return __riscv_ztt_mls_cm_i64_1x2(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_i64_1x2(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i64", i64, 64, 1, 2) %{{.*}}, i32 1073741888, i32 2)
void store_cm_i64_1x2(__INT64_TYPE__ *p, __riscv_ztt_i64_1x2_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @load_rm_i128_1x1(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741952, i32 1)
__riscv_ztt_i128_1x1_t load_rm_i128_1x1(const signed _BitInt(128) *p) {
  return __riscv_ztt_mls_rm_i128_1x1(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_i128_1x1(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
void store_rm_i128_1x1(signed _BitInt(128) *p, __riscv_ztt_i128_1x1_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @load_cm_i128_1x1(
// UDS128: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741952, i32 1)
__riscv_ztt_i128_1x1_t load_cm_i128_1x1(const signed _BitInt(128) *p) {
  return __riscv_ztt_mls_cm_i128_1x1(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_i128_1x1(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
void store_cm_i128_1x1(signed _BitInt(128) *p, __riscv_ztt_i128_1x1_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.u32", i32, 32, 1, 4) @load_rm_u32_1x4(
// UDS128: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 32, i32 4)
__riscv_ztt_u32_1x4_t load_rm_u32_1x4(const unsigned int *p) {
  return __riscv_ztt_mls_rm_u32_1x4(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_u32_1x4(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u32", i32, 32, 1, 4) %{{.*}}, i32 32, i32 4)
void store_rm_u32_1x4(unsigned int *p, __riscv_ztt_u32_1x4_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.u32", i32, 32, 1, 4) @load_cm_u32_1x4(
// UDS128: call target("riscv.ztt.m.u32", i32, 32, 1, 4) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 32, i32 4)
__riscv_ztt_u32_1x4_t load_cm_u32_1x4(const unsigned int *p) {
  return __riscv_ztt_mls_cm_u32_1x4(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_u32_1x4(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u32", i32, 32, 1, 4) %{{.*}}, i32 32, i32 4)
void store_cm_u32_1x4(unsigned int *p, __riscv_ztt_u32_1x4_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @load_rm_bf16_1x8(
// UDS128: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 540016912, i32 8)
__riscv_ztt_bf16_1x8_t load_rm_bf16_1x8(const __bf16 *p) {
  return __riscv_ztt_mls_rm_bf16_1x8(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_bf16_1x8(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %{{.*}}, i32 540016912, i32 8)
void store_rm_bf16_1x8(__bf16 *p, __riscv_ztt_bf16_1x8_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @load_cm_bf16_1x8(
// UDS128: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 540016912, i32 8)
__riscv_ztt_bf16_1x8_t load_cm_bf16_1x8(const __bf16 *p) {
  return __riscv_ztt_mls_cm_bf16_1x8(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_bf16_1x8(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %{{.*}}, i32 540016912, i32 8)
void store_cm_bf16_1x8(__bf16 *p, __riscv_ztt_bf16_1x8_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 4) @load_rm_f32_1x4(
// UDS128: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 540016928, i32 4)
__riscv_ztt_f32_1x4_t load_rm_f32_1x4(const float *p) {
  return __riscv_ztt_mls_rm_f32_1x4(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_f32_1x4(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f32", float, 32, 1, 4) %{{.*}}, i32 540016928, i32 4)
void store_rm_f32_1x4(float *p, __riscv_ztt_f32_1x4_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 4) @load_cm_f32_1x4(
// UDS128: call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 540016928, i32 4)
__riscv_ztt_f32_1x4_t load_cm_f32_1x4(const float *p) {
  return __riscv_ztt_mls_cm_f32_1x4(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_f32_1x4(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f32", float, 32, 1, 4) %{{.*}}, i32 540016928, i32 4)
void store_cm_f32_1x4(float *p, __riscv_ztt_f32_1x4_t value) {
  __riscv_ztt_mss_cm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 1, 2) @load_rm_f64_1x2(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 741343552, i32 2)
__riscv_ztt_f64_1x2_t load_rm_f64_1x2(const double *p) {
  return __riscv_ztt_mls_rm_f64_1x2(p);
}

// UDS128-LABEL: define{{.*}} void @store_rm_f64_1x2(
// UDS128: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f64", double, 64, 1, 2) %{{.*}}, i32 741343552, i32 2)
void store_rm_f64_1x2(double *p, __riscv_ztt_f64_1x2_t value) {
  __riscv_ztt_mss_rm(p, value);
}

// UDS128-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 1, 2) @load_cm_f64_1x2(
// UDS128: call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 741343552, i32 2)
__riscv_ztt_f64_1x2_t load_cm_f64_1x2(const double *p) {
  return __riscv_ztt_mls_cm_f64_1x2(p);
}

// UDS128-LABEL: define{{.*}} void @store_cm_f64_1x2(
// UDS128: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f64", double, 64, 1, 2) %{{.*}}, i32 741343552, i32 2)
void store_cm_f64_1x2(double *p, __riscv_ztt_f64_1x2_t value) {
  __riscv_ztt_mss_cm(p, value);
}


#elif defined(TEST_PACKED)
// Packed memory round trips, including copy/concat users of the loaded value.
// PACKED-LABEL: define{{.*}} void @packed_rm_i16(
// PACKED-SAME: ptr{{[^%]*}}[[SRC_PTR:%[^, )]+]], ptr{{[^%]*}}[[DST_PTR:%[^, )]+]])
// PACKED: [[SRC:%.*]] = {{.*}}call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[SRC_PTR]], i32 1073741840, i32 4)
// PACKED-NEXT: [[DST:%.*]] = {{.*}}call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 4) [[SRC]], i32 1073741840, i32 4)
// PACKED-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[DST_PTR]], target("riscv.ztt.m.i16", i16, 16, 1, 4) [[DST]], i32 1073741840, i32 4)
// PACKED-NEXT: ret void
void packed_rm_i16(const short *src, short *dst) {
  __riscv_ztt_i16_1x4_t m = __riscv_ztt_mls_rm_i16_1x4(src);
  __riscv_ztt_i16_1x4_t copy = __riscv_ztt_mcopy_m2m_i16_1x4(m);
  __riscv_ztt_mss_rm(dst, copy);
}

// PACKED-LABEL: define{{.*}} void @packed_cm_bf16(
// PACKED-SAME: ptr{{[^%]*}}[[SRC_PTR:%[^, )]+]], ptr{{[^%]*}}[[DST_PTR:%[^, )]+]])
// PACKED: [[SRC:%.*]] = {{.*}}call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr [[SRC_PTR]], i32 540016912, i32 4)
// PACKED-NEXT: [[DST:%.*]] = {{.*}}call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mcopy.m2m{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) [[SRC]], i32 540016912, i32 4)
// PACKED-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr [[DST_PTR]], target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) [[DST]], i32 540016912, i32 4)
// PACKED-NEXT: ret void
void packed_cm_bf16(const __bf16 *src, __bf16 *dst) {
  __riscv_ztt_bf16_4x1_t m = __riscv_ztt_mls_cm_bf16_4x1(src);
  __riscv_ztt_bf16_4x1_t copy = __riscv_ztt_mcopy_m2m_bf16_4x1(m);
  __riscv_ztt_mss_cm(dst, copy);
}

// PACKED-LABEL: define{{.*}} void @concat_i16(
// PACKED-SAME: ptr{{[^%]*}}[[SRC_PTR:%[^, )]+]], ptr{{[^%]*}}[[DST_PTR:%[^, )]+]])
// PACKED: [[SRC:%.*]] = {{.*}}call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[SRC_PTR]], i32 1073741840, i32 2)
// PACKED-NEXT: [[DST:%.*]] = {{.*}}call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) [[SRC]], target("riscv.ztt.m.i16", i16, 16, 1, 2) [[SRC]], i32 1073741840, i32 2)
// PACKED-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[DST_PTR]], target("riscv.ztt.m.i16", i16, 16, 1, 4) [[DST]], i32 1073741840, i32 4)
// PACKED-NEXT: ret void
void concat_i16(const short *src, short *dst) {
  __riscv_ztt_i16_1x2_t m = __riscv_ztt_mls_rm_i16_1x2(src);
  __riscv_ztt_i16_1x4_t joined = __riscv_ztt_mconcat_m_i16_1x4(m, m);
  __riscv_ztt_mss_rm(dst, joined);
}

// PACKED-LABEL: define{{.*}} void @concat_bf16(
// PACKED-SAME: ptr{{[^%]*}}[[SRC_PTR:%[^, )]+]], ptr{{[^%]*}}[[DST_PTR:%[^, )]+]])
// PACKED: [[SRC:%.*]] = {{.*}}call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr [[SRC_PTR]], i32 540016912, i32 2)
// PACKED-NEXT: [[DST:%.*]] = {{.*}}call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mconcat.m{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) [[SRC]], target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) [[SRC]], i32 540016912, i32 2)
// PACKED-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr [[DST_PTR]], target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) [[DST]], i32 540016912, i32 4)
// PACKED-NEXT: ret void
void concat_bf16(const __bf16 *src, __bf16 *dst) {
  __riscv_ztt_bf16_2x1_t m = __riscv_ztt_mls_cm_bf16_2x1(src);
  __riscv_ztt_bf16_4x1_t joined = __riscv_ztt_mconcat_m_bf16_4x1(m, m);
  __riscv_ztt_mss_cm(dst, joined);
}


#elif defined(TEST_DATATYPE)
// Complete descriptors must reach each metadata/element-pointer operand.
// DATATYPE-LABEL: @datatype_i8(
// DATATYPE: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741832, i32 1)
// DATATYPE: call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741832, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 1) %{{.*}}, i32 1073741832, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 1) %{{.*}}, i32 1073741832, i32 1)
void datatype_i8(signed char *p) {
  __riscv_ztt_i8_1x1_t rm = __riscv_ztt_mls_rm_i8_1x1(p);
  __riscv_ztt_i8_1x1_t cm = __riscv_ztt_mls_cm_i8_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_u8(
// DATATYPE: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 8, i32 1)
// DATATYPE: call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 8, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u8", i8, 8, 1, 1) %{{.*}}, i32 8, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u8", i8, 8, 1, 1) %{{.*}}, i32 8, i32 1)
void datatype_u8(unsigned char *p) {
  __riscv_ztt_u8_1x1_t rm = __riscv_ztt_mls_rm_u8_1x1(p);
  __riscv_ztt_u8_1x1_t cm = __riscv_ztt_mls_cm_u8_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_i16(
// DATATYPE: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741840, i32 1)
// DATATYPE: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741840, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 1) %{{.*}}, i32 1073741840, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 1) %{{.*}}, i32 1073741840, i32 1)
void datatype_i16(short *p) {
  __riscv_ztt_i16_1x1_t rm = __riscv_ztt_mls_rm_i16_1x1(p);
  __riscv_ztt_i16_1x1_t cm = __riscv_ztt_mls_cm_i16_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_u16(
// DATATYPE: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 16, i32 1)
// DATATYPE: call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 16, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u16", i16, 16, 1, 1) %{{.*}}, i32 16, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u16", i16, 16, 1, 1) %{{.*}}, i32 16, i32 1)
void datatype_u16(unsigned short *p) {
  __riscv_ztt_u16_1x1_t rm = __riscv_ztt_mls_rm_u16_1x1(p);
  __riscv_ztt_u16_1x1_t cm = __riscv_ztt_mls_cm_u16_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_i32(
// DATATYPE: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741856, i32 1)
// DATATYPE: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741856, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{.*}}, i32 1073741856, i32 1)
void datatype_i32(int *p) {
  __riscv_ztt_i32_1x1_t rm = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t cm = __riscv_ztt_mls_cm_i32_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_u32(
// DATATYPE: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 32, i32 1)
// DATATYPE: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 32, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u32", i32, 32, 1, 1) %{{.*}}, i32 32, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u32", i32, 32, 1, 1) %{{.*}}, i32 32, i32 1)
void datatype_u32(unsigned int *p) {
  __riscv_ztt_u32_1x1_t rm = __riscv_ztt_mls_rm_u32_1x1(p);
  __riscv_ztt_u32_1x1_t cm = __riscv_ztt_mls_cm_u32_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_i64(
// DATATYPE: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741888, i32 1)
// DATATYPE: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741888, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i64", i64, 64, 1, 1) %{{.*}}, i32 1073741888, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i64", i64, 64, 1, 1) %{{.*}}, i32 1073741888, i32 1)
void datatype_i64(__INT64_TYPE__ *p) {
  __riscv_ztt_i64_1x1_t rm = __riscv_ztt_mls_rm_i64_1x1(p);
  __riscv_ztt_i64_1x1_t cm = __riscv_ztt_mls_cm_i64_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_u64(
// DATATYPE: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 64, i32 1)
// DATATYPE: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 64, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u64", i64, 64, 1, 1) %{{.*}}, i32 64, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u64", i64, 64, 1, 1) %{{.*}}, i32 64, i32 1)
void datatype_u64(__UINT64_TYPE__ *p) {
  __riscv_ztt_u64_1x1_t rm = __riscv_ztt_mls_rm_u64_1x1(p);
  __riscv_ztt_u64_1x1_t cm = __riscv_ztt_mls_cm_u64_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_i128(
// DATATYPE: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1073741952, i32 1)
// DATATYPE: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 1073741952, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.i128", i128, 128, 1, 1) %{{.*}}, i32 1073741952, i32 1)
void datatype_i128(signed _BitInt(128) *p) {
  __riscv_ztt_i128_1x1_t rm = __riscv_ztt_mls_rm_i128_1x1(p);
  __riscv_ztt_i128_1x1_t cm = __riscv_ztt_mls_cm_i128_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_u128(
// DATATYPE: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 128, i32 1)
// DATATYPE: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 128, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, i32 128, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.u128", i128, 128, 1, 1) %{{.*}}, i32 128, i32 1)
void datatype_u128(unsigned _BitInt(128) *p) {
  __riscv_ztt_u128_1x1_t rm = __riscv_ztt_mls_rm_u128_1x1(p);
  __riscv_ztt_u128_1x1_t cm = __riscv_ztt_mls_cm_u128_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_f16(
// DATATYPE: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 338690320, i32 1)
// DATATYPE: call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 338690320, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f16", half, 16, 1, 1) %{{.*}}, i32 338690320, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f16", half, 16, 1, 1) %{{.*}}, i32 338690320, i32 1)
void datatype_f16(_Float16 *p) {
  __riscv_ztt_f16_1x1_t rm = __riscv_ztt_mls_rm_f16_1x1(p);
  __riscv_ztt_f16_1x1_t cm = __riscv_ztt_mls_cm_f16_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_bf16(
// DATATYPE: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 540016912, i32 1)
// DATATYPE: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 540016912, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %{{.*}}, i32 540016912, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %{{.*}}, i32 540016912, i32 1)
void datatype_bf16(__bf16 *p) {
  __riscv_ztt_bf16_1x1_t rm = __riscv_ztt_mls_rm_bf16_1x1(p);
  __riscv_ztt_bf16_1x1_t cm = __riscv_ztt_mls_cm_bf16_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_f32(
// DATATYPE: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 540016928, i32 1)
// DATATYPE: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 540016928, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f32", float, 32, 1, 1) %{{.*}}, i32 540016928, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f32", float, 32, 1, 1) %{{.*}}, i32 540016928, i32 1)
void datatype_f32(float *p) {
  __riscv_ztt_f32_1x1_t rm = __riscv_ztt_mls_rm_f32_1x1(p);
  __riscv_ztt_f32_1x1_t cm = __riscv_ztt_mls_cm_f32_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}

// DATATYPE-LABEL: @datatype_f64(
// DATATYPE: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 741343552, i32 1)
// DATATYPE: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mls.cm{{.*}}(ptr %{{.*}}, i32 741343552, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, i32 741343552, i32 1)
// DATATYPE: call void @llvm.riscv.ztt.mss.cm{{.*}}(ptr %{{.*}}, target("riscv.ztt.m.f64", double, 64, 1, 1) %{{.*}}, i32 741343552, i32 1)
void datatype_f64(double *p) {
  __riscv_ztt_f64_1x1_t rm = __riscv_ztt_mls_rm_f64_1x1(p);
  __riscv_ztt_f64_1x1_t cm = __riscv_ztt_mls_cm_f64_1x1(p);
  __riscv_ztt_mss_rm(p, rm);
  __riscv_ztt_mss_cm(p, cm);
}


#endif
