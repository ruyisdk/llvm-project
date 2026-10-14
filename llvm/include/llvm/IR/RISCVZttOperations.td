//===- RISCVZttOperations.td - RISC-V Ztt operations --------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_IR_RISCVZTTOPERATIONS_TD
#define LLVM_IR_RISCVZTTOPERATIONS_TD

// Basic interface structure shared by Clang and LLVM.
class RISCVZttOperation<string name, int numMatrixArgs, int numScalarArgs>
{
  string Name = name;

  // M/ACC input arguments, excluding the old result.
  int NumMatrixArgs = numMatrixArgs;

  // Non-matrix C arguments: scalars, controls, pointers and strides.
  int NumScalarArgs = numScalarArgs;

  // The first C argument is the old result matrix and has the result type.
  bit HasOldResult = 0;

  // Return kind.
  // NonMatrix: Ordinary scalar or void; CSR reads, acquire/release and stores.
  // M: M matrix; loads and elementwise arithmetic.
  // ACC: ACC matrix; matmul and mcopy_m2a.
  string ResultKind = "M";
}

// Matrix compute interfaces.
class RISCVZttCompute<string name, int numMatrixArgs, int numScalarArgs>
    : RISCVZttOperation<name, numMatrixArgs, numScalarArgs>;

// () or (scalar); clear/zero, row/column IDs and scalar broadcast.
class RISCVZttNoMatrixArg<string name, int numScalarArgs>
    : RISCVZttCompute<name, 0, numScalarArgs>;

// () -> M/ACC; clear/zero and row/column IDs.
class RISCVZttNoArg<string name> : RISCVZttNoMatrixArg<name, 0>;

// (scalar); broadcast also carries the scalar datatype.
class RISCVZttScalarBroadcast<string name> : RISCVZttNoMatrixArg<name, 1>;

// (old_d).
// Zip/unzip expand as a two-square operation with tied input/output registers.
class RISCVZttZipUnZip<string name> : RISCVZttCompute<name, 0, 0>
{
  let HasOldResult = 1;
}

// (matrix).
class RISCVZttUnary<string name> : RISCVZttCompute<name, 1, 0>;

// (matrix, matrix).
class RISCVZttBinary<string name> : RISCVZttCompute<name, 2, 0>;

// (matrix, scalar); a value with a RISC-V Ztt scalar datatype.
class RISCVZttScalarBinary<string name> : RISCVZttCompute<name, 1, 1>;

// (matrix, control); an ordinary integer for a shift, index or exponent.
class RISCVZttControlBinary<string name> : RISCVZttCompute<name, 1, 1>;

// (old_d, matrix, matrix).
class RISCVZttBinaryWithOld<string name> : RISCVZttBinary<name>
{
  let HasOldResult = 1;
}

// (old_d, matrix, scalar).
class RISCVZttScalarBinaryWithOld<string name> : RISCVZttScalarBinary<name>
{
  let HasOldResult = 1;
}

// (old_d, matrix, control).
class RISCVZttControlBinaryWithOld<string name> : RISCVZttControlBinary<name>
{
  let HasOldResult = 1;
}

// (old_acc, matrix, matrix) -> ACC.
// Separate expansion: M input slices accumulate into the first ACC square.
class RISCVZttMatmul<string name> : RISCVZttOperation<name, 2, 0>
{
  let HasOldResult = 1;
  let ResultKind = "ACC";
}

// (matrix) -> M/ACC; mcopy.
class RISCVZttCopy<string name> : RISCVZttOperation<name, 1, 0>;

// (M) -> M; input and result have the same type.
class RISCVZttCopyM2M<string name> : RISCVZttCopy<name>;

// (M) -> ACC; input and result have different matrix types.
class RISCVZttCopyM2A<string name> : RISCVZttCopy<name>
{
  let ResultKind = "ACC";
}

// (ACC) -> M; input and result have different matrix types.
class RISCVZttCopyA2M<string name> : RISCVZttCopy<name>;

// (matrix, matrix); inputs have the same type, result has twice their shape.
class RISCVZttConcat<string name> : RISCVZttOperation<name, 2, 0>;

// (matrix, index); a constant index selects one half of the input shape.
class RISCVZttExtract<string name> : RISCVZttOperation<name, 1, 1>;

// (base) -> M.
class RISCVZttLoad<string name> : RISCVZttOperation<name, 0, 1>;

// (base, stride) -> M.
class RISCVZttStridedLoad<string name> : RISCVZttLoad<name>
{
  let NumScalarArgs = 2;
}

// (base, matrix) -> void.
class RISCVZttStore<string name> : RISCVZttOperation<name, 1, 1>
{
  let ResultKind = "NonMatrix";
}

// (base, stride, matrix) -> void.
class RISCVZttStridedStore<string name> : RISCVZttStore<name>
{
  let NumScalarArgs = 2;
}

// CSR reads and acquire/release.
class RISCVZttState<string name, int numScalarArgs>
    : RISCVZttOperation<name, 0, numScalarArgs>
{
  let ResultKind = "NonMatrix";
}

// size_t get_<csr>().
class RISCVZttCSRRead<string csr> : RISCVZttState<"get_" # csr, 0>;

// State.
def riscv_ztt_op_ame_acquire : RISCVZttState<"ame_acquire", 1>;
def riscv_ztt_op_ame_release : RISCVZttState<"ame_release", 0>;
def riscv_ztt_op_get_amefflags : RISCVZttCSRRead<"amefflags">;
def riscv_ztt_op_get_amenlen : RISCVZttCSRRead<"amenlen">;
def riscv_ztt_op_get_ameown : RISCVZttCSRRead<"ameown">;
def riscv_ztt_op_get_amestatus : RISCVZttCSRRead<"amestatus">;
def riscv_ztt_op_get_amestype : RISCVZttCSRRead<"amestype">;
def riscv_ztt_op_get_ameudsz : RISCVZttCSRRead<"ameudsz">;
def riscv_ztt_op_get_amexsat : RISCVZttCSRRead<"amexsat">;

// Load and store.
def riscv_ztt_op_mls_rm : RISCVZttLoad<"mls_rm">;
def riscv_ztt_op_mls_cm : RISCVZttLoad<"mls_cm">;
def riscv_ztt_op_mls_st : RISCVZttStridedLoad<"mls_st">;
def riscv_ztt_op_mls_tst : RISCVZttStridedLoad<"mls_tst">;
def riscv_ztt_op_mss_rm : RISCVZttStore<"mss_rm">;
def riscv_ztt_op_mss_cm : RISCVZttStore<"mss_cm">;
def riscv_ztt_op_mss_st : RISCVZttStridedStore<"mss_st">;
def riscv_ztt_op_mss_tst : RISCVZttStridedStore<"mss_tst">;

// Clear and zero.
def riscv_ztt_op_mclear_acc : RISCVZttNoArg<"mclear_acc">
{
  let ResultKind = "ACC";
}
def riscv_ztt_op_mclear_m : RISCVZttNoArg<"mclear_m">;
def riscv_ztt_op_mzero_acc : RISCVZttNoArg<"mzero_acc">
{
  let ResultKind = "ACC";
}
def riscv_ztt_op_mzero_m : RISCVZttNoArg<"mzero_m">;

// Copy, concat and extract.
def riscv_ztt_op_mconcat_m : RISCVZttConcat<"mconcat_m">;
def riscv_ztt_op_mcopy_a2m : RISCVZttCopyA2M<"mcopy_a2m">;
def riscv_ztt_op_mcopy_m2a : RISCVZttCopyM2A<"mcopy_m2a">;
def riscv_ztt_op_mcopy_m2m : RISCVZttCopyM2M<"mcopy_m2m">;
def riscv_ztt_op_mextract : RISCVZttExtract<"mextract">;

// Matrix multiply.
def riscv_ztt_op_mmulacc_2d : RISCVZttMatmul<"mmulacc_2d">;
def riscv_ztt_op_mmulaccneg_2d : RISCVZttMatmul<"mmulaccneg_2d">;
def riscv_ztt_op_mmulatacc_2d : RISCVZttMatmul<"mmulatacc_2d">;
def riscv_ztt_op_mmulataccneg_2d : RISCVZttMatmul<"mmulataccneg_2d">;
def riscv_ztt_op_mmulbtacc_2d : RISCVZttMatmul<"mmulbtacc_2d">;
def riscv_ztt_op_mmulbtaccneg_2d : RISCVZttMatmul<"mmulbtaccneg_2d">;

// Elementwise and scalar operations.
def riscv_ztt_op_mabs_ew : RISCVZttUnary<"mabs_ew">;
def riscv_ztt_op_mabsdiff_ew : RISCVZttBinary<"mabsdiff_ew">;
def riscv_ztt_op_mabsdiff_ew_x : RISCVZttScalarBinary<"mabsdiff_ew_x">;
def riscv_ztt_op_madd_ew : RISCVZttBinary<"madd_ew">;
def riscv_ztt_op_madd_ew_x : RISCVZttScalarBinary<"madd_ew_x">;
def riscv_ztt_op_mand_ew : RISCVZttBinary<"mand_ew">;
def riscv_ztt_op_mand_ew_x : RISCVZttScalarBinary<"mand_ew_x">;
def riscv_ztt_op_mandnot_ew : RISCVZttBinary<"mandnot_ew">;
def riscv_ztt_op_mandnot_ew_x : RISCVZttScalarBinary<"mandnot_ew_x">;
def riscv_ztt_op_mbcast_m_x : RISCVZttScalarBroadcast<"mbcast_m_x">;
def riscv_ztt_op_mcmovge_ew : RISCVZttBinaryWithOld<"mcmovge_ew">;
def riscv_ztt_op_mcmovlt_ew : RISCVZttBinaryWithOld<"mcmovlt_ew">;
def riscv_ztt_op_mcmpge_ew : RISCVZttBinary<"mcmpge_ew">;
def riscv_ztt_op_mcmpge_ew_x : RISCVZttScalarBinary<"mcmpge_ew_x">;
def riscv_ztt_op_mcmplt_ew : RISCVZttBinary<"mcmplt_ew">;
def riscv_ztt_op_mcmplt_ew_x : RISCVZttScalarBinary<"mcmplt_ew_x">;
def riscv_ztt_op_mconv_ew : RISCVZttUnary<"mconv_ew">;
def riscv_ztt_op_mcos_ew : RISCVZttUnary<"mcos_ew">;
def riscv_ztt_op_mexp2_ew : RISCVZttUnary<"mexp2_ew">;
def riscv_ztt_op_mfrintm_ew : RISCVZttUnary<"mfrintm_ew">;
def riscv_ztt_op_mfrintn_ew : RISCVZttUnary<"mfrintn_ew">;
def riscv_ztt_op_mfrintp_ew : RISCVZttUnary<"mfrintp_ew">;
def riscv_ztt_op_mfrintz_ew : RISCVZttUnary<"mfrintz_ew">;
def riscv_ztt_op_mhdiff_ew : RISCVZttBinary<"mhdiff_ew">;
def riscv_ztt_op_mhdiff_ew_x : RISCVZttScalarBinary<"mhdiff_ew_x">;
def riscv_ztt_op_mldexp_ew : RISCVZttBinary<"mldexp_ew">;
def riscv_ztt_op_mldexp_ew_x : RISCVZttControlBinary<"mldexp_ew_x">;
def riscv_ztt_op_mldexpacc_ew : RISCVZttBinaryWithOld<"mldexpacc_ew">;
def riscv_ztt_op_mldexpacc_ew_x : RISCVZttControlBinaryWithOld<"mldexpacc_ew_x">;
def riscv_ztt_op_mlog2_ew : RISCVZttUnary<"mlog2_ew">;
def riscv_ztt_op_mlog2sub_ew : RISCVZttBinary<"mlog2sub_ew">;
def riscv_ztt_op_mlog2sub_ew_x : RISCVZttScalarBinary<"mlog2sub_ew_x">;
def riscv_ztt_op_mmax_ew : RISCVZttBinary<"mmax_ew">;
def riscv_ztt_op_mmax_ew_x : RISCVZttScalarBinary<"mmax_ew_x">;
def riscv_ztt_op_mmean_ew : RISCVZttBinary<"mmean_ew">;
def riscv_ztt_op_mmean_ew_x : RISCVZttScalarBinary<"mmean_ew_x">;
def riscv_ztt_op_mmin_ew : RISCVZttBinary<"mmin_ew">;
def riscv_ztt_op_mmin_ew_x : RISCVZttScalarBinary<"mmin_ew_x">;
def riscv_ztt_op_mmul_ew : RISCVZttBinary<"mmul_ew">;
def riscv_ztt_op_mmul_ew_x : RISCVZttScalarBinary<"mmul_ew_x">;
def riscv_ztt_op_mmulacc_ew : RISCVZttBinaryWithOld<"mmulacc_ew">;
def riscv_ztt_op_mmulacc_ew_x : RISCVZttScalarBinaryWithOld<"mmulacc_ew_x">;
def riscv_ztt_op_mmulaccneg_ew : RISCVZttBinaryWithOld<"mmulaccneg_ew">;
def riscv_ztt_op_mmulaccneg_ew_x : RISCVZttScalarBinaryWithOld<"mmulaccneg_ew_x">;
def riscv_ztt_op_mmuladd_ew : RISCVZttBinaryWithOld<"mmuladd_ew">;
def riscv_ztt_op_mmuladd_ew_x : RISCVZttScalarBinaryWithOld<"mmuladd_ew_x">;
def riscv_ztt_op_mmulneg_ew : RISCVZttBinary<"mmulneg_ew">;
def riscv_ztt_op_mmulneg_ew_x : RISCVZttScalarBinary<"mmulneg_ew_x">;
def riscv_ztt_op_mmulsub_ew : RISCVZttBinaryWithOld<"mmulsub_ew">;
def riscv_ztt_op_mmulsub_ew_x : RISCVZttScalarBinaryWithOld<"mmulsub_ew_x">;
def riscv_ztt_op_mor_ew : RISCVZttBinary<"mor_ew">;
def riscv_ztt_op_mor_ew_x : RISCVZttScalarBinary<"mor_ew_x">;
def riscv_ztt_op_mornot_ew : RISCVZttBinary<"mornot_ew">;
def riscv_ztt_op_mornot_ew_x : RISCVZttScalarBinary<"mornot_ew_x">;
def riscv_ztt_op_mrdexp_ew : RISCVZttBinary<"mrdexp_ew">;
def riscv_ztt_op_mrdexpacc_ew : RISCVZttBinaryWithOld<"mrdexpacc_ew">;
def riscv_ztt_op_mrec_ew : RISCVZttUnary<"mrec_ew">;
def riscv_ztt_op_mrsqrt_ew : RISCVZttUnary<"mrsqrt_ew">;
def riscv_ztt_op_mselge_ew : RISCVZttBinary<"mselge_ew">;
def riscv_ztt_op_msellt_ew : RISCVZttBinary<"msellt_ew">;
def riscv_ztt_op_msin_ew : RISCVZttUnary<"msin_ew">;
def riscv_ztt_op_msll_ew : RISCVZttBinary<"msll_ew">;
def riscv_ztt_op_msll_ew_x : RISCVZttControlBinary<"msll_ew_x">;
def riscv_ztt_op_msqrt_ew : RISCVZttUnary<"msqrt_ew">;
def riscv_ztt_op_msra_ew : RISCVZttBinary<"msra_ew">;
def riscv_ztt_op_msra_ew_x : RISCVZttControlBinary<"msra_ew_x">;
def riscv_ztt_op_msrl_ew : RISCVZttBinary<"msrl_ew">;
def riscv_ztt_op_msrl_ew_x : RISCVZttControlBinary<"msrl_ew_x">;
def riscv_ztt_op_msub_ew : RISCVZttBinary<"msub_ew">;
def riscv_ztt_op_msub_ew_x : RISCVZttScalarBinary<"msub_ew_x">;
def riscv_ztt_op_msublog2_ew : RISCVZttBinary<"msublog2_ew">;
def riscv_ztt_op_msublog2_ew_x : RISCVZttScalarBinary<"msublog2_ew_x">;
def riscv_ztt_op_mtanh_ew : RISCVZttUnary<"mtanh_ew">;
def riscv_ztt_op_mxor_ew : RISCVZttBinary<"mxor_ew">;
def riscv_ztt_op_mxor_ew_x : RISCVZttScalarBinary<"mxor_ew_x">;

// Reduction and prefix operations.
def riscv_ztt_op_mprefixadd_row : RISCVZttUnary<"mprefixadd_row">;
def riscv_ztt_op_mprefixadd_col : RISCVZttUnary<"mprefixadd_col">;
def riscv_ztt_op_mprefixmax_row : RISCVZttUnary<"mprefixmax_row">;
def riscv_ztt_op_mprefixmax_col : RISCVZttUnary<"mprefixmax_col">;
def riscv_ztt_op_mreduceadd_row : RISCVZttUnary<"mreduceadd_row">;
def riscv_ztt_op_mreduceadd_col : RISCVZttUnary<"mreduceadd_col">;
def riscv_ztt_op_mreducemax_row : RISCVZttUnary<"mreducemax_row">;
def riscv_ztt_op_mreducemax_col : RISCVZttUnary<"mreducemax_col">;
def riscv_ztt_op_mreducemin_row : RISCVZttUnary<"mreducemin_row">;
def riscv_ztt_op_mreducemin_col : RISCVZttUnary<"mreducemin_col">;

// Row and column operations.
def riscv_ztt_op_mrowbcast_ew_x : RISCVZttControlBinary<"mrowbcast_ew_x">;
def riscv_ztt_op_mcolbcast_ew_x : RISCVZttControlBinary<"mcolbcast_ew_x">;
def riscv_ztt_op_mrowgather_ew : RISCVZttBinary<"mrowgather_ew">;
def riscv_ztt_op_mcolgather_ew : RISCVZttBinary<"mcolgather_ew">;
def riscv_ztt_op_mrowid_ew : RISCVZttNoArg<"mrowid_ew">;
def riscv_ztt_op_mcolid_ew : RISCVZttNoArg<"mcolid_ew">;
def riscv_ztt_op_mrowscatadd_ew : RISCVZttBinaryWithOld<"mrowscatadd_ew">;
def riscv_ztt_op_mcolscatadd_ew : RISCVZttBinaryWithOld<"mcolscatadd_ew">;
def riscv_ztt_op_mrowscatmax_ew : RISCVZttBinaryWithOld<"mrowscatmax_ew">;
def riscv_ztt_op_mcolscatmax_ew : RISCVZttBinaryWithOld<"mcolscatmax_ew">;
def riscv_ztt_op_mrowshift_ew_x : RISCVZttControlBinary<"mrowshift_ew_x">;
def riscv_ztt_op_mcolshift_ew_x : RISCVZttControlBinary<"mcolshift_ew_x">;
def riscv_ztt_op_mrowunzip_ew : RISCVZttZipUnZip<"mrowunzip_ew">;
def riscv_ztt_op_mcolunzip_ew : RISCVZttZipUnZip<"mcolunzip_ew">;
def riscv_ztt_op_mrowzip_ew : RISCVZttZipUnZip<"mrowzip_ew">;
def riscv_ztt_op_mcolzip_ew : RISCVZttZipUnZip<"mcolzip_ew">;

#endif // LLVM_IR_RISCVZTTOPERATIONS_TD
