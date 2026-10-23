// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify=expected,rv32 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify=expected %s
// RUN: %clang_cc1 -x c++ -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify=expected,rv32 %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fsyntax-only -verify=expected %s

// Test raw builtin argument checks.
// The final null pointer argument specifies the matrix result type.
#define RESULT(T) ((__riscv_ztt_##T##_t *)0)

__riscv_ztt_i32_1x1_t result_type(void) {
  return __builtin_riscv_ztt_mzero_m(RESULT(i32_1x1));
}

void markers(__riscv_ztt_i32_1x1_t *p) {
  (void)__builtin_riscv_ztt_mclear_m(RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mclear_acc(RESULT(i32_accx4));
  (void)__builtin_riscv_ztt_mzero_acc(RESULT(f32_accx1));
  (void)__builtin_riscv_ztt_mzero_m(); // expected-error {{too few arguments}}
  (void)__builtin_riscv_ztt_mzero_m(0, RESULT(i32_1x1)); // expected-error {{too many arguments}}
  (void)__builtin_riscv_ztt_mzero_m((void *)0); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i32_scalar)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m(RESULT(i32_accx1)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_acc(RESULT(i32_1x1)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m(p); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m((__riscv_ztt_i32_1x1_t *)1); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mzero_m((p = 0, RESULT(i32_1x1))); // expected-error {{requires a null pointer result-type marker}}
}

void memory(int *p, const int *cp, volatile int *vp, unsigned int *up,
            short *sp, void *v, __SIZE_TYPE__ stride,
            __riscv_ztt_i32_1x1_t m, __riscv_ztt_i32_accx1_t acc,
            __riscv_ztt_i4_1x8_t subbyte) {
  int array[8];
  (void)__builtin_riscv_ztt_mls_rm(p, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mls_cm(cp, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mls_rm(array, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mls_st(p, stride, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mls_tst(p, -1, RESULT(i32_1x1));
  __builtin_riscv_ztt_mss_rm(p, m);
  __builtin_riscv_ztt_mss_cm(p, m);
  __builtin_riscv_ztt_mss_st(p, stride, m);
  __builtin_riscv_ztt_mss_tst(p, -1, m);
  (void)__builtin_riscv_ztt_mls_rm(0, RESULT(i32_1x1)); // expected-error {{first argument to RISC-V Ztt memory intrinsic must be a pointer}}
  (void)__builtin_riscv_ztt_mls_rm(v, RESULT(i32_1x1)); // expected-error {{memory base pointee type 'void' does not match matrix element type 'int'}}
  (void)__builtin_riscv_ztt_mls_rm(up, RESULT(i32_1x1)); // expected-error {{memory base pointee type 'unsigned int' does not match matrix element type 'int'}}
  (void)__builtin_riscv_ztt_mls_rm(sp, RESULT(i32_1x1)); // expected-error {{memory base pointee type 'short' does not match matrix element type 'int'}}
  (void)__builtin_riscv_ztt_mls_rm(vp, RESULT(i32_1x1)); // expected-error {{load base pointee type 'volatile int' has invalid qualifiers}}
  __builtin_riscv_ztt_mss_rm(cp, m); // expected-error {{store base pointee type 'const int' has invalid qualifiers}}
  __builtin_riscv_ztt_mss_st(vp, stride, m); // expected-error {{store base pointee type 'volatile int' has invalid qualifiers}}
  __builtin_riscv_ztt_mss_rm(p, acc); // expected-error {{requires an M matrix type}}
  __builtin_riscv_ztt_mss_rm(v, subbyte); // expected-error {{sub-byte datatypes have no public C element carrier}}
  (void)__builtin_riscv_ztt_mls_rm(v, RESULT(i4_1x8)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mls_st(v, stride, RESULT(i4_1x8)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mls_st(p, 1.0, RESULT(i32_1x1)); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
}

void transfer(__riscv_ztt_i32_1x1_t m, __riscv_ztt_i32_1x2_t row,
              __riscv_ztt_i32_2x1_t col, __riscv_ztt_u32_1x2_t urow,
              __riscv_ztt_i32_rne_1x2_t rounded,
              __riscv_ztt_i32_accx1_t acc, __riscv_ztt_i32_accx2_t acc2,
              __SIZE_TYPE__ index) {
  (void)__builtin_riscv_ztt_mcopy_m2m(m, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mcopy_m2a(row, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mcopy_a2m(acc2, RESULT(i32_2x1));
  (void)__builtin_riscv_ztt_mconcat_m(m, m, RESULT(i32_1x2));
  (void)__builtin_riscv_ztt_mconcat_m(m, m, RESULT(i32_2x1));
  (void)__builtin_riscv_ztt_mconcat_m(row, row, RESULT(i32_1x4));
  (void)__builtin_riscv_ztt_mextract(row, 0, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mextract(col, 1, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mcopy_m2m(row, RESULT(i32_2x1)); // expected-error {{copy source type}}
  (void)__builtin_riscv_ztt_mcopy_m2m(rounded, RESULT(i32_1x2)); // expected-error {{copy source type}}
  (void)__builtin_riscv_ztt_mcopy_m2a(acc, RESULT(i32_accx1)); // expected-error {{M-to-Acc copy requires a M source type}}
  (void)__builtin_riscv_ztt_mcopy_a2m(m, RESULT(i32_1x1)); // expected-error {{Acc-to-M copy requires a Acc source type}}
  (void)__builtin_riscv_ztt_mcopy_m2a(row, RESULT(i32_accx1)); // expected-error {{element type and square count must be identical}}
  (void)__builtin_riscv_ztt_mcopy_a2m(acc, RESULT(u32_1x1)); // expected-error {{element type and square count must be identical}}
  (void)__builtin_riscv_ztt_mconcat_m(row, col, RESULT(i32_1x4)); // expected-error {{mconcat.m source types must be identical}}
  (void)__builtin_riscv_ztt_mconcat_m(row, urow, RESULT(i32_1x4)); // expected-error {{mconcat.m source types must be identical}}
  (void)__builtin_riscv_ztt_mconcat_m(row, row, RESULT(i32_4x1)); // expected-error {{must preserve the source datatype and double source shape}}
  (void)__builtin_riscv_ztt_mconcat_m(row, row, RESULT(u32_1x4)); // expected-error {{must preserve the source datatype and double source shape}}
  (void)__builtin_riscv_ztt_mconcat_m(acc, acc, RESULT(i32_1x2)); // expected-error {{requires two M source types}}
  (void)__builtin_riscv_ztt_mconcat_m(m, m, RESULT(i32_1x1)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mextract(row, 2, RESULT(i32_1x1)); // expected-error {{mextract operands violate}}
  (void)__builtin_riscv_ztt_mextract(row, -1, RESULT(i32_1x1)); // expected-error {{mextract operands violate}}
  (void)__builtin_riscv_ztt_mextract(row, index, RESULT(i32_1x1)); // expected-error {{must be a constant integer}}
  (void)__builtin_riscv_ztt_mextract(row, 0, RESULT(u32_1x1)); // expected-error {{mextract operands violate}}
  (void)__builtin_riscv_ztt_mextract(m, 0, RESULT(i32_1x1)); // expected-error {{mextract operands violate}}
}

void numeric(__riscv_ztt_i32_1x1_t i, __riscv_ztt_u32_1x1_t u,
             __riscv_ztt_f32_1x1_t f, __riscv_ztt_i32_1x2_t row,
             __riscv_ztt_i32_accx1_t acc, __riscv_ztt_i32_rne_1x1_t rounded,
             __riscv_ztt_i32_scalar_t si, __riscv_ztt_f32_scalar_t sf,
             __riscv_ztt_i64_scalar_t si64) {
  // Mixed datatypes are accepted unless a specific type rule forbids them.
  (void)__builtin_riscv_ztt_madd_ew(i, f, RESULT(u32_1x1));
  (void)__builtin_riscv_ztt_madd_ew_x(i, sf, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mbcast_m_x(si, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mmin_ew(i, i, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mmin_ew_x(i, sf, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mand_ew_x(i, si, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_msqrt_ew(f, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mlog2sub_ew(f, i, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mselge_ew(f, i, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mldexp_ew(f, i, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mldexp_ew_x(f, -1L, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mcmpge_ew(f, f, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mreduceadd_row(row, RESULT(i32_1x2));
  (void)__builtin_riscv_ztt_mmulacc_ew(i, f, u, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mmulacc_ew_x(i, f, si, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_madd_ew(i, row, RESULT(i32_1x1)); // expected-error {{madd.ew operands violate}}
  (void)__builtin_riscv_ztt_madd_ew(i, acc, RESULT(i32_1x1)); // expected-error {{requires an M matrix type}}
  (void)__builtin_riscv_ztt_madd_ew_x(i, 1, RESULT(i32_1x1)); // expected-error {{madd.ew.x operands violate}}
  (void)__builtin_riscv_ztt_madd_ew_x(i, si64, RESULT(i32_1x1)); // rv32-error {{has 64 bits, exceeding the 32-bit XLEN}}
  (void)__builtin_riscv_ztt_mmin_ew(i, u, RESULT(i32_1x1)); // expected-error {{mmin.ew operands violate}}
  (void)__builtin_riscv_ztt_mmin_ew(i, rounded, RESULT(i32_1x1)); // expected-error {{mmin.ew operands violate}}
  (void)__builtin_riscv_ztt_mand_ew(i, f, RESULT(i32_1x1)); // expected-error {{mand.ew operands violate}}
  (void)__builtin_riscv_ztt_mand_ew(f, i, RESULT(i32_1x1)); // expected-error {{mand.ew operands violate}}
  (void)__builtin_riscv_ztt_mand_ew(i, u, RESULT(i32_1x1)); // expected-error {{mand.ew operands violate}}
  (void)__builtin_riscv_ztt_mand_ew_x(f, si, RESULT(i32_1x1)); // expected-error {{mand.ew.x operands violate}}
  (void)__builtin_riscv_ztt_mand_ew_x(i, sf, RESULT(i32_1x1)); // expected-error {{mand.ew.x operands violate}}
  (void)__builtin_riscv_ztt_mand_ew(f, f, RESULT(f32_1x1)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_msqrt_ew(i, RESULT(f32_1x1)); // expected-error {{msqrt.ew operands violate}}
  (void)__builtin_riscv_ztt_msqrt_ew(f, RESULT(i32_1x1)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mselge_ew(i, f, RESULT(i32_1x1)); // expected-error {{mselge.ew operands violate}}
  (void)__builtin_riscv_ztt_mldexp_ew(i, f, RESULT(i32_1x1)); // expected-error {{mldexp.ew operands violate}}
  (void)__builtin_riscv_ztt_mmulacc_ew(u, i, i, RESULT(i32_1x1)); // expected-error {{mmulacc.ew operands violate}}
}

void permutation(__riscv_ztt_i32_1x1_t m, __riscv_ztt_u32_1x1_t u,
                 __riscv_ztt_f32_1x1_t f, __riscv_ztt_i32_1x2_t row,
                 __riscv_ztt_i32_2x1_t col, __riscv_ztt_i16_1x2_t packed,
                 __riscv_ztt_i32_scalar_t scalar) {
  (void)__builtin_riscv_ztt_mrowid_ew(RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mrowbcast_ew_x(m, 0, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mcolshift_ew_x(m, -1, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_mrowgather_ew(f, u, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mrowscatadd_ew(f, m, u, RESULT(f32_1x1));
  (void)__builtin_riscv_ztt_mrowzip_ew(row, RESULT(i32_1x2));
  (void)__builtin_riscv_ztt_mcolunzip_ew(row, RESULT(i32_1x2));
  (void)__builtin_riscv_ztt_mrowid_ew(RESULT(i32_1x2)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mrowbcast_ew_x(m, 0, RESULT(u32_1x1)); // expected-error {{mrowbcast.ew.x operands violate}}
  (void)__builtin_riscv_ztt_mrowbcast_ew_x(m, scalar, RESULT(i32_1x1)); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
  (void)__builtin_riscv_ztt_mcolshift_ew_x(m, 1.0f, RESULT(i32_1x1)); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
  (void)__builtin_riscv_ztt_mrowgather_ew(f, f, RESULT(f32_1x1)); // expected-error {{mrowgather.ew operands violate}}
  (void)__builtin_riscv_ztt_mrowgather_ew(m, u, RESULT(f32_1x1)); // expected-error {{mrowgather.ew operands violate}}
  (void)__builtin_riscv_ztt_mrowscatadd_ew(f, m, f, RESULT(f32_1x1)); // expected-error {{mrowscatadd.ew operands violate}}
  (void)__builtin_riscv_ztt_mrowscatadd_ew(m, m, u, RESULT(f32_1x1)); // expected-error {{mrowscatadd.ew operands violate}}
  (void)__builtin_riscv_ztt_mrowscatadd_ew(f, row, u, RESULT(f32_1x1)); // expected-error {{mrowscatadd.ew operands violate}}
  (void)__builtin_riscv_ztt_mrowscatadd_ew(f, m, row, RESULT(f32_1x1)); // expected-error {{mrowscatadd.ew operands violate}}
  (void)__builtin_riscv_ztt_mrowzip_ew(packed, RESULT(i16_1x2)); // expected-error {{zip/unzip requires identical M source and result types of shape 1x2 with element width at least UDS}}
  (void)__builtin_riscv_ztt_mrowzip_ew(col, RESULT(i32_2x1)); // expected-error {{requires a null pointer result-type marker}}
  (void)__builtin_riscv_ztt_mrowzip_ew(m, RESULT(i32_1x2)); // expected-error {{zip/unzip requires identical M source and result types}}
}

void shift(__riscv_ztt_i32_1x1_t i, __riscv_ztt_u32_1x1_t u,
           __riscv_ztt_i64_1x1_t wide, __riscv_ztt_f32_1x1_t f,
           __riscv_ztt_i32_1x2_t row) {
  (void)__builtin_riscv_ztt_msll_ew(i, wide, RESULT(u32_1x1));
  (void)__builtin_riscv_ztt_msrl_ew(u, i, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_msra_ew(i, u, RESULT(u32_1x1));
  (void)__builtin_riscv_ztt_msra_ew_x(i, -1, RESULT(i32_1x1));
  (void)__builtin_riscv_ztt_msll_ew(f, i, RESULT(i32_1x1)); // expected-error {{msll.ew operands violate}}
  (void)__builtin_riscv_ztt_msll_ew(i, f, RESULT(i32_1x1)); // expected-error {{msll.ew operands violate}}
  (void)__builtin_riscv_ztt_msll_ew(i, row, RESULT(i32_1x1)); // expected-error {{msll.ew operands violate}}
  (void)__builtin_riscv_ztt_msra_ew(u, i, RESULT(i32_1x1)); // expected-error {{msra.ew operands violate}}
  (void)__builtin_riscv_ztt_msra_ew_x(u, 1, RESULT(i32_1x1)); // expected-error {{msra.ew.x operands violate}}
  (void)__builtin_riscv_ztt_msrl_ew_x(i, 1.0f, RESULT(i32_1x1)); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
}

void matmul(__riscv_ztt_i32_accx2_t acc, __riscv_ztt_u32_accx2_t uacc,
            __riscv_ztt_i16_1x2_t row, __riscv_ztt_f32_2x1_t col,
            __riscv_ztt_i32_1x4_t longer) {
  (void)__builtin_riscv_ztt_mmulacc_2d(acc, row, col, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mmulaccneg_2d(acc, row, col, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mmulatacc_2d(acc, col, col, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mmulataccneg_2d(acc, col, col, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mmulbtacc_2d(acc, row, row, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mmulbtaccneg_2d(acc, row, row, RESULT(i32_accx2));
  (void)__builtin_riscv_ztt_mmulacc_2d(uacc, row, col, RESULT(i32_accx2)); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  (void)__builtin_riscv_ztt_mmulacc_2d(acc, row, col, RESULT(i32_accx1)); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  (void)__builtin_riscv_ztt_mmulacc_2d(acc, col, row, RESULT(i32_accx2)); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  (void)__builtin_riscv_ztt_mmulacc_2d(acc, longer, col, RESULT(i32_accx2)); // expected-error {{requires an identical accumulator type and matching source dimensions}}
  (void)__builtin_riscv_ztt_mmulacc_2d(acc, acc, col, RESULT(i32_accx2)); // expected-error {{requires two M source types}}
  (void)__builtin_riscv_ztt_mmulatacc_2d(acc, row, col, RESULT(i32_accx2)); // expected-error {{requires an identical accumulator type and matching source dimensions}}
}

void state(void) {
  enum { Descriptor = 1 };
  (void)__builtin_riscv_ztt_ame_acquire(Descriptor);
  (void)__builtin_riscv_ztt_ame_acquire(-1);
  __builtin_riscv_ztt_ame_release();
  (void)__builtin_riscv_ztt_get_amenlen();
  (void)__builtin_riscv_ztt_ame_acquire(1.0f); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type}}
}
