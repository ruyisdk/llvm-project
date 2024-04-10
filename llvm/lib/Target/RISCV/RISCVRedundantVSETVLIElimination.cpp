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
  return false;
}

bool RISCVRedundantVSETVLIElimination::runOnMachineFunction(MachineFunction &MF) {
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
