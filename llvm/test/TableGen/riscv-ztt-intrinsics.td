// RUN: llvm-tblgen -I %p/../../include -DTEST_INTRINSICS_SUPPRESS_DEFS %s -o /dev/null

// Shared descriptions can be included before and after the intrinsic definitions.
include "llvm/IR/RISCVZttOperations.td"
include "llvm/IR/Intrinsics.td"
include "llvm/IR/IntrinsicsRISCVZtt.td"
include "llvm/IR/RISCVZttOperations.td"

// Check signatures, overload relationships, immediate positions and effects.
class CheckSignature<string name, list<LLVMType> results,
                     list<LLVMType> args, list<int> immediates,
                     list<IntrinsicProperty> effects = [IntrNoMem],
                     bit hasBase = 0>
{
  Intrinsic I = !cast<Intrinsic>("int_riscv_ztt_" # name);
  TypeInfoGen Expected = TypeInfoGen<results, args>;
  assert !eq(!repr(I.TypeInfo.TypeSig), !repr(Expected.TypeSig)),
         "wrong signature: " # name;
  assert !eq(I.TargetPrefix, "riscv"), "wrong target prefix: " # name;
  assert !not(I.DisableDefaultAttributes), "missing default attributes: " # name;

  list<IntrinsicProperty> ImmArgs = !filter(P, I.IntrProperties, !isa<ImmArg>(P));
  assert !eq(!size(ImmArgs), !size(immediates)), "wrong immediate count: " # name;
  // Attribute indices start at one; signature argument indices start at zero.
  list<int> ImmIndices = !foreach(P, ImmArgs, !sub(!cast<ImmArg>(P).ArgNo, 1));
  assert !empty(!listremove(immediates, ImmIndices)),
         "missing immediate: " # name;

  list<IntrinsicProperty> Captures = !filter(P, I.IntrProperties, !isa<NoCapture>(P));
  assert !eq(!size(Captures), hasBase), "wrong pointer capture attributes: " # name;
  assert !empty(!filter(P, Captures, !ne(!cast<NoCapture>(P).ArgNo, 1))),
         "wrong base pointer: " # name;

  list<IntrinsicProperty> Effects = !filter(P, I.IntrProperties,
      !not(!or(!isa<ImmArg>(P), !isa<NoCapture>(P))));
  assert !eq(!size(Effects), !size(effects)), "wrong effect count: " # name;
  assert !empty(!listremove(effects, Effects)),
         "missing effect: " # name;
}

foreach Name = ["mclear_m", "mzero_m", "mclear_acc", "mzero_acc",
                "mrowid_ew", "mcolid_ew"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_i32_ty, llvm_i32_ty], [0, 1]>;

foreach Name = ["mabs_ew", "mconv_ew", "mexp2_ew", "mlog2_ew", "mcos_ew",
                "msin_ew", "mtanh_ew", "mrec_ew", "mrsqrt_ew", "msqrt_ew",
                "mfrintm_ew", "mfrintn_ew", "mfrintp_ew", "mfrintz_ew",
                "mprefixadd_col", "mprefixadd_row", "mprefixmax_col",
                "mprefixmax_row", "mreduceadd_col", "mreduceadd_row",
                "mreducemax_col", "mreducemax_row", "mreducemin_col",
                "mreducemin_row", "mcopy_m2a", "mcopy_a2m"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_any_ty, llvm_i32_ty, llvm_i32_ty], [1, 2]>;

foreach Name = ["madd_ew", "mabsdiff_ew", "mhdiff_ew", "mmean_ew", "mmul_ew",
                "mmulneg_ew", "msub_ew", "mmax_ew", "mmin_ew", "mand_ew",
                "mandnot_ew", "mor_ew", "mornot_ew", "mxor_ew", "msll_ew",
                "msrl_ew", "msra_ew", "mcmpge_ew", "mcmplt_ew", "mselge_ew",
                "msellt_ew", "mldexp_ew", "mrdexp_ew", "mlog2sub_ew",
                "msublog2_ew", "mcolgather_ew", "mrowgather_ew"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_any_ty, llvm_any_ty, llvm_i32_ty, llvm_i32_ty], [2, 3]>;

// Data scalars carry a separate datatype and update AMESTYPE.
foreach Name = ["madd_ew_x", "mabsdiff_ew_x", "mhdiff_ew_x", "mmean_ew_x",
                "mmul_ew_x", "mmulneg_ew_x", "msub_ew_x", "mmax_ew_x",
                "mmin_ew_x", "mand_ew_x", "mandnot_ew_x", "mor_ew_x",
                "mornot_ew_x", "mxor_ew_x", "mcmpge_ew_x", "mcmplt_ew_x",
                "mlog2sub_ew_x", "msublog2_ew_x"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_any_ty, llvm_anyint_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
      [2, 3, 4], [IntrNoMem, IntrHasSideEffects]>;

// Control scalars do not update AMESTYPE.
foreach Name = ["msll_ew_x", "msrl_ew_x", "msra_ew_x", "mldexp_ew_x",
                "mcolbcast_ew_x", "mrowbcast_ew_x", "mcolshift_ew_x",
                "mrowshift_ew_x"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_any_ty, llvm_anyint_ty, llvm_i32_ty, llvm_i32_ty], [2, 3]>;

foreach Name = ["mcmovge_ew", "mcmovlt_ew", "mmulacc_ew", "mmulaccneg_ew",
                "mmuladd_ew", "mmulsub_ew", "mldexpacc_ew", "mrdexpacc_ew",
                "mcolscatadd_ew", "mrowscatadd_ew", "mcolscatmax_ew",
                "mrowscatmax_ew"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [LLVMMatchType<0>, llvm_any_ty, llvm_any_ty, llvm_i32_ty, llvm_i32_ty],
      [3, 4]>;

foreach Name = ["mmulacc_ew_x", "mmulaccneg_ew_x", "mmuladd_ew_x", "mmulsub_ew_x"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [LLVMMatchType<0>, llvm_any_ty, llvm_anyint_ty,
       llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
      [3, 4, 5], [IntrNoMem, IntrHasSideEffects]>;

def check_mldexpacc_ew_x : CheckSignature<"mldexpacc_ew_x", [llvm_any_ty],
    [LLVMMatchType<0>, llvm_any_ty, llvm_anyint_ty, llvm_i32_ty, llvm_i32_ty],
    [3, 4]>;

// Matmul inherits the ACC datatype from old_d and only adds the M square count.
foreach Name = ["mmulacc_2d", "mmulaccneg_2d", "mmulatacc_2d", "mmulataccneg_2d",
                "mmulbtacc_2d", "mmulbtaccneg_2d"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [LLVMMatchType<0>, llvm_any_ty, llvm_any_ty, llvm_i32_ty], [3]>;

foreach Name = ["mcopy_m2m", "mcolzip_ew", "mcolunzip_ew",
                "mrowzip_ew", "mrowunzip_ew"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [LLVMMatchType<0>, llvm_i32_ty, llvm_i32_ty], [1, 2]>;

def check_mconcat_m : CheckSignature<"mconcat_m", [llvm_any_ty],
    [llvm_any_ty, LLVMMatchType<1>, llvm_i32_ty, llvm_i32_ty], [2, 3]>;
def check_mextract : CheckSignature<"mextract", [llvm_any_ty],
    [llvm_any_ty, llvm_anyint_ty, llvm_i32_ty, llvm_i32_ty], [1, 2, 3]>;

// Broadcast carries a scalar datatype without writing AMESTYPE.
def check_mbcast_m_x : CheckSignature<"mbcast_m_x", [llvm_any_ty],
    [llvm_anyint_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [1, 2, 3]>;

foreach Name = ["mls_rm", "mls_cm"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty], [1, 2],
      [IntrReadMem, IntrArgMemOnly], 1>;
foreach Name = ["mls_st", "mls_tst"] in
  def check_#Name : CheckSignature<Name, [llvm_any_ty],
      [llvm_ptr_ty, llvm_anyint_ty, llvm_i32_ty, llvm_i32_ty], [2, 3],
      [IntrReadMem, IntrArgMemOnly], 1>;
foreach Name = ["mss_rm", "mss_cm"] in
  def check_#Name : CheckSignature<Name, [],
      [llvm_ptr_ty, llvm_any_ty, llvm_i32_ty, llvm_i32_ty], [2, 3],
      [IntrWriteMem, IntrArgMemOnly], 1>;
foreach Name = ["mss_st", "mss_tst"] in
  def check_#Name : CheckSignature<Name, [],
      [llvm_ptr_ty, llvm_anyint_ty, llvm_any_ty, llvm_i32_ty, llvm_i32_ty], [3, 4],
      [IntrWriteMem, IntrArgMemOnly], 1>;

def check_ame_acquire : CheckSignature<"ame_acquire", [llvm_anyint_ty],
    [LLVMMatchType<0>], [], [IntrNoMem, IntrHasSideEffects]>;
def check_ame_release : CheckSignature<"ame_release", [], [], [],
    [IntrNoMem, IntrHasSideEffects]>;
foreach Name = ["get_ameown", "get_amestype", "get_amenlen", "get_ameudsz",
                "get_amefflags", "get_amexsat", "get_amestatus"] in
  def check_#Name : CheckSignature<Name, [llvm_anyint_ty], [], [],
      [IntrNoMem, IntrHasSideEffects]>;

// Keep explicit expectations independent of the classes used for generation.
defvar CheckedIntrinsics = !foreach(C, !instances<CheckSignature>(), C.I);
assert !eq(!size(CheckedIntrinsics), 133),
       "unexpected signature check count";
assert !eq(!size(!instances<Intrinsic>()), !size(CheckedIntrinsics)),
       "unexpected intrinsic count";
assert !empty(!listremove(!instances<Intrinsic>(), CheckedIntrinsics)),
       "missing intrinsic signature check";

// Every shared operation must produce exactly one intrinsic.
defvar OperationIntrinsics = !foreach(Op, !instances<RISCVZttOperation>(),
    !cast<Intrinsic>("int_riscv_ztt_" # Op.Name));
assert !eq(!size(OperationIntrinsics), !size(CheckedIntrinsics)),
       "unexpected operation count";
assert !empty(!listremove(CheckedIntrinsics, OperationIntrinsics)),
       "intrinsic is missing its shared operation";
