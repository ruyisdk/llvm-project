//===-- RISCVInstrInfoZtt.td - Ztt instructions ----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

def ZTTMAsmOperand : AsmOperandClass {
  let Name = "ZTTMRegister";
  let RenderMethod = "addRegOperands";
  let PredicateMethod = "isZTTMRegister";
  let ParserMethod = "parseZTTMRegister";
  let DiagnosticType = "InvalidZTTMRegister";
}

def ZTTMOp : RegisterOperand<ZTTMR> {
  let ParserMatchClass = ZTTMAsmOperand;
  let DecoderMethod = "DecodeZTTMRRegisterClass";
}

def ZTTAAsmOperand : AsmOperandClass {
  let Name = "ZTTARegister";
  let RenderMethod = "addRegOperands";
  let PredicateMethod = "isZTTARegister";
  let ParserMethod = "parseZTTARegister";
  let DiagnosticType = "InvalidZTTARegister";
}

def ZTTAOp : RegisterOperand<ZTTAR> {
  let ParserMatchClass = ZTTAAsmOperand;
  let DecoderMethod = "DecodeZTTARRegisterClass";
}

// Register layouts are named Dst_Src1_Src2; X denotes a GPR.
class ZttOperands<dag outs, dag ins> {
  dag Outs = outs;
  dag Ins = ins;
}

def ZttA_M_M : ZttOperands<(outs ZTTAOp:$rd), (ins ZTTMOp:$rs1, ZTTMOp:$rs2)>;
def ZttM_M_M : ZttOperands<(outs ZTTMOp:$rd), (ins ZTTMOp:$rs1, ZTTMOp:$rs2)>;
def ZttM_X_M : ZttOperands<(outs ZTTMOp:$rd), (ins GPR:$rs1, ZTTMOp:$rs2)>;
def ZttM_X_X : ZttOperands<(outs ZTTMOp:$rd), (ins GPR:$rs1, GPR:$rs2)>;
def ZttA_M : ZttOperands<(outs ZTTAOp:$rd), (ins ZTTMOp:$rs1)>;
def ZttA_X : ZttOperands<(outs ZTTAOp:$rd), (ins GPR:$rs1)>;
def ZttM_A : ZttOperands<(outs ZTTMOp:$rd), (ins ZTTAOp:$rs1)>;
def ZttM_M : ZttOperands<(outs ZTTMOp:$rd), (ins ZTTMOp:$rs1)>;
def ZttM_X : ZttOperands<(outs ZTTMOp:$rd), (ins GPR:$rs1)>;
def ZttX_A : ZttOperands<(outs GPR:$rd), (ins ZTTAOp:$rs1)>;
def ZttX_M : ZttOperands<(outs GPR:$rd), (ins ZTTMOp:$rs1)>;
def ZttX_X : ZttOperands<(outs GPR:$rd), (ins GPR:$rs1)>;
def ZttA : ZttOperands<(outs ZTTAOp:$rd), (ins)>;
def ZttM : ZttOperands<(outs ZTTMOp:$rd), (ins)>;

class ZttInst<bits<7> funct7, dag outs, dag ins, string name, string args>
    : RVInstR<funct7, 0b000, OPC_CUSTOM_1, outs, ins, name, args> {
  let hasSideEffects = 0;
  let mayLoad = 0;
  let mayStore = 0;
}

// One result and two register inputs.
class ZttBinaryInst<bits<7> funct7, string name, ZttOperands operands>
    : ZttInst<funct7, operands.Outs, operands.Ins,
              name, "$rd, $rs1, $rs2">;

// One result and one register input.
class ZttUnaryInst<bits<7> funct7, bits<5> selector, string name,
                   ZttOperands operands>
    : ZttInst<funct7, operands.Outs, operands.Ins, name, "$rd, $rs1"> {
  let rs2 = selector;
}

// Matrix construction without register inputs.
class ZttGenerateInst<bits<5> selector, string name, ZttOperands operands>
    : ZttInst<0b1010011, operands.Outs, operands.Ins, name, "$rd"> {
  let rs1 = selector;
  let rs2 = 0b00000;
}

// In-place zip/unzip; tied operands describe all register effects.
class ZttZipInst<bits<7> funct7, string name>
    : ZttInst<funct7, (outs ZTTMOp:$rs1, ZTTMOp:$rs2),
              (ins ZTTMOp:$src1, ZTTMOp:$src2), name, "$rs1, $rs2"> {
  let rd = 0b00000;
  let Constraints = "$src1 = $rs1, $src2 = $rs2";
}

// Non-strided matrix or whole-register loads/stores.
class ZttMemoryInst<bits<5> selector, string name, bit store>
    : ZttInst<0b1010001, !if(store, (outs), (outs ZTTMOp:$rd)),
              !if(store, (ins ZTTMOp:$rd, GPR:$rs1), (ins GPR:$rs1)),
              name, "$rd, $rs1"> {
  let rs2 = selector;
  let mayLoad = !not(store);
  let mayStore = store;
}

// Strided matrix loads/stores; rs2 holds the byte stride.
class ZttStridedMemoryInst<bits<7> funct7, string name, bit store>
    : ZttInst<funct7, !if(store, (outs), (outs ZTTMOp:$rd)),
              !if(store, (ins ZTTMOp:$rd, GPR:$rs1, GPR:$rs2),
                         (ins GPR:$rs1, GPR:$rs2)),
              name, "$rd, (${rs1}), $rs2"> {
  let mayLoad = !not(store);
  let mayStore = store;
}

let Predicates = [HasStdExtZtt] in {
  let hasSideEffects = 1 in {
    def ZTT_AME_RELEASE : ZttInst<0b1010010, (outs), (ins), "ame.release", ""> {
      let rd = 0b00000;
      let rs1 = 0b00000;
      let rs2 = 0b01010;
    }
  }

  def ZTT_MGETTYP : ZttUnaryInst<0b1010001, 0b00010, "mgettyp", ZttX_M>;

  def ZTT_AGETTYP : ZttUnaryInst<0b1010001, 0b00000, "agettyp", ZttX_A>;

  def ZTT_MABS_EW : ZttUnaryInst<0b1010001, 0b00100, "mabs.ew", ZttM_M>;
  def ZTT_MFRINTM_EW : ZttUnaryInst<0b1010001, 0b00101, "mfrintm.ew", ZttM_M>;
  def ZTT_MFRINTN_EW : ZttUnaryInst<0b1010001, 0b00110, "mfrintn.ew", ZttM_M>;
  def ZTT_MFRINTP_EW : ZttUnaryInst<0b1010001, 0b00111, "mfrintp.ew", ZttM_M>;
  def ZTT_MFRINTZ_EW : ZttUnaryInst<0b1010001, 0b01000, "mfrintz.ew", ZttM_M>;
  def ZTT_MCONV_EW : ZttUnaryInst<0b1010001, 0b01101, "mconv.ew", ZttM_M>;
  def ZTT_MCOS_EW : ZttUnaryInst<0b1010001, 0b01110, "mcos.ew", ZttM_M>;
  def ZTT_MEXP2_EW : ZttUnaryInst<0b1010001, 0b01111, "mexp2.ew", ZttM_M>;
  def ZTT_MLOG2_EW : ZttUnaryInst<0b1010001, 0b10000, "mlog2.ew", ZttM_M>;
  def ZTT_MREC_EW : ZttUnaryInst<0b1010001, 0b10001, "mrec.ew", ZttM_M>;
  def ZTT_MRSQRT_EW : ZttUnaryInst<0b1010001, 0b10010, "mrsqrt.ew", ZttM_M>;
  def ZTT_MSIN_EW : ZttUnaryInst<0b1010001, 0b10011, "msin.ew", ZttM_M>;
  def ZTT_MSQRT_EW : ZttUnaryInst<0b1010001, 0b10100, "msqrt.ew", ZttM_M>;
  def ZTT_MTANH_EW : ZttUnaryInst<0b1010001, 0b10101, "mtanh.ew", ZttM_M>;
  def ZTT_MMOV_M_M : ZttUnaryInst<0b1010001, 0b11110, "mmov.m.m", ZttM_M>;
  def ZTT_MPREFIXADD_COL : ZttUnaryInst<0b1010001, 0b11111, "mprefixadd.col", ZttM_M>;
  def ZTT_MPREFIXADD_ROW : ZttUnaryInst<0b1010010, 0b00000, "mprefixadd.row", ZttM_M>;
  def ZTT_MPREFIXMAX_COL : ZttUnaryInst<0b1010010, 0b00001, "mprefixmax.col", ZttM_M>;
  def ZTT_MPREFIXMAX_ROW : ZttUnaryInst<0b1010010, 0b00010, "mprefixmax.row", ZttM_M>;
  def ZTT_MREDUCEADD_COL : ZttUnaryInst<0b1010010, 0b00011, "mreduceadd.col", ZttM_M>;
  def ZTT_MREDUCEADD_ROW : ZttUnaryInst<0b1010010, 0b00100, "mreduceadd.row", ZttM_M>;
  def ZTT_MREDUCEMAX_COL : ZttUnaryInst<0b1010010, 0b00101, "mreducemax.col", ZttM_M>;
  def ZTT_MREDUCEMAX_ROW : ZttUnaryInst<0b1010010, 0b00110, "mreducemax.row", ZttM_M>;
  def ZTT_MREDUCEMIN_COL : ZttUnaryInst<0b1010010, 0b00111, "mreducemin.col", ZttM_M>;
  def ZTT_MREDUCEMIN_ROW : ZttUnaryInst<0b1010010, 0b01000, "mreducemin.row", ZttM_M>;

  def ZTT_MMOV_M_A : ZttUnaryInst<0b1010001, 0b11100, "mmov.m.a", ZttM_A>;

  def ZTT_MMOV_A_M : ZttUnaryInst<0b1010001, 0b11101, "mmov.a.m", ZttA_M>;

  let hasSideEffects = 1 in {
    def ZTT_MSETTYP : ZttUnaryInst<0b1010001, 0b00011, "msettyp", ZttM_X>;
  }

  let hasSideEffects = 1 in {
    def ZTT_ASETTYP : ZttUnaryInst<0b1010001, 0b00001, "asettyp", ZttA_X>;
  }

  let hasSideEffects = 1 in {
    def ZTT_AME_ACQUIRE : ZttUnaryInst<0b1010010, 0b01001, "ame.acquire", ZttX_X>;
  }

  def ZTT_MABSDIFF_EW : ZttBinaryInst<0b0000000, "mabsdiff.ew", ZttM_M_M>;
  def ZTT_MADD_EW : ZttBinaryInst<0b0000010, "madd.ew", ZttM_M_M>;
  def ZTT_MHDIFF_EW : ZttBinaryInst<0b0000100, "mhdiff.ew", ZttM_M_M>;
  def ZTT_MMAX_EW : ZttBinaryInst<0b0000110, "mmax.ew", ZttM_M_M>;
  def ZTT_MMEAN_EW : ZttBinaryInst<0b0001000, "mmean.ew", ZttM_M_M>;
  def ZTT_MMIN_EW : ZttBinaryInst<0b0001010, "mmin.ew", ZttM_M_M>;
  def ZTT_MMUL_EW : ZttBinaryInst<0b0001100, "mmul.ew", ZttM_M_M>;
  def ZTT_MMULACC_EW : ZttBinaryInst<0b0001110, "mmulacc.ew", ZttM_M_M>;
  def ZTT_MMULACCNEG_EW : ZttBinaryInst<0b0010000, "mmulaccneg.ew", ZttM_M_M>;
  def ZTT_MMULADD_EW : ZttBinaryInst<0b0010010, "mmuladd.ew", ZttM_M_M>;
  def ZTT_MMULNEG_EW : ZttBinaryInst<0b0010100, "mmulneg.ew", ZttM_M_M>;
  def ZTT_MMULSUB_EW : ZttBinaryInst<0b0010110, "mmulsub.ew", ZttM_M_M>;
  def ZTT_MSUB_EW : ZttBinaryInst<0b0011000, "msub.ew", ZttM_M_M>;
  def ZTT_MAND_EW : ZttBinaryInst<0b0011010, "mand.ew", ZttM_M_M>;
  def ZTT_MANDNOT_EW : ZttBinaryInst<0b0011100, "mandnot.ew", ZttM_M_M>;
  def ZTT_MOR_EW : ZttBinaryInst<0b0011110, "mor.ew", ZttM_M_M>;
  def ZTT_MORNOT_EW : ZttBinaryInst<0b0100000, "mornot.ew", ZttM_M_M>;
  def ZTT_MSLL_EW : ZttBinaryInst<0b0100010, "msll.ew", ZttM_M_M>;
  def ZTT_MSRA_EW : ZttBinaryInst<0b0100100, "msra.ew", ZttM_M_M>;
  def ZTT_MSRL_EW : ZttBinaryInst<0b0100110, "msrl.ew", ZttM_M_M>;
  def ZTT_MXOR_EW : ZttBinaryInst<0b0101000, "mxor.ew", ZttM_M_M>;
  def ZTT_MCMOVGE_EW : ZttBinaryInst<0b0101010, "mcmovge.ew", ZttM_M_M>;
  def ZTT_MCMOVLT_EW : ZttBinaryInst<0b0101011, "mcmovlt.ew", ZttM_M_M>;
  def ZTT_MCMPGE_EW : ZttBinaryInst<0b0101100, "mcmpge.ew", ZttM_M_M>;
  def ZTT_MCMPLT_EW : ZttBinaryInst<0b0101110, "mcmplt.ew", ZttM_M_M>;
  def ZTT_MSELGE_EW : ZttBinaryInst<0b0110000, "mselge.ew", ZttM_M_M>;
  def ZTT_MSELLT_EW : ZttBinaryInst<0b0110001, "msellt.ew", ZttM_M_M>;
  def ZTT_MCOLGATHER_EW : ZttBinaryInst<0b0110011, "mcolgather.ew", ZttM_M_M>;
  def ZTT_MROWGATHER_EW : ZttBinaryInst<0b0110110, "mrowgather.ew", ZttM_M_M>;
  def ZTT_MROWSCATADD_EW : ZttBinaryInst<0b0111001, "mrowscatadd.ew", ZttM_M_M>;
  def ZTT_MCOLSCATADD_EW : ZttBinaryInst<0b0111010, "mcolscatadd.ew", ZttM_M_M>;
  def ZTT_MROWSCATMAX_EW : ZttBinaryInst<0b0111011, "mrowscatmax.ew", ZttM_M_M>;
  def ZTT_MCOLSCATMAX_EW : ZttBinaryInst<0b0111100, "mcolscatmax.ew", ZttM_M_M>;
  def ZTT_MLDEXP_EW : ZttBinaryInst<0b0111111, "mldexp.ew", ZttM_M_M>;
  def ZTT_MLDEXPACC_EW : ZttBinaryInst<0b1000001, "mldexpacc.ew", ZttM_M_M>;
  def ZTT_MLOG2SUB_EW : ZttBinaryInst<0b1000011, "mlog2sub.ew", ZttM_M_M>;
  def ZTT_MRDEXP_EW : ZttBinaryInst<0b1000101, "mrdexp.ew", ZttM_M_M>;
  def ZTT_MRDEXPACC_EW : ZttBinaryInst<0b1000110, "mrdexpacc.ew", ZttM_M_M>;
  def ZTT_MSUBLOG2_EW : ZttBinaryInst<0b1000111, "msublog2.ew", ZttM_M_M>;

  def ZTT_MSLL_EW_X : ZttBinaryInst<0b0100011, "msll.ew.x", ZttM_X_M>;
  def ZTT_MSRA_EW_X : ZttBinaryInst<0b0100101, "msra.ew.x", ZttM_X_M>;
  def ZTT_MSRL_EW_X : ZttBinaryInst<0b0100111, "msrl.ew.x", ZttM_X_M>;
  def ZTT_MCOLBCAST_EW_X : ZttBinaryInst<0b0110010, "mcolbcast.ew.x", ZttM_X_M>;
  def ZTT_MCOLSHIFT_EW_X : ZttBinaryInst<0b0110100, "mcolshift.ew.x", ZttM_X_M>;
  def ZTT_MROWBCAST_EW_X : ZttBinaryInst<0b0110101, "mrowbcast.ew.x", ZttM_X_M>;
  def ZTT_MROWSHIFT_EW_X : ZttBinaryInst<0b0110111, "mrowshift.ew.x", ZttM_X_M>;
  def ZTT_MLDEXP_EW_X : ZttBinaryInst<0b1000000, "mldexp.ew.x", ZttM_X_M>;
  def ZTT_MLDEXPACC_EW_X : ZttBinaryInst<0b1000010, "mldexpacc.ew.x", ZttM_X_M>;
  // Data scalars depend on amestype, which is not a register operand.
  let hasSideEffects = 1 in {
    def ZTT_MABSDIFF_EW_X : ZttBinaryInst<0b0000001, "mabsdiff.ew.x", ZttM_X_M>;
    def ZTT_MADD_EW_X : ZttBinaryInst<0b0000011, "madd.ew.x", ZttM_X_M>;
    def ZTT_MHDIFF_EW_X : ZttBinaryInst<0b0000101, "mhdiff.ew.x", ZttM_X_M>;
    def ZTT_MMAX_EW_X : ZttBinaryInst<0b0000111, "mmax.ew.x", ZttM_X_M>;
    def ZTT_MMEAN_EW_X : ZttBinaryInst<0b0001001, "mmean.ew.x", ZttM_X_M>;
    def ZTT_MMIN_EW_X : ZttBinaryInst<0b0001011, "mmin.ew.x", ZttM_X_M>;
    def ZTT_MMUL_EW_X : ZttBinaryInst<0b0001101, "mmul.ew.x", ZttM_X_M>;
    def ZTT_MMULACC_EW_X : ZttBinaryInst<0b0001111, "mmulacc.ew.x", ZttM_X_M>;
    def ZTT_MMULACCNEG_EW_X : ZttBinaryInst<0b0010001, "mmulaccneg.ew.x", ZttM_X_M>;
    def ZTT_MMULADD_EW_X : ZttBinaryInst<0b0010011, "mmuladd.ew.x", ZttM_X_M>;
    def ZTT_MMULNEG_EW_X : ZttBinaryInst<0b0010101, "mmulneg.ew.x", ZttM_X_M>;
    def ZTT_MMULSUB_EW_X : ZttBinaryInst<0b0010111, "mmulsub.ew.x", ZttM_X_M>;
    def ZTT_MSUB_EW_X : ZttBinaryInst<0b0011001, "msub.ew.x", ZttM_X_M>;
    def ZTT_MAND_EW_X : ZttBinaryInst<0b0011011, "mand.ew.x", ZttM_X_M>;
    def ZTT_MANDNOT_EW_X : ZttBinaryInst<0b0011101, "mandnot.ew.x", ZttM_X_M>;
    def ZTT_MOR_EW_X : ZttBinaryInst<0b0011111, "mor.ew.x", ZttM_X_M>;
    def ZTT_MORNOT_EW_X : ZttBinaryInst<0b0100001, "mornot.ew.x", ZttM_X_M>;
    def ZTT_MXOR_EW_X : ZttBinaryInst<0b0101001, "mxor.ew.x", ZttM_X_M>;
    def ZTT_MCMPGE_EW_X : ZttBinaryInst<0b0101101, "mcmpge.ew.x", ZttM_X_M>;
    def ZTT_MCMPLT_EW_X : ZttBinaryInst<0b0101111, "mcmplt.ew.x", ZttM_X_M>;
    def ZTT_MLOG2SUB_EW_X : ZttBinaryInst<0b1000100, "mlog2sub.ew.x", ZttM_X_M>;
    def ZTT_MSUBLOG2_EW_X : ZttBinaryInst<0b1001000, "msublog2.ew.x", ZttM_X_M>;
  }

  def ZTT_MMULACC_2D : ZttBinaryInst<0b1001010, "mmulacc.2d", ZttA_M_M>;
  def ZTT_MMULACCNEG_2D : ZttBinaryInst<0b1001011, "mmulaccneg.2d", ZttA_M_M>;
  def ZTT_MMULATACC_2D : ZttBinaryInst<0b1001101, "mmulatacc.2d", ZttA_M_M>;
  def ZTT_MMULATACCNEG_2D : ZttBinaryInst<0b1001110, "mmulataccneg.2d", ZttA_M_M>;
  def ZTT_MMULBTACC_2D : ZttBinaryInst<0b1001111, "mmulbtacc.2d", ZttA_M_M>;
  def ZTT_MMULBTACCNEG_2D : ZttBinaryInst<0b1010000, "mmulbtaccneg.2d", ZttA_M_M>;

  def ZTT_MBCAST_M_X : ZttBinaryInst<0b1011000, "mbcast.m.x", ZttM_X_X>;

  def ZTT_MZERO_2D_ACC : ZttGenerateInst<0b00000, "mzero.2d.acc", ZttA>;

  def ZTT_MZERO_2D_M : ZttGenerateInst<0b00001, "mzero.2d.m", ZttM>;
  def ZTT_MCOLID_EW : ZttGenerateInst<0b00010, "mcolid.ew", ZttM>;
  def ZTT_MROWID_EW : ZttGenerateInst<0b00011, "mrowid.ew", ZttM>;

  def ZTT_MROWZIP_EW : ZttZipInst<0b0111000, "mrowzip.ew">;
  def ZTT_MCOLUNZIP_EW : ZttZipInst<0b1100001, "mcolunzip.ew">;
  def ZTT_MCOLZIP_EW : ZttZipInst<0b1100010, "mcolzip.ew">;
  def ZTT_MROWUNZIP_EW : ZttZipInst<0b1100011, "mrowunzip.ew">;

  def ZTT_MLS_1R : ZttMemoryInst<0b10110, "mls.1r", 0>;
  def ZTT_MSS_1R : ZttMemoryInst<0b11001, "mss.1r", 1>;
  def ZTT_MLS_CM : ZttMemoryInst<0b10111, "mls.cm", 0>;
  def ZTT_MLS_RM : ZttMemoryInst<0b11000, "mls.rm", 0>;
  def ZTT_MSS_CM : ZttMemoryInst<0b11010, "mss.cm", 1>;
  def ZTT_MSS_RM : ZttMemoryInst<0b11011, "mss.rm", 1>;

  def ZTT_MLS_ST : ZttStridedMemoryInst<0b1010100, "mls.st", 0>;
  def ZTT_MLS_TST : ZttStridedMemoryInst<0b1010101, "mls.tst", 0>;
  def ZTT_MSS_ST : ZttStridedMemoryInst<0b1010110, "mss.st", 1>;
  def ZTT_MSS_TST : ZttStridedMemoryInst<0b1010111, "mss.tst", 1>;
}
