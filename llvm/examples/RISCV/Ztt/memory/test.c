// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// Padded memory rows/columns have six elements, while matrices have four.
// All eight instructions are checked independently: not only inverse pairs.
enum { Pitch = 6, Storage = Pitch * N };
KERNEL void ztt_test_memory(const int32_t *src, const int32_t *padded,
                            int32_t loaded[4][Elements],
                            int32_t stored[4][Storage]) {
  __riscv_ztt_i32_1x1_t rm = __riscv_ztt_mls_rm_i32_1x1(src);
  __riscv_ztt_mss_rm(loaded[0], rm);
  __riscv_ztt_i32_1x1_t cm = __riscv_ztt_mls_cm_i32_1x1(src);
  __riscv_ztt_mss_rm(loaded[1], cm);
  __riscv_ztt_i32_1x1_t st =
      __riscv_ztt_mls_st_i32_1x1(padded, (size_t)(Pitch * 4));
  __riscv_ztt_mss_rm(loaded[2], st);
  __riscv_ztt_i32_1x1_t tst =
      __riscv_ztt_mls_tst_i32_1x1(padded, (size_t)(Pitch * 4));
  __riscv_ztt_mss_rm(loaded[3], tst);
  __riscv_ztt_mss_rm(stored[0], rm);
  __riscv_ztt_mss_cm(stored[1], rm);
  __riscv_ztt_mss_st(stored[2], (size_t)(Pitch * 4), rm);
  __riscv_ztt_mss_tst(stored[3], (size_t)(Pitch * 4), rm);
}
int main(void) {
  if (!begin())
    return 2;
  int32_t src[Elements], padded[Storage], loaded[4][Elements],
      stored[4][Storage];
  for (int i = 0; i < Elements; ++i)
    src[i] = i * 3 - 17;
  for (int i = 0; i < Storage; ++i) {
    padded[i] = i * 5 + 11;
    for (int k = 0; k < 4; ++k)
      stored[k][i] = 1234567;
  }
  ztt_test_memory(src, padded, loaded, stored);
  for (int r = 0; r < N; ++r)
    for (int c = 0; c < N; ++c) {
      int i = r * N + c;
      check("mls.rm", i, loaded[0][i], src[i]);
      check("mls.cm", i, loaded[1][i], src[c * N + r]);
      check("mls.st", i, loaded[2][i], padded[r * Pitch + c]);
      check("mls.tst", i, loaded[3][i], padded[c * Pitch + r]);
    }
  for (int k = 0; k < 4; ++k)
    for (int i = 0; i < Storage; ++i) {
      int pitch = k < 2 ? N : Pitch;
      int r = i / pitch, c = i % pitch;
      int32_t want =
          r < N && c < N ? src[k % 2 ? c * N + r : r * N + c] : 1234567;
      check("mss layout/guard", k * Storage + i, stored[k][i], want);
    }
  return finish();
}
