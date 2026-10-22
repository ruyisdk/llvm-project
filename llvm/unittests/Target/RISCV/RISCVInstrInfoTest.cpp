//===- RISCVInstrInfoTest.cpp - RISCVInstrInfo unit tests -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/RISCVInstPrinter.h"
#include "RISCVInstrInfo.h"
#include "RISCVSubtarget.h"
#include "RISCVTargetMachine.h"
#include "RISCVMachineFunctionInfo.h"
#include "RISCVZttRegisterLayout.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/IR/DebugInfoMetadata.h"
#include "llvm/IR/Module.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetLoweringObjectFile.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Target/TargetOptions.h"

#include "gtest/gtest.h"

#include <memory>
#include <string>

using namespace llvm;

namespace {

class RISCVInstrInfoTest : public testing::TestWithParam<const char *> {
protected:
  std::unique_ptr<RISCVTargetMachine> TM;
  std::unique_ptr<LLVMContext> Ctx;
  std::unique_ptr<RISCVSubtarget> ST;
  std::unique_ptr<MachineModuleInfo> MMI;
  std::unique_ptr<MachineFunction> MF;
  std::unique_ptr<Module> M;

  static void SetUpTestSuite() {
    LLVMInitializeRISCVTargetInfo();
    LLVMInitializeRISCVTarget();
    LLVMInitializeRISCVTargetMC();
  }

  RISCVInstrInfoTest(StringRef Features = "") {
    std::string Error;
    Triple TT(GetParam());
    const Target *TheTarget = TargetRegistry::lookupTarget(TT, Error);
    TargetOptions Options;

    TM.reset(static_cast<RISCVTargetMachine *>(TheTarget->createTargetMachine(
        TT, "generic", Features, Options, std::nullopt, std::nullopt,
        CodeGenOptLevel::Default)));

    Ctx = std::make_unique<LLVMContext>();
    M = std::make_unique<Module>("Module", *Ctx);
    M->setDataLayout(TT.computeDataLayout());
    auto *FType = FunctionType::get(Type::getVoidTy(*Ctx), false);
    auto *F = Function::Create(FType, GlobalValue::ExternalLinkage, "Test", *M);
    MMI = std::make_unique<MachineModuleInfo>(TM.get());

    ST = std::make_unique<RISCVSubtarget>(
        TM->getTargetTriple(), TM->getTargetCPU(), TM->getTargetCPU(),
        TM->getTargetFeatureString(),
        TM->getTargetTriple().isArch64Bit() ? "lp64" : "ilp32", 0, 0, *TM);

    MF = std::make_unique<MachineFunction>(*F, *TM, *ST, MMI->getContext(), 42);
  }
};

class RISCVXQCIInstrInfoTest : public RISCVInstrInfoTest {
protected:
  RISCVXQCIInstrInfoTest() : RISCVInstrInfoTest("+xqci") {}
};

TEST_P(RISCVInstrInfoTest, IsAddImmediate) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  DebugLoc DL;

  MachineInstr *MI1 = BuildMI(*MF, DL, TII->get(RISCV::ADDI), RISCV::X1)
                          .addReg(RISCV::X2)
                          .addImm(-128)
                          .getInstr();
  auto MI1Res = TII->isAddImmediate(*MI1, RISCV::X1);
  ASSERT_TRUE(MI1Res.has_value());
  EXPECT_EQ(MI1Res->Reg, RISCV::X2);
  EXPECT_EQ(MI1Res->Imm, -128);
  EXPECT_FALSE(TII->isAddImmediate(*MI1, RISCV::X2).has_value());

  MachineInstr *MI2 =
      BuildMI(*MF, DL, TII->get(RISCV::LUI), RISCV::X1).addImm(-128).getInstr();
  EXPECT_FALSE(TII->isAddImmediate(*MI2, RISCV::X1));

  // Check ADDIW isn't treated as isAddImmediate.
  if (ST->is64Bit()) {
    MachineInstr *MI3 = BuildMI(*MF, DL, TII->get(RISCV::ADDIW), RISCV::X1)
                            .addReg(RISCV::X2)
                            .addImm(-128)
                            .getInstr();
    EXPECT_FALSE(TII->isAddImmediate(*MI3, RISCV::X1));
  }
}

TEST_P(RISCVInstrInfoTest, IsCopyInstrImpl) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  DebugLoc DL;

  // ADDI.

  MachineInstr *MI1 = BuildMI(*MF, DL, TII->get(RISCV::ADDI), RISCV::X1)
                          .addReg(RISCV::X2)
                          .addImm(-128)
                          .getInstr();
  auto MI1Res = TII->isCopyInstrImpl(*MI1);
  EXPECT_FALSE(MI1Res.has_value());

  MachineInstr *MI2 = BuildMI(*MF, DL, TII->get(RISCV::ADDI), RISCV::X1)
                          .addReg(RISCV::X2)
                          .addImm(0)
                          .getInstr();
  auto MI2Res = TII->isCopyInstrImpl(*MI2);
  ASSERT_TRUE(MI2Res.has_value());
  EXPECT_EQ(MI2Res->Destination->getReg(), RISCV::X1);
  EXPECT_EQ(MI2Res->Source->getReg(), RISCV::X2);

  // Partial coverage of FSGNJ_* instructions.

  MachineInstr *MI3 = BuildMI(*MF, DL, TII->get(RISCV::FSGNJ_D), RISCV::F1_D)
                          .addReg(RISCV::F2_D)
                          .addReg(RISCV::F1_D)
                          .getInstr();
  auto MI3Res = TII->isCopyInstrImpl(*MI3);
  EXPECT_FALSE(MI3Res.has_value());

  MachineInstr *MI4 = BuildMI(*MF, DL, TII->get(RISCV::FSGNJ_D), RISCV::F1_D)
                          .addReg(RISCV::F2_D)
                          .addReg(RISCV::F2_D)
                          .getInstr();
  auto MI4Res = TII->isCopyInstrImpl(*MI4);
  ASSERT_TRUE(MI4Res.has_value());
  EXPECT_EQ(MI4Res->Destination->getReg(), RISCV::F1_D);
  EXPECT_EQ(MI4Res->Source->getReg(), RISCV::F2_D);

  // ADD/OR/XOR.
  for (unsigned Opc : {RISCV::ADD, RISCV::OR, RISCV::XOR}) {
    MachineInstr *MI5 = BuildMI(*MF, DL, TII->get(Opc), RISCV::X1)
                            .addReg(RISCV::X2)
                            .addReg(RISCV::X3)
                            .getInstr();
    auto MI5Res = TII->isCopyInstrImpl(*MI5);
    EXPECT_FALSE(MI5Res.has_value());

    MachineInstr *MI6 = BuildMI(*MF, DL, TII->get(Opc), RISCV::X1)
                            .addReg(RISCV::X0)
                            .addReg(RISCV::X2)
                            .getInstr();
    auto MI6Res = TII->isCopyInstrImpl(*MI6);
    ASSERT_TRUE(MI6Res.has_value());
    EXPECT_EQ(MI6Res->Destination->getReg(), RISCV::X1);
    EXPECT_EQ(MI6Res->Source->getReg(), RISCV::X2);

    MachineInstr *MI7 = BuildMI(*MF, DL, TII->get(Opc), RISCV::X1)
                            .addReg(RISCV::X2)
                            .addReg(RISCV::X0)
                            .getInstr();
    auto MI7Res = TII->isCopyInstrImpl(*MI7);
    ASSERT_TRUE(MI7Res.has_value());
    EXPECT_EQ(MI7Res->Destination->getReg(), RISCV::X1);
    EXPECT_EQ(MI7Res->Source->getReg(), RISCV::X2);
  }

  // SUB.
  MachineInstr *MI8 = BuildMI(*MF, DL, TII->get(RISCV::SUB), RISCV::X1)
                          .addReg(RISCV::X0)
                          .addReg(RISCV::X2)
                          .getInstr();
  auto MI8Res = TII->isCopyInstrImpl(*MI8);
  EXPECT_FALSE(MI8Res.has_value());

  MachineInstr *MI9 = BuildMI(*MF, DL, TII->get(RISCV::SUB), RISCV::X1)
                          .addReg(RISCV::X2)
                          .addReg(RISCV::X0)
                          .getInstr();
  auto MI9Res = TII->isCopyInstrImpl(*MI9);
  ASSERT_TRUE(MI9Res.has_value());
  EXPECT_EQ(MI9Res->Destination->getReg(), RISCV::X1);
  EXPECT_EQ(MI9Res->Source->getReg(), RISCV::X2);

  // SH1ADD(_UW), SH2ADD(_UW), SH3ADD(_UW).
  for (unsigned Opc : {RISCV::SH1ADD, RISCV::SH1ADD_UW, RISCV::SH2ADD,
                       RISCV::SH2ADD_UW, RISCV::SH3ADD, RISCV::SH3ADD_UW}) {
    MachineInstr *MI10 = BuildMI(*MF, DL, TII->get(Opc), RISCV::X1)
                             .addReg(RISCV::X2)
                             .addReg(RISCV::X3)
                             .getInstr();
    auto MI10Res = TII->isCopyInstrImpl(*MI10);
    EXPECT_FALSE(MI10Res.has_value());

    MachineInstr *MI11 = BuildMI(*MF, DL, TII->get(Opc), RISCV::X1)
                             .addReg(RISCV::X0)
                             .addReg(RISCV::X2)
                             .getInstr();
    auto MI11Res = TII->isCopyInstrImpl(*MI11);
    ASSERT_TRUE(MI11Res.has_value());
    EXPECT_EQ(MI11Res->Destination->getReg(), RISCV::X1);
    EXPECT_EQ(MI11Res->Source->getReg(), RISCV::X2);
  }
}

TEST_P(RISCVInstrInfoTest, GetMemOperandsWithOffsetWidth) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  const TargetRegisterInfo *TRI = ST->getRegisterInfo();
  DebugLoc DL;

  SmallVector<const MachineOperand *> BaseOps;
  LocationSize Width = LocationSize::precise(0);
  int64_t Offset;
  bool OffsetIsScalable;

  auto MMO = MF->getMachineMemOperand(MachinePointerInfo(),
                                      MachineMemOperand::MOLoad, 1, Align(1));
  MachineInstr *MI = BuildMI(*MF, DL, TII->get(RISCV::LB), RISCV::X1)
                         .addReg(RISCV::X2)
                         .addImm(-128)
                         .addMemOperand(MMO)
                         .getInstr();
  bool Res = TII->getMemOperandsWithOffsetWidth(*MI, BaseOps, Offset,
                                                OffsetIsScalable, Width, TRI);
  ASSERT_TRUE(Res);
  ASSERT_EQ(BaseOps.size(), 1u);
  ASSERT_TRUE(BaseOps.front()->isReg());
  EXPECT_EQ(BaseOps.front()->getReg(), RISCV::X2);
  EXPECT_EQ(Offset, -128);
  EXPECT_FALSE(OffsetIsScalable);
  EXPECT_EQ(Width, 1u);

  BaseOps.clear();
  MMO = MF->getMachineMemOperand(MachinePointerInfo(),
                                 MachineMemOperand::MOStore, 4, Align(4));
  MI = BuildMI(*MF, DL, TII->get(RISCV::FSW))
           .addReg(RISCV::F3_F)
           .addReg(RISCV::X3)
           .addImm(36)
           .addMemOperand(MMO);
  Res = TII->getMemOperandsWithOffsetWidth(*MI, BaseOps, Offset,
                                           OffsetIsScalable, Width, TRI);
  ASSERT_TRUE(Res);
  ASSERT_EQ(BaseOps.size(), 1u);
  ASSERT_TRUE(BaseOps.front()->isReg());
  EXPECT_EQ(BaseOps.front()->getReg(), RISCV::X3);
  EXPECT_EQ(Offset, 36);
  EXPECT_FALSE(OffsetIsScalable);
  EXPECT_EQ(Width, 4u);

  BaseOps.clear();
  MMO = MF->getMachineMemOperand(MachinePointerInfo(),
                                 MachineMemOperand::MOStore, 16, Align(16));
  MI = BuildMI(*MF, DL, TII->get(RISCV::PseudoVLE32_V_M1), RISCV::V8)
           .addReg(RISCV::X3)
           .addMemOperand(MMO);
  Res = TII->getMemOperandsWithOffsetWidth(*MI, BaseOps, Offset,
                                           OffsetIsScalable, Width, TRI);
  ASSERT_FALSE(Res); // Vector loads/stored are not handled for now.

  BaseOps.clear();
  MI = BuildMI(*MF, DL, TII->get(RISCV::ADDI), RISCV::X4)
           .addReg(RISCV::X5)
           .addImm(16);
  Res = TII->getMemOperandsWithOffsetWidth(*MI, BaseOps, Offset,
                                           OffsetIsScalable, Width, TRI);

  BaseOps.clear();
  MMO = MF->getMachineMemOperand(MachinePointerInfo(),
                                 MachineMemOperand::MOStore, 4, Align(4));
  MI = BuildMI(*MF, DL, TII->get(RISCV::SW))
           .addReg(RISCV::X3)
           .addFrameIndex(2)
           .addImm(4)
           .addMemOperand(MMO);
  Res = TII->getMemOperandsWithOffsetWidth(*MI, BaseOps, Offset,
                                           OffsetIsScalable, Width, TRI);
  ASSERT_TRUE(Res);
  ASSERT_EQ(BaseOps.size(), 1u);
  ASSERT_TRUE(BaseOps.front()->isFI());
  EXPECT_EQ(BaseOps.front()->getIndex(), 2);
  EXPECT_EQ(Offset, 4);
  EXPECT_FALSE(OffsetIsScalable);
  EXPECT_EQ(Width, 4u);
}

static void expectDIEPrintResult(const DIExpression *Expr, StringRef Expected) {
  std::string Output;
  raw_string_ostream OS(Output);
  Expr->print(OS);
  EXPECT_EQ(Output, Expected);
}

TEST_P(RISCVInstrInfoTest, DescribeLoadedValue) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  DebugLoc DL;

  MachineBasicBlock *MBB = MF->CreateMachineBasicBlock();
  MF->getProperties().setNoVRegs();

  // Register move.
  auto *MI1 = BuildMI(*MBB, MBB->begin(), DL, TII->get(RISCV::ADDI), RISCV::X1)
                  .addReg(RISCV::X2)
                  .addImm(0)
                  .getInstr();
  EXPECT_FALSE(TII->describeLoadedValue(*MI1, RISCV::X2).has_value());
  std::optional<ParamLoadedValue> MI1Res =
      TII->describeLoadedValue(*MI1, RISCV::X1);
  ASSERT_TRUE(MI1Res.has_value());
  ASSERT_TRUE(MI1Res->first.isReg());
  EXPECT_EQ(MI1Res->first.getReg(), RISCV::X2);
  expectDIEPrintResult(MI1Res->second, "!DIExpression()");

  // Load immediate.
  auto *MI2 = BuildMI(*MBB, MBB->begin(), DL, TII->get(RISCV::ADDI), RISCV::X3)
                  .addReg(RISCV::X0)
                  .addImm(111)
                  .getInstr();
  std::optional<ParamLoadedValue> MI2Res =
      TII->describeLoadedValue(*MI2, RISCV::X3);
  ASSERT_TRUE(MI2Res.has_value());
  ASSERT_TRUE(MI2Res->first.isReg());
  EXPECT_EQ(MI2Res->first.getReg(), RISCV::X0);
  // TODO: Could be a DW_OP_constu if this is recognised as a immediate load
  // rather than just an addi.
  expectDIEPrintResult(MI2Res->second, "!DIExpression(DW_OP_plus_uconst, 111)");

  // Add immediate.
  auto *MI3 = BuildMI(*MBB, MBB->begin(), DL, TII->get(RISCV::ADDI), RISCV::X2)
                  .addReg(RISCV::X3)
                  .addImm(222)
                  .getInstr();
  std::optional<ParamLoadedValue> MI3Res =
      TII->describeLoadedValue(*MI3, RISCV::X2);
  ASSERT_TRUE(MI3Res.has_value());
  ASSERT_TRUE(MI3Res->first.isReg());
  EXPECT_EQ(MI3Res->first.getReg(), RISCV::X3);
  expectDIEPrintResult(MI3Res->second, "!DIExpression(DW_OP_plus_uconst, 222)");

  // Load value from memory.
  // It would be better (more reflective of real-world describeLoadedValue
  // usage) to test using MachinePointerInfo::getFixedStack, but
  // unfortunately it would be overly fiddly to make this work.
  auto MMO = MF->getMachineMemOperand(MachinePointerInfo::getConstantPool(*MF),
                                      MachineMemOperand::MOLoad, 1, Align(1));
  auto *MI4 = BuildMI(*MBB, MBB->begin(), DL, TII->get(RISCV::LB), RISCV::X1)
                  .addReg(RISCV::X2)
                  .addImm(-128)
                  .addMemOperand(MMO)
                  .getInstr();
  std::optional<ParamLoadedValue> MI4Res =
      TII->describeLoadedValue(*MI4, RISCV::X1);
  ASSERT_TRUE(MI4Res.has_value());
  ASSERT_TRUE(MI4Res->first.isReg());
  EXPECT_EQ(MI4Res->first.getReg(), RISCV::X2);
  expectDIEPrintResult(
      MI4Res->second,
      "!DIExpression(DW_OP_constu, 128, DW_OP_minus, DW_OP_deref_size, 1)");

  MF->deleteMachineBasicBlock(MBB);
}

TEST_P(RISCVInstrInfoTest, GetDestEEW) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VADD_VV), 3), 3u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VWADD_VV), 3), 4u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VLE32_V), 5), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VLSE32_V), 5), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VREDSUM_VS), 4), 4u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VWREDSUM_VS), 4), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VFWREDOSUM_VS), 5), 6u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VFCVT_RTZ_XU_F_V), 4), 4u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VFWCVT_RTZ_XU_F_V), 4), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VSLL_VI), 4), 4u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VWSLL_VI), 4), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VMSEQ_VV), 4), 0u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VMAND_MM), 0), 0u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::VIOTA_M), 3), 3u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::SF_VQMACCU_2x8x2), 3), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::SF_VFWMACC_4x4x4), 4), 5u);
  EXPECT_EQ(RISCV::getDestLog2EEW(TII->get(RISCV::TH_VMAQA_VV), 5), 5u);
}

TEST_P(RISCVXQCIInstrInfoTest, XQCIEInstSize) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  MachineBasicBlock *MBB = MF->CreateMachineBasicBlock();
  MF->push_back(MBB);

  auto MakeLoad = [&](unsigned Opcode) {
    MachineMemOperand *MMO = MF->getMachineMemOperand(
        MachinePointerInfo(), MachineMemOperand::MOLoad, 4, Align(4));
    return BuildMI(MBB, DebugLoc(), TII->get(Opcode), RISCV::X0)
        .addReg(RISCV::X14)
        .addImm(0)
        .addMemOperand(MMO)
        .getInstr();
  };

  auto MakeStore = [&](unsigned Opcode) {
    MachineMemOperand *MMO = MF->getMachineMemOperand(
        MachinePointerInfo(), MachineMemOperand::MOStore, 4, Align(4));
    return BuildMI(MBB, DebugLoc(), TII->get(Opcode))
        .addReg(RISCV::X0)
        .addReg(RISCV::X14)
        .addImm(0)
        .addMemOperand(MMO)
        .getInstr();
  };

  auto MakeEAI = [&](unsigned Opcode) {
    return BuildMI(MBB, DebugLoc(), TII->get(Opcode), RISCV::X31)
        .addReg(RISCV::X31)
        .addImm(100)
        .getInstr();
  };

  auto MakeEI = [&](unsigned Opcode) {
    return BuildMI(MBB, DebugLoc(), TII->get(Opcode), RISCV::X31)
        .addReg(RISCV::X30)
        .addImm(1)
        .getInstr();
  };

  auto MakeBranch = [&](unsigned Opcode) {
    return BuildMI(MBB, DebugLoc(), TII->get(Opcode))
        .addReg(RISCV::X14)
        .addImm(1)
        .addImm(2)
        .getInstr();
  };

  auto MakeJump = [&](unsigned Opcode) {
    return BuildMI(MBB, DebugLoc(), TII->get(Opcode)).addImm(4096).getInstr();
  };

  // FIXME: The instructions being checked in this test all compress to 4 byte
  // instructions but getInstSizeInBytes() currently returns 2 for all
  // instructions that are compressible.
  auto CheckSize = [&](MachineInstr *MI) {
    EXPECT_EQ(2u, TII->getInstSizeInBytes(*MI));
  };

  CheckSize(MakeLoad(RISCV::QC_E_LW));
  CheckSize(MakeLoad(RISCV::QC_E_LB));
  CheckSize(MakeLoad(RISCV::QC_E_LH));
  CheckSize(MakeLoad(RISCV::QC_E_LBU));
  CheckSize(MakeLoad(RISCV::QC_E_LHU));
  CheckSize(MakeStore(RISCV::QC_E_SW));
  CheckSize(MakeStore(RISCV::QC_E_SB));
  CheckSize(MakeStore(RISCV::QC_E_SH));
  CheckSize(MakeJump(RISCV::QC_E_JAL));
  CheckSize(MakeJump(RISCV::QC_E_J));
  CheckSize(BuildMI(MBB, DebugLoc(), TII->get(RISCV::QC_E_LI), RISCV::X31)
                .addImm(123)
                .getInstr());
  CheckSize(MakeEI(RISCV::QC_E_ADDI));
  CheckSize(MakeEI(RISCV::QC_E_ANDI));
  CheckSize(MakeEI(RISCV::QC_E_ORI));
  CheckSize(MakeEI(RISCV::QC_E_XORI));
  CheckSize(MakeEAI(RISCV::QC_E_ADDAI));
  CheckSize(MakeEAI(RISCV::QC_E_ANDAI));
  CheckSize(MakeEAI(RISCV::QC_E_ORAI));
  CheckSize(MakeEAI(RISCV::QC_E_XORAI));
  CheckSize(MakeBranch(RISCV::QC_E_BEQI));
  CheckSize(MakeBranch(RISCV::QC_E_BNEI));
  CheckSize(MakeBranch(RISCV::QC_E_BLTI));
  CheckSize(MakeBranch(RISCV::QC_E_BGEUI));
  CheckSize(MakeBranch(RISCV::QC_E_BLTUI));
  CheckSize(MakeBranch(RISCV::QC_E_BGEI));
}

TEST_P(RISCVInstrInfoTest, ZttInstructionEffects) {
  const RISCVInstrInfo *TII = ST->getInstrInfo();
  for (unsigned Opcode : {RISCV::ZTT_MCOLZIP_EW, RISCV::ZTT_MCOLUNZIP_EW,
                          RISCV::ZTT_MROWZIP_EW, RISCV::ZTT_MROWUNZIP_EW}) {
    const MCInstrDesc &Desc = TII->get(Opcode);
    EXPECT_FALSE(Desc.hasUnmodeledSideEffects());
    EXPECT_EQ(Desc.getNumDefs(), 2u);
    EXPECT_EQ(Desc.getNumOperands(), 4u);
    EXPECT_EQ(Desc.getOperandConstraint(2, MCOI::TIED_TO), 0);
    EXPECT_EQ(Desc.getOperandConstraint(3, MCOI::TIED_TO), 1);
  }

  // Ownership, type updates and amestype dependencies remain observable.
  for (unsigned Opcode : {RISCV::ZTT_AME_ACQUIRE, RISCV::ZTT_AME_RELEASE,
                          RISCV::ZTT_MSETTYP, RISCV::ZTT_ASETTYP,
                          RISCV::ZTT_MADD_EW_X})
    EXPECT_TRUE(TII->get(Opcode).hasUnmodeledSideEffects());
  for (unsigned Opcode : {RISCV::ZTT_MADD_EW, RISCV::ZTT_MSLL_EW_X,
                          RISCV::ZTT_MBCAST_M_X, RISCV::ZTT_MMOV_M_M})
    EXPECT_FALSE(TII->get(Opcode).hasUnmodeledSideEffects());

  // Memory effects are represented by load/store flags.
  for (unsigned Opcode : {RISCV::ZTT_MLS_1R, RISCV::ZTT_MLS_RM,
                          RISCV::ZTT_MLS_ST}) {
    EXPECT_TRUE(TII->get(Opcode).mayLoad());
    EXPECT_FALSE(TII->get(Opcode).mayStore());
    EXPECT_FALSE(TII->get(Opcode).hasUnmodeledSideEffects());
  }
  for (unsigned Opcode : {RISCV::ZTT_MSS_1R, RISCV::ZTT_MSS_RM,
                          RISCV::ZTT_MSS_ST}) {
    EXPECT_FALSE(TII->get(Opcode).mayLoad());
    EXPECT_TRUE(TII->get(Opcode).mayStore());
    EXPECT_FALSE(TII->get(Opcode).hasUnmodeledSideEffects());
  }
}

TEST_P(RISCVInstrInfoTest, ZttRegisterBanks) {
  const RISCVRegisterInfo *TRI = ST->getRegisterInfo();
  const TargetRegisterClass *MRC = TRI->getRegClass(RISCV::ZTTMRRegClassID);
  const TargetRegisterClass *ARC = TRI->getRegClass(RISCV::ZTTARRegClassID);
  ASSERT_EQ(MRC->getNumRegs(), 32u);
  ASSERT_EQ(ARC->getNumRegs(), 16u);

  for (unsigned I = 0; I != 32; ++I) {
    MCRegister Reg = RISCV::ZTTM0 + I;
    EXPECT_TRUE(MRC->contains(Reg));
    EXPECT_FALSE(ARC->contains(Reg));
    EXPECT_EQ(TRI->getEncodingValue(Reg), I);
    EXPECT_EQ("m" + std::to_string(I),
              RISCVInstPrinter::getRegisterName(Reg, RISCV::NoRegAltName));
    EXPECT_STREQ(RISCVInstPrinter::getRegisterName(Reg, RISCV::NoRegAltName),
                 RISCVInstPrinter::getRegisterName(Reg, RISCV::ABIRegAltName));
  }
  for (unsigned I = 0; I != 16; ++I) {
    MCRegister Reg = RISCV::ZTTA0 + I;
    EXPECT_TRUE(ARC->contains(Reg));
    EXPECT_FALSE(MRC->contains(Reg));
    EXPECT_EQ(TRI->getEncodingValue(Reg), I);
    EXPECT_EQ("acc" + std::to_string(I),
              RISCVInstPrinter::getRegisterName(Reg, RISCV::NoRegAltName));
    EXPECT_STREQ(RISCVInstPrinter::getRegisterName(Reg, RISCV::NoRegAltName),
                 RISCVInstPrinter::getRegisterName(Reg, RISCV::ABIRegAltName));
  }
  for (MCRegister Reg : {RISCV::X0, RISCV::F0_D, RISCV::V0, RISCV::M0}) {
    EXPECT_FALSE(MRC->contains(Reg));
    EXPECT_FALSE(ARC->contains(Reg));
  }
}

TEST_P(RISCVInstrInfoTest, ZttValueTypes) {
  const MVT Types[] = {
      MVT::riscv_zttm4,    MVT::riscv_zttm8,    MVT::riscv_zttm16,   MVT::riscv_zttm32, MVT::riscv_zttm64,
      MVT::riscv_zttm128,  MVT::riscv_zttm256,  MVT::riscv_zttm512,  MVT::riscv_zttm1024,
      MVT::riscv_zttm2048, MVT::riscv_zttm4096, MVT::riscv_ztta1,    MVT::riscv_ztta2,
      MVT::riscv_ztta4,    MVT::riscv_ztta8,    MVT::riscv_ztta16};
  const unsigned Sizes[] = {4,   8,   16,  32,   64,   128, 256, 512,
                            1024, 2048, 4096, 16, 32, 64, 128, 256};
  for (unsigned I = 0; I != std::size(Types); ++I) {
    MVT VT = Types[I];
    EXPECT_TRUE(VT.isRISCVZtt());
    EXPECT_TRUE(VT.isScalableTargetExtVT());
    EXPECT_TRUE(VT.isScalableVT());
    EXPECT_FALSE(VT.isVector());
    EXPECT_EQ(VT.getSizeInBits(), TypeSize::getScalable(Sizes[I]));
  }
  for (MVT VT : {MVT::i16, MVT::f32, MVT::nxv1i8, MVT::aarch64svcount})
    EXPECT_FALSE(VT.isRISCVZtt());
}

struct ZttTestGroup {
  const TargetRegisterClass *RC;
  unsigned Size;
};

static void checkZttRegisterGroups(const RISCVRegisterInfo &TRI,
                                   const TargetRegisterClass &BaseRC,
                                   ArrayRef<ZttTestGroup> Groups,
                                   ArrayRef<unsigned> SubRegIndices,
                                   bool AlignToGroup) {
  for (const auto &[RC, Size] : Groups) {
    unsigned Step = AlignToGroup ? Size : 1;
    ASSERT_EQ(RC->getNumRegs(), (BaseRC.getNumRegs() - Size) / Step + 1);
    ASSERT_GE(SubRegIndices.size(), Size);
    for (unsigned I = 0; I != RC->getNumRegs(); ++I) {
      MCRegister Reg = RC->getRegister(I);
      unsigned Base = I * Step;
      SCOPED_TRACE(TRI.getName(Reg));
      EXPECT_EQ(TRI.getEncodingValue(Reg), Base);
      for (unsigned J = 0; J != Size; ++J) {
        MCRegister SubReg = BaseRC.getRegister(Base + J);
        EXPECT_EQ(TRI.getSubReg(Reg, SubRegIndices[J]), SubReg);
        EXPECT_EQ(TRI.getSubRegIndex(Reg, SubReg), SubRegIndices[J]);
      }
      for (unsigned J = 0; J != BaseRC.getNumRegs(); ++J)
        EXPECT_EQ(TRI.regsOverlap(Reg, BaseRC.getRegister(J)),
                  Base <= J && J < Base + Size);

      // Groups overlap exactly when they share physical registers.
      for (const auto &[OtherRC, OtherSize] : Groups) {
        unsigned OtherStep = AlignToGroup ? OtherSize : 1;
        for (unsigned J = 0; J != OtherRC->getNumRegs(); ++J) {
          MCRegister Other = OtherRC->getRegister(J);
          unsigned OtherBase = J * OtherStep;
          SCOPED_TRACE(TRI.getName(Other));
          EXPECT_EQ(TRI.regsOverlap(Reg, Other),
                    Base < OtherBase + OtherSize && OtherBase < Base + Size);
        }
      }
      for (MCRegister Other : {RISCV::X0, RISCV::F0_D, RISCV::V0, RISCV::M0})
        EXPECT_FALSE(TRI.regsOverlap(Reg, Other));
    }
  }
}

TEST_P(RISCVInstrInfoTest, ZttMRegisterGroups) {
  const RISCVRegisterInfo *TRI = ST->getRegisterInfo();
  const ZttTestGroup Groups[] = {{&RISCV::ZTTMRM2RegClass, 2},
                                 {&RISCV::ZTTMRM4RegClass, 4},
                                 {&RISCV::ZTTMRM8RegClass, 8},
                                 {&RISCV::ZTTMRM16RegClass, 16},
                                 {&RISCV::ZTTMRM32RegClass, 32}};
  const unsigned Indices[] = {
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
  checkZttRegisterGroups(*TRI, RISCV::ZTTMRRegClass, Groups, Indices,
                         /*AlignToGroup=*/true);
  EXPECT_FALSE(TRI->regsOverlap(RISCV::ZTTM0M32, RISCV::ZTTA0M8));
  EXPECT_FALSE(TRI->regsOverlap(RISCV::ZTTM0M32, RISCV::ZTTA8M8));
}

TEST_P(RISCVInstrInfoTest, ZttACCRegisterGroups) {
  const ZttTestGroup Groups[] = {{&RISCV::ZTTARM2RegClass, 2},
                                 {&RISCV::ZTTARM4RegClass, 4},
                                 {&RISCV::ZTTARM8RegClass, 8},
                                 {&RISCV::ZTTARM16RegClass, 16}};
  const unsigned Indices[] = {RISCV::sub_ztta_0, RISCV::sub_ztta_1,
                              RISCV::sub_ztta_2, RISCV::sub_ztta_3,
                              RISCV::sub_ztta_4, RISCV::sub_ztta_5,
                              RISCV::sub_ztta_6, RISCV::sub_ztta_7,
                              RISCV::sub_ztta_8, RISCV::sub_ztta_9,
                              RISCV::sub_ztta_10, RISCV::sub_ztta_11,
                              RISCV::sub_ztta_12, RISCV::sub_ztta_13,
                              RISCV::sub_ztta_14, RISCV::sub_ztta_15};
  checkZttRegisterGroups(*ST->getRegisterInfo(), RISCV::ZTTARRegClass, Groups,
                         Indices, /*AlignToGroup=*/false);
}

TEST_P(RISCVInstrInfoTest, ZttReservedRegisters) {
  for (unsigned MCount : {16U, 32U})
    for (unsigned ACount : {1U, 2U, 4U, 8U, 16U}) {
      RISCV::ZttProfile Profile{0, 16, MCount, ACount};
      RISCVSubtarget ZST(TM->getTargetTriple(), TM->getTargetCPU(),
                         TM->getTargetCPU(), "+ztt",
                         ST->is64Bit() ? "lp64" : "ilp32", 0, 0, *TM, Profile);
      MachineFunction ZMF(MF->getFunction(), *TM, ZST, MMI->getContext(), 43);
      // Initialize per-function state before querying reserved registers.
      ZMF.initTargetMachineFunctionInfo(ZST);
      const auto *RI = ZST.getRegisterInfo();
      BitVector Reserved = RI->getReservedRegs(ZMF);
      EXPECT_EQ(ZST.getZttUdsBits(), 16U);
      EXPECT_EQ(ZST.getZttMRegs(), MCount);
      EXPECT_EQ(ZST.getZttARegs(), ACount);
      auto CheckClass = [&](const TargetRegisterClass &RC, unsigned Limit) {
        for (MCPhysReg Reg : RC) {
          bool Unavailable = false;
          for (MCPhysReg Sub : RI->subregs_inclusive(Reg))
            if (RISCV::ZTTMRRegClass.contains(Sub) ||
                RISCV::ZTTARRegClass.contains(Sub))
              Unavailable |= RI->getEncodingValue(Sub) >= Limit;
          EXPECT_EQ(Reserved.test(Reg), Unavailable) << RI->getName(Reg);
        }
      };
      // Check every physical register and every group, including unaligned
      // ACC groups which cross the end of the configured register file.
      for (const auto *RC :
           {&RISCV::ZTTMRRegClass, &RISCV::ZTTMRM2RegClass,
            &RISCV::ZTTMRM4RegClass, &RISCV::ZTTMRM8RegClass,
            &RISCV::ZTTMRM16RegClass, &RISCV::ZTTMRM32RegClass})
        CheckClass(*RC, MCount);
      for (const auto *RC : {&RISCV::ZTTARRegClass, &RISCV::ZTTARM2RegClass,
                             &RISCV::ZTTARM4RegClass, &RISCV::ZTTARM8RegClass,
                             &RISCV::ZTTARM16RegClass})
        CheckClass(*RC, ACount);
    }
}

// Borrowing a continuation must discover the original wide leader. Copies
// propagate that layout, but data-only moves must not erase it.
TEST_P(RISCVInstrInfoTest, ZttMLayoutTransfer) {
  auto *BB = MF->CreateMachineBasicBlock();
  MF->push_back(BB);
  const auto &TII = *ST->getInstrInfo();
  const auto &TRI = *ST->getRegisterInfo();
  ZttMLayout State;
  State.fill(-1);
  auto Set = BuildMI(*BB, BB->end(), DebugLoc(), TII.get(RISCV::ZTT_MSETTYP),
                     RISCV::ZTTM0)
                 .addReg(RISCV::X10)
                 .addReg(RISCV::ZTTM1, RegState::ImplicitDefine);
  transferZttMLayout(*Set, State, TRI);
  EXPECT_EQ(State[0], 2);
  EXPECT_EQ(State[1], 0);
  EXPECT_EQ(State[2], -1);
  auto Copy = BuildMI(*BB, BB->end(), DebugLoc(), TII.get(TargetOpcode::COPY),
                      RISCV::ZTTM2M2)
                  .addReg(RISCV::ZTTM0M2);
  transferZttMLayout(*Copy, State, TRI);
  EXPECT_EQ(State[2], 2);
  EXPECT_EQ(State[3], 0);
  auto Move = BuildMI(*BB, BB->end(), DebugLoc(), TII.get(RISCV::ZTT_MMOV_M_A),
                      RISCV::ZTTM2)
                  .addReg(RISCV::ZTTA0)
                  .addReg(RISCV::ZTTM3, RegState::ImplicitDefine);
  transferZttMLayout(*Move, State, TRI);
  EXPECT_EQ(State[2], 2);
  EXPECT_EQ(State[3], 0);
  auto Clobber = BuildMI(*BB, BB->end(), DebugLoc(),
                         TII.get(TargetOpcode::IMPLICIT_DEF), RISCV::ZTTM2M2);
  transferZttMLayout(*Clobber, State, TRI);
  EXPECT_EQ(State[0], 2);
  EXPECT_EQ(State[1], 0);
  EXPECT_EQ(State[2], -1);
  EXPECT_EQ(State[3], -1);
  EXPECT_EQ(getZttMGroupSize(RISCV::ZTTM0M32), 32u);
  EXPECT_EQ(getZttMGroupSize(RISCV::ZTTA0M2), 0u);
  // A call mask invalidates only clobbered registers, even when no explicit
  // matrix definition occurs on the instruction.
  auto *Mask = MF->allocateRegMask();
  std::fill_n(Mask, MachineOperand::getRegMaskSize(TRI.getNumRegs()), ~0u);
  Mask[RISCV::ZTTM0 / 32] &= ~(1u << (RISCV::ZTTM0 % 32));
  Mask[RISCV::ZTTM1 / 32] &= ~(1u << (RISCV::ZTTM1 % 32));
  State[8] = 1;
  auto Call = BuildMI(*BB, BB->end(), DebugLoc(), TII.get(RISCV::PseudoCALL))
                  .addExternalSymbol("callee")
                  .addRegMask(Mask);
  transferZttMLayout(*Call, State, TRI);
  EXPECT_EQ(State[0], -1);
  EXPECT_EQ(State[1], -1);
  EXPECT_EQ(State[8], 1);
}

TEST_P(RISCVInstrInfoTest, ZttMLayoutLoopAndConflict) {
  MF->initTargetMachineFunctionInfo(*ST);
  auto *Entry = MF->CreateMachineBasicBlock();
  auto *Loop = MF->CreateMachineBasicBlock();
  auto *Other = MF->CreateMachineBasicBlock();
  auto *Merge = MF->CreateMachineBasicBlock();
  auto *Unreachable = MF->CreateMachineBasicBlock();
  for (auto *BB : {Entry, Loop, Other, Merge, Unreachable})
    MF->push_back(BB);
  Entry->addSuccessor(Loop);
  Entry->addSuccessor(Other);
  Loop->addSuccessor(Loop);
  Loop->addSuccessor(Merge);
  Other->addSuccessor(Merge);
  auto &Info = *MF->getInfo<RISCVMachineFunctionInfo>();
  Info.setZttMArgLayout(0, 2, 2);
  const auto &TII = *ST->getInstrInfo();
  BuildMI(*Other, Other->end(), DebugLoc(), TII.get(RISCV::ZTT_MSETTYP),
          RISCV::ZTTM0)
      .addReg(RISCV::X10);
  auto Layouts = analyzeZttMLayouts(*MF);
  EXPECT_FALSE(Layouts.count(Unreachable));
  ASSERT_TRUE(Layouts.count(Loop));
  EXPECT_EQ(Layouts[Loop][0], 2);
  EXPECT_EQ(Layouts[Loop][1], 0);
  ASSERT_TRUE(Layouts.count(Merge));
  EXPECT_EQ(Layouts[Merge][0], -1);
  // An unknown leader prevents a transfer even if its continuation is known.
  EXPECT_EQ(Layouts[Merge][1], 0);
}

TEST_P(RISCVInstrInfoTest, ZttAccTransferLayout) {
  // Cover all supported widths, shapes and UDS values independently of the
  // instruction emitter. Packed batches must never be rounded up.
  for (unsigned U : {8u, 16u, 32u, 64u, 128u})
    for (unsigned E : {4u, 8u, 16u, 32u, 64u, 128u})
      for (unsigned K : {1u, 2u, 4u, 8u, 16u}) {
        auto L = getZttAccTransferLayout(E, K, U);
        if (E * K < U) {
          EXPECT_FALSE(L);
          continue;
        }
        ASSERT_TRUE(L);
        EXPECT_EQ(L->MRegsPerMove, E > U ? E / U : 1u);
        EXPECT_EQ(L->AccsPerMove, E < U ? U / E : 1u);
        EXPECT_EQ(L->NumMoves * L->AccsPerMove, K);
        EXPECT_EQ(L->Units * U, K * E);
      }
  EXPECT_FALSE(getZttAccTransferLayout(0, 2, 32));
  EXPECT_FALSE(getZttAccTransferLayout(24, 2, 32));
  EXPECT_FALSE(getZttAccTransferLayout(16, 3, 32));
  EXPECT_FALSE(getZttAccTransferLayout(16, 32, 32));
  EXPECT_FALSE(getZttAccTransferLayout(16, 2, 0));
}

TEST_P(RISCVInstrInfoTest, ZttAccValueLayout) {
  const auto &TII = *ST->getInstrInfo();
  auto &MRI = MF->getRegInfo();
  auto *BB = MF->CreateMachineBasicBlock();
  MF->push_back(BB);
  auto Acc = [&]() {
    return MRI.createVirtualRegister(&RISCV::ZTTARM2RegClass);
  };
  Register Seed = Acc(), Copy = Acc(), Sum = Acc(), Phi = Acc();
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(RISCV::PseudoZTTAClearA2), Seed)
      .addReg(RISCV::X10)
      .addImm(16);
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(TargetOpcode::COPY), Copy)
      .addReg(Seed);
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(TargetOpcode::PHI), Phi)
      .addReg(Copy)
      .addMBB(BB)
      .addReg(Sum)
      .addMBB(BB);
  BuildMI(*BB, BB->end(), DebugLoc(),
          TII.get(RISCV::PseudoZTTMMulAcc2D_A2_L1_R1), Sum)
      .addReg(Phi)
      .addReg(RISCV::ZTTM0)
      .addReg(RISCV::ZTTM1)
      .addImm(1);
  for (Register R : {Seed, Copy, Phi, Sum})
    EXPECT_EQ(getZttAccElementBits(R, *MF, 32), 16u);

  Register Cross = Acc();
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(RISCV::PseudoZTTMCopyM2A_A2_M1),
          Cross)
      .addReg(RISCV::ZTTM0)
      .addImm(1)
      .addImm(2)
      .addReg(RISCV::X10);
  EXPECT_EQ(getZttAccElementBits(Cross, *MF, 32), 16u);
  EXPECT_EQ(getZttAccElementBits(Cross, *MF, 64), 32u);

  Register Other = Acc(), Conflict = Acc(), Unknown = Acc();
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(RISCV::PseudoZTTAClearA2), Other)
      .addReg(RISCV::X11)
      .addImm(32);
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(TargetOpcode::PHI), Conflict)
      .addReg(Seed)
      .addMBB(BB)
      .addReg(Other)
      .addMBB(BB);
  EXPECT_FALSE(getZttAccElementBits(Conflict, *MF, 32));
  BuildMI(*BB, BB->end(), DebugLoc(), TII.get(TargetOpcode::IMPLICIT_DEF),
          Unknown);
  EXPECT_FALSE(getZttAccElementBits(Unknown, *MF, 32));
  EXPECT_FALSE(getZttAccElementBits(RISCV::ZTTA0M2, *MF, 32));
}

TEST_P(RISCVInstrInfoTest, ZttAcc16PackedLayout) {
  const auto &TII = *ST->getInstrInfo();
  auto *BB = MF->CreateMachineBasicBlock();
  MF->push_back(BB);
  Register Acc = MF->getRegInfo().createVirtualRegister(&RISCV::ZTTARM16RegClass);
  auto MI = BuildMI(*BB, BB->end(), DebugLoc(),
                    TII.get(RISCV::PseudoZTTMCopyM2A_A16_M1), Acc)
                .addReg(RISCV::ZTTM0)
                .addImm(1)
                .addImm(16)
                .addReg(RISCV::X10);
  EXPECT_EQ(getZttAccElementBits(Acc, *MF, 128), 8u);
  EXPECT_EQ(getZttAccElementBits(Acc, *MF, 64), 4u);
  MI->getOperand(0).setReg(RISCV::ZTTA0M16);
  ZttAccLayout Layout;
  Layout.fill(-1);
  transferZttAccLayout(*MI, Layout, *ST->getRegisterInfo(), 128);
  for (unsigned I = 0; I != 16; ++I)
    EXPECT_EQ(Layout[I], 8);
}

} // namespace

INSTANTIATE_TEST_SUITE_P(RV32And64, RISCVInstrInfoTest,
                         testing::Values("riscv32", "riscv64"));
INSTANTIATE_TEST_SUITE_P(RV32, RISCVXQCIInstrInfoTest,
                         testing::Values("riscv32"));
