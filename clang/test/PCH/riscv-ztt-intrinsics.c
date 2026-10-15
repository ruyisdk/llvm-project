// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c-header -DHEADER -emit-pch -o %t.32 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -include-pch %t.32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c-header -DHEADER -emit-pch -o %t.64 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -include-pch %t.64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++-header -DHEADER -emit-pch -o %t.cpp32 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++ -include-pch %t.cpp32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++-header -DHEADER -emit-pch -o %t.cpp64 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++ -include-pch %t.cpp64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c-header -DHEADER -DDISABLED_HEADER -emit-pch -o %t.disabled32 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -include-pch %t.disabled32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++-header -DHEADER -DDISABLED_HEADER -emit-pch -o %t.disabled64 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++ -include-pch %t.disabled64 -fsyntax-only -verify %s

#ifdef HEADER
#include <riscv_vector.h>
#ifndef DISABLED_HEADER
#include <riscv_ztt.h>

void cached(__riscv_ztt_i32_1x1_t a, size_t n) {
  (void)__riscv_ztt_madd_ew_i32_1x1(a, a);
  (void)__riscv_vsetvl_e32m1(n);
}

#ifdef __cplusplus
template <typename T> __riscv_ztt_i32_1x1_t delayed(T a) {
  return __riscv_ztt_msub_ew_i32_1x1(a, a);
}
#endif
#endif
#undef HEADER
#elif defined(DISABLED_HEADER)
// An RVV-only PCH must not enable RISC-V Ztt public names.
void still_disabled(size_t n) {
  (void)__riscv_vsetvl_e8m1(n);
  __riscv_ztt_ame_release(); // expected-error {{undeclared}}
}
#else
// Reuse a serialized declaration and look up new RISC-V Ztt and RVV names.
void restored(__riscv_ztt_i32_1x1_t a, __riscv_ztt_i32_1x2_t row, size_t n) {
  (void)__riscv_ztt_madd_ew_i32_1x1(a, a);
  (void)__riscv_ztt_mcopy_m2a_i32_accx1(a);
  (void)__riscv_ztt_mzero_m_i32_rne_1x1();
  (void)__riscv_vsetvl_e8m1(n);
  (void)__riscv_ztt_madd_ew_i32_1x1(a, row); // expected-error {{madd.ew operands violate}}
#ifdef __cplusplus
  (void)delayed(a);
#endif
}
#endif
