// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +f -target-feature +d \
// RUN:   -target-feature +xtheadvector \
// RUN:   -fsyntax-only -verify %s

#include <riscv_vector.h>

vuint32m1_t test_vnclipu_wv_u32m1(vuint64m2_t op1, vuint32m1_t shift, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vnclipu_wv_u32m1(op1, shift, 5, vl);
}

vuint32m1_t test_vnclipu_wx_u32m1(vuint64m2_t op1, size_t shift, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vnclipu_wx_u32m1(op1, shift, 5, vl);
}

vuint32m1_t test_vnclipu_wv_u32m1_m(vbool32_t mask, vuint32m1_t maskedoff, vuint64m2_t op1, vuint32m1_t shift, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vnclipu_wv_u32m1_m(mask, maskedoff, op1, shift, 5, vl);
}

vuint32m1_t test_vnclipu_wx_u32m1_m(vbool32_t mask, vuint32m1_t maskedoff, vuint64m2_t op1, size_t shift, size_t vl) {
  // expected-error@+1 {{argument value 5 is outside the valid range [0, 3]}}
  return __riscv_vnclipu_wx_u32m1_m(mask, maskedoff, op1, shift, 5, vl);
}
