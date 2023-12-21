//===-- RISCVInstrInfoXTHeadVPseudos.td - RISC-V 'V' Pseudos -----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------------===//
///
/// This file contains the required infrastructure to support code generation
/// for the standard 'V' (Vector) extension, version 0.7.1
///
/// This file is included from RISCVInstrInfoXTHeadV.td

//===----------------------------------------------------------------------===//
// Register definitions, helper functions, etc.
//===----------------------------------------------------------------------===//

// Used to iterate over all possible LMULs in RVV 0.7.1
defvar MxListXTHeadV = [V_M1, V_M2, V_M4, V_M8];

// Redefine `AllIntegerVectors` from RISCVInstrInfoVPseudos.td to remove fractionally-grouped register groups
// like MF2, MF4, MF8, which are not supported by the 'V' extension 0.7.1.
defset list<VTypeInfo> AllXVectors = {
  defset list<VTypeInfo> AllIntegerXVectors = {
    defset list<VTypeInfo> NoGroupIntegerXVectors = {
      def XVI8M1:  VTypeInfo<vint8m1_t,  vbool8_t,   8, VR, V_M1>;
      def XVI16M1: VTypeInfo<vint16m1_t, vbool16_t, 16, VR, V_M1>;
      def XVI32M1: VTypeInfo<vint32m1_t, vbool32_t, 32, VR, V_M1>;
      def XVI64M1: VTypeInfo<vint64m1_t, vbool64_t, 64, VR, V_M1>;
    }
    defset list<GroupVTypeInfo> GroupIntegerXVectors = {
      def XVI8M2: GroupVTypeInfo<vint8m2_t, vint8m1_t, vbool4_t, 8, VRM2, V_M2>;
      def XVI8M4: GroupVTypeInfo<vint8m4_t, vint8m1_t, vbool2_t, 8, VRM4, V_M4>;
      def XVI8M8: GroupVTypeInfo<vint8m8_t, vint8m1_t, vbool1_t, 8, VRM8, V_M8>;

      def XVI16M2: GroupVTypeInfo<vint16m2_t, vint16m1_t, vbool8_t, 16, VRM2, V_M2>;
      def XVI16M4: GroupVTypeInfo<vint16m4_t, vint16m1_t, vbool4_t, 16, VRM4, V_M4>;
      def XVI16M8: GroupVTypeInfo<vint16m8_t, vint16m1_t, vbool2_t, 16, VRM8, V_M8>;

      def XVI32M2: GroupVTypeInfo<vint32m2_t, vint32m1_t, vbool16_t,32, VRM2, V_M2>;
      def XVI32M4: GroupVTypeInfo<vint32m4_t, vint32m1_t, vbool8_t, 32, VRM4, V_M4>;
      def XVI32M8: GroupVTypeInfo<vint32m8_t, vint32m1_t, vbool4_t, 32, VRM8, V_M8>;

      def XVI64M2: GroupVTypeInfo<vint64m2_t, vint64m1_t, vbool32_t,64, VRM2, V_M2>;
      def XVI64M4: GroupVTypeInfo<vint64m4_t, vint64m1_t, vbool16_t,64, VRM4, V_M4>;
      def XVI64M8: GroupVTypeInfo<vint64m8_t, vint64m1_t, vbool8_t, 64, VRM8, V_M8>;
    }
  }

  defset list<VTypeInfo> AllFloatXVectors = {
    defset list<VTypeInfo> NoGroupFloatXVectors = {
      def XVF16M1:  VTypeInfo<vfloat16m1_t, vbool16_t, 16, VR, V_M1, f16, FPR16>;
      def XVF32M1:  VTypeInfo<vfloat32m1_t, vbool32_t, 32, VR, V_M1, f32, FPR32>;
      def XVF64M1:  VTypeInfo<vfloat64m1_t, vbool64_t, 64, VR, V_M1, f64, FPR64>;
    }

    defset list<GroupVTypeInfo> GroupFloatXVectors = {
      def XVF16M2: GroupVTypeInfo<vfloat16m2_t, vfloat16m1_t, vbool8_t, 16,
                                  VRM2, V_M2, f16, FPR16>;
      def XVF16M4: GroupVTypeInfo<vfloat16m4_t, vfloat16m1_t, vbool4_t, 16,
                                  VRM4, V_M4, f16, FPR16>;
      def XVF16M8: GroupVTypeInfo<vfloat16m8_t, vfloat16m1_t, vbool2_t, 16,
                                  VRM8, V_M8, f16, FPR16>;

      def XVF32M2: GroupVTypeInfo<vfloat32m2_t, vfloat32m1_t, vbool16_t, 32,
                                  VRM2, V_M2, f32, FPR32>;
      def XVF32M4: GroupVTypeInfo<vfloat32m4_t, vfloat32m1_t, vbool8_t,  32,
                                  VRM4, V_M4, f32, FPR32>;
      def XVF32M8: GroupVTypeInfo<vfloat32m8_t, vfloat32m1_t, vbool4_t,  32,
                                  VRM8, V_M8, f32, FPR32>;

      def XVF64M2: GroupVTypeInfo<vfloat64m2_t, vfloat64m1_t, vbool32_t, 64,
                                  VRM2, V_M2, f64, FPR64>;
      def XVF64M4: GroupVTypeInfo<vfloat64m4_t, vfloat64m1_t, vbool16_t, 64,
                                  VRM4, V_M4, f64, FPR64>;
      def XVF64M8: GroupVTypeInfo<vfloat64m8_t, vfloat64m1_t, vbool8_t,  64,
                                  VRM8, V_M8, f64, FPR64>;
    }
  }
}

class GetXVTypePredicates<VTypeInfo vti> {
  // TODO: distinguish different types (like F16, F32, F64, AnyF)? Is it needed?
  list<Predicate> Predicates = !cond(!eq(vti.Scalar, f16) : [HasVendorXTHeadV],
                                     !eq(vti.Scalar, f32) : [HasVendorXTHeadV],
                                     !eq(vti.Scalar, f64) : [HasVendorXTHeadV],
                                     !eq(vti.SEW, 64) : [HasVendorXTHeadV],
                                     true : [HasVendorXTHeadV]);
}

class XTHeadVVL<bit M, bit ST, bit I, bit F, bit U, bit E,
                bits<3> ME, bits<3> S, bits<3> L> {
  bits<1> Masked = M;
  bits<1> Strided = ST;
  bits<1> Indexed = I;
  bits<1> FF = F;
  bits<1> Unsigned = U;
  bits<1> IsE = E;
  bits<3> Log2MEM = ME;
  bits<3> Log2SEW = S;
  bits<3> LMUL = L;
  Pseudo Pseudo = !cast<Pseudo>(NAME);
}

def XTHeadVVLTable : GenericTable {
  let FilterClass = "XTHeadVVL";
  let CppTypeName = "TH_VLPseudo";
  let Fields = ["Masked", "Strided", "Indexed", "FF", "Unsigned",
                "IsE", "Log2MEM", "Log2SEW", "LMUL", "Pseudo"];
  let PrimaryKey = ["Masked", "Strided", "Indexed", "FF", "Unsigned",
                    "IsE", "Log2MEM", "Log2SEW", "LMUL"];
  let PrimaryKeyName = "getTH_VLPseudo";
}

class XTHeadVVS<bit M, bit ST, bit I, bit E, bits<3> ME, bits<3> S, bits<3> L> {
  bits<1> Masked = M;
  bits<1> Strided = ST;
  bits<1> Indexed = I;
  bits<1> IsE = E;
  bits<3> Log2MEM = ME;
  bits<3> Log2SEW = S;
  bits<3> LMUL = L;
  Pseudo Pseudo = !cast<Pseudo>(NAME);
}

def XTHeadVVSTable : GenericTable {
  let FilterClass = "XTHeadVVS";
  let CppTypeName = "TH_VSPseudo";
  let Fields = ["Masked", "Strided", "Indexed", "IsE",
                "Log2MEM", "Log2SEW", "LMUL", "Pseudo"];
  let PrimaryKey = ["Masked", "Strided", "Indexed", "IsE",
                    "Log2MEM", "Log2SEW", "LMUL"];
  let PrimaryKeyName = "getTH_VSPseudo";
}

class XTHeadVVLSEG<bits<4> N, bit M, bit ST, bit F, bit U, bit E,
                   bits<3> ME, bits<3> S, bits<3> L> {
  bits<4> NF = N;
  bits<1> Masked = M;
  bits<1> Strided = ST;
  bits<1> FF = F;
  bits<1> Unsigned = U;
  bits<1> IsE = E;
  bits<3> Log2MEM = ME;
  bits<3> Log2SEW = S;
  bits<3> LMUL = L;
  Pseudo Pseudo = !cast<Pseudo>(NAME);
}

def XTHeadVVLSEGTable : GenericTable {
  let FilterClass = "XTHeadVVLSEG";
  let CppTypeName = "TH_VLSEGPseudo";
  let Fields = ["NF", "Masked", "Strided", "FF", "Unsigned", "IsE",
                "Log2MEM", "Log2SEW", "LMUL", "Pseudo"];
  let PrimaryKey = ["NF", "Masked", "Strided", "FF", "Unsigned", "IsE",
                    "Log2MEM", "Log2SEW", "LMUL"];
  let PrimaryKeyName = "getTH_VLSEGPseudo";
}

class XTHeadVVSSEG<bits<4> N, bit M, bit ST, bit E,
                   bits<3> ME, bits<3> S, bits<3> L> {
  bits<4> NF = N;
  bits<1> Masked = M;
  bits<1> Strided = ST;
  bits<1> IsE = E;
  bits<3> Log2MEM = ME;
  bits<3> Log2SEW = S;
  bits<3> LMUL = L;
  Pseudo Pseudo = !cast<Pseudo>(NAME);
}

def XTHeadVVSSEGTable : GenericTable {
  let FilterClass = "XTHeadVVSSEG";
  let CppTypeName = "TH_VSSEGPseudo";
  let Fields = ["NF", "Masked", "Strided", "IsE", "Log2MEM", "Log2SEW", "LMUL", "Pseudo"];
  let PrimaryKey = ["NF", "Masked", "Strided", "IsE", "Log2MEM", "Log2SEW", "LMUL"];
  let PrimaryKeyName = "getTH_VSSEGPseudo";
}

//===----------------------------------------------------------------------===//
// The following code defines the pseudo instructions and their patterns.
// 1. "Pseudos" are defined in the same way as normal instructions, except they
// start with the prefix "Pseudo".  Pseudo instructions are expanded to MC
// instructions in the `RISCVExpandPseudoInsts.cpp` file.
// 2. "Patterns" tell LLVM how to lower intrinsic calls to pseudos or MC instructions.
// If an intrinsic call is lowered to a pseudo, the pseudo is then expanded
// to MC instructions as described above.
//
// Some intrinsics may be lowered manually (for example, `RSICVISelDAGToDAG.cpp`).
// Patterns are not needed for these instructions, like
// `int_riscv_th_vsetvl` and `int_riscv_th_vsetvlmax` in `IntrinsicRISCVXTHeadV.td`.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// 6. Configuration-Setting Instructions
//===----------------------------------------------------------------------===//

// These can't be reused, since the vtypei in rvv 0.7 differs from the one in rvv 1.0
let Predicates = [HasVendorXTHeadV] in {
  let hasSideEffects = 1, mayLoad = 0, mayStore = 0, Defs = [VL, VTYPE] in {
    def PseudoTH_VSETVLI : Pseudo<(outs GPR:$rd), (ins GPRNoX0:$rs1, XTHeadVTypeI:$vtypei), []>,
                           Sched<[WriteVSETVLI, ReadVSETVLI]>;
    def PseudoTH_VSETVLIX0 : Pseudo<(outs GPR:$rd), (ins GPRX0:$rs1, XTHeadVTypeI:$vtypei), []>,
                             Sched<[WriteVSETVLI, ReadVSETVLI]>;
  }
} // Predicates = [HasVendorXTHeadV]

//===----------------------------------------------------------------------===//
// 7. Vector Loads and Stores
//===----------------------------------------------------------------------===//

class MemBitsToTag<int mem> {
  string ret = !cond(!eq(mem, 8)  : "B",
                     !eq(mem, 16) : "H",
                     !eq(mem, 32) : "W",
                     true         : "E");
}

// 7.4 Vector Unit-Stride Instructions
class XVPseudoUSLoadNoMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e> :
      Pseudo<(outs RetClass:$rd),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/0, /*Strided*/0, /*Indexed*/0, /*FF*/0,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoUSLoadMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e> :
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
              (ins GetVRegNoV0<RetClass>.R:$merge,
                   GPRMemZeroOffset:$rs1,
                   VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/1, /*Strided*/0, /*Indexed*/0, /*FF*/0, unsigned, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "$rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoUSStoreNoMask<VReg StClass, int MEM, int REG, bit e>:
      Pseudo<(outs),
              (ins StClass:$rd, GPRMemZeroOffset:$rs1, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVS</*Masked*/0, /*Strided*/0, /*Indexed*/0, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoUSStoreMask<VReg StClass, int MEM, int REG, int e>:
      Pseudo<(outs),
              (ins StClass:$rd, GPRMemZeroOffset:$rs1, VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVS</*Masked*/1, /*Strided*/0, /*Indexed*/0, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoUSLoad {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          // The destination register element must be wider
          // than the memory element (7.3 in RVV spec 0.7.1).
          let VLMul = lmul.value, SEW = mem in {
            def tag # "_V_E" # reg # "_" # LInfo :
              XVPseudoUSLoadNoMask<vreg, mem, reg, 0, 0>,
              VLESched<LInfo>;
            def tag # "U_V_E" # reg # "_" # LInfo :
              XVPseudoUSLoadNoMask<vreg, mem, reg, 1, 0>,
              VLESched<LInfo>;
            def tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoUSLoadMask<vreg, mem, reg, 0, 0>,
              RISCVMaskedPseudo<MaskIdx=2>,
              VLESched<LInfo>;
            def tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoUSLoadMask<vreg, mem, reg, 1, 0>,
              RISCVMaskedPseudo<MaskIdx=2>,
              VLESched<LInfo>;
          }
        }
      }
    }
  }
  // For VLE, whose mem bits and reg bits is both SEW
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "E_V_E" # eew # "_" # LInfo :
          XVPseudoUSLoadNoMask<vreg, eew, eew, 0, 1>,
          VLESched<LInfo>;
        def "E_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoUSLoadMask<vreg, eew, eew, 0, 1>,
          RISCVMaskedPseudo<MaskIdx=2>,
          VLESched<LInfo>;
      }
    }
  }
}

multiclass XVPseudoUSStore {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach sew = EEWList in {
        let VLMul = lmul.value, SEW = mem in {
          // There is no 'unsigned store' in RVV 0.7.1
          def tag # "_V_E" # sew # "_" # LInfo :
            XVPseudoUSStoreNoMask<vreg, mem, sew, 0>,
            VSESched<LInfo>;
          def tag # "_V_E" # sew # "_" # LInfo # "_MASK" :
            XVPseudoUSStoreMask<vreg, mem, sew, 0>,
            VSESched<LInfo>;
        }
      }
    }
  }
  // For VSE, whose mem bits and reg bits is both SEW
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "E_V_E" # eew # "_" # LInfo :
          XVPseudoUSStoreNoMask<vreg, eew, eew, 1>,
          VSESched<LInfo>;
        def "E_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoUSStoreMask<vreg, eew, eew, 1>,
          VSESched<LInfo>;
      }
    }
  }
}

// 7.5 Vector Strided Instructions
class XVPseudoSLoadNoMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e>:
      Pseudo<(outs RetClass:$rd),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, GPR:$rs2, AVL:$vl,
                  ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/0, /*Strided*/1, /*Indexed*/0, /*FF*/0,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoSLoadMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e>:
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
              (ins GetVRegNoV0<RetClass>.R:$merge,
                   GPRMemZeroOffset:$rs1, GPR:$rs2,
                   VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/1, /*Strided*/1, /*Indexed*/0, /*FF*/0,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "$rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoSStoreNoMask<VReg StClass, int MEM, int REG, bit e>:
      Pseudo<(outs),
              (ins StClass:$rd, GPRMemZeroOffset:$rs1, GPR:$rs2, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVS</*Masked*/0, /*Strided*/1, /*Indexed*/0, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoSStoreMask<VReg StClass, int MEM, int REG, int e>:
      Pseudo<(outs),
              (ins StClass:$rd, GPRMemZeroOffset:$rs1, GPR:$rs2, VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVS</*Masked*/1, /*Strided*/1, /*Indexed*/0, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoSLoad {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            def "S" # tag # "_V_E" # reg # "_" # LInfo :
              XVPseudoSLoadNoMask<vreg, mem, reg, 0, 0>,
              VLESched<LInfo>;
            def "S" # tag # "U_V_E" # reg # "_" # LInfo :
              XVPseudoSLoadNoMask<vreg, mem, reg, 1, 0>,
              VLESched<LInfo>;
            def "S" # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoSLoadMask<vreg, mem, reg, 0, 0>,
              RISCVMaskedPseudo<MaskIdx=3>,
              VLESched<LInfo>;
            def "S" # tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoSLoadMask<vreg, mem, reg, 1, 0>,
              RISCVMaskedPseudo<MaskIdx=3>,
              VLESched<LInfo>;
          }
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "SE_V_E" # eew # "_" # LInfo :
          XVPseudoSLoadNoMask<vreg, eew, eew, 0, 1>,
          VLESched<LInfo>;
        def "SE_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoSLoadMask<vreg, eew, eew, 0, 1>,
          RISCVMaskedPseudo<MaskIdx=3>,
          VLESched<LInfo>;
      }
    }
  }
}

multiclass XVPseudoSStore {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach sew = EEWList in {
        let VLMul = lmul.value, SEW = mem in {
          def "S" # tag # "_V_E" # sew # "_" # LInfo :
            XVPseudoSStoreNoMask<vreg, mem, sew, 0>,
            VSESched<LInfo>;
          def "S" # tag # "_V_E" # sew # "_" # LInfo # "_MASK" :
            XVPseudoSStoreMask<vreg, mem, sew, 0>,
            VSESched<LInfo>;
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "SE_V_E" # eew # "_" # LInfo :
          XVPseudoSStoreNoMask<vreg, eew, eew, 1>,
          VSESched<LInfo>;
        def "SE_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoSStoreMask<vreg, eew, eew, 1>,
          VSESched<LInfo>;
      }
    }
  }
}

// 7.6 Vector Indexed Instructions
class XVPseudoILoadNoMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e>:
      Pseudo<(outs RetClass:$rd),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, RetClass:$rs2,
              AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/0, /*Strided*/0, /*Indexed*/1, /*FF*/0,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoILoadMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e>:
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
              (ins GetVRegNoV0<RetClass>.R:$merge,
                   GPRMemZeroOffset:$rs1, RetClass:$rs2,
                   VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/1, /*Strided*/0, /*Indexed*/1, /*FF*/0,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $merge";
}

multiclass XVPseudoILoad {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            def "X" # tag # "_V_E" # reg # "_" # LInfo :
              XVPseudoILoadNoMask<vreg, mem, reg, 0, 0>,
              VLXSched<mem, "O", LInfo, LInfo>;
            def "X" # tag # "U_V_E" # reg # "_" # LInfo :
              XVPseudoILoadNoMask<vreg, mem, reg, 1, 0>,
              VLXSched<mem, "O", LInfo, LInfo>;
            def "X" # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoILoadMask<vreg, mem, reg, 0, 0>,
              RISCVMaskedPseudo<MaskIdx=3>,
              VLXSched<mem, "O", LInfo, LInfo>;
            def "X" # tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoILoadMask<vreg, mem, reg, 1, 0>,
              RISCVMaskedPseudo<MaskIdx=3>,
              VLXSched<mem, "O", LInfo, LInfo>;
          }
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "XE_V_E" # eew # "_" # LInfo :
          XVPseudoILoadNoMask<vreg, eew, eew, 0, 1>,
          VLXSched<eew, "O", LInfo, LInfo>;
        def "XE_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoILoadMask<vreg, eew, eew, 0, 1>,
          RISCVMaskedPseudo<MaskIdx=3>,
          VLXSched<eew, "O", LInfo, LInfo>;
      }
    }
  }
}

class XVPseudoIStoreNoMask<VReg StClass, int MEM, int REG, bit e>:
      Pseudo<(outs),
             (ins StClass:$rd, GPRMemZeroOffset:$rs1, StClass:$rs2,
              AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVS</*Masked*/0, /*Strided*/0, /*Indexed*/1, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoIStoreMask<VReg StClass, int MEM, int REG, bit e>:
      Pseudo<(outs),
             (ins StClass:$rd, GPRMemZeroOffset:$rs1, StClass:$rs2, VMaskOp:$vm,
              AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVS</*Masked*/1, /*Strided*/0, /*Indexed*/1, e,
                !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoIStore {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        let VLMul = lmul.value, SEW = mem in {
          def "X" # tag # "_V_E" # reg # "_" # LInfo :
            XVPseudoIStoreNoMask<vreg, mem, reg, 0>,
            VSXSched<mem, "O", LInfo, LInfo>;
          def "X" # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
            XVPseudoIStoreMask<vreg, mem, reg, 0>,
            VSXSched<mem, "O", LInfo, LInfo>;
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "XE_V_E" # eew # "_" # LInfo :
          XVPseudoIStoreNoMask<vreg, eew, eew, 1>,
          VSXSched<eew, "O", LInfo, LInfo>;
        def "XE_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoIStoreMask<vreg, eew, eew, 1>,
          VSXSched<eew, "O", LInfo, LInfo>;
      }
    }
  }
}

// 7.7. Unit-stride Fault-Only-First Loads
class XVPseudoUSLoadFFNoMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e> :
      Pseudo<(outs RetClass:$rd, GPR:$vl),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, AVL:$avl,
                  ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/0, /*Strided*/0, /*Indexed*/0, /*FF*/1,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoUSLoadFFMask<VReg RetClass, int MEM, int REG, bit unsigned, bit e> :
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd, GPR:$vl),
             (ins GetVRegNoV0<RetClass>.R:$merge,
                  GPRMemZeroOffset:$rs1,
                  VMaskOp:$vm, AVL:$avl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVL</*Masked*/1, /*Strided*/0, /*Indexed*/0, /*FF*/1,
                unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "$rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoFFLoad {
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar vreg = lmul.vrclass;
      let VLMul = lmul.value, SEW = eew in {
        def "EFF_V_E" # eew # "_" # LInfo :
          XVPseudoUSLoadFFNoMask<vreg, eew, eew, 0, 1>,
          VLESched<LInfo>;
        def "EFF_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoUSLoadFFMask<vreg, eew, eew, 0, 1>,
          RISCVMaskedPseudo<MaskIdx=2>,
          VLESched<LInfo>;
      }
    }
  }
}

// 7.8. Vector Load/Store Segment Instructions
// 7.8.1. Vector Unit-Stride Segment Loads and Stores
class XVPseudoUSSegLoadNoMask<VReg RetClass, int MEM, int REG,
                              bits<4> NF, bit unsigned, bit e> :
      Pseudo<(outs RetClass:$rd),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/0, /*FF*/0, unsigned, e,
                   !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoUSSegLoadMask<VReg RetClass, int MEM, int REG,
                            bits<4> NF, bit unsigned, bit e> :
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
              (ins GetVRegNoV0<RetClass>.R:$merge,
                   GPRMemZeroOffset:$rs1,
                   VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/0, /*FF*/0, unsigned, e,
                   !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "$rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoUSSegLoad {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            foreach nf = NFSet<lmul>.L in {
              defvar vreg = SegRegClass<lmul, nf>.RC;
              def nf # tag # "_V_E" # reg # "_" # LInfo :
                XVPseudoUSSegLoadNoMask<vreg, mem, reg, nf, 0, 0>,
                VLSEGSched<nf, mem, LInfo>;
              def nf # tag # "U_V_E" # reg # "_" # LInfo :
                XVPseudoUSSegLoadNoMask<vreg, mem, reg, nf, 1, 0>,
                VLSEGSched<nf, mem, LInfo>;
              def nf # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoUSSegLoadMask<vreg, mem, reg, nf, 0, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VLSEGSched<nf, mem, LInfo>;
              def nf # tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoUSSegLoadMask<vreg, mem, reg, nf, 1, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VLSEGSched<nf, mem, LInfo>;
            }
          }
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      let VLMul = lmul.value, SEW = eew in {
        foreach nf = NFSet<lmul>.L in {
          defvar vreg = SegRegClass<lmul, nf>.RC;
          def nf # "E_E" # eew # "_V_" # LInfo :
            XVPseudoUSSegLoadNoMask<vreg, eew, eew, nf, 0, 1>,
            VLSEGSched<nf, eew, LInfo>;
          def nf # "E_E" # eew # "_V_" # LInfo # "_MASK" :
            XVPseudoUSSegLoadMask<vreg, eew, eew, nf, 0, 1>,
            VLSEGSched<nf, eew, LInfo>;
        }
      }
    }
  }
}

class XVPseudoUSSegStoreNoMask<VReg ValClass, int MEM, int REG, bits<4> NF, bit e>:
      Pseudo<(outs),
             (ins ValClass:$rd, GPRMemZeroOffset:$rs1, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVSSEG<NF, /*Masked*/0, /*Strided*/0, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoUSSegStoreMask<VReg ValClass, int MEM, int REG, bits<4> NF, bit e>:
      Pseudo<(outs),
             (ins ValClass:$rd, GPRMemZeroOffset:$rs1,
                  VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVSSEG<NF, /*Masked*/1, /*Strided*/0, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoUSSegStore {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            foreach nf = NFSet<lmul>.L in {
              defvar vreg = SegRegClass<lmul, nf>.RC;
              def nf # tag # "_V_E" # reg # "_" # LInfo :
                XVPseudoUSSegStoreNoMask<vreg, mem, reg, nf, 0>,
                VSSEGSched<nf, mem, LInfo>;
              def nf # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoUSSegStoreMask<vreg, mem, reg, nf, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VSSEGSched<nf, mem, LInfo>;
            }
          }
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      let VLMul = lmul.value, SEW = eew in {
        foreach nf = NFSet<lmul>.L in {
          defvar vreg = SegRegClass<lmul, nf>.RC;
          def nf # "E_E" # eew # "_V_" # LInfo :
            XVPseudoUSSegStoreNoMask<vreg, eew, eew, nf, 1>,
            VSSEGSched<nf, eew, LInfo>;
          def nf # "E_E" # eew # "_V_" # LInfo # "_MASK" :
            XVPseudoUSSegStoreMask<vreg, eew, eew, nf, 1>,
            VSSEGSched<nf, eew, LInfo>;
        }
      }
    }
  }
}

// 7.8. Vector Load/Store Segment Instructions
// 7.8.1. Vector Unit-Stride Falut-only-first Segment Loads
class XVPseudoUSSegLoadFFNoMask<VReg RetClass, int EEW, bits<4> NF> :
      Pseudo<(outs RetClass:$rd, GPR:$vl),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, AVL:$avl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/0, /*FF*/1, /*Unsigned*/0, /*IsE*/1,
                   !logtwo(EEW), !logtwo(EEW), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoUSSegLoadFFMask<VReg RetClass, int EEW, bits<4> NF> :
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd, GPR:$vl),
             (ins GetVRegNoV0<RetClass>.R:$merge, GPRMemZeroOffset:$rs1,
                  VMaskOp:$vm, AVL:$avl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/0, /*FF*/1, /*Unsigned*/0, /*IsE*/1,
                   !logtwo(EEW), !logtwo(EEW), VLMul>{
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "$rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoSegLoadFF {
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      let VLMul = lmul.value, SEW = eew in {
        foreach nf = NFSet<lmul>.L in {
          defvar vreg = SegRegClass<lmul, nf>.RC;
          def nf # "EFF_V_E" # eew # "_" # LInfo :
            XVPseudoUSSegLoadFFNoMask<vreg, eew, nf>,
            VLSEGFFSched<nf, eew, LInfo>;
          def nf # "EFF_V_E" # eew # "_" # LInfo # "_MASK" :
            XVPseudoUSSegLoadFFMask<vreg, eew, nf>,
            VLSEGFFSched<nf, eew, LInfo>;
        }
      }
    }
  }
}

// 7.8.2. Vector Strided Segment Loads and Stores
class XVPseudoSSegLoadNoMask<VReg RetClass, int MEM, int REG,
                             bits<4> NF, bit unsigned, bit e> :
      Pseudo<(outs RetClass:$rd),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, GPR:$offset, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/1, /*FF*/0, unsigned, e,
                   !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "$rd = $dest";
}

class XVPseudoSSegLoadMask<VReg RetClass, int MEM, int REG,
                           bits<4> NF, bit unsigned, bit e> :
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
             (ins GetVRegNoV0<RetClass>.R:$merge, GPRMemZeroOffset:$rs1,
                  GPR:$offset, VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/1, /*FF*/0, unsigned, e,
                   !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "$rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoSSegLoad {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            foreach nf = NFSet<lmul>.L in {
              defvar vreg = SegRegClass<lmul, nf>.RC;
              def nf # tag # "_V_E" # reg # "_" # LInfo :
                XVPseudoSSegLoadNoMask<vreg, mem, reg, nf, 0, 0>,
                VLSSEGSched<nf, mem, LInfo>;
              def nf # tag # "U_V_E" # reg # "_" # LInfo :
                XVPseudoSSegLoadNoMask<vreg, mem, reg, nf, 1, 0>,
                VLSSEGSched<nf, mem, LInfo>;
              def nf # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoSSegLoadMask<vreg, mem, reg, nf, 0, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VLSSEGSched<nf, mem, LInfo>;
              def nf # tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoSSegLoadMask<vreg, mem, reg, nf, 1, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VLSSEGSched<nf, mem, LInfo>;
            }
          }
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      let VLMul = lmul.value, SEW = eew in {
        foreach nf = NFSet<lmul>.L in {
          defvar vreg = SegRegClass<lmul, nf>.RC;
          def nf # "E_V_E" # eew # "_" # LInfo :
            XVPseudoSSegLoadNoMask<vreg, eew, eew, nf, 0, 1>,
            VLSSEGSched<nf, eew, LInfo>;
          def nf # "E_V_E" # eew # "_" # LInfo # "_MASK" :
            XVPseudoSSegLoadMask<vreg, eew, eew, nf, 0, 1>,
            VLSSEGSched<nf, eew, LInfo>;
        }
      }
    }
  }
}

class XVPseudoSSegStoreNoMask<VReg ValClass, int MEM, int REG, bits<4> NF, bit e>:
      Pseudo<(outs),
             (ins ValClass:$rd, GPRMemZeroOffset:$rs1, GPR:$offset, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVSSEG<NF, /*Masked*/0, /*Strided*/1, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoSSegStoreMask<VReg ValClass, int MEM, int REG, bits<4> NF, bit e>:
      Pseudo<(outs),
             (ins ValClass:$rd, GPRMemZeroOffset:$rs1,
                  GPR:$offset, VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVSSEG<NF, /*Masked*/1, /*Strided*/1, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoSSegStore {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            foreach nf = NFSet<lmul>.L in {
              defvar vreg = SegRegClass<lmul, nf>.RC;
              def nf # tag # "_V_E" # reg # "_" # LInfo :
                XVPseudoSSegStoreNoMask<vreg, mem, reg, nf, 0>,
                VSSSEGSched<nf, mem, LInfo>;
              def nf # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoSSegStoreMask<vreg, mem, reg, nf, 0>,
                VSSSEGSched<nf, mem, LInfo>;
            }
          }
        }
      }
    }
  }
  foreach eew = EEWList in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      let VLMul = lmul.value, SEW = eew in {
        foreach nf = NFSet<lmul>.L in {
          defvar vreg = SegRegClass<lmul, nf>.RC;
          def nf # "E_E" # eew # "_V_" # LInfo :
            XVPseudoSSegStoreNoMask<vreg, eew, eew, nf, 1>,
            VSSSEGSched<nf, eew, LInfo>;
          def nf # "E_E" # eew # "_V_" # LInfo # "_MASK" :
            XVPseudoSSegStoreMask<vreg, eew, eew, nf, 1>,
            VSSSEGSched<nf, eew, LInfo>;
        }
      }
    }
  }
}

let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VL : XVPseudoUSLoad;
  defm PseudoTH_VS : XVPseudoUSStore;
  defm PseudoTH_VL : XVPseudoSLoad;
  defm PseudoTH_VS : XVPseudoSStore;
  defm PseudoTH_VL : XVPseudoILoad;
  defm PseudoTH_VS : XVPseudoIStore;

  let hasSideEffects = 1, Defs = [VL] in
  defm PseudoTH_VL : XVPseudoFFLoad;

  defm PseudoTH_VLSEG : XVPseudoUSSegLoad;
  defm PseudoTH_VSSEG : XVPseudoUSSegStore;
  defm PseudoTH_VLSSEG : XVPseudoSSegLoad;
  defm PseudoTH_VSSSEG : XVPseudoSSegStore;

  let hasSideEffects = 1, Defs = [VL] in
  defm PseudoTH_VLSEG : XVPseudoSegLoadFF;
} // Predicates = [HasVendorXTHeadV]

//===----------------------------------------------------------------------===//
// 7. Vector Loads and Stores
// for emulating Vector Load/Store Whole Register Instructions in RVV 1.0
//===----------------------------------------------------------------------===//

// This part defines the pseudo `PseudoTH_VLE_V_M*` and `PseudoTH_VSE_V_M*`,
// with the type of operands being VRM2, VRM4 and VRM8.
// We cannot directly convert `PseudoTH_VL<nr>R` or `PseudoTH_VS<nr>R` to `TH_VLE_V` or `TH_VSE_V`,
// which will be reported as ill-typed program by the type checker.
// See https://github.com/ruyisdk/llvm-project/pull/23#issuecomment-1816071060 for details.

// In the following, we define such pseudos only to make the type checker happy.
// As the types in these pseudos are always erased when lowering to MCInst.
// TODO: consider using `PseudoTH_VLE_V_E*_M*` and `PseudoTH_VSE_V_E*_M*` defined above,
//   but these pseudos seems to require more operands like `AVL:$vl, ixlenimm:$sew`,
//   some of which are not available in the original `PseudoTH_VL<nr>R` and `PseudoTH_VS<nr>R`.

multiclass XVPseudoWellTypedUSLoadStore_VLE {
  foreach lmul = MxListXTHeadV in {
    defvar LInfo = lmul.MX;
    defvar vreg = lmul.vrclass;

    let hasSideEffects = 0, mayLoad = 1, mayStore = 0 in {
      def "_" # LInfo : Pseudo<(outs vreg:$vd), (ins GPRMemZeroOffset:$rs1), []>,
                        RISCVVPseudo;
    }
  }
}

multiclass XVPseudoWellTypedUSLoadStore_VSE {
  foreach lmul = MxListXTHeadV in {
    defvar LInfo = lmul.MX;
    defvar vreg = lmul.vrclass;

    let hasSideEffects = 0, mayLoad = 0, mayStore = 1 in {
      def "_" # LInfo : Pseudo<(outs), (ins vreg:$vs, GPRMemZeroOffset:$rs1), []>,
                        RISCVVPseudo;
    }
  }
}

// Set `isCodeGenOnly = 1` to hide them from the tablegened assembly parser,
// to avoid decoding conflict with the original `vle.v` and `vse.v` in RISCVInstraInfoXTHeadV.td
let Predicates = [HasVendorXTHeadV], isCodeGenOnly = 1 in {
  defm PseudoTH_VLE_V : XVPseudoWellTypedUSLoadStore_VLE;
  defm PseudoTH_VSE_V : XVPseudoWellTypedUSLoadStore_VSE;
} // Predicates = [HasVendorXTHeadV], isCodeGenOnly = 1

// This part defines the pseudo version of `vl<n>r.v` and `vs<n>r.v`,
// that is, `PseudoTH_VL<nr>R` and `PseudoTH_VS<nr>R`,
// and explcitly binds them to LLVM IR `load`/`store` intrinsic calls
// in the instruction selection process, which enables directly
// loading/storing a vector register in LLVM IR with builtin `load`/`store`,
// without the need of remembering the RISCV-V intrinsic name and type.
// See: llvm/test/CodeGen/RISCV/rvv0p71/whole-load-store-*.ll

class XVPseudoWholeLoad<Instruction instr, LMULInfo m, RegisterClass VRC>
  : VPseudo<instr, m, (outs VRC:$vd), (ins GPRMemZeroOffset:$rs1)> {
}

multiclass XVPseudoWholeLoadN<bits<3> nf, LMULInfo m, RegisterClass VRC> {
  foreach l = EEWList in {
    defvar s = !cast<SchedWrite>("WriteVLD" # !add(nf, 1) # "R");

    def E # l # _V : XVPseudoWholeLoad<TH_VLE_V, m, VRC>,
                     Sched<[s, ReadVLDX]>;
  }
}

class XVPseudoWholeStore<Instruction instr, LMULInfo m, RegisterClass VRC>
  : VPseudo<instr, m, (outs), (ins VRC:$vs3, GPRMemZeroOffset:$rs1)> {
}

multiclass XVPseudoWholeStoreN<bits<3> nf, LMULInfo m, RegisterClass VRC> {
  foreach l = EEWList in {
    defvar sw = !cast<SchedWrite>("WriteVST" # !add(nf, 1) # "R");
    defvar sr = !cast<SchedRead>("ReadVST" # !add(nf, 1) # "R");

    def E # l # _V : XVPseudoWholeStore<TH_VSE_V, m, VRC>,
                     Sched<[sw, sr, ReadVSTX]>;
  }
}

// Set `usesCustomInserter = 1` to lower these manually
// to `PseudoTH_VLE_V_M*` or `PseudoTH_VSE_V_M*` defined above.
// See: RISCVISelLowering.cpp, function `RISCVTargetLowering::EmitInstrWithCustomInserter`
// and `emitXWholeLoadStore`.
let Predicates = [HasVendorXTHeadV] in {
  // Whole register load
  let hasSideEffects = 0, mayLoad = 1, mayStore = 0, isCodeGenOnly = 1, usesCustomInserter = 1 in {
    defm PseudoTH_VL1R : XVPseudoWholeLoadN<0, V_M1, VR>;
    defm PseudoTH_VL2R : XVPseudoWholeLoadN<1, V_M2, VRM2>;
    defm PseudoTH_VL4R : XVPseudoWholeLoadN<3, V_M4, VRM4>;
    defm PseudoTH_VL8R : XVPseudoWholeLoadN<7, V_M8, VRM8>;
  }
  // Whole register store
  let hasSideEffects = 0, mayLoad = 0, mayStore = 1, isCodeGenOnly = 1, usesCustomInserter = 1 in {
    defm PseudoTH_VS1R : XVPseudoWholeStoreN<0, V_M1, VR>;
    defm PseudoTH_VS2R : XVPseudoWholeStoreN<1, V_M2, VRM2>;
    defm PseudoTH_VS4R : XVPseudoWholeStoreN<3, V_M4, VRM4>;
    defm PseudoTH_VS8R : XVPseudoWholeStoreN<7, V_M8, VRM8>;
  }
} // Predicates = [HasVendorXTHeadV]

// Patterns to bind the pseudo instructions to LLVM IR `load`/`store` intrinsic calls.
multiclass XVPatUSLoadStoreWholeVRSDNode<ValueType type,
                                         int log2sew,
                                         LMULInfo vlmul,
                                         VReg reg_class,
                                         int sew = !shl(1, log2sew)> {
  defvar load_instr =
    !cast<Instruction>("PseudoTH_VL"#!substr(vlmul.MX, 1)#"RE"#sew#"_V");
  defvar store_instr =
    !cast<Instruction>("PseudoTH_VS"#!substr(vlmul.MX, 1)#"RE"#sew#"_V");

  // Load
  def : Pat<(type (load GPR:$rs1)),
            (load_instr GPR:$rs1)>;
  // Store
  def : Pat<(store type:$rs2, GPR:$rs1),
            (store_instr reg_class:$rs2, GPR:$rs1)>;
}

// Explicitly define the expected instruction selection result for each vector type
foreach vti = [XVI8M1, XVI16M1, XVI32M1, XVI64M1] in
  let Predicates = GetXVTypePredicates<vti>.Predicates in
  defm : XVPatUSLoadStoreWholeVRSDNode<vti.Vector, vti.Log2SEW, vti.LMul,
                                       vti.RegClass>;
foreach vti = GroupIntegerXVectors in
  let Predicates = GetXVTypePredicates<vti>.Predicates in
  defm : XVPatUSLoadStoreWholeVRSDNode<vti.Vector, vti.Log2SEW, vti.LMul,
                                       vti.RegClass>;

//===----------------------------------------------------------------------===//
// 8. Vector AMO Operations
//===----------------------------------------------------------------------===//

// Pseudo base class for unmasked vamo instructions
class XVPseudoAMOWDNoMask<VReg RetClass,
                          VReg Op1Class> :
        Pseudo<(outs GetVRegNoV0<RetClass>.R:$vd_wd),
               (ins Op1Class:$vs2,
                    GPR:$rs1,
                    GetVRegNoV0<RetClass>.R:$vd,
                    AVL:$vl, ixlenimm:$sew), []>,
        RISCVVPseudo {
  let mayLoad = 1;
  let mayStore = 1;
  let hasSideEffects = 1;
  let Constraints = "$vd_wd = $vd";
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let BaseInstr = !cast<Instruction>(PseudoToVInst<NAME>.VInst # "_V");
}

// Pseudo base class for masked vamo instructions
class XVPseudoAMOWDMask<VReg RetClass,
                        VReg Op1Class> :
        Pseudo<(outs GetVRegNoV0<RetClass>.R:$vd_wd),
               (ins Op1Class:$vs2,
                    GPR:$rs1,
                    GetVRegNoV0<RetClass>.R:$vd,
                    VMaskOp:$vm, AVL:$vl, ixlenimm:$sew), []>,
        RISCVVPseudo {
  let mayLoad = 1;
  let mayStore = 1;
  let hasSideEffects = 1;
  let Constraints = "$vd_wd = $vd";
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let BaseInstr = !cast<Instruction>(PseudoToVInst<NAME>.VInst # "_V");
}

multiclass XVPseudoAMOMem<int mem> {
  // VAMO in RVV 0.7.1 supports 32, 64, and 128 Mem data bits, and in
  // the base vector "V" extension, only SEW up to ELEN = max(XLEN, FLEN)
  // are required to be supported, therefore only [32, 64] is allowed here.
  foreach sew = [32, 64] in {
    foreach lmul = MxListXTHeadV in {
      defvar octuple_lmul = lmul.octuple;
      // Calculate emul = sew * lmul / mem
      defvar octuple_emul = !srl(!mul(sew, octuple_lmul), !logtwo(mem));
      if !and(!ge(octuple_emul, 8), !le(octuple_emul, 64)) then {
        defvar emulMX = octuple_to_str<octuple_emul>.ret;
        defvar emul = !cast<LMULInfo>("V_" # emulMX);
        let VLMul = lmul.value in {
          def "_WD_" # lmul.MX # "_" # emulMX : XVPseudoAMOWDNoMask<lmul.vrclass, emul.vrclass>;
          def "_WD_" # lmul.MX # "_" # emulMX # "_MASK" : XVPseudoAMOWDMask<lmul.vrclass, emul.vrclass>;
        }
      }
    }
  }
}

multiclass XVPseudoAMO {
  defm "W" : XVPseudoAMOMem<32>;
  defm "D" : XVPseudoAMOMem<64>;
}

let Predicates = [HasVendorXTHeadV, HasVendorXTHeadZvamo, HasStdExtA] in {
  defm PseudoTH_VAMOSWAP : XVPseudoAMO;
  defm PseudoTH_VAMOADD  : XVPseudoAMO;
  defm PseudoTH_VAMOXOR  : XVPseudoAMO;
  defm PseudoTH_VAMOAND  : XVPseudoAMO;
  defm PseudoTH_VAMOOR   : XVPseudoAMO;
  defm PseudoTH_VAMOMIN  : XVPseudoAMO;
  defm PseudoTH_VAMOMAX  : XVPseudoAMO;
  defm PseudoTH_VAMOMINU : XVPseudoAMO;
  defm PseudoTH_VAMOMAXU : XVPseudoAMO;
} // Predicates = [HasVendorXTHeadV, HasVendorXTHeadZvamo, HasStdExtA]

// Patterns for vamo intrinsics.
class XVPatAMOWDNoMask<string intrinsic_name,
                    string inst,
                    ValueType result_type,
                    ValueType op1_type,
                    int sew,
                    LMULInfo vlmul,
                    LMULInfo emul,
                    VReg op1_reg_class> :
  Pat<(result_type (!cast<Intrinsic>(intrinsic_name)
                    GPR:$rs1,
                    (op1_type op1_reg_class:$vs2),
                    (result_type vlmul.vrclass:$vd),
                    VLOpFrag)),
                   (!cast<Instruction>(inst # "_WD_" # vlmul.MX # "_" # emul.MX)
                    $vs2, $rs1, $vd,
                    GPR:$vl, sew)>;

class XVPatAMOWDMask<string intrinsic_name,
                    string inst,
                    ValueType result_type,
                    ValueType op1_type,
                    ValueType mask_type,
                    int sew,
                    LMULInfo vlmul,
                    LMULInfo emul,
                    VReg op1_reg_class> :
  Pat<(result_type (!cast<Intrinsic>(intrinsic_name # "_mask")
                    GPR:$rs1,
                    (op1_type op1_reg_class:$vs2),
                    (result_type vlmul.vrclass:$vd),
                    (mask_type V0),
                    VLOpFrag)),
                  (!cast<Instruction>(inst # "_WD_" # vlmul.MX # "_" # emul.MX # "_MASK")
                    $vs2, $rs1, $vd,
                    (mask_type V0), GPR:$vl, sew)>;

multiclass XVPatAMOWD<string intrinsic,
                     string inst,
                     ValueType result_type,
                     ValueType offset_type,
                     ValueType mask_type,
                     int sew,
                     LMULInfo vlmul,
                     LMULInfo emul,
                     VReg op1_reg_class> {
  def : XVPatAMOWDNoMask<intrinsic, inst, result_type, offset_type,
                        sew, vlmul, emul, op1_reg_class>;
  def : XVPatAMOWDMask<intrinsic, inst, result_type, offset_type,
                      mask_type, sew, vlmul, emul, op1_reg_class>;
}

multiclass XVPatAMOV_WD<string intrinsic,
                       string inst,
                       list<VTypeInfo> vtilist> {
  foreach eew = [32, 64] in {
    foreach vti = vtilist in {
      if !or(!eq(vti.SEW, 32), !eq(vti.SEW, 64)) then {
        defvar octuple_lmul = vti.LMul.octuple;
        // Calculate emul = eew * lmul / sew
        defvar octuple_emul = !srl(!mul(eew, octuple_lmul), vti.Log2SEW);
        // emul must be in range 8 - 64, since rvv 0.7.1 does not
        // allow fractional lmul
        if !and(!ge(octuple_emul, 8), !le(octuple_emul, 64)) then {
          defvar emulMX = octuple_to_str<octuple_emul>.ret;
          defvar offsetVti = !cast<VTypeInfo>("XVI" # eew # emulMX);
          defvar inst_tag = inst # !cond(!eq(vti.SEW, 32) : "W", !eq(vti.SEW, 64) : "D");
          defm : XVPatAMOWD<intrinsic, inst_tag,
                           vti.Vector, offsetVti.Vector,
                           vti.Mask, vti.Log2SEW, vti.LMul, offsetVti.LMul, offsetVti.RegClass>;
        }
      }
    }
  }
}

let Predicates = [HasVendorXTHeadV, HasVendorXTHeadZvamo, HasStdExtA] in {
  defm : XVPatAMOV_WD<"int_riscv_th_vamoswap", "PseudoTH_VAMOSWAP", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamoadd", "PseudoTH_VAMOADD", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamoxor", "PseudoTH_VAMOXOR", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamoand", "PseudoTH_VAMOAND", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamoor", "PseudoTH_VAMOOR", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamomin", "PseudoTH_VAMOMIN", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamomax", "PseudoTH_VAMOMAX", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamominu", "PseudoTH_VAMOMINU", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_th_vamomaxu", "PseudoTH_VAMOMAXU", AllIntegerXVectors>;
} // Predicates = [HasVendorXTHeadV, HasVendorXTHeadZvamo, HasStdExtA]

//===----------------------------------------------------------------------===//
// 12. Vector Integer Arithmetic Instructions
//===----------------------------------------------------------------------===//
multiclass XVPseudoVALU_VV_VX_VI<Operand ImmType = simm5, string Constraint = ""> {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVIALUV_MX = !cast<SchedWrite>("WriteVIALUV_" # mx);
    defvar WriteVIALUX_MX = !cast<SchedWrite>("WriteVIALUX_" # mx);
    defvar WriteVIALUI_MX = !cast<SchedWrite>("WriteVIALUI_" # mx);
    defvar ReadVIALUV_MX = !cast<SchedRead>("ReadVIALUV_" # mx);
    defvar ReadVIALUX_MX = !cast<SchedRead>("ReadVIALUX_" # mx);

    defm "" : VPseudoBinaryV_VV<m, Constraint>,
            Sched<[WriteVIALUV_MX, ReadVIALUV_MX, ReadVIALUV_MX, ReadVMask]>;
    defm "" : VPseudoBinaryV_VX<m, Constraint>,
            Sched<[WriteVIALUX_MX, ReadVIALUV_MX, ReadVIALUX_MX, ReadVMask]>;
    defm "" : VPseudoBinaryV_VI<ImmType, m, Constraint>,
            Sched<[WriteVIALUI_MX, ReadVIALUV_MX, ReadVMask]>;
  }
}

let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VADD   : XVPseudoVALU_VV_VX_VI;
} // Predicates = [HasVendorXTHeadV]

let Predicates = [HasVendorXTHeadV] in {
  defm : VPatBinaryV_VV_VX_VI<"int_riscv_th_vadd", "PseudoTH_VADD", AllIntegerXVectors>;
} // Predicates = [HasVendorXTHeadV]

//===----------------------------------------------------------------------===//
// 12.14. Vector Integer Merge and Move Instructions
//===----------------------------------------------------------------------===//
multiclass XVPseudoUnaryVMV_V_X_I {
  foreach m = MxListXTHeadV in {
    let VLMul = m.value in {
      defvar mx = m.MX;
      defvar WriteVIMovV_MX = !cast<SchedWrite>("WriteVIMovV_" # mx);
      defvar WriteVIMovX_MX = !cast<SchedWrite>("WriteVIMovX_" # mx);
      defvar WriteVIMovI_MX = !cast<SchedWrite>("WriteVIMovI_" # mx);
      defvar ReadVIMovV_MX = !cast<SchedRead>("ReadVIMovV_" # mx);
      defvar ReadVIMovX_MX = !cast<SchedRead>("ReadVIMovX_" # mx);

      let VLMul = m.value in {
        def "_V_" # mx : VPseudoUnaryNoMask<m.vrclass, m.vrclass>,
                           Sched<[WriteVIMovV_MX, ReadVIMovV_MX]>;
        def "_X_" # mx : VPseudoUnaryNoMask<m.vrclass, GPR>,
                           Sched<[WriteVIMovX_MX, ReadVIMovX_MX]>;
        def "_I_" # mx : VPseudoUnaryNoMask<m.vrclass, simm5>,
                           Sched<[WriteVIMovI_MX]>;
      }
    }
  }
}

let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VMV_V : XVPseudoUnaryVMV_V_X_I;
} // Predicates = [HasVendorXTHeadV]

// Patterns for `int_riscv_vmv_v_v` -> `PseudoTH_VMV_V_V_<LMUL>`
foreach vti = AllXVectors in {
  let Predicates = GetXVTypePredicates<vti>.Predicates in {
    // vmv.v.v
    def : Pat<(vti.Vector (int_riscv_th_vmv_v_v (vti.Vector vti.RegClass:$passthru),
                                                (vti.Vector vti.RegClass:$rs1),
                                                 VLOpFrag)),
              (!cast<Instruction>("PseudoTH_VMV_V_V_"#vti.LMul.MX)
               $passthru, $rs1, GPR:$vl, vti.Log2SEW, TU_MU)>;

    // TODO: vmv.v.x, vmv.v.i
  }
}

//===----------------------------------------------------------------------===//
// 12.14. Vector Integer Merge and Move Instructions
// for emulating Whole Vector Register Move Instructions in RVV 1.0
//===----------------------------------------------------------------------===//

class XVPseudoWholeMove<Instruction instr, LMULInfo m, RegisterClass VRC>
  : VPseudo<instr, m, (outs VRC:$vd), (ins VRC:$vs2)> {
}

let Predicates = [HasVendorXTHeadV] in {
  let hasSideEffects = 0, mayLoad = 0, mayStore = 0, isCodeGenOnly = 1, usesCustomInserter = 1 in {
    // Note: All `LMULInfo` and `RegisterClass` should be `V_M1` and `VR` respectively.
    // From RVV Spec 1.0: "These instructions are intended to aid compilers to
    // shuffle vector registers without needing to know or change vl or vtype."
    // The 1, 2, 4, 8 in suffixes are "the number of individual vector registers, NREG, to copy",
    // rather than LMUL.
    def PseudoTH_VMV1R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M1, VR>;
    def PseudoTH_VMV2R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M1, VR>;
    def PseudoTH_VMV4R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M1, VR>;
    def PseudoTH_VMV8R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M1, VR>;
  }
} // Predicates = [HasVendorXTHeadV]
