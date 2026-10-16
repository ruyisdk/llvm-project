//===- RISCVInstrInfoZttPseudos.td - Ztt pseudos -----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

include "llvm/IR/RISCVZttOperations.td"

//===----------------------------------------------------------------------===//
// Common operands and mappings.
//===----------------------------------------------------------------------===//

// XLEN-sized constants for datatype, layout and control operands.
def ztt_xlenimm : Operand<XLenVT>;

// Shared feature and named-operand support for Ztt pseudos.
class ZttPseudo<dag outs, dag ins, list<dag> pattern>
    : Pseudo<outs, ins, pattern> {
  let Predicates = [HasStdExtZtt];
  let UseNamedOperandTable = 1;
}

// No memory access; each operation supplies its side-effect flag.
class ZttRegisterPseudo<dag outs, dag ins, bit sideEffects>
    : ZttPseudo<outs, ins, []> {
  let hasSideEffects = sideEffects;
  let mayLoad = 0;
  let mayStore = 0;
}

defvar ZttMGroupSizes = [1, 2, 4, 8, 16, 32];
defvar ZttAGroupSizes = [1, 2, 4, 8];

// Physical register-group size to register class. Zero is an unused source.
class ZttMRegClass<int group> {
  RegisterClass RC = !if(!gt(group, 1),
                        !cast<RegisterClass>("ZTTMRM" # group), ZTTMR);
}
class ZttARegClass<int group> {
  RegisterClass RC = !if(!gt(group, 1),
                        !cast<RegisterClass>("ZTTARM" # group), ZTTAR);
}

// Properties shared by all register-group sizes of an operation.
class ZttOperationRecord<RISCVZttOperation op> {
  ZttOperationRecord Operation = !cast<ZttOperationRecord>(NAME);
  string EnumName = !toupper(op.Name);
  Intrinsic IntrinsicID = !cast<Intrinsic>("int_riscv_ztt_" # op.Name);
  // IR memory effects and side effects require a DAG chain.
  bit HasChain = !or(
      !empty(!filter(P, IntrinsicID.IntrProperties, !eq(P, IntrNoMem))),
      !not(!empty(!filter(P, IntrinsicID.IntrProperties,
                          !eq(P, IntrHasSideEffects)))));
  string DAGOpcode = ?;
  bit IsAcc = !eq(op.ResultKind, "ACC");
  string OperandLayout = ?;
}

// Shared operation IDs keep machine tables independent of intrinsic IDs.
def ZttOperationID : GenericEnum {
  let FilterClass = "ZttOperationRecord";
  let NameField = "EnumName";
  let UnderlyingType = "unsigned";
}

def ZttOperationTable : GenericTable {
  let FilterClass = "ZttOperationRecord";
  let CppTypeName = "OperationInfo";
  let Fields = ["Operation", "IsAcc", "OperandLayout"];
  string TypeOf_Operation = "ZttOperationID";
  string TypeOf_OperandLayout = "code";
  let PrimaryKey = ["Operation"];
  let PrimaryKeyName = "getOperationInfo";
}

// A group record supplies machine information and its DAG mapping.
// Old-result operands share dst; absent or layout-implied source groups use zero.
class ZttGroupMapping<ZttOperationRecord op, int dst, int src0 = 0, int src1 = 0> {
  Instruction Pseudo = ?;
  ZttOperationRecord Operation = op;
  string DAGOpcode = ?;
  bits<8> DstGroup = dst;
  bits<8> Src0Group = src0;
  bits<8> Src1Group = src1;
}

def ZttPseudoTable : GenericTable {
  let FilterClass = "ZttGroupMapping";
  let CppTypeName = "PseudoInfo";
  let Fields = ["Pseudo", "Operation", "DstGroup", "Src0Group", "Src1Group"];
  string TypeOf_Operation = "ZttOperationID";
  let PrimaryKey = ["Pseudo"];
  let PrimaryKeyName = "getPseudoInfo";
}

def getPseudoGroupEntry : SearchIndex {
  let Table = ZttPseudoTable;
  let Key = ["Operation", "DstGroup", "Src0Group", "Src1Group"];
}

// Derive the SelectionDAG entry point from the intrinsic's IR effects.
class ZttIntrinsicLowering<ZttOperationRecord op> {
  Intrinsic IntrinsicID = op.IntrinsicID;
  ZttOperationRecord Operation = op;
  string DAGOpcode = op.DAGOpcode;
  bit HasChain = op.HasChain;
  string Opcode = !if(!empty(IntrinsicID.RetTypes), "ISD::INTRINSIC_VOID",
      !if(HasChain, "ISD::INTRINSIC_W_CHAIN", "ISD::INTRINSIC_WO_CHAIN"));
}

def ZttIntrinsicLoweringTable : GenericTable {
  let FilterClass = "ZttIntrinsicLowering";
  let CppTypeName = "IntrinsicLoweringInfo";
  let Fields = ["IntrinsicID", "Opcode", "DAGOpcode", "Operation"];
  string TypeOf_Opcode = "code";
  string TypeOf_DAGOpcode = "code";
  string TypeOf_Operation = "ZttOperationID";
  let PrimaryKey = ["IntrinsicID"];
  let PrimaryKeyName = "getIntrinsicLoweringInfo";
}

def ZttDAGNodeTable : GenericTable {
  let FilterClass = "ZttGroupMapping";
  let CppTypeName = "DAGNodeInfo";
  let Fields = ["Pseudo", "DAGOpcode"];
  string TypeOf_DAGOpcode = "code";
  let PrimaryKey = ["Pseudo"];
  let PrimaryKeyName = "getDAGNodeInfo";
}

//===----------------------------------------------------------------------===//
// Clear and zero.
//===----------------------------------------------------------------------===//

// Clear sets storage bits to zero; Zero sets elements to numeric zero.
// Clear/zero use NoArg interfaces; row/column IDs use compute pseudos.
class ZttInitOperation<RISCVZttNoArg op, string kind, string node,
                       string prefix> : ZttOperationRecord<op> {
  let OperandLayout = "OperandLayout::" # kind;
  let DAGOpcode = "RISCVISD::" # node # "1";
  string Layout = kind;
  string Node = node;
  string Prefix = prefix;
}

def : ZttInitOperation<riscv_ztt_op_mclear_m, "Clear", "ZTT_MCLEAR_M", "PseudoZTTMSetTypM">;
def : ZttInitOperation<riscv_ztt_op_mclear_acc, "Clear", "ZTT_ACLEAR_A", "PseudoZTTAClearA">;
def : ZttInitOperation<riscv_ztt_op_mzero_m, "Zero", "ZTT_MZERO_M", "PseudoZTTMZeroM">;
def : ZttInitOperation<riscv_ztt_op_mzero_acc, "Zero", "ZTT_AZERO_A", "PseudoZTTAZeroA">;

// One matrix result; datatype and layout operands both use XLEN.
def SDT_ZttClear
    : SDTypeProfile<1, 2, [SDTCisVT<1, XLenVT>, SDTCisVT<2, XLenVT>]>;

foreach Op = !instances<ZttInitOperation>() in {
  def : ZttIntrinsicLowering<Op>;
  foreach G = !if(Op.IsAcc, ZttAGroupSizes, ZttMGroupSizes) in {
    defvar RC = !if(Op.IsAcc, ZttARegClass<G>.RC, ZttMRegClass<G>.RC);
    def !tolower(Op.Node) # G : RVSDNode<Op.Node # G, SDT_ZttClear>;
    if !eq(Op.Layout, "Clear") then
      def Op.Prefix # G : ZttRegisterPseudo<(outs RC:$rd),
          !con((ins GPR:$rs1), !if(Op.IsAcc, (ins ztt_xlenimm:$element_bits),
                                   (ins ztt_xlenimm:$regs_per_unit))), 1>;
    else
      def Op.Prefix # G : ZttRegisterPseudo<(outs RC:$rd),
          !con((ins GPR:$dtype), !if(Op.IsAcc, (ins ztt_xlenimm:$element_bits),
                                     (ins ztt_xlenimm:$regs_per_square))), 1>;
    def : ZttGroupMapping<Op, G> {
      let Pseudo = !cast<Instruction>(Op.Prefix # G);
      let DAGOpcode = "RISCVISD::" # Op.Node # G;
    }
  }
}
