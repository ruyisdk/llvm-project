//===-- RISCVZttISelLowering.cpp - Lower Ztt intrinsics ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Lower Ztt intrinsic operands and layouts to target DAG nodes.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/RISCVBaseInfo.h"
#include "RISCVISelLowering.h"
#include "RISCVInstrInfo.h"
#include "RISCVSelectionDAGInfo.h"
#include "RISCVSubtarget.h"
#include "RISCVZttUtils.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/IR/IntrinsicsRISCV.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"
#include "llvm/TargetParser/RISCVZttDatatype.h"

using namespace llvm;

/// Check an M value against UDS and the configured register count.
static void checkZttMTypeFitsRegister(unsigned LogicalBits, unsigned UdsBits,
                                      const RISCVSubtarget &Subtarget) {
  if (isZttMHalfRegister(LogicalBits, UdsBits))
    report_fatal_error("Ztt half-register M types are not supported");
  unsigned GroupSize = getZttMRegisterGroupSize(LogicalBits, UdsBits);
  if (GroupSize > 32)
    report_fatal_error("Ztt M-register group requires more than 32 registers");
  if (GroupSize > Subtarget.getZttMRegs())
    report_fatal_error("Ztt M type exceeds the configured register count");
}

/// Check logical ACC square count against the configured physical capacity.
static void checkZttAccCapacity(MVT VT, const RISCVSubtarget &Subtarget) {
  unsigned Count = 1U << (VT.SimpleTy - unsigned(MVT::riscv_ztta1));
  if (Count > Subtarget.getZttARegs())
    report_fatal_error("Ztt ACC type exceeds the configured register count");
}

/// Read a constant datatype, shape or control operand.
static unsigned getZttConstantOperand(SDValue Op, unsigned Operand,
                                      StringRef Field) {
  auto *Constant = dyn_cast<ConstantSDNode>(Op.getOperand(Operand));
  if (!Constant)
    report_fatal_error(Twine("Ztt ") + Field + " operand must be constant");
  return Constant->getZExtValue();
}

/// Read the element width and reject zero before layout arithmetic.
static unsigned getZttElementBits(uint32_t Descriptor) {
  unsigned Bits = RISCVZtt::elementBits(Descriptor);
  if (!Bits)
    report_fatal_error("Ztt datatype has an invalid element size");
  return Bits;
}

/// Validate the descriptor of an XLEN scalar payload. Raw IR may describe a
/// datatype wider than XLEN; hardware zero-extends the payload in that case.
/// This is distinct from Clang's scalar carrier-conversion restriction.
static void checkZttScalarDescriptor(uint32_t Descriptor) {
  unsigned Bits = RISCVZtt::elementBits(Descriptor);
  if (!isPowerOf2_32(Bits) || Bits < 4 || Bits > 128)
    report_fatal_error("Ztt scalar datatype has an invalid element size");
}

/// Make an XLEN datatype value for msettyp/asettyp.
static SDValue extendZttDTypeToXLen(SDValue DType, const SDLoc &DL, MVT XLenVT,
                                    SelectionDAG &DAG) {
  // immarg operands arrive as TargetConstants. settyp needs a GPR, so make a
  // selectable constant even on RV32, where no extension is otherwise needed.
  if (auto *C = dyn_cast<ConstantSDNode>(DType))
    return DAG.getConstant(C->getZExtValue(), DL, XLenVT);
  if (DType.getValueType() == XLenVT)
    return DType;
  return DAG.getNode(ISD::ZERO_EXTEND, DL, XLenVT, DType);
}

/// Look up the DAG node for a register group.
static unsigned getZttGroupOpcode(unsigned Operation, unsigned GroupSize) {
  assert(isPowerOf2_32(GroupSize) && "Ztt register group must be a power of 2");
  const auto *P = RISCVZttInstrInfo::getPseudoForGroups(Operation, GroupSize);
  assert(P && "unsupported Ztt register group size");
  return RISCVZttLowering::getDAGNodeInfo(P->Pseudo)->DAGOpcode;
}

/// Chain and byte stride used when expanding a logical matrix memory operation
/// into one instruction per packed register or wide square.
struct ZttMemoryAddressing {
  /// Chain after an optional amenlen CSR read.
  SDValue Chain;
  /// Byte distance between consecutive memory instructions.
  SDValue Stride;
};

/// Address stepping is an explicit mode, not inferred from a missing operand.
enum class ZttMemoryMode { Contiguous, Strided, TransposedStrided };

/// Compute the byte step between physical slices. Contiguous memory advances
/// N*N*max(E,UDS)/8, .st advances N*max(E,UDS)/8, and .tst advances
/// N*packed_squares*byte_stride. A single slice needs neither N nor a step.
static ZttMemoryAddressing
getZttMemoryAddressing(SDValue Chain, const ZttMRegisterLayout &Layout,
                       unsigned TransferBits, SDValue ByteStride,
                       ZttMemoryMode Mode, const SDLoc &DL, MVT XLenVT,
                       SelectionDAG &DAG) {
  SDValue Step = DAG.getConstant(0, DL, XLenVT);
  if (Layout.GroupSize <= Layout.RegsPerSquare)
    return {Chain, Step};

  const auto *CSR = RISCVSysReg::lookupSysRegByName("AMENLEN");
  assert(CSR && "amenlen must be present in the RISC-V CSR table");
  SDValue N =
      DAG.getNode(RISCVISD::READ_CSR, DL, DAG.getVTList(XLenVT, MVT::Other),
                  Chain, DAG.getTargetConstant(CSR->Encoding, DL, XLenVT));
  SDValue Unit = N;
  unsigned Scale = TransferBits / 8;
  switch (Mode) {
  case ZttMemoryMode::Contiguous:
    Unit = DAG.getNode(ISD::MUL, DL, XLenVT, N, N);
    break;
  case ZttMemoryMode::Strided:
    break;
  case ZttMemoryMode::TransposedStrided:
    Unit = DAG.getNode(ISD::MUL, DL, XLenVT, N, ByteStride);
    Scale = Layout.SquaresPerRegister;
    break;
  }
  Step = DAG.getNode(ISD::SHL, DL, XLenVT, Unit,
                     DAG.getConstant(Log2_32(Scale), DL, XLenVT));
  return {N.getValue(1), Step};
}

// Matmul preserves the ACC type and passes K to instruction selection.
static SDValue lowerZttMatmul(SDValue Op, SelectionDAG &DAG,
                              const RISCVSubtarget &Subtarget, unsigned Opcode,
                              StringRef Name) {
  SDLoc DL(Op);
  MVT AccVT = Op.getSimpleValueType();
  MVT LVT = Op.getOperand(2).getSimpleValueType();
  MVT RVT = Op.getOperand(3).getSimpleValueType();
  if (AccVT.SimpleTy < MVT::riscv_ztta1 || AccVT.SimpleTy > MVT::riscv_ztta8 ||
      !isZttMatrixVT(LVT) || !isZttMatrixVT(RVT))
    report_fatal_error(Twine("Ztt ") + Name +
                       " requires an Acc result and two M sources");
  checkZttAccCapacity(AccVT, Subtarget);
  checkZttMTypeFitsRegister(getZttMatrixLogicalBits(LVT),
                            Subtarget.getZttUdsBits(), Subtarget);
  checkZttMTypeFitsRegister(getZttMatrixLogicalBits(RVT),
                            Subtarget.getZttUdsBits(), Subtarget);
  unsigned K = getZttConstantOperand(Op, 4, "square count");
  if (!K)
    report_fatal_error(Twine("Ztt ") + Name + " requires a nonzero constant K");
  SDValue KOp = DAG.getTargetConstant(K, DL, Subtarget.getXLenVT());
  return DAG.getNode(Opcode, DL, Op.getValueType(), Op.getOperand(1),
                     Op.getOperand(2), Op.getOperand(3), KOp);
}

// Validate the M footprints in diagnostic order and determine how many logical
// squares one hardware operation handles. Packed sources can increase that
// count independently of the result; wide operands still represent one square.
static unsigned getZttElementwiseSquares(ArrayRef<MVT> Types, unsigned K,
                                         const RISCVSubtarget &Subtarget,
                                         StringRef Name) {
  unsigned Uds = Subtarget.getZttUdsBits();
  unsigned SquaresPerOp = 1;
  for (MVT VT : Types) {
    if (!isZttMatrixVT(VT))
      report_fatal_error(Twine("Ztt ") + Name + " requires M sources");
    unsigned Bits = getZttMatrixLogicalBits(VT);
    checkZttMTypeFitsRegister(Bits, Uds, Subtarget);
    if (Bits % K || Bits / K < 4 || Bits / K > 128)
      report_fatal_error(Twine("Ztt ") + Name +
                         " has an invalid source layout");
    SquaresPerOp =
        std::max(SquaresPerOp, getZttSquaresPerMRegister(Bits / K, Uds));
  }
  return SquaresPerOp;
}

/// Logical matrix size, before checking the physical register count.
struct ZttLogicalResult {
  unsigned Squares;
  unsigned ElementBits;
  unsigned LogicalBits;
};

/// Check that result datatype and square count match the result MVT.
static ZttLogicalResult decodeZttResultLayout(SDValue Op, unsigned DIndex,
                                              unsigned KIndex, StringRef Name) {
  MVT VT = Op.getSimpleValueType();
  if (!isZttMatrixVT(VT))
    report_fatal_error(Twine("Ztt ") + Name + " requires an M result");
  unsigned DType = getZttConstantOperand(Op, DIndex, "datatype");
  unsigned K = getZttConstantOperand(Op, KIndex, "square count");
  unsigned E = getZttElementBits(DType);
  unsigned LogicalBits = getZttMatrixLogicalBits(VT);
  if (!isPowerOf2_32(K) || K > 32 || uint64_t(E) * K != LogicalBits)
    report_fatal_error(Twine("Ztt ") + Name + " has an invalid result layout");
  return {K, E, LogicalBits};
}

/// Check the element width of a matrix constructor.
static void checkZttConstructorElementWidth(const ZttLogicalResult &Result,
                                            StringRef Name) {
  if (Result.ElementBits < 4 || Result.ElementBits > 128)
    report_fatal_error(Twine("Ztt ") + Name + " has an invalid result layout");
}

// Lower each slice using its matrix, old-result and scalar operands.
// Datatype-family checks belong to Clang Sema.
static SDValue lowerZttComputedSlice(
    SDValue Op, SelectionDAG &DAG, const RISCVSubtarget &Subtarget,
    const RISCVZttInstrInfo::OperationInfo &Info, unsigned Opcode) {
  SDLoc DL(Op);
  MVT XLenVT = Subtarget.getXLenVT();
  MVT DVT = Op.getSimpleValueType();
  StringRef Name = Info.getName();
  bool ScalarType = Info.HasScalarType;
  bool Scalar = Info.HasScalar;
  unsigned First = 1 + Info.HasChain;
  unsigned Source = First + Info.HasOld;
  unsigned ScalarIndex = Source + Info.NumSources;
  unsigned DIndex = ScalarIndex + Scalar;
  unsigned KIndex = DIndex + 1 + ScalarType;
  if (Info.HasOld && Op.getOperand(First).getValueType() != DVT)
    report_fatal_error("Ztt tied result and old destination must match");
  unsigned Uds = Subtarget.getZttUdsBits();
  auto Layout = decodeZttResultLayout(Op, DIndex, KIndex, Name);
  if (Info.Pairwise && (Layout.Squares != 2 || Layout.ElementBits < Uds))
    report_fatal_error("Ztt zip/unzip requires two unpacked squares");
  SmallVector<MVT, 3> Types{DVT};
  for (unsigned I = 0; I != Info.NumSources; ++I)
    Types.push_back(Op.getOperand(Source + I).getSimpleValueType());
  unsigned SquaresPerOp =
      getZttElementwiseSquares(Types, Layout.Squares, Subtarget, Name);
  // Every matrix footprint, including the result, was validated above.
  auto Registers =
      getZttMRegisterLayout(Layout.LogicalBits, Layout.ElementBits, Uds);
  if (Scalar && Op.getOperand(ScalarIndex).getValueType() != XLenVT)
    report_fatal_error(Twine("Ztt ") + Name + " requires an XLEN scalar");
  if (ScalarType)
    checkZttScalarDescriptor(
        getZttConstantOperand(Op, DIndex + 1, "scalar datatype"));
  SmallVector<SDValue, 8> Ops;
  if (Info.HasChain)
    Ops.push_back(Op.getOperand(0));
  for (unsigned I = First; I != DIndex; ++I)
    Ops.push_back(Op.getOperand(I));
  // A tied pair inherits its metadata; no runtime type setter is needed.
  Ops.push_back(
      Info.Pairwise
          ? DAG.getTargetConstant(getZttConstantOperand(Op, DIndex, "datatype"),
                                  DL, XLenVT)
          : extendZttDTypeToXLen(Op.getOperand(DIndex), DL, XLenVT, DAG));
  if (ScalarType)
    Ops.push_back(
        extendZttDTypeToXLen(Op.getOperand(DIndex + 1), DL, XLenVT, DAG));
  Ops.push_back(DAG.getTargetConstant(
      Info.Pairwise ? 1 : Layout.Squares / SquaresPerOp, DL, XLenVT));
  Ops.push_back(DAG.getTargetConstant(Registers.RegsPerSquare, DL, XLenVT));
  return DAG.getNode(Opcode, DL,
                     Info.HasChain
                         ? DAG.getVTList(Op.getValueType(), MVT::Other)
                         : DAG.getVTList(Op.getValueType()),
                     Ops);
}

// Index constructors have no matrix inputs; N representability is a
// hardware constraint, not a compiler-generated runtime check.
static SDValue lowerZttIndexConstruct(SDValue Op, SelectionDAG &DAG,
                                      const RISCVSubtarget &Subtarget,
                                      unsigned Opcode, StringRef Name) {
  SDLoc DL(Op);
  MVT XLenVT = Subtarget.getXLenVT();
  MVT DVT = Op.getSimpleValueType();
  unsigned Uds = Subtarget.getZttUdsBits();
  auto Layout = decodeZttResultLayout(Op, 1, 2, Name);
  checkZttConstructorElementWidth(Layout, Name);
  checkZttMTypeFitsRegister(getZttMatrixLogicalBits(DVT), Uds, Subtarget);
  auto Registers =
      getZttMRegisterLayout(Layout.LogicalBits, Layout.ElementBits, Uds);
  return DAG.getNode(
      Opcode, DL, Op.getValueType(),
      {extendZttDTypeToXLen(Op.getOperand(1), DL, XLenVT, DAG),
       DAG.getTargetConstant(Layout.Squares / Registers.SquaresPerRegister, DL,
                             XLenVT),
       DAG.getTargetConstant(Registers.RegsPerSquare, DL, XLenVT)});
}

// Initialize M or ACC datatype and, for mzero, numeric zero.
static SDValue
lowerZttInitialize(SDValue Op, SelectionDAG &DAG,
                   const RISCVSubtarget &Subtarget,
                   const RISCVZttInstrInfo::OperationInfo &Info) {
  using RISCVZttInstrInfo::OperandLayout;
  SDLoc DL(Op);
  MVT XLenVT = Subtarget.getXLenVT();
  if (Info.IsAcc) {
    MVT AccVT = Op.getSimpleValueType();
    if (AccVT.SimpleTy < MVT::riscv_ztta1 || AccVT.SimpleTy > MVT::riscv_ztta8)
      report_fatal_error(Info.Layout == OperandLayout::Clear
                             ? "Ztt accumulator clear requires an Acc type"
                             : "Ztt accumulator zero requires an Acc type");
    checkZttAccCapacity(AccVT, Subtarget);
    unsigned ElementBits =
        getZttElementBits(getZttConstantOperand(Op, 1, "datatype"));
    SDValue DType = extendZttDTypeToXLen(Op.getOperand(1), DL, XLenVT, DAG);
    unsigned Group = AccVT.SimpleTy - unsigned(MVT::riscv_ztta1);
    return DAG.getNode(getZttGroupOpcode(Info.Operation, 1U << Group), DL,
                       Op.getValueType(), DType,
                       DAG.getTargetConstant(ElementBits, DL, XLenVT));
  }
  unsigned UdsBits = Subtarget.getZttUdsBits();
  unsigned ElementBits =
      getZttElementBits(getZttConstantOperand(Op, 1, "datatype"));
  unsigned LogicalBits =
      ElementBits * getZttConstantOperand(Op, 2, "square count");
  checkZttMTypeFitsRegister(LogicalBits, UdsBits, Subtarget);
  unsigned GroupSize = getZttMRegisterGroupSize(LogicalBits, UdsBits);

  unsigned RegsPerUnit = getZttMRegisterGroupSize(ElementBits, UdsBits);

  SDValue DType = extendZttDTypeToXLen(Op.getOperand(1), DL, XLenVT, DAG);
  unsigned Opc = getZttGroupOpcode(Info.Operation, GroupSize);
  SDValue RegsPerUnitOp = DAG.getTargetConstant(RegsPerUnit, DL, XLenVT);
  return DAG.getNode(Opc, DL, Op.getValueType(), DType, RegsPerUnitOp);
}

// Copy, concat and extract use the datatype supplied by the intrinsic.
static SDValue lowerZttTransfer(SDValue Op, SelectionDAG &DAG,
                                const RISCVSubtarget &Subtarget,
                                const RISCVZttInstrInfo::OperationInfo &Info,
                                unsigned Opcode) {
  using RISCVZttInstrInfo::OperandLayout;
  SDLoc DL(Op);
  MVT XLenVT = Subtarget.getXLenVT();
  switch (Info.Layout) {
  case OperandLayout::Copy: {
    unsigned UdsBits = Subtarget.getZttUdsBits();
    uint32_t Descriptor = getZttConstantOperand(Op, 2, "datatype");
    unsigned ElementBits = getZttElementBits(Descriptor);
    unsigned LogicalBits =
        ElementBits * getZttConstantOperand(Op, 3, "square count");
    checkZttMTypeFitsRegister(LogicalBits, UdsBits, Subtarget);
    ZttMRegisterLayout Layout =
        getZttMRegisterLayout(LogicalBits, ElementBits, UdsBits);
    unsigned GroupSize = Layout.GroupSize;
    unsigned RegsPerUnit = Layout.RegsPerSquare;
    if (GroupSize % RegsPerUnit)
      report_fatal_error("invalid Ztt mcopy register group");
    SDValue RegsPerUnitOp = DAG.getTargetConstant(RegsPerUnit, DL, XLenVT);
    // Preserve the complete descriptor supplied by the intrinsic. Internal
    // physical COPY still reads metadata from its source instead.
    SDValue DType = DAG.getConstant(Descriptor, DL, XLenVT);
    SDVTList VTs = DAG.getVTList(Op.getValueType());
    return DAG.getNode(getZttGroupOpcode(Info.Operation, GroupSize), DL, VTs,
                       Op.getOperand(1), RegsPerUnitOp, DType);
  }
  case OperandLayout::Concat: {
    unsigned UdsBits = Subtarget.getZttUdsBits();
    MVT DstVT = Op.getSimpleValueType();
    MVT LVT = Op.getOperand(1).getSimpleValueType();
    MVT RVT = Op.getOperand(2).getSimpleValueType();
    if (!isZttMatrixVT(DstVT) || !isZttMatrixVT(LVT) || LVT != RVT)
      report_fatal_error(
          "Ztt mconcat.m requires two identical M sources and an M result");
    uint32_t Descriptor = getZttConstantOperand(Op, 3, "datatype");
    unsigned ElementBits = getZttElementBits(Descriptor);
    unsigned SrcLogicalBits =
        ElementBits * getZttConstantOperand(Op, 4, "square count");
    if (getZttMatrixLogicalBits(LVT) != SrcLogicalBits ||
        getZttMatrixLogicalBits(DstVT) != 2 * SrcLogicalBits)
      report_fatal_error("invalid Ztt mconcat.m logical types");
    checkZttMTypeFitsRegister(SrcLogicalBits, UdsBits, Subtarget);
    ZttMRegisterLayout SrcLayout =
        getZttMRegisterLayout(SrcLogicalBits, ElementBits, UdsBits);
    ZttMRegisterLayout DstLayout =
        getZttMRegisterLayout(2 * SrcLogicalBits, ElementBits, UdsBits);
    checkZttMTypeFitsRegister(2 * SrcLogicalBits, UdsBits, Subtarget);
    if (DstLayout.GroupSize != 2 * SrcLayout.GroupSize ||
        DstLayout.RegsPerSquare != SrcLayout.RegsPerSquare)
      report_fatal_error("invalid Ztt mconcat.m register groups");
    // A full-register-file destination leaves no space for either source.
    // Reject it before register allocation instead of allowing destructive
    // overlap or reporting an impossible allocation as register pressure.
    if (DstLayout.GroupSize == 32)
      report_fatal_error(
          "Ztt mconcat.m requires a destination register group "
          "disjoint from both sources; M32 results are unsupported");
    if (DstLayout.GroupSize == Subtarget.getZttMRegs())
      report_fatal_error(
          "Ztt mconcat.m has no room for disjoint source registers");
    SDValue RegsPerSquare =
        DAG.getTargetConstant(SrcLayout.RegsPerSquare, DL, XLenVT);
    SDValue DType = DAG.getConstant(Descriptor, DL, XLenVT);
    SDVTList VTs = DAG.getVTList(Op.getValueType());
    return DAG.getNode(getZttGroupOpcode(Info.Operation, DstLayout.GroupSize),
                       DL, VTs, Op.getOperand(1), Op.getOperand(2),
                       RegsPerSquare, DType);
  }
  case OperandLayout::CrossCopy: {
    bool IsM2A = Info.IsAcc;
    MVT ResultVT = Op.getSimpleValueType();
    MVT SourceVT = Op.getOperand(1).getSimpleValueType();
    MVT AccVT = IsM2A ? ResultVT : SourceVT;
    MVT MatrixVT = IsM2A ? SourceVT : ResultVT;
    if (AccVT.SimpleTy < MVT::riscv_ztta1 ||
        AccVT.SimpleTy > MVT::riscv_ztta8 || !isZttMatrixVT(MatrixVT))
      report_fatal_error(
          "Ztt cross-register mcopy requires one M type and one Acc type");

    unsigned UdsBits = Subtarget.getZttUdsBits();
    uint32_t Descriptor = getZttConstantOperand(Op, 2, "datatype");
    unsigned ElementBits = getZttElementBits(Descriptor);
    unsigned Squares = getZttConstantOperand(Op, 3, "square count");
    unsigned AccSquares = 1U << (AccVT.SimpleTy - unsigned(MVT::riscv_ztta1));
    checkZttAccCapacity(AccVT, Subtarget);
    unsigned MatrixLogicalBits = getZttMatrixLogicalBits(MatrixVT);
    checkZttMTypeFitsRegister(MatrixLogicalBits, UdsBits, Subtarget);
    if (Squares != MatrixLogicalBits / ElementBits ||
        MatrixLogicalBits % ElementBits != 0 || Squares != AccSquares)
      report_fatal_error(
          "Ztt cross-register mcopy M and Acc square counts must match");
    ZttMRegisterLayout Layout =
        getZttMRegisterLayout(MatrixLogicalBits, ElementBits, UdsBits);
    unsigned MRegsPerSquare = Layout.RegsPerSquare;
    unsigned AccsPerMove = std::min(Squares, Layout.SquaresPerRegister);
    SDValue MRegsOp = DAG.getTargetConstant(MRegsPerSquare, DL, XLenVT);
    SDValue AccsOp = DAG.getTargetConstant(AccsPerMove, DL, XLenVT);
    SDVTList VTs = DAG.getVTList(Op.getValueType());
    SDValue DType = DAG.getConstant(Descriptor, DL, XLenVT);
    return DAG.getNode(Opcode, DL, VTs, Op.getOperand(1), MRegsOp, AccsOp,
                       DType);
  }
  case OperandLayout::Extract: {
    SDLoc DL(Op);
    MVT XLenVT = Subtarget.getXLenVT();
    MVT DVT = Op.getSimpleValueType();
    unsigned Uds = Subtarget.getZttUdsBits();
    auto Layout = decodeZttResultLayout(Op, 3, 4, "mextract");
    MVT SrcVT = Op.getOperand(1).getSimpleValueType();
    if (!isZttMatrixVT(SrcVT) ||
        getZttMatrixLogicalBits(SrcVT) != 2 * getZttMatrixLogicalBits(DVT))
      report_fatal_error(
          "Ztt mextract requires a source twice the result size");
    checkZttMTypeFitsRegister(getZttMatrixLogicalBits(DVT), Uds, Subtarget);
    auto Registers =
        getZttMRegisterLayout(Layout.LogicalBits, Layout.ElementBits, Uds);
    checkZttMTypeFitsRegister(getZttMatrixLogicalBits(SrcVT), Uds, Subtarget);
    unsigned Index = getZttConstantOperand(Op, 2, "index");
    if (Index > 1)
      report_fatal_error("Ztt mextract index must be 0 or 1");
    if (Op.getOperand(2).getValueType() != XLenVT)
      report_fatal_error("Ztt mextract requires an XLEN scalar");
    return DAG.getNode(
        Opcode, DL, DAG.getVTList(Op.getValueType()),
        {Op.getOperand(1), DAG.getTargetConstant(Index, DL, XLenVT),
         extendZttDTypeToXLen(Op.getOperand(3), DL, XLenVT, DAG),
         DAG.getTargetConstant(Layout.Squares / Registers.SquaresPerRegister,
                               DL, XLenVT),
         DAG.getTargetConstant(Registers.RegsPerSquare, DL, XLenVT)});
  }
  default:
    llvm_unreachable("unexpected Ztt transfer layout");
  }
}

/// Memory operands and decoded layout. An empty Value denotes a load.
struct ZttMemoryOperands {
  SDValue Chain, Base, Value, ByteStride, Descriptor;
  unsigned Datatype, ElementBits, LogicalBits;
};

static unsigned getZttMemoryElementBits(unsigned Datatype) {
  unsigned Bits = getZttElementBits(Datatype);
  if (Bits < 8)
    report_fatal_error(
        "Ztt load/store requires an element width of at least 8 bits");
  return Bits;
}

/// Read (base[, value], datatype, squares).
static ZttMemoryOperands decodeZttContiguousMemory(SDValue Op, bool IsLoad) {
  unsigned DIndex = IsLoad ? 3 : 4;
  unsigned Datatype = getZttConstantOperand(Op, DIndex, "datatype");
  unsigned ElementBits = getZttMemoryElementBits(Datatype);
  unsigned Bits =
      ElementBits * getZttConstantOperand(Op, DIndex + 1, "square count");
  return {Op.getOperand(0),
          Op.getOperand(2),
          IsLoad ? SDValue() : Op.getOperand(3),
          SDValue(),
          Op.getOperand(DIndex),
          Datatype,
          ElementBits,
          Bits};
}

/// Read (base, stride[, value], datatype, squares).
static ZttMemoryOperands decodeZttStridedMemory(SDValue Op, bool IsLoad) {
  unsigned DIndex = IsLoad ? 4 : 5;
  unsigned Datatype = getZttConstantOperand(Op, DIndex, "datatype");
  unsigned ElementBits = getZttMemoryElementBits(Datatype);
  unsigned Bits =
      ElementBits * getZttConstantOperand(Op, DIndex + 1, "square count");
  return {Op.getOperand(0),
          Op.getOperand(2),
          IsLoad ? SDValue() : Op.getOperand(4),
          Op.getOperand(3),
          Op.getOperand(DIndex),
          Datatype,
          ElementBits,
          Bits};
}

/// Arrange contiguous load/store operands for the target DAG node.
static SmallVector<SDValue, 7>
getZttContiguousMemoryNodeOperands(const ZttMemoryOperands &M,
                                   ZttMemoryAddressing Addressing,
                                   SDValue Width, SDValue DType) {
  if (M.Value)
    return {Addressing.Chain, M.Value, M.Base, Width, Addressing.Stride};
  return {Addressing.Chain, M.Base, DType, Width, Addressing.Stride};
}

/// Strided stores retain an immediate descriptor, never a datatype GPR.
static SmallVector<SDValue, 7>
getZttStridedMemoryNodeOperands(const ZttMemoryOperands &M,
                                ZttMemoryAddressing Addressing, SDValue Width,
                                SDValue DType) {
  if (M.Value)
    return {Addressing.Chain, M.Base, M.ByteStride, M.Value, DType, Width,
            Addressing.Stride};
  return {Addressing.Chain, M.Base, M.ByteStride, DType, Width,
          Addressing.Stride};
}

// Lower the register layout, address step and memory dependency together.
static SDValue lowerZttMemory(SDValue Op, SelectionDAG &DAG,
                              const RISCVSubtarget &Subtarget,
                              const RISCVZttInstrInfo::OperationInfo &Info,
                              unsigned Opcode) {
  SDLoc DL(Op);
  MVT XLenVT = Subtarget.getXLenVT();
  unsigned UdsBits = Subtarget.getZttUdsBits();
  bool Strided = Info.Layout == RISCVZttInstrInfo::OperandLayout::StridedMemory;
  ZttMemoryOperands M = Strided ? decodeZttStridedMemory(Op, Info.IsLoad)
                                : decodeZttContiguousMemory(Op, Info.IsLoad);
  checkZttMTypeFitsRegister(M.LogicalBits, UdsBits, Subtarget);
  auto Layout = getZttMRegisterLayout(M.LogicalBits, M.ElementBits, UdsBits);
  if (!Strided && Layout.GroupSize % Layout.RegsPerSquare)
    report_fatal_error(Info.IsLoad ? "invalid Ztt load register group"
                                   : "invalid Ztt store register group");
  if (Strided && M.ByteStride.getValueType() != XLenVT)
    report_fatal_error("Ztt strided memory requires an XLEN byte stride");
  ZttMemoryMode Mode = !Strided          ? ZttMemoryMode::Contiguous
                       : Info.Transposed ? ZttMemoryMode::TransposedStrided
                                         : ZttMemoryMode::Strided;
  auto Addressing =
      getZttMemoryAddressing(M.Chain, Layout, std::max(M.ElementBits, UdsBits),
                             M.ByteStride, Mode, DL, XLenVT, DAG);
  SDValue Width = DAG.getTargetConstant(Layout.RegsPerSquare, DL, XLenVT);
  SDValue DType;
  if (Info.IsLoad)
    DType = extendZttDTypeToXLen(M.Descriptor, DL, XLenVT, DAG);
  else if (Strided)
    DType = DAG.getTargetConstant(M.Datatype, DL, XLenVT);
  auto Ops =
      Strided ? getZttStridedMemoryNodeOperands(M, Addressing, Width, DType)
              : getZttContiguousMemoryNodeOperands(M, Addressing, Width, DType);
  unsigned NodeOpcode =
      Strided ? Opcode : getZttGroupOpcode(Info.Operation, Layout.GroupSize);
  auto *MMO = cast<MemIntrinsicSDNode>(Op)->getMemOperand();
  SDValue Mem = DAG.getMemIntrinsicNode(
      NodeOpcode, DL,
      Info.IsLoad ? DAG.getVTList(Op.getValueType(), XLenVT, MVT::Other)
                  : DAG.getVTList(XLenVT, MVT::Other),
      Ops, Info.IsLoad ? Op.getValueType() : M.Value.getValueType(), MMO);
  return Info.IsLoad ? DAG.getMergeValues({Mem, Mem.getValue(2)}, DL)
                     : Mem.getValue(1);
}

// Broadcast carries scalar metadata directly, without an amestype chain.
static SDValue lowerZttBroadcast(SDValue Op, SelectionDAG &DAG,
                                 const RISCVSubtarget &Subtarget) {
  SDLoc DL(Op);
  MVT XLenVT = Subtarget.getXLenVT();
  MVT DVT = Op.getSimpleValueType();
  unsigned Uds = Subtarget.getZttUdsBits();
  auto Layout = decodeZttResultLayout(Op, 2, 4, "mbcast.m.x");
  checkZttConstructorElementWidth(Layout, "mbcast.m.x");
  checkZttMTypeFitsRegister(getZttMatrixLogicalBits(DVT), Uds, Subtarget);
  auto Registers =
      getZttMRegisterLayout(Layout.LogicalBits, Layout.ElementBits, Uds);
  if (Op.getOperand(1).getValueType() != XLenVT)
    report_fatal_error("Ztt mbcast.m.x requires an XLEN scalar");
  checkZttScalarDescriptor(getZttConstantOperand(Op, 3, "scalar datatype"));
  // Unlike elementwise data scalars, broadcast carries its descriptor in
  // rs2 directly. It neither reads nor writes amestype.
  return DAG.getNode(
      RISCVISD::ZTT_MBCAST_M_X, DL, DAG.getVTList(Op.getValueType()),
      {Op.getOperand(1),
       extendZttDTypeToXLen(Op.getOperand(2), DL, XLenVT, DAG),
       extendZttDTypeToXLen(Op.getOperand(3), DL, XLenVT, DAG),
       DAG.getTargetConstant(Layout.Squares / Registers.SquaresPerRegister, DL,
                             XLenVT),
       DAG.getTargetConstant(Registers.RegsPerSquare, DL, XLenVT)});
}

SDValue RISCVTargetLowering::lowerZttIntrinsic(SDValue Op, SelectionDAG &DAG,
                                               unsigned IntNo) const {
  const auto *Hook = RISCVZttLowering::getIntrinsicLoweringInfo(IntNo);
  assert(Hook && "missing Ztt intrinsic mapping");
  const auto *Info = RISCVZttInstrInfo::getOperationInfo(Hook->Operation);
  assert(Info && "missing Ztt operation metadata");
  switch (Info->Kind) {
  case RISCVZttInstrInfo::CodeGenKind::Slice:
    if (Info->Layout != RISCVZttInstrInfo::OperandLayout::Matrix)
      return lowerZttInitialize(Op, DAG, Subtarget, *Info);
    if (!Info->NumSources && !Info->HasOld) {
      if (Info->HasScalar)
        return lowerZttBroadcast(Op, DAG, Subtarget);
      return lowerZttIndexConstruct(Op, DAG, Subtarget, Hook->DAGOpcode,
                                    Info->getName());
    }
    return lowerZttComputedSlice(Op, DAG, Subtarget, *Info, Hook->DAGOpcode);
  case RISCVZttInstrInfo::CodeGenKind::Matmul:
    return lowerZttMatmul(Op, DAG, Subtarget, Hook->DAGOpcode, Info->getName());
  case RISCVZttInstrInfo::CodeGenKind::Transfer:
    return lowerZttTransfer(Op, DAG, Subtarget, *Info, Hook->DAGOpcode);
  case RISCVZttInstrInfo::CodeGenKind::Memory:
    return lowerZttMemory(Op, DAG, Subtarget, *Info, Hook->DAGOpcode);
  case RISCVZttInstrInfo::CodeGenKind::State:
    llvm_unreachable("state operations use instruction patterns");
  }
  llvm_unreachable("unexpected Ztt intrinsic");
}
