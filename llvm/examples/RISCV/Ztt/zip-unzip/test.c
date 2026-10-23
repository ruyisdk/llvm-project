// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// N=4, two row-major squares A=0..15 and B=16..31. Expected images
// are written independently from the generated matrix instructions.
static const int32_t input[32] = {0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,
                                  11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
                                  22, 23, 24, 25, 26, 27, 28, 29, 30, 31};
static const int32_t expected[4][32] = {
    {0, 16, 1, 17, 4, 20, 5, 21, 8,  24, 9,  25, 12, 28, 13, 29,
     2, 18, 3, 19, 6, 22, 7, 23, 10, 26, 11, 27, 14, 30, 15, 31},
    {0, 2, 16, 18, 4, 6, 20, 22, 8, 10, 24, 26, 12, 14, 28, 30,
     1, 3, 17, 19, 5, 7, 21, 23, 9, 11, 25, 27, 13, 15, 29, 31},
    {0, 1, 2,  3,  16, 17, 18, 19, 4,  5,  6,  7,  20, 21, 22, 23,
     8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31},
    {0, 1, 2, 3, 8,  9,  10, 11, 16, 17, 18, 19, 24, 25, 26, 27,
     4, 5, 6, 7, 12, 13, 14, 15, 20, 21, 22, 23, 28, 29, 30, 31}};
static int32_t output[5][32];
KERNEL void ztt_test_zip_live(void) {
  __riscv_ztt_i32_1x2_t src = __riscv_ztt_mls_rm_i32_1x2(input);
  __riscv_ztt_i32_1x2_t cz = __riscv_ztt_mcolzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(output[0], cz);
  __riscv_ztt_i32_1x2_t cu = __riscv_ztt_mcolunzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(output[1], cu);
  __riscv_ztt_i32_1x2_t rz = __riscv_ztt_mrowzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(output[2], rz);
  __riscv_ztt_i32_1x2_t ru = __riscv_ztt_mrowunzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(output[3], ru);
  __riscv_ztt_mss_rm(output[4], src);
}
KERNEL void ztt_test_mcolzip_dead(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x2_t src = __riscv_ztt_mls_rm_i32_1x2(p);
  __riscv_ztt_i32_1x2_t result = __riscv_ztt_mcolzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(out, result);
}
KERNEL void ztt_test_mcolunzip_dead(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x2_t src = __riscv_ztt_mls_rm_i32_1x2(p);
  __riscv_ztt_i32_1x2_t result = __riscv_ztt_mcolunzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(out, result);
}
KERNEL void ztt_test_mrowzip_dead(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x2_t src = __riscv_ztt_mls_rm_i32_1x2(p);
  __riscv_ztt_i32_1x2_t result = __riscv_ztt_mrowzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(out, result);
}
KERNEL void ztt_test_mrowunzip_dead(const int32_t *p, int32_t *out) {
  __riscv_ztt_i32_1x2_t src = __riscv_ztt_mls_rm_i32_1x2(p);
  __riscv_ztt_i32_1x2_t result = __riscv_ztt_mrowunzip_ew_i32_1x2(src);
  __riscv_ztt_mss_rm(out, result);
}
int main(void) {
  if (!begin())
    return 2;
  int32_t dead[32];
  ztt_test_mcolzip_dead(input, dead);
  for (unsigned i = 0; i < 32; ++i)
    check("mcolzip dead", i, dead[i], expected[0][i]);
  ztt_test_mcolunzip_dead(input, dead);
  for (unsigned i = 0; i < 32; ++i)
    check("mcolunzip dead", i, dead[i], expected[1][i]);
  ztt_test_mrowzip_dead(input, dead);
  for (unsigned i = 0; i < 32; ++i)
    check("mrowzip dead", i, dead[i], expected[2][i]);
  ztt_test_mrowunzip_dead(input, dead);
  for (unsigned i = 0; i < 32; ++i)
    check("mrowunzip dead", i, dead[i], expected[3][i]);
  ztt_test_zip_live();
  for (unsigned k = 0; k < 5; ++k)
    for (unsigned i = 0; i < 32; ++i) {
      int32_t want = k == 4 ? input[i] : expected[k][i];
      check("zip/unzip live", k * 32 + i, output[k][i], want);
    }
  return finish();
}
