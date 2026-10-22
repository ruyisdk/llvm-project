// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#ifndef ZTT_EXAMPLE_SMOKE_H
#define ZTT_EXAMPLE_SMOKE_H

#include <math.h>
#include <riscv_ztt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// Deliberately small, non-symmetric matrices: every coordinate is observable.
// Compile separately for each UDS and run with amenlen=4, M16/A4.
enum { N = 4, Elements = N * N };
#define KERNEL __attribute__((noinline))
static unsigned failures;

static int begin(void) {
  if (!(__riscv_ztt_ame_acquire(0) & 1)) {
    puts("FAIL acquire");
    return 0;
  }
  if (__riscv_ztt_get_amenlen() != N) {
    puts("FAIL: run with amenlen=4");
    __riscv_ztt_ame_release();
    return 0;
  }
  return 1;
}

static void check(const char *op, unsigned i, int64_t got, int64_t want) {
  if (got != want) {
    printf("FAIL %s[%u]: got %lld, expected %lld\n", op, i, (long long)got,
           (long long)want);
    ++failures;
  }
}

static void check_float(const char *op, unsigned i, double got, double want,
                        double abs_tol, double rel_tol) {
  if (!isfinite(got) || fabs(got - want) > abs_tol + rel_tol * fabs(want)) {
    printf("FAIL %s[%u]: got %.17g, expected %.17g\n", op, i, got, want);
    ++failures;
  }
}

static int finish(void) {
  size_t status = __riscv_ztt_get_amestatus();
  __riscv_ztt_ame_release();
  if (status & 1) {
    puts("FAIL unsupported operation/datatype tuple (amestatus.UN)");
    ++failures;
  }
  puts(failures ? "FAIL" : "PASS");
  return failures != 0;
}
#endif
