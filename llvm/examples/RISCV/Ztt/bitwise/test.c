// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Scalar expectations below follow the documented operand order, not assembly.

KERNEL void ztt_test_mand_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mand_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mand_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mand_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mandnot_ew(const int32_t *ap, const int32_t *bp,
                                const int32_t *dp, int32_t *out,
                                int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mandnot_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mandnot_ew_x(const int32_t *ap, const int32_t *bp,
                                  const int32_t *dp, int32_t *out,
                                  int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mandnot_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mor_ew(const int32_t *ap, const int32_t *bp,
                            const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mor_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mor_ew_x(const int32_t *ap, const int32_t *bp,
                              const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mor_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mornot_ew(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mornot_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mornot_ew_x(const int32_t *ap, const int32_t *bp,
                                 const int32_t *dp, int32_t *out,
                                 int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mornot_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mxor_ew(const int32_t *ap, const int32_t *bp,
                             const int32_t *dp, int32_t *out, int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mxor_ew_i32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mxor_ew_x(const int32_t *ap, const int32_t *bp,
                               const int32_t *dp, int32_t *out,
                               int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_scalar_t x = 8;
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mxor_ew_x_i32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t ap[Elements], bp[Elements], dp[Elements];
  int32_t out[Elements + 2], saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = i % 2 ? -17 - i : 37 + i;
    bp[i] = 0x55 ^ (i * 11);
    dp[i] = i - 3;
  }
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mand_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mand_ew", i, out[i + 1], (int32_t)((uint32_t)a & (uint32_t)b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mand_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mand_ew_x", i, out[i + 1], (int32_t)((uint32_t)x & (uint32_t)a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mandnot_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mandnot_ew", i, out[i + 1], (int32_t)((uint32_t)a & ~(uint32_t)b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mandnot_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mandnot_ew_x", i, out[i + 1], (int32_t)((uint32_t)x & ~(uint32_t)a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mor_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mor_ew", i, out[i + 1], (int32_t)((uint32_t)a | (uint32_t)b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mor_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mor_ew_x", i, out[i + 1], (int32_t)((uint32_t)x | (uint32_t)a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mornot_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mornot_ew", i, out[i + 1], (int32_t)((uint32_t)a | ~(uint32_t)b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mornot_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mornot_ew_x", i, out[i + 1], (int32_t)((uint32_t)x | ~(uint32_t)a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mxor_ew(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mxor_ew", i, out[i + 1], (int32_t)((uint32_t)a ^ (uint32_t)b));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  out[0] = out[Elements + 1] = 1234567;
  ztt_test_mxor_ew_x(ap, bp, dp, out + 1, saved);
  for (int i = 0; i < Elements; ++i) {
    int64_t a = ap[i], b = bp[i], d = dp[i], x = 8;
    check("mxor_ew_x", i, out[i + 1], (int32_t)((uint32_t)x ^ (uint32_t)a));
  }
  check("guard", 0, out[0], 1234567);
  check("guard", 1, out[Elements + 1], 1234567);
  return finish();
}
