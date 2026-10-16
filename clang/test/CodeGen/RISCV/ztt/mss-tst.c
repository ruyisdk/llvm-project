// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64
#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif
void test_0(signed char *base, __SIZE_TYPE__ stride, __riscv_ztt_i8_1x4_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_0(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE0:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE0:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[SRC0:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE0]], i{{32|64}} %[[STRIDE0]], target("riscv.ztt.m.i8", i8, 8, 1, 4) %[[SRC0]], i32 1073741832, i32 4)
void test_1(unsigned char *base, __SIZE_TYPE__ stride, __riscv_ztt_u8_8x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_1(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE1:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE1:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u8", i8, 8, 8, 1) %[[SRC1:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE1]], i{{32|64}} %[[STRIDE1]], target("riscv.ztt.m.u8", i8, 8, 8, 1) %[[SRC1]], i32 8, i32 8)
void test_2(short *base, __SIZE_TYPE__ stride, __riscv_ztt_i16_1x2_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_2(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE2:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE2:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[SRC2:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE2]], i{{32|64}} %[[STRIDE2]], target("riscv.ztt.m.i16", i16, 16, 1, 2) %[[SRC2]], i32 1073741840, i32 2)
void test_3(unsigned short *base, __SIZE_TYPE__ stride, __riscv_ztt_u16_4x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_3(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE3:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE3:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u16", i16, 16, 4, 1) %[[SRC3:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE3]], i{{32|64}} %[[STRIDE3]], target("riscv.ztt.m.u16", i16, 16, 4, 1) %[[SRC3]], i32 16, i32 4)
void test_4(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_4(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE4:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE4:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[SRC4:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE4]], i{{32|64}} %[[STRIDE4]], target("riscv.ztt.m.i32", i32, 32, 1, 1) %[[SRC4]], i32 1073741856, i32 1)
void test_5(unsigned int *base, __SIZE_TYPE__ stride, __riscv_ztt_u32_2x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_5(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE5:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE5:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u32", i32, 32, 2, 1) %[[SRC5:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE5]], i{{32|64}} %[[STRIDE5]], target("riscv.ztt.m.u32", i32, 32, 2, 1) %[[SRC5]], i32 32, i32 2)
void test_6(__INT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_i64_1x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_6(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE6:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE6:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[SRC6:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE6]], i{{32|64}} %[[STRIDE6]], target("riscv.ztt.m.i64", i64, 64, 1, 1) %[[SRC6]], i32 1073741888, i32 1)
void test_7(__UINT64_TYPE__ *base, __SIZE_TYPE__ stride, __riscv_ztt_u64_2x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_7(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE7:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE7:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u64", i64, 64, 2, 1) %[[SRC7:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE7]], i{{32|64}} %[[STRIDE7]], target("riscv.ztt.m.u64", i64, 64, 2, 1) %[[SRC7]], i32 64, i32 2)
void test_8(_BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_i128_1x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_8(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE8:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE8:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[SRC8:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE8]], i{{32|64}} %[[STRIDE8]], target("riscv.ztt.m.i128", i128, 128, 1, 1) %[[SRC8]], i32 1073741952, i32 1)
void test_9(unsigned _BitInt(128) *base, __SIZE_TYPE__ stride, __riscv_ztt_u128_2x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_9(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE9:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE9:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.u128", i128, 128, 2, 1) %[[SRC9:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE9]], i{{32|64}} %[[STRIDE9]], target("riscv.ztt.m.u128", i128, 128, 2, 1) %[[SRC9]], i32 128, i32 2)
void test_10(_Float16 *base, __SIZE_TYPE__ stride, __riscv_ztt_f16_1x2_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_10(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE10:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE10:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC10:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE10]], i{{32|64}} %[[STRIDE10]], target("riscv.ztt.m.f16", half, 16, 1, 2) %[[SRC10]], i32 338690320, i32 2)
void test_11(__bf16 *base, __SIZE_TYPE__ stride, __riscv_ztt_bf16_4x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_11(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE11:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE11:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %[[SRC11:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE11]], i{{32|64}} %[[STRIDE11]], target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %[[SRC11]], i32 540016912, i32 4)
void test_12(float *base, __SIZE_TYPE__ stride, __riscv_ztt_f32_1x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_12(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE12:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE12:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC12:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE12]], i{{32|64}} %[[STRIDE12]], target("riscv.ztt.m.f32", float, 32, 1, 1) %[[SRC12]], i32 540016928, i32 1)
void test_13(double *base, __SIZE_TYPE__ stride, __riscv_ztt_f64_2x1_t src) { __riscv_ztt_mss_tst(base, stride, src); }
// CHECK-LABEL: define{{.*}} @test_13(
// CHECK-SAME: ptr{{[^%]*}} %[[BASE13:[^ ,)]+]]
// CHECK-SAME: i{{32|64}}{{[^%]*}} %[[STRIDE13:[^ ,)]+]]
// CHECK-SAME: target("riscv.ztt.m.f64", double, 64, 2, 1) %[[SRC13:[^ ,)]+]]
// CHECK: call void @llvm.riscv.ztt.mss.tst{{.*}}(ptr %[[BASE13]], i{{32|64}} %[[STRIDE13]], target("riscv.ztt.m.f64", double, 64, 2, 1) %[[SRC13]], i32 741343552, i32 2)
void zero_stride(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_tst(base, 0, src); }
// CHECK-LABEL: @zero_stride(
// RV32: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i32 0, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i64 0, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
void odd_stride(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_tst(base, 1, src); }
// CHECK-LABEL: @odd_stride(
// RV32: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i32 1, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i64 1, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
void negative_stride(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_tst(base, -1, src); }
// CHECK-LABEL: @negative_stride(
// RV32: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i32 -1, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i64 -1, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
void wide_stride(int *base, __SIZE_TYPE__ stride, __riscv_ztt_i32_1x1_t src) { __riscv_ztt_mss_tst(base, 4294967297ULL, src); }
// CHECK-LABEL: @wide_stride(
// RV32: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i32 1, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
// RV64: @llvm.riscv.ztt.mss.tst{{.*}}(ptr %{{[^,]+}}, i64 4294967297, target("riscv.ztt.m.i32", i32, 32, 1, 1) %{{[^ ,)]+}}, i32 1073741856, i32 1)
#ifdef __cplusplus
}
#endif
