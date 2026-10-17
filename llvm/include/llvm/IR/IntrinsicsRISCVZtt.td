//===- IntrinsicsRISCVZtt.td - RISC-V Ztt intrinsics ------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

include "llvm/IR/RISCVZttOperations.td"

// RISC-V Ztt intrinsics with constant i32 arguments after the data arguments.
// metadata: Number of extra arguments, normally datatype code and square count.
// Matmul only needs the square count; data scalars also need a scalar datatype.
// Datatype codes use the full Md/Ad encoding.
class RISCVZttIntrinsic<list<LLVMType> results, list<LLVMType> data,
                      int metadata = 2,
                      list<IntrinsicProperty> effects = [IntrNoMem]>
    : DefaultAttrsIntrinsic<results,
        !listconcat(data, !listsplat(llvm_i32_ty, metadata)),
        !listconcat(effects, !foreach(I, !range(!size(data),
            !add(!size(data), metadata)), ImmArg<ArgIndex<I>>))>;

// Generate intrinsics with matrix results.
// If HasOldResult is set, old_d is the first argument and has the result type.
multiclass RISCVZttMatrixIntrinsics<list<RISCVZttOperation> ops, list<LLVMType> data,
                                  int metadata = 2,
                                  list<IntrinsicProperty> effects = [IntrNoMem]>
{
  foreach Op = ops in
    def int_riscv_ztt_#Op.Name
        : RISCVZttIntrinsic<[llvm_any_ty], !listconcat(
            !if(Op.HasOldResult, [LLVMMatchType<0>], []), data),
            metadata, effects>;
}

// (base [, stride]) -> M.
class RISCVZttLoadIntrinsic<bit strided>
    : RISCVZttIntrinsic<[llvm_any_ty], !listconcat([llvm_ptr_ty],
        !if(strided, [llvm_anyint_ty], [])), 2,
        [IntrReadMem, IntrArgMemOnly, NoCapture<ArgIndex<0>>]>;

// (base [, stride], matrix) -> void.
class RISCVZttStoreIntrinsic<bit strided>
    : RISCVZttIntrinsic<[],
        !listconcat([llvm_ptr_ty], !if(strided, [llvm_anyint_ty], []),
                    [llvm_any_ty]), 2,
        [IntrWriteMem, IntrArgMemOnly, NoCapture<ArgIndex<0>>]>;

let TargetPrefix = "riscv" in
{
  // State.
  // Acquire/release change AME ownership and must not be removed.
  // Keep CSR reads even when their results are unused; they may trap.
  let IntrProperties = [IntrNoMem, IntrHasSideEffects] in
  {
    def int_riscv_ztt_ame_acquire
        : DefaultAttrsIntrinsic<[llvm_anyint_ty], [LLVMMatchType<0>]>;
    def int_riscv_ztt_ame_release : DefaultAttrsIntrinsic<[], []>;
    foreach Op = !instances<RISCVZttCSRRead>() in
      def int_riscv_ztt_#Op.Name : DefaultAttrsIntrinsic<[llvm_anyint_ty], []>;
  }

  // Load and store.
  foreach Op = !instances<RISCVZttLoad>() in
    def int_riscv_ztt_#Op.Name : RISCVZttLoadIntrinsic<!isa<RISCVZttStridedLoad>(Op)>;
  foreach Op = !instances<RISCVZttStore>() in
    def int_riscv_ztt_#Op.Name : RISCVZttStoreIntrinsic<!isa<RISCVZttStridedStore>(Op)>;

  // () or (old_d).
  defm "" : RISCVZttMatrixIntrinsics<!listconcat(!instances<RISCVZttNoArg>(),
                                               !instances<RISCVZttZipUnZip>()),
                                   []>;

  // (matrix); source and result types are independent.
  defm "" : RISCVZttMatrixIntrinsics<!listconcat(!instances<RISCVZttUnary>(),
                                               !instances<RISCVZttCopyM2A>(),
                                               !instances<RISCVZttCopyA2M>()),
                                   [llvm_any_ty]>;

  // Copy within M, concat and extract.
  // mconcat carries its source square count and has matching input types.
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttConcat>(),
                                   [llvm_any_ty, LLVMMatchType<1>]>;
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttCopyM2M>(), [LLVMMatchType<0>]>;
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttExtract>(),
      [llvm_any_ty, llvm_anyint_ty], 2, [IntrNoMem, ImmArg<ArgIndex<1>>]>;

  // Matrix multiply: only the M input square count follows.
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttMatmul>(),
                                   [llvm_any_ty, llvm_any_ty], 1>;

  // (matrix, matrix) or (old_d, matrix, matrix).
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttBinary>(),
                                   [llvm_any_ty, llvm_any_ty]>;

  // (matrix, scalar); the scalar datatype is written to AMESTYPE.
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttScalarBinary>(),
      [llvm_any_ty, llvm_anyint_ty], 3, [IntrNoMem, IntrHasSideEffects]>;

  // (matrix, control); no scalar datatype or AMESTYPE write.
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttControlBinary>(),
                                   [llvm_any_ty, llvm_anyint_ty]>;

  // (scalar); broadcast carries its datatype without an AMESTYPE write.
  defm "" : RISCVZttMatrixIntrinsics<!instances<RISCVZttScalarBroadcast>(),
                                   [llvm_anyint_ty], 3>;
}
