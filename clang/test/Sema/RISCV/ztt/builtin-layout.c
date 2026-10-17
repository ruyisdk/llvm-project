// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify %s

// Check profile limits for every matrix input and result.
#define RESULT(T) ((__riscv_ztt_##T##_t *)0)

void layout(__riscv_ztt_i16_1x1_t half, __riscv_ztt_i32_1x1_t m,
            __riscv_ztt_i64_1x16_t large, __riscv_ztt_i32_accx8_t acc) {
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i16_1x2));
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i128_1x4));
  (void)__builtin_riscv_ztt_mzero_acc(RESULT(i4_accx4));
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i16_1x1)); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i64_1x16)); // expected-error {{requires 32 M registers, exceeding the configured limit of 16}}
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i128_1x32)); // expected-error {{requires 128 M registers, exceeding the architectural limit of 32}}
  (void)__builtin_riscv_ztt_mzero_acc(RESULT(i32_accx8)); // expected-error {{requires 8 ACC registers, exceeding the configured limit of 4}}
  (void)__builtin_riscv_ztt_madd_ew(m, half, RESULT(i32_1x1)); // expected-error {{occupies only 16 bits, which is smaller than the 32-bit UDS}}
  (void)__builtin_riscv_ztt_mextract(large, 0, RESULT(i64_1x8)); // expected-error {{requires 32 M registers, exceeding the configured limit of 16}}
  (void)__builtin_riscv_ztt_mcopy_a2m(acc, RESULT(i32_1x8)); // expected-error {{requires 8 ACC registers, exceeding the configured limit of 4}}
}
