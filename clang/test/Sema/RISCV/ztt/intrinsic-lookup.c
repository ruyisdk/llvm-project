// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fno-spell-checking -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fno-spell-checking -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fno-spell-checking -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fno-spell-checking -fsyntax-only -verify %s

void before_header(void) {
  (void)__riscv_ztt_mzero_m_i16_1x8(); // expected-error {{undeclared}}
}

#include <riscv_ztt.h>

// Datatype variants share an operation-level builtin, not enumerated IDs.
#if !__has_builtin(__builtin_riscv_ztt_mzero_m) || \
    __has_builtin(__builtin_riscv_ztt_mzero_m_i16_1x1)
#error Ztt must use one builtin per operation.
#endif

#if defined(__riscv_ztt_mzero_m_i16_1x1) || defined(__riscv_ztt_mzero_m_i16_rne_sat_1x1)
#error Public intrinsic declarations must be lazy, not header macros.
#endif

typedef __riscv_ztt_i16_1x1_t __riscv_ztt_invented_t;

// API-defined control conversions still accept large constants silently.
// These cover size_t, int and long, without duplicating each instruction's
// shape/datatype tests. Stride conversion is also covered by its existing tests.
void control_conversions(__riscv_ztt_i32_1x1_t m) {
  (void)__riscv_ztt_msll_ew_x_i32_1x1(m, 0x100000001ULL);
  (void)__riscv_ztt_mrowshift_ew_x_i32_1x1(m, 0x100000001ULL);
  (void)__riscv_ztt_mldexp_ew_x_i32_1x1(m, 0x100000001ULL);
  (void)__riscv_ztt_ame_acquire(0x100000001ULL);
}

void lookup(void) {
  __riscv_ztt_i16_1x1_t a = __riscv_ztt_mzero_m_i16_rnu_1x1();
  __riscv_ztt_i16_rod_sat_1x1_t b = __riscv_ztt_mzero_m_i16_rod_sat_1x1();
  (void)__riscv_ztt_mcopy_m2m_i16_rod_sat_1x1(b);
  // Recognizing a prefix or a known datatype must not invent an interface.
  (void)__riscv_ztt_mzero_m(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mzero_m_invented(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mzero_m_i16_rtz_1x1(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mzero_m_i16_rne_3x1(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mzero_m_i16_2x2(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mzero_acc_i16_accx3(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mzero_m_i16_rne_accx1(); // expected-error {{undeclared}}
  (void)__riscv_ztt_mand_ew_f32_rno_1x1(a, a); // expected-error {{undeclared}}
  (void)__riscv_ztt_mls_rm_i4_sat_1x2((void *)0); // expected-error {{undeclared}}
}
