//===-- RISCVZttProfileTest.cpp - Ztt subtarget tests --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RISCVSubtarget.h"
#include "RISCVTargetMachine.h"
#include "llvm/IR/Module.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetLoweringObjectFile.h"
#include "gtest/gtest.h"

using namespace llvm;

TEST(RISCVZttProfile, SubtargetConfiguration) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTarget();
  LLVMInitializeRISCVTargetMC();
  for (StringRef Arch : {"riscv32", "riscv64"}) {
    Triple TT(Arch);
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(TT, Error);
    ASSERT_NE(T, nullptr);
    for (StringRef Profile :
         {"clang-runtime-u32-m16-a4", "clang-n128-u32-m16-a4",
          "clang-runtime-u8-m32-a1", "clang-runtime-u16-m16-a2",
          "clang-runtime-u64-m32-a8", "clang-runtime-u128-m16-a16", ""}) {
      SCOPED_TRACE(Profile);
      std::unique_ptr<RISCVTargetMachine> TM(
          static_cast<RISCVTargetMachine *>(T->createTargetMachine(
              TT, "generic", Profile.empty() ? "" : "+ztt", TargetOptions(),
              std::nullopt)));
      LLVMContext C;
      Module M("ztt-profile", C);
      M.setDataLayout(TM->createDataLayout());
      auto *F = Function::Create(FunctionType::get(Type::getVoidTy(C), false),
                                 GlobalValue::ExternalLinkage, "f", M);
      if (!Profile.empty())
        F->addFnAttr("riscv-ztt-profile", Profile);
      const RISCVSubtarget *ST = TM->getSubtargetImpl(*F);
      if (Profile.empty()) {
        EXPECT_FALSE(ST->getZttProfile());
        continue;
      }
      auto Expected = RISCV::ZttProfile::parse(Profile);
      ASSERT_TRUE(bool(Expected));
      ASSERT_TRUE(ST->getZttProfile());
      EXPECT_EQ(ST->getZttProfile()->N, Expected->N);
      EXPECT_EQ(ST->getZttUdsBits(), Expected->UdsBits);
      EXPECT_EQ(ST->getZttMRegs(), Expected->MRegs);
      EXPECT_EQ(ST->getZttARegs(), Expected->ARegs);
    }
  }
}
