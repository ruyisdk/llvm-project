// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Scalar expectations below follow the documented operand order, not assembly.

KERNEL void ztt_test_mcmpge_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmpge_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcmpge_ew_x(const int32_t *ap, const int32_t *bp,
                                 const int32_t *dp, int32_t *out,
                                 int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmpge_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcmplt_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmplt_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcmplt_ew_x(const int32_t *ap, const int32_t *bp,
                                 const int32_t *dp, int32_t *out,
                                 int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmplt_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcmovge_ew_dead(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmovge_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcmovge_ew_live(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmovge_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mcmovlt_ew_dead(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmovlt_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcmovlt_ew_live(const int32_t *ap, const int32_t *bp,
                                     const int32_t *dp, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcmovlt_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mselge_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mselge_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msellt_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_msellt_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t ap[Elements], bp[Elements], dp[Elements];
  int32_t out[Elements + 2], saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = i - 8;
    bp[i] = 3 - i % 7;
    dp[i] = 100 + i;
  }
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmpge_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmpge_ew", i, out[i + 1], a >= b ? -1 : 0);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmpge_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmpge_ew_x", i, out[i + 1], x >= a ? -1 : 0);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmplt_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmplt_ew", i, out[i + 1], a < b ? -1 : 0);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmplt_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmplt_ew_x", i, out[i + 1], x < a ? -1 : 0);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmovge_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmovge_ew_dead", i, out[i + 1], a >= 0 ? b : d);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmovge_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmovge_ew_live", i, out[i + 1], a >= 0 ? b : d);
    check("mcmovge_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmovlt_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmovlt_ew_dead", i, out[i + 1], a < 0 ? b : d);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mcmovlt_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mcmovlt_ew_live", i, out[i + 1], a < 0 ? b : d);
    check("mcmovlt_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mselge_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mselge_ew", i, out[i + 1], a >= 0 ? b : 0);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_msellt_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("msellt_ew", i, out[i + 1], a < 0 ? b : 0);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  return finish();
}
