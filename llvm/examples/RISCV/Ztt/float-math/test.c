// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#include "../smoke.h"

// f32 libm reference evaluated in double, not obtained from Ztt output.
// Trig uses f16_1x2 because this QEMU has no f32 sin/cos tuple.

KERNEL void ztt_test_mfrintm_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mfrintm_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mfrintn_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mfrintn_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mfrintp_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mfrintp_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mfrintz_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mfrintz_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mexp2_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mexp2_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mlog2_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mlog2_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrec_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mrec_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mrsqrt_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mrsqrt_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msqrt_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_msqrt_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mtanh_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mtanh_ew_f32_1x1(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mlog2sub_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mls_rm_f32_1x1(bp);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mlog2sub_ew_f32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mlog2sub_ew_x(const float *ap, const float *bp,
                                   float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_scalar_t x = 0.5f;
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_mlog2sub_ew_x_f32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msublog2_ew(const float *ap, const float *bp, float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_1x1_t b = __riscv_ztt_mls_rm_f32_1x1(bp);
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_msublog2_ew_f32_1x1(a, b);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msublog2_ew_x(const float *ap, const float *bp,
                                   float *out) {
  __riscv_ztt_f32_1x1_t a = __riscv_ztt_mls_rm_f32_1x1(ap);
  __riscv_ztt_f32_scalar_t x = 0.5f;
  __riscv_ztt_f32_1x1_t result = __riscv_ztt_msublog2_ew_x_f32_1x1(a, x);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_msin(const _Float16 *p, _Float16 *out) {
  __riscv_ztt_f16_1x2_t a = __riscv_ztt_mls_rm_f16_1x2(p);
  __riscv_ztt_f16_1x2_t result = __riscv_ztt_msin_ew_f16_1x2(a);
  __riscv_ztt_mss_rm(out, result);
}

KERNEL void ztt_test_mcos(const _Float16 *p, _Float16 *out) {
  __riscv_ztt_f16_1x2_t a = __riscv_ztt_mls_rm_f16_1x2(p);
  __riscv_ztt_f16_1x2_t result = __riscv_ztt_mcos_ew_f16_1x2(a);
  __riscv_ztt_mss_rm(out, result);
}

int main(void) {
  if (!begin())
    return 2;
  float ap[Elements], bp[Elements], out[Elements];
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i - 8) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mfrintm_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mfrintm_ew", i, out[i], floor(a), 0, 0);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i - 8) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mfrintn_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mfrintn_ew", i, out[i], nearbyint(a), 0, 0);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i - 8) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mfrintp_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mfrintp_ew", i, out[i], ceil(a), 0, 0);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i - 8) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mfrintz_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mfrintz_ew", i, out[i], trunc(a), 0, 0);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i - 8) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mexp2_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mexp2_ew", i, out[i], exp2(a), 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mlog2_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mlog2_ew", i, out[i], log2(a), 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mrec_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mrec_ew", i, out[i], 1.0 / a, 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mrsqrt_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mrsqrt_ew", i, out[i], 1.0 / sqrt(a), 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_msqrt_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("msqrt_ew", i, out[i], sqrt(a), 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = (i - 8) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mtanh_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mtanh_ew", i, out[i], tanh(a), 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = -(i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mlog2sub_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mlog2sub_ew", i, out[i], log2(fabs(a)) - b, 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = -(i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_mlog2sub_ew_x(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("mlog2sub_ew_x", i, out[i], log2(fabs(a)) - 0.5, 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = -(i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_msublog2_ew(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("msublog2_ew", i, out[i], b - log2(fabs(a)), 2e-6, 2e-6);
  }
  for (int i = 0; i < Elements; ++i) {
    ap[i] = -(i + 1) * 0.25f;
    bp[i] = (i - 7) * 0.25f;
  }
  ztt_test_msublog2_ew_x(ap, bp, out);
  for (int i = 0; i < Elements; ++i) {
    double a = ap[i], b = bp[i];
    check_float("msublog2_ew_x", i, out[i], 0.5 - log2(fabs(a)), 2e-6, 2e-6);
  }
  _Float16 hp[2 * Elements], hout[2 * Elements];
  for (int i = 0; i < 2 * Elements; ++i)
    hp[i] = (_Float16)((i - 16) * 0.0625f);
  ztt_test_msin(hp, hout);
  for (int i = 0; i < 2 * Elements; ++i)
    check_float("msin", i, (double)hout[i], sin((double)hp[i]), 0.001, 0.001);
  ztt_test_mcos(hp, hout);
  for (int i = 0; i < 2 * Elements; ++i)
    check_float("mcos", i, (double)hout[i], cos((double)hp[i]), 0.001, 0.001);
  return finish();
}
