// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
__riscv_ztt_i8_1x4_t test_0(const signed char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i8_1x4(base, stride); }
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE0:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE0:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE0]], i{{32|64}} %[[STRIDE0]], i32 1073741832, i32 4)
__riscv_ztt_u8_8x1_t test_1(const unsigned char *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u8_8x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE1:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE1:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u8", i8, 8, 8, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE1]], i{{32|64}} %[[STRIDE1]], i32 8, i32 8)
__riscv_ztt_i16_1x2_t test_2(const short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i16_1x2(base, stride); }
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE2:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE2:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE2]], i{{32|64}} %[[STRIDE2]], i32 1073741840, i32 2)
__riscv_ztt_u16_4x1_t test_3(const unsigned short *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u16_4x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE3:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE3:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u16", i16, 16, 4, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE3]], i{{32|64}} %[[STRIDE3]], i32 16, i32 4)
__riscv_ztt_i32_1x1_t test_4(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE4:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE4:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE4]], i{{32|64}} %[[STRIDE4]], i32 1073741856, i32 1)
__riscv_ztt_u32_2x1_t test_5(const unsigned int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u32_2x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE5:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE5:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u32", i32, 32, 2, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE5]], i{{32|64}} %[[STRIDE5]], i32 32, i32 2)
__riscv_ztt_i64_1x1_t test_6(const __INT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i64_1x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE6:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE6:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE6]], i{{32|64}} %[[STRIDE6]], i32 1073741888, i32 1)
__riscv_ztt_u64_2x1_t test_7(const __UINT64_TYPE__ *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u64_2x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE7:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE7:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u64", i64, 64, 2, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE7]], i{{32|64}} %[[STRIDE7]], i32 64, i32 2)
__riscv_ztt_i128_1x1_t test_8(const _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i128_1x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE8:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE8:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE8]], i{{32|64}} %[[STRIDE8]], i32 1073741952, i32 1)
__riscv_ztt_u128_2x1_t test_9(const unsigned _BitInt(128) *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_u128_2x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE9:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE9:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.u128", i128, 128, 2, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE9]], i{{32|64}} %[[STRIDE9]], i32 128, i32 2)
__riscv_ztt_f16_1x2_t test_10(const _Float16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f16_1x2(base, stride); }
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE10:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE10:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f16", half, 16, 1, 2) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE10]], i{{32|64}} %[[STRIDE10]], i32 338690320, i32 2)
__riscv_ztt_bf16_4x1_t test_11(const __bf16 *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_bf16_4x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE11:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE11:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE11]], i{{32|64}} %[[STRIDE11]], i32 540016912, i32 4)
__riscv_ztt_f32_1x1_t test_12(const float *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f32_1x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE12:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE12:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE12]], i{{32|64}} %[[STRIDE12]], i32 540016928, i32 1)
__riscv_ztt_f64_2x1_t test_13(const double *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_f64_2x1(base, stride); }
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE13:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE13:[^ ,)]+]]
// CHECK: call target("riscv.ztt.m.f64", double, 64, 2, 1) @llvm.riscv.ztt.mls.st{{.*}}(ptr %[[BASE13]], i{{32|64}} %[[STRIDE13]], i32 741343552, i32 2)
__riscv_ztt_i32_1x1_t zero_stride(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, 0); }
// CHECK-LABEL: @zero_stride(
// RV32: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i32 0, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i64 0, i32 1073741856, i32 1)
__riscv_ztt_i32_1x1_t odd_stride(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, 1); }
// CHECK-LABEL: @odd_stride(
// RV32: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i32 1, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i64 1, i32 1073741856, i32 1)
__riscv_ztt_i32_1x1_t negative_stride(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, -1); }
// CHECK-LABEL: @negative_stride(
// RV32: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i32 -1, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i64 -1, i32 1073741856, i32 1)
__riscv_ztt_i32_1x1_t wide_stride(const int *base, __SIZE_TYPE__ stride) { return __riscv_ztt_mls_st_i32_1x1(base, 4294967297ULL); }
// CHECK-LABEL: @wide_stride(
// RV32: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i32 1, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mls.st{{.*}}(ptr %{{[^,]+}}, i64 4294967297, i32 1073741856, i32 1)
#ifdef __cplusplus
}
#endif
