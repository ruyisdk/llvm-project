// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify=enabled %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify=enabled %s
// RUN: %clang_cc1 -triple riscv64 -fsyntax-only -verify=disabled %s
// RUN: %clang_cc1 -triple riscv32 -fsyntax-only -verify=disabled %s
// RUN: %clang_cc1 -triple x86_64 -fsyntax-only -verify=disabled %s

#ifdef __riscv_ztt

// Keep the expected public names independent of RISCVZttTypes.def.
#define DECLARE_RISCV_ZTT_TYPE(TYPE, SHAPE) \
  typedef __riscv_ztt_##TYPE##_##SHAPE##_t TYPE##_##SHAPE;

#define DECLARE_RISCV_ZTT_TYPES(TYPE) \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 1x1)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 1x2)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 1x4)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 1x8)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 1x16)  \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 1x32)  \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 2x1)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 4x1)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 8x1)   \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 16x1)  \
  DECLARE_RISCV_ZTT_TYPE(TYPE, 32x1)  \
  DECLARE_RISCV_ZTT_TYPE(TYPE, accx1) \
  DECLARE_RISCV_ZTT_TYPE(TYPE, accx2) \
  DECLARE_RISCV_ZTT_TYPE(TYPE, accx4) \
  DECLARE_RISCV_ZTT_TYPE(TYPE, accx8)

DECLARE_RISCV_ZTT_TYPES(i4)
DECLARE_RISCV_ZTT_TYPES(u4)
DECLARE_RISCV_ZTT_TYPES(i8)
DECLARE_RISCV_ZTT_TYPES(u8)
DECLARE_RISCV_ZTT_TYPES(i16)
DECLARE_RISCV_ZTT_TYPES(u16)
DECLARE_RISCV_ZTT_TYPES(i32)
DECLARE_RISCV_ZTT_TYPES(u32)
DECLARE_RISCV_ZTT_TYPES(i64)
DECLARE_RISCV_ZTT_TYPES(u64)
DECLARE_RISCV_ZTT_TYPES(i128)
DECLARE_RISCV_ZTT_TYPES(u128)
DECLARE_RISCV_ZTT_TYPES(f16)
DECLARE_RISCV_ZTT_TYPES(bf16)
DECLARE_RISCV_ZTT_TYPES(f32)
DECLARE_RISCV_ZTT_TYPES(f64)

#define SAME(A, B) __builtin_types_compatible_p(A, B)
_Static_assert(SAME(i16_1x2, __riscv_ztt_i16_1x2_t), "typedef identity");
_Static_assert(!SAME(i16_1x1, u16_1x1), "signedness");
_Static_assert(!SAME(i16_1x1, i32_1x1), "element width");
_Static_assert(!SAME(i16_1x1, f16_1x1), "integer and float");
_Static_assert(!SAME(f16_1x1, bf16_1x1), "float format");
_Static_assert(!SAME(i16_1x2, i16_2x1), "shape direction");
_Static_assert(!SAME(i16_1x2, i16_1x4), "M square count");
_Static_assert(!SAME(i16_1x1, i16_accx1), "register kind");
_Static_assert(!SAME(i16_accx1, i16_accx2), "ACC square count");
_Static_assert(!SAME(i32_1x1, int), "matrix is not its element type");
// enabled-no-diagnostics

#else
typedef __riscv_ztt_i16_1x1_t DisabledM;
// disabled-error@-1 {{unknown type name '__riscv_ztt_i16_1x1_t'}}
typedef __riscv_ztt_i16_accx1_t DisabledACC;
// disabled-error@-1 {{unknown type name '__riscv_ztt_i16_accx1_t'}}
#endif
