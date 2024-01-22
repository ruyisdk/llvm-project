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

// Used to iterate over all possible extendable LMULs in RVV 0.7.1.
defvar MxListWXTHeadV = [V_M1, V_M2, V_M4];

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

// Redefine `AllWidenableIntVectors` from RISCVInstrInfoVPseudos.td to remove fractionally-grouped
// register groups like MF2, MF4, MF8, which are not supported by the 'V' extension 0.7.1.
defset list<VTypeInfoToWide> AllWidenableIntXVectors = {
  def : VTypeInfoToWide<VI8M1,   VI16M2>;
  def : VTypeInfoToWide<VI8M2,   VI16M4>;
  def : VTypeInfoToWide<VI8M4,   VI16M8>;

  def : VTypeInfoToWide<VI16M1,  VI32M2>;
  def : VTypeInfoToWide<VI16M2,  VI32M4>;
  def : VTypeInfoToWide<VI16M4,  VI32M8>;

  def : VTypeInfoToWide<VI32M1,  VI64M2>;
  def : VTypeInfoToWide<VI32M2,  VI64M4>;
  def : VTypeInfoToWide<VI32M4,  VI64M8>;
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

class XTHeadVVLSEG<bits<4> N, bit M, bit ST, bit I, bit F, bit U, bit E,
                   bits<3> ME, bits<3> S, bits<3> L> {
  bits<4> NF = N;
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

def XTHeadVVLSEGTable : GenericTable {
  let FilterClass = "XTHeadVVLSEG";
  let CppTypeName = "TH_VLSEGPseudo";
  let Fields = ["NF", "Masked", "Strided", "Indexed", "FF", "Unsigned",
                "IsE", "Log2MEM", "Log2SEW", "LMUL", "Pseudo"];
  let PrimaryKey = ["NF", "Masked", "Strided", "Indexed", "FF", "Unsigned",
                    "IsE", "Log2MEM", "Log2SEW", "LMUL"];
  let PrimaryKeyName = "getTH_VLSEGPseudo";
}

class XTHeadVVSSEG<bits<4> N, bit M, bit ST, bit I, bit E,
                   bits<3> ME, bits<3> S, bits<3> L> {
  bits<4> NF = N;
  bits<1> Masked = M;
  bits<1> Strided = ST;
  bits<1> Indexed = I;
  bits<1> IsE = E;
  bits<3> Log2MEM = ME;
  bits<3> Log2SEW = S;
  bits<3> LMUL = L;
  Pseudo Pseudo = !cast<Pseudo>(NAME);
}

def XTHeadVVSSEGTable : GenericTable {
  let FilterClass = "XTHeadVVSSEG";
  let CppTypeName = "TH_VSSEGPseudo";
  let Fields = ["NF", "Masked", "Strided", "Indexed", "IsE",
                "Log2MEM", "Log2SEW", "LMUL", "Pseudo"];
  let PrimaryKey = ["NF", "Masked", "Strided", "Indexed", "IsE",
                    "Log2MEM", "Log2SEW", "LMUL"];
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
              VLSSched<mem, LInfo>;
            def "S" # tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
              XVPseudoSLoadMask<vreg, mem, reg, 1, 0>,
              RISCVMaskedPseudo<MaskIdx=3>,
              VLSSched<mem, LInfo>;
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
          VLSSched<eew, LInfo>;
        def "SE_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoSLoadMask<vreg, eew, eew, 0, 1>,
          RISCVMaskedPseudo<MaskIdx=3>,
          VLSSched<eew, LInfo>;
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
            VSSSched<mem, LInfo>;
          def "S" # tag # "_V_E" # sew # "_" # LInfo # "_MASK" :
            XVPseudoSStoreMask<vreg, mem, sew, 0>,
            VSSSched<mem, LInfo>;
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
          VSSSched<eew, LInfo>;
        def "SE_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoSStoreMask<vreg, eew, eew, 1>,
          VSSSched<eew, LInfo>;
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
          VLFSched<LInfo>;
        def "EFF_V_E" # eew # "_" # LInfo # "_MASK" :
          XVPseudoUSLoadFFMask<vreg, eew, eew, 0, 1>,
          RISCVMaskedPseudo<MaskIdx=2>,
          VLFSched<LInfo>;
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
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/0, /*Indexed*/0, /*FF*/0,
                   unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/0, /*Indexed*/0, /*FF*/0,
                   unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
          def nf # "E_V_E" # eew # "_" # LInfo :
            XVPseudoUSSegLoadNoMask<vreg, eew, eew, nf, 0, 1>,
            VLSEGSched<nf, eew, LInfo>;
          def nf # "E_V_E" # eew # "_" # LInfo # "_MASK" :
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
      XTHeadVVSSEG<NF, /*Masked*/0, /*Strided*/0, /*Indexed*/0,
                   e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
      XTHeadVVSSEG<NF, /*Masked*/1, /*Strided*/0, /*Indexed*/0,
                   e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/0, /*Indexed*/0, /*FF*/1,
                   /*Unsigned*/0, /*IsE*/1, !logtwo(EEW), !logtwo(EEW), VLMul> {
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
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/0, /*Indexed*/0, /*FF*/1,
                   /*Unsigned*/0, /*IsE*/1, !logtwo(EEW), !logtwo(EEW), VLMul> {
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
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/1, /*Indexed*/0, /*FF*/0,
                   unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/1, /*Indexed*/0, /*FF*/0,
                   unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
      XTHeadVVSSEG<NF, /*Masked*/0, /*Strided*/1, /*Indexed*/0,
                   e, !logtwo(MEM), !logtwo(REG), VLMul> {
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
      XTHeadVVSSEG<NF, /*Masked*/1, /*Strided*/1, /*Indexed*/0,
                   e, !logtwo(MEM), !logtwo(REG), VLMul> {
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

class XVPseudoISegLoadNoMask<VReg RetClass, VReg IdxClass, int MEM, int REG,
                             bits<4> NF, bit unsigned, bit e> :
      Pseudo<(outs RetClass:$rd),
             (ins RetClass:$dest, GPRMemZeroOffset:$rs1, IdxClass:$offset,
                  AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/0, /*Strided*/0, /*Indexed*/1, /*FF*/0,
                   unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let Constraints = "@earlyclobber $rd, $rd = $dest";
}

class XVPseudoISegLoadMask<VReg RetClass, VReg IdxClass, int MEM, int REG,
                           bits<4> NF, bit unsigned, bit e> :
      Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
             (ins GetVRegNoV0<RetClass>.R:$merge, GPRMemZeroOffset:$rs1,
                  IdxClass:$offset, VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVLSEG<NF, /*Masked*/1, /*Strided*/0, /*Indexed*/1, /*FF*/0,
                   unsigned, e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 1;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = "@earlyclobber $rd, $rd = $merge";
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoISegLoad {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            foreach nf = NFSet<lmul>.L in {
              defvar vreg = SegRegClass<lmul, nf>.RC;
              defvar idxreg = lmul.vrclass;
              def nf # tag # "_V_E" # reg # "_" # LInfo :
                XVPseudoISegLoadNoMask<vreg, idxreg, mem, reg, nf, 0, 0>,
                VLXSEGSched<nf, mem, "O", LInfo>;
              def nf # tag # "U_V_E" # reg # "_" # LInfo :
                XVPseudoISegLoadNoMask<vreg, idxreg, mem, reg, nf, 1, 0>,
                VLXSEGSched<nf, mem, "O", LInfo>;
              def nf # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoISegLoadMask<vreg, idxreg, mem, reg, nf, 0, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VLXSEGSched<nf, mem, "O", LInfo>;
              def nf # tag # "U_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoISegLoadMask<vreg, idxreg, mem, reg, nf, 1, 0>,
                RISCVMaskedPseudo<MaskIdx=2>,
                VLXSEGSched<nf, mem, "O", LInfo>;
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
          defvar idxreg = lmul.vrclass;
          def nf # "E_V_E" # eew # "_" # LInfo :
            XVPseudoISegLoadNoMask<vreg, idxreg, eew, eew, nf, 0, 1>,
            VLXSEGSched<nf, eew, "O", LInfo>;
          def nf # "E_V_E" # eew # "_" # LInfo # "_MASK" :
            XVPseudoISegLoadMask<vreg, idxreg, eew, eew, nf, 0, 1>,
            VLXSEGSched<nf, eew, "O", LInfo>;
        }
      }
    }
  }
}

class XVPseudoISegStoreNoMask<VReg ValClass, VReg IdxClass,
                              int MEM, int REG, bits<4> NF, bit e> :
      Pseudo<(outs),
             (ins ValClass:$rd, GPRMem:$rs1, IdxClass: $index,
                  AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVSSEG<NF, /*Masked*/0, /*Strided*/0, /*Indexed*/1,
                   e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoISegStoreMask<VReg ValClass, VReg IdxClass,
                            int MEM, int REG, bits<4> NF, bit e>:
      Pseudo<(outs),
             (ins ValClass:$rd, GPRMem:$rs1, IdxClass: $index,
                  VMaskOp:$vm, AVL:$vl, ixlenimm:$sew),[]>,
      RISCVVPseudo,
      XTHeadVVSSEG<NF, /*Masked*/1, /*Strided*/0, /*Indexed*/1,
                   e, !logtwo(MEM), !logtwo(REG), VLMul> {
  let mayLoad = 0;
  let mayStore = 1;
  let hasSideEffects = 0;
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

multiclass XVPseudoISegStore {
  foreach mem = [8, 16, 32] in {
    foreach lmul = MxListXTHeadV in {
      defvar LInfo = lmul.MX;
      defvar tag = MemBitsToTag<mem>.ret;
      foreach reg = EEWList in {
        if !ge(reg, mem) then {
          let VLMul = lmul.value, SEW = mem in {
            foreach nf = NFSet<lmul>.L in {
              defvar vreg = SegRegClass<lmul, nf>.RC;
              defvar idxreg = lmul.vrclass;
              def nf # tag # "_V_E" # reg # "_" # LInfo :
                XVPseudoISegStoreNoMask<vreg, idxreg, mem, reg, nf, 0>,
                VSXSEGSched<nf, mem, "O", LInfo>;
              def nf # tag # "_V_E" # reg # "_" # LInfo # "_MASK" :
                XVPseudoISegStoreMask<vreg, idxreg, mem, reg, nf, 0>,
                VSXSEGSched<nf, mem, "O", LInfo>;
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
          defvar idxreg = lmul.vrclass;
          def nf # "E_E" # eew # "_V_" # LInfo :
            XVPseudoISegStoreNoMask<vreg, idxreg, eew, eew, nf, 1>,
            VSXSEGSched<nf, eew, "O", LInfo>;
          def nf # "E_E" # eew # "_V_" # LInfo # "_MASK" :
            XVPseudoISegStoreMask<vreg, idxreg, eew, eew, nf, 1>,
            VSXSEGSched<nf, eew, "O", LInfo>;
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
  defm PseudoTH_VLXSEG : XVPseudoISegLoad;
  defm PseudoTH_VSXSEG : XVPseudoISegStore;

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

//===----------------------------------------------------------------------===//
// Pseudos for arithmetic instructions.
//===----------------------------------------------------------------------===//

class XVPseudoBinaryNoMask<VReg RetClass,
                          VReg Op1Class,
                          DAGOperand Op2Class,
                          string Constraint> :
        Pseudo<(outs RetClass:$rd),
               (ins RetClass:$merge, Op1Class:$rs2, Op2Class:$rs1,
                AVL:$vl, ixlenimm:$sew), []>,
        RISCVVPseudo {
  let mayLoad = 0;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = !interleave([Constraint, "$rd = $merge"], ",");
  let HasVLOp = 1;
  let HasSEWOp = 1;
}

class XVPseudoTiedBinaryNoMask<VReg RetClass,
                               DAGOperand Op2Class,
                               string Constraint> :
        Pseudo<(outs RetClass:$rd),
               (ins RetClass:$rs2, Op2Class:$rs1, AVL:$vl, ixlenimm:$sew), []>,
        RISCVVPseudo {
  let mayLoad = 0;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = !interleave([Constraint, "$rd = $rs2"], ",");
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let isConvertibleToThreeAddress = 1;
  let IsTiedPseudo = 1;
}

class XVPseudoTiedBinaryMask<VReg RetClass,
                            DAGOperand Op2Class,
                            string Constraint> :
        Pseudo<(outs GetVRegNoV0<RetClass>.R:$rd),
                (ins GetVRegNoV0<RetClass>.R:$merge,
                     Op2Class:$rs1,
                     VMaskOp:$vm, GPR:$vl, ixlenimm:$sew), []>,
        RISCVVPseudo {
  let mayLoad = 0;
  let mayStore = 0;
  let hasSideEffects = 0;
  let Constraints = !interleave([Constraint, "$rd = $merge"], ",");
  let HasVLOp = 1;
  let HasSEWOp = 1;
  let IsTiedPseudo = 1;
}

multiclass XVPseudoBinary<VReg RetClass,
                          VReg Op1Class,
                          DAGOperand Op2Class,
                          LMULInfo MInfo,
                          string Constraint = "",
                          int sew = 0> {
  let VLMul = MInfo.value, SEW=sew in {
    defvar suffix = !if(sew, "_" # MInfo.MX # "_E" # sew, "_" # MInfo.MX);
    def suffix : XVPseudoBinaryNoMask<RetClass, Op1Class, Op2Class,
                                     Constraint>;
    def suffix # "_MASK" : VPseudoBinaryMask<RetClass, Op1Class, Op2Class,
                                             Constraint>,
                           RISCVMaskedPseudo<MaskIdx=3>;
  }
}

multiclass XVPseudoTiedBinary<VReg RetClass,
                              DAGOperand Op2Class,
                              LMULInfo MInfo,
                              string Constraint = ""> {
  let VLMul = MInfo.value in {
    def "_" # MInfo.MX # "_TIED": XVPseudoTiedBinaryNoMask<RetClass, Op2Class,
                                                           Constraint>;
    def "_" # MInfo.MX # "_MASK_TIED" : XVPseudoTiedBinaryMask<RetClass, Op2Class,
                                                               Constraint>;
  }
}

multiclass XVPseudoBinaryV_VV<LMULInfo m, string Constraint = "", int sew = 0> {
  defm _VV : XVPseudoBinary<m.vrclass, m.vrclass, m.vrclass, m, Constraint, sew>;
}

multiclass XVPseudoBinaryV_VX<LMULInfo m, string Constraint = "", int sew = 0> {
  defm _VX : XVPseudoBinary<m.vrclass, m.vrclass, GPR, m, Constraint, sew>;
}

multiclass XVPseudoBinaryV_VI<Operand ImmType = simm5, LMULInfo m, string Constraint = ""> {
  defm _VI : XVPseudoBinary<m.vrclass, m.vrclass, ImmType, m, Constraint>;
}

multiclass XVPseudoBinaryW_VV<LMULInfo m> {
  defm _VV : XVPseudoBinary<m.wvrclass, m.vrclass, m.vrclass, m,
                            "@earlyclobber $rd">;
}

multiclass XVPseudoBinaryW_VX<LMULInfo m> {
  defm _VX : XVPseudoBinary<m.wvrclass, m.vrclass, GPR, m,
                            "@earlyclobber $rd">;
}

multiclass XVPseudoBinaryW_WV<LMULInfo m> {
  defm _WV : XVPseudoBinary<m.wvrclass, m.wvrclass, m.vrclass, m,
                            "@earlyclobber $rd">;
  defm _WV : XVPseudoTiedBinary<m.wvrclass, m.vrclass, m,
                                "@earlyclobber $rd">;
}

multiclass XVPseudoBinaryW_WX<LMULInfo m> {
  defm _WX : XVPseudoBinary<m.wvrclass, m.wvrclass, GPR, m>;
}

// In RVV 1.0 `@earlyclobber` is used here to prevent the source and destination
// from overlapping. The case where LMUL <= 1 is excluded because of the
// exception from the 1.0 spec:
// "The destination EEW is smaller than the source EEW and the overlap is in the
//  lowest-numbered part of the source register group."
// However, the 0.7 spec is unclear about the source-destination overlapping of
// narrowing instructions like vnsrl/vnsra. Here we simply follow the 1.0 spec.
multiclass XVPseudoBinaryVNSHT_VV<LMULInfo m> {
  defm _VV : XVPseudoBinary<m.vrclass, m.wvrclass, m.vrclass, m,
                            !if(!ge(m.octuple, 8), "@earlyclobber $rd", "")>;
}

multiclass XVPseudoBinaryVNSHT_VX<LMULInfo m> {
  defm _VX : XVPseudoBinary<m.vrclass, m.wvrclass, GPR, m,
                            !if(!ge(m.octuple, 8), "@earlyclobber $rd", "")>;
}

multiclass XVPseudoBinaryVNSHT_VI<LMULInfo m> {
  defm _VI : XVPseudoBinary<m.vrclass, m.wvrclass, uimm5, m,
                            !if(!ge(m.octuple, 8), "@earlyclobber $rd", "")>;
}

multiclass XVPseudoVALU_VV_VX_VI<Operand ImmType = simm5, string Constraint = ""> {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVIALUV_MX = !cast<SchedWrite>("WriteVIALUV_" # mx);
    defvar WriteVIALUX_MX = !cast<SchedWrite>("WriteVIALUX_" # mx);
    defvar WriteVIALUI_MX = !cast<SchedWrite>("WriteVIALUI_" # mx);
    defvar ReadVIALUV_MX = !cast<SchedRead>("ReadVIALUV_" # mx);
    defvar ReadVIALUX_MX = !cast<SchedRead>("ReadVIALUX_" # mx);

    defm "" : XVPseudoBinaryV_VV<m, Constraint>,
              Sched<[WriteVIALUV_MX, ReadVIALUV_MX, ReadVIALUV_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryV_VX<m, Constraint>,
              Sched<[WriteVIALUX_MX, ReadVIALUV_MX, ReadVIALUX_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryV_VI<ImmType, m, Constraint>,
              Sched<[WriteVIALUI_MX, ReadVIALUV_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVALU_VV_VX {
 foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVIALUV_MX = !cast<SchedWrite>("WriteVIALUV_" # mx);
    defvar WriteVIALUX_MX = !cast<SchedWrite>("WriteVIALUV_" # mx);
    defvar ReadVIALUV_MX = !cast<SchedRead>("ReadVIALUV_" # mx);
    defvar ReadVIALUX_MX = !cast<SchedRead>("ReadVIALUX_" # mx);

    defm "" : XVPseudoBinaryV_VV<m>,
              Sched<[WriteVIALUV_MX, ReadVIALUV_MX, ReadVIALUV_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryV_VX<m>,
              Sched<[WriteVIALUX_MX, ReadVIALUV_MX, ReadVIALUX_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVALU_VX_VI<Operand ImmType = simm5> {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVIALUX_MX = !cast<SchedWrite>("WriteVIALUX_" # mx);
    defvar WriteVIALUI_MX = !cast<SchedWrite>("WriteVIALUI_" # mx);
    defvar ReadVIALUV_MX = !cast<SchedRead>("ReadVIALUV_" # mx);
    defvar ReadVIALUX_MX = !cast<SchedRead>("ReadVIALUX_" # mx);

    defm "" : XVPseudoBinaryV_VX<m>,
              Sched<[WriteVIALUX_MX, ReadVIALUV_MX, ReadVIALUX_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryV_VI<ImmType, m>,
              Sched<[WriteVIALUI_MX, ReadVIALUV_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVWALU_VV_VX {
  foreach m = MxListWXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVIWALUV_MX = !cast<SchedWrite>("WriteVIWALUV_" # mx);
    defvar WriteVIWALUX_MX = !cast<SchedWrite>("WriteVIWALUX_" # mx);
    defvar ReadVIWALUV_MX = !cast<SchedRead>("ReadVIWALUV_" # mx);
    defvar ReadVIWALUX_MX = !cast<SchedRead>("ReadVIWALUX_" # mx);

    defm "" : XVPseudoBinaryW_VV<m>,
            Sched<[WriteVIWALUV_MX, ReadVIWALUV_MX, ReadVIWALUV_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryW_VX<m>,
            Sched<[WriteVIWALUX_MX, ReadVIWALUV_MX, ReadVIWALUX_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVWALU_WV_WX {
  foreach m = MxListWXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVIWALUV_MX = !cast<SchedWrite>("WriteVIWALUV_" # mx);
    defvar WriteVIWALUX_MX = !cast<SchedWrite>("WriteVIWALUX_" # mx);
    defvar ReadVIWALUV_MX = !cast<SchedRead>("ReadVIWALUV_" # mx);
    defvar ReadVIWALUX_MX = !cast<SchedRead>("ReadVIWALUX_" # mx);

    defm "" : XVPseudoBinaryW_WV<m>,
              Sched<[WriteVIWALUV_MX, ReadVIWALUV_MX, ReadVIWALUV_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryW_WX<m>,
              Sched<[WriteVIWALUX_MX, ReadVIWALUV_MX, ReadVIWALUX_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVCALU_VM_XM_IM {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVICALUV_MX = !cast<SchedWrite>("WriteVICALUV_" # mx);
    defvar WriteVICALUX_MX = !cast<SchedWrite>("WriteVICALUX_" # mx);
    defvar WriteVICALUI_MX = !cast<SchedWrite>("WriteVICALUI_" # mx);
    defvar ReadVICALUV_MX = !cast<SchedRead>("ReadVICALUV_" # mx);
    defvar ReadVICALUX_MX = !cast<SchedRead>("ReadVICALUX_" # mx);

    defm "" : VPseudoTiedBinaryV_VM<m>,
              Sched<[WriteVICALUV_MX, ReadVICALUV_MX, ReadVICALUV_MX, ReadVMask]>;
    defm "" : VPseudoTiedBinaryV_XM<m>,
              Sched<[WriteVICALUX_MX, ReadVICALUV_MX, ReadVICALUX_MX, ReadVMask]>;
    defm "" : VPseudoTiedBinaryV_IM<m>,
              Sched<[WriteVICALUI_MX, ReadVICALUV_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVCALUM_VM_XM_IM<string Constraint> {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVICALUV_MX = !cast<SchedWrite>("WriteVICALUV_" # mx);
    defvar WriteVICALUX_MX = !cast<SchedWrite>("WriteVICALUX_" # mx);
    defvar WriteVICALUI_MX = !cast<SchedWrite>("WriteVICALUI_" # mx);
    defvar ReadVICALUV_MX = !cast<SchedRead>("ReadVICALUV_" # mx);
    defvar ReadVICALUX_MX = !cast<SchedRead>("ReadVICALUX_" # mx);

    defm "" : VPseudoBinaryV_VM<m, CarryOut=1, CarryIn=1, Constraint=Constraint>,
              Sched<[WriteVICALUV_MX, ReadVICALUV_MX, ReadVICALUV_MX, ReadVMask]>;
    defm "" : VPseudoBinaryV_XM<m, CarryOut=1, CarryIn=1, Constraint=Constraint>,
              Sched<[WriteVICALUX_MX, ReadVICALUV_MX, ReadVICALUX_MX, ReadVMask]>;
    defm "" : VPseudoBinaryV_IM<m, CarryOut=1, CarryIn=1, Constraint=Constraint>,
              Sched<[WriteVICALUI_MX, ReadVICALUV_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVCALU_VM_XM {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVICALUV_MX = !cast<SchedWrite>("WriteVICALUV_" # mx);
    defvar WriteVICALUX_MX = !cast<SchedWrite>("WriteVICALUX_" # mx);
    defvar ReadVICALUV_MX = !cast<SchedRead>("ReadVICALUV_" # mx);
    defvar ReadVICALUX_MX = !cast<SchedRead>("ReadVICALUX_" # mx);

    defm "" : VPseudoTiedBinaryV_VM<m>,
              Sched<[WriteVICALUV_MX, ReadVICALUV_MX, ReadVICALUV_MX, ReadVMask]>;
    defm "" : VPseudoTiedBinaryV_XM<m>,
              Sched<[WriteVICALUX_MX, ReadVICALUV_MX, ReadVICALUX_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVCALUM_VM_XM<string Constraint> {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVICALUV_MX = !cast<SchedWrite>("WriteVICALUV_" # mx);
    defvar WriteVICALUX_MX = !cast<SchedWrite>("WriteVICALUX_" # mx);
    defvar ReadVICALUV_MX = !cast<SchedRead>("ReadVICALUV_" # mx);
    defvar ReadVICALUX_MX = !cast<SchedRead>("ReadVICALUX_" # mx);

    defm "" : VPseudoBinaryV_VM<m, CarryOut=1, CarryIn=1, Constraint=Constraint>,
              Sched<[WriteVICALUV_MX, ReadVICALUV_MX, ReadVICALUV_MX, ReadVMask]>;
    defm "" : VPseudoBinaryV_XM<m, CarryOut=1, CarryIn=1, Constraint=Constraint>,
              Sched<[WriteVICALUX_MX, ReadVICALUV_MX, ReadVICALUX_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVSHT_VV_VX_VI<Operand ImmType = simm5, string Constraint = ""> {
  foreach m = MxListXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVShiftV_MX = !cast<SchedWrite>("WriteVShiftV_" # mx);
    defvar WriteVShiftX_MX = !cast<SchedWrite>("WriteVShiftX_" # mx);
    defvar WriteVShiftI_MX = !cast<SchedWrite>("WriteVShiftI_" # mx);
    defvar ReadVShiftV_MX = !cast<SchedRead>("ReadVShiftV_" # mx);
    defvar ReadVShiftX_MX = !cast<SchedRead>("ReadVShiftX_" # mx);

    defm "" : XVPseudoBinaryV_VV<m, Constraint>,
              Sched<[WriteVShiftV_MX, ReadVShiftV_MX, ReadVShiftV_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryV_VX<m, Constraint>,
              Sched<[WriteVShiftX_MX, ReadVShiftV_MX, ReadVShiftX_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryV_VI<ImmType, m, Constraint>,
              Sched<[WriteVShiftI_MX, ReadVShiftV_MX, ReadVMask]>;
  }
}

multiclass XVPseudoVNSHT_VV_VX_VI {
  foreach m = MxListWXTHeadV in {
    defvar mx = m.MX;
    defvar WriteVNShiftV_MX = !cast<SchedWrite>("WriteVNShiftV_" # mx);
    defvar WriteVNShiftX_MX = !cast<SchedWrite>("WriteVNShiftX_" # mx);
    defvar WriteVNShiftI_MX = !cast<SchedWrite>("WriteVNShiftI_" # mx);
    defvar ReadVNShiftV_MX = !cast<SchedRead>("ReadVNShiftV_" # mx);
    defvar ReadVNShiftX_MX = !cast<SchedRead>("ReadVNShiftX_" # mx);

    defm "" : XVPseudoBinaryVNSHT_VV<m>,
              Sched<[WriteVNShiftV_MX, ReadVNShiftV_MX, ReadVNShiftV_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryVNSHT_VX<m>,
              Sched<[WriteVNShiftX_MX, ReadVNShiftV_MX, ReadVNShiftX_MX, ReadVMask]>;
    defm "" : XVPseudoBinaryVNSHT_VI<m>,
              Sched<[WriteVNShiftI_MX, ReadVNShiftV_MX, ReadVMask]>;
  }
}

//===----------------------------------------------------------------------===//
// Helpers to define the intrinsic patterns for the XTHeadVector extension.
//===----------------------------------------------------------------------===//

class XVPatBinaryNoMask<string intrinsic_name,
                         string inst,
                         ValueType result_type,
                         ValueType op1_type,
                         ValueType op2_type,
                         int sew,
                         VReg result_reg_class,
                         VReg op1_reg_class,
                         DAGOperand op2_kind> :
  Pat<(result_type (!cast<Intrinsic>(intrinsic_name)
                   (result_type result_reg_class:$merge),
                   (op1_type op1_reg_class:$rs1),
                   (op2_type op2_kind:$rs2),
                   VLOpFrag)),
                   (!cast<Instruction>(inst)
                   (result_type result_reg_class:$merge),
                   (op1_type op1_reg_class:$rs1),
                   (op2_type op2_kind:$rs2),
                   GPR:$vl, sew)>;

class XVPatTiedBinaryNoMask<string intrinsic_name,
                            string inst,
                            ValueType result_type,
                            ValueType op2_type,
                            int sew,
                            VReg result_reg_class,
                            DAGOperand op2_kind> :
  Pat<(result_type (!cast<Intrinsic>(intrinsic_name)
                   (result_type (undef)),
                   (result_type result_reg_class:$rs1),
                   (op2_type op2_kind:$rs2), VLOpFrag)),
                   (!cast<Instruction>(inst#"_TIED")
                   (result_type result_reg_class:$rs1),
                   (op2_type op2_kind:$rs2),
                   GPR:$vl, sew)>;

class XVPatTiedBinaryMask<string intrinsic_name,
                          string inst,
                          ValueType result_type,
                          ValueType op2_type,
                          ValueType mask_type,
                          int sew,
                          VReg result_reg_class,
                          DAGOperand op2_kind> :
  Pat<(result_type (!cast<Intrinsic>(intrinsic_name#"_mask")
                   (result_type result_reg_class:$merge),
                   (result_type result_reg_class:$merge),
                   (op2_type op2_kind:$rs2),
                   (mask_type V0), VLOpFrag)),
                   (!cast<Instruction>(inst#"_MASK_TIED")
                   (result_type result_reg_class:$merge),
                   (op2_type op2_kind:$rs2),
                   (mask_type V0), GPR:$vl, sew)>;

multiclass XVPatBinary<string intrinsic,
                      string inst,
                      ValueType result_type,
                      ValueType op1_type,
                      ValueType op2_type,
                      ValueType mask_type,
                      int sew,
                      VReg result_reg_class,
                      VReg op1_reg_class,
                      DAGOperand op2_kind> {
  def : XVPatBinaryNoMask<intrinsic, inst, result_type, op1_type, op2_type,
                          sew, result_reg_class, op1_reg_class, op2_kind>;
  def : VPatBinaryMask<intrinsic, inst, result_type, op1_type, op2_type,
                       mask_type, sew, result_reg_class, op1_reg_class,
                       op2_kind>;
}

multiclass XVPatBinaryV_VV<string intrinsic, string instruction,
                           list<VTypeInfo> vtilist, bit isSEWAware = 0> {
  foreach vti = vtilist in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : XVPatBinary<intrinsic,
                      !if(isSEWAware,
                          instruction # "_VV_" # vti.LMul.MX # "_E" # vti.SEW,
                          instruction # "_VV_" # vti.LMul.MX),
                      vti.Vector, vti.Vector, vti.Vector,vti.Mask,
                      vti.Log2SEW, vti.RegClass,
                      vti.RegClass, vti.RegClass>;
}

multiclass XVPatBinaryV_VX<string intrinsic, string instruction,
                          list<VTypeInfo> vtilist, bit isSEWAware = 0> {
  foreach vti = vtilist in {
    defvar kind = "V"#vti.ScalarSuffix;
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : XVPatBinary<intrinsic,
                       !if(isSEWAware,
                           instruction#"_"#kind#"_"#vti.LMul.MX#"_E"#vti.SEW,
                           instruction#"_"#kind#"_"#vti.LMul.MX),
                       vti.Vector, vti.Vector, vti.Scalar, vti.Mask,
                       vti.Log2SEW, vti.RegClass,
                       vti.RegClass, vti.ScalarRegClass>;
  }
}

multiclass XVPatBinaryV_VI<string intrinsic, string instruction,
                          list<VTypeInfo> vtilist, Operand imm_type> {
  foreach vti = vtilist in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : XVPatBinary<intrinsic, instruction # "_VI_" # vti.LMul.MX,
                      vti.Vector, vti.Vector, XLenVT, vti.Mask,
                      vti.Log2SEW, vti.RegClass,
                      vti.RegClass, imm_type>;
}

multiclass XVPatBinaryW_VV<string intrinsic, string instruction,
                           list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in
    defm : XVPatBinary<intrinsic, instruction # "_VV_" # Vti.LMul.MX,
                       Wti.Vector, Vti.Vector, Vti.Vector, Vti.Mask,
                       Vti.Log2SEW, Wti.RegClass,
                       Vti.RegClass, Vti.RegClass>;
  }
}

multiclass XVPatBinaryW_VX<string intrinsic, string instruction,
                           list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    defvar kind = "V"#Vti.ScalarSuffix;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in
    defm : XVPatBinary<intrinsic, instruction#"_"#kind#"_"#Vti.LMul.MX,
                       Wti.Vector, Vti.Vector, Vti.Scalar, Vti.Mask,
                       Vti.Log2SEW, Wti.RegClass,
                       Vti.RegClass, Vti.ScalarRegClass>;
  }
}

multiclass XVPatBinaryW_WV<string intrinsic, string instruction,
                           list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in {
      def : XVPatTiedBinaryNoMask<intrinsic, instruction # "_WV_" # Vti.LMul.MX,
                                  Wti.Vector, Vti.Vector,
                                  Vti.Log2SEW, Wti.RegClass, Vti.RegClass>;
      let AddedComplexity = 1 in {
      def : XVPatTiedBinaryMask<intrinsic, instruction # "_WV_" # Vti.LMul.MX,
                                Wti.Vector, Vti.Vector, Vti.Mask,
                                Vti.Log2SEW, Wti.RegClass, Vti.RegClass>;
      }
      def : VPatBinaryMask<intrinsic, instruction # "_WV_" # Vti.LMul.MX,
                            Wti.Vector, Wti.Vector, Vti.Vector, Vti.Mask,
                            Vti.Log2SEW, Wti.RegClass,
                            Wti.RegClass, Vti.RegClass>;
    }
  }
}

multiclass XVPatBinaryW_WX<string intrinsic, string instruction,
                           list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    defvar kind = "W"#Vti.ScalarSuffix;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in
    defm : XVPatBinary<intrinsic, instruction#"_"#kind#"_"#Vti.LMul.MX,
                       Wti.Vector, Wti.Vector, Vti.Scalar, Vti.Mask,
                       Vti.Log2SEW, Wti.RegClass,
                       Wti.RegClass, Vti.ScalarRegClass>;
  }
}

multiclass XVPatBinaryV_VM_TAIL<string intrinsic, string instruction> {
  foreach vti = AllIntegerXVectors in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : VPatBinaryCarryInTAIL<intrinsic, instruction, "VVM",
                                 vti.Vector,
                                 vti.Vector, vti.Vector, vti.Mask,
                                 vti.Log2SEW, vti.LMul, vti.RegClass,
                                 vti.RegClass, vti.RegClass>;
}

multiclass XVPatBinaryV_XM_TAIL<string intrinsic, string instruction> {
  foreach vti = AllIntegerXVectors in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : VPatBinaryCarryInTAIL<intrinsic, instruction,
                                 "V"#vti.ScalarSuffix#"M",
                                 vti.Vector,
                                 vti.Vector, vti.Scalar, vti.Mask,
                                 vti.Log2SEW, vti.LMul, vti.RegClass,
                                 vti.RegClass, vti.ScalarRegClass>;
}

multiclass XVPatBinaryV_IM_TAIL<string intrinsic, string instruction> {
  foreach vti = AllIntegerXVectors in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : VPatBinaryCarryInTAIL<intrinsic, instruction, "VIM",
                                 vti.Vector,
                                 vti.Vector, XLenVT, vti.Mask,
                                 vti.Log2SEW, vti.LMul,
                                 vti.RegClass, vti.RegClass, simm5>;
}
multiclass XVPatBinaryV_VM<string intrinsic, string instruction,
                           bit CarryOut = 0,
                           list<VTypeInfo> vtilist = AllIntegerXVectors> {
  foreach vti = vtilist in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : VPatBinaryCarryIn<intrinsic, instruction, "VVM",
                             !if(CarryOut, vti.Mask, vti.Vector),
                             vti.Vector, vti.Vector, vti.Mask,
                             vti.Log2SEW, vti.LMul,
                             vti.RegClass, vti.RegClass>;
}

multiclass XVPatBinaryV_XM<string intrinsic, string instruction,
                           bit CarryOut = 0,
                           list<VTypeInfo> vtilist = AllIntegerXVectors> {
  foreach vti = vtilist in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : VPatBinaryCarryIn<intrinsic, instruction,
                             "V"#vti.ScalarSuffix#"M",
                             !if(CarryOut, vti.Mask, vti.Vector),
                             vti.Vector, vti.Scalar, vti.Mask,
                             vti.Log2SEW, vti.LMul,
                             vti.RegClass, vti.ScalarRegClass>;
}

multiclass XVPatBinaryV_IM<string intrinsic, string instruction,
                           bit CarryOut = 0> {
  foreach vti = AllIntegerXVectors in
    let Predicates = GetXVTypePredicates<vti>.Predicates in
    defm : VPatBinaryCarryIn<intrinsic, instruction, "VIM",
                             !if(CarryOut, vti.Mask, vti.Vector),
                             vti.Vector, XLenVT, vti.Mask,
                             vti.Log2SEW, vti.LMul,
                             vti.RegClass, simm5>;
}

multiclass XVPatBinaryVNSHT_VV<string intrinsic, string instruction,
                               list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in
    defm : XVPatBinary<intrinsic, instruction # "_VV_" # Vti.LMul.MX,
                       Vti.Vector, Wti.Vector, Vti.Vector, Vti.Mask,
                       Vti.Log2SEW, Vti.RegClass,
                       Wti.RegClass, Vti.RegClass>;
  }
}

multiclass XVPatBinaryVNSHT_VX<string intrinsic, string instruction,
                               list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    defvar kind = "V"#Vti.ScalarSuffix;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in
    defm : XVPatBinary<intrinsic, instruction#"_"#kind#"_"#Vti.LMul.MX,
                       Vti.Vector, Wti.Vector, Vti.Scalar, Vti.Mask,
                       Vti.Log2SEW, Vti.RegClass,
                       Wti.RegClass, Vti.ScalarRegClass>;
  }
}

multiclass XVPatBinaryVNSHT_VI<string intrinsic, string instruction,
                               list<VTypeInfoToWide> vtilist> {
  foreach VtiToWti = vtilist in {
    defvar Vti = VtiToWti.Vti;
    defvar Wti = VtiToWti.Wti;
    let Predicates = !listconcat(GetXVTypePredicates<Vti>.Predicates,
                                 GetXVTypePredicates<Wti>.Predicates) in
    defm : XVPatBinary<intrinsic, instruction # "_VI_" # Vti.LMul.MX,
                       Vti.Vector, Wti.Vector, XLenVT, Vti.Mask,
                       Vti.Log2SEW, Vti.RegClass,
                       Wti.RegClass, uimm5>;
  }
}

multiclass XVPatBinaryV_VV_VX_VI<string intrinsic, string instruction,
                                 list<VTypeInfo> vtilist, Operand ImmType = simm5>
    : XVPatBinaryV_VV<intrinsic, instruction, vtilist>,
      XVPatBinaryV_VX<intrinsic, instruction, vtilist>,
      XVPatBinaryV_VI<intrinsic, instruction, vtilist, ImmType>;

multiclass XVPatBinaryV_VV_VX<string intrinsic, string instruction,
                              list<VTypeInfo> vtilist, bit isSEWAware = 0>
    : XVPatBinaryV_VV<intrinsic, instruction, vtilist, isSEWAware>,
      XVPatBinaryV_VX<intrinsic, instruction, vtilist, isSEWAware>;

multiclass XVPatBinaryV_VX_VI<string intrinsic, string instruction,
                              list<VTypeInfo> vtilist>
    : XVPatBinaryV_VX<intrinsic, instruction, vtilist>,
      XVPatBinaryV_VI<intrinsic, instruction, vtilist, simm5>;

multiclass XVPatBinaryW_VV_VX<string intrinsic, string instruction,
                              list<VTypeInfoToWide> vtilist>
    : XVPatBinaryW_VV<intrinsic, instruction, vtilist>,
      XVPatBinaryW_VX<intrinsic, instruction, vtilist>;

multiclass XVPatBinaryW_WV_WX<string intrinsic, string instruction,
                              list<VTypeInfoToWide> vtilist>
    : XVPatBinaryW_WV<intrinsic, instruction, vtilist>,
      XVPatBinaryW_WX<intrinsic, instruction, vtilist>;

multiclass XVPatBinaryV_VM_XM_IM<string intrinsic, string instruction>
    : XVPatBinaryV_VM_TAIL<intrinsic, instruction>,
      XVPatBinaryV_XM_TAIL<intrinsic, instruction>,
      XVPatBinaryV_IM_TAIL<intrinsic, instruction>;

multiclass XVPatBinaryM_VM_XM_IM<string intrinsic, string instruction>
    : XVPatBinaryV_VM<intrinsic, instruction, CarryOut=1>,
      XVPatBinaryV_XM<intrinsic, instruction, CarryOut=1>,
      XVPatBinaryV_IM<intrinsic, instruction, CarryOut=1>;

multiclass XVPatBinaryV_VM_XM<string intrinsic, string instruction>
    : XVPatBinaryV_VM_TAIL<intrinsic, instruction>,
      XVPatBinaryV_XM_TAIL<intrinsic, instruction>;

multiclass XVPatBinaryM_VM_XM<string intrinsic, string instruction>
    : XVPatBinaryV_VM<intrinsic, instruction, CarryOut=1>,
      XVPatBinaryV_XM<intrinsic, instruction, CarryOut=1>;

multiclass XVPatBinaryVNSHT_VV_VX_VI<string intrinsic, string instruction,
                                     list<VTypeInfoToWide> vtilist>
    : XVPatBinaryVNSHT_VV<intrinsic, instruction, vtilist>,
      XVPatBinaryVNSHT_VX<intrinsic, instruction, vtilist>,
      XVPatBinaryVNSHT_VI<intrinsic, instruction, vtilist>;

//===----------------------------------------------------------------------===//
// 12.1. Vector Single-Width Saturating Add and Subtract
//===----------------------------------------------------------------------===//
let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VADD   : XVPseudoVALU_VV_VX_VI;
  defm PseudoTH_VSUB   : XVPseudoVALU_VV_VX;
  defm PseudoTH_VRSUB  : XVPseudoVALU_VX_VI;

  foreach vti = AllIntegerXVectors in {
    // Match vrsub with 2 vector operands to th.vsub.vv by swapping operands. This
    // Occurs when legalizing th.vrsub.vx intrinsics for i64 on RV32 since we need
    // to use a more complex splat sequence. Add the pattern for all VTs for
    // consistency.
    let Predicates = GetXVTypePredicates<vti>.Predicates in {
      def : Pat<(vti.Vector (int_riscv_th_vrsub (vti.Vector vti.RegClass:$merge),
                                                (vti.Vector vti.RegClass:$rs2),
                                                (vti.Vector vti.RegClass:$rs1),
                                                VLOpFrag)),
                (!cast<Instruction>("PseudoTH_VSUB_VV_"#vti.LMul.MX)
                                                          vti.RegClass:$merge,
                                                          vti.RegClass:$rs1,
                                                          vti.RegClass:$rs2,
                                                          GPR:$vl,
                                                          vti.Log2SEW)>;
      def : Pat<(vti.Vector (int_riscv_th_vrsub_mask (vti.Vector vti.RegClass:$merge),
                                                     (vti.Vector vti.RegClass:$rs2),
                                                     (vti.Vector vti.RegClass:$rs1),
                                                     (vti.Mask V0),
                                                     VLOpFrag)),
                (!cast<Instruction>("PseudoTH_VSUB_VV_"#vti.LMul.MX#"_MASK")
                                                          vti.RegClass:$merge,
                                                          vti.RegClass:$rs1,
                                                          vti.RegClass:$rs2,
                                                          (vti.Mask V0),
                                                          GPR:$vl,
                                                          vti.Log2SEW)>;

    // Match th.vsub with a small immediate to th.vadd.vi by negating the immediate.
    def : Pat<(vti.Vector (int_riscv_th_vsub (vti.Vector (undef)),
                                             (vti.Vector vti.RegClass:$rs1),
                                             (vti.Scalar simm5_plus1:$rs2),
                                             VLOpFrag)),
              (!cast<Instruction>("PseudoTH_VADD_VI_"#vti.LMul.MX) (vti.Vector (IMPLICIT_DEF)),
                                                                vti.RegClass:$rs1,
                                                                (NegImm simm5_plus1:$rs2),
                                                                GPR:$vl,
                                                                vti.Log2SEW)>;
    def : Pat<(vti.Vector (int_riscv_th_vsub_mask (vti.Vector vti.RegClass:$merge),
                                                  (vti.Vector vti.RegClass:$rs1),
                                                  (vti.Scalar simm5_plus1:$rs2),
                                                  (vti.Mask V0),
                                                  VLOpFrag)),
              (!cast<Instruction>("PseudoTH_VADD_VI_"#vti.LMul.MX#"_MASK")
                                                        vti.RegClass:$merge,
                                                        vti.RegClass:$rs1,
                                                        (NegImm simm5_plus1:$rs2),
                                                        (vti.Mask V0),
                                                        GPR:$vl,
                                                        vti.Log2SEW)>;
    }
  }
} // Predicates = [HasVendorXTHeadV]

let Predicates = [HasVendorXTHeadV] in {
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vadd", "PseudoTH_VADD", AllIntegerXVectors>;
  defm : XVPatBinaryV_VV_VX<"int_riscv_th_vsub", "PseudoTH_VSUB", AllIntegerXVectors>;
  defm : XVPatBinaryV_VX_VI<"int_riscv_th_vrsub", "PseudoTH_VRSUB", AllIntegerXVectors>;
} // Predicates = [HasVendorXTHeadV]

//===----------------------------------------------------------------------===//
// 12.2. Vector Widening Integer Add/Subtract
//===----------------------------------------------------------------------===//
let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VWADDU : XVPseudoVWALU_VV_VX;
  defm PseudoTH_VWSUBU : XVPseudoVWALU_VV_VX;
  defm PseudoTH_VWADD  : XVPseudoVWALU_VV_VX;
  defm PseudoTH_VWSUB  : XVPseudoVWALU_VV_VX;
  defm PseudoTH_VWADDU : XVPseudoVWALU_WV_WX;
  defm PseudoTH_VWSUBU : XVPseudoVWALU_WV_WX;
  defm PseudoTH_VWADD  : XVPseudoVWALU_WV_WX;
  defm PseudoTH_VWSUB  : XVPseudoVWALU_WV_WX;
}

let Predicates = [HasVendorXTHeadV] in {
  defm : XVPatBinaryW_VV_VX<"int_riscv_th_vwaddu", "PseudoTH_VWADDU", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_VV_VX<"int_riscv_th_vwsubu", "PseudoTH_VWSUBU", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_VV_VX<"int_riscv_th_vwadd", "PseudoTH_VWADD", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_VV_VX<"int_riscv_th_vwsub", "PseudoTH_VWSUB", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_WV_WX<"int_riscv_th_vwaddu_w", "PseudoTH_VWADDU", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_WV_WX<"int_riscv_th_vwsubu_w", "PseudoTH_VWSUBU", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_WV_WX<"int_riscv_th_vwadd_w", "PseudoTH_VWADD", AllWidenableIntXVectors>;
  defm : XVPatBinaryW_WV_WX<"int_riscv_th_vwsub_w", "PseudoTH_VWSUB", AllWidenableIntXVectors>;
}

//===----------------------------------------------------------------------===//
// 12.3. Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions
//===----------------------------------------------------------------------===//
let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VADC   : XVPseudoVCALU_VM_XM_IM;
  defm PseudoTH_VMADC  : XVPseudoVCALUM_VM_XM_IM<"@earlyclobber $rd">;

  defm PseudoTH_VSBC  : XVPseudoVCALU_VM_XM;
  defm PseudoTH_VMSBC : XVPseudoVCALUM_VM_XM<"@earlyclobber $rd">;
} // Predicates = [HasVendorXTHeadV]

let Predicates = [HasVendorXTHeadV] in {
  defm : XVPatBinaryV_VM_XM_IM<"int_riscv_th_vadc", "PseudoTH_VADC">;
  defm : XVPatBinaryM_VM_XM_IM<"int_riscv_th_vmadc_carry_in", "PseudoTH_VMADC">;

  defm : XVPatBinaryV_VM_XM<"int_riscv_th_vsbc", "PseudoTH_VSBC">;
  defm : XVPatBinaryM_VM_XM<"int_riscv_th_vmsbc_borrow_in", "PseudoTH_VMSBC">;
} // Predicates = [HasVendorXTHeadV]

//===----------------------------------------------------------------------===//
// 12.4. Vector Bitwise Logical Instructions
//===----------------------------------------------------------------------===//
let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VAND : XVPseudoVALU_VV_VX_VI;
  defm PseudoTH_VOR  : XVPseudoVALU_VV_VX_VI;
  defm PseudoTH_VXOR : XVPseudoVALU_VV_VX_VI;
}

let Predicates = [HasVendorXTHeadV] in {
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vand", "PseudoTH_VAND", AllIntegerXVectors>;
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vor", "PseudoTH_VOR", AllIntegerXVectors>;
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vxor", "PseudoTH_VXOR", AllIntegerXVectors>;
}

//===----------------------------------------------------------------------===//
// 12.5. Vector Single-Width Bit Shift Instructions
//===----------------------------------------------------------------------===//
let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VSLL : XVPseudoVSHT_VV_VX_VI<uimm5>;
  defm PseudoTH_VSRL : XVPseudoVSHT_VV_VX_VI<uimm5>;
  defm PseudoTH_VSRA : XVPseudoVSHT_VV_VX_VI<uimm5>;
} // Predicates = [HasVendorXTHeadV]

let Predicates = [HasVendorXTHeadV] in {
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vsll", "PseudoTH_VSLL", AllIntegerXVectors,
                               uimm5>;
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vsrl", "PseudoTH_VSRL", AllIntegerXVectors,
                               uimm5>;
  defm : XVPatBinaryV_VV_VX_VI<"int_riscv_th_vsra", "PseudoTH_VSRA", AllIntegerXVectors,
                               uimm5>;

  foreach vti = AllIntegerXVectors in {
    // Emit shift by 1 as an add since it might be faster.
    let Predicates = GetXVTypePredicates<vti>.Predicates in {
      def : Pat<(vti.Vector (int_riscv_th_vsll (vti.Vector undef),
                                               (vti.Vector vti.RegClass:$rs1),
                                               (XLenVT 1), VLOpFrag)),
                (!cast<Instruction>("PseudoTH_VADD_VV_"#vti.LMul.MX)
                  (vti.Vector (IMPLICIT_DEF)), vti.RegClass:$rs1,
                  vti.RegClass:$rs1, GPR:$vl, vti.Log2SEW)>;
      def : Pat<(vti.Vector (int_riscv_th_vsll_mask (vti.Vector vti.RegClass:$merge),
                                                    (vti.Vector vti.RegClass:$rs1),
                                                    (XLenVT 1),
                                                    (vti.Mask V0),
                                                    VLOpFrag)),
                (!cast<Instruction>("PseudoTH_VADD_VV_"#vti.LMul.MX#"_MASK")
                                                            vti.RegClass:$merge,
                                                            vti.RegClass:$rs1,
                                                            vti.RegClass:$rs1,
                                                            (vti.Mask V0),
                                                            GPR:$vl,
                                                            vti.Log2SEW)>;
    }
  }
} // Predicates = [HasVendorXTHeadV]

//===----------------------------------------------------------------------===//
// 12.6. Vector Narrowing Integer Right Shift Instructions
//===----------------------------------------------------------------------===//
let Predicates = [HasVendorXTHeadV] in {
  defm PseudoTH_VNSRL : XVPseudoVNSHT_VV_VX_VI;
  defm PseudoTH_VNSRA : XVPseudoVNSHT_VV_VX_VI;
} // Predicates = [HasVendorXTHeadV]

let Predicates = [HasVendorXTHeadV] in {
  defm : XVPatBinaryVNSHT_VV_VX_VI<"int_riscv_th_vnsrl", "PseudoTH_VNSRL", AllWidenableIntXVectors>;
  defm : XVPatBinaryVNSHT_VV_VX_VI<"int_riscv_th_vnsra", "PseudoTH_VNSRA", AllWidenableIntXVectors>;
}

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
    // From RVV Spec 1.0: "These instructions are intended to aid compilers to
    // shuffle vector registers without needing to know or change vl or vtype."
    // The 1, 2, 4, 8 in suffixes are "the number of individual vector registers, NREG, to copy".
    def PseudoTH_VMV1R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M1, VR>;
    def PseudoTH_VMV2R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M2, VRM2>;
    def PseudoTH_VMV4R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M4, VRM4>;
    def PseudoTH_VMV8R_V : XVPseudoWholeMove<TH_VMV_V_V, V_M8, VRM8>;
  }
} // Predicates = [HasVendorXTHeadV]
