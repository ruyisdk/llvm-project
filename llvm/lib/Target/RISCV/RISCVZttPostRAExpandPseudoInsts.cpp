//===-- RISCVZttPostRAExpandPseudoInsts.cpp - Expand Ztt pseudos ------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/RISCVBaseInfo.h"
#include "RISCV.h"
#include "RISCVInstrInfo.h"
#include "RISCVMachineFunctionInfo.h"
#include "RISCVSubtarget.h"
#include "RISCVZttRegisterLayout.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/RegisterClassInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include <optional>

using namespace llvm;

namespace {

static constexpr unsigned ZttMSubRegs[] = {
    RISCV::sub_zttm_0,  RISCV::sub_zttm_1,  RISCV::sub_zttm_2,
    RISCV::sub_zttm_3,  RISCV::sub_zttm_4,  RISCV::sub_zttm_5,
    RISCV::sub_zttm_6,  RISCV::sub_zttm_7,  RISCV::sub_zttm_8,
    RISCV::sub_zttm_9,  RISCV::sub_zttm_10, RISCV::sub_zttm_11,
    RISCV::sub_zttm_12, RISCV::sub_zttm_13, RISCV::sub_zttm_14,
    RISCV::sub_zttm_15, RISCV::sub_zttm_16, RISCV::sub_zttm_17,
    RISCV::sub_zttm_18, RISCV::sub_zttm_19, RISCV::sub_zttm_20,
    RISCV::sub_zttm_21, RISCV::sub_zttm_22, RISCV::sub_zttm_23,
    RISCV::sub_zttm_24, RISCV::sub_zttm_25, RISCV::sub_zttm_26,
    RISCV::sub_zttm_27, RISCV::sub_zttm_28, RISCV::sub_zttm_29,
    RISCV::sub_zttm_30, RISCV::sub_zttm_31};
static constexpr unsigned ZttASubRegs[] = {
    RISCV::sub_ztta_0, RISCV::sub_ztta_1, RISCV::sub_ztta_2, RISCV::sub_ztta_3,
    RISCV::sub_ztta_4, RISCV::sub_ztta_5, RISCV::sub_ztta_6, RISCV::sub_ztta_7};

class RISCVZttPostRAExpandPseudo : public MachineFunctionPass {
public:
  static char ID;
  RISCVZttPostRAExpandPseudo() : MachineFunctionPass(ID) {
    initializeRISCVZttPostRAExpandPseudoPass(*PassRegistry::getPassRegistry());
  }

  bool runOnMachineFunction(MachineFunction &MF) override;
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addPreserved<MachineRegisterClassInfoWrapperPass>();
    MachineFunctionPass::getAnalysisUsage(AU);
  }
  StringRef getPassName() const override {
    return "RISC-V Ztt post-regalloc pseudo instruction expansion pass";
  }

private:
  const RISCVInstrInfo *TII;
  const TargetRegisterInfo *TRI;

  // Resolve a physical register within an M or ACC group.
  Register getMReg(Register Group, unsigned GroupSize, unsigned Index) const;
  Register getAReg(Register Group, unsigned GroupSize, unsigned Index) const;
  // Remove identity copies and reject other overlapping groups.
  bool needsMCopy(Register DstGroup, Register SrcGroup) const;
  // Set a square's metadata, including implicit definitions of wide tails.
  void emitMSetTyp(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                   Register Group, unsigned GroupSize, unsigned Base,
                   unsigned RegsPerSquare, Register DType);
  // Copy one square. Read source metadata unless DType supplies it.
  void emitMCopySquare(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                       Register Scratch, Register DstGroup,
                       unsigned DstGroupSize, unsigned DstBase,
                       Register SrcGroup, unsigned SrcGroupSize,
                       unsigned SrcBase, unsigned RegsPerSquare,
                       Register DType = Register());
  // Expand internal COPYs using layouts exposed by datatype-setting operations.
  bool expandMCopies(MachineFunction &MF);
  bool expandMI(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI);
  bool expandZero(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                  unsigned GroupSize, bool IsAcc);
  bool expandMSetTyp(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                     unsigned GroupSize);
  bool expandAClear(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                    unsigned GroupSize);
};

char RISCVZttPostRAExpandPseudo::ID = 0;

bool RISCVZttPostRAExpandPseudo::expandMCopies(MachineFunction &MF) {
  auto BaseIndex = [&](Register R) {
    unsigned Group = getZttMGroupSize(R);
    assert(Group && "expected M register");
    return unsigned(getMReg(R, Group, 0) - RISCV::ZTTM0);
  };
  auto IsMCopy = [](const MachineInstr &MI) {
    return MI.isCopy() && getZttMGroupSize(MI.getOperand(0).getReg());
  };
  if (!llvm::any_of(MF, [&](const MachineBasicBlock &MBB) {
        return llvm::any_of(MBB, IsMCopy);
      }))
    return false;

  const auto In = analyzeZttMLayouts(MF);

  DenseMap<const MachineInstr *, unsigned> CopyWidths;
  for (MachineBasicBlock &MBB : MF) {
    ZttMLayout State;
    State.fill(-1);
    if (auto It = In.find(&MBB); It != In.end())
      State = It->second;
    for (MachineInstr &MI : MBB) {
      if (IsMCopy(MI)) {
        Register Dst = MI.getOperand(0).getReg();
        Register Src = MI.getOperand(1).getReg();
        unsigned Group = getZttMGroupSize(Dst);
        if (needsMCopy(Dst, Src)) {
          if (getZttMGroupSize(Src) != Group)
            report_fatal_error("Ztt M COPY requires equal M register groups");
          unsigned S = BaseIndex(Src);
          int Width = State[S];
          if (Width <= 0 || !isPowerOf2_32(Width) || unsigned(Width) > Group ||
              Group % Width)
            report_fatal_error("Ztt M COPY source square layout is unknown");
          for (unsigned I = 0; I != Group; ++I)
            if (State[S + I] != (I % Width ? 0 : Width))
              report_fatal_error(
                  "Ztt M COPY source square layout is inconsistent");
          CopyWidths[&MI] = Width;
        }
      }
      transferZttMLayout(MI, State, *TRI);
    }
  }

  // Liveness at COPY, rather than at its producer, determines the scratch.
  // Walk backwards so intervening uses and successor live-ins are respected.
  const MachineRegisterInfo &MRI = MF.getRegInfo();
  // This pass runs before PEI. A single ordinary XLEN spill slot can be reused
  // by all COPYs: each save/restore pair encloses only its own expansion.
  std::optional<int> ScratchFI;
  for (MachineBasicBlock &MBB : MF) {
    LivePhysRegs Live(*TRI);
    Live.addLiveOuts(MBB);
    SmallVector<MachineInstr *> OriginalInstructions;
    for (MachineInstr &MI : MBB)
      OriginalInstructions.push_back(&MI);
    for (MachineInstr *Original : llvm::reverse(OriginalInstructions)) {
      MachineInstr &MI = *Original;
      auto It = MI.getIterator();
      Live.stepBackward(MI);
      if (!IsMCopy(MI))
        continue;
      Register Dst = MI.getOperand(0).getReg();
      Register Src = MI.getOperand(1).getReg();
      if (Dst != Src) {
        Register Scratch;
        bool RestoreScratch = false;
        for (MCPhysReg R :
             TRI->getRawAllocationOrder(RISCV::GPRNoX0RegClass, MF))
          if (Live.available(MRI, R)) {
            Scratch = R;
            break;
          }
        if (!Scratch) {
          // Never borrow reserved registers (in particular SP/FP). Preserve a
          // live allocatable GPR using the target's normal scalar spill path.
          for (MCPhysReg R :
               TRI->getRawAllocationOrder(RISCV::GPRNoX0RegClass, MF))
            if (!MRI.isReserved(R)) {
              Scratch = R;
              break;
            }
          if (!Scratch)
            report_fatal_error("Ztt M COPY has no allocatable scratch GPR");
          if (!ScratchFI)
            ScratchFI = MF.getFrameInfo().CreateSpillStackObject(
                TRI->getSpillSize(RISCV::GPRRegClass),
                TRI->getSpillAlign(RISCV::GPRRegClass));
          TII->storeRegToStackSlot(MBB, It, Scratch, false, *ScratchFI,
                                   &RISCV::GPRRegClass, Register());
          RestoreScratch = true;
        }
        unsigned Group = getZttMGroupSize(Dst);
        unsigned Width = CopyWidths.lookup(&MI);
        for (unsigned Base = 0; Base != Group; Base += Width)
          emitMCopySquare(MBB, It, Scratch, Dst, Group, Base, Src, Group, Base,
                          Width);
        if (RestoreScratch)
          TII->loadRegFromStackSlot(MBB, It, Scratch, *ScratchFI,
                                    &RISCV::GPRRegClass, Register());
      }
      // The new sequence has the same matrix boundary liveness as COPY; its
      // scratch is either dead or restored. Do not revisit inserted moves.
      MBB.erase(It);
    }
  }
  return true;
}

bool RISCVZttPostRAExpandPseudo::runOnMachineFunction(MachineFunction &MF) {
  const auto &ST = MF.getSubtarget<RISCVSubtarget>();
  if (!ST.hasStdExtZtt())
    return false;

  TII = static_cast<const RISCVInstrInfo *>(MF.getSubtarget().getInstrInfo());
  TRI = MF.getSubtarget().getRegisterInfo();
  bool Modified = false;
  for (MachineBasicBlock &MBB : MF) {
    auto MBBI = MBB.begin();
    while (MBBI != MBB.end()) {
      auto NextMBBI = std::next(MBBI);
      Modified |= expandMI(MBB, MBBI);
      MBBI = NextMBBI;
    }
  }
  Modified |= expandMCopies(MF);
  return Modified;
}

Register RISCVZttPostRAExpandPseudo::getMReg(Register Group, unsigned GroupSize,
                                             unsigned Index) const {
  assert(Index < GroupSize && "Ztt M subregister index out of range");
  return GroupSize == 1 ? Group
                        : Register(TRI->getSubReg(Group, ZttMSubRegs[Index]));
}

Register RISCVZttPostRAExpandPseudo::getAReg(Register Group, unsigned GroupSize,
                                             unsigned Index) const {
  assert(Index < GroupSize && "Ztt Acc subregister index out of range");
  return GroupSize == 1 ? Group
                        : Register(TRI->getSubReg(Group, ZttASubRegs[Index]));
}

void RISCVZttPostRAExpandPseudo::emitMSetTyp(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI, Register Group,
    unsigned GroupSize, unsigned Base, unsigned RegsPerSquare, Register DType) {
  assert(RegsPerSquare && Base + RegsPerSquare <= GroupSize &&
         "invalid Ztt M square register range");
  MachineInstrBuilder MIB =
      BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_MSETTYP),
              getMReg(Group, GroupSize, Base))
          .addReg(DType);
  for (unsigned I = 1; I != RegsPerSquare; ++I)
    MIB.addReg(getMReg(Group, GroupSize, Base + I), RegState::ImplicitDefine);
}

bool RISCVZttPostRAExpandPseudo::needsMCopy(Register DstGroup,
                                            Register SrcGroup) const {
  if (DstGroup == SrcGroup)
    return false;
  if (TRI->regsOverlap(DstGroup, SrcGroup))
    report_fatal_error(
        "Ztt copy destination register group overlaps its source");
  return true;
}

void RISCVZttPostRAExpandPseudo::emitMCopySquare(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI, Register Scratch,
    Register DstGroup, unsigned DstGroupSize, unsigned DstBase,
    Register SrcGroup, unsigned SrcGroupSize, unsigned SrcBase,
    unsigned RegsPerSquare, Register DType) {
  assert(DstBase + RegsPerSquare <= DstGroupSize &&
         SrcBase + RegsPerSquare <= SrcGroupSize &&
         "invalid Ztt M copy square range");
  // Also protect direct square-copy callers. Group-copy callers check the
  // entire groups first, so an earlier square cannot clobber a later source.
  if (getMReg(DstGroup, DstGroupSize, DstBase) ==
      getMReg(SrcGroup, SrcGroupSize, SrcBase))
    return;
  for (unsigned D = 0; D != RegsPerSquare; ++D)
    for (unsigned S = 0; S != RegsPerSquare; ++S)
      if (TRI->regsOverlap(getMReg(DstGroup, DstGroupSize, DstBase + D),
                           getMReg(SrcGroup, SrcGroupSize, SrcBase + S)))
        report_fatal_error(
            "Ztt copy destination register group overlaps its source");
  // Metadata and moves address the base of a physical square, including wide
  // squares spanning several M registers.
  // Only compiler-generated copies need to recover metadata from the source.
  if (!DType) {
    BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_MGETTYP),
            Scratch)
        .addReg(getMReg(SrcGroup, SrcGroupSize, SrcBase));
    DType = Scratch;
  }
  emitMSetTyp(MBB, MBBI, DstGroup, DstGroupSize, DstBase, RegsPerSquare, DType);
  auto Move =
      BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_MMOV_M_M),
              getMReg(DstGroup, DstGroupSize, DstBase))
          .addReg(getMReg(SrcGroup, SrcGroupSize, SrcBase));
  for (unsigned I = 1; I != RegsPerSquare; ++I) {
    Move.addReg(getMReg(DstGroup, DstGroupSize, DstBase + I),
                RegState::ImplicitDefine);
    Move.addReg(getMReg(SrcGroup, SrcGroupSize, SrcBase + I),
                RegState::Implicit);
  }
}

bool RISCVZttPostRAExpandPseudo::expandMI(MachineBasicBlock &MBB,
                                          MachineBasicBlock::iterator MBBI) {
  if (const auto *P = RISCVZttInstrInfo::getPseudoInfo(MBBI->getOpcode())) {
    const auto *Info = RISCVZttInstrInfo::getOperationInfo(P->Operation);
    assert(Info && "missing Ztt operation metadata");
    using RISCVZttInstrInfo::OperandLayout;
    switch (Info->Kind) {
    case RISCVZttInstrInfo::CodeGenKind::Slice:
      if (Info->Layout == OperandLayout::Clear)
        return Info->IsAcc ? expandAClear(MBB, MBBI, P->DstGroup)
                           : expandMSetTyp(MBB, MBBI, P->DstGroup);
      if (Info->Layout == OperandLayout::Zero)
        return expandZero(MBB, MBBI, P->DstGroup, Info->IsAcc);
      break;
    default:
      break;
    }
  }
  return false;
}

bool RISCVZttPostRAExpandPseudo::expandZero(MachineBasicBlock &MBB,
                                            MachineBasicBlock::iterator MI,
                                            unsigned GroupSize, bool IsAcc) {
  Register Group = MI->getOperand(0).getReg();
  Register DType = MI->getOperand(1).getReg();
  unsigned Step = IsAcc ? 1 : MI->getOperand(2).getImm();
  assert(Step && GroupSize % Step == 0 && "invalid Ztt zero layout");
  for (unsigned I = 0; I != GroupSize; I += Step) {
    if (IsAcc)
      BuildMI(MBB, MI, MI->getDebugLoc(), TII->get(RISCV::ZTT_ASETTYP),
              getAReg(Group, GroupSize, I))
          .addReg(DType);
    else
      emitMSetTyp(MBB, MI, Group, GroupSize, I, Step, DType);
  }
  for (unsigned I = 0; I != GroupSize; I += Step) {
    Register Base =
        IsAcc ? getAReg(Group, GroupSize, I) : getMReg(Group, GroupSize, I);
    auto Zero = BuildMI(
        MBB, MI, MI->getDebugLoc(),
        TII->get(IsAcc ? RISCV::ZTT_MZERO_2D_ACC : RISCV::ZTT_MZERO_2D_M),
        Base);
    // The operation consumes the newly installed Md/Ad and defines payload.
    Zero.addReg(Base, RegState::Implicit);
    for (unsigned J = 1; J != Step; ++J) {
      Register Tail = getMReg(Group, GroupSize, I + J);
      Zero.addReg(Tail, RegState::Implicit);
      Zero.addReg(Tail, RegState::ImplicitDefine);
    }
  }
  MI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandMSetTyp(MachineBasicBlock &MBB,
                                               MachineBasicBlock::iterator MBBI,
                                               unsigned GroupSize) {
  Register GroupReg = MBBI->getOperand(0).getReg();
  unsigned RegsPerUnit = MBBI->getOperand(2).getImm();
  assert(RegsPerUnit && GroupSize % RegsPerUnit == 0 &&
         "invalid Ztt registers-per-unit");
  for (unsigned Base = 0; Base != GroupSize; Base += RegsPerUnit)
    emitMSetTyp(MBB, MBBI, GroupReg, GroupSize, Base, RegsPerUnit,
                MBBI->getOperand(1).getReg());
  MBBI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandAClear(MachineBasicBlock &MBB,
                                              MachineBasicBlock::iterator MBBI,
                                              unsigned GroupSize) {
  Register GroupReg = MBBI->getOperand(0).getReg();
  for (unsigned I = 0; I != GroupSize; ++I) {
    BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_ASETTYP),
            getAReg(GroupReg, GroupSize, I))
        .addReg(MBBI->getOperand(1).getReg());
  }
  MBBI->eraseFromParent();
  return true;
}

} // end of anonymous namespace

INITIALIZE_PASS(RISCVZttPostRAExpandPseudo, "riscv-ztt-post-ra-expand-pseudo",
                "RISC-V Ztt post-regalloc pseudo instruction expansion pass",
                false, false)

namespace llvm {
FunctionPass *createRISCVZttPostRAExpandPseudoPass() {
  return new RISCVZttPostRAExpandPseudo();
}
} // end of namespace llvm
