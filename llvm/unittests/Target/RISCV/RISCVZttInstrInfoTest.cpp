//===- RISCVZttInstrInfoTest.cpp - Ztt instruction information tests ------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RISCVISelLowering.h"
#include "RISCVInstrInfo.h"
#include "RISCVSelectionDAGInfo.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Twine.h"
#include "llvm/IR/IntrinsicsRISCV.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/TargetSelect.h"
#include "gtest/gtest.h"

using namespace llvm;
using namespace llvm::RISCVZttInstrInfo;
using namespace llvm::RISCVZttLowering;

namespace {

struct ClearZeroOperation {
  unsigned ID;
  ZttOperationID Operation;
  bool IsAcc;
  OperandLayout Layout;
  const char *PseudoPrefix;
  const char *DAGPrefix;
};

constexpr ClearZeroOperation ClearZeroOperations[] = {
    {Intrinsic::riscv_ztt_mclear_m, MCLEAR_M, false, OperandLayout::Clear,
     "PseudoZTTMSetTypM", "RISCVISD::ZTT_MCLEAR_M"},
    {Intrinsic::riscv_ztt_mclear_acc, MCLEAR_ACC, true, OperandLayout::Clear,
     "PseudoZTTAClearA", "RISCVISD::ZTT_ACLEAR_A"},
    {Intrinsic::riscv_ztt_mzero_m, MZERO_M, false, OperandLayout::Zero,
     "PseudoZTTMZeroM", "RISCVISD::ZTT_MZERO_M"},
    {Intrinsic::riscv_ztt_mzero_acc, MZERO_ACC, true, OperandLayout::Zero,
     "PseudoZTTAZeroA", "RISCVISD::ZTT_AZERO_A"}};

// Expose the generated DAG descriptions for operand checks.
struct TestDAGInfo : RISCVSelectionDAGInfo {
  using SelectionDAGGenTargetInfo::GenNodeInfo;
};

TEST(RISCVZttInstrInfo, IntrinsicLoweringHooks) {
  for (const auto &Expected : ClearZeroOperations) {
    const auto *Info = getIntrinsicLoweringInfo(Expected.ID);
    ASSERT_NE(Info, nullptr);
    EXPECT_EQ(Info->IntrinsicID, Expected.ID);
    EXPECT_EQ(Info->Opcode, ISD::INTRINSIC_WO_CHAIN);
    EXPECT_EQ(Info->Operation, Expected.Operation);
  }
  EXPECT_EQ(getIntrinsicLoweringInfo(Intrinsic::riscv_orc_b), nullptr);
}

// Check all groups independently of the generated table's own entries.
TEST(RISCVZttInstrInfo, ClearZeroGroups) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTargetMC();
  TestDAGInfo DAGInfo;
  const unsigned MClasses[] = {
      RISCV::ZTTMRRegClassID,    RISCV::ZTTMRM2RegClassID,
      RISCV::ZTTMRM4RegClassID,  RISCV::ZTTMRM8RegClassID,
      RISCV::ZTTMRM16RegClassID, RISCV::ZTTMRM32RegClassID};
  const unsigned ACCClasses[] = {
      RISCV::ZTTARRegClassID, RISCV::ZTTARM2RegClassID,
      RISCV::ZTTARM4RegClassID, RISCV::ZTTARM8RegClassID};

  for (StringRef TripleName : {"riscv32", "riscv64"}) {
    SCOPED_TRACE(TripleName.str());
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(Triple(TripleName), Error);
    ASSERT_NE(T, nullptr) << Error;
    std::unique_ptr<MCInstrInfo> MCII(T->createMCInstrInfo());
    for (const auto &Expected : ClearZeroOperations) {
      SCOPED_TRACE(Expected.PseudoPrefix);
      const auto *Intrinsic = getIntrinsicLoweringInfo(Expected.ID);
      ASSERT_NE(Intrinsic, nullptr);
      const auto *Op = getOperationInfo(Expected.Operation);
      ASSERT_NE(Op, nullptr);
      EXPECT_EQ(Op->Operation, Expected.Operation);
      EXPECT_EQ(Op->Operation, Intrinsic->Operation);
      EXPECT_EQ(Op->IsAcc, Expected.IsAcc);
      EXPECT_EQ(Op->Layout, Expected.Layout);
      ArrayRef<unsigned> Classes =
          Expected.IsAcc ? ArrayRef(ACCClasses) : ArrayRef(MClasses);
      for (unsigned I = 0; I != Classes.size(); ++I) {
        unsigned Group = 1U << I;
        SCOPED_TRACE(Group);
        const auto *P = getPseudoForGroups(Expected.Operation, Group);
        ASSERT_NE(P, nullptr);
        EXPECT_EQ(P->Operation, Expected.Operation);
        EXPECT_EQ(P->DstGroup, Group);
        EXPECT_EQ(getPseudoInfo(P->Pseudo), P);
        const auto *DAG = getDAGNodeInfo(P->Pseudo);
        ASSERT_NE(DAG, nullptr);
        EXPECT_EQ(DAG->Pseudo, P->Pseudo);
        EXPECT_EQ(getDAGPseudoInfo(DAG->DAGOpcode), P);
        EXPECT_EQ(getDAGOperationInfo(DAG->DAGOpcode), Op);
        if (Group == 1)
          EXPECT_EQ(Intrinsic->DAGOpcode, DAG->DAGOpcode);
        EXPECT_EQ(MCII->getName(P->Pseudo),
                  (Twine(Expected.PseudoPrefix) + Twine(Group)).str());
        EXPECT_EQ(DAGInfo.GenNodeInfo.getName(DAG->DAGOpcode),
                  (Twine(Expected.DAGPrefix) + Twine(Group)).str());

        const MCInstrDesc &Desc = MCII->get(P->Pseudo);
        EXPECT_TRUE(Desc.isPseudo());
        EXPECT_EQ(Desc.getNumDefs(), 1U);
        ASSERT_EQ(Desc.getNumOperands(), 3U);
        EXPECT_FALSE(Desc.mayLoad());
        EXPECT_FALSE(Desc.mayStore());
        EXPECT_TRUE(Desc.hasUnmodeledSideEffects());
        EXPECT_EQ(Desc.operands()[0].RegClass, int(Classes[I]));
        EXPECT_EQ(Desc.operands()[1].RegClass, RISCV::GPRRegClassID);
        EXPECT_EQ(Desc.operands()[2].RegClass, -1);
        for (unsigned J = 0; J != Desc.getNumOperands(); ++J) {
          EXPECT_EQ(Desc.getOperandConstraint(J, MCOI::TIED_TO), -1);
          EXPECT_EQ(Desc.getOperandConstraint(J, MCOI::EARLY_CLOBBER), -1);
        }
        EXPECT_EQ(RISCV::getNamedOperandIdx(P->Pseudo, RISCV::OpName::rd), 0);
        RISCV::OpName TypeName = Expected.Layout == OperandLayout::Clear
                                     ? RISCV::OpName::rs1
                                     : RISCV::OpName::dtype;
        RISCV::OpName LayoutName = Expected.IsAcc ? RISCV::OpName::element_bits
                                   : Expected.Layout == OperandLayout::Clear
                                       ? RISCV::OpName::regs_per_unit
                                       : RISCV::OpName::regs_per_square;
        EXPECT_EQ(RISCV::getNamedOperandIdx(P->Pseudo, TypeName), 1);
        EXPECT_EQ(RISCV::getNamedOperandIdx(P->Pseudo, LayoutName), 2);

        const auto &Node = DAGInfo.GenNodeInfo.getDesc(DAG->DAGOpcode);
        EXPECT_EQ(Node.NumResults, 1U);
        EXPECT_EQ(Node.NumOperands, 2);
        EXPECT_EQ(Node.Properties, 0U);
        auto Constraints = DAGInfo.GenNodeInfo.getConstraints(DAG->DAGOpcode);
        ASSERT_EQ(Constraints.size(), 2U);
        EXPECT_NE(Constraints[0].ConstrainedValIdx,
                  Constraints[1].ConstrainedValIdx);
        for (const auto &Constraint : Constraints) {
          EXPECT_EQ(Constraint.Kind, SDTCisVT);
          EXPECT_TRUE(Constraint.ConstrainedValIdx == 1 ||
                      Constraint.ConstrainedValIdx == 2);
        }
      }

      unsigned Count = 0;
      for (unsigned Opcode = 0; Opcode != RISCV::INSTRUCTION_LIST_END; ++Opcode)
        if (const auto *P = getPseudoInfo(Opcode))
          Count += P->Operation == Expected.Operation;
      EXPECT_EQ(Count, Classes.size());
      for (unsigned Group : {0U, 3U, 64U})
        EXPECT_EQ(getPseudoForGroups(Expected.Operation, Group), nullptr);
      if (Expected.IsAcc)
        for (unsigned Group : {16U, 32U})
          EXPECT_EQ(getPseudoForGroups(Expected.Operation, Group), nullptr);
    }
  }
}

TEST(RISCVZttInstrInfo, UnmappedOpcodes) {
  EXPECT_EQ(getOperationInfo(~0U), nullptr);
  EXPECT_EQ(getPseudoForGroups(~0U, 1), nullptr);
  EXPECT_EQ(getPseudoInfo(RISCV::ADD), nullptr);
  EXPECT_EQ(getPseudoInfo(RISCV::ZTT_MSETTYP), nullptr);
  EXPECT_EQ(getDAGNodeInfo(RISCV::ADD), nullptr);
  EXPECT_EQ(getDAGNodeInfo(RISCV::ZTT_MSETTYP), nullptr);
  for (unsigned Opcode : {unsigned(ISD::ADD), unsigned(RISCVISD::RET_GLUE),
                          unsigned(RISCVISD::GENERATED_OPCODE_END)}) {
    EXPECT_EQ(getDAGPseudoInfo(Opcode), nullptr);
    EXPECT_EQ(getDAGOperationInfo(Opcode), nullptr);
  }
}

struct TransferOperation {
  unsigned ID;
  ZttOperationID Operation;
  OperandLayout Layout;
  bool IsAcc;
  unsigned DAGOpcode;
  const char *PseudoPrefix;
  const char *DAGPrefix;
  unsigned NumGroups;
};

constexpr TransferOperation TransferOperations[] = {
    {Intrinsic::riscv_ztt_mcopy_m2m, MCOPY_M2M, OperandLayout::Copy, false,
     RISCVISD::ZTT_MCOPY_M1, "PseudoZTTMCopyM", "RISCVISD::ZTT_MCOPY_M", 6},
    {Intrinsic::riscv_ztt_mconcat_m, MCONCAT_M, OperandLayout::Concat, false,
     RISCVISD::ZTT_MCONCAT_M2, "PseudoZTTMConcatM", "RISCVISD::ZTT_MCONCAT_M",
     5},
    {Intrinsic::riscv_ztt_mcopy_m2a, MCOPY_M2A, OperandLayout::CrossCopy, true,
     RISCVISD::ZTT_MCOPY_M2A, "PseudoZTTMCopyM2A", "RISCVISD::ZTT_MCOPY_M2A",
     21},
    {Intrinsic::riscv_ztt_mcopy_a2m, MCOPY_A2M, OperandLayout::CrossCopy, false,
     RISCVISD::ZTT_MCOPY_A2M, "PseudoZTTMCopyA2M", "RISCVISD::ZTT_MCOPY_A2M",
     21},
    {Intrinsic::riscv_ztt_mextract, MEXTRACT, OperandLayout::Extract, false,
     RISCVISD::ZTT_MEXTRACT, "PseudoZTTMextract", "RISCVISD::ZTT_MEXTRACT",
     36}};

static void checkTransferDAG(const SDNodeInfo &Info, unsigned Opcode,
                             OperandLayout Layout) {
  bool Copy = Layout == OperandLayout::Copy;
  bool Concat = Layout == OperandLayout::Concat;
  unsigned NumOperands = Copy ? 3 : Layout == OperandLayout::Extract ? 5 : 4;
  unsigned FirstScalar = Concat ? 3 : 2;
  const auto &Node = Info.getDesc(Opcode);
  EXPECT_EQ(Node.NumResults, 1U);
  EXPECT_EQ(Node.NumOperands, int(NumOperands));
  EXPECT_EQ(Node.Properties, 0U);
  auto Constraints = Info.getConstraints(Opcode);
  ASSERT_EQ(Constraints.size(),
            NumOperands - FirstScalar + 1 + (Copy || Concat));
  unsigned ScalarMask = 0;
  unsigned SameTypes = 0;
  for (const auto &Constraint : Constraints) {
    if (Constraint.Kind == SDTCisSameAs) {
      ++SameTypes;
      EXPECT_EQ(Constraint.ConstrainedValIdx, Concat ? 1 : 0);
      EXPECT_EQ(Constraint.ConstrainingValIdx, Concat ? 2 : 1);
      continue;
    }
    EXPECT_EQ(Constraint.Kind, SDTCisVT);
    ASSERT_GE(Constraint.ConstrainedValIdx, FirstScalar);
    ASSERT_LE(Constraint.ConstrainedValIdx, NumOperands);
    EXPECT_NE(Constraint.NumHwModes, 0); // XLEN differs between RV32 and RV64.
    ScalarMask |= 1U << Constraint.ConstrainedValIdx;
  }
  EXPECT_EQ(SameTypes, unsigned(Copy || Concat));
  EXPECT_EQ(ScalarMask, (1U << (NumOperands + 1)) - (1U << FirstScalar));
}

TEST(RISCVZttInstrInfo, TransferGroups) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTargetMC();
  TestDAGInfo DAGInfo;
  const unsigned Groups[] = {1, 2, 4, 8, 16, 32};
  const unsigned NoSource[] = {0};
  const int MClasses[] = {RISCV::ZTTMRRegClassID,    RISCV::ZTTMRM2RegClassID,
                          RISCV::ZTTMRM4RegClassID,  RISCV::ZTTMRM8RegClassID,
                          RISCV::ZTTMRM16RegClassID, RISCV::ZTTMRM32RegClassID};
  const int ACCClasses[] = {RISCV::ZTTARRegClassID, RISCV::ZTTARM2RegClassID,
                            RISCV::ZTTARM4RegClassID, RISCV::ZTTARM8RegClassID};

  for (StringRef TripleName : {"riscv32", "riscv64"}) {
    SCOPED_TRACE(TripleName.str());
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(Triple(TripleName), Error);
    ASSERT_NE(T, nullptr) << Error;
    std::unique_ptr<MCInstrInfo> MCII(T->createMCInstrInfo());
    for (const auto &Expected : TransferOperations) {
      SCOPED_TRACE(Expected.PseudoPrefix);
      const auto *Op = getOperationInfo(Expected.Operation);
      ASSERT_NE(Op, nullptr);
      EXPECT_EQ(Op->Operation, Expected.Operation);
      EXPECT_EQ(Op->IsAcc, Expected.IsAcc);
      EXPECT_EQ(Op->Layout, Expected.Layout);
      const auto *Intrinsic = getIntrinsicLoweringInfo(Expected.ID);
      ASSERT_NE(Intrinsic, nullptr);
      EXPECT_EQ(Intrinsic->IntrinsicID, Expected.ID);
      EXPECT_EQ(Intrinsic->Operation, Expected.Operation);
      EXPECT_EQ(Intrinsic->Opcode, ISD::INTRINSIC_WO_CHAIN);
      EXPECT_EQ(Intrinsic->DAGOpcode, Expected.DAGOpcode);

      bool Cross = Expected.Layout == OperandLayout::CrossCopy;
      bool Extract = Expected.Layout == OperandLayout::Extract;
      bool Concat = Expected.Layout == OperandLayout::Concat;
      ArrayRef<unsigned> Sources =
          Cross || Extract ? ArrayRef(Groups) : ArrayRef(NoSource);
      unsigned Count = 0;
      for (unsigned DI = 0; DI != std::size(Groups); ++DI) {
        unsigned D = Groups[DI];
        for (unsigned SI = 0; SI != Sources.size(); ++SI) {
          unsigned S = Sources[SI];
          SCOPED_TRACE((Twine(D) + "/" + Twine(S)).str());
          const auto *P = getPseudoForGroups(Expected.Operation, D, S);
          unsigned A = Expected.IsAcc ? D : S;
          unsigned M = Expected.IsAcc ? S : D;
          bool Valid = !Concat || D >= 2;
          if (Cross)
            Valid = A <= 8 && (A == 1 || M <= A * 4);
          EXPECT_EQ(P != nullptr, Valid);
          if (!P || !Valid)
            continue;
          ++Count;
          EXPECT_EQ(P->Operation, Expected.Operation);
          EXPECT_EQ(P->DstGroup, D);
          EXPECT_EQ(P->Src0Group, S);
          EXPECT_EQ(getPseudoInfo(P->Pseudo), P);
          const auto *DAG = getDAGNodeInfo(P->Pseudo);
          ASSERT_NE(DAG, nullptr);
          EXPECT_EQ(DAG->Pseudo, P->Pseudo);
          EXPECT_EQ(getDAGOperationInfo(DAG->DAGOpcode), Op);
          const auto *DAGPseudo = getDAGPseudoInfo(DAG->DAGOpcode);
          ASSERT_NE(DAGPseudo, nullptr);
          EXPECT_EQ(DAGPseudo->Operation, Expected.Operation);
          const auto *MappedDAG = getDAGNodeInfo(DAGPseudo->Pseudo);
          ASSERT_NE(MappedDAG, nullptr);
          EXPECT_EQ(MappedDAG->DAGOpcode, DAG->DAGOpcode);
          if (!Cross && !Extract)
            EXPECT_EQ(DAGPseudo, P);
          else
            EXPECT_EQ(DAG->DAGOpcode, Intrinsic->DAGOpcode);

          SmallVector<int, 6> Classes;
          SmallVector<RISCV::OpName, 6> Names;
          std::string Suffix;
          if (Cross) {
            Classes = {Expected.IsAcc ? ACCClasses[DI] : MClasses[DI],
                       Expected.IsAcc ? MClasses[SI] : ACCClasses[SI], -1, -1,
                       RISCV::GPRRegClassID};
            Names = {RISCV::OpName::rd, RISCV::OpName::src,
                     RISCV::OpName::mregs_per_square,
                     RISCV::OpName::accs_per_move, RISCV::OpName::dtype};
            Suffix = (Twine("_A") + Twine(A) + "_M" + Twine(M)).str();
          } else if (Concat) {
            Classes = {MClasses[DI], MClasses[DI - 1], MClasses[DI - 1], -1,
                       RISCV::GPRRegClassID};
            Names = {RISCV::OpName::rd, RISCV::OpName::lhs, RISCV::OpName::rhs,
                     RISCV::OpName::regs_per_square, RISCV::OpName::dtype};
            Suffix = Twine(D).str();
          } else if (Extract) {
            Classes = {MClasses[DI],         MClasses[SI], -1,
                       RISCV::GPRRegClassID, -1,           -1};
            Names = {RISCV::OpName::rd,      RISCV::OpName::s0,
                     RISCV::OpName::scalar,  RISCV::OpName::dtype,
                     RISCV::OpName::num_ops, RISCV::OpName::regs_per_square};
            Suffix = (Twine("_G0") + (D < 10 ? "0" : "") + Twine(D) + "_G1" +
                      (S < 10 ? "0" : "") + Twine(S))
                         .str();
          } else {
            Classes = {MClasses[DI], MClasses[DI], -1, RISCV::GPRRegClassID};
            Names = {RISCV::OpName::rd, RISCV::OpName::src,
                     RISCV::OpName::regs_per_unit, RISCV::OpName::dtype};
            Suffix = Twine(D).str();
          }
          EXPECT_EQ(MCII->getName(P->Pseudo),
                    (Twine(Expected.PseudoPrefix) + Suffix).str());
          EXPECT_EQ(DAGInfo.GenNodeInfo.getName(DAG->DAGOpcode),
                    (Twine(Expected.DAGPrefix) +
                     (Cross || Extract ? std::string() : Twine(D).str()))
                        .str());

          const MCInstrDesc &Desc = MCII->get(P->Pseudo);
          EXPECT_TRUE(Desc.isPseudo());
          EXPECT_FALSE(Desc.mayLoad());
          EXPECT_FALSE(Desc.mayStore());
          EXPECT_EQ(Desc.hasUnmodeledSideEffects(), !Extract);
          EXPECT_EQ(Desc.getNumDefs(), 1U);
          ASSERT_EQ(Desc.getNumOperands(), Classes.size());
          for (unsigned I = 0; I != Classes.size(); ++I) {
            EXPECT_EQ(Desc.operands()[I].RegClass, Classes[I]);
            EXPECT_EQ(RISCV::getNamedOperandIdx(P->Pseudo, Names[I]), int(I));
            EXPECT_EQ(Desc.getOperandConstraint(I, MCOI::TIED_TO), -1);
            EXPECT_EQ(Desc.getOperandConstraint(I, MCOI::EARLY_CLOBBER) >= 0,
                      I == 0 && !Cross);
          }
          checkTransferDAG(DAGInfo.GenNodeInfo, DAG->DAGOpcode,
                           Expected.Layout);
        }
      }
      EXPECT_EQ(Count, Expected.NumGroups);
      unsigned Mapped = 0;
      for (unsigned Opcode = 0; Opcode != RISCV::INSTRUCTION_LIST_END; ++Opcode)
        if (const auto *P = getPseudoInfo(Opcode))
          Mapped += P->Operation == Expected.Operation;
      EXPECT_EQ(Mapped, Expected.NumGroups);
      for (unsigned Invalid : {0U, 3U, 64U}) {
        EXPECT_EQ(getPseudoForGroups(Expected.Operation, Invalid, Sources[0]),
                  nullptr);
        if (Cross || Extract)
          EXPECT_EQ(getPseudoForGroups(Expected.Operation, 1, Invalid),
                    nullptr);
      }
      if (!Cross && !Extract)
        EXPECT_EQ(getPseudoForGroups(Expected.Operation, 2, 1), nullptr);
    }
  }
}

TEST(RISCVZttInstrInfo, GroupQueryKeys) {
  unsigned Mapped = 0;
  for (unsigned Opcode = 0; Opcode != RISCV::INSTRUCTION_LIST_END; ++Opcode) {
    const auto *P = getPseudoInfo(Opcode);
    if (!P)
      continue;
    ++Mapped;
    EXPECT_EQ(getPseudoForGroups(P->Operation, P->DstGroup, P->Src0Group,
                                 P->Src1Group),
              P);
    EXPECT_EQ(getPseudoForGroups(P->Operation, 64, P->Src0Group, P->Src1Group),
              nullptr);
    EXPECT_EQ(getPseudoForGroups(P->Operation, P->DstGroup, 64, P->Src1Group),
              nullptr);
    EXPECT_EQ(getPseudoForGroups(P->Operation, P->DstGroup, P->Src0Group, 64),
              nullptr);
  }
  EXPECT_NE(Mapped, 0U);
}

TEST(RISCVZttInstrInfo, ComputationGroups) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTargetMC();
  TestDAGInfo DAGInfo;
  const unsigned Classes[] = {
      RISCV::ZTTMRRegClassID,    RISCV::ZTTMRM2RegClassID,
      RISCV::ZTTMRM4RegClassID,  RISCV::ZTTMRM8RegClassID,
      RISCV::ZTTMRM16RegClassID, RISCV::ZTTMRM32RegClassID};
  for (StringRef TripleName : {"riscv32", "riscv64"}) {
    SCOPED_TRACE(TripleName.str());
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(Triple(TripleName), Error);
    ASSERT_NE(T, nullptr) << Error;
    std::unique_ptr<MCInstrInfo> MCII(T->createMCInstrInfo());
    unsigned Operations = 0;
    for (unsigned ID = 1; ID != Intrinsic::num_intrinsics; ++ID) {
      const auto *Hook = getIntrinsicLoweringInfo(ID);
      if (!Hook)
        continue;
      const auto *Op = getOperationInfo(Hook->Operation);
      ASSERT_NE(Op, nullptr);
      if (Op->Kind != CodeGenKind::Slice || Op->Layout != OperandLayout::Matrix)
        continue;
      ++Operations;
      EXPECT_EQ(Hook->Opcode, Op->HasChain ? ISD::INTRINSIC_W_CHAIN
                                           : ISD::INTRINSIC_WO_CHAIN);
      EXPECT_EQ(Op->HasSideEffects, Op->HasChain);
      EXPECT_FALSE(Op->IsAcc);
      unsigned Groups = 0;
      for (unsigned D = 0; D != 6; ++D)
        for (unsigned S0 = 0; S0 != (Op->NumSources ? 6U : 1U); ++S0)
          for (unsigned S1 = 0; S1 != (Op->NumSources > 1 ? 6U : 1U); ++S1) {
            unsigned G0 = Op->NumSources ? 1U << S0 : 0;
            unsigned G1 = Op->NumSources > 1 ? 1U << S1 : 0;
            const auto *P = getPseudoForGroups(Op->Operation, 1U << D, G0, G1);
            if (Op->SameGroups &&
                ((G0 && G0 != (1U << D)) || (G1 && G1 != (1U << D)))) {
              EXPECT_EQ(P, nullptr);
              continue;
            }
            ASSERT_NE(P, nullptr);
            ++Groups;
            SCOPED_TRACE(MCII->getName(P->Pseudo).str());
            EXPECT_EQ(getPseudoInfo(P->Pseudo), P);
            const auto *DAG = getDAGNodeInfo(P->Pseudo);
            ASSERT_NE(DAG, nullptr);
            EXPECT_EQ(DAG->DAGOpcode, Hook->DAGOpcode);
            EXPECT_EQ(getDAGOperationInfo(DAG->DAGOpcode), Op);
            const MCInstrDesc &Desc = MCII->get(P->Pseudo);
            EXPECT_TRUE(Desc.isPseudo());
            EXPECT_FALSE(Desc.mayLoad());
            EXPECT_FALSE(Desc.mayStore());
            EXPECT_EQ(Desc.hasUnmodeledSideEffects(), Op->HasSideEffects);
            EXPECT_EQ(Desc.getNumDefs(), 1U);
            unsigned NumOperands = 4 + Op->HasOld + Op->NumSources +
                                   Op->HasScalar + Op->HasScalarType;
            ASSERT_EQ(Desc.getNumOperands(), NumOperands);
            EXPECT_EQ(Desc.operands()[0].RegClass, int(Classes[D]));
            EXPECT_EQ(Desc.getOperandConstraint(0, MCOI::EARLY_CLOBBER) >= 0,
                      !Op->HasOld);
            unsigned I = 1;
            if (Op->HasOld) {
              EXPECT_EQ(Desc.operands()[I].RegClass, int(Classes[D]));
              EXPECT_EQ(Desc.getOperandConstraint(I++, MCOI::TIED_TO), 0);
            }
            if (G0)
              EXPECT_EQ(Desc.operands()[I++].RegClass, int(Classes[S0]));
            if (G1)
              EXPECT_EQ(Desc.operands()[I++].RegClass, int(Classes[S1]));
            if (Op->HasScalar)
              EXPECT_EQ(Desc.operands()[I++].RegClass, RISCV::GPRRegClassID);
            EXPECT_EQ(Desc.operands()[I++].RegClass,
                      Op->Pairwise ? -1 : RISCV::GPRRegClassID);
            if (Op->HasScalarType)
              EXPECT_EQ(Desc.operands()[I++].RegClass, RISCV::GPRRegClassID);
            EXPECT_EQ(Desc.operands()[I++].RegClass, -1);
            EXPECT_EQ(Desc.operands()[I++].RegClass, -1);
            EXPECT_EQ(I, NumOperands);
            const auto &Node = DAGInfo.GenNodeInfo.getDesc(DAG->DAGOpcode);
            EXPECT_EQ(Node.NumResults, 1U);
            EXPECT_EQ(Node.NumOperands, int(NumOperands - 1));
          }
      unsigned Mapped = 0;
      for (unsigned Opcode = 0; Opcode != RISCV::INSTRUCTION_LIST_END; ++Opcode)
        if (const auto *P = getPseudoInfo(Opcode))
          Mapped += P->Operation == Op->Operation;
      EXPECT_EQ(Mapped, Groups);
    }
    EXPECT_EQ(Operations, 101U);
  }
}

TEST(RISCVZttInstrInfo, ComputationOperandKinds) {
  const auto *Mixed = getPseudoForGroups(MSUB_EW, 4, 1, 8);
  ASSERT_NE(Mixed, nullptr);
  EXPECT_EQ(Mixed->Pseudo, RISCV::PseudoZTTMsubEw_G004_G101_G208);
  EXPECT_EQ(getPseudoForGroups(MAND_EW, 4, 1, 8), nullptr);
  const auto *Same = getPseudoForGroups(MAND_EW, 4, 4, 4);
  ASSERT_NE(Same, nullptr);
  EXPECT_EQ(Same->Pseudo, RISCV::PseudoZTTMandEw_G004_G104_G204);
  for (auto ID : {MADD_EW_X, MMULACC_EW_X}) {
    const auto *Op = getOperationInfo(ID);
    ASSERT_NE(Op, nullptr);
    EXPECT_TRUE(Op->HasScalar);
    EXPECT_TRUE(Op->HasScalarType);
    EXPECT_TRUE(Op->HasChain);
    EXPECT_EQ(Op->NumSources, 1U);
  }
  EXPECT_TRUE(getOperationInfo(MMULACC_EW_X)->HasOld);
  EXPECT_EQ(getOperationInfo(MMULACC_EW_X)->BaseOpcode,
            RISCV::ZTT_MMULACC_EW_X);
  EXPECT_FALSE(getOperationInfo(MADD_EW_X)->HasOld);
  const auto *Shift = getOperationInfo(MSLL_EW_X);
  ASSERT_NE(Shift, nullptr);
  EXPECT_TRUE(Shift->HasScalar);
  EXPECT_FALSE(Shift->HasScalarType);
  EXPECT_FALSE(Shift->HasChain);
  const auto *Broadcast = getOperationInfo(MBCAST_M_X);
  ASSERT_NE(Broadcast, nullptr);
  EXPECT_TRUE(Broadcast->HasScalarType);
  EXPECT_FALSE(Broadcast->HasChain);
  EXPECT_EQ(Broadcast->NumSources, 0U);
  for (auto ID : {MROWZIP_EW, MCOLZIP_EW, MROWUNZIP_EW, MCOLUNZIP_EW}) {
    const auto *Op = getOperationInfo(ID);
    ASSERT_NE(Op, nullptr);
    EXPECT_TRUE(Op->Pairwise);
    EXPECT_TRUE(Op->HasOld);
    EXPECT_EQ(Op->NumSources, 0U);
  }
  for (auto ID : {MROWID_EW, MCOLID_EW}) {
    const auto *Op = getOperationInfo(ID);
    ASSERT_NE(Op, nullptr);
    EXPECT_EQ(Op->NumSources, 0U);
    EXPECT_FALSE(Op->HasScalar);
    EXPECT_FALSE(Op->HasOld);
  }
}

TEST(RISCVZttInstrInfo, MatmulGroups) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTargetMC();
  const unsigned MClasses[] = {
      RISCV::ZTTMRRegClassID,    RISCV::ZTTMRM2RegClassID,
      RISCV::ZTTMRM4RegClassID,  RISCV::ZTTMRM8RegClassID,
      RISCV::ZTTMRM16RegClassID, RISCV::ZTTMRM32RegClassID};
  const unsigned AClasses[] = {RISCV::ZTTARRegClassID, RISCV::ZTTARM2RegClassID,
                               RISCV::ZTTARM4RegClassID,
                               RISCV::ZTTARM8RegClassID};
  for (StringRef TripleName : {"riscv32", "riscv64"}) {
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(Triple(TripleName), Error);
    ASSERT_NE(T, nullptr) << Error;
    std::unique_ptr<MCInstrInfo> MCII(T->createMCInstrInfo());
    for (unsigned ID :
         {Intrinsic::riscv_ztt_mmulacc_2d, Intrinsic::riscv_ztt_mmulaccneg_2d,
          Intrinsic::riscv_ztt_mmulatacc_2d,
          Intrinsic::riscv_ztt_mmulataccneg_2d,
          Intrinsic::riscv_ztt_mmulbtacc_2d,
          Intrinsic::riscv_ztt_mmulbtaccneg_2d}) {
      const auto *Hook = getIntrinsicLoweringInfo(ID);
      ASSERT_NE(Hook, nullptr);
      const auto *Op = getOperationInfo(Hook->Operation);
      ASSERT_NE(Op, nullptr);
      EXPECT_EQ(Op->Kind, CodeGenKind::Matmul);
      EXPECT_TRUE(Op->HasOld);
      EXPECT_TRUE(Op->HasSideEffects);
      EXPECT_TRUE(Op->IsAcc);
      EXPECT_FALSE(Op->HasChain);
      EXPECT_FALSE(Op->SameGroups);
      EXPECT_EQ(Op->NumSources, 2U);
      EXPECT_EQ(Hook->Opcode, ISD::INTRINSIC_WO_CHAIN);
      for (unsigned A = 0; A != 4; ++A)
        for (unsigned L = 0; L != 6; ++L)
          for (unsigned R = 0; R != 6; ++R) {
            const auto *P =
                getPseudoForGroups(Op->Operation, 1U << A, 1U << L, 1U << R);
            ASSERT_NE(P, nullptr);
            EXPECT_EQ(getPseudoInfo(P->Pseudo), P);
            EXPECT_EQ(getDAGNodeInfo(P->Pseudo)->DAGOpcode, Hook->DAGOpcode);
            EXPECT_EQ(getDAGOperationInfo(Hook->DAGOpcode), Op);
            const auto &Desc = MCII->get(P->Pseudo);
            EXPECT_EQ(Desc.getNumDefs(), 1U);
            ASSERT_EQ(Desc.getNumOperands(), 5U);
            EXPECT_TRUE(Desc.isPseudo());
            EXPECT_TRUE(Desc.hasUnmodeledSideEffects());
            EXPECT_FALSE(Desc.mayLoad());
            EXPECT_FALSE(Desc.mayStore());
            EXPECT_EQ(Desc.operands()[0].RegClass, int(AClasses[A]));
            EXPECT_EQ(Desc.operands()[1].RegClass, int(AClasses[A]));
            EXPECT_EQ(Desc.operands()[2].RegClass, int(MClasses[L]));
            EXPECT_EQ(Desc.operands()[3].RegClass, int(MClasses[R]));
            EXPECT_EQ(Desc.operands()[4].RegClass, -1);
            EXPECT_EQ(Desc.getOperandConstraint(1, MCOI::TIED_TO), 0);
            EXPECT_EQ(Desc.getOperandConstraint(0, MCOI::EARLY_CLOBBER), -1);
          }
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 16, 1, 1), nullptr);
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 1, 3, 1), nullptr);
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 1, 1, 64), nullptr);
    }
  }
  const auto *P = getPseudoForGroups(MMULACC_2D, 8, 16, 2);
  ASSERT_NE(P, nullptr);
  EXPECT_EQ(P->Pseudo, RISCV::PseudoZTTMMulAcc2D_A8_L16_R2);
}

// Check matrix, address and datatype operands for every memory register group.
static void checkMemoryGroups(ArrayRef<unsigned> IDs, bool Strided) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTargetMC();
  TestDAGInfo DAGInfo;
  const unsigned Classes[] = {
      RISCV::ZTTMRRegClassID,    RISCV::ZTTMRM2RegClassID,
      RISCV::ZTTMRM4RegClassID,  RISCV::ZTTMRM8RegClassID,
      RISCV::ZTTMRM16RegClassID, RISCV::ZTTMRM32RegClassID};
  for (StringRef TripleName : {"riscv32", "riscv64"}) {
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(Triple(TripleName), Error);
    ASSERT_NE(T, nullptr) << Error;
    std::unique_ptr<MCInstrInfo> MCII(T->createMCInstrInfo());
    for (unsigned ID : IDs) {
      const auto *Hook = getIntrinsicLoweringInfo(ID);
      ASSERT_NE(Hook, nullptr);
      const auto *Op = getOperationInfo(Hook->Operation);
      ASSERT_NE(Op, nullptr);
      EXPECT_EQ(Op->Kind, CodeGenKind::Memory);
      EXPECT_TRUE(Op->isMemory());
      EXPECT_TRUE(Op->HasScratch);
      EXPECT_TRUE(Op->HasSideEffects);
      EXPECT_TRUE(Op->HasChain);
      EXPECT_FALSE(Op->IsAcc);
      EXPECT_EQ(Op->Layout,
                Strided ? OperandLayout::StridedMemory : OperandLayout::Memory);
      EXPECT_EQ(Hook->Opcode,
                Op->IsLoad ? ISD::INTRINSIC_W_CHAIN : ISD::INTRINSIC_VOID);
      for (unsigned I = 0; I != 6; ++I) {
        const auto *P = getPseudoForGroups(Op->Operation, 1U << I);
        ASSERT_NE(P, nullptr);
        SCOPED_TRACE(MCII->getName(P->Pseudo).str());
        EXPECT_EQ(getPseudoInfo(P->Pseudo), P);
        const auto *DAG = getDAGNodeInfo(P->Pseudo);
        ASSERT_NE(DAG, nullptr);
        EXPECT_EQ(getDAGOperationInfo(DAG->DAGOpcode), Op);
        EXPECT_EQ(getDAGPseudoInfo(DAG->DAGOpcode)->Operation, Op->Operation);
        if (Strided || I == 0)
          EXPECT_EQ(DAG->DAGOpcode, Hook->DAGOpcode);
        const auto &Desc = MCII->get(P->Pseudo);
        EXPECT_TRUE(Desc.isPseudo());
        EXPECT_TRUE(Desc.hasUnmodeledSideEffects());
        EXPECT_EQ(Desc.mayLoad(), Op->IsLoad);
        EXPECT_EQ(Desc.mayStore(), !Op->IsLoad);
        unsigned Scratch = Op->IsLoad ? 1 : 0;
        unsigned Base = Strided ? Scratch + 1 : 2;
        unsigned Matrix = Op->IsLoad ? 0 : Strided ? 3 : 1;
        EXPECT_EQ(Desc.getNumDefs(), Op->IsLoad ? 2U : 1U);
        ASSERT_EQ(Desc.getNumOperands(), Strided ? 7U : Op->IsLoad ? 6U : 5U);
        EXPECT_EQ(Desc.operands()[Matrix].RegClass, int(Classes[I]));
        EXPECT_EQ(Desc.operands()[Scratch].RegClass, RISCV::GPRRegClassID);
        EXPECT_EQ(Desc.operands()[Base].RegClass, RISCV::GPRRegClassID);
        EXPECT_EQ(Desc.getOperandConstraint(Base, MCOI::TIED_TO), int(Scratch));
        EXPECT_EQ(Desc.getOperandConstraint(Scratch, MCOI::EARLY_CLOBBER) >= 0,
                  Strided);
        EXPECT_EQ(Desc.getOperandConstraint(Matrix, MCOI::EARLY_CLOBBER), -1);
        EXPECT_EQ(RISCV::getNamedOperandIdx(P->Pseudo, RISCV::OpName::base),
                  int(Base));
        EXPECT_EQ(RISCV::getNamedOperandIdx(P->Pseudo, RISCV::OpName::scratch),
                  int(Scratch));
        const auto &Node = DAGInfo.GenNodeInfo.getDesc(DAG->DAGOpcode);
        EXPECT_EQ(Node.NumResults, Op->IsLoad ? 2U : 1U);
        EXPECT_EQ(Node.NumOperands, Strided ? (Op->IsLoad ? 5 : 6) : 4);
        EXPECT_TRUE(Node.hasProperty(SDNPHasChain));
        EXPECT_TRUE(Node.hasProperty(SDNPMemOperand));
      }
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 0), nullptr);
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 3), nullptr);
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 64), nullptr);
      EXPECT_EQ(getPseudoForGroups(Op->Operation, 2, 1), nullptr);
    }
  }
}

TEST(RISCVZttInstrInfo, ContiguousMemoryGroups) {
  checkMemoryGroups({Intrinsic::riscv_ztt_mls_rm, Intrinsic::riscv_ztt_mls_cm,
                     Intrinsic::riscv_ztt_mss_rm, Intrinsic::riscv_ztt_mss_cm},
                    false);
  EXPECT_TRUE(getOperationInfo(MLS_RM)->IsLoad);
  EXPECT_TRUE(getOperationInfo(MLS_CM)->IsLoad);
  EXPECT_FALSE(getOperationInfo(MSS_RM)->IsLoad);
  EXPECT_FALSE(getOperationInfo(MSS_CM)->IsLoad);
  EXPECT_EQ(getOperationInfo(MLS_RM)->BaseOpcode, RISCV::ZTT_MLS_RM);
  EXPECT_EQ(getOperationInfo(MSS_CM)->BaseOpcode, RISCV::ZTT_MSS_CM);
}

TEST(RISCVZttInstrInfo, StridedMemoryGroups) {
  checkMemoryGroups({Intrinsic::riscv_ztt_mls_st, Intrinsic::riscv_ztt_mls_tst,
                     Intrinsic::riscv_ztt_mss_st, Intrinsic::riscv_ztt_mss_tst},
                    true);
  EXPECT_TRUE(getOperationInfo(MLS_ST)->IsLoad);
  EXPECT_TRUE(getOperationInfo(MLS_TST)->IsLoad);
  EXPECT_FALSE(getOperationInfo(MSS_ST)->IsLoad);
  EXPECT_FALSE(getOperationInfo(MSS_TST)->IsLoad);
  EXPECT_FALSE(getOperationInfo(MLS_ST)->Transposed);
  EXPECT_TRUE(getOperationInfo(MLS_TST)->Transposed);
  EXPECT_FALSE(getOperationInfo(MSS_ST)->Transposed);
  EXPECT_TRUE(getOperationInfo(MSS_TST)->Transposed);
  EXPECT_EQ(getOperationInfo(MLS_ST)->BaseOpcode, RISCV::ZTT_MLS_ST);
  EXPECT_EQ(getOperationInfo(MSS_TST)->BaseOpcode, RISCV::ZTT_MSS_TST);
}

TEST(RISCVZttInstrInfo, StateOperations) {
  const std::pair<unsigned, ZttOperationID> Operations[] = {
      {Intrinsic::riscv_ztt_ame_acquire, AME_ACQUIRE},
      {Intrinsic::riscv_ztt_ame_release, AME_RELEASE},
      {Intrinsic::riscv_ztt_get_ameown, GET_AMEOWN},
      {Intrinsic::riscv_ztt_get_amestype, GET_AMESTYPE},
      {Intrinsic::riscv_ztt_get_amenlen, GET_AMENLEN},
      {Intrinsic::riscv_ztt_get_ameudsz, GET_AMEUDSZ},
      {Intrinsic::riscv_ztt_get_amefflags, GET_AMEFFLAGS},
      {Intrinsic::riscv_ztt_get_amexsat, GET_AMEXSAT},
      {Intrinsic::riscv_ztt_get_amestatus, GET_AMESTATUS}};
  for (auto [Intrinsic, Operation] : Operations) {
    const auto *Info = getOperationInfo(Operation);
    ASSERT_NE(Info, nullptr);
    EXPECT_EQ(Info->Kind, CodeGenKind::State);
    EXPECT_TRUE(Info->HasChain);
    EXPECT_FALSE(Info->isMemory());
    EXPECT_FALSE(Info->HasScratch);
    EXPECT_FALSE(Info->HasScalar);
    EXPECT_EQ(getIntrinsicLoweringInfo(Intrinsic), nullptr);
    for (unsigned G : {1U, 2U, 4U, 8U, 16U, 32U})
      EXPECT_EQ(getPseudoForGroups(Operation, G), nullptr);
  }
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTargetMC();
  for (StringRef TripleName : {"riscv32", "riscv64"}) {
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(Triple(TripleName), Error);
    ASSERT_NE(T, nullptr) << Error;
    std::unique_ptr<MCInstrInfo> MCII(T->createMCInstrInfo());
    for (unsigned Opcode :
         {RISCV::PseudoZttReadAMEOWN, RISCV::PseudoZttReadAMESTYPE,
          RISCV::PseudoZttReadAMENLEN, RISCV::PseudoZttReadAMEUDSZ,
          RISCV::PseudoZttReadAMEFFLAGS, RISCV::PseudoZttReadAMEXSAT,
          RISCV::PseudoZttReadAMESTATUS}) {
      const auto &Desc = MCII->get(Opcode);
      EXPECT_TRUE(Desc.isPseudo());
      EXPECT_TRUE(Desc.hasUnmodeledSideEffects());
      EXPECT_FALSE(Desc.mayLoad());
      EXPECT_FALSE(Desc.mayStore());
      EXPECT_EQ(Desc.getNumDefs(), 1U);
      ASSERT_EQ(Desc.getNumOperands(), 1U);
      EXPECT_EQ(Desc.operands()[0].RegClass, RISCV::GPRRegClassID);
      EXPECT_EQ(getPseudoInfo(Opcode), nullptr);
      EXPECT_EQ(getDAGNodeInfo(Opcode), nullptr);
    }
  }
}

TEST(RISCVZttInstrInfo, MetadataPreservation) {
  for (unsigned Opcode :
       {RISCV::ZTT_MLS_1R, RISCV::ZTT_MLS_RM, RISCV::ZTT_MLS_TST,
        RISCV::ZTT_MMOV_M_M, RISCV::ZTT_MMOV_M_A, RISCV::ZTT_MZERO_2D_M,
        RISCV::ZTT_MADD_EW, RISCV::ZTT_MADD_EW_X})
    EXPECT_NE(getMDPreservingInfo(Opcode), nullptr);
  for (unsigned Opcode : {RISCV::ZTT_MSETTYP, RISCV::ZTT_ASETTYP,
                          RISCV::ZTT_MSS_1R, RISCV::ADD, RISCV::COPY})
    EXPECT_EQ(getMDPreservingInfo(Opcode), nullptr);
  for (unsigned ID = 1; ID != Intrinsic::num_intrinsics; ++ID) {
    const auto *Hook = getIntrinsicLoweringInfo(ID);
    if (!Hook)
      continue;
    const auto *Op = getOperationInfo(Hook->Operation);
    if (Op->Layout == OperandLayout::Matrix)
      EXPECT_EQ(getMDPreservingInfo(Op->BaseOpcode) != nullptr,
                Op->Kind != CodeGenKind::Matmul);
  }
}

} // namespace
