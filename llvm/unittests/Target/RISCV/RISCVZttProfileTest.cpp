//===-- RISCVZttProfileTest.cpp - Ztt subtarget tests --------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RISCVSubtarget.h"
#include "RISCVTargetMachine.h"
#include "llvm/ADT/SmallVector.h"
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

TEST(RISCVZttProfile, SubtargetCacheIsolation) {
  LLVMInitializeRISCVTargetInfo();
  LLVMInitializeRISCVTarget();
  LLVMInitializeRISCVTargetMC();
  for (StringRef Arch : {"riscv32", "riscv64"}) {
    SCOPED_TRACE(Arch);
    Triple TT(Arch);
    std::string Error;
    const Target *T = TargetRegistry::lookupTarget(TT, Error);
    ASSERT_NE(T, nullptr);
    std::unique_ptr<RISCVTargetMachine> TM(
        static_cast<RISCVTargetMachine *>(T->createTargetMachine(
            TT, "generic", "+ztt", TargetOptions(), std::nullopt)));
    LLVMContext C;
    Module M("ztt-profile-cache", C);
    M.setDataLayout(TM->createDataLayout());
    auto CreateFunction = [&](StringRef Profile) {
      auto *F = Function::Create(FunctionType::get(Type::getVoidTy(C), false),
                                 GlobalValue::ExternalLinkage, "f", M);
      F->addFnAttr("riscv-ztt-profile", Profile);
      return F;
    };

    // Vary each profile field independently while keeping CPU and ISA fixed.
    const struct {
      StringRef Name;
      unsigned N, UdsBits, MRegs, ARegs;
    } Profiles[] = {
        {"clang-runtime-u32-m16-a4", 0, 32, 16, 4},
        {"clang-runtime-u8-m16-a4", 0, 8, 16, 4},
        {"clang-runtime-u32-m32-a4", 0, 32, 32, 4},
        {"clang-runtime-u32-m16-a1", 0, 32, 16, 1},
        {"clang-n128-u32-m16-a4", 128, 32, 16, 4},
        {"clang-n256-u32-m16-a4", 256, 32, 16, 4},
    };
    SmallVector<const RISCVSubtarget *> Subtargets;
    for (const auto &Profile : Profiles) {
      SCOPED_TRACE(Profile.Name);
      const auto *ST = TM->getSubtargetImpl(*CreateFunction(Profile.Name));
      ASSERT_TRUE(ST->getZttProfile());
      EXPECT_EQ(ST->getZttProfile()->N, Profile.N);
      EXPECT_EQ(ST->getZttUdsBits(), Profile.UdsBits);
      EXPECT_EQ(ST->getZttMRegs(), Profile.MRegs);
      EXPECT_EQ(ST->getZttARegs(), Profile.ARegs);
      for (const auto *Previous : Subtargets)
        EXPECT_NE(ST, Previous);
      Subtargets.push_back(ST);
    }

    // Interleaved functions with the same profile still reuse the cached entry.
    for (unsigned I = 0; I != std::size(Profiles); ++I)
      EXPECT_EQ(TM->getSubtargetImpl(*CreateFunction(Profiles[I].Name)),
                Subtargets[I]);
  }
}
