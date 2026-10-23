// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Neither public load aliases nor direct builtins exist, for any shape.
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_1x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_1x2), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_1x4), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_1x8), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_1x16), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_1x32), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_2x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_4x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_8x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_16x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_i4_32x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_1x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_1x2), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_1x4), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_1x8), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_1x16), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_1x32), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_2x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_4x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_8x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_16x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_i4_32x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_1x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_1x2), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_1x4), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_1x8), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_1x16), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_1x32), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_2x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_4x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_8x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_16x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_rm_u4_32x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_1x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_1x2), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_1x4), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_1x8), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_1x16), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_1x32), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_2x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_4x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_8x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_16x1), "no sub-byte load builtin");
_Static_assert(!__has_builtin(__builtin_riscv_ztt_mls_cm_u4_32x1), "no sub-byte load builtin");

#if defined(__riscv_ztt_mls_rm_i4_1x1) || \
    defined(__riscv_ztt_mls_rm_i4_1x2) || \
    defined(__riscv_ztt_mls_rm_i4_1x4) || \
    defined(__riscv_ztt_mls_rm_i4_1x8) || \
    defined(__riscv_ztt_mls_rm_i4_1x16) || \
    defined(__riscv_ztt_mls_rm_i4_1x32) || \
    defined(__riscv_ztt_mls_rm_i4_2x1) || \
    defined(__riscv_ztt_mls_rm_i4_4x1) || \
    defined(__riscv_ztt_mls_rm_i4_8x1) || \
    defined(__riscv_ztt_mls_rm_i4_16x1) || \
    defined(__riscv_ztt_mls_rm_i4_32x1) || \
    defined(__riscv_ztt_mls_cm_i4_1x1) || \
    defined(__riscv_ztt_mls_cm_i4_1x2) || \
    defined(__riscv_ztt_mls_cm_i4_1x4) || \
    defined(__riscv_ztt_mls_cm_i4_1x8) || \
    defined(__riscv_ztt_mls_cm_i4_1x16) || \
    defined(__riscv_ztt_mls_cm_i4_1x32) || \
    defined(__riscv_ztt_mls_cm_i4_2x1) || \
    defined(__riscv_ztt_mls_cm_i4_4x1) || \
    defined(__riscv_ztt_mls_cm_i4_8x1) || \
    defined(__riscv_ztt_mls_cm_i4_16x1) || \
    defined(__riscv_ztt_mls_cm_i4_32x1) || \
    defined(__riscv_ztt_mls_rm_u4_1x1) || \
    defined(__riscv_ztt_mls_rm_u4_1x2) || \
    defined(__riscv_ztt_mls_rm_u4_1x4) || \
    defined(__riscv_ztt_mls_rm_u4_1x8) || \
    defined(__riscv_ztt_mls_rm_u4_1x16) || \
    defined(__riscv_ztt_mls_rm_u4_1x32) || \
    defined(__riscv_ztt_mls_rm_u4_2x1) || \
    defined(__riscv_ztt_mls_rm_u4_4x1) || \
    defined(__riscv_ztt_mls_rm_u4_8x1) || \
    defined(__riscv_ztt_mls_rm_u4_16x1) || \
    defined(__riscv_ztt_mls_rm_u4_32x1) || \
    defined(__riscv_ztt_mls_cm_u4_1x1) || \
    defined(__riscv_ztt_mls_cm_u4_1x2) || \
    defined(__riscv_ztt_mls_cm_u4_1x4) || \
    defined(__riscv_ztt_mls_cm_u4_1x8) || \
    defined(__riscv_ztt_mls_cm_u4_1x16) || \
    defined(__riscv_ztt_mls_cm_u4_1x32) || \
    defined(__riscv_ztt_mls_cm_u4_2x1) || \
    defined(__riscv_ztt_mls_cm_u4_4x1) || \
    defined(__riscv_ztt_mls_cm_u4_8x1) || \
    defined(__riscv_ztt_mls_cm_u4_16x1) || \
    defined(__riscv_ztt_mls_cm_u4_32x1)
#error "sub-byte load aliases must not be exposed"
#endif

// These shapes occupy a full register even under UDS128, so rejection must
// be about the missing carrier, not a half-register or capacity diagnostic.
void unavailable_loads(signed _BitInt(4) *i, unsigned _BitInt(4) *u) {
  __riscv_ztt_mls_rm_i4_1x32(i); // expected-error {{call to undeclared function '__riscv_ztt_mls_rm_i4_1x32'}}
  __builtin_riscv_ztt_mls_rm_i4_32x1(i); // expected-error {{use of unknown builtin '__builtin_riscv_ztt_mls_rm_i4_32x1'}}
  __riscv_ztt_mls_cm_i4_1x32(i); // expected-error {{call to undeclared function '__riscv_ztt_mls_cm_i4_1x32'}}
  __builtin_riscv_ztt_mls_cm_i4_32x1(i); // expected-error {{use of unknown builtin '__builtin_riscv_ztt_mls_cm_i4_32x1'}}
  __riscv_ztt_mls_rm_u4_1x32(u); // expected-error {{call to undeclared function '__riscv_ztt_mls_rm_u4_1x32'}}
  __builtin_riscv_ztt_mls_rm_u4_32x1(u); // expected-error {{use of unknown builtin '__builtin_riscv_ztt_mls_rm_u4_32x1'}}
  __riscv_ztt_mls_cm_u4_1x32(u); // expected-error {{call to undeclared function '__riscv_ztt_mls_cm_u4_1x32'}}
  __builtin_riscv_ztt_mls_cm_u4_32x1(u); // expected-error {{use of unknown builtin '__builtin_riscv_ztt_mls_cm_u4_32x1'}}
}

void reject_store_i4_1x32(signed _BitInt(4) *i, unsigned _BitInt(4) *u,
    signed char *c, unsigned char *uc, int *n, void *p) {
  __riscv_ztt_i4_1x32_t m = __riscv_ztt_mclear_m_i4_1x32();
  __riscv_ztt_mss_rm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
}

void reject_store_i4_32x1(signed _BitInt(4) *i, unsigned _BitInt(4) *u,
    signed char *c, unsigned char *uc, int *n, void *p) {
  __riscv_ztt_i4_32x1_t m = __riscv_ztt_mclear_m_i4_32x1();
  __riscv_ztt_mss_rm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
}

void reject_store_u4_1x32(signed _BitInt(4) *i, unsigned _BitInt(4) *u,
    signed char *c, unsigned char *uc, int *n, void *p) {
  __riscv_ztt_u4_1x32_t m = __riscv_ztt_mclear_m_u4_1x32();
  __riscv_ztt_mss_rm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
}

void reject_store_u4_32x1(signed _BitInt(4) *i, unsigned _BitInt(4) *u,
    signed char *c, unsigned char *uc, int *n, void *p) {
  __riscv_ztt_u4_32x1_t m = __riscv_ztt_mclear_m_u4_32x1();
  __riscv_ztt_mss_rm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(i, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(u, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(c, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(uc, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(n, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_rm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __builtin_riscv_ztt_mss_cm(p, m); // expected-error {{sub-byte datatypes have no public C element carrier}}
}
