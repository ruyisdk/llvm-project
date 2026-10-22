// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Distinct input coordinates; gather reverses indices, scatter collides in
// pairs.

KERNEL void ztt_test_mrowbcast_ew_x(const int32_t *p, const int32_t *indices,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mrowbcast_ew_x_i32_1x1(a, (size_t)1);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrowgather_ew(const int32_t *p, const int32_t *indices,
                                   const int32_t *seed, int32_t *out,
                                   int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mrowgather_ew_i32_1x1(a, idx);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrowscatadd_ew_dead(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mrowscatadd_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrowscatadd_ew_live(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mrowscatadd_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, old);
}

KERNEL void ztt_test_mrowscatmax_ew_dead(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mrowscatmax_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrowscatmax_ew_live(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mrowscatmax_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, old);
}

KERNEL void ztt_test_mrowshift_ew_x(const int32_t *p, const int32_t *indices,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mrowshift_ew_x_i32_1x1(a, -1);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcolbcast_ew_x(const int32_t *p, const int32_t *indices,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mcolbcast_ew_x_i32_1x1(a, (size_t)1);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcolgather_ew(const int32_t *p, const int32_t *indices,
                                   const int32_t *seed, int32_t *out,
                                   int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcolgather_ew_i32_1x1(a, idx);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcolscatadd_ew_dead(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mcolscatadd_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcolscatadd_ew_live(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mcolscatadd_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, old);
}

KERNEL void ztt_test_mcolscatmax_ew_dead(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mcolscatmax_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcolscatmax_ew_live(const int32_t *p,
                                         const int32_t *indices,
                                         const int32_t *seed, int32_t *out,
                                         int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t idx = __riscv_ztt_mls_rm_i32_1x1(indices);
  __riscv_ztt_i32_1x1_t old = __riscv_ztt_mls_rm_i32_1x1(seed);
  __riscv_ztt_i32_1x1_t result =
      __riscv_ztt_mcolscatmax_ew_i32_1x1(old, a, idx);
  __riscv_ztt_mss_rm(out, result);
  __riscv_ztt_mss_rm(saved, old);
}

KERNEL void ztt_test_mcolshift_ew_x(const int32_t *p, const int32_t *indices,
                                    const int32_t *seed, int32_t *out,
                                    int32_t *saved) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mcolshift_ew_x_i32_1x1(a, -1);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t input[Elements], indices[Elements], seed[Elements];
  int32_t out[Elements], saved[Elements], want[Elements];
  for (int i = 0; i < Elements; ++i) {
    input[i] = 3 * i - 17;
    seed[i] = i - 7;
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = r / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowbcast_ew_x(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      want[r * N + c] = input[N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowbcast_ew_x", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = N - 1 - r;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowgather_ew(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      want[r * N + c] = input[(N - 1 - r) * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowgather_ew", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = r / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowscatadd_ew_dead(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = indices[r * N + c] * N + c;
      want[dest] += input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowscatadd_ew_dead", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = r / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowscatadd_ew_live(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = indices[r * N + c] * N + c;
      want[dest] += input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowscatadd_ew_live", i, out[i], want[i]);
    check("old destination", i, saved[i], seed[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = r / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowscatmax_ew_dead(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = indices[r * N + c] * N + c;
      if (input[r * N + c] > want[dest])
        want[dest] = input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowscatmax_ew_dead", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = r / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowscatmax_ew_live(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = indices[r * N + c] * N + c;
      if (input[r * N + c] > want[dest])
        want[dest] = input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowscatmax_ew_live", i, out[i], want[i]);
    check("old destination", i, saved[i], seed[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = r / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mrowshift_ew_x(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      want[r * N + c] = r ? input[(r - 1) * N + c] : 0;
    }
  for (int i = 0; i < Elements; ++i) {
    check("mrowshift_ew_x", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = c / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolbcast_ew_x(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      want[r * N + c] = input[r * N + 1];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolbcast_ew_x", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = N - 1 - c;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolgather_ew(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      want[r * N + c] = input[r * N + N - 1 - c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolgather_ew", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = c / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolscatadd_ew_dead(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = r * N + indices[r * N + c];
      want[dest] += input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolscatadd_ew_dead", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = c / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolscatadd_ew_live(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = r * N + indices[r * N + c];
      want[dest] += input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolscatadd_ew_live", i, out[i], want[i]);
    check("old destination", i, saved[i], seed[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = c / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolscatmax_ew_dead(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = r * N + indices[r * N + c];
      if (input[r * N + c] > want[dest])
        want[dest] = input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolscatmax_ew_dead", i, out[i], want[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = c / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolscatmax_ew_live(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int dest = r * N + indices[r * N + c];
      if (input[r * N + c] > want[dest])
        want[dest] = input[r * N + c];
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolscatmax_ew_live", i, out[i], want[i]);
    check("old destination", i, saved[i], seed[i]);
  }
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      indices[r * N + c] = c / 2;
      want[r * N + c] = seed[r * N + c];
    }
  ztt_test_mcolshift_ew_x(input, indices, seed, out, saved);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      want[r * N + c] = c ? input[r * N + c - 1] : 0;
    }
  for (int i = 0; i < Elements; ++i) {
    check("mcolshift_ew_x", i, out[i], want[i]);
  }
  return finish();
}
