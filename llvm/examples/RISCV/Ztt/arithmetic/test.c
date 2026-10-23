// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Scalar expectations below follow the documented operand order, not assembly.

KERNEL void ztt_test_mabs_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mabs_ew_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mabsdiff_ew(const int32_t *ap, const int32_t *bp,
                                 const int32_t *dp, int32_t *out,
                                 int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mabsdiff_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mabsdiff_ew_x(const int32_t *ap, const int32_t *bp,
                                   const int32_t *dp, int32_t *out,
                                   int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mabsdiff_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_madd_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_madd_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_madd_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_madd_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msub_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msub_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msub_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msub_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mhdiff_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mhdiff_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mhdiff_ew_x(const int32_t *ap, const int32_t *bp,
                                 const int32_t *dp, int32_t *out,
                                 int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mhdiff_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmean_ew(const int32_t *ap, const int32_t *bp,
                              const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmean_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmean_ew_x(const int32_t *ap, const int32_t *bp,
                                const int32_t *dp, int32_t *out,
                                int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmean_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmin_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmin_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmin_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmin_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmax_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmax_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmax_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmax_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmul_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmul_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmul_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmul_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulneg_ew(const int32_t *ap, const int32_t *bp,
                                const int32_t *dp, int32_t *out,
                                int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulneg_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mmulneg_ew_x(const int32_t *ap, const int32_t *bp,
                                  const int32_t *dp, int32_t *out,
                                  int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mmulneg_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t ap[Elements], bp[Elements], dp[Elements];
  int32_t out[Elements + 2], saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = 2 * (i - 8);
    bp[i] = 2 * (5 - i % 7);
    dp[i] = i - 3;
  }
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mabs_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mabs_ew", i, out[i + 1], llabs(a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mabsdiff_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mabsdiff_ew", i, out[i + 1], llabs(a - b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mabsdiff_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mabsdiff_ew_x", i, out[i + 1], llabs(x - a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_madd_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("madd_ew", i, out[i + 1], a + b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_madd_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("madd_ew_x", i, out[i + 1], x + a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msub_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msub_ew", i, out[i + 1], b - a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msub_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msub_ew_x", i, out[i + 1], a - x);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mhdiff_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mhdiff_ew", i, out[i + 1], (b - a) / 2);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mhdiff_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mhdiff_ew_x", i, out[i + 1], (a - x) / 2);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmean_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmean_ew", i, out[i + 1], (a + b) / 2);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmean_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmean_ew_x", i, out[i + 1], (x + a) / 2);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmin_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmin_ew", i, out[i + 1], a < b ? a : b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmin_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmin_ew_x", i, out[i + 1], x < a ? x : a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmax_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmax_ew", i, out[i + 1], a > b ? a : b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmax_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmax_ew_x", i, out[i + 1], x > a ? x : a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmul_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmul_ew", i, out[i + 1], a * b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmul_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmul_ew_x", i, out[i + 1], x * a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulneg_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulneg_ew", i, out[i + 1], -a * b);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mmulneg_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mmulneg_ew_x", i, out[i + 1], -x * a);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  return finish();
}
