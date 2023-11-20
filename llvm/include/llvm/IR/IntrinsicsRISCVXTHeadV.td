//===- IntrinsicsRISCVXTHeadV.td - RVV 0.7.1 intrinsics ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the prototype (in LLVM IR) of RVV 0.7.1 intrinsics.
// Refer to RISCVInstrrInfoXTHeadVPseudos.td for lowering from intrinsic calls
// to MC instructions.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Vectors version 0.7.1

let TargetPrefix = "riscv" in {
  // 6. Configuration-Setting and Utility
  def int_riscv_xvsetvl    : Intrinsic<[llvm_anyint_ty],
                                       [/* AVL */ LLVMMatchType<0>,
                                        /* SEW */ LLVMMatchType<0>,
                                        /* LMUL */ LLVMMatchType<0>
                                       ],
                                       [IntrNoMem,
                                        ImmArg<ArgIndex<1>>,
                                        ImmArg<ArgIndex<2>>
                                       ]>;
  def int_riscv_xvsetvlmax : Intrinsic<[llvm_anyint_ty],
                                       [/* SEW */ LLVMMatchType<0>,
                                        /* LMUL */ LLVMMatchType<0>
                                       ],
                                       [IntrNoMem,
                                        ImmArg<ArgIndex<0>>,
                                        ImmArg<ArgIndex<1>>
                                       ]>;
} // TargetPrefix = "riscv"

let TargetPrefix = "riscv" in {
  // 7. Vector Loads and Stores

  // 7.4 Vector Unit-Strided Instructions
  // For unit stride load
  // Input: (passthru, pointer, vl)
  class XVUSLoad
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                    [LLVMMatchType<0>, llvm_ptr_ty, llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrReadMem]>, RISCVVIntrinsic {
    let VLOperand = 2;
  }

  // For unit stride mask load
  // Input: (passthru, pointer, vl)
  class XVUSLoadMasked
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                    [LLVMMatchType<0>, llvm_ptr_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                     llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrReadMem]>,
                    RISCVVIntrinsic {
    let VLOperand = 3;
  }

  // For unit stride store
  // Input: (vector_in, pointer, vl)
  class XVUSStore
        : DefaultAttrsIntrinsic<[],
                    [llvm_anyvector_ty, llvm_ptr_ty, llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = 2;
  }

  // For unit stride store with mask
  // Input: (vector_in, pointer, mask, vl)
  class XVUSStoreMasked
        : DefaultAttrsIntrinsic<[],
                    [llvm_anyvector_ty, llvm_ptr_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                     llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = 3;
  }

  // We define vlx (e.g. vlb), vlxu (e.g. vlbu) and vle
  // seperately here because otherwise we cannot distinguish
  // which intrinsic the user actually calls when lowering pseudos.
  def int_riscv_xvlb : XVUSLoad;
  def int_riscv_xvlh : XVUSLoad;
  def int_riscv_xvlw : XVUSLoad;
  def int_riscv_xvle : XVUSLoad;
  def int_riscv_xvlbu : XVUSLoad;
  def int_riscv_xvlhu : XVUSLoad;
  def int_riscv_xvlwu : XVUSLoad;
  def int_riscv_xvlb_mask : XVUSLoadMasked;
  def int_riscv_xvlh_mask : XVUSLoadMasked;
  def int_riscv_xvlw_mask : XVUSLoadMasked;
  def int_riscv_xvle_mask : XVUSLoadMasked;
  def int_riscv_xvlbu_mask : XVUSLoadMasked;
  def int_riscv_xvlhu_mask : XVUSLoadMasked;
  def int_riscv_xvlwu_mask : XVUSLoadMasked;

  def int_riscv_xvsb : XVUSStore;
  def int_riscv_xvsh : XVUSStore;
  def int_riscv_xvsw : XVUSStore;
  def int_riscv_xvse : XVUSStore;
  def int_riscv_xvsb_mask : XVUSStoreMasked;
  def int_riscv_xvsh_mask : XVUSStoreMasked;
  def int_riscv_xvsw_mask : XVUSStoreMasked;
  def int_riscv_xvse_mask : XVUSStoreMasked;

  // 7.5 Vector Strided Instructions
  // For strided load with passthru operand
  // Input: (maskedoff, pointer, strided, vl)
  class XVSLoad
    : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, llvm_ptr_ty,
                 llvm_anyint_ty, LLVMMatchType<1>],
                [NoCapture<ArgIndex<1>>, IntrReadMem]>, RISCVVIntrinsic {
    let VLOperand = 3;
  }

  // For strided load with mask
  // Input: (maskedoff, pointer, stride, mask, vl)
  class XVSLoadMasked
    : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                [LLVMMatchType<0>, llvm_ptr_ty, llvm_anyint_ty,
                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, LLVMMatchType<1>],
                [NoCapture<ArgIndex<1>>, IntrReadMem]>,
                RISCVVIntrinsic {
    let VLOperand = 4;
  }

  // For strided store
  // Input: (vector_in, pointer, stride, vl)
  class XVSStore
        : DefaultAttrsIntrinsic<[],
                    [llvm_anyvector_ty, llvm_ptr_ty,
                     llvm_anyint_ty, LLVMMatchType<1>],
                    [NoCapture<ArgIndex<1>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = 3;
  }
  // For stride store with mask
  // Input: (vector_in, pointer, stirde, mask, vl)
  class XVSStoreMasked
        : DefaultAttrsIntrinsic<[],
                    [llvm_anyvector_ty, llvm_ptr_ty, llvm_anyint_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, LLVMMatchType<1>],
                    [NoCapture<ArgIndex<1>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = 4;
  }

  def int_riscv_xvlsb : XVSLoad;
  def int_riscv_xvlsh : XVSLoad;
  def int_riscv_xvlsw : XVSLoad;
  def int_riscv_xvlse : XVSLoad;
  def int_riscv_xvlsbu : XVSLoad;
  def int_riscv_xvlshu : XVSLoad;
  def int_riscv_xvlswu : XVSLoad;
  def int_riscv_xvlsb_mask : XVSLoadMasked;
  def int_riscv_xvlsh_mask : XVSLoadMasked;
  def int_riscv_xvlsw_mask : XVSLoadMasked;
  def int_riscv_xvlse_mask : XVSLoadMasked;
  def int_riscv_xvlsbu_mask : XVSLoadMasked;
  def int_riscv_xvlshu_mask : XVSLoadMasked;
  def int_riscv_xvlswu_mask : XVSLoadMasked;

  def int_riscv_xvssb : XVSStore;
  def int_riscv_xvssh : XVSStore;
  def int_riscv_xvssw : XVSStore;
  def int_riscv_xvsse : XVSStore;
  def int_riscv_xvssb_mask : XVSStoreMasked;
  def int_riscv_xvssh_mask : XVSStoreMasked;
  def int_riscv_xvssw_mask : XVSStoreMasked;
  def int_riscv_xvsse_mask : XVSStoreMasked;
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

let TargetPrefix = "riscv" in {
  // 12. Vector Integer Arithmetic Instructions
  defm xvadd : RISCVBinaryAAX;
} // TargetPrefix = "riscv"

let TargetPrefix = "riscv" in {
  // 12.14. Vector Integer Merge and Move Instructions
  // Output: (vector)
  // Input: (passthru, vector_in, vl)
  def int_riscv_xvmv_v_v : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                                                 [LLVMMatchType<0>,
                                                  LLVMMatchType<0>,
                                                  llvm_anyint_ty],
                                                 [IntrNoMem]>, RISCVVIntrinsic {
    let VLOperand = 2;
  }
} // TargetPrefix = "riscv"
