// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s
// RUN: not %clang_cc1 -triple riscv64 -E %s -o /dev/null 2>&1 | FileCheck %s --check-prefix=NO-ZTT

// NO-ZTT: error: "RISC-V Ztt intrinsics require the Ztt extension."

#include <riscv_ztt.h>

// Exact C return type, including unsignedness and the ABI-dependent size_t.
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_ameown()), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_amestype()), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_amenlen()), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_ameudsz()), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_amefflags()), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_amexsat()), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_get_amestatus()), size_t), "size_t result");

void bad_arguments(void) {
  __riscv_ztt_get_ameown(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
  __riscv_ztt_get_amestype(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
  __riscv_ztt_get_amenlen(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
  __riscv_ztt_get_ameudsz(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
  __riscv_ztt_get_amefflags(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
  __riscv_ztt_get_amexsat(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
  __riscv_ztt_get_amestatus(1); // expected-error {{too many arguments to function call, expected 0, have 1}}
}
