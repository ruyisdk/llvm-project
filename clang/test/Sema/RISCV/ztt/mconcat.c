// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -fsyntax-only -verify -DTEST_32 %s

// Matrix operands use the same target checks in C and C++, not ellipsis rules.
// RUN: %clang_cc1 -triple riscv32 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify -DTEST_32 %s
// RUN: %clang_cc1 -triple riscv32 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify -DTEST_32 %s
// RUN: %clang_cc1 -triple riscv64 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify -DTEST_32 %s

#include <riscv_ztt.h>

// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DTEST_16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DTEST_64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DTEST_128 -fsyntax-only -verify %s

#ifdef TEST_32
void valid(__riscv_ztt_i32_1x1_t x,
           __riscv_ztt_i32_1x2_t r2,
           __riscv_ztt_i32_2x1_t c2) {
  (void)__riscv_ztt_mconcat_m_i32_1x2(x, x);
  (void)__riscv_ztt_mconcat_m_i32_2x1(x, x);
  (void)__riscv_ztt_mconcat_m_i32_1x4(r2, r2);
  (void)__riscv_ztt_mconcat_m_i32_4x1(c2, c2);
}

void invalid(__riscv_ztt_i32_1x1_t x,
             __riscv_ztt_u32_1x1_t ux,
             __riscv_ztt_i32_1x2_t r2,
             __riscv_ztt_i32_1x4_t r4,
             __riscv_ztt_i32_2x1_t c2,
             __riscv_ztt_i32_accx1_t acc) {
  (void)__riscv_ztt_mconcat_m_i32_1x2(x, ux); // expected-error {{source types must be identical}}
  (void)__riscv_ztt_mconcat_m_i32_1x4(r2, c2); // expected-error {{source types must be identical}}
  // Same datatype and direction, but unequal input square counts.
  (void)__riscv_ztt_mconcat_m_i32_1x4(r2, r4); // expected-error {{source types must be identical}}
  (void)__riscv_ztt_mconcat_m_i32_1x2(acc, acc); // expected-error {{requires two M source types}}
  (void)__riscv_ztt_mconcat_m_i32_1x4(c2, c2); // expected-error {{must preserve the source datatype and double source shape}}
  (void)__riscv_ztt_mconcat_m_u32_1x2(x, x); // expected-error {{must preserve the source datatype and double source shape}}
  // Same datatype and direction, but the result is not exactly twice as large.
  (void)__riscv_ztt_mconcat_m_i32_1x4(x, x); // expected-error {{must preserve the source datatype and double source shape}}
}
#else
// expected-no-diagnostics
#endif

#define TEST_MCONCAT(T)                                                       \
  __riscv_ztt_##T##_1x2_t cat_##T##_1x2(__riscv_ztt_##T##_1x1_t a,           \
                                         __riscv_ztt_##T##_1x1_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_1x2(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_2x1_t cat_##T##_2x1(__riscv_ztt_##T##_1x1_t a,           \
                                         __riscv_ztt_##T##_1x1_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_2x1(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_1x4_t cat_##T##_1x4(__riscv_ztt_##T##_1x2_t a,           \
                                         __riscv_ztt_##T##_1x2_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_1x4(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_4x1_t cat_##T##_4x1(__riscv_ztt_##T##_2x1_t a,           \
                                         __riscv_ztt_##T##_2x1_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_4x1(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_1x8_t cat_##T##_1x8(__riscv_ztt_##T##_1x4_t a,           \
                                         __riscv_ztt_##T##_1x4_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_1x8(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_8x1_t cat_##T##_8x1(__riscv_ztt_##T##_4x1_t a,           \
                                         __riscv_ztt_##T##_4x1_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_8x1(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_1x16_t cat_##T##_1x16(__riscv_ztt_##T##_1x8_t a,         \
                                           __riscv_ztt_##T##_1x8_t b) {       \
    return __riscv_ztt_mconcat_m_##T##_1x16(a, b);                           \
  }                                                                          \
  __riscv_ztt_##T##_16x1_t cat_##T##_16x1(__riscv_ztt_##T##_8x1_t a,         \
                                           __riscv_ztt_##T##_8x1_t b) {       \
    return __riscv_ztt_mconcat_m_##T##_16x1(a, b);                           \
  }                                                                          \
  __riscv_ztt_##T##_1x32_t cat_##T##_1x32(__riscv_ztt_##T##_1x16_t a,        \
                                           __riscv_ztt_##T##_1x16_t b) {      \
    return __riscv_ztt_mconcat_m_##T##_1x32(a, b);                           \
  }                                                                          \
  __riscv_ztt_##T##_32x1_t cat_##T##_32x1(__riscv_ztt_##T##_16x1_t a,        \
                                           __riscv_ztt_##T##_16x1_t b) {      \
    return __riscv_ztt_mconcat_m_##T##_32x1(a, b);                           \
  }

#define TEST_MCONCAT_I4(T)                                                    \
  __riscv_ztt_##T##_1x4_t cat_##T##_1x4(__riscv_ztt_##T##_1x2_t a,           \
                                         __riscv_ztt_##T##_1x2_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_1x4(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_4x1_t cat_##T##_4x1(__riscv_ztt_##T##_2x1_t a,           \
                                         __riscv_ztt_##T##_2x1_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_4x1(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_1x8_t cat_##T##_1x8(__riscv_ztt_##T##_1x4_t a,           \
                                         __riscv_ztt_##T##_1x4_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_1x8(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_8x1_t cat_##T##_8x1(__riscv_ztt_##T##_4x1_t a,           \
                                         __riscv_ztt_##T##_4x1_t b) {         \
    return __riscv_ztt_mconcat_m_##T##_8x1(a, b);                            \
  }                                                                          \
  __riscv_ztt_##T##_1x16_t cat_##T##_1x16(__riscv_ztt_##T##_1x8_t a,         \
                                           __riscv_ztt_##T##_1x8_t b) {       \
    return __riscv_ztt_mconcat_m_##T##_1x16(a, b);                           \
  }                                                                          \
  __riscv_ztt_##T##_16x1_t cat_##T##_16x1(__riscv_ztt_##T##_8x1_t a,         \
                                           __riscv_ztt_##T##_8x1_t b) {       \
    return __riscv_ztt_mconcat_m_##T##_16x1(a, b);                           \
  }                                                                          \
  __riscv_ztt_##T##_1x32_t cat_##T##_1x32(__riscv_ztt_##T##_1x16_t a,        \
                                           __riscv_ztt_##T##_1x16_t b) {      \
    return __riscv_ztt_mconcat_m_##T##_1x32(a, b);                           \
  }                                                                          \
  __riscv_ztt_##T##_32x1_t cat_##T##_32x1(__riscv_ztt_##T##_16x1_t a,        \
                                           __riscv_ztt_##T##_16x1_t b) {      \
    return __riscv_ztt_mconcat_m_##T##_32x1(a, b);                           \
  }

#ifdef TEST_8
TEST_MCONCAT_I4(i4)
TEST_MCONCAT_I4(u4)
TEST_MCONCAT(i8)
TEST_MCONCAT(u8)
#endif
#ifdef TEST_16
TEST_MCONCAT(i16)
TEST_MCONCAT(u16)
TEST_MCONCAT(f16)
TEST_MCONCAT(bf16)
#endif
#ifdef TEST_32
TEST_MCONCAT(i32)
TEST_MCONCAT(u32)
TEST_MCONCAT(f32)
#endif
#ifdef TEST_64
TEST_MCONCAT(i64)
TEST_MCONCAT(u64)
TEST_MCONCAT(f64)
#endif
#ifdef TEST_128
TEST_MCONCAT(i128)
TEST_MCONCAT(u128)
#endif
