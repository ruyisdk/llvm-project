// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -emit-llvm %s -o - | FileCheck %s

#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

// Independent descriptor expectations from spec 2.4:
// signed=30, sat=29, integer rounding=28:27; float rounding=25:22.
// mzero represents the shared result encoder. No per-instruction suffix matrix.

// A raw call uses the same type/descriptor path as a public lazy declaration.
// Its compile-time marker must never become an LLVM call operand.
// CHECK-LABEL: @raw_zero(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1073741840, i32 1)
// CHECK: call target("riscv.ztt.m.i16_rne", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1207959568, i32 1)
void raw_zero(void) {
  __riscv_ztt_i16_1x1_t a =
      __builtin_riscv_ztt_mzero_m((__riscv_ztt_i16_1x1_t *)0);
  __riscv_ztt_i16_rne_1x1_t b =
      __builtin_riscv_ztt_mzero_m((__riscv_ztt_i16_rne_1x1_t *)0);
}

// CHECK-LABEL: @zero_i16_rnu(
// CHECK: call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1073741840, i32 1)
void zero_i16_rnu(void) {
  __riscv_ztt_i16_rnu_1x1_t m = __riscv_ztt_mzero_m_i16_rnu_1x1();
}

// CHECK-LABEL: @zero_i16_rne(
// CHECK: call target("riscv.ztt.m.i16_rne", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1207959568, i32 1)
void zero_i16_rne(void) {
  __riscv_ztt_i16_rne_1x1_t m = __riscv_ztt_mzero_m_i16_rne_1x1();
}

// CHECK-LABEL: @zero_i16_rdn(
// CHECK: call target("riscv.ztt.m.i16_rdn", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1342177296, i32 1)
void zero_i16_rdn(void) {
  __riscv_ztt_i16_rdn_1x1_t m = __riscv_ztt_mzero_m_i16_rdn_1x1();
}

// CHECK-LABEL: @zero_i16_rod(
// CHECK: call target("riscv.ztt.m.i16_rod", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1476395024, i32 1)
void zero_i16_rod(void) {
  __riscv_ztt_i16_rod_1x1_t m = __riscv_ztt_mzero_m_i16_rod_1x1();
}

// CHECK-LABEL: @zero_i16_rnu_sat(
// CHECK: call target("riscv.ztt.m.i16_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1610612752, i32 1)
void zero_i16_rnu_sat(void) {
  __riscv_ztt_i16_rnu_sat_1x1_t m = __riscv_ztt_mzero_m_i16_rnu_sat_1x1();
}

// CHECK-LABEL: @zero_i16_rne_sat(
// CHECK: call target("riscv.ztt.m.i16_rne_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1744830480, i32 1)
void zero_i16_rne_sat(void) {
  __riscv_ztt_i16_rne_sat_1x1_t m = __riscv_ztt_mzero_m_i16_rne_sat_1x1();
}

// CHECK-LABEL: @zero_i16_rdn_sat(
// CHECK: call target("riscv.ztt.m.i16_rdn_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 1879048208, i32 1)
void zero_i16_rdn_sat(void) {
  __riscv_ztt_i16_rdn_sat_1x1_t m = __riscv_ztt_mzero_m_i16_rdn_sat_1x1();
}

// CHECK-LABEL: @zero_i16_rod_sat(
// CHECK: call target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 2013265936, i32 1)
void zero_i16_rod_sat(void) {
  __riscv_ztt_i16_rod_sat_1x1_t m = __riscv_ztt_mzero_m_i16_rod_sat_1x1();
}

// CHECK-LABEL: @zero_u16_rod_sat(
// CHECK: call target("riscv.ztt.m.u16_rod_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 939524112, i32 1)
void zero_u16_rod_sat(void) {
  __riscv_ztt_u16_rod_sat_1x1_t m = __riscv_ztt_mzero_m_u16_rod_sat_1x1();
}

// CHECK-LABEL: @zero_f32_rne(
// CHECK: call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 540016928, i32 1)
void zero_f32_rne(void) {
  __riscv_ztt_f32_rne_1x1_t m = __riscv_ztt_mzero_m_f32_rne_1x1();
}

// CHECK-LABEL: @zero_f32_rtz(
// CHECK: call target("riscv.ztt.m.f32_rtz", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 544211232, i32 1)
void zero_f32_rtz(void) {
  __riscv_ztt_f32_rtz_1x1_t m = __riscv_ztt_mzero_m_f32_rtz_1x1();
}

// CHECK-LABEL: @zero_f32_rdn(
// CHECK: call target("riscv.ztt.m.f32_rdn", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 548405536, i32 1)
void zero_f32_rdn(void) {
  __riscv_ztt_f32_rdn_1x1_t m = __riscv_ztt_mzero_m_f32_rdn_1x1();
}

// CHECK-LABEL: @zero_f32_rup(
// CHECK: call target("riscv.ztt.m.f32_rup", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 552599840, i32 1)
void zero_f32_rup(void) {
  __riscv_ztt_f32_rup_1x1_t m = __riscv_ztt_mzero_m_f32_rup_1x1();
}

// CHECK-LABEL: @zero_f32_rmm(
// CHECK: call target("riscv.ztt.m.f32_rmm", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 556794144, i32 1)
void zero_f32_rmm(void) {
  __riscv_ztt_f32_rmm_1x1_t m = __riscv_ztt_mzero_m_f32_rmm_1x1();
}

// CHECK-LABEL: @zero_f32_rno(
// CHECK: call target("riscv.ztt.m.f32_rno", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 560988448, i32 1)
void zero_f32_rno(void) {
  __riscv_ztt_f32_rno_1x1_t m = __riscv_ztt_mzero_m_f32_rno_1x1();
}

// CHECK-LABEL: @zero_f16_rno(
// CHECK: call target("riscv.ztt.m.f16_rno", half, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 359661840, i32 1)
void zero_f16_rno(void) {
  __riscv_ztt_f16_rno_1x1_t m = __riscv_ztt_mzero_m_f16_rno_1x1();
}

// CHECK-LABEL: @zero_bf16_rno(
// CHECK: call target("riscv.ztt.m.bf16_rno", bfloat, 16, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 560988432, i32 1)
void zero_bf16_rno(void) {
  __riscv_ztt_bf16_rno_1x1_t m = __riscv_ztt_mzero_m_bf16_rno_1x1();
}

// CHECK-LABEL: @zero_f64_rno(
// CHECK: call target("riscv.ztt.m.f64_rno", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m{{.*}}(i32 762315072, i32 1)
void zero_f64_rno(void) {
  __riscv_ztt_f64_rno_1x1_t m = __riscv_ztt_mzero_m_f64_rno_1x1();
}

// CHECK-LABEL: @acc_suffix(
// CHECK: call target("riscv.ztt.acc.f32_rno", float, 32, 2) @llvm.riscv.ztt.mzero.acc{{.*}}(i32 560988448, i32 2)
void acc_suffix(void) {
  __riscv_ztt_f32_rno_accx2_t a = __riscv_ztt_mzero_acc_f32_rno_accx2();
}

// The scalar descriptor has its own mode/sat, independent of the result.
// The marker contributes neither an IR operand nor a wrapper call.
// CHECK-LABEL: @scalar_suffix(
// CHECK: call target("riscv.ztt.m.i16_rdn", i16, 16, 1, 1) @llvm.riscv.ztt.madd.ew.x{{.*}}(target("riscv.ztt.m.i16_rdn", i16, 16, 1, 1) %{{.*}}, i{{32|64}} %{{.*}}, i32 1342177296, i32 2013265936, i32 1)
void scalar_suffix(short x, short *out) {
  __riscv_ztt_i16_rod_sat_scalar_t scalar = x;
  __riscv_ztt_i16_rdn_1x1_t a = __riscv_ztt_mzero_m_i16_rdn_1x1();
  __riscv_ztt_i16_rdn_1x1_t b = __riscv_ztt_madd_ew_x_i16_rdn_1x1(a, scalar);
  __riscv_ztt_mss_rm(out, b);
}

// The pointee remains the C carrier type, not a suffix-specific scalar type.
// CHECK-LABEL: @load_suffix(
// CHECK: call target("riscv.ztt.m.i16_rne_sat", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr %{{.*}}, i32 1744830480, i32 1)
void load_suffix(const short *in, short *out) {
  __riscv_ztt_i16_rne_sat_1x1_t a = __riscv_ztt_mls_rm_i16_rne_sat_1x1(in);
  __riscv_ztt_mss_rm(out, a);
}
#ifdef __cplusplus
}
#endif
