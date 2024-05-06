//===-- RISCVInstrInfoXTHeadVVLPatterns.td - RVV VL patterns -----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------------===//
///
/// This file contains the required infrastructure and VL patterns to support
/// code generation for the standard 'V' (Vector) extension, version 0.7.1
///
/// This file is included from RISCVInstrInfoXTHeadVPseudos.td
//===---------------------------------------------------------------------------===//

def riscv_th_vmv_v_x_vl : SDNode<"RISCVISD::TH_VMV_V_X_VL",
                              SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisInt<0>,
                                                   SDTCisSameAs<0, 1>,
                                                   SDTCisVT<2, XLenVT>,
                                                   SDTCisVT<3, XLenVT>]>>;

def riscv_th_vfmv_v_f_vl : SDNode<"RISCVISD::TH_VFMV_V_F_VL",
                               SDTypeProfile<1, 3, [SDTCisVec<0>, SDTCisFP<0>,
                                                    SDTCisSameAs<0, 1>,
                                                    SDTCisEltOfVec<2, 0>,
                                                    SDTCisVT<3, XLenVT>]>>;

foreach vti = AllXVectors in {
  foreach vti = AllIntegerXVectors in {
      def : Pat<(vti.Vector (riscv_th_vmv_v_x_vl vti.RegClass:$passthru, GPR:$rs2, VLOpFrag)),
                (!cast<Instruction>("PseudoTH_VMV_V_X_"#vti.LMul.MX)
                vti.RegClass:$passthru, GPR:$rs2, GPR:$vl, vti.Log2SEW)>;
      defvar ImmPat = !cast<ComplexPattern>("sew"#vti.SEW#"simm5");
      def : Pat<(vti.Vector (riscv_th_vmv_v_x_vl vti.RegClass:$passthru, (ImmPat simm5:$imm5),
                                                  VLOpFrag)),
                (!cast<Instruction>("PseudoTH_VMV_V_I_"#vti.LMul.MX)
                vti.RegClass:$passthru, simm5:$imm5, GPR:$vl, vti.Log2SEW)>;
  }
}

foreach fvti = AllFloatXVectors in {
  let Predicates = GetXVTypePredicates<fvti>.Predicates in {
    def : Pat<(fvti.Vector (riscv_th_vfmv_v_f_vl
                           fvti.Vector:$passthru, (fvti.Scalar (fpimm0)), VLOpFrag)),
              (!cast<Instruction>("PseudoTH_VMV_V_I_"#fvti.LMul.MX)
               $passthru, 0, GPR:$vl, fvti.Log2SEW)>;
    def : Pat<(fvti.Vector (riscv_th_vfmv_v_f_vl
                           fvti.Vector:$passthru, (fvti.Scalar (SelectFPImm (XLenVT GPR:$imm))), VLOpFrag)),
              (!cast<Instruction>("PseudoTH_VMV_V_X_"#fvti.LMul.MX)
               $passthru, GPR:$imm, GPR:$vl, fvti.Log2SEW)>;

    def : Pat<(fvti.Vector (riscv_th_vfmv_v_f_vl
                           fvti.Vector:$passthru, (fvti.Scalar fvti.ScalarRegClass:$rs2), VLOpFrag)),
              (!cast<Instruction>("PseudoTH_VFMV_V_" # fvti.ScalarSuffix # "_" #
                                  fvti.LMul.MX)
               $passthru, (fvti.Scalar fvti.ScalarRegClass:$rs2),
               GPR:$vl, fvti.Log2SEW)>;
  }
}
