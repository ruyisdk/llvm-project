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

defvar NFList = [2, 3, 4, 5, 6, 7, 8];

let TargetPrefix = "riscv" in {
  // 6. Configuration-Setting and Utility
  def int_riscv_th_vsetvl    : Intrinsic<[llvm_anyint_ty],
                                         [/* AVL */ LLVMMatchType<0>,
                                          /* SEW */ LLVMMatchType<0>,
                                          /* LMUL */ LLVMMatchType<0>
                                         ],
                                         [IntrNoMem,
                                          ImmArg<ArgIndex<1>>,
                                          ImmArg<ArgIndex<2>>
                                         ]>;
  def int_riscv_th_vsetvlmax : Intrinsic<[llvm_anyint_ty],
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
  def int_riscv_th_vlb : XVUSLoad;
  def int_riscv_th_vlh : XVUSLoad;
  def int_riscv_th_vlw : XVUSLoad;
  def int_riscv_th_vle : XVUSLoad;
  def int_riscv_th_vlbu : XVUSLoad;
  def int_riscv_th_vlhu : XVUSLoad;
  def int_riscv_th_vlwu : XVUSLoad;
  def int_riscv_th_vlb_mask : XVUSLoadMasked;
  def int_riscv_th_vlh_mask : XVUSLoadMasked;
  def int_riscv_th_vlw_mask : XVUSLoadMasked;
  def int_riscv_th_vle_mask : XVUSLoadMasked;
  def int_riscv_th_vlbu_mask : XVUSLoadMasked;
  def int_riscv_th_vlhu_mask : XVUSLoadMasked;
  def int_riscv_th_vlwu_mask : XVUSLoadMasked;

  def int_riscv_th_vsb : XVUSStore;
  def int_riscv_th_vsh : XVUSStore;
  def int_riscv_th_vsw : XVUSStore;
  def int_riscv_th_vse : XVUSStore;
  def int_riscv_th_vsb_mask : XVUSStoreMasked;
  def int_riscv_th_vsh_mask : XVUSStoreMasked;
  def int_riscv_th_vsw_mask : XVUSStoreMasked;
  def int_riscv_th_vse_mask : XVUSStoreMasked;

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

  def int_riscv_th_vlsb : XVSLoad;
  def int_riscv_th_vlsh : XVSLoad;
  def int_riscv_th_vlsw : XVSLoad;
  def int_riscv_th_vlse : XVSLoad;
  def int_riscv_th_vlsbu : XVSLoad;
  def int_riscv_th_vlshu : XVSLoad;
  def int_riscv_th_vlswu : XVSLoad;
  def int_riscv_th_vlsb_mask : XVSLoadMasked;
  def int_riscv_th_vlsh_mask : XVSLoadMasked;
  def int_riscv_th_vlsw_mask : XVSLoadMasked;
  def int_riscv_th_vlse_mask : XVSLoadMasked;
  def int_riscv_th_vlsbu_mask : XVSLoadMasked;
  def int_riscv_th_vlshu_mask : XVSLoadMasked;
  def int_riscv_th_vlswu_mask : XVSLoadMasked;

  def int_riscv_th_vssb : XVSStore;
  def int_riscv_th_vssh : XVSStore;
  def int_riscv_th_vssw : XVSStore;
  def int_riscv_th_vsse : XVSStore;
  def int_riscv_th_vssb_mask : XVSStoreMasked;
  def int_riscv_th_vssh_mask : XVSStoreMasked;
  def int_riscv_th_vssw_mask : XVSStoreMasked;
  def int_riscv_th_vsse_mask : XVSStoreMasked;

  // 7.6. Vector Indexed Instructions
  // For indexed load with passthru operand
  // Input: (passthru, pointer, index, vl)
  class XVILoad
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                    [LLVMMatchType<0>, llvm_ptr_ty,
                     llvm_anyvector_ty, llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrReadMem]>, RISCVVIntrinsic {
    let VLOperand = 3;
  }
  // For indexed load with mask
  // Input: (maskedoff, pointer, index, mask, vl)
  class XVILoadMasked
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                    [LLVMMatchType<0>, llvm_ptr_ty, llvm_anyvector_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrReadMem]>,
                    RISCVVIntrinsic {
    let VLOperand = 4;
  }

  // For indexed store
  // Input: (vector_in, pointer, index, vl)
  class XVIStore
        : DefaultAttrsIntrinsic<[],
                    [llvm_anyvector_ty, llvm_ptr_ty,
                     llvm_anyvector_ty, llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = 3;
  }
  // For indexed store with mask
  // Input: (vector_in, pointer, index, mask, vl)
  class XVIStoreMasked
        : DefaultAttrsIntrinsic<[],
                    [llvm_anyvector_ty, llvm_ptr_ty, llvm_anyvector_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                    [NoCapture<ArgIndex<1>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = 4;
  }

  def int_riscv_th_vlxb : XVILoad;
  def int_riscv_th_vlxh : XVILoad;
  def int_riscv_th_vlxw : XVILoad;
  def int_riscv_th_vlxe : XVILoad;
  def int_riscv_th_vlxbu : XVILoad;
  def int_riscv_th_vlxhu : XVILoad;
  def int_riscv_th_vlxwu : XVILoad;
  def int_riscv_th_vlxb_mask : XVILoadMasked;
  def int_riscv_th_vlxh_mask : XVILoadMasked;
  def int_riscv_th_vlxw_mask : XVILoadMasked;
  def int_riscv_th_vlxe_mask : XVILoadMasked;
  def int_riscv_th_vlxbu_mask : XVILoadMasked;
  def int_riscv_th_vlxhu_mask : XVILoadMasked;
  def int_riscv_th_vlxwu_mask : XVILoadMasked;

  def int_riscv_th_vsxb : XVIStore;
  def int_riscv_th_vsxh : XVIStore;
  def int_riscv_th_vsxw : XVIStore;
  def int_riscv_th_vsxe : XVIStore;
  def int_riscv_th_vsxb_mask : XVIStoreMasked;
  def int_riscv_th_vsxh_mask : XVIStoreMasked;
  def int_riscv_th_vsxw_mask : XVIStoreMasked;
  def int_riscv_th_vsxe_mask : XVIStoreMasked;

  // 7.7 Unit-Stride Fault-only-first Loads
  // For unit stride fault-only-first load without mask
  // Input: (passthru, pointer, vl)
  // Output: (data, vl)
  // NOTE: We model this with default memory properties since we model writing
  // VL as a side effect. IntrReadMem, IntrHasSideEffects does not work.
  class XVUSLoadFF
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty, llvm_anyint_ty],
                    [LLVMMatchType<0>, llvm_ptr_ty, LLVMMatchType<1>],
                    [NoCapture<ArgIndex<1>>]>,
                    RISCVVIntrinsic {
    let VLOperand = 2;
  }

  // For unit stride fault-only-first load with mask
  // Input: (maskedoff, pointer, mask, vl)
  // Output: (data, vl)
  // NOTE: We model this with default memory properties since we model writing
  // VL as a side effect. IntrReadMem, IntrHasSideEffects does not work.
  class XVUSLoadFFMasked
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty, llvm_anyint_ty],
                    [LLVMMatchType<0>, llvm_ptr_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                     LLVMMatchType<1>],
                    [NoCapture<ArgIndex<1>>]>, RISCVVIntrinsic {
    let VLOperand = 3;
  }

  def int_riscv_th_vleff : XVUSLoadFF;
  def int_riscv_th_vleff_mask : XVUSLoadFFMasked;

  // 7.8.1 Vector Unit-Stride Segment Loads and Stores
  // For unit stride segment load
  class XVUSSegLoad<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1))),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                                [llvm_ptr_ty, llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrReadMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 1);
  }
  // For unit stride segment load with mask
  class XVUSSegLoadMasked<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1))),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                                [llvm_ptr_ty,
                                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                                 llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrReadMem]>,
                    RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }

  // For unit stride segment store
  class XVUSSegStore<int nf>
        : DefaultAttrsIntrinsic<[],
                    !listconcat([llvm_anyvector_ty],
                                !listsplat(LLVMMatchType<0>, !add(nf, -1)),
                                [llvm_ptr_ty, llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 1);
  }
  // For unit stride masked segment store
  class XVUSSegStoreMasked<int nf>
        : DefaultAttrsIntrinsic<[],
                    !listconcat([llvm_anyvector_ty],
                                !listsplat(LLVMMatchType<0>, !add(nf, -1)),
                                [llvm_ptr_ty,
                                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                                 llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }

  multiclass XVUSSegLoad<int nf> {
    def "int_riscv_th_" # NAME : XVUSSegLoad<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVUSSegLoadMasked<nf>;
  }

  multiclass XVUSSegStore<int nf> {
    def "int_riscv_th_" # NAME : XVUSSegStore<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVUSSegStoreMasked<nf>;
  }

  foreach nf = NFList in {
    defm "vlseg" # nf # "b" : XVUSSegLoad<nf>;
    defm "vlseg" # nf # "bu" : XVUSSegLoad<nf>;
    defm "vlseg" # nf # "h" : XVUSSegLoad<nf>;
    defm "vlseg" # nf # "hu" : XVUSSegLoad<nf>;
    defm "vlseg" # nf # "w" : XVUSSegLoad<nf>;
    defm "vlseg" # nf # "wu" : XVUSSegLoad<nf>;
    defm "vlseg" # nf # "e" : XVUSSegLoad<nf>;

    defm "vsseg" # nf # "b" : XVUSSegStore<nf>;
    defm "vsseg" # nf # "h" : XVUSSegStore<nf>;
    defm "vsseg" # nf # "w" : XVUSSegStore<nf>;
    defm "vsseg" # nf # "e" : XVUSSegStore<nf>;
  }

  // 7.8 Unit-Stride Segment Fault-only-first Loads
  // Input: (passthru, pointer, vl)
  // Output: (data, vl)
  // NOTE: We model this with default memory properties since we model writing
  // VL as a side effect. IntrReadMem, IntrHasSideEffects does not work.
  class XVUSSegLoadFF<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1)), [llvm_anyint_ty]),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                    [llvm_ptr_ty, LLVMMatchType<1>]),
                    [NoCapture<ArgIndex<nf>>]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 1);
  }
  // For unit stride fault-only-first segment load with mask
  // Input: (maskedoff, pointer, mask, vl)
  // Output: (data, vl)
  // NOTE: We model this with default memory properties since we model writing
  // VL as a side effect. IntrReadMem, IntrHasSideEffects does not work.
  class XVUSSegLoadFFMasked<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1)), [llvm_anyint_ty]),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                     [llvm_ptr_ty,
                      LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                      LLVMMatchType<1>]),
                    [NoCapture<ArgIndex<nf>>]>,
                    RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }

  multiclass XVUSSegLoadFF<int nf> {
    def "int_riscv_th_" # NAME : XVUSSegLoadFF<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVUSSegLoadFFMasked<nf>;
  }

  foreach nf = NFList in {
    defm vlseg # nf # eff : XVUSSegLoadFF<nf>;
  }

  // 7.8.2. Vector Strided Segment Loads and Stores
  // For stride segment load
  // Input: (passthru, pointer, stride, vl)
  class XVSSegLoad<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1))),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                                [llvm_ptr_ty, llvm_anyint_ty, LLVMMatchType<1>]),
                    [NoCapture<ArgIndex<nf>>, IntrReadMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }
  // For stride segment load with mask
  // Input: (maskedoff, pointer, stride, mask, vl)
  class XVSSegLoadMasked<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1))),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                                [llvm_ptr_ty,
                                 llvm_anyint_ty,
                                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                                 LLVMMatchType<1>]),
                    [NoCapture<ArgIndex<nf>>, IntrReadMem]>,
                    RISCVVIntrinsic {
    let VLOperand = !add(nf, 3);
  }

  // For stride segment stores
  // Input: (value, pointer, offset, vl)
  class XVSSegStore<int nf>
        : DefaultAttrsIntrinsic<[],
                    !listconcat([llvm_anyvector_ty],
                                !listsplat(LLVMMatchType<0>, !add(nf, -1)),
                                [llvm_ptr_ty, llvm_anyint_ty,
                                 LLVMMatchType<1>]),
                    [NoCapture<ArgIndex<nf>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }
  // For stride masked segment stores
  // Input: (value, pointer, offset, mask, vl)
  class XVSSegStoreMasked<int nf>
        : DefaultAttrsIntrinsic<[],
                    !listconcat([llvm_anyvector_ty],
                                !listsplat(LLVMMatchType<0>, !add(nf, -1)),
                                [llvm_ptr_ty, llvm_anyint_ty,
                                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                                 LLVMMatchType<1>]),
                    [NoCapture<ArgIndex<nf>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 3);
  }

  multiclass XVSSegLoad<int nf> {
    def "int_riscv_th_" # NAME : XVSSegLoad<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVSSegLoadMasked<nf>;
  }

  multiclass XVSSegStore<int nf> {
    def "int_riscv_th_" # NAME : XVSSegStore<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVSSegStoreMasked<nf>;
  }

  foreach nf = NFList in {
    defm "vlsseg" # nf # "b" : XVSSegLoad<nf>;
    defm "vlsseg" # nf # "bu" : XVSSegLoad<nf>;
    defm "vlsseg" # nf # "h" : XVSSegLoad<nf>;
    defm "vlsseg" # nf # "hu" : XVSSegLoad<nf>;
    defm "vlsseg" # nf # "w" : XVSSegLoad<nf>;
    defm "vlsseg" # nf # "wu" : XVSSegLoad<nf>;
    defm "vlsseg" # nf # "e" : XVSSegLoad<nf>;

    defm "vssseg" # nf # "b" : XVSSegStore<nf>;
    defm "vssseg" # nf # "h" : XVSSegStore<nf>;
    defm "vssseg" # nf # "w" : XVSSegStore<nf>;
    defm "vssseg" # nf # "e" : XVSSegStore<nf>;
  }

  // 7.8.3. Vector Indexed Segment Loads and Stores
  // For indexed segment load
  // Input: (passthru, pointer, index, vl)
  class XVISegLoad<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1))),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                    [llvm_ptr_ty, llvm_anyvector_ty, llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrReadMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }
  // For indexed segment load with mask
  // Input: (maskedoff, pointer, index, mask, vl)
  class XVISegLoadMasked<int nf>
        : DefaultAttrsIntrinsic<!listconcat([llvm_anyvector_ty], !listsplat(LLVMMatchType<0>,
                                !add(nf, -1))),
                    !listconcat(!listsplat(LLVMMatchType<0>, nf),
                                [llvm_ptr_ty,
                                 llvm_anyvector_ty,
                                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                                 llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrReadMem]>,
                    RISCVVIntrinsic {
    let VLOperand = !add(nf, 3);
  }

  // For indexed segment store
  // Input: (value, pointer, offset, vl)
  class XVISegStore<int nf>
        : DefaultAttrsIntrinsic<[],
                    !listconcat([llvm_anyvector_ty],
                                !listsplat(LLVMMatchType<0>, !add(nf, -1)),
                                [llvm_ptr_ty, llvm_anyvector_ty,
                                 llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 2);
  }
  // For indexed segment store with mask
  // Input: (value, pointer, offset, mask, vl)
  class XVISegStoreMasked<int nf>
        : DefaultAttrsIntrinsic<[],
                    !listconcat([llvm_anyvector_ty],
                                !listsplat(LLVMMatchType<0>, !add(nf, -1)),
                                [llvm_ptr_ty, llvm_anyvector_ty,
                                 LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>,
                                 llvm_anyint_ty]),
                    [NoCapture<ArgIndex<nf>>, IntrWriteMem]>, RISCVVIntrinsic {
    let VLOperand = !add(nf, 3);
  }

  multiclass XVISegLoad<int nf> {
    def "int_riscv_th_" # NAME : XVISegLoad<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVISegLoadMasked<nf>;
  }

  multiclass XVISegStore<int nf> {
    def "int_riscv_th_" # NAME : XVISegStore<nf>;
    def "int_riscv_th_" # NAME # "_mask" : XVISegStoreMasked<nf>;
  }

  foreach nf = NFList in {
    defm "vlxseg" # nf # "b" : XVISegLoad<nf>;
    defm "vlxseg" # nf # "bu" : XVISegLoad<nf>;
    defm "vlxseg" # nf # "h" : XVISegLoad<nf>;
    defm "vlxseg" # nf # "hu" : XVISegLoad<nf>;
    defm "vlxseg" # nf # "w" : XVISegLoad<nf>;
    defm "vlxseg" # nf # "wu" : XVISegLoad<nf>;
    defm "vlxseg" # nf # "e" : XVISegLoad<nf>;

    defm "vsxseg" # nf # "b" : XVISegStore<nf>;
    defm "vsxseg" # nf # "h" : XVISegStore<nf>;
    defm "vsxseg" # nf # "w" : XVISegStore<nf>;
    defm "vsxseg" # nf # "e" : XVISegStore<nf>;
  }
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

  defm th_vamoswap : XIntrinsicVAMO;
  defm th_vamoadd  : XIntrinsicVAMO;
  defm th_vamoxor  : XIntrinsicVAMO;
  defm th_vamoand  : XIntrinsicVAMO;
  defm th_vamoor   : XIntrinsicVAMO;
  defm th_vamomin  : XIntrinsicVAMO;
  defm th_vamomax  : XIntrinsicVAMO;
  defm th_vamominu : XIntrinsicVAMO;
  defm th_vamomaxu : XIntrinsicVAMO;
} // TargetPrefix = "riscv"

let TargetPrefix = "riscv" in {
  // For destination vector type is the same as
  // first source vector (with mask but no policy).
  // Input: (maskedoff, vector_in, vector_in/scalar_in, mask, vl)
  class XVBinaryAAXMasked
       : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                   [LLVMMatchType<0>, LLVMMatchType<0>, llvm_any_ty,
                    LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                   [IntrNoMem]>, RISCVVIntrinsic {
    let ScalarOperand = 2;
    let VLOperand = 4;
  }

  // For destination vector type is NOT the same as
  // first source vector (with mask but no policy).
  // Input: (maskedoff, vector_in, vector_in/scalar_in, mask, vl)
  class XVBinaryABXMasked
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                    [LLVMMatchType<0>, llvm_anyvector_ty, llvm_any_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                    [IntrNoMem]>, RISCVVIntrinsic {
    let ScalarOperand = 2;
    let VLOperand = 4;
  }

  // For destination vector type is the same as
  // first source vector (with mask but no policy).
  // The second source operand must match the destination type or be an XLen scalar.
  // Input: (maskedoff, vector_in, vector_in/scalar_in, mask, vl)
  class XVBinaryAAShiftMasked
       : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                   [LLVMMatchType<0>, LLVMMatchType<0>, llvm_any_ty,
                    LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                   [IntrNoMem]>, RISCVVIntrinsic {
    let VLOperand = 4;
  }

  // For destination vector type is the same as
  // first source vector (with mask but no policy).
  // The second source operand must match the destination type or be an XLen scalar.
  // Input: (maskedoff, vector_in, vector_in/scalar_in, mask, vl)
  class XVBinaryABShiftMasked
        : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                    [LLVMMatchType<0>, llvm_anyvector_ty, llvm_any_ty,
                     LLVMScalarOrSameVectorWidth<0, llvm_i1_ty>, llvm_anyint_ty],
                    [IntrNoMem]>, RISCVVIntrinsic {
    let VLOperand = 4;
  }

  multiclass XVBinaryAAX {
    def "int_riscv_" # NAME : RISCVBinaryAAXUnMasked;
    def "int_riscv_" # NAME # "_mask" : XVBinaryAAXMasked;
  }

  multiclass XVBinaryABX {
    def "int_riscv_" # NAME : RISCVBinaryABXUnMasked;
    def "int_riscv_" # NAME # "_mask" : XVBinaryABXMasked;
  }

  multiclass XVBinaryAAShift {
    def "int_riscv_" # NAME : RISCVBinaryAAShiftUnMasked;
    def "int_riscv_" # NAME # "_mask" : XVBinaryAAShiftMasked;
  }

  multiclass XVBinaryABShift {
    def "int_riscv_" # NAME : RISCVBinaryABShiftUnMasked;
    def "int_riscv_" # NAME # "_mask" : XVBinaryABShiftMasked;
  }
}

let TargetPrefix = "riscv" in {
  // 12. Vector Integer Arithmetic Instructions
  // 12.1. Vector Single-Width Integer Add and Subtract
  defm th_vadd : XVBinaryAAX;
  defm th_vsub : XVBinaryAAX;
  defm th_vrsub : XVBinaryAAX;

  // 12.2. Vector Widening Integer Add/Subtract
  defm th_vwaddu : XVBinaryABX;
  defm th_vwadd : XVBinaryABX;
  defm th_vwaddu_w : XVBinaryAAX;
  defm th_vwadd_w : XVBinaryAAX;
  defm th_vwsubu : XVBinaryABX;
  defm th_vwsub : XVBinaryABX;
  defm th_vwsubu_w : XVBinaryAAX;
  defm th_vwsub_w : XVBinaryAAX;

  // 12.3. Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions
  defm th_vadc : RISCVBinaryWithV0;
  defm th_vmadc_carry_in : RISCVBinaryMaskOutWithV0;
  defm th_vsbc : RISCVBinaryWithV0;
  defm th_vmsbc_borrow_in : RISCVBinaryMaskOutWithV0;

  // 12.4. Vector Single-Width Integer Add and Subtract
  defm th_vand : XVBinaryAAX;
  defm th_vor : XVBinaryAAX;
  defm th_vxor : XVBinaryAAX;

  // 12.5. Vector Single-Width Bit Shift Instructions
  defm th_vsll : XVBinaryAAShift;
  defm th_vsrl : XVBinaryAAShift;
  defm th_vsra : XVBinaryAAShift;

  // 12.6. Vector Narrowing Integer Right Shift Instructions
  defm th_vnsrl : XVBinaryABShift;
  defm th_vnsra : XVBinaryABShift;
} // TargetPrefix = "riscv"

let TargetPrefix = "riscv" in {
  // 12.14. Vector Integer Merge and Move Instructions
  // Output: (vector)
  // Input: (passthru, vector_in, vl)
  def int_riscv_th_vmv_v_v : DefaultAttrsIntrinsic<[llvm_anyvector_ty],
                                                   [LLVMMatchType<0>,
                                                    LLVMMatchType<0>,
                                                    llvm_anyint_ty],
                                                   [IntrNoMem]>, RISCVVIntrinsic {
    let VLOperand = 2;
  }
} // TargetPrefix = "riscv"
