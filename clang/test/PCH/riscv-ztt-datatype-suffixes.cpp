// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DHEADER -emit-pch -o %t.32 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -include-pch %t.32 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DHEADER -emit-pch -o %t.64 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -include-pch %t.64 -emit-llvm -o - %s | FileCheck %s

#ifdef HEADER
#include <riscv_ztt.h>
using Matrix = __riscv_ztt_i16_rod_sat_1x1_t;
using Acc = __riscv_ztt_f32_rno_accx2_t;
using Scalar = __riscv_ztt_i16_rdn_scalar_t;
using Default = __riscv_ztt_i16_rnu_1x1_t;
// Instantiation after PCH reading must retain the hidden marker, the complete
// result type and the real-operand list. No marker may escape into IR.
template <int N> void make(short *out, short value) {
  Matrix m = __riscv_ztt_mzero_m_i16_rod_sat_1x1();
  Scalar scalar = value;
  Matrix r = __riscv_ztt_madd_ew_x_i16_rod_sat_1x1(m, scalar);
  __riscv_ztt_mss_rm(out, r);
  Acc a = __riscv_ztt_mzero_acc_f32_rno_accx2();
}
#undef HEADER
#else
static_assert(__is_same(Matrix, __riscv_ztt_i16_rod_sat_1x1_t), "matrix options");
static_assert(__is_same(Acc, __riscv_ztt_f32_rno_accx2_t), "ACC options");
static_assert(__is_same(Scalar, __riscv_ztt_i16_rdn_scalar_t), "scalar options");
static_assert(__is_same(Default, __riscv_ztt_i16_1x1_t), "default alias");
template void make<0>(short *, short);
#endif

// CHECK: call target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 2013265936, i32 1)
// CHECK: call target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) @llvm.riscv.ztt.madd.ew.x{{.*}}(target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 2013265936, i32 1342177296, i32 1)
// CHECK: call target("riscv.ztt.acc.f32_rno", float, 32, 2) @llvm.riscv.ztt.mzero.acc{{.*}}(i32 560988448, i32 2)
