// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -fsyntax-only -verify %s

// State/CSR operations require the same profile as matrix operations.
void missing_profile(void) {
  (void)__builtin_riscv_ztt_get_amenlen(); // expected-error {{RISC-V Ztt builtin requires a Ztt profile}}
  (void)__builtin_riscv_ztt_ame_acquire(0); // expected-error {{RISC-V Ztt builtin requires a Ztt profile}}
  __builtin_riscv_ztt_ame_release(); // expected-error {{RISC-V Ztt builtin requires a Ztt profile}}
  (void)__builtin_riscv_ztt_mzero_m((__riscv_ztt_i32_1x1_t *)0); // expected-error {{RISC-V Ztt builtin requires a Ztt profile}}
}
