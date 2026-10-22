// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// A and B are non-symmetric. The oracle computes transpose choices explicitly.

KERNEL void ztt_test_mmulacc_dead(const int32_t *ap, const int32_t *bp,
                                  const int32_t *seed, int32_t *out,
                                  int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result = __riscv_ztt_mmulacc_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
}

KERNEL void ztt_test_mmulacc_live(const int32_t *ap, const int32_t *bp,
                                  const int32_t *seed, int32_t *out,
                                  int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result = __riscv_ztt_mmulacc_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i32_1x1_t old_m = __riscv_ztt_mcopy_a2m_i32_1x1(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

KERNEL void ztt_test_mmulaccneg_dead(const int32_t *ap, const int32_t *bp,
                                     const int32_t *seed, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulaccneg_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
}

KERNEL void ztt_test_mmulaccneg_live(const int32_t *ap, const int32_t *bp,
                                     const int32_t *seed, int32_t *out,
                                     int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulaccneg_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i32_1x1_t old_m = __riscv_ztt_mcopy_a2m_i32_1x1(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

KERNEL void ztt_test_mmulatacc_dead(const int32_t *ap, const int32_t *bp,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
}

KERNEL void ztt_test_mmulatacc_live(const int32_t *ap, const int32_t *bp,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulatacc_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i32_1x1_t old_m = __riscv_ztt_mcopy_a2m_i32_1x1(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

KERNEL void ztt_test_mmulataccneg_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *seed, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulataccneg_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
}

KERNEL void ztt_test_mmulataccneg_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *seed, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulataccneg_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i32_1x1_t old_m = __riscv_ztt_mcopy_a2m_i32_1x1(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

KERNEL void ztt_test_mmulbtacc_dead(const int32_t *ap, const int32_t *bp,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
}

KERNEL void ztt_test_mmulbtacc_live(const int32_t *ap, const int32_t *bp,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulbtacc_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i32_1x1_t old_m = __riscv_ztt_mcopy_a2m_i32_1x1(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

KERNEL void ztt_test_mmulbtaccneg_dead(const int32_t *ap, const int32_t *bp,
                                       const int32_t *seed, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulbtaccneg_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
}

KERNEL void ztt_test_mmulbtaccneg_live(const int32_t *ap, const int32_t *bp,
                                       const int32_t *seed, int32_t *out,
                                       int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(ap);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(bp);
  __riscv_ztt_i32_1x1_t initial = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_accx1_t old = __riscv_ztt_mcopy_m2a_i32_accx1(initial);
  __riscv_ztt_i32_accx1_t result =
      __riscv_ztt_mmulbtaccneg_2d_i32_accx1(old, a, b);
  __riscv_ztt_i32_1x1_t m = __riscv_ztt_mcopy_a2m_i32_1x1(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i32_1x1_t old_m = __riscv_ztt_mcopy_a2m_i32_1x1(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

// At UDS32 an i16 transfer moves two ACC squares together. Matmul only
// updates square zero: both the copied tail and the original must survive.
KERNEL void ztt_test_packed_tail(const int16_t *ap, const int16_t *bp,
                               const int16_t *seed, int16_t *out,
                               int16_t *saved) {
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mls_rm_i16_1x2(ap);
  __riscv_ztt_i16_2x1_t b = __riscv_ztt_mls_rm_i16_2x1(bp);
  __riscv_ztt_i16_1x2_t initial = __riscv_ztt_mls_rm_i16_1x2(seed);
  __riscv_ztt_i16_accx2_t old = __riscv_ztt_mcopy_m2a_i16_accx2(initial);
  __riscv_ztt_i16_accx2_t result = __riscv_ztt_mmulacc_2d_i16_accx2(old, a, b);
  __riscv_ztt_i16_1x2_t m = __riscv_ztt_mcopy_a2m_i16_1x2(result);
  __riscv_ztt_mss_rm(out, m);
  __riscv_ztt_i16_1x2_t old_m = __riscv_ztt_mcopy_a2m_i16_1x2(old);
  __riscv_ztt_mss_rm(saved, old_m);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t a[Elements], b[Elements], seed[Elements], out[Elements],
      saved[Elements];
  for (int i = 0; i < Elements; ++i) {
    a[i] = 3 * (i / N) - 2 * (i % N) + 1;
    b[i] = 2 * (i / N) + (i % N) - 4;
    seed[i] = 100 + i;
  }
  ztt_test_mmulacc_dead(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[k * N + c];
      check("mmulacc_dead", r * N + c, out[r * N + c],
            seed[r * N + c] + product);
    }
  ztt_test_mmulacc_live(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[k * N + c];
      check("mmulacc_live", r * N + c, out[r * N + c],
            seed[r * N + c] + product);
      check("old ACC", r * N + c, saved[r * N + c], seed[r * N + c]);
    }
  ztt_test_mmulaccneg_dead(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[k * N + c];
      check("mmulaccneg_dead", r * N + c, out[r * N + c],
            seed[r * N + c] - product);
    }
  ztt_test_mmulaccneg_live(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[k * N + c];
      check("mmulaccneg_live", r * N + c, out[r * N + c],
            seed[r * N + c] - product);
      check("old ACC", r * N + c, saved[r * N + c], seed[r * N + c]);
    }
  ztt_test_mmulatacc_dead(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[k * N + r] * b[k * N + c];
      check("mmulatacc_dead", r * N + c, out[r * N + c],
            seed[r * N + c] + product);
    }
  ztt_test_mmulatacc_live(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[k * N + r] * b[k * N + c];
      check("mmulatacc_live", r * N + c, out[r * N + c],
            seed[r * N + c] + product);
      check("old ACC", r * N + c, saved[r * N + c], seed[r * N + c]);
    }
  ztt_test_mmulataccneg_dead(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[k * N + r] * b[k * N + c];
      check("mmulataccneg_dead", r * N + c, out[r * N + c],
            seed[r * N + c] - product);
    }
  ztt_test_mmulataccneg_live(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[k * N + r] * b[k * N + c];
      check("mmulataccneg_live", r * N + c, out[r * N + c],
            seed[r * N + c] - product);
      check("old ACC", r * N + c, saved[r * N + c], seed[r * N + c]);
    }
  ztt_test_mmulbtacc_dead(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[c * N + k];
      check("mmulbtacc_dead", r * N + c, out[r * N + c],
            seed[r * N + c] + product);
    }
  ztt_test_mmulbtacc_live(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[c * N + k];
      check("mmulbtacc_live", r * N + c, out[r * N + c],
            seed[r * N + c] + product);
      check("old ACC", r * N + c, saved[r * N + c], seed[r * N + c]);
    }
  ztt_test_mmulbtaccneg_dead(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[c * N + k];
      check("mmulbtaccneg_dead", r * N + c, out[r * N + c],
            seed[r * N + c] - product);
    }
  ztt_test_mmulbtaccneg_live(a, b, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int64_t product = 0;
      for (int k = 0; k < N; ++k)
        product += (int64_t)a[r * N + k] * b[c * N + k];
      check("mmulbtaccneg_live", r * N + c, out[r * N + c],
            seed[r * N + c] - product);
      check("old ACC", r * N + c, saved[r * N + c], seed[r * N + c]);
    }
  int16_t pa[2 * Elements], pb[2 * Elements], ps[2 * Elements];
  int16_t po[2 * Elements], saved_pair[2 * Elements];
  for (int i = 0; i < 2 * Elements; ++i) {
    pa[i] = i % 9 - 4;
    pb[i] = i % 7 - 3;
    ps[i] = i < Elements ? 100 + i : -100 - i;
  }
  ztt_test_packed_tail(pa, pb, ps, po, saved_pair);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int product = 0;
      for (int s = 0; s < 2; ++s)
        for (int k = 0; k < N; ++k)
          product += pa[s * Elements + r * N + k] *
                     pb[s * Elements + k * N + c];
      check("packed ACC head", r * N + c, po[r * N + c],
            ps[r * N + c] + product);
      check("packed ACC tail", r * N + c, po[Elements + r * N + c],
            ps[Elements + r * N + c]);
    }
  for (int i = 0; i < 2 * Elements; ++i)
    check("packed old ACC", i, saved_pair[i], ps[i]);
  return finish();
}
