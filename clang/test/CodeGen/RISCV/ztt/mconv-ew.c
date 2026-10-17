// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

__riscv_ztt_i4_1x8_t test_0(__riscv_ztt_i4_1x8_t src) {
  return __riscv_ztt_mconv_ew_i4_1x8(src);
}
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: target("riscv.ztt.m.i4", i4, 4, 1, 8) %[[SRC0:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i4", i4, 4, 1, 8) %[[SRC0]], i32 1073741828, i32 8)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 1, 8)

__riscv_ztt_u4_8x1_t test_1(__riscv_ztt_u4_8x1_t src) {
  return __riscv_ztt_mconv_ew_u4_8x1(src);
}
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: target("riscv.ztt.m.u4", i4, 4, 8, 1) %[[SRC1:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u4", i4, 4, 8, 1) %[[SRC1]], i32 4, i32 8)
// CHECK: ret target("riscv.ztt.m.u4", i4, 4, 8, 1)

__riscv_ztt_i8_1x4_t test_2(__riscv_ztt_i8_1x4_t src) {
  return __riscv_ztt_mconv_ew_i8_1x4(src);
}
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[SRC2:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[SRC2]], i32 1073741832, i32 4)
// CHECK: ret target("riscv.ztt.m.i8", i8, 8, 1, 4)

__riscv_ztt_u8_4x1_t test_3(__riscv_ztt_u8_4x1_t src) {
  return __riscv_ztt_mconv_ew_u8_4x1(src);
}
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[SRC3:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 4, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[SRC3]], i32 8, i32 4)
// CHECK: ret target("riscv.ztt.m.u8", i8, 8, 4, 1)

__riscv_ztt_i16_1x2_t test_4(__riscv_ztt_i16_1x2_t src) {
  return __riscv_ztt_mconv_ew_i16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[SRC4:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[SRC4]], i32 1073741840, i32 2)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 1, 2)

__riscv_ztt_u16_2x1_t test_5(__riscv_ztt_u16_2x1_t src) {
  return __riscv_ztt_mconv_ew_u16_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 2, 1) %[[SRC5:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 2, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u16", i16, 16, 2, 1) %[[SRC5]], i32 16, i32 2)
// CHECK: ret target("riscv.ztt.m.u16", i16, 16, 2, 1)

__riscv_ztt_i32_1x1_t test_6(__riscv_ztt_i32_1x1_t src) {
  return __riscv_ztt_mconv_ew_i32_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[SRC6:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[SRC6]], i32 1073741856, i32 1)
// CHECK: ret target("riscv.ztt.m.i32", i32, 32, 1, 1)

__riscv_ztt_u32_1x1_t test_7(__riscv_ztt_u32_1x1_t src) {
  return __riscv_ztt_mconv_ew_u32_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[SRC7:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u32", i32, 32, 1, 1) %[[SRC7]], i32 32, i32 1)
// CHECK: ret target("riscv.ztt.m.u32", i32, 32, 1, 1)

__riscv_ztt_i64_1x1_t test_8(__riscv_ztt_i64_1x1_t src) {
  return __riscv_ztt_mconv_ew_i64_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[SRC8:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[SRC8]], i32 1073741888, i32 1)
// CHECK: ret target("riscv.ztt.m.i64", i64, 64, 1, 1)

__riscv_ztt_u64_1x1_t test_9(__riscv_ztt_u64_1x1_t src) {
  return __riscv_ztt_mconv_ew_u64_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[SRC9:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u64", i64, 64, 1, 1) %[[SRC9]], i32 64, i32 1)
// CHECK: ret target("riscv.ztt.m.u64", i64, 64, 1, 1)

__riscv_ztt_i128_1x1_t test_10(__riscv_ztt_i128_1x1_t src) {
  return __riscv_ztt_mconv_ew_i128_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[SRC10:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[SRC10]], i32 1073741952, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)

__riscv_ztt_u128_1x1_t test_11(__riscv_ztt_u128_1x1_t src) {
  return __riscv_ztt_mconv_ew_u128_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[SRC11:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[SRC11]], i32 128, i32 1)
// CHECK: ret target("riscv.ztt.m.u128", i128, 128, 1, 1)

__riscv_ztt_f16_1x2_t test_12(__riscv_ztt_f16_1x2_t src) {
  return __riscv_ztt_mconv_ew_f16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC12:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC12]], i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_bf16_2x1_t test_13(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_mconv_ew_bf16_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC13:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC13]], i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 2, 1)

__riscv_ztt_f32_1x1_t test_14(__riscv_ztt_f32_1x1_t src) {
  return __riscv_ztt_mconv_ew_f32_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_14(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC14:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC14]], i32 540016928, i32 1)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 1, 1)

__riscv_ztt_f64_1x1_t test_15(__riscv_ztt_f64_1x1_t src) {
  return __riscv_ztt_mconv_ew_f64_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_15(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 1) %[[SRC15:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 1) %[[SRC15]], i32 741343552, i32 1)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 1)

__riscv_ztt_bf16_1x2_t test_16(__riscv_ztt_f32_1x2_t src) {
  return __riscv_ztt_mconv_ew_bf16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_16(
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 2) %[[SRC16:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f32", float, 32, 1, 2) %[[SRC16]], i32 540016912, i32 2)
// CHECK: ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2)

__riscv_ztt_f64_2x1_t test_17(__riscv_ztt_bf16_2x1_t src) {
  return __riscv_ztt_mconv_ew_f64_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_17(
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC17:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %[[SRC17]], i32 741343552, i32 2)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 2, 1)

__riscv_ztt_f16_1x2_t test_18(__riscv_ztt_f64_1x2_t src) {
  return __riscv_ztt_mconv_ew_f16_1x2(src);
}
// CHECK-LABEL: define{{.*}} @test_18(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 1, 2) %[[SRC18:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 1, 2) %[[SRC18]], i32 338690320, i32 2)
// CHECK: ret target("riscv.ztt.m.f16", half, 16, 1, 2)

__riscv_ztt_f32_2x1_t test_19(__riscv_ztt_f16_2x1_t src) {
  return __riscv_ztt_mconv_ew_f32_2x1(src);
}
// CHECK-LABEL: define{{.*}} @test_19(
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 2, 1) %[[SRC19:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f16", half, 16, 2, 1) %[[SRC19]], i32 540016928, i32 2)
// CHECK: ret target("riscv.ztt.m.f32", float, 32, 2, 1)

__riscv_ztt_f64_1x4_t test_20(__riscv_ztt_i8_1x4_t src) {
  return __riscv_ztt_mconv_ew_f64_1x4(src);
}
// CHECK-LABEL: define{{.*}} @test_20(
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[SRC20:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.f64", double, 64, 1, 4) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[SRC20]], i32 741343552, i32 4)
// CHECK: ret target("riscv.ztt.m.f64", double, 64, 1, 4)

__riscv_ztt_i4_8x1_t test_21(__riscv_ztt_f64_8x1_t src) {
  return __riscv_ztt_mconv_ew_i4_8x1(src);
}
// CHECK-LABEL: define{{.*}} @test_21(
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 8, 1) %[[SRC21:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i4", i4, 4, 8, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.f64", double, 64, 8, 1) %[[SRC21]], i32 1073741828, i32 8)
// CHECK: ret target("riscv.ztt.m.i4", i4, 4, 8, 1)

__riscv_ztt_i128_1x1_t test_22(__riscv_ztt_u128_1x1_t src) {
  return __riscv_ztt_mconv_ew_i128_1x1(src);
}
// CHECK-LABEL: define{{.*}} @test_22(
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[SRC22:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u128", i128, 128, 1, 1) %[[SRC22]], i32 1073741952, i32 1)
// CHECK: ret target("riscv.ztt.m.i128", i128, 128, 1, 1)

__riscv_ztt_i16_4x1_t test_23(__riscv_ztt_u8_4x1_t src) {
  return __riscv_ztt_mconv_ew_i16_4x1(src);
}
// CHECK-LABEL: define{{.*}} @test_23(
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[SRC23:[^ ,)]+]])
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mconv.ew{{.*}}(target("riscv.ztt.m.u8", i8, 8, 4, 1) %[[SRC23]], i32 1073741840, i32 4)
// CHECK: ret target("riscv.ztt.m.i16", i16, 16, 4, 1)
#ifdef __cplusplus
}
#endif
