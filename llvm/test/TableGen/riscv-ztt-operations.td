// RUN: llvm-tblgen -I %p/../../include %s -o /dev/null

include "llvm/IR/RISCVZttOperations.td"

// Check the complete operation list and its record-to-interface name mapping.
defvar ExpectedNames = [
    "ame_acquire", "ame_release", "get_amefflags", "get_amenlen",
    "get_ameown", "get_amestatus", "get_amestype", "get_ameudsz",
    "get_amexsat", "mabs_ew", "mabsdiff_ew", "mabsdiff_ew_x", "madd_ew",
    "madd_ew_x", "mand_ew", "mand_ew_x", "mandnot_ew", "mandnot_ew_x",
    "mbcast_m_x", "mclear_acc", "mclear_m", "mcmovge_ew", "mcmovlt_ew",
    "mcmpge_ew", "mcmpge_ew_x", "mcmplt_ew", "mcmplt_ew_x", "mcolbcast_ew_x",
    "mcolgather_ew", "mcolid_ew", "mcolscatadd_ew", "mcolscatmax_ew",
    "mcolshift_ew_x", "mcolunzip_ew", "mcolzip_ew", "mconcat_m", "mconv_ew",
    "mcopy_a2m", "mcopy_m2a", "mcopy_m2m", "mcos_ew", "mexp2_ew", "mextract",
    "mfrintm_ew", "mfrintn_ew", "mfrintp_ew", "mfrintz_ew", "mhdiff_ew",
    "mhdiff_ew_x", "mldexp_ew", "mldexp_ew_x", "mldexpacc_ew",
    "mldexpacc_ew_x", "mlog2_ew", "mlog2sub_ew", "mlog2sub_ew_x", "mls_cm",
    "mls_rm", "mls_st", "mls_tst", "mmax_ew", "mmax_ew_x", "mmean_ew",
    "mmean_ew_x", "mmin_ew", "mmin_ew_x", "mmul_ew", "mmul_ew_x",
    "mmulacc_2d", "mmulacc_ew", "mmulacc_ew_x", "mmulaccneg_2d",
    "mmulaccneg_ew", "mmulaccneg_ew_x", "mmuladd_ew", "mmuladd_ew_x",
    "mmulatacc_2d", "mmulataccneg_2d", "mmulbtacc_2d", "mmulbtaccneg_2d",
    "mmulneg_ew", "mmulneg_ew_x", "mmulsub_ew", "mmulsub_ew_x", "mor_ew",
    "mor_ew_x", "mornot_ew", "mornot_ew_x", "mprefixadd_col",
    "mprefixadd_row", "mprefixmax_col", "mprefixmax_row", "mrdexp_ew",
    "mrdexpacc_ew", "mrec_ew", "mreduceadd_col", "mreduceadd_row",
    "mreducemax_col", "mreducemax_row", "mreducemin_col", "mreducemin_row",
    "mrowbcast_ew_x", "mrowgather_ew", "mrowid_ew", "mrowscatadd_ew",
    "mrowscatmax_ew", "mrowshift_ew_x", "mrowunzip_ew", "mrowzip_ew",
    "mrsqrt_ew", "mselge_ew", "msellt_ew", "msin_ew", "msll_ew", "msll_ew_x",
    "msqrt_ew", "msra_ew", "msra_ew_x", "msrl_ew", "msrl_ew_x", "mss_cm",
    "mss_rm", "mss_st", "mss_tst", "msub_ew", "msub_ew_x", "msublog2_ew",
    "msublog2_ew_x", "mtanh_ew", "mxor_ew", "mxor_ew_x", "mzero_acc",
    "mzero_m"
];

assert !eq(!size(!instances<RISCVZttOperation>()), !size(ExpectedNames)),
       "unexpected operation count";
foreach Name = ExpectedNames in
  assert !eq(!cast<RISCVZttOperation>("riscv_ztt_op_" # Name).Name, Name),
         "operation name mismatch: " # Name;

// Base classes describe C signatures, without instruction-specific checks.
assert !isa<RISCVZttCompute>(riscv_ztt_op_madd_ew), "compute signature";
assert !isa<RISCVZttUnary>(riscv_ztt_op_mabs_ew), "unary signature";
assert !isa<RISCVZttBinary>(riscv_ztt_op_madd_ew), "binary signature";
assert !isa<RISCVZttScalarBinary>(riscv_ztt_op_madd_ew_x), "matrix and scalar signature";
assert !isa<RISCVZttBinaryWithOld>(riscv_ztt_op_mcmovge_ew), "old result and two matrices";
assert !isa<RISCVZttScalarBinaryWithOld>(riscv_ztt_op_mmulacc_ew_x),
       "old result, matrix and scalar";
foreach Op = [riscv_ztt_op_msll_ew, riscv_ztt_op_msrl_ew, riscv_ztt_op_msra_ew] in
  assert !isa<RISCVZttBinary>(Op), "two matrix arguments";
foreach Op = [riscv_ztt_op_msll_ew_x, riscv_ztt_op_msrl_ew_x, riscv_ztt_op_msra_ew_x,
              riscv_ztt_op_mldexp_ew_x,
              riscv_ztt_op_mcolbcast_ew_x, riscv_ztt_op_mrowbcast_ew_x,
              riscv_ztt_op_mcolshift_ew_x, riscv_ztt_op_mrowshift_ew_x] in
{
  assert !isa<RISCVZttControlBinary>(Op), "matrix and control arguments";
  assert !not(!isa<RISCVZttScalarBinary>(Op)), "control has no RISC-V Ztt scalar datatype";
}
assert !isa<RISCVZttControlBinaryWithOld>(riscv_ztt_op_mldexpacc_ew_x),
       "old result, matrix and control";
assert !not(!isa<RISCVZttScalarBinaryWithOld>(riscv_ztt_op_mldexpacc_ew_x)),
       "old result does not change the control datatype";
assert !not(!isa<RISCVZttControlBinary>(riscv_ztt_op_madd_ew_x)),
       "data scalar is not a control argument";
assert !isa<RISCVZttMatmul>(riscv_ztt_op_mmulacc_2d), "matmul signature";
foreach Op = [riscv_ztt_op_mcopy_m2m, riscv_ztt_op_mcopy_m2a, riscv_ztt_op_mcopy_a2m] in
  assert !isa<RISCVZttCopy>(Op), "copy signature";
assert !isa<RISCVZttCopyM2M>(riscv_ztt_op_mcopy_m2m), "same-type M copy";
assert !isa<RISCVZttCopyM2A>(riscv_ztt_op_mcopy_m2a), "M to ACC copy";
assert !isa<RISCVZttCopyA2M>(riscv_ztt_op_mcopy_a2m), "ACC to M copy";
assert !isa<RISCVZttConcat>(riscv_ztt_op_mconcat_m), "concat has matching input types";
assert !not(!isa<RISCVZttBinary>(riscv_ztt_op_mconcat_m)), "concat is not arithmetic";
assert !isa<RISCVZttExtract>(riscv_ztt_op_mextract), "extract has a constant index";
assert !not(!isa<RISCVZttControlBinary>(riscv_ztt_op_mextract)),
       "extract is not a runtime control operation";
assert !isa<RISCVZttLoad>(riscv_ztt_op_mls_rm), "load signature";
assert !isa<RISCVZttStridedLoad>(riscv_ztt_op_mls_st), "strided load signature";
assert !isa<RISCVZttStore>(riscv_ztt_op_mss_rm), "store signature";
assert !isa<RISCVZttStridedStore>(riscv_ztt_op_mss_st), "strided store signature";
assert !isa<RISCVZttCSRRead>(riscv_ztt_op_get_amenlen), "CSR read signature";
foreach Op = [riscv_ztt_op_get_amenlen, riscv_ztt_op_ame_acquire, riscv_ztt_op_ame_release] in
{
  assert !isa<RISCVZttState>(Op), "state signature";
  assert !not(!isa<RISCVZttNoArg>(Op)), "state is not a matrix result operation";
}
foreach Op = [riscv_ztt_op_mcolzip_ew, riscv_ztt_op_mcolunzip_ew,
              riscv_ztt_op_mrowzip_ew, riscv_ztt_op_mrowunzip_ew] in
{
  assert !isa<RISCVZttZipUnZip>(Op), "zip/unzip signature";
  assert !not(!isa<RISCVZttNoMatrixArg>(Op)), "old result is a matrix argument";
}
assert !isa<RISCVZttNoMatrixArg>(riscv_ztt_op_mbcast_m_x), "no matrix arguments";
assert !isa<RISCVZttScalarBroadcast>(riscv_ztt_op_mbcast_m_x),
       "broadcast has a scalar datatype";
assert !not(!isa<RISCVZttNoArg>(riscv_ztt_op_mbcast_m_x)), "broadcast takes a scalar";
assert !eq(!size(!instances<RISCVZttNoArg>()), 6), "unexpected no-argument operations";
foreach Op = [riscv_ztt_op_mclear_m, riscv_ztt_op_mclear_acc, riscv_ztt_op_mzero_m,
              riscv_ztt_op_mzero_acc, riscv_ztt_op_mrowid_ew, riscv_ztt_op_mcolid_ew] in
{
  assert !isa<RISCVZttNoArg>(Op), "no-argument matrix result";
  assert !isa<RISCVZttNoMatrixArg>(Op), "no matrix arguments";
  assert !not(!isa<RISCVZttScalarBroadcast>(Op)), "no scalar broadcast argument";
}

// Check each count separately: exchanging a matrix and scalar must fail.
class CheckArguments<RISCVZttOperation op, int matrices, int scalars, bit old>
{
  assert !eq(op.NumMatrixArgs, matrices), "wrong matrix argument count";
  assert !eq(op.NumScalarArgs, scalars), "wrong scalar argument count";
  assert !eq(op.HasOldResult, old), "wrong old result argument";
}

foreach Op = [riscv_ztt_op_mclear_m, riscv_ztt_op_mclear_acc, riscv_ztt_op_mzero_m,
              riscv_ztt_op_mzero_acc, riscv_ztt_op_mrowid_ew, riscv_ztt_op_mcolid_ew,
              riscv_ztt_op_get_amenlen, riscv_ztt_op_ame_release] in
  def : CheckArguments<Op, 0, 0, 0>;
foreach Op = [riscv_ztt_op_mcolzip_ew, riscv_ztt_op_mcolunzip_ew,
              riscv_ztt_op_mrowzip_ew, riscv_ztt_op_mrowunzip_ew] in
  def : CheckArguments<Op, 0, 0, 1>;
foreach Op = [riscv_ztt_op_mbcast_m_x, riscv_ztt_op_ame_acquire,
              riscv_ztt_op_mls_rm, riscv_ztt_op_mls_cm] in
  def : CheckArguments<Op, 0, 1, 0>;
foreach Op = [riscv_ztt_op_mls_st, riscv_ztt_op_mls_tst] in
  def : CheckArguments<Op, 0, 2, 0>;
foreach Op = [riscv_ztt_op_mabs_ew, riscv_ztt_op_msqrt_ew, riscv_ztt_op_mreduceadd_row,
              riscv_ztt_op_mcopy_m2m, riscv_ztt_op_mcopy_m2a, riscv_ztt_op_mcopy_a2m] in
  def : CheckArguments<Op, 1, 0, 0>;
foreach Op = [riscv_ztt_op_madd_ew_x, riscv_ztt_op_mlog2sub_ew_x, riscv_ztt_op_mcmpge_ew_x,
              riscv_ztt_op_mrowbcast_ew_x, riscv_ztt_op_mrowshift_ew_x,
              riscv_ztt_op_msll_ew_x, riscv_ztt_op_msrl_ew_x, riscv_ztt_op_msra_ew_x,
              riscv_ztt_op_mextract, riscv_ztt_op_mss_rm, riscv_ztt_op_mss_cm] in
  def : CheckArguments<Op, 1, 1, 0>;
foreach Op = [riscv_ztt_op_mss_st, riscv_ztt_op_mss_tst] in
  def : CheckArguments<Op, 1, 2, 0>;
foreach Op = [riscv_ztt_op_mmulacc_ew_x, riscv_ztt_op_mmulaccneg_ew_x,
              riscv_ztt_op_mmuladd_ew_x, riscv_ztt_op_mmulsub_ew_x,
              riscv_ztt_op_mldexpacc_ew_x] in
  def : CheckArguments<Op, 1, 1, 1>;
foreach Op = [riscv_ztt_op_madd_ew, riscv_ztt_op_mlog2sub_ew, riscv_ztt_op_mcmpge_ew,
              riscv_ztt_op_msll_ew, riscv_ztt_op_msrl_ew, riscv_ztt_op_msra_ew,
              riscv_ztt_op_mconcat_m] in
  def : CheckArguments<Op, 2, 0, 0>;
foreach Op = [riscv_ztt_op_mcmovge_ew, riscv_ztt_op_mmulacc_ew,
              riscv_ztt_op_mmulacc_2d, riscv_ztt_op_mmulaccneg_2d,
              riscv_ztt_op_mmulatacc_2d, riscv_ztt_op_mmulataccneg_2d,
              riscv_ztt_op_mmulbtacc_2d, riscv_ztt_op_mmulbtaccneg_2d] in
  def : CheckArguments<Op, 2, 0, 1>;

// NonMatrix includes both scalar state results and void stores/release.
foreach Op = [riscv_ztt_op_mclear_m, riscv_ztt_op_mzero_m, riscv_ztt_op_madd_ew,
              riscv_ztt_op_mrowid_ew, riscv_ztt_op_mcolid_ew,
              riscv_ztt_op_madd_ew_x, riscv_ztt_op_mcopy_m2m, riscv_ztt_op_mcopy_a2m,
              riscv_ztt_op_mls_rm, riscv_ztt_op_mls_cm, riscv_ztt_op_mls_st,
              riscv_ztt_op_mls_tst, riscv_ztt_op_mconcat_m, riscv_ztt_op_mextract] in
  assert !eq(Op.ResultKind, "M"), "M result";
foreach Op = [riscv_ztt_op_mclear_acc, riscv_ztt_op_mzero_acc, riscv_ztt_op_mcopy_m2a,
              riscv_ztt_op_mmulacc_2d, riscv_ztt_op_mmulaccneg_2d,
              riscv_ztt_op_mmulatacc_2d, riscv_ztt_op_mmulataccneg_2d,
              riscv_ztt_op_mmulbtacc_2d, riscv_ztt_op_mmulbtaccneg_2d] in
  assert !eq(Op.ResultKind, "ACC"), "ACC result";
foreach Op = [riscv_ztt_op_get_amenlen, riscv_ztt_op_ame_acquire, riscv_ztt_op_ame_release,
              riscv_ztt_op_mss_rm, riscv_ztt_op_mss_cm, riscv_ztt_op_mss_st, riscv_ztt_op_mss_tst] in
  assert !eq(Op.ResultKind, "NonMatrix"), "ordinary scalar or void result";

foreach Op = !instances<RISCVZttOperation>() in
{
  assert !and(!ge(Op.NumMatrixArgs, 0), !le(Op.NumMatrixArgs, 2)),
         "unknown matrix argument count";
  assert !and(!ge(Op.NumScalarArgs, 0), !le(Op.NumScalarArgs, 2)),
         "unknown scalar argument count";
  assert !le(!add(Op.NumMatrixArgs, Op.NumScalarArgs, Op.HasOldResult), 3),
         "unknown total argument count";
  assert !not(!empty(!filter(Kind, ["NonMatrix", "M", "ACC"],
      !eq(Kind, Op.ResultKind)))), "unknown result kind";
}
