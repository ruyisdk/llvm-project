// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Integer widening and narrowing, with exactly representable source values.
KERNEL void ztt_test_conversion(const int32_t *p, int64_t *wide,
                                int32_t *back) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i64_1x1_t b = __riscv_ztt_mconv_ew_i64_1x1(a);
  __riscv_ztt_mss_rm(wide, b);
  __riscv_ztt_i32_1x1_t c = __riscv_ztt_mconv_ew_i32_1x1(b);
  __riscv_ztt_mss_rm(back, c);
}
int main(void) {
  if (!begin())
    return 2;
  int32_t input[Elements], back[Elements];
  int64_t wide[Elements];
  for (int i = 0; i < Elements; ++i)
    input[i] = i * 100003 - 750011;
  ztt_test_conversion(input, wide, back);
  for (int i = 0; i < Elements; ++i) {
    check("mconv i32->i64", i, wide[i], input[i]);
    check("mconv i64->i32", i, back[i], input[i]);
  }
  return finish();
}
