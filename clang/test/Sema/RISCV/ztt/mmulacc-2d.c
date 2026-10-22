// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -fsyntax-only -verify %s

// Matrix operands use the same target checks in C and C++, not ellipsis rules.
// RUN: %clang_cc1 -triple riscv32 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

__riscv_ztt_i32_accx1_t
valid_packed(__riscv_ztt_i32_accx1_t acc, __riscv_ztt_i16_1x2_t lhs,
             __riscv_ztt_i16_2x1_t rhs) {
  return __riscv_ztt_mmulacc_2d_i32_accx1(acc, lhs, rhs);
}

__riscv_ztt_i32_accx2_t
valid_acc_tail(__riscv_ztt_i32_accx2_t acc, __riscv_ztt_i32_1x1_t lhs,
               __riscv_ztt_i32_1x1_t rhs) {
  return __riscv_ztt_mmulacc_2d_i32_accx2(acc, lhs, rhs);
}

__riscv_ztt_i32_accx4_t
valid_mixed_source_types(__riscv_ztt_i32_accx4_t acc,
                         __riscv_ztt_i8_1x4_t lhs,
                         __riscv_ztt_i16_4x1_t rhs) {
  // The compiler checks structural constraints, but deliberately does not
  // validate the hardware datatype tuple.
  return __riscv_ztt_mmulacc_2d_i32_accx4(acc, lhs, rhs);
}

#define TEST_RESULT_TYPE(Suffix)                                              \
  __riscv_ztt_##Suffix##_t test_result_##Suffix(                             \
      __riscv_ztt_##Suffix##_t acc, __riscv_ztt_i32_1x1_t lhs,              \
      __riscv_ztt_i32_1x1_t rhs) {                                           \
    return __riscv_ztt_mmulacc_2d_##Suffix(acc, lhs, rhs);                   \
  }

TEST_RESULT_TYPE(i4_accx1)
TEST_RESULT_TYPE(i4_accx2)
TEST_RESULT_TYPE(i4_accx4)
TEST_RESULT_TYPE(i4_accx8)
TEST_RESULT_TYPE(u4_accx1)
TEST_RESULT_TYPE(u4_accx2)
TEST_RESULT_TYPE(u4_accx4)
TEST_RESULT_TYPE(u4_accx8)
TEST_RESULT_TYPE(i8_accx1)
TEST_RESULT_TYPE(i8_accx2)
TEST_RESULT_TYPE(i8_accx4)
TEST_RESULT_TYPE(i8_accx8)
TEST_RESULT_TYPE(u8_accx1)
TEST_RESULT_TYPE(u8_accx2)
TEST_RESULT_TYPE(u8_accx4)
TEST_RESULT_TYPE(u8_accx8)
TEST_RESULT_TYPE(i16_accx1)
TEST_RESULT_TYPE(i16_accx2)
TEST_RESULT_TYPE(i16_accx4)
TEST_RESULT_TYPE(i16_accx8)
TEST_RESULT_TYPE(u16_accx1)
TEST_RESULT_TYPE(u16_accx2)
TEST_RESULT_TYPE(u16_accx4)
TEST_RESULT_TYPE(u16_accx8)
TEST_RESULT_TYPE(i32_accx1)
TEST_RESULT_TYPE(i32_accx2)
TEST_RESULT_TYPE(i32_accx4)
TEST_RESULT_TYPE(i32_accx8)
TEST_RESULT_TYPE(i32_accx16)
TEST_RESULT_TYPE(u32_accx1)
TEST_RESULT_TYPE(u32_accx2)
TEST_RESULT_TYPE(u32_accx4)
TEST_RESULT_TYPE(u32_accx8)
TEST_RESULT_TYPE(i64_accx1)
TEST_RESULT_TYPE(i64_accx2)
TEST_RESULT_TYPE(i64_accx4)
TEST_RESULT_TYPE(i64_accx8)
TEST_RESULT_TYPE(u64_accx1)
TEST_RESULT_TYPE(u64_accx2)
TEST_RESULT_TYPE(u64_accx4)
TEST_RESULT_TYPE(u64_accx8)
TEST_RESULT_TYPE(i128_accx1)
TEST_RESULT_TYPE(i128_accx2)
TEST_RESULT_TYPE(i128_accx4)
TEST_RESULT_TYPE(i128_accx8)
TEST_RESULT_TYPE(u128_accx1)
TEST_RESULT_TYPE(u128_accx2)
TEST_RESULT_TYPE(u128_accx4)
TEST_RESULT_TYPE(u128_accx8)
TEST_RESULT_TYPE(f16_accx1)
TEST_RESULT_TYPE(f16_accx2)
TEST_RESULT_TYPE(f16_accx4)
TEST_RESULT_TYPE(f16_accx8)
TEST_RESULT_TYPE(bf16_accx1)
TEST_RESULT_TYPE(bf16_accx2)
TEST_RESULT_TYPE(bf16_accx4)
TEST_RESULT_TYPE(bf16_accx8)
TEST_RESULT_TYPE(f32_accx1)
TEST_RESULT_TYPE(f32_accx2)
TEST_RESULT_TYPE(f32_accx4)
TEST_RESULT_TYPE(f32_accx8)
TEST_RESULT_TYPE(f32_accx16)
TEST_RESULT_TYPE(f64_accx1)
TEST_RESULT_TYPE(f64_accx2)
TEST_RESULT_TYPE(f64_accx4)
TEST_RESULT_TYPE(f64_accx8)

#undef TEST_RESULT_TYPE

void argument_count(__riscv_ztt_i32_accx1_t acc,
                    __riscv_ztt_i32_1x1_t lhs,
                    __riscv_ztt_i32_1x1_t rhs) {
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, lhs); // expected-error {{too few arguments to function call}}
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, lhs, rhs, rhs); // expected-error {{too many arguments to function call}}
}

void accumulator_type(__riscv_ztt_i16_accx1_t wrong,
                      __riscv_ztt_i32_accx2_t wrong_size,
                      __riscv_ztt_i32_1x1_t lhs,
                      __riscv_ztt_i32_1x1_t rhs) {
  __riscv_ztt_mmulacc_2d_i32_accx1(wrong, lhs, rhs); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  // Same datatype, different ACC square count.
  __riscv_ztt_mmulacc_2d_i32_accx1(wrong_size, lhs, rhs); // expected-error {{requires an identical accumulator type and matching source dimensions}}
}

void source_register_kind(__riscv_ztt_i32_accx1_t acc,
                          __riscv_ztt_i32_1x1_t matrix) {
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, acc, matrix); // expected-error {{requires two M source types}}
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, matrix, acc); // expected-error {{requires two M source types}}
}

void source_shapes(__riscv_ztt_i32_accx1_t acc,
                   __riscv_ztt_i32_2x1_t column,
                   __riscv_ztt_i32_1x2_t row,
                   __riscv_ztt_i16_1x2_t k2,
                   __riscv_ztt_i16_4x1_t k4) {
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, column, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  // Keep the RHS valid to isolate the LHS orientation constraint.
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, column, column); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, row, row); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  __riscv_ztt_mmulacc_2d_i32_accx1(acc, k2, k4); // expected-error {{requires an identical accumulator type and matching source dimensions}}
}
