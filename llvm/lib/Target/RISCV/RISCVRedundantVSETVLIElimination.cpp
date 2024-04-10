//=- RISCVRedundantVSETVLIElimination.cpp - Remove useless vsetvl for RISC-V =//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//

#include "RISCV.h"
#include "RISCVInstrInfo.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/Debug.h"

using namespace llvm;

#define DEBUG_TYPE "riscv-th-vsetvli-elim"

STATISTIC(NumVSETVLIRemoved, "Number of vsetvli removed.");

namespace {
class RISCVRedundantVSETVLIElimination : public MachineFunctionPass {
  const MachineRegisterInfo *MRI;
  const TargetRegisterInfo *TRI;
  const TargetInstrInfo *TII;

public:
  static char ID;
  RISCVRedundantVSETVLIElimination() : MachineFunctionPass(ID) {
    initializeRISCVRedundantVSETVLIEliminationPass(
        *PassRegistry::getPassRegistry());
  }

  bool runOnMachineFunction(MachineFunction &MF) override;
  MachineFunctionProperties getRequiredProperties() const override {
    return MachineFunctionProperties().set(
        MachineFunctionProperties::Property::NoVRegs);
  }

  StringRef getPassName() const override {
    return "RISC-V Redundant VSETVLI Elimination";
  }

private:
  bool optimizeBlock(MachineBasicBlock &MBB);
};

} // end anonymous namespace

char RISCVRedundantVSETVLIElimination::ID = 0;

INITIALIZE_PASS(RISCVRedundantVSETVLIElimination, "riscv-th-vsetvli-elim",
                "RISC-V Redundant VSETVLI Elimination", false, false)

bool RISCVRedundantVSETVLIElimination::optimizeBlock(MachineBasicBlock &MBB) {
  // Delete the following backup-action-restore patterns where action is empty.
  // ; CHECK-NEXT:    csrr a1, vl
  // ; CHECK-NEXT:    csrr a2, vtype
  // ; CHECK-NEXT:    <a lot of th.vsetvl/vsetvli>
  // ; CHECK-NEXT:    th.vsetvl zero, a1, a2

  enum State {
    OTHER,
    BACKUP_VL,
    BACKUP_VTYPE,
    SEQUENCE,
  };

  State NowState = OTHER;
  MachineBasicBlock::iterator FoundBegin = MBB.end();
  Register SavedVL = RISCV::NoRegister;
  Register SavedVTYPE = RISCV::NoRegister;

  const auto VLEncoding = RISCVSysReg::lookupSysRegByName("VL")->Encoding;
  const auto VTYPEEncoding = RISCVSysReg::lookupSysRegByName("VTYPE")->Encoding;

  bool Changed = false;

  // Remove redundant VTYPE preserving blocks unless it has some side effects.
  for (MachineBasicBlock::iterator I = MBB.begin(), E = MBB.end(); I != E;) {
    MachineInstr *MI = &*I;
    ++I;

    // CSRRS saved_vl, VL, x0
    if (NowState == OTHER) {
      if (MI->getOpcode() == RISCV::CSRRS) {
        if (MI->getOperand(1).getImm() == VLEncoding) {
          NowState = BACKUP_VL;
          SavedVL = MI->getOperand(0).getReg();
          FoundBegin = MI;
          continue;
        }
        NowState = OTHER;
      }
    }

    // CSRRS saved_vtype, VTYPE, x0
    if (NowState == BACKUP_VL) {
      if (MI->getOpcode() == RISCV::CSRRS) {
        if (MI->getOperand(1).getImm() == VTYPEEncoding) {
          NowState = BACKUP_VTYPE;
          SavedVTYPE = MI->getOperand(0).getReg();
          continue;
        }
        NowState = OTHER;
      }
    }

    if (NowState == BACKUP_VTYPE) {
      if (MI->getOpcode() == RISCV::TH_VSETVL ||
          MI->getOpcode() == RISCV::TH_VSETVLI ||
          MI->getOpcode() == RISCV::PseudoTH_VSETVLI ||
          MI->getOpcode() == RISCV::PseudoTH_VSETVLIX0) {
        NowState = SEQUENCE;
        continue;
      }
      NowState = OTHER;
    }

    if (NowState == SEQUENCE) {
      if (MI->getOpcode() == RISCV::TH_VSETVLI ||
          MI->getOpcode() == RISCV::PseudoTH_VSETVLI ||
          MI->getOpcode() == RISCV::PseudoTH_VSETVLIX0) {
        continue;
      }

      if (MI->getOpcode() == RISCV::TH_VSETVL) {
        // Check if this is a restore point
        if (MI->getOperand(0).getReg() == RISCV::X0 &&
            MI->getOperand(1).getReg() == SavedVL &&
            MI->getOperand(2).getReg() == SavedVTYPE) {
          assert(FoundBegin != MBB.end() &&
                 "FoundBegin is not set but restore point is found");
          // Now erase the sequence from the FoundBegin to MI
          while (FoundBegin != MI) {
            MachineInstr *ToErase = &*FoundBegin;
            ++FoundBegin;
            ToErase->eraseFromParent();
            ++NumVSETVLIRemoved;
            Changed = true;
          }
          // Don't forget to erase the restoring vsetvl
          MI->eraseFromParent();
          ++NumVSETVLIRemoved;
          NowState = OTHER;
        }
        continue;
      }

      NowState = OTHER;
    }
  }

  return Changed;
}

bool RISCVRedundantVSETVLIElimination::runOnMachineFunction(
    MachineFunction &MF) {
  if (skipFunction(MF.getFunction()))
    return false;

  TII = MF.getSubtarget().getInstrInfo();
  TRI = MF.getSubtarget().getRegisterInfo();
  MRI = &MF.getRegInfo();

  bool Changed = false;
  for (MachineBasicBlock &MBB : MF)
    Changed |= optimizeBlock(MBB);

  return Changed;
}

FunctionPass *llvm::createRISCVRedundantVSETVLIEliminationPass() {
  return new RISCVRedundantVSETVLIElimination();
}
