// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Scalar expectations below follow the documented operand order, not assembly.

KERNEL void ztt_test_mmulacc_ew_dead(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulacc_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulacc_ew_live(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulacc_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmulacc_ew_x_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulacc_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulacc_ew_x_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulacc_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmulaccneg_ew_dead(const int32_t *ap, const int32_t *bp,
                                        const int32_t *dp, int32_t *out,
                                        int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulaccneg_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulaccneg_ew_live(const int32_t *ap, const int32_t *bp,
                                        const int32_t *dp, int32_t *out,
                                        int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulaccneg_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmulaccneg_ew_x_dead(const int32_t *ap, const int32_t *bp,
                                          const int32_t *dp, int32_t *out,
                                          int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulaccneg_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulaccneg_ew_x_live(const int32_t *ap, const int32_t *bp,
                                          const int32_t *dp, int32_t *out,
                                          int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulaccneg_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmuladd_ew_dead(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmuladd_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmuladd_ew_live(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmuladd_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmuladd_ew_x_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmuladd_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmuladd_ew_x_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmuladd_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmulsub_ew_dead(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulsub_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulsub_ew_live(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulsub_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mmulsub_ew_x_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulsub_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulsub_ew_x_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulsub_ew_x_i32_1x1(d, a, x);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t ap[Elements], bp[Elements], dp[Elements];
  int32_t out[Elements + 2], saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = i - 8;
    bp[i] = 5 - i % 7;
    dp[i] = 3 * i - 11;
  }
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulacc_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulacc_ew_dead", i, out[i + 1], d + a * b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulacc_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulacc_ew_live", i, out[i + 1], d + a * b);
    check("mmulacc_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulacc_ew_x_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulacc_ew_x_dead", i, out[i + 1], d + x * a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulacc_ew_x_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulacc_ew_x_live", i, out[i + 1], d + x * a);
    check("mmulacc_ew_x_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulaccneg_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulaccneg_ew_dead", i, out[i + 1], d - a * b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulaccneg_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulaccneg_ew_live", i, out[i + 1], d - a * b);
    check("mmulaccneg_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulaccneg_ew_x_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulaccneg_ew_x_dead", i, out[i + 1], d - x * a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulaccneg_ew_x_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulaccneg_ew_x_live", i, out[i + 1], d - x * a);
    check("mmulaccneg_ew_x_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmuladd_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmuladd_ew_dead", i, out[i + 1], a + b * d);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmuladd_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmuladd_ew_live", i, out[i + 1], a + b * d);
    check("mmuladd_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmuladd_ew_x_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmuladd_ew_x_dead", i, out[i + 1], x + a * d);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmuladd_ew_x_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmuladd_ew_x_live", i, out[i + 1], x + a * d);
    check("mmuladd_ew_x_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulsub_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulsub_ew_dead", i, out[i + 1], a - b * d);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulsub_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulsub_ew_live", i, out[i + 1], a - b * d);
    check("mmulsub_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulsub_ew_x_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulsub_ew_x_dead", i, out[i + 1], x - a * d);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulsub_ew_x_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulsub_ew_x_live", i, out[i + 1], x - a * d);
    check("mmulsub_ew_x_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  return finish();
}
