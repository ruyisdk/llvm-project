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

//===----------------------------------------------------------------------===//
// Pseudos. These are used internally during code generation.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// 6. Configuration-Setting Instructions
//===----------------------------------------------------------------------===//

let hasSideEffects = 1, mayLoad = 0, mayStore = 0, Defs = [VL, VTYPE] in {
  def PseudoXVSETVLI : Pseudo<(outs GPR:$rd), (ins GPRNoX0:$rs1, XTHeadVTypeI:$vtypei), []>,
                       Sched<[WriteVSETVLI, ReadVSETVLI]>;
  def PseudoXVSETVLIX0 : Pseudo<(outs GPR:$rd), (ins GPRX0:$rs1, XTHeadVTypeI:$vtypei), []>,
                         Sched<[WriteVSETVLI, ReadVSETVLI]>;
}

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
    foreach lmul = [V_M1, V_M2, V_M4, V_M8] in {
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

defm PseudoXVAMOSWAP : XVPseudoAMO;
defm PseudoXVAMOADD  : XVPseudoAMO;
defm PseudoXVAMOXOR  : XVPseudoAMO;
defm PseudoXVAMOAND  : XVPseudoAMO;
defm PseudoXVAMOOR   : XVPseudoAMO;
defm PseudoXVAMOMIN  : XVPseudoAMO;
defm PseudoXVAMOMAX  : XVPseudoAMO;
defm PseudoXVAMOMINU : XVPseudoAMO;
defm PseudoXVAMOMAXU : XVPseudoAMO;

//===----------------------------------------------------------------------===//
// 12. Vector Integer Arithmetic Instructions
//===----------------------------------------------------------------------===//
defm PseudoXVADD   : VPseudoVALU_VV_VX_VI;

//===----------------------------------------------------------------------===//
// Patterns. Enabling code generation from intrinsics to pseudos, then to asms.
//===----------------------------------------------------------------------===//

defm : VPatBinaryV_VV_VX_VI<"int_riscv_xvadd", "PseudoXVADD", AllIntegerXVectors>;

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

let Predicates = [HasVendorXTHeadV, HasVendorXTHeadVamo, HasStdExtA] in {
  defm : XVPatAMOV_WD<"int_riscv_xvamoswap", "PseudoXVAMOSWAP", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamoadd", "PseudoXVAMOADD", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamoxor", "PseudoXVAMOXOR", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamoand", "PseudoXVAMOAND", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamoor", "PseudoXVAMOOR", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamomin", "PseudoXVAMOMIN", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamomax", "PseudoXVAMOMAX", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamominu", "PseudoXVAMOMINU", AllIntegerXVectors>;
  defm : XVPatAMOV_WD<"int_riscv_xvamomaxu", "PseudoXVAMOMAXU", AllIntegerXVectors>;
} // Predicates = [HasVendorXTHeadV, HasVendorXTHeadVamo, HasStdExtA]
