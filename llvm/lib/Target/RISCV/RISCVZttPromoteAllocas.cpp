//===-- RISCVZttPromoteAllocas.cpp - Matrix locals -------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// Promote matrix locals before instruction selection, including at -O0.
// Ztt memory accesses and register spills use dedicated instructions.
//===----------------------------------------------------------------------===//

#include "RISCV.h"
#include "RISCVTargetMachine.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Instructions.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Transforms/Utils/PromoteMemToReg.h"

using namespace llvm;

namespace {
// Include local pointer slots holding matrix addresses, but not unrelated locals.
static SmallVector<AllocaInst *> getPromotableZttAllocas(Function &F) {
  SmallSetVector<AllocaInst *, 8> Candidates;
  for (Instruction &I : F.getEntryBlock()) {
    auto *AI = dyn_cast<AllocaInst>(&I);
    if (!AI)
      continue;
    auto *Ty = dyn_cast<TargetExtType>(AI->getAllocatedType());
    if (Ty &&
        (Ty->getName().starts_with("riscv.ztt.m.") ||
         Ty->getName().starts_with("riscv.ztt.acc.")))
      Candidates.insert(AI);
  }
  for (unsigned I = 0; I != Candidates.size(); ++I) {
    AllocaInst *AI = Candidates[I];
    for (User *U : AI->users()) {
      auto *SI = dyn_cast<StoreInst>(U);
      if (!SI || SI->getValueOperand() != AI)
        continue;
      auto *Alias = dyn_cast<AllocaInst>(SI->getPointerOperand());
      if (Alias && Alias->getParent() == &F.getEntryBlock() &&
          Alias->getAllocatedType()->isPointerTy())
        Candidates.insert(Alias);
    }
  }
  SmallVector<AllocaInst *> Allocas;
  for (AllocaInst *AI : Candidates)
    if (isAllocaPromotable(AI))
      Allocas.push_back(AI);
  return Allocas;
}

static bool promoteZttAllocas(Function &F) {
  if (F.isDeclaration())
    return false;
  DominatorTree DT;
  bool Changed = false;
  while (true) {
    SmallVector<AllocaInst *> Allocas = getPromotableZttAllocas(F);
    if (Allocas.empty())
      return Changed;
    if (!Changed)
      DT.recalculate(F);
    // Removing pointer slots exposes matrix accesses and further local aliases.
    PromoteMemToReg(Allocas, DT);
    Changed = true;
  }
}

class RISCVZttPromoteAllocasLegacy : public FunctionPass {
public:
  static char ID;
  RISCVZttPromoteAllocasLegacy() : FunctionPass(ID) {}
  bool runOnFunction(Function &F) override {
    // Do not call skipFunction: this legalization is required at optnone too.
    const auto &TM =
        getAnalysis<TargetPassConfig>().getTM<RISCVTargetMachine>();
    if (!TM.getSubtarget<RISCVSubtarget>(F).hasStdExtZtt())
      return false;
    return promoteZttAllocas(F);
  }
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesCFG();
    AU.addRequired<TargetPassConfig>();
  }
};
} // namespace

char RISCVZttPromoteAllocasLegacy::ID = 0;
INITIALIZE_PASS_BEGIN(RISCVZttPromoteAllocasLegacy, "riscv-ztt-promote-allocas",
                      "RISC-V Ztt promote matrix locals", false, false)
INITIALIZE_PASS_DEPENDENCY(TargetPassConfig)
INITIALIZE_PASS_END(RISCVZttPromoteAllocasLegacy, "riscv-ztt-promote-allocas",
                    "RISC-V Ztt promote matrix locals", false, false)

FunctionPass *llvm::createRISCVZttPromoteAllocasLegacyPass() {
  return new RISCVZttPromoteAllocasLegacy();
}

PreservedAnalyses RISCVZttPromoteAllocasPass::run(Function &F,
                                                  FunctionAnalysisManager &) {
  if (!TM->getSubtarget<RISCVSubtarget>(F).hasStdExtZtt() ||
      !promoteZttAllocas(F))
    return PreservedAnalyses::all();
  return PreservedAnalyses::allInSet<CFGAnalyses>();
}
