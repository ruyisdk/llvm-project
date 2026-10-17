// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -O1 -emit-llvm -o - %s | FileCheck %s

#include <riscv_ztt.h>

__riscv_ztt_i32_accx1_t
test_i16_i16_i32(__riscv_ztt_i32_accx1_t acc,
                 __riscv_ztt_i16_1x2_t lhs,
                 __riscv_ztt_i16_2x1_t rhs) {
  return __riscv_ztt_mmulacc_2d_i32_accx1(acc, lhs, rhs);
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i32", i32, 32, 1) @test_i16_i16_i32(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulacc.2d{{.*}}(target("riscv.ztt.acc.i32", i32, 32, 1) %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 1, 2) %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 2, 1) %{{.*}}, i32 2)

__riscv_ztt_i32_accx4_t
test_mixed_sources(__riscv_ztt_i32_accx4_t acc,
                   __riscv_ztt_i8_1x4_t lhs,
                   __riscv_ztt_i16_4x1_t rhs) {
  return __riscv_ztt_mmulacc_2d_i32_accx4(acc, lhs, rhs);
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i32", i32, 32, 4) @test_mixed_sources(
// CHECK: call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mmulacc.2d{{.*}}(target("riscv.ztt.acc.i32", i32, 32, 4) %{{.*}}, target("riscv.ztt.m.i8", i8, 8, 1, 4) %{{.*}}, target("riscv.ztt.m.i16", i16, 16, 4, 1) %{{.*}}, i32 4)

__riscv_ztt_bf16_accx2_t
test_bf16(__riscv_ztt_bf16_accx2_t acc,
          __riscv_ztt_bf16_1x2_t lhs,
          __riscv_ztt_bf16_2x1_t rhs) {
  return __riscv_ztt_mmulacc_2d_bf16_accx2(acc, lhs, rhs);
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.bf16", bfloat, 16, 2) @test_bf16(
// CHECK: call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mmulacc.2d{{.*}}(target("riscv.ztt.acc.bf16", bfloat, 16, 2) %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %{{.*}}, target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %{{.*}}, i32 2)
