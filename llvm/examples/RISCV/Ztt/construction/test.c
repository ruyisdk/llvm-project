// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

KERNEL void ztt_test_construction(int32_t out[8][Elements], size_t *stype) {
  __riscv_ztt_i32_1x1_t clear = __riscv_ztt_mclear_m_i32_1x1();
  __riscv_ztt_mss_rm(out[0], clear);
  __riscv_ztt_i32_1x1_t zero = __riscv_ztt_mzero_m_i32_1x1();
  __riscv_ztt_mss_rm(out[1], zero);
  __riscv_ztt_i32_accx1_t ac = __riscv_ztt_mclear_acc_i32_accx1();
  __riscv_ztt_i32_1x1_t acm = __riscv_ztt_mcopy_a2m_i32_1x1(ac);
  __riscv_ztt_mss_rm(out[2], acm);
  __riscv_ztt_i32_accx1_t az = __riscv_ztt_mzero_acc_i32_accx1();
  __riscv_ztt_i32_1x1_t azm = __riscv_ztt_mcopy_a2m_i32_1x1(az);
  __riscv_ztt_mss_rm(out[3], azm);
  __riscv_ztt_i32_scalar_t scalar = -17;
  __riscv_ztt_i32_1x1_t broadcast = __riscv_ztt_mbcast_m_x_i32_1x1(scalar);
  __riscv_ztt_mss_rm(out[4], broadcast);
  __riscv_ztt_i32_1x1_t rows = __riscv_ztt_mrowid_ew_i32_1x1();
  __riscv_ztt_mss_rm(out[5], rows);
  __riscv_ztt_i32_1x1_t cols = __riscv_ztt_mcolid_ew_i32_1x1();
  __riscv_ztt_mss_rm(out[6], cols);
  // Unlike mbcast, a data-scalar arithmetic operation writes amestype.
  __riscv_ztt_i32_1x1_t sum = __riscv_ztt_madd_ew_x_i32_1x1(zero, scalar);
  __riscv_ztt_mss_rm(out[7], sum);
  *stype = __riscv_ztt_get_amestype();
}

// Named kernels also exercise the state-interface instructions.
KERNEL size_t ztt_test_acquire(void) { return __riscv_ztt_ame_acquire(0); }

KERNEL void ztt_test_release(void) { __riscv_ztt_ame_release(); }

KERNEL void ztt_test_csrs(size_t *values) {
  values[0] = __riscv_ztt_get_ameown();
  values[1] = __riscv_ztt_get_amestype();
  values[2] = __riscv_ztt_get_amenlen();
  values[3] = __riscv_ztt_get_ameudsz();
  values[4] = __riscv_ztt_get_amefflags();
  values[5] = __riscv_ztt_get_amexsat();
  values[6] = __riscv_ztt_get_amestatus();
}

int main(void) {
  check("initial ownership", 0, __riscv_ztt_get_ameown() & 1, 0);
  if (!(ztt_test_acquire() & 1)) {
    puts("FAIL acquire");
    return 2;
  }
  check("ownership", 0, __riscv_ztt_get_ameown() & 1, 1);
#if __riscv_ztt_uds == 32
  const int uds = 32;
#elif __riscv_ztt_uds == 16
  const int uds = 16;
#else
  const int uds = 8;
#endif
  check("ameudsz", 0, __riscv_ztt_get_ameudsz(), uds);
  check("amenlen", 0, __riscv_ztt_get_amenlen(), N);
  int32_t out[8][Elements];
  size_t stype;
  ztt_test_construction(out, &stype);
  check("amestype i32", 0, stype, 0x40000020);
  size_t csrs[7];
  ztt_test_csrs(csrs);
  check("ameown snapshot", 0, csrs[0] & 1, 1);
  check("amestype snapshot", 0, csrs[1], 0x40000020);
  check("amenlen snapshot", 0, csrs[2], N);
  check("ameudsz snapshot", 0, csrs[3], uds);
  check("amefflags", 0, csrs[4], 0);
  check("amexsat", 0, csrs[5], 0);
  check("amestatus", 0, csrs[6] & 1, 0);
  for (int k = 0; k < 8; ++k)
    for (int i = 0; i < Elements; ++i)
      check("construction", k * Elements + i, out[k][i],
            k < 4                ? 0
            : (k == 4 || k == 7) ? -17
            : k == 5             ? i / N
                                 : i % N);
  ztt_test_release();
  check("released ownership", 0, __riscv_ztt_get_ameown() & 1, 0);
  // Do not read owner-only CSRs after release. Reacquire for the common
  // epilogue.
  if (!begin())
    return 2;
  return finish();
}
