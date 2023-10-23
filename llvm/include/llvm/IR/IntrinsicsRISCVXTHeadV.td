//===- IntrinsicsRISCVXTHeadV.td - RVV 0.7.1 intrinsics ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines all of RISC-V Vector Extension version 0.7.1 intrinsics.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Vectors version 0.7.1

let TargetPrefix = "riscv" in {
  // 6. Configuration-Setting and Utility
  def int_riscv_xvsetvl    : Intrinsic<[llvm_i64_ty],
                                       [/* AVL */ llvm_i64_ty, /* SEW */ llvm_i64_ty, /* LMUL */ llvm_i64_ty],
                                       [IntrNoMem]>;
  def int_riscv_xvsetvlmax : Intrinsic<[llvm_i64_ty],
                                       [/* SEW */ llvm_i64_ty, /* LMUL */ llvm_i64_ty],
                                       [IntrNoMem]>;

  defm xvadd : RISCVBinaryAAX;

} // TargetPrefix = "riscv"

let TargetPrefix = "riscv" in {
  // 8. Vector AMO Operations (Zvamo)

  // For atomic operations without mask
  // Input: (base pointer, index, value, vl)
  class XVAMONoMask
        : Intrinsic<[llvm_anyvector_ty],
                    [llvm_ptr_ty, llvm_anyvector_ty, LLVMMatchType<0>,
                     llvm_anyint_ty],
                    [NoCapture<ArgIndex<0>>]>, RISCVVIntrinsic;
  // For atomic operations with mask
  // Input: (base pointer, index, value, mask, vl)
  class XVAMOMask
        : Intrinsic<[llvm_anyvector_ty],
                    [llvm_ptr_ty, llvm_anyvector_ty, LLVMMatchType<0>,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                    [NoCapture<ArgIndex<0>>]>, RISCVVIntrinsic;

  multiclass XIntrinsicVAMO {
    def "int_riscv_" # NAME           : XVAMONoMask;
    def "int_riscv_" # NAME # "_mask" : XVAMOMask;
  }

  defm xvamoswap : XIntrinsicVAMO;
  defm xvamoadd  : XIntrinsicVAMO;
  defm xvamoxor  : XIntrinsicVAMO;
  defm xvamoand  : XIntrinsicVAMO;
  defm xvamoor   : XIntrinsicVAMO;
  defm xvamomin  : XIntrinsicVAMO;
  defm xvamomax  : XIntrinsicVAMO;
  defm xvamominu : XIntrinsicVAMO;
  defm xvamomaxu : XIntrinsicVAMO;
} // TargetPrefix = "riscv"
