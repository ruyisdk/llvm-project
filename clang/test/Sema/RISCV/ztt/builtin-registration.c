// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple x86_64 -fsyntax-only -verify %s

#ifdef __riscv_ztt
#define AVAILABLE 1
#else
#define AVAILABLE 0
#endif

// Builtin IDs are per operation, not per datatype or shape.
_Static_assert(__has_builtin(__builtin_riscv_ztt_madd_ew) == AVAILABLE, "compute");
_Static_assert(__has_builtin(__builtin_riscv_ztt_mls_rm) == AVAILABLE, "load");
_Static_assert(__has_builtin(__builtin_riscv_ztt_mss_rm) == AVAILABLE, "store");
_Static_assert(__has_builtin(__builtin_riscv_ztt_get_amenlen) == AVAILABLE, "CSR");
_Static_assert(__has_builtin(__builtin_riscv_ztt_ame_acquire) == AVAILABLE, "acquire");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_madd_ew_i16_1x2), "no typed builtin ID");

// Public names are not enabled without the intrinsic header.
void no_header(void) {
  __riscv_ztt_mzero_m_i32_1x1(); // expected-error {{call to undeclared function '__riscv_ztt_mzero_m_i32_1x1'}}
  __riscv_ztt_ame_release(); // expected-error {{call to undeclared function '__riscv_ztt_ame_release'}}
}
