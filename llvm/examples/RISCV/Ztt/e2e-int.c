//===-- e2e-int.c - Self-checking integer Ztt integration example -----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// See README.md for build and run commands.
// This is a runtime test, not a replacement for LLVM/Clang FileCheck tests.
// ZTT_CHECK_ORACLE builds only the scalar oracle self-test on a host machine.
//
// clang -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 -mabi=lp64d -O2 -fno-unwind-tables -fno-asynchronous-unwind-tables -static e2e-int.c -o a.out
// qemu-riscv64 -cpu rv64,x-ztt=true,amenlen=32,ameudsz=32,ame-num-mregs=16,ame-num-accregs=4 a.out

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

#ifndef ZTT_CHECK_ORACLE
#include <riscv_ztt.h>
#if __riscv_ztt_mregs != 16 || __riscv_ztt_accregs != 4
#error "Compile this example for the M16/A4 profile"
#endif
#endif

#ifndef ZTT_MAX_N
#define ZTT_MAX_N 32
#endif
_Static_assert(ZTT_MAX_N > 0 && ZTT_MAX_N <= 32, "oracle bounds assume N <= 32");

enum { Capacity = 2 * ZTT_MAX_N * ZTT_MAX_N, Guard = 8 };
enum {
  PhaseConfig = 1, PhaseOracle, PhaseA, PhaseB, PhaseBroadcast, PhaseSum,
  PhaseProduct, PhaseFinalRM, PhaseFinalCM, PhaseSeeded, PhaseWide,
  PhaseInput, PhaseGuard, PhaseUnsupported
};

// Inspect this symbol in a debugger on failure. No printf/libc calls occur
// while matrix values are live. Exit zero means every element and guard passed.
volatile struct {
  size_t n, uds, acquire_result;
  unsigned failures, first_phase;
  size_t first_index;
  int64_t expected, actual;
} ztt_test_report;

static void expect(unsigned phase, size_t index, int64_t actual,
                   int64_t expected) {
  if (actual == expected)
    return;
  if (!ztt_test_report.failures) {
    ztt_test_report.first_phase = phase;
    ztt_test_report.first_index = index;
    ztt_test_report.expected = expected;
    ztt_test_report.actual = actual;
  }
  ++ztt_test_report.failures;
}

// r,k,c below are one-based mathematical coordinates, not byte offsets.
static int a_value(unsigned sq, int r, int k) {
  return sq ? 3 * r - k : r + 2 * k;
}
static int b_value(unsigned sq, int k, int c) {
  return sq ? k + 2 * c : 2 * k - c;
}
static int seed_value(unsigned sq, int r, int c) {
  return sq ? -200 - 7 * r + 3 * c : 100 + 5 * r - 2 * c;
}

// Sum over k of (r+2k)(2k-c+3) + (3r-k)(k+2c+3).
// = 3*S2 + (5r-4c+3)*S1 + N*(5rc+12r), independently of UDS.
static int64_t product_value(int n, int r, int c) {
  int64_t s1 = (int64_t)n * (n + 1) / 2;
  int64_t s2 = (int64_t)n * (n + 1) * (2 * n + 1) / 6;
  return 3 * s2 + (5 * r - 4 * c + 3) * s1 +
         (int64_t)n * (5 * r * c + 12 * r);
}

// Cross-check the closed form against direct scalar multiplication and the
// literal N=2 hand calculation. This does NOT execute or emulate Ztt code.
static void check_oracle(void) {
  static const int hand_product[4] = {61, 59, 110, 118};
  static const int hand_final[8] = {127, 123, 225, 241, 5, 5, 5, 5};
  for (int n = 1; n <= ZTT_MAX_N; n *= 2)
    for (int r = 1; r <= n; ++r)
      for (int c = 1; c <= n; ++c) {
        int64_t sum = 0;
        for (unsigned sq = 0; sq != 2; ++sq)
          for (int k = 1; k <= n; ++k)
            sum += (int64_t)a_value(sq, r, k) * (b_value(sq, k, c) + 3);
        expect(PhaseOracle, (r - 1) * n + c - 1, sum,
               product_value(n, r, c));
      }
  for (int r = 1; r <= 2; ++r)
    for (int c = 1; c <= 2; ++c) {
      int i = (r - 1) * 2 + c - 1;
      expect(PhaseOracle, i, product_value(2, r, c), hand_product[i]);
      expect(PhaseOracle, i, 2 * product_value(2, r, c) + 5, hand_final[i]);
      expect(PhaseOracle, 4 + i, 5, hand_final[4 + i]);
    }
}

#ifndef ZTT_CHECK_ORACLE

// All buffers have a leading guard and a checked suffix immediately after the
// *runtime* transfer length, including unused capacity. Elements are naturally
// aligned even after skipping Guard elements. No UDS-dependent input packing.
static int16_t a_rm[Capacity + 2 * Guard], b_cm[Capacity + 2 * Guard];
static int16_t a_seen[Capacity + 2 * Guard], b_seen[Capacity + 2 * Guard];
static int16_t broadcast_seen[Capacity + 2 * Guard], sum_seen[Capacity + 2 * Guard];
static int32_t seed_rm[Capacity + 2 * Guard], product_rm[Capacity + 2 * Guard];
static int32_t final_rm[Capacity + 2 * Guard], final_cm[Capacity + 2 * Guard];
static int32_t seeded_rm[Capacity + 2 * Guard];
static int64_t wide_in[Capacity + 2 * Guard], wide_out[Capacity + 2 * Guard];
enum { Sub, Abs, Mul, Max, Min, Xor, And, Or, ShiftLeft, ShiftRight,
       Select, Prefix, RowBroadcast, IntStages };
static int32_t int_a[Capacity + 2 * Guard], int_b[Capacity + 2 * Guard];
static int32_t int_out[IntStages][Capacity + 2 * Guard];

enum { Sentinel16 = -12345, Sentinel32 = -123456789 };
static const int64_t Sentinel64 = -INT64_C(123456789012345);

static void prepare(int n) {
  for (size_t i = 0; i < Capacity + 2 * Guard; ++i) {
    a_rm[i] = b_cm[i] = a_seen[i] = b_seen[i] = Sentinel16;
    broadcast_seen[i] = sum_seen[i] = Sentinel16;
    seed_rm[i] = product_rm[i] = final_rm[i] = final_cm[i] = Sentinel32;
    seeded_rm[i] = Sentinel32;
    wide_in[i] = wide_out[i] = Sentinel64;
    int_a[i] = int_b[i] = Sentinel32;
    for (unsigned s = 0; s < IntStages; ++s)
      int_out[s][i] = Sentinel32;
  }
  for (unsigned sq = 0; sq != 2; ++sq)
    for (int r = 1; r <= n; ++r)
      for (int c = 1; c <= n; ++c) {
        size_t rm = Guard + sq * n * n + (r - 1) * n + c - 1;
        size_t cm = Guard + sq * n * n + (c - 1) * n + r - 1;
        a_rm[rm] = a_value(sq, r, c);
        b_cm[cm] = b_value(sq, r, c);
        seed_rm[rm] = seed_value(sq, r, c);
      }
  for (int r = 1; r <= n; ++r)
    for (int c = 1; c <= n; ++c) {
      size_t i = Guard + (r - 1) * n + c - 1;
      wide_in[i] = 1000 + 7 * r - 3 * c;
      int_a[i] = 7 * r - 2 * c;
      int_b[i] = 1 + (r + c) % 7;
    }
}

// Matrix values never cross a C function boundary. Keeping A/B/C alive for
// later snapshots increases pressure on the smaller-UDS, sixteen-M profiles.
__attribute__((noinline)) static void matrix_chain(void) {
  __riscv_ztt_i16_scalar_t three = (int16_t)3;
  __riscv_ztt_i32_scalar_t five = (int32_t)5;
  __riscv_ztt_i16_1x2_t a = __riscv_ztt_mls_rm_i16_1x2(a_rm + Guard);
  __riscv_ztt_i16_2x1_t b = __riscv_ztt_mls_cm_i16_2x1(b_cm + Guard);
  __riscv_ztt_i16_2x1_t broadcast = __riscv_ztt_mbcast_m_x_i16_2x1(three);
  __riscv_ztt_i16_2x1_t sum = __riscv_ztt_madd_ew_i16_2x1(b, broadcast);
  __riscv_ztt_i32_accx2_t acc = __riscv_ztt_mzero_acc_i32_accx2();
  acc = __riscv_ztt_mmulacc_2d_i32_accx2(acc, a, sum);
  acc = __riscv_ztt_mmulacc_2d_i32_accx2(acc, a, sum);
  __riscv_ztt_i32_1x2_t product = __riscv_ztt_mcopy_a2m_i32_1x2(acc);
  __riscv_ztt_mss_rm(product_rm + Guard, product);
  __riscv_ztt_i32_1x2_t result = __riscv_ztt_madd_ew_x_i32_1x2(product, five);
  __riscv_ztt_mss_rm(final_rm + Guard, result);
  __riscv_ztt_mss_cm(final_cm + Guard, result);

  __riscv_ztt_i32_1x2_t seed = __riscv_ztt_mls_rm_i32_1x2(seed_rm + Guard);
  __riscv_ztt_i32_accx2_t seeded = __riscv_ztt_mcopy_m2a_i32_accx2(seed);
  seeded = __riscv_ztt_mmulacc_2d_i32_accx2(seeded, a, sum);
  __riscv_ztt_i32_1x2_t seeded_result = __riscv_ztt_mcopy_a2m_i32_1x2(seeded);
  __riscv_ztt_mss_rm(seeded_rm + Guard, seeded_result);
  __riscv_ztt_mss_rm(a_seen + Guard, a);
  __riscv_ztt_mss_rm(b_seen + Guard, b);
  __riscv_ztt_mss_rm(broadcast_seen + Guard, broadcast);
  __riscv_ztt_mss_rm(sum_seen + Guard, sum);
}

// i64 occupies 2/4/8 M registers at UDS32/16/8. Scalar i32 is also legal on
// RV32; the hardware must support the i64 + i32 -> i64 tuple.
__attribute__((noinline)) static void wide_chain(void) {
  __riscv_ztt_i32_scalar_t minus_eleven = (int32_t)-11;
  __riscv_ztt_i64_1x1_t a = __riscv_ztt_mls_rm_i64_1x1(wide_in + Guard);
  __riscv_ztt_i64_1x1_t b = __riscv_ztt_madd_ew_x_i64_1x1(a, minus_eleven);
  __riscv_ztt_i64_1x1_t copy = __riscv_ztt_mcopy_m2m_i64_1x1(b);
  __riscv_ztt_mss_rm(wide_out + Guard, copy);
}

// Each intermediate result is observable; the final result alone could hide
// errors in masks, clamps or shifts. Inputs include both signs, with no overflow.
__attribute__((noinline)) static void integer_chain(void) {
  __riscv_ztt_i32_scalar_t lo = 20, hi = 200, mask = 85, bits = 127, bit = 8;
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(int_a + Guard);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(int_b + Guard);
#define STEP(Name, Expr)                                                        \
  __riscv_ztt_i32_1x1_t v##Name = (Expr);                                       \
  __riscv_ztt_mss_rm(int_out[Name] + Guard, v##Name)
  STEP(Sub, __riscv_ztt_msub_ew_i32_1x1(a, b));
  STEP(Abs, __riscv_ztt_mabs_ew_i32_1x1(vSub));
  STEP(Mul, __riscv_ztt_mmul_ew_i32_1x1(vAbs, b));
  STEP(Max, __riscv_ztt_mmax_ew_x_i32_1x1(vMul, lo));
  STEP(Min, __riscv_ztt_mmin_ew_x_i32_1x1(vMax, hi));
  STEP(Xor, __riscv_ztt_mxor_ew_x_i32_1x1(vMin, mask));
  STEP(And, __riscv_ztt_mand_ew_x_i32_1x1(vXor, bits));
  STEP(Or, __riscv_ztt_mor_ew_x_i32_1x1(vAnd, bit));
  STEP(ShiftLeft, __riscv_ztt_msll_ew_x_i32_1x1(vOr, 2));
  STEP(ShiftRight, __riscv_ztt_msrl_ew_x_i32_1x1(vShiftLeft, 1));
  STEP(Select, __riscv_ztt_msellt_ew_i32_1x1(vSub, vShiftRight));
  STEP(Prefix, __riscv_ztt_mprefixadd_row_i32_1x1(vSelect));
  STEP(RowBroadcast, __riscv_ztt_mrowbcast_ew_x_i32_1x1(vPrefix, 0));
#undef STEP
}

static int integer_expected(unsigned stage, int r, int c) {
  int b = 1 + (r + c) % 7;
  // Spec msub.ew computes source 2 minus source 1.
  int sub = b - (7 * r - 2 * c);
  int v = sub;
  if (stage == Sub)
    return v;
  v = v < 0 ? -v : v;
  if (stage == Abs)
    return v;
  v *= b;
  if (stage == Mul)
    return v;
  v = v < 20 ? 20 : v;
  if (stage == Max)
    return v;
  v = v > 200 ? 200 : v;
  if (stage == Min)
    return v;
  v ^= 85;
  if (stage == Xor)
    return v;
  v &= 127;
  if (stage == And)
    return v;
  v |= 8;
  if (stage == Or)
    return v;
  v *= 4;
  if (stage == ShiftLeft)
    return v;
  v /= 2;
  if (stage == ShiftRight)
    return v;
  return sub < 0 ? v : 0;
}

#define CHECK_GUARDS(Buffer, Length, Sentinel)                                   \
  do {                                                                          \
    for (size_t i = 0; i < Capacity + 2 * Guard; ++i)                            \
      if (i < Guard || i >= Guard + (size_t)(Length))                            \
        expect(PhaseGuard, i, (Buffer)[i], Sentinel);                            \
  } while (0)

static void verify(int n) {
  for (unsigned sq = 0; sq != 2; ++sq)
    for (int r = 1; r <= n; ++r)
      for (int c = 1; c <= n; ++c) {
        size_t rm = Guard + sq * n * n + (r - 1) * n + c - 1;
        size_t cm = Guard + sq * n * n + (c - 1) * n + r - 1;
        int64_t p = sq ? 0 : product_value(n, r, c);
        expect(PhaseA, rm, a_seen[rm], a_value(sq, r, c));
        expect(PhaseB, rm, b_seen[rm], b_value(sq, r, c));
        expect(PhaseBroadcast, rm, broadcast_seen[rm], 3);
        expect(PhaseSum, rm, sum_seen[rm], b_value(sq, r, c) + 3);
        expect(PhaseProduct, rm, product_rm[rm], 2 * p);
        expect(PhaseFinalRM, rm, final_rm[rm], 2 * p + 5);
        expect(PhaseFinalCM, cm, final_cm[cm], 2 * p + 5);
        expect(PhaseSeeded, rm, seeded_rm[rm], seed_value(sq, r, c) + p);
        expect(PhaseInput, rm, a_rm[rm], a_value(sq, r, c));
        expect(PhaseInput, cm, b_cm[cm], b_value(sq, r, c));
        expect(PhaseInput, rm, seed_rm[rm], seed_value(sq, r, c));
      }
  for (int r = 1; r <= n; ++r)
    for (int c = 1; c <= n; ++c) {
      size_t i = Guard + (r - 1) * n + c - 1;
      expect(PhaseInput, i, wide_in[i], 1000 + 7 * r - 3 * c);
      expect(PhaseWide, i, wide_out[i], 989 + 7 * r - 3 * c);
      expect(PhaseInput, i, int_a[i], 7 * r - 2 * c);
      expect(PhaseInput, i, int_b[i], 1 + (r + c) % 7);
      for (unsigned s = 0; s < IntStages; ++s) {
        int expected = 0;
        if (s < Prefix)
          expected = integer_expected(s, r, c);
        else
          for (int k = 1; k <= c; ++k)
            expected += integer_expected(Select, s == Prefix ? r : 1, k);
        expect(100 + s, i, int_out[s][i], expected);
      }
    }
  size_t length = 2 * n * n;
  CHECK_GUARDS(a_rm, length, Sentinel16);
  CHECK_GUARDS(b_cm, length, Sentinel16);
  CHECK_GUARDS(a_seen, length, Sentinel16);
  CHECK_GUARDS(b_seen, length, Sentinel16);
  CHECK_GUARDS(broadcast_seen, length, Sentinel16);
  CHECK_GUARDS(sum_seen, length, Sentinel16);
  CHECK_GUARDS(seed_rm, length, Sentinel32);
  CHECK_GUARDS(product_rm, length, Sentinel32);
  CHECK_GUARDS(final_rm, length, Sentinel32);
  CHECK_GUARDS(final_cm, length, Sentinel32);
  CHECK_GUARDS(seeded_rm, length, Sentinel32);
  CHECK_GUARDS(wide_in, n * n, Sentinel64);
  CHECK_GUARDS(wide_out, n * n, Sentinel64);
  CHECK_GUARDS(int_a, n * n, Sentinel32);
  CHECK_GUARDS(int_b, n * n, Sentinel32);
  for (unsigned s = 0; s < IntStages; ++s)
    CHECK_GUARDS(int_out[s], n * n, Sentinel32);
}
#endif

int main(void) {
  check_oracle();
#ifndef ZTT_CHECK_ORACLE
  // The platform must first enable MS. Do not borrow or release somebody
  // else's live AME context; a fresh acquire also starts with clear UN status.
  if (__riscv_ztt_get_ameown() & 1) {
    expect(PhaseConfig, 0, 1, 0);
    return 2;
  }
  size_t acquired = __riscv_ztt_ame_acquire(0);
  ztt_test_report.acquire_result = acquired;
  if (!(acquired & 1)) {
    expect(PhaseConfig, 1, acquired & 1, 1);
    return 2;
  }
  size_t n = __riscv_ztt_get_amenlen();
  size_t uds = __riscv_ztt_get_ameudsz();
  ztt_test_report.n = n;
  ztt_test_report.uds = uds;
  // Binary and machine profile must agree; smaller UDS requires recompilation.
#if __riscv_ztt_uds == 32
  const size_t compiled_uds = 32;
#elif __riscv_ztt_uds == 16
  const size_t compiled_uds = 16;
#elif __riscv_ztt_uds == 8
  const size_t compiled_uds = 8;
#else
#error "Compile this example for UDS32, UDS16 or UDS8"
#endif
  if (!n || n > ZTT_MAX_N || (n & (n - 1)) || uds != compiled_uds) {
    expect(PhaseConfig, 2, 0, 1);
    __riscv_ztt_ame_release();
    return 2;
  }
  prepare((int)n);
  matrix_chain();
  wide_chain();
  integer_chain();
  size_t status = __riscv_ztt_get_amestatus();
  expect(PhaseUnsupported, 0, status & 1, 0);
  __riscv_ztt_ame_release();
  verify((int)n);
#endif
  if (ztt_test_report.failures)
    printf("FAIL phase=%u index=%zu expected=%lld actual=%lld failures=%u\n",
           ztt_test_report.first_phase, ztt_test_report.first_index,
           (long long)ztt_test_report.expected, (long long)ztt_test_report.actual,
           ztt_test_report.failures);
  else
#ifdef ZTT_CHECK_ORACLE
    printf("PASS e2e-int scalar oracle\n");
#else
    printf("PASS e2e-int N=%zu UDS=%zu\n", ztt_test_report.n,
           ztt_test_report.uds);
#endif
  return ztt_test_report.failures ? 1 : 0;
}
