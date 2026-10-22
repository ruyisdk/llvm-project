//===-- e2e-float.c - Self-checking floating Ztt integration example --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// clang -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 -mabi=lp64d -O2 -fno-unwind-tables -fno-asynchronous-unwind-tables -static e2e-float.c -lm -o a.out
// qemu-riscv64 -cpu rv64,x-ztt=true,amenlen=32,ameudsz=32,ame-num-mregs=16,ame-num-accregs=4 a.out
//
// See README.md for build and run commands.
// Scalar reference computations run only after all matrix values are dead.

#include <math.h>
#include <stddef.h>
#include <stdio.h>
#include <riscv_ztt.h>

#if __riscv_ztt_mregs != 16 || __riscv_ztt_accregs != 4
#error "Compile this example for the M16/A4 profile"
#endif

enum { MaxN = 32, Capacity = 2 * MaxN * MaxN, Guard = 8 };
enum {
  Add, Multiply, Fused, Absolute, Clamp, Prefix, Reduce, RowBroadcast,
  Sqrt, Reciprocal, ReciprocalSqrt, Exp2, Log2, Tanh,
  RoundDown, RoundUp, RoundZero, RoundNearest, ScalarAdd, ScalarMultiply,
  Compare, Select, Stages
};
static const double Sentinel = -12345;
static float x_in[Capacity + 2 * Guard], y_in[Capacity + 2 * Guard];
static float out[Stages][Capacity + 2 * Guard];
static _Float16 a_rm[Capacity + 2 * Guard], b_cm[Capacity + 2 * Guard];
static float product_rm[Capacity + 2 * Guard], product_cm[Capacity + 2 * Guard];
static double wide_out[Capacity + 2 * Guard];
static float narrow_out[Capacity + 2 * Guard];
static int compare_out[Capacity + 2 * Guard];

volatile struct {
  size_t n, uds, acquire_result;
  unsigned failures, first_stage;
  size_t first_index;
  double expected, actual, tolerance, max_absolute_error;
} ztt_test_report;

static void expect(unsigned stage, size_t i, double actual, double expected,
                   double tolerance) {
  double error = fabs(actual - expected);
  if (error > ztt_test_report.max_absolute_error)
    ztt_test_report.max_absolute_error = error;
  // A NaN cannot pass the comparison; none of our inputs has an infinite result.
  if (isfinite(actual) && isfinite(expected) && error <= tolerance)
    return;
  if (!ztt_test_report.failures) {
    ztt_test_report.first_stage = stage;
    ztt_test_report.first_index = i;
    ztt_test_report.expected = expected;
    ztt_test_report.actual = actual;
    ztt_test_report.tolerance = tolerance;
  }
  ++ztt_test_report.failures;
}

// Zero-based coordinates. Dyadic inputs and bounded sums/products are exact
// in f16 inputs and f32 arithmetic, independent of reduction association.
static double x_value(int r, int c) { return (r - c) / 16.0; }
static double y_value(int r, int c) { return 1 + ((r + c) % 16) / 16.0; }
static double a_value(int s, int r, int k) {
  return s ? (r - k) / 16.0 : (r + k + 1) / 16.0;
}
static double b_value(int s, int k, int c) {
  return s ? (k + c + 1) / 16.0 : (k - c) / 16.0;
}

// A0*B0 + A1*B1: the k^2 terms cancel. Summand numerator is
// 2*(r-c)*k + r-c, hence P = (r-c)*N^2/256.
static double product_value(int n, int r, int c) {
  return (r - c) * n * n / 256.0;
}

static void prepare(int n) {
  for (size_t i = 0; i < Capacity + 2 * Guard; ++i) {
    x_in[i] = y_in[i] = Sentinel;
    a_rm[i] = b_cm[i] = (_Float16)-12344;
    product_rm[i] = product_cm[i] = Sentinel;
    wide_out[i] = narrow_out[i] = Sentinel;
    compare_out[i] = -12345;
    for (unsigned s = 0; s < Stages; ++s)
      out[s][i] = Sentinel;
  }
  for (int r = 0; r < n; ++r)
    for (int c = 0; c < n; ++c) {
      size_t i = Guard + r * n + c;
      x_in[i] = x_value(r, c);
      y_in[i] = y_value(r, c);
      for (int s = 0; s < 2; ++s) {
        a_rm[Guard + s * n * n + r * n + c] = a_value(s, r, c);
        b_cm[Guard + s * n * n + c * n + r] = b_value(s, r, c);
      }
    }
}

__attribute__((noinline)) static void float_matrix_chain(void) {
  __riscv_ztt_f16_1x2_t a = __riscv_ztt_mls_rm_f16_1x2(a_rm + Guard);
  __riscv_ztt_f16_2x1_t b = __riscv_ztt_mls_cm_f16_2x1(b_cm + Guard);
  __riscv_ztt_f32_accx2_t acc = __riscv_ztt_mzero_acc_f32_accx2();
  acc = __riscv_ztt_mmulacc_2d_f32_accx2(acc, a, b);
  __riscv_ztt_f32_1x2_t p = __riscv_ztt_mcopy_a2m_f32_1x2(acc);
  __riscv_ztt_mss_rm(product_rm + Guard, p);
  __riscv_ztt_mss_cm(product_cm + Guard, p);
}

__attribute__((noinline)) static void float_arithmetic_chain(void) {
  __riscv_ztt_f32_scalar_t limit = 2.0f, half = 0.5f;
  __riscv_ztt_f32_1x1_t x = __riscv_ztt_mls_rm_f32_1x1(x_in + Guard);
  __riscv_ztt_f32_1x1_t y = __riscv_ztt_mls_rm_f32_1x1(y_in + Guard);
#define STEP(Name, Expr)                                                        \
  __riscv_ztt_f32_1x1_t v##Name = (Expr);                                       \
  __riscv_ztt_mss_rm(out[Name] + Guard, v##Name)
  STEP(Add, __riscv_ztt_madd_ew_f32_1x1(x, y));
  STEP(Multiply, __riscv_ztt_mmul_ew_f32_1x1(x, y));
  STEP(Fused, __riscv_ztt_mmulacc_ew_f32_1x1(vAdd, x, y));
  STEP(Absolute, __riscv_ztt_mabs_ew_f32_1x1(vFused));
  STEP(Clamp, __riscv_ztt_mmin_ew_x_f32_1x1(vAbsolute, limit));
  STEP(Prefix, __riscv_ztt_mprefixadd_row_f32_1x1(vClamp));
  STEP(Reduce, __riscv_ztt_mreduceadd_row_f32_1x1(vClamp));
  STEP(RowBroadcast, __riscv_ztt_mrowbcast_ew_x_f32_1x1(vPrefix, 0));
  STEP(ScalarAdd, __riscv_ztt_madd_ew_x_f32_1x1(vClamp, half));
  STEP(ScalarMultiply, __riscv_ztt_mmul_ew_x_f32_1x1(vScalarAdd, half));
  __riscv_ztt_i32_1x1_t cmp = __riscv_ztt_mcmplt_ew_i32_1x1(x, y);
  __riscv_ztt_mss_rm(compare_out + Guard, cmp);
  STEP(Select, __riscv_ztt_msellt_ew_f32_1x1(x, vScalarMultiply));
  // Keep the old FMA destination observable after the destructive instruction.
  __riscv_ztt_mss_rm(out[Add] + Guard, vAdd);
#undef STEP
}

__attribute__((noinline)) static void float_nonlinear_chain(void) {
  __riscv_ztt_f32_1x1_t x = __riscv_ztt_mls_rm_f32_1x1(x_in + Guard);
  __riscv_ztt_f32_1x1_t y = __riscv_ztt_mls_rm_f32_1x1(y_in + Guard);
#define STEP(Name, Expr)                                                        \
  __riscv_ztt_f32_1x1_t v##Name = (Expr);                                       \
  __riscv_ztt_mss_rm(out[Name] + Guard, v##Name)
  STEP(Sqrt, __riscv_ztt_msqrt_ew_f32_1x1(y));
  STEP(Reciprocal, __riscv_ztt_mrec_ew_f32_1x1(y));
  STEP(ReciprocalSqrt, __riscv_ztt_mrsqrt_ew_f32_1x1(y));
  STEP(Exp2, __riscv_ztt_mexp2_ew_f32_1x1(x));
  STEP(Log2, __riscv_ztt_mlog2_ew_f32_1x1(y));
  STEP(Tanh, __riscv_ztt_mtanh_ew_f32_1x1(x));
  STEP(RoundDown, __riscv_ztt_mfrintm_ew_f32_1x1(x));
  STEP(RoundUp, __riscv_ztt_mfrintp_ew_f32_1x1(x));
  STEP(RoundZero, __riscv_ztt_mfrintz_ew_f32_1x1(x));
  STEP(RoundNearest, __riscv_ztt_mfrintn_ew_f32_1x1(x));
#undef STEP
}

__attribute__((noinline)) static void float_wide_chain(void) {
  __riscv_ztt_f64_scalar_t half = 0.5;
  __riscv_ztt_f32_1x1_t x = __riscv_ztt_mls_rm_f32_1x1(x_in + Guard);
  __riscv_ztt_f64_1x1_t wide = __riscv_ztt_mconv_ew_f64_1x1(x);
  __riscv_ztt_f64_1x1_t shifted = __riscv_ztt_madd_ew_x_f64_1x1(wide, half);
  __riscv_ztt_f64_1x1_t squared = __riscv_ztt_mmul_ew_f64_1x1(shifted, shifted);
  __riscv_ztt_mss_rm(wide_out + Guard, squared);
  __riscv_ztt_f32_1x1_t narrow = __riscv_ztt_mconv_ew_f32_1x1(squared);
  __riscv_ztt_mss_rm(narrow_out + Guard, narrow);
}

static double clamp_value(int r, int c) {
  double x = x_value(r, c), y = y_value(r, c);
  return fmin(fabs(x + y + x * y), 2.0);
}

// Two float ULPs around the double oracle: one for the allowed hardware
// approximation and one for rounding/reference error. Exact stages use zero.
// All nonzero nonlinear results here are normal f32 values.
static double nonlinear_tolerance(double expected) {
  if (expected == 0)
    return 0;
  int exponent;
  frexp(fabs(expected), &exponent);
  return ldexp(2.0, exponent - 24);
}

#define GUARDS(Buffer, Length, Value)                                           \
  do {                                                                         \
    for (size_t i = 0; i < Capacity + 2 * Guard; ++i)                            \
      if (i < Guard || i >= Guard + (size_t)(Length))                           \
        expect(200, i, (Buffer)[i], Value, 0);                                  \
  } while (0)

static void verify(int n) {
  for (int r = 0; r < n; ++r)
    for (int c = 0; c < n; ++c) {
      size_t i = Guard + r * n + c;
      double x = x_value(r, c), y = y_value(r, c), clamp = clamp_value(r, c);
      double ref[Stages] = {0};
      ref[Add] = x + y;
      ref[Multiply] = x * y;
      ref[Fused] = x + y + x * y;
      ref[Absolute] = fabs(ref[Fused]);
      ref[Clamp] = clamp;
      for (int k = 0; k < n; ++k) {
        ref[Reduce] += clamp_value(r, k);
        if (k <= c) {
          ref[Prefix] += clamp_value(r, k);
          ref[RowBroadcast] += clamp_value(0, k);
        }
      }
      ref[Sqrt] = sqrt(y);
      ref[Reciprocal] = 1 / y;
      ref[ReciprocalSqrt] = 1 / sqrt(y);
      ref[Exp2] = exp2(x);
      ref[Log2] = log2(y);
      ref[Tanh] = tanh(x);
      ref[RoundDown] = floor(x);
      ref[RoundUp] = ceil(x);
      ref[RoundZero] = trunc(x);
      ref[RoundNearest] = nearbyint(x); // Default RNE; includes +/- halfway cases.
      ref[ScalarAdd] = clamp + 0.5;
      ref[ScalarMultiply] = (clamp + 0.5) * 0.5;
      ref[Select] = x < 0 ? ref[ScalarMultiply] : 0;
      for (unsigned s = 0; s < Stages; ++s)
        if (s != Compare)
          expect(s, i, out[s][i], ref[s],
                 s >= Sqrt && s <= Tanh ? nonlinear_tolerance(ref[s]) : 0);
      expect(Compare, i, compare_out[i], x < y ? -1 : 0, 0);
      expect(100, i, wide_out[i], (x + 0.5) * (x + 0.5), 0);
      expect(101, i, narrow_out[i], (x + 0.5) * (x + 0.5), 0);
      expect(102, i, x_in[i], x, 0);
      expect(103, i, y_in[i], y, 0);
      double direct = 0;
      for (int s = 0; s < 2; ++s)
        for (int k = 0; k < n; ++k)
          direct += a_value(s, r, k) * b_value(s, k, c);
      expect(104, i, direct, product_value(n, r, c), 0);
      for (int s = 0; s < 2; ++s) {
        size_t rm = i + s * n * n;
        size_t cm = Guard + s * n * n + c * n + r;
        expect(105, rm, product_rm[rm], s ? 0 : product_value(n, r, c), 0);
        expect(106, cm, product_cm[cm], s ? 0 : product_value(n, r, c), 0);
        expect(107, rm, a_rm[rm], a_value(s, r, c), 0);
        expect(108, cm, b_cm[cm], b_value(s, r, c), 0);
      }
    }
  GUARDS(x_in, n * n, Sentinel);
  GUARDS(y_in, n * n, Sentinel);
  GUARDS(a_rm, 2 * n * n, -12344);
  GUARDS(b_cm, 2 * n * n, -12344);
  GUARDS(product_rm, 2 * n * n, Sentinel);
  GUARDS(product_cm, 2 * n * n, Sentinel);
  GUARDS(wide_out, n * n, Sentinel);
  GUARDS(narrow_out, n * n, Sentinel);
  GUARDS(compare_out, n * n, -12345);
  for (unsigned s = 0; s < Stages; ++s)
    GUARDS(out[s], s == Compare ? 0 : n * n, Sentinel);
}

int main(void) {
  if (__riscv_ztt_get_ameown() & 1)
    return 2;
  size_t acquired = __riscv_ztt_ame_acquire(0);
  ztt_test_report.acquire_result = acquired;
  if (!(acquired & 1))
    return 2;
  size_t n = __riscv_ztt_get_amenlen(), uds = __riscv_ztt_get_ameudsz();
  ztt_test_report.n = n;
  ztt_test_report.uds = uds;
#if __riscv_ztt_uds == 32
  const size_t compiled_uds = 32;
#elif __riscv_ztt_uds == 16
  const size_t compiled_uds = 16;
#elif __riscv_ztt_uds == 8
  const size_t compiled_uds = 8;
#else
#error "Compile this example for UDS32, UDS16 or UDS8"
#endif
  if (!n || n > MaxN || (n & (n - 1)) || uds != compiled_uds) {
    __riscv_ztt_ame_release();
    return 2;
  }
  prepare(n);
  float_matrix_chain();
  float_arithmetic_chain();
  float_nonlinear_chain();
  float_wide_chain();
  size_t status = __riscv_ztt_get_amestatus();
  __riscv_ztt_ame_release();
  expect(201, 0, status & 1, 0, 0);
  verify(n);
  if (ztt_test_report.failures)
    printf("FAIL stage=%u index=%zu expected=%.17g actual=%.17g tol=%.3g failures=%u\n",
           ztt_test_report.first_stage, ztt_test_report.first_index,
           ztt_test_report.expected, ztt_test_report.actual,
           ztt_test_report.tolerance, ztt_test_report.failures);
  else
    printf("PASS e2e-float N=%zu UDS=%zu\n", ztt_test_report.n,
           ztt_test_report.uds);
  return ztt_test_report.failures ? 1 : 0;
}
