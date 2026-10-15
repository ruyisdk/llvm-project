// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -fsyntax-only -verify %s

// Scalar existence and carrier conversions do not depend on UDS or XLEN.
// These are distinct AST types, not ordinary typedef aliases or M/ACC values.
#ifdef __cplusplus
#define ASSERT(C) static_assert(C, #C)
#define DISTINCT(A, B) ASSERT(!__is_same(A, B))
#else
#define ASSERT(C) _Static_assert(C, #C)
#define DISTINCT(A, B) ASSERT(!__builtin_types_compatible_p(A, B))
#endif

#define TEST(T, C) \
  DISTINCT(__riscv_ztt_##T##_scalar_t, C); \
  ASSERT(sizeof(__riscv_ztt_##T##_scalar_t) == sizeof(C)); \
  ASSERT(__alignof__(__riscv_ztt_##T##_scalar_t) == __alignof__(C)); \
  C roundtrip_##T(C value) { \
    __riscv_ztt_##T##_scalar_t a = value; \
    __riscv_ztt_##T##_scalar_t b = (__riscv_ztt_##T##_scalar_t)value; \
    __riscv_ztt_##T##_scalar_t copy = a; \
    b = copy; \
    return (C)b; \
  }

TEST(i8, __INT8_TYPE__)
TEST(u8, __UINT8_TYPE__)
TEST(i16, __INT16_TYPE__)
TEST(u16, __UINT16_TYPE__)
TEST(i32, __INT32_TYPE__)
TEST(u32, __UINT32_TYPE__)
TEST(i64, __INT64_TYPE__)
TEST(u64, __UINT64_TYPE__)
TEST(i128, _BitInt(128))
TEST(u128, unsigned _BitInt(128))
TEST(f16, _Float16)
TEST(bf16, __bf16)
TEST(f32, float)
TEST(f64, double)

DISTINCT(__riscv_ztt_i32_scalar_t, __riscv_ztt_u32_scalar_t);
DISTINCT(__riscv_ztt_i32_scalar_t, __riscv_ztt_f32_scalar_t);

void invalid(int i, float f, __riscv_ztt_i32_scalar_t si,
             __riscv_ztt_u32_scalar_t su) {
  __riscv_ztt_f32_scalar_t a = i; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t b = f; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t c = su; // expected-error {{initializ}}
  (void)(si + si); // expected-error {{invalid operands}}
  (void)(__riscv_ztt_i32_scalar_t)f; // expected-error {{'float' to '__riscv_ztt_i32_scalar_t'}}
}

__riscv_ztt_i4_scalar_t no_i4; // expected-error {{unknown type name}}
__riscv_ztt_u4_scalar_t no_u4; // expected-error {{unknown type name}}

void exact_types(char c, short s, unsigned u, long l, long long ll,
                 __riscv_ztt_i32_scalar_t base,
                 __riscv_ztt_i32_rne_scalar_t rounded,
                 __riscv_ztt_i32_sat_scalar_t saturated) {
  __riscv_ztt_i8_scalar_t a = c; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t b = s; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t d = u; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t e = l; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t f = rounded; // expected-error {{initializ}}
  __riscv_ztt_i32_scalar_t g = saturated; // expected-error {{initializ}}
  base = rounded; // expected-error {{assign}}
#if __riscv_xlen == 32
  __riscv_ztt_i64_scalar_t h = ll;
  __riscv_ztt_i64_scalar_t bad = l; // expected-error {{initializ}}
#else
  __riscv_ztt_i64_scalar_t h = l;
  __riscv_ztt_i64_scalar_t bad = ll; // expected-error {{initializ}}
#endif
  (void)(base + base); // expected-error {{invalid operands}}
}

#ifdef __cplusplus
constexpr __riscv_ztt_i32_scalar_t const_i = -7;
constexpr __riscv_ztt_u32_scalar_t const_u = 0xffffffffU;
constexpr __riscv_ztt_f32_scalar_t const_f = 1.5f;
static_assert((int)const_i == -7);
static_assert((unsigned)const_u == 0xffffffffU);
static_assert((float)const_f == 1.5f);

// RISC-V Ztt scalar evaluation also handles zero initialization, copies and
// returned values. Arithmetic in the corresponding C type still works.
constexpr __riscv_ztt_i32_scalar_t zero_i{};
constexpr __riscv_ztt_f32_scalar_t zero_f{};
static_assert((int)zero_i == 0);
static_assert((float)zero_f == 0.0f);
constexpr __riscv_ztt_i32_scalar_t copy_i = const_i;
constexpr __riscv_ztt_f32_scalar_t copy_f = const_f;
static_assert((int)copy_i == -7);
static_assert((float)copy_f == 1.5f);
constexpr __riscv_ztt_u128_scalar_t wide = (unsigned _BitInt(128))1 << 100;
static_assert((unsigned _BitInt(128))wide == (unsigned _BitInt(128))1 << 100);

constexpr __riscv_ztt_i32_scalar_t select_i(bool first,
                                         __riscv_ztt_i32_scalar_t a,
                                         __riscv_ztt_i32_scalar_t b) {
  return first ? a : b;
}
constexpr __riscv_ztt_f32_scalar_t select_f(bool first,
                                         __riscv_ztt_f32_scalar_t a,
                                         __riscv_ztt_f32_scalar_t b) {
  return first ? a : b;
}
static_assert((int)select_i(true, const_i, 2 + 3) == -7);
static_assert((int)select_i(false, const_i, 2 + 3) == 5);
static_assert((float)select_f(true, const_f, 2.0f + 3.0f) == 1.5f);
static_assert((float)select_f(false, const_f, 2.0f + 3.0f) == 5.0f);
#endif

// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DTEST_GPR_OPERAND -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DTEST_GPR_OPERAND -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DTEST_GPR_OPERAND -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DTEST_GPR_OPERAND -fsyntax-only -verify %s

#ifdef TEST_GPR_OPERAND
#include <riscv_ztt.h>

// Scalar arguments must fit XLEN; the types themselves remain available.
#if __riscv_xlen == 32
void too_wide32(__riscv_ztt_i128_1x1_t m,
                __riscv_ztt_i64_scalar_t i, __riscv_ztt_u64_scalar_t u,
                __riscv_ztt_f64_scalar_t f) {
  __riscv_ztt_madd_ew_x_i128_1x1(m, i); // expected-error {{has 64 bits, exceeding the 32-bit XLEN}}
  __riscv_ztt_madd_ew_x_i128_1x1(m, u); // expected-error {{has 64 bits, exceeding the 32-bit XLEN}}
  __riscv_ztt_madd_ew_x_i128_1x1(m, f); // expected-error {{has 64 bits, exceeding the 32-bit XLEN}}
}
#endif

void too_wide(__riscv_ztt_i128_1x1_t m, __riscv_ztt_i128_scalar_t i,
              __riscv_ztt_u128_scalar_t u) {
  __riscv_ztt_madd_ew_x_i128_1x1(m, i); // expected-error {{has 128 bits, exceeding}}
  __riscv_ztt_madd_ew_x_i128_1x1(m, u); // expected-error {{has 128 bits, exceeding}}
}
#endif
