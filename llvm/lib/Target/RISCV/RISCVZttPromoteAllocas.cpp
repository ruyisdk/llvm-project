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
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Instructions.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Transforms/Utils/PromoteMemToReg.h"

using namespace llvm;

namespace {
// Promote only nonescaping RISC-V Ztt matrix allocas.
static bool promoteZttAllocas(Function &F) {
  if (F.isDeclaration())
    return false;
  SmallVector<AllocaInst *> Allocas;
  for (Instruction &I : F.getEntryBlock()) {
    auto *AI = dyn_cast<AllocaInst>(&I);
    if (!AI)
      continue;
    auto *Ty = dyn_cast<TargetExtType>(AI->getAllocatedType());
    if (Ty &&
        (Ty->getName().starts_with("riscv.ztt.m.") ||
         Ty->getName().starts_with("riscv.ztt.acc.")) &&
        isAllocaPromotable(AI))
      Allocas.push_back(AI);
  }
  if (Allocas.empty())
    return false;
  DominatorTree DT(F);
  PromoteMemToReg(Allocas, DT);
  return true;
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
