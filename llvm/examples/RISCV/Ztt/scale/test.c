// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Scalar expectations below follow the documented operand order, not assembly.

KERNEL void ztt_test_mldexp_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mldexp_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mldexp_ew_x(const int32_t *ap, const int32_t *bp,
                                 const int32_t *dp, int32_t *out,
                                 int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mldexp_ew_x_i32_1x1(a, (long)2);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mldexpacc_ew_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mldexpacc_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mldexpacc_ew_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mldexpacc_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mldexpacc_ew_x_dead(const int32_t *ap, const int32_t *bp,
                                         const int32_t *dp, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mldexpacc_ew_x_i32_1x1(d, a, (long)2);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mldexpacc_ew_x_live(const int32_t *ap, const int32_t *bp,
                                         const int32_t *dp, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mldexpacc_ew_x_i32_1x1(d, a, (long)2);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

KERNEL void ztt_test_mrdexp_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mrdexp_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrdexpacc_ew_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mrdexpacc_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrdexpacc_ew_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *dp, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(dp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mrdexpacc_ew_i32_1x1(d, a, b);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, d);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t ap[Elements], bp[Elements], dp[Elements];
  int32_t out[Elements + 2], saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = 16 * (i - 8);
    bp[i] = i % 4;
    dp[i] = i - 3;
  }
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mldexp_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mldexp_ew", i, out[i + 1], a * (1LL << b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mldexp_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mldexp_ew_x", i, out[i + 1], a * 4);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mldexpacc_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mldexpacc_ew_dead", i, out[i + 1], d + a * (1LL << b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mldexpacc_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mldexpacc_ew_live", i, out[i + 1], d + a * (1LL << b));
    check("mldexpacc_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mldexpacc_ew_x_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mldexpacc_ew_x_dead", i, out[i + 1], d + a * 4);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mldexpacc_ew_x_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mldexpacc_ew_x_live", i, out[i + 1], d + a * 4);
    check("mldexpacc_ew_x_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mrdexp_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mrdexp_ew", i, out[i + 1], a / (1LL << b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mrdexpacc_ew_dead(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mrdexpacc_ew_dead", i, out[i + 1], d + a / (1LL << b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mrdexpacc_ew_live(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mrdexpacc_ew_live", i, out[i + 1], d + a / (1LL << b));
    check("mrdexpacc_ew_live old", i, saved[i], dp[i]);
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  return finish();
}
