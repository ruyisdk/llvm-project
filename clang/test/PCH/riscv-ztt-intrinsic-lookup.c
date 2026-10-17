// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DHEADER -emit-pch -o %t.32 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -include-pch %t.32 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DHEADER -emit-pch -o %t.64 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -include-pch %t.64 -emit-llvm -o - %s | FileCheck %s

#ifdef HEADER
#include <riscv_ztt.h>
// No intrinsic has been looked up when the PCH is written. Its pragma state
// must enable fresh declarations after reading the PCH.
#undef HEADER
#else
void after_pch(void) {
  __riscv_ztt_i16_rod_sat_1x1_t m = __riscv_ztt_mzero_m_i16_rod_sat_1x1();
  __riscv_ztt_i16_rod_sat_accx1_t a = __riscv_ztt_mcopy_m2a_i16_rod_sat_accx1(m);
}
#endif

// CHECK-LABEL: @after_pch(
// CHECK: call target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 2013265936, i32 1)
// CHECK: call target("riscv.ztt.acc.i16_rod_sat", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a{{.*}}(target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) %{{.*}}, i32 2013265936, i32 1)
