// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -DHEADER -emit-pch -o %t-32-c %s
// RUN: %clang_cc1 -x c -triple riscv32 -target-feature +ztt -include-pch %t-32-c -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -DHEADER -emit-pch -o %t-32-cpp %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -include-pch %t-32-cpp -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -DHEADER -emit-pch -o %t-64-c %s
// RUN: %clang_cc1 -x c -triple riscv64 -target-feature +ztt -include-pch %t-64-c -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -DHEADER -emit-pch -o %t-64-cpp %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -include-pch %t-64-cpp -fsyntax-only -verify %s
// expected-no-diagnostics

#ifdef HEADER
#define TYPE(N, C) \
  typedef __riscv_ztt_##N##_scalar_t saved_##N; \
  extern saved_##N pch_##N;
#else
#ifdef __cplusplus
#define SAME(A, B) static_assert(__is_same(A, B))
#else
#define SAME(A, B) _Static_assert(__builtin_types_compatible_p(A, B), "")
#endif
#define TYPE(N, C) \
  SAME(saved_##N, __riscv_ztt_##N##_scalar_t); \
  C roundtrip_##N(C x) { pch_##N = x; return (C)pch_##N; }
#endif

#define INTEGER(T, C) \
  TYPE(T, C) \
  TYPE(T##_rnu, C) \
  TYPE(T##_rne, C) \
  TYPE(T##_rdn, C) \
  TYPE(T##_rod, C) \
  TYPE(T##_sat, C) \
  TYPE(T##_rnu_sat, C) \
  TYPE(T##_rne_sat, C) \
  TYPE(T##_rdn_sat, C) \
  TYPE(T##_rod_sat, C)
#define FLOAT(T, C) \
  TYPE(T, C) \
  TYPE(T##_rne, C) \
  TYPE(T##_rtz, C) \
  TYPE(T##_rdn, C) \
  TYPE(T##_rup, C) \
  TYPE(T##_rmm, C) \
  TYPE(T##_rno, C)

INTEGER(i8, __INT8_TYPE__)
INTEGER(u8, __UINT8_TYPE__)
INTEGER(i16, __INT16_TYPE__)
INTEGER(u16, __UINT16_TYPE__)
INTEGER(i32, __INT32_TYPE__)
INTEGER(u32, __UINT32_TYPE__)
INTEGER(i64, __INT64_TYPE__)
INTEGER(u64, __UINT64_TYPE__)
INTEGER(i128, _BitInt(128))
INTEGER(u128, unsigned _BitInt(128))
FLOAT(f16, _Float16)
FLOAT(bf16, __bf16)
FLOAT(f32, float)
FLOAT(f64, double)

#undef INTEGER
#undef FLOAT
#undef TYPE
#undef HEADER
