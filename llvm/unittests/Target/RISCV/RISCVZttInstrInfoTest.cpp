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

} // namespace
