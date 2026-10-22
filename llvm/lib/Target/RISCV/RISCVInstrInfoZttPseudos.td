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
defvar ZttAGroupSizes = [1, 2, 4, 8, 16];

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
  string Kind = "CodeGenKind::" # op.CodeGenKind;
  Instruction BaseOpcode = ZTT_MSETTYP;
  bits<8> NumSources = 0;
  bit SameGroups = 0;
  bit HasOld = 0;
  // Zip/unzip update both squares in one instruction.
  bit Pairwise = !isa<RISCVZttZipUnZip>(op);
  bit HasSideEffects = 0;
  bit HasScalar = !and(!or(!isa<RISCVZttCompute>(op),
                          !isa<RISCVZttExtract>(op)), !gt(op.NumScalarArgs, 0));
  bit HasScalarType = !or(!isa<RISCVZttScalarBinary>(op),
                          !isa<RISCVZttScalarBroadcast>(op));
  string ScalarType = "ScalarTypeLocation::" # !if(HasScalarType,
      !if(!isa<RISCVZttScalarBroadcast>(op), "Operand", "CSR"), "None");
  bit IsLoad = 0;
  bit HasScratch = 0;
  bit Transposed = 0;
  string Name = !subst("_", ".", op.Name);
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
  let Fields = ["Operation", "IsAcc", "OperandLayout", "Kind", "BaseOpcode",
                "NumSources", "HasChain", "SameGroups", "HasOld", "Pairwise",
                "HasSideEffects", "HasScalar", "HasScalarType", "ScalarType", "IsLoad",
                "HasScratch", "Transposed", "Name"];
  string TypeOf_Operation = "ZttOperationID";
  string TypeOf_OperandLayout = "code";
  string TypeOf_Kind = "code";
  string TypeOf_ScalarType = "code";
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
  let HasSideEffects = 1;
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

//===----------------------------------------------------------------------===//
// Copy, concat and extract.
//===----------------------------------------------------------------------===//

class ZttTransferOperation<RISCVZttOperation op, string layout, string node>
    : ZttOperationRecord<op> {
  let OperandLayout = "OperandLayout::" # layout;
  let DAGOpcode = "RISCVISD::" # node;
  let NumSources = !if(!eq(layout, "Extract"), 1, 0);
  let HasSideEffects = !ne(layout, "Extract");
}

// Source/result types match; the remaining operands use XLEN.
def SDT_ZttMCopy : SDTypeProfile<1, 3,
    [SDTCisSameAs<0, 1>, SDTCisVT<2, XLenVT>, SDTCisVT<3, XLenVT>]>;

foreach Op = !instances<RISCVZttCopyM2M>() in {
  def "ztt_transfer_" # Op.Name : ZttTransferOperation<Op, "Copy", "ZTT_MCOPY_M1">;
  defvar Info = !cast<ZttTransferOperation>("ztt_transfer_" # Op.Name);
  def : ZttIntrinsicLowering<Info>;
  foreach G = ZttMGroupSizes in {
    defvar RC = ZttMRegClass<G>.RC;
    def ztt_mcopy_m # G : RVSDNode<"ZTT_MCOPY_M" # G, SDT_ZttMCopy>;
    def PseudoZTTMCopyM # G : ZttRegisterPseudo<(outs RC:$rd),
        (ins RC:$src, ztt_xlenimm:$regs_per_unit, GPR:$dtype), 1> {
      let Constraints = "@earlyclobber $rd";
    }
    def : ZttGroupMapping<Info, G> {
      let Pseudo = !cast<Instruction>("PseudoZTTMCopyM" # G);
      let DAGOpcode = "RISCVISD::ZTT_MCOPY_M" # G;
    }
  }
}

// The two source types match; the result uses twice their register group.
def SDT_ZttMConcat : SDTypeProfile<1, 4,
    [SDTCisSameAs<1, 2>, SDTCisVT<3, XLenVT>, SDTCisVT<4, XLenVT>]>;

foreach Op = !instances<RISCVZttConcat>() in {
  def "ztt_transfer_" # Op.Name : ZttTransferOperation<Op, "Concat", "ZTT_MCONCAT_M2">;
  defvar Info = !cast<ZttTransferOperation>("ztt_transfer_" # Op.Name);
  def : ZttIntrinsicLowering<Info>;
  foreach G = [2, 4, 8, 16, 32] in {
    defvar RC = ZttMRegClass<G>.RC;
    defvar Half = ZttMRegClass<!srl(G, 1)>.RC;
    def ztt_mconcat_m # G : RVSDNode<"ZTT_MCONCAT_M" # G, SDT_ZttMConcat>;
    def PseudoZTTMConcatM # G : ZttRegisterPseudo<(outs RC:$rd),
        (ins Half:$lhs, Half:$rhs, ztt_xlenimm:$regs_per_square, GPR:$dtype), 1> {
      let Constraints = "@earlyclobber $rd";
    }
    def : ZttGroupMapping<Info, G> {
      let Pseudo = !cast<Instruction>("PseudoZTTMConcatM" # G);
      let DAGOpcode = "RISCVISD::ZTT_MCONCAT_M" # G;
    }
  }
}

// M and ACC use separate groups; layout and datatype operands use XLEN.
def SDT_ZttMCopyCross : SDTypeProfile<1, 4,
    [SDTCisVT<2, XLenVT>, SDTCisVT<3, XLenVT>, SDTCisVT<4, XLenVT>]>;

foreach Op = !listconcat(!instances<RISCVZttCopyM2A>(),
                        !instances<RISCVZttCopyA2M>()) in {
  defvar Node = "ZTT_" # !toupper(Op.Name);
  def "ztt_transfer_" # Op.Name : ZttTransferOperation<Op, "CrossCopy", Node>;
  defvar Info = !cast<ZttTransferOperation>("ztt_transfer_" # Op.Name);
  defvar Prefix = !if(Info.IsAcc, "PseudoZTTMCopyM2A", "PseudoZTTMCopyA2M");
  def : ZttIntrinsicLowering<Info>;
  def "ztt_" # Op.Name : RVSDNode<Node, SDT_ZttMCopyCross>;
  foreach A = ZttAGroupSizes in
    foreach M = ZttMGroupSizes in {
      defvar ARC = ZttARegClass<A>.RC;
      defvar MRC = ZttMRegClass<M>.RC;
      defvar Name = Prefix # "_A" # A # "_M" # M;
      def Name : ZttRegisterPseudo<
          !if(Info.IsAcc, (outs ARC:$rd), (outs MRC:$rd)),
          !con(!if(Info.IsAcc, (ins MRC:$src), (ins ARC:$src)),
               (ins ztt_xlenimm:$mregs_per_square,
                    ztt_xlenimm:$accs_per_move, GPR:$dtype)), 1>;
      def : ZttGroupMapping<Info, !if(Info.IsAcc, A, M),
                                 !if(Info.IsAcc, M, A)> {
        let Pseudo = !cast<Instruction>(Name);
        let DAGOpcode = Info.DAGOpcode;
      }
    }
}

// Source, constant half index, datatype, move count and registers per square.
def SDT_ZttMextract : SDTypeProfile<1, 5,
    [SDTCisVT<2, XLenVT>, SDTCisVT<3, XLenVT>,
     SDTCisVT<4, XLenVT>, SDTCisVT<5, XLenVT>]>;

foreach Op = !instances<RISCVZttExtract>() in {
  def "ztt_transfer_" # Op.Name : ZttTransferOperation<Op, "Extract", "ZTT_MEXTRACT">;
  defvar Info = !cast<ZttTransferOperation>("ztt_transfer_" # Op.Name);
  def : ZttIntrinsicLowering<Info>;
  def ztt_mextract : RVSDNode<"ZTT_MEXTRACT", SDT_ZttMextract>;
  foreach D = ZttMGroupSizes in
    foreach S = ZttMGroupSizes in {
      defvar DRC = ZttMRegClass<D>.RC;
      defvar SRC = ZttMRegClass<S>.RC;
      defvar Name = "PseudoZTTMextract_G0" # !if(!lt(D, 10), "0", "") # D #
                   "_G1" # !if(!lt(S, 10), "0", "") # S;
      def Name : ZttRegisterPseudo<(outs DRC:$rd),
          (ins SRC:$s0, ztt_xlenimm:$scalar, GPR:$dtype,
               ztt_xlenimm:$num_ops, ztt_xlenimm:$regs_per_square), 0> {
        let Constraints = "@earlyclobber $rd";
      }
      def : ZttGroupMapping<Info, D, S> {
        let Pseudo = !cast<Instruction>(Name);
        let DAGOpcode = Info.DAGOpcode;
      }
    }
}

//===----------------------------------------------------------------------===//
// Matrix and scalar computation.
//===----------------------------------------------------------------------===//

class ZttComputeOperation<RISCVZttCompute op> : ZttOperationRecord<op> {
  let OperandLayout = "OperandLayout::Matrix";
  let DAGOpcode = "RISCVISD::ZTT_" # !toupper(op.Name);
  let BaseOpcode = !cast<Instruction>("ZTT_" # !toupper(op.Name));
  let HasOld = op.HasOldResult;
  let NumSources = op.NumMatrixArgs;
  let SameGroups = !or(!eq(op.ComputeMatrixArgRule, "AllSameAsRes"),
                      !eq(op.ComputeMatrixArgRule, "AllSameIntAsRes"));
  let HasSideEffects = HasChain;
  string NameSuffix = !subst("_", "", !subst("_ew", "Ew",
      !subst("_x", "X", !subst("_m", "M", !subst("_row", "Row",
      !subst("_col", "Col", !substr(op.Name, 1)))))));
  string PseudoPrefix = !if(Pairwise, "PseudoZTT_" # op.Name,
                           "PseudoZTTM" # NameSuffix);
}

// Group suffixes name the result and each independent matrix input.
class ZttComputeName<ZttComputeOperation op, int dst, int src0, int src1> {
  string Name = op.PseudoPrefix # "_G0" # !if(!lt(dst, 10), "0", "") # dst #
      !if(!gt(op.NumSources, 0), "_G1" # !if(!lt(src0, 10), "0", "") # src0, "") #
      !if(!gt(op.NumSources, 1), "_G2" # !if(!lt(src1, 10), "0", "") # src1, "");
}

// Matrix inputs precede scalar, datatype and layout operands. Chains are implicit.
class ZttComputeProfile<ZttComputeOperation op> : SDTypeProfile<1,
    !add(op.HasOld, op.NumSources, op.HasScalar, 3, op.HasScalarType),
    !listconcat(!if(op.HasOld, [SDTCisSameAs<0, 1>], []),
        !foreach(I, !range(!add(1, op.HasOld, op.NumSources),
            !add(1, op.HasOld, op.NumSources, op.HasScalar,
                 3, op.HasScalarType)), SDTCisVT<I, XLenVT>))>;

// Computation with optional old result, matrix inputs and scalar/control input.
class ZttComputePseudo<ZttComputeOperation op, RegisterClass dst,
                       RegisterClass src0, RegisterClass src1>
    : ZttRegisterPseudo<(outs dst:$rd),
        !con(!if(op.HasOld, (ins dst:$old), (ins)),
             !if(!gt(op.NumSources, 0), (ins src0:$s0), (ins)),
             !if(!gt(op.NumSources, 1), (ins src1:$s1), (ins)),
             !if(op.HasScalar, (ins GPR:$scalar), (ins)),
             !if(op.Pairwise, (ins ztt_xlenimm:$dtype), (ins GPR:$dtype)),
             !if(op.HasScalarType, (ins GPR:$stype), (ins)),
             (ins ztt_xlenimm:$num_ops, ztt_xlenimm:$regs_per_square)),
        op.HasSideEffects> {
  let Constraints = !if(op.HasOld, "$rd = $old", "@earlyclobber $rd");
}

foreach Op = !instances<RISCVZttCompute>() in
  if !not(!or(!eq(Op.Name, "mclear_m"), !eq(Op.Name, "mclear_acc"),
              !eq(Op.Name, "mzero_m"), !eq(Op.Name, "mzero_acc"))) then {
    def "ztt_compute_" # Op.Name : ZttComputeOperation<Op>;
    defvar Info = !cast<ZttComputeOperation>("ztt_compute_" # Op.Name);
    def : ZttIntrinsicLowering<Info>;
    def "ztt_" # Op.Name : RVSDNode<"ZTT_" # !toupper(Op.Name),
        ZttComputeProfile<Info>,
        !if(Info.HasChain, [SDNPHasChain, SDNPSideEffect], [])>;
    foreach D = ZttMGroupSizes in
      foreach S0 = !if(!eq(Info.NumSources, 0), [0],
                       !if(Info.SameGroups, [D], ZttMGroupSizes)) in
        foreach S1 = !if(!lt(Info.NumSources, 2), [0],
                         !if(Info.SameGroups, [D], ZttMGroupSizes)) in {
          defvar Name = ZttComputeName<Info, D, S0, S1>.Name;
          def Name : ZttComputePseudo<Info, ZttMRegClass<D>.RC,
              ZttMRegClass<S0>.RC, ZttMRegClass<S1>.RC>;
          def : ZttGroupMapping<Info, D, S0, S1> {
            let Pseudo = !cast<Instruction>(Name);
            let DAGOpcode = Info.DAGOpcode;
          }
        }
  }

//===----------------------------------------------------------------------===//
// Matrix multiplication.
//===----------------------------------------------------------------------===//

class ZttMatmulOperation<RISCVZttMatmul op> : ZttOperationRecord<op> {
  let OperandLayout = "OperandLayout::Matrix";
  let DAGOpcode = "RISCVISD::ZTT_" # !toupper(op.Name);
  let BaseOpcode = !cast<Instruction>("ZTT_" # !toupper(op.Name));
  let NumSources = op.NumMatrixArgs;
  let HasOld = op.HasOldResult;
  let HasSideEffects = 1;
  string PseudoPrefix = !if(!eq(op.Name, "mmulacc_2d"), "PseudoZTTMMulAcc2D",
      "PseudoZTTM" # !subst("_", "", !substr(op.Name, 1)));
}

def SDT_ZttMatmul : SDTypeProfile<1, 4,
    [SDTCisSameAs<0, 1>, SDTCisVT<4, XLenVT>]>;

// The complete ACC group is tied, although hardware updates its first square.
class ZttMatmulPseudo<RegisterClass acc, RegisterClass lhs, RegisterClass rhs>
    : ZttRegisterPseudo<(outs acc:$rd),
        (ins acc:$acc, lhs:$lhs, rhs:$rhs, ztt_xlenimm:$num_ops), 1> {
  let Constraints = "$rd = $acc";
}

foreach Op = !instances<RISCVZttMatmul>() in {
  def "ztt_matmul_" # Op.Name : ZttMatmulOperation<Op>;
  defvar Info = !cast<ZttMatmulOperation>("ztt_matmul_" # Op.Name);
  def : ZttIntrinsicLowering<Info>;
  def "ztt_" # Op.Name : RVSDNode<"ZTT_" # !toupper(Op.Name), SDT_ZttMatmul>;
  foreach A = ZttAGroupSizes in
    foreach L = ZttMGroupSizes in
      foreach R = ZttMGroupSizes in {
        defvar Name = Info.PseudoPrefix # "_A" # A # "_L" # L # "_R" # R;
        def Name : ZttMatmulPseudo<ZttARegClass<A>.RC,
                                  ZttMRegClass<L>.RC, ZttMRegClass<R>.RC>;
        def : ZttGroupMapping<Info, A, L, R> {
          let Pseudo = !cast<Instruction>(Name);
          let DAGOpcode = Info.DAGOpcode;
        }
      }
}

//===----------------------------------------------------------------------===//
// Matrix memory operations.
//===----------------------------------------------------------------------===//

class ZttMemoryOperation<RISCVZttOperation op, string layout, string node,
                         string prefix> : ZttOperationRecord<op> {
  let OperandLayout = "OperandLayout::" # layout;
  let BaseOpcode = !cast<Instruction>("ZTT_" # !toupper(op.Name));
  let IsLoad = !isa<RISCVZttLoad>(op);
  let HasScratch = 1;
  let HasSideEffects = 1;
  string Node = node;
  string Prefix = prefix;
}

// Memory pseudos update a scratch address tied to the input base.
class ZttMemoryPseudo<dag outs, dag ins, bit load, bit strided>
    : ZttPseudo<outs, ins, []> {
  let hasSideEffects = 1;
  let mayLoad = load;
  let mayStore = !not(load);
  let Constraints = "$scratch = $base" #
                    !if(strided, ",@earlyclobber $scratch", "");
}

class ZttContiguousMemoryOperation<RISCVZttOperation op, string node,
                                   string prefix>
    : ZttMemoryOperation<op, "Memory", node, prefix> {
  let DAGOpcode = "RISCVISD::" # node # "1";
}

def : ZttContiguousMemoryOperation<riscv_ztt_op_mls_rm, "ZTT_MLS_RM_M", "PseudoZTTMLoadRMM">;
def : ZttContiguousMemoryOperation<riscv_ztt_op_mls_cm, "ZTT_MLS_CM_M", "PseudoZTTMLoadCMM">;
def : ZttContiguousMemoryOperation<riscv_ztt_op_mss_rm, "ZTT_MSS_RM_M", "PseudoZTTMStoreRMM">;
def : ZttContiguousMemoryOperation<riscv_ztt_op_mss_cm, "ZTT_MSS_CM_M", "PseudoZTTMStoreCMM">;

// Loads return a matrix and scratch address; stores return the scratch address.
def SDT_ZttMLoad : SDTypeProfile<2, 4,
    [SDTCisVT<1, XLenVT>, SDTCisPtrTy<2>, SDTCisVT<3, XLenVT>,
     SDTCisVT<4, XLenVT>, SDTCisVT<5, XLenVT>]>;
def SDT_ZttMStore : SDTypeProfile<1, 4,
    [SDTCisVT<0, XLenVT>, SDTCisPtrTy<2>, SDTCisVT<3, XLenVT>,
     SDTCisVT<4, XLenVT>]>;

foreach Op = !instances<ZttContiguousMemoryOperation>() in {
  def : ZttIntrinsicLowering<Op>;
  foreach G = ZttMGroupSizes in {
    defvar RC = ZttMRegClass<G>.RC;
    def !tolower(Op.Node) # G : RVSDNode<Op.Node # G,
        !if(Op.IsLoad, SDT_ZttMLoad, SDT_ZttMStore),
        !if(Op.IsLoad, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand],
                      [SDNPHasChain, SDNPMayStore, SDNPMemOperand])>;
    def Op.Prefix # G : ZttMemoryPseudo<
        !if(Op.IsLoad, (outs RC:$rd, GPR:$scratch), (outs GPR:$scratch)),
        !if(Op.IsLoad,
            (ins GPR:$base, GPR:$dtype, ztt_xlenimm:$regs_per_unit, GPR:$stride),
            (ins RC:$src, GPR:$base, ztt_xlenimm:$regs_per_unit, GPR:$stride)),
        Op.IsLoad, 0>;
    def : ZttGroupMapping<Op, G> {
      let Pseudo = !cast<Instruction>(Op.Prefix # G);
      let DAGOpcode = "RISCVISD::" # Op.Node # G;
    }
  }
}

//===----------------------------------------------------------------------===//
// Strided memory operations.
//===----------------------------------------------------------------------===//

class ZttStridedMemoryOperation<RISCVZttOperation op, string node,
                                string prefix, bit transposed>
    : ZttMemoryOperation<op, "StridedMemory", node, prefix> {
  let DAGOpcode = "RISCVISD::" # node;
  let Transposed = transposed;
}

def : ZttStridedMemoryOperation<riscv_ztt_op_mls_st, "ZTT_MLS_ST", "PseudoZTTMlsSt", 0>;
def : ZttStridedMemoryOperation<riscv_ztt_op_mls_tst, "ZTT_MLS_TST", "PseudoZTTMlsTst", 1>;
def : ZttStridedMemoryOperation<riscv_ztt_op_mss_st, "ZTT_MSS_ST", "PseudoZTTMssSt", 0>;
def : ZttStridedMemoryOperation<riscv_ztt_op_mss_tst, "ZTT_MSS_TST", "PseudoZTTMssTst", 1>;

def SDT_ZttStridedLoad : SDTypeProfile<2, 5,
    [SDTCisVT<1, XLenVT>, SDTCisVT<2, XLenVT>, SDTCisVT<3, XLenVT>,
     SDTCisVT<4, XLenVT>, SDTCisVT<5, XLenVT>, SDTCisVT<6, XLenVT>]>;
def SDT_ZttStridedStore : SDTypeProfile<1, 6,
    [SDTCisVT<0, XLenVT>, SDTCisVT<1, XLenVT>, SDTCisVT<2, XLenVT>,
     SDTCisVT<4, XLenVT>, SDTCisVT<5, XLenVT>, SDTCisVT<6, XLenVT>]>;

foreach Op = !instances<ZttStridedMemoryOperation>() in {
  def : ZttIntrinsicLowering<Op>;
  def !tolower(Op.Node) : RVSDNode<Op.Node,
      !if(Op.IsLoad, SDT_ZttStridedLoad, SDT_ZttStridedStore),
      !if(Op.IsLoad, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand],
                    [SDNPHasChain, SDNPMayStore, SDNPMemOperand])>;
  foreach G = ZttMGroupSizes in {
    defvar RC = ZttMRegClass<G>.RC;
    defvar Name = Op.Prefix # "_G" # !if(!lt(G, 10), "0", "") # G;
    def Name : ZttMemoryPseudo<
        !if(Op.IsLoad, (outs RC:$rd, GPR:$scratch), (outs GPR:$scratch)),
        !if(Op.IsLoad,
            (ins GPR:$base, GPR:$stride, GPR:$dtype,
                 ztt_xlenimm:$regs_per_square, GPR:$step),
            (ins GPR:$base, GPR:$stride, RC:$src,
                 ztt_xlenimm:$dtype, ztt_xlenimm:$regs_per_square, GPR:$step)),
        Op.IsLoad, 1>;
    def : ZttGroupMapping<Op, G> {
      let Pseudo = !cast<Instruction>(Name);
      let DAGOpcode = Op.DAGOpcode;
    }
  }
}

//===----------------------------------------------------------------------===//
// State and CSR operations.
//===----------------------------------------------------------------------===//

// State operations have no custom matrix DAG or register-group mappings.
foreach Op = !instances<RISCVZttOperation>() in
  if !eq(Op.CodeGenKind, "State") then
    def "ztt_state_" # Op.Name : ZttOperationRecord<Op> {
      let DAGOpcode = "0";
      let OperandLayout = "OperandLayout::Matrix";
    }

class ZttReadCSR<SysReg csr, Intrinsic read>
    : ZttPseudo<(outs GPR:$rd), (ins), [(set GPR:$rd, (XLenVT (read)))]>,
      PseudoInstExpansion<(CSRRS GPR:$rd, csr.Encoding, X0)> {
  let hasSideEffects = 1;
  let mayLoad = 0;
  let mayStore = 0;
}

let Predicates = [HasStdExtZtt] in {
  def : Pat<(XLenVT (int_riscv_ztt_ame_acquire (XLenVT GPR:$desc))),
            (ZTT_AME_ACQUIRE GPR:$desc)>;
  def : Pat<(int_riscv_ztt_ame_release), (ZTT_AME_RELEASE)>;
  def PseudoReadAMENLEN : ReadSysReg<SysRegAMENLEN, []>;
}
def PseudoZttReadAMEOWN : ZttReadCSR<SysRegAMEOWN, int_riscv_ztt_get_ameown>;
def PseudoZttReadAMESTYPE : ZttReadCSR<SysRegAMESTYPE, int_riscv_ztt_get_amestype>;
def PseudoZttReadAMENLEN : ZttReadCSR<SysRegAMENLEN, int_riscv_ztt_get_amenlen>;
def PseudoZttReadAMEUDSZ : ZttReadCSR<SysRegAMEUDSZ, int_riscv_ztt_get_ameudsz>;
def PseudoZttReadAMEFFLAGS : ZttReadCSR<SysRegAMEFFLAGS, int_riscv_ztt_get_amefflags>;
def PseudoZttReadAMEXSAT : ZttReadCSR<SysRegAMEXSAT, int_riscv_ztt_get_amexsat>;
def PseudoZttReadAMESTATUS : ZttReadCSR<SysRegAMESTATUS, int_riscv_ztt_get_amestatus>;

//===----------------------------------------------------------------------===//
// Data writes that preserve the existing M datatype layout.
//===----------------------------------------------------------------------===//

class ZttMDPreservingOpcode<Instruction inst> {
  Instruction Opcode = inst;
}
foreach Op = !instances<ZttComputeOperation>() in
  def : ZttMDPreservingOpcode<Op.BaseOpcode>;
foreach Inst = [ZTT_MLS_RM, ZTT_MLS_CM, ZTT_MLS_1R, ZTT_MLS_ST, ZTT_MLS_TST,
                ZTT_MMOV_M_M, ZTT_MMOV_M_A, ZTT_MZERO_2D_M] in
  def : ZttMDPreservingOpcode<Inst>;

def ZttMDPreservingTable : GenericTable {
  let FilterClass = "ZttMDPreservingOpcode";
  let CppTypeName = "MDPreservingInfo";
  let Fields = ["Opcode"];
  let PrimaryKey = ["Opcode"];
  let PrimaryKeyName = "getMDPreservingInfo";
}

//===----------------------------------------------------------------------===//
// Internal spill and frame operations.
//===----------------------------------------------------------------------===//

// Compute register stride and aligned payload bytes; count is physical M count.
def PseudoZTTMFrameSize : ZttRegisterPseudo<
    (outs GPRNoX0:$bytes, GPRNoX0:$stride, GPRNoX0:$tmp0,
          GPRNoX0:$tmp1, GPRNoX0:$tmp2),
    (ins ztt_xlenimm:$count, ztt_xlenimm:$alignment), 1> {
  let Constraints = "@earlyclobber $bytes,@earlyclobber $stride,"
                    "@earlyclobber $tmp0,@earlyclobber $tmp1,"
                    "@earlyclobber $tmp2";
}

foreach G = ZttMGroupSizes in {
  defvar RC = ZttMRegClass<G>.RC;
  let hasSideEffects = 1 in {
    // Allocator spills carry a frame index and square width.
    def PseudoZTTMSpillM # G : ZttPseudo<(outs),
        (ins RC:$src, GPR:$base, ztt_xlenimm:$regs_per_square), []> {
      let mayLoad = 0;
      let mayStore = 1;
    }
    def PseudoZTTMReloadM # G : ZttPseudo<(outs RC:$dst),
        (ins GPR:$base, ztt_xlenimm:$regs_per_square), []> {
      let mayLoad = 1;
      let mayStore = 0;
    }
    // Image transfers use explicit data, metadata and stride addresses.
    let Constraints = "@earlyclobber $cursor,@earlyclobber $dtype" in {
      def PseudoZTTMSaveM # G : ZttPseudo<
          (outs GPRNoX0:$cursor, GPRNoX0:$dtype),
          (ins RC:$src, GPR:$data, GPR:$metadata, GPR:$stride,
               ztt_xlenimm:$regs_per_square), []> {
        let mayLoad = 0;
        let mayStore = 1;
      }
      def PseudoZTTMRestoreM # G : ZttPseudo<
          (outs RC:$dst, GPRNoX0:$cursor, GPRNoX0:$dtype),
          (ins GPR:$data, GPR:$metadata, GPR:$stride,
               ztt_xlenimm:$regs_per_square), []> {
        let mayLoad = 1;
        let mayStore = 0;
      }
    }
  }
}

// ACC spills may save and restore borrowed M registers in either direction.
foreach A = ZttAGroupSizes in {
  defvar RC = ZttARegClass<A>.RC;
  let hasSideEffects = 1, mayLoad = 1, mayStore = 1 in {
    def PseudoZTTASpillA # A : ZttPseudo<(outs),
        (ins RC:$src, GPR:$base, ztt_xlenimm:$element_bits), []>;
    def PseudoZTTAReloadA # A : ZttPseudo<(outs RC:$dst),
        (ins GPR:$base, ztt_xlenimm:$element_bits), []>;
  }
}
