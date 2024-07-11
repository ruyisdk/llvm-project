// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d \
// RUN:   -target-feature +xtheadvector \
// RUN:   -fsyntax-only -verify %s

#include <riscv_vector.h>

vint32m1_t test_vasub_vv_i32m1(vint32m1_t op1, vint32m1_t op2, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vasub_vv_i32m1(op1, op2, 5, vl);
}

vint32m1_t test_vasub_vx_i32m1(vint32m1_t op1, int32_t op2, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vasub_vx_i32m1(op1, op2, 5, vl);
}

vint32m1_t test_vasub_vv_i32m1_m(vbool32_t mask, vint32m1_t maskedoff, vint32m1_t op1, vint32m1_t op2, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vasub_vv_i32m1_m(mask, maskedoff, op1, op2, 5, vl);
}

vint32m1_t test_vasub_vx_i32m1_m(vbool32_t mask, vint32m1_t maskedoff, vint32m1_t op1, int32_t op2, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vasub_vx_i32m1_m(mask, maskedoff, op1, op2, 5, vl);
}
