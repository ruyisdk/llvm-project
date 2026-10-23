// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Scalar expectations below follow the documented operand order, not assembly.

KERNEL void ztt_test_msll_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msll_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msll_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msll_ew_x_i32_1x1(a, 35U);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msrl_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msrl_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msrl_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msrl_ew_x_i32_1x1(a, 35U);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msra_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msra_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msra_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msra_ew_x_i32_1x1(a, 35U);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t ap[Elements], bp[Elements], dp[Elements];
  int32_t out[Elements + 2], saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = i % 2 ? -33 - i : 37 + i;
    bp[i] = i % 5 + (i % 2 ? 32 : 0);
    dp[i] = i - 3;
  }
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msll_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msll_ew", i, out[i + 1], (int32_t)((uint32_t)a << (b % 32)));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msll_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msll_ew_x", i, out[i + 1], (int32_t)((uint32_t)a << 3));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msrl_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msrl_ew", i, out[i + 1], (int32_t)((uint32_t)a >> (b % 32)));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msrl_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msrl_ew_x", i, out[i + 1], (int32_t)((uint32_t)a >> 3));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msra_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msra_ew", i, out[i + 1],
          a >= 0 ? a / (1LL << (b % 32))
                 : -((-a + (1LL << (b % 32)) - 1) / (1LL << (b % 32))));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msra_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msra_ew_x", i, out[i + 1],
          a >= 0 ? a / (1LL << 3) : -((-a + (1LL << 3) - 1) / (1LL << 3)));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  return finish();
}
