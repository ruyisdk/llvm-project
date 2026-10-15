// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>
#ifdef __cplusplus
#define SAME(A, B) __is_same(A, B)
#else
#define SAME(A, B) __builtin_types_compatible_p(A, B)
#endif
#define TYPE(T, S) __riscv_ztt_##T##_##S##_t
#define ALIAS(T, R, S) _Static_assert(SAME(TYPE(T, S), TYPE(T##_##R, S)), "default alias")
#define INT_ALIASES(T) \
  ALIAS(T, rnu, 1x2); ALIAS(T, rnu, accx2); \
  _Static_assert(SAME(TYPE(T##_sat, 1x2), TYPE(T##_rnu_sat, 1x2)), "sat alias"); \
  _Static_assert(SAME(TYPE(T##_sat, accx2), TYPE(T##_rnu_sat, accx2)), "sat alias")
#define FLOAT_ALIASES(T) \
  ALIAS(T, rne, 1x1); ALIAS(T, rne, accx1); ALIAS(T, rne, scalar)

INT_ALIASES(i4);
INT_ALIASES(u4);
INT_ALIASES(i8);
INT_ALIASES(u8);
INT_ALIASES(i16);
INT_ALIASES(u16);
INT_ALIASES(i32);
INT_ALIASES(u32);
INT_ALIASES(i64);
INT_ALIASES(u64);
INT_ALIASES(i128);
INT_ALIASES(u128);

ALIAS(i8, rnu, scalar);
_Static_assert(SAME(TYPE(i8_sat, scalar), TYPE(i8_rnu_sat, scalar)), "scalar sat alias");
ALIAS(u8, rnu, scalar);
_Static_assert(SAME(TYPE(u8_sat, scalar), TYPE(u8_rnu_sat, scalar)), "scalar sat alias");
ALIAS(i16, rnu, scalar);
_Static_assert(SAME(TYPE(i16_sat, scalar), TYPE(i16_rnu_sat, scalar)), "scalar sat alias");
ALIAS(u16, rnu, scalar);
_Static_assert(SAME(TYPE(u16_sat, scalar), TYPE(u16_rnu_sat, scalar)), "scalar sat alias");
ALIAS(i32, rnu, scalar);
_Static_assert(SAME(TYPE(i32_sat, scalar), TYPE(i32_rnu_sat, scalar)), "scalar sat alias");
ALIAS(u32, rnu, scalar);
_Static_assert(SAME(TYPE(u32_sat, scalar), TYPE(u32_rnu_sat, scalar)), "scalar sat alias");
ALIAS(i64, rnu, scalar);
_Static_assert(SAME(TYPE(i64_sat, scalar), TYPE(i64_rnu_sat, scalar)), "scalar sat alias");
ALIAS(u64, rnu, scalar);
_Static_assert(SAME(TYPE(u64_sat, scalar), TYPE(u64_rnu_sat, scalar)), "scalar sat alias");
ALIAS(i128, rnu, scalar);
_Static_assert(SAME(TYPE(i128_sat, scalar), TYPE(i128_rnu_sat, scalar)), "scalar sat alias");
ALIAS(u128, rnu, scalar);
_Static_assert(SAME(TYPE(u128_sat, scalar), TYPE(u128_rnu_sat, scalar)), "scalar sat alias");
FLOAT_ALIASES(f16);
FLOAT_ALIASES(bf16);
FLOAT_ALIASES(f32);
FLOAT_ALIASES(f64);

_Static_assert(!SAME(TYPE(i16, 1x1), TYPE(i16_rne, 1x1)), "integer rounding identity");
_Static_assert(!SAME(TYPE(i16, accx1), TYPE(i16_sat, accx1)), "ACC saturation identity");
_Static_assert(!SAME(TYPE(f32, scalar), TYPE(f32_rno, scalar)), "scalar rounding identity");

// Copy is a representative exact-datatype operation: mode and saturation
// are part of the type, whereas explicit default spellings are true aliases.
void copy_rules(TYPE(i16_rne, 1x1) rne, TYPE(i16_sat, 1x1) sat,
                TYPE(i16, 1x1) def) {
  (void)__riscv_ztt_mcopy_m2m_i16_rne_1x1(rne);
  (void)__riscv_ztt_mcopy_m2m_i16_rnu_1x1(def);
  (void)__riscv_ztt_mcopy_m2m_i16_rnu_sat_1x1(sat);
  (void)__riscv_ztt_mcopy_m2a_i16_rne_accx1(rne);
  (void)__riscv_ztt_mcopy_m2m_i16_rdn_1x1(rne); // expected-error {{does not match destination type}}
  (void)__riscv_ztt_mcopy_m2m_i16_rne_sat_1x1(rne); // expected-error {{does not match destination type}}
  (void)__riscv_ztt_mcopy_m2a_i16_accx1(rne); // expected-error {{element type and square count must be identical}}
}

void scalar_rules(short carrier, TYPE(i16_rne, scalar) scalar) {
  TYPE(i16_rne, scalar) good = carrier;
  TYPE(i16_rdn, scalar) bad = scalar; // expected-error {{initializ}}
}

// The hidden result marker is compile-time only. Raw calls cannot bypass
// result category/domain checks or cause the marker's evaluation to be dropped.
void marker_rules(TYPE(i16_rne, 1x1) m, TYPE(i16_rne, 1x1) *p) {
  (void)__builtin_riscv_ztt_mcopy_m2m(m, (TYPE(i16_rdn, 1x1) *)0); // expected-error {{does not match destination type}}
  (void)__builtin_riscv_ztt_mzero_m((int *)0); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m((TYPE(i16_rne, accx1) *)0); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m(p); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m((TYPE(i16_rne, 1x1) *)1); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m((p++, (TYPE(i16_rne, 1x1) *)0)); // expected-error {{arithmetic on a pointer to sizeless type}}
  (void)__builtin_riscv_ztt_mzero_m((p = 0, (TYPE(i16_rne, 1x1) *)0)); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mand_ew(m, m, (TYPE(f32_rtz, 1x1) *)0); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mcos_ew(m, (TYPE(i16_rne, 1x1) *)0); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mls_rm((void *)0, (TYPE(i4_rne, 1x2) *)0); // expected-error {{null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m(); // expected-error {{too few arguments}}
}
