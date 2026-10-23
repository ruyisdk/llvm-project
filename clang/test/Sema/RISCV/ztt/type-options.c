// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -fno-spell-checking -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -fno-spell-checking -verify %s

#define SAME(A, B) __builtin_types_compatible_p(A, B)
#define TYPE(T, S) __riscv_ztt_##T##_##S##_t

#define CHECK_INTEGER(T, S)                                                   \
  _Static_assert(SAME(TYPE(T, S), TYPE(T##_rnu, S)), "default rounding");      \
  _Static_assert(SAME(TYPE(T##_sat, S), TYPE(T##_rnu_sat, S)),                 \
                 "default saturating rounding");                            \
  _Static_assert(!SAME(TYPE(T, S), TYPE(T##_rne, S)), "rnu != rne");           \
  _Static_assert(!SAME(TYPE(T##_rne, S), TYPE(T##_rdn, S)), "rne != rdn");     \
  _Static_assert(!SAME(TYPE(T##_rdn, S), TYPE(T##_rod, S)), "rdn != rod");     \
  _Static_assert(!SAME(TYPE(T, S), TYPE(T##_sat, S)), "saturation");           \
  _Static_assert(!SAME(TYPE(T##_rne, S), TYPE(T##_rne_sat, S)), "saturation"); \
  _Static_assert(!SAME(TYPE(T##_rdn, S), TYPE(T##_rdn_sat, S)), "saturation"); \
  _Static_assert(!SAME(TYPE(T##_rod, S), TYPE(T##_rod_sat, S)), "saturation");

#define CHECK_FLOAT(T, S)                                                     \
  _Static_assert(SAME(TYPE(T, S), TYPE(T##_rne, S)), "default rounding");      \
  _Static_assert(!SAME(TYPE(T, S), TYPE(T##_rtz, S)), "rne != rtz");           \
  _Static_assert(!SAME(TYPE(T##_rtz, S), TYPE(T##_rdn, S)), "rtz != rdn");     \
  _Static_assert(!SAME(TYPE(T##_rdn, S), TYPE(T##_rup, S)), "rdn != rup");     \
  _Static_assert(!SAME(TYPE(T##_rup, S), TYPE(T##_rmm, S)), "rup != rmm");     \
  _Static_assert(!SAME(TYPE(T##_rmm, S), TYPE(T##_rno, S)), "rmm != rno");

CHECK_INTEGER(i4, 1x32)
CHECK_INTEGER(u4, 32x1)
CHECK_INTEGER(i8, 1x1)
CHECK_INTEGER(u8, accx1)
CHECK_INTEGER(i16, 1x2)
CHECK_INTEGER(u16, 2x1)
CHECK_INTEGER(i32, accx2)
CHECK_INTEGER(u32, 1x4)
CHECK_INTEGER(i64, 4x1)
CHECK_INTEGER(u64, accx4)
CHECK_INTEGER(i128, 1x8)
CHECK_INTEGER(u128, accx8)
CHECK_FLOAT(f16, 8x1)
CHECK_FLOAT(bf16, 1x16)
CHECK_FLOAT(f32, accx8)
CHECK_FLOAT(f64, 16x1)

// Options do not erase the element format, shape or register kind.
_Static_assert(!SAME(TYPE(i16_rne, 1x2), TYPE(u16_rne, 1x2)), "signedness");
_Static_assert(!SAME(TYPE(i16_rne, 1x2), TYPE(i32_rne, 1x2)), "element width");
_Static_assert(!SAME(TYPE(f16_rdn, 1x2), TYPE(bf16_rdn, 1x2)), "float format");
_Static_assert(!SAME(TYPE(i16_sat, 1x2), TYPE(i16_sat, 2x1)), "direction");
_Static_assert(!SAME(TYPE(i16_sat, 1x2), TYPE(i16_sat, 1x4)), "M square count");
_Static_assert(!SAME(TYPE(f32_rno, 1x1), TYPE(f32_rno, accx1)), "register kind");
_Static_assert(!SAME(TYPE(f32_rno, accx1), TYPE(f32_rno, accx2)), "ACC count");

// Integer and floating-point rounding modes are not interchangeable.
typedef __riscv_ztt_i16_rtz_1x1_t InvalidIntegerRtz; // expected-error {{unknown type name '__riscv_ztt_i16_rtz_1x1_t'}}
typedef __riscv_ztt_u16_rup_accx1_t InvalidIntegerRup; // expected-error {{unknown type name '__riscv_ztt_u16_rup_accx1_t'}}
typedef __riscv_ztt_i16_rmm_1x1_t InvalidIntegerRmm; // expected-error {{unknown type name '__riscv_ztt_i16_rmm_1x1_t'}}
typedef __riscv_ztt_u16_rno_accx1_t InvalidIntegerRno; // expected-error {{unknown type name '__riscv_ztt_u16_rno_accx1_t'}}
typedef __riscv_ztt_f32_rnu_1x1_t InvalidFloatRnu; // expected-error {{unknown type name '__riscv_ztt_f32_rnu_1x1_t'}}
typedef __riscv_ztt_f32_rod_accx1_t InvalidFloatRod; // expected-error {{unknown type name '__riscv_ztt_f32_rod_accx1_t'}}
typedef __riscv_ztt_f32_sat_1x1_t InvalidFloatSat; // expected-error {{unknown type name '__riscv_ztt_f32_sat_1x1_t'}}
typedef __riscv_ztt_bf16_rne_sat_accx1_t InvalidFloatRoundingSat; // expected-error {{unknown type name '__riscv_ztt_bf16_rne_sat_accx1_t'}}
typedef __riscv_ztt_i16_sat_rne_1x1_t InvalidSuffixOrder; // expected-error {{unknown type name '__riscv_ztt_i16_sat_rne_1x1_t'}}
