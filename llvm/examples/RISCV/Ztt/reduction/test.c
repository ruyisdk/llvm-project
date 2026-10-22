// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Independent scalar row/column prefix and reduction oracle.

KERNEL void ztt_test_mprefixadd_row(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mprefixadd_row_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mprefixadd_col(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mprefixadd_col_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mprefixmax_row(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mprefixmax_row_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mprefixmax_col(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mprefixmax_col_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mreduceadd_row(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mreduceadd_row_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mreduceadd_col(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mreduceadd_col_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mreducemax_row(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mreducemax_row_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mreducemax_col(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mreducemax_col_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mreducemin_row(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mreducemin_row_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mreducemin_col(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t result = __riscv_ztt_mreducemin_col_i32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  int32_t input[Elements], out[Elements];
  for (int i = 0; i < Elements; ++i)
    input[i] = (i * 7) % 19 - 9;
  ztt_test_mprefixadd_row(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = c + 1;
      int64_t want = 0;
      for (int j = 0; j < count; ++j) {
        int value = input[r * N + j];
        want += value;
      }
      check("mprefixadd.row", r * N + c, out[r * N + c], want);
    }
  ztt_test_mprefixadd_col(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = r + 1;
      int64_t want = 0;
      for (int j = 0; j < count; ++j) {
        int value = input[j * N + c];
        want += value;
      }
      check("mprefixadd.col", r * N + c, out[r * N + c], want);
    }
  ztt_test_mprefixmax_row(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = c + 1;
      int64_t want = INT32_MIN;
      for (int j = 0; j < count; ++j) {
        int value = input[r * N + j];
        if (value > want)
          want = value;
      }
      check("mprefixmax.row", r * N + c, out[r * N + c], want);
    }
  ztt_test_mprefixmax_col(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = r + 1;
      int64_t want = INT32_MIN;
      for (int j = 0; j < count; ++j) {
        int value = input[j * N + c];
        if (value > want)
          want = value;
      }
      check("mprefixmax.col", r * N + c, out[r * N + c], want);
    }
  ztt_test_mreduceadd_row(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = N;
      int64_t want = 0;
      for (int j = 0; j < count; ++j) {
        int value = input[r * N + j];
        want += value;
      }
      check("mreduceadd.row", r * N + c, out[r * N + c], want);
    }
  ztt_test_mreduceadd_col(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = N;
      int64_t want = 0;
      for (int j = 0; j < count; ++j) {
        int value = input[j * N + c];
        want += value;
      }
      check("mreduceadd.col", r * N + c, out[r * N + c], want);
    }
  ztt_test_mreducemax_row(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = N;
      int64_t want = INT32_MIN;
      for (int j = 0; j < count; ++j) {
        int value = input[r * N + j];
        if (value > want)
          want = value;
      }
      check("mreducemax.row", r * N + c, out[r * N + c], want);
    }
  ztt_test_mreducemax_col(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = N;
      int64_t want = INT32_MIN;
      for (int j = 0; j < count; ++j) {
        int value = input[j * N + c];
        if (value > want)
          want = value;
      }
      check("mreducemax.col", r * N + c, out[r * N + c], want);
    }
  ztt_test_mreducemin_row(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = N;
      int64_t want = INT32_MAX;
      for (int j = 0; j < count; ++j) {
        int value = input[r * N + j];
        if (value < want)
          want = value;
      }
      check("mreducemin.row", r * N + c, out[r * N + c], want);
    }
  ztt_test_mreducemin_col(input, out);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int count = N;
      int64_t want = INT32_MAX;
      for (int j = 0; j < count; ++j) {
        int value = input[j * N + c];
        if (value < want)
          want = value;
      }
      check("mreducemin.col", r * N + c, out[r * N + c], want);
    }
  return finish();
}
