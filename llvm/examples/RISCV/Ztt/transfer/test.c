// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

KERNEL void ztt_test_transfer(const int32_t *ap, const int32_t *bp,
                              int32_t out[6][Elements], int32_t *joined) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t copy = __riscv_ztt_mcopy_m2m_i32_1x1(a);
  __riscv_ztt_mss_rm(out[0], copy);
  __riscv_ztt_i32_accx1_t acc = __riscv_ztt_mcopy_m2a_i32_accx1(b);
  __riscv_ztt_i32_1x1_t back = __riscv_ztt_mcopy_a2m_i32_1x1(acc);
  __riscv_ztt_mss_rm(out[1], back);
  __riscv_ztt_i32_1x2_t pair = __riscv_ztt_mconcat_m_i32_1x2(a, b);
  __riscv_ztt_mss_rm(joined, pair);
  __riscv_ztt_i32_1x1_t first = __riscv_ztt_mextract_i32_1x1(pair, 0);
  __riscv_ztt_mss_rm(out[2], first);
  __riscv_ztt_i32_1x1_t second = __riscv_ztt_mextract_i32_1x1(pair, 1);
  __riscv_ztt_mss_rm(out[3], second);
  __riscv_ztt_mss_rm(out[4], a);
  __riscv_ztt_mss_rm(out[5], b);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t a[Elements], b[Elements], out[6][Elements], joined[2 * Elements];
  for (int i = 0; i < Elements; ++i) {
    a[i] = 3 * i - 13;
    b[i] = 57 - 2 * i;
  }
  ztt_test_transfer(a, b, out, joined);
  for (int i = 0; i < Elements; ++i) {
    for (int k = 0; k < 6; ++k)
      check("transfer", k * Elements + i, out[k][i], k % 2 ? b[i] : a[i]);
    check("concat first", i, joined[i], a[i]);
    check("concat second", i, joined[Elements + i], b[i]);
  }
  return finish();
}
