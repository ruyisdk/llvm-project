//===-- RISCVZttAccSpill.cpp - Ztt ACC spills ----------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RISCVInstrInfo.h"
#include "RISCVMachineFunctionInfo.h"
#include "RISCVSubtarget.h"
#include "RISCVZttRegisterLayout.h"
#include "RISCVZttSpill.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"

using namespace llvm;

bool llvm::prepareZttAccCopies(MachineFunction &MF) {
  auto IsCopy = [](const MachineInstr &MI) {
    return MI.isCopy() && getZttAccGroupSize(MI.getOperand(0).getReg());
  };
  if (!llvm::any_of(MF, [&](const MachineBasicBlock &BB) {
        return llvm::any_of(BB, IsCopy);
      }))
    return false;

  const auto &ST = MF.getSubtarget<RISCVSubtarget>();
  const auto &TRI = *ST.getRegisterInfo();
  auto In = analyzeZttAccLayouts(MF);
  // Each copy completes its save/reload before the next one, so copies of the
  // same layout may reuse a single image. Existing spill expansion protects
  // borrowed M groups and GPRs even when no registers are available.
  DenseMap<std::pair<unsigned, unsigned>, int> Slots;
  for (auto &BB : MF) {
    ZttAccLayout State;
    State.fill(-1);
    if (auto It = In.find(&BB); It != In.end())
      State = It->second;
    for (auto I = BB.begin(); I != BB.end();) {
      MachineInstr &MI = *I++;
      ZttAccLayout Before = State;
      transferZttAccLayout(MI, State, TRI, ST.getZttUdsBits());
      if (!IsCopy(MI))
        continue;
      Register Dst = MI.getOperand(0).getReg();
      Register Src = MI.getOperand(1).getReg();
      if (Dst == Src) {
        MI.eraseFromParent();
        continue;
      }
      unsigned Group = getZttAccGroupSize(Dst);
      if (getZttAccGroupSize(Src) != Group)
        report_fatal_error("Ztt ACC COPY requires equal ACC register groups");
      if (TRI.regsOverlap(Dst, Src))
        report_fatal_error("Ztt ACC COPY source and destination overlap");
      Register Base =
          Group == 1 ? Src : Register(TRI.getSubReg(Src, RISCV::sub_ztta_0));
      unsigned S = Base - RISCV::ZTTA0;
      int Bits = Before[S];
      if (Bits < 0 || !llvm::all_of(
                          ArrayRef<int>(Before).slice(S, Group),
                          [&](int B) { return B == Bits; }))
        report_fatal_error("Ztt ACC COPY source element width is unknown");
      if (!getZttAccTransferLayout(Bits, Group, ST.getZttUdsBits()))
        reportFatalUsageError(
            "Ztt ACC COPY requires a complete transfer group");
      auto Key = std::make_pair(Group, unsigned(Bits));
      auto Slot = Slots.find(Key);
      if (Slot == Slots.end()) {
        int FI = MF.getFrameInfo().CreateSpillStackObject(Group * 4, Align(4));
        Slot = Slots.try_emplace(Key, FI).first;
        MF.getInfo<RISCVMachineFunctionInfo>()->ZttAccSpillBits[FI] = Bits;
      }
      const auto *RC = getZttAccRegisterClass(Group);
      emitZttSpill(BB, MI.getIterator(), Src, false, MI.getOperand(1).isKill(),
                   Slot->second, RC, Register(), MachineInstr::NoFlags);
      emitZttSpill(BB, MI.getIterator(), Dst, true, false, Slot->second, RC,
                   Register(), MachineInstr::NoFlags);
      MI.eraseFromParent();
    }
  }
  return true;
}

namespace {
/// Save or reload ACC while preserving borrowed M registers and GPRs.
struct AccImageEmitter {
  MachineFunction &MF;
  MachineBasicBlock &BB;
  MachineBasicBlock::iterator I;
  const RISCVInstrInfo &TII;
  const TargetRegisterInfo &TRI;
  RISCVMachineFunctionInfo &Info;
  unsigned UDS, Count, XBytes;
  SmallVector<Register, 5> Scratch;
  // Payload address, descriptor address, cached/header stride, address scratch,
  // and the complete runtime Md/Ad word, respectively.
  Register Data, Meta, Stride, Temp, Type;
  AccImageEmitter(MachineInstr &MI)
      : MF(*MI.getMF()), BB(*MI.getParent()), I(MI.getIterator()),
        TII(*MF.getSubtarget<RISCVSubtarget>().getInstrInfo()),
        TRI(*MF.getSubtarget().getRegisterInfo()),
        Info(*MF.getInfo<RISCVMachineFunctionInfo>()),
        UDS(MF.getSubtarget<RISCVSubtarget>().getZttUdsBits()),
        Count(MF.getSubtarget<RISCVSubtarget>().getZttMRegs()),
        XBytes(MF.getSubtarget<RISCVSubtarget>().getXLen() / 8),
        Scratch(getZttSpillScratchRegs(MF)), Data(Scratch[0]), Meta(Scratch[1]),
        Stride(Info.ZttMStrideReg ? Register(Info.ZttMStrideReg) : Scratch[2]),
        Temp(Scratch[3]), Type(Scratch[4]) {}

  /// Transfer an XLEN header word or a fixed 32-bit descriptor word.
  void scalar(bool Load, Register Value, Register Base, int Offset,
              unsigned Bytes) {
    unsigned Op = Load ? (Bytes == 8 ? RISCV::LD : RISCV::LW)
                       : (Bytes == 8 ? RISCV::SD : RISCV::SW);
    BuildMI(BB, I, I->getDebugLoc(), TII.get(Op))
        .addReg(Value, Load ? RegState::Define : RegState::NoFlags)
        .addReg(Base)
        .addImm(Offset)
        .addMemOperand(MF.getMachineMemOperand(
            MachinePointerInfo(),
            Load ? MachineMemOperand::MOLoad : MachineMemOperand::MOStore,
            Bytes, Align(Bytes)));
  }
  /// Form the address of a fixed metadata slot.
  void metaAddress(int FI) {
    BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ADDI), Meta)
        .addFrameIndex(FI)
        .addImm(0);
  }
  /// Address an M-sized payload slot without multiplication libcalls.
  void dataAddress(unsigned Offset) {
    BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ADDI), Data)
        .addFrameIndex(Info.ZttMFrameFI)
        .addImm(ZttMFrameHeaderSize);
    for (unsigned B = 0; (Offset >> B) != 0; ++B)
      if (Offset & (1u << B)) {
        BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::SLLI), Temp)
            .addReg(Stride)
            .addImm(B);
        BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ADD), Data)
            .addReg(Data)
            .addReg(Temp);
      }
  }
  /// Set an M square's type and define all its wide registers.
  void mset(unsigned Base, unsigned Width) {
    auto Set = BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ZTT_MSETTYP),
                       RISCV::ZTTM0 + Base)
                   .addReg(Type);
    for (unsigned J = 1; J != Width; ++J)
      Set.addReg(RISCV::ZTTM0 + Base + J, RegState::ImplicitDefine);
  }
  /// Save/restore one physical M payload without accessing continuation Md.
  void raw(bool Load, unsigned M) {
    BuildMI(BB, I, I->getDebugLoc(),
            TII.get(Load ? RISCV::ZTT_MLS_1R : RISCV::ZTT_MSS_1R))
        .addReg(RISCV::ZTTM0 + M, Load ? RegState::Define : RegState::NoFlags)
        .addReg(Data)
        .addMemOperand(MF.getMachineMemOperand(
            MachinePointerInfo(),
            Load ? MachineMemOperand::MOLoad : MachineMemOperand::MOStore,
            LocationSize::beforeOrAfterPointer(), Align(UDS / 8)));
  }
  /// Preserve borrowed state, transfer the entire ACC value, then return all
  /// borrowed registers. State and Live describe the original pseudo boundary.
  void emit(const ZttMLayout &State, const LivePhysRegs &Live, unsigned Group,
            bool Load) {
    auto Layout =
        getZttAccTransferLayout(I->getOperand(2).getImm(), Group, UDS);
    if (!Layout)
      reportFatalUsageError("Ztt ACC spill requires a complete transfer group");
    unsigned Width = Layout->MRegsPerMove;
    const auto &MRI = MF.getRegInfo();
    std::optional<unsigned> Base, Free;
    for (unsigned B = 0; B + Width <= Count; B += Width) {
      bool Reserved = false, Busy = false;
      for (unsigned J = 0; J != Width; ++J) {
        Register R = RISCV::ZTTM0 + B + J;
        Reserved |= MRI.isReserved(R);
        Busy |= !Live.available(MRI, R);
      }
      if (Reserved)
        continue;
      if (!Base)
        Base = B;
      if (!Busy) {
        Free = B;
        break;
      }
    }
    if (!Base)
      reportFatalUsageError("Ztt ACC spill has no borrowable M transfer group");
    if (Free)
      Base = Free;

    // If borrowing busy M, preserve every live M value, including all wide
    // continuation registers. This conservative whole-file protection avoids
    // splitting any live logical M group; dead unknown metadata is not read.
    std::array<bool, 32> Protect{};
    if (!Free)
      for (unsigned M = 0; M != Count; ++M) {
        if (!Live.contains(RISCV::ZTTM0 + M))
          continue;
        unsigned Leader = M;
        while (Leader && State[Leader] == 0)
          --Leader;
        int W = State[Leader];
        if (W <= 0 || !isPowerOf2_32(W) || Leader + W > Count ||
            Leader + W <= M || Leader % W)
          reportFatalUsageError("Ztt ACC spill borrowed M layout is unknown");
        for (unsigned J = 0; J != unsigned(W); ++J) {
          if (State[Leader + J] != (J ? 0 : W))
            reportFatalUsageError(
                "Ztt ACC spill borrowed M layout is inconsistent");
          Protect[Leader + J] = true;
        }
      }

    for (unsigned J = 0; J != 5; ++J) {
      TII.storeRegToStackSlot(BB, I, Scratch[J], false, Info.ZttScratchFIs[J],
                              &RISCV::GPRRegClass, Register());
      if (!Live.contains(Scratch[J]))
        std::prev(I)->getOperand(0).setIsUndef();
    }
    if (!Info.ZttMStrideReg) {
      BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ADDI), Data)
          .addFrameIndex(Info.ZttMFrameFI)
          .addImm(0);
      scalar(true, Stride, Data, XBytes, XBytes);
    }
    metaAddress(Info.ZttAccScratchFI);
    for (unsigned M = 0; M != Count; ++M)
      if (Protect[M]) {
        if (State[M] > 0) {
          BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ZTT_MGETTYP), Type)
              .addReg(RISCV::ZTTM0 + M);
          scalar(false, Type, Meta, M * 4, 4);
        }
        dataAddress(Info.ZttAccScratchOffset + M);
        raw(false, M);
      }

    int FI = I->getOperand(1).getIndex();
    auto Slot =
        llvm::find_if(Info.ZttMSpillSlots, [&](auto S) { return S.FI == FI; });
    assert(Slot != Info.ZttMSpillSlots.end());
    Register AG = I->getOperand(0).getReg();
    Register ABase =
        Group == 1 ? AG : Register(TRI.getSubReg(AG, RISCV::sub_ztta_0));
    unsigned AIndex = ABase - RISCV::ZTTA0;
    if (AIndex + Group > MF.getSubtarget<RISCVSubtarget>().getZttARegs())
      reportFatalUsageError(
          "Ztt ACC spill exceeds the configured register count");
    metaAddress(FI);
    // Restore every Ad before moving any payload: asettyp is destructive.
    for (unsigned A = 0; A != Group; ++A) {
      if (Load) {
        scalar(true, Type, Meta, A * 4, 4);
        BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ZTT_ASETTYP), ABase + A)
            .addReg(Type);
      } else {
        BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ZTT_AGETTYP), Type)
            .addReg(ABase + A);
        scalar(false, Type, Meta, A * 4, 4);
      }
    }
    for (unsigned Batch = 0; Batch != Layout->NumMoves; ++Batch) {
      unsigned A = Batch * Layout->AccsPerMove;
      scalar(true, Type, Meta, A * 4, 4);
      mset(*Base, Width);
      auto Move = [&]() {
        auto B =
            BuildMI(BB, I, I->getDebugLoc(),
                    TII.get(Load ? RISCV::ZTT_MMOV_A_M : RISCV::ZTT_MMOV_M_A));
        if (Load)
          B.addDef(ABase + A).addUse(RISCV::ZTTM0 + *Base);
        else
          B.addDef(RISCV::ZTTM0 + *Base).addUse(ABase + A);
        for (unsigned J = 1; J != Width; ++J)
          B.addReg(RISCV::ZTTM0 + *Base + J,
                   Load ? RegState::Implicit : RegState::ImplicitDefine);
        for (unsigned J = 1; J != Layout->AccsPerMove; ++J)
          B.addReg(ABase + A + J,
                   Load ? RegState::ImplicitDefine : RegState::Implicit);
      };
      if (!Load)
        Move();
      dataAddress(Slot->Offset + Batch * Width);
      for (unsigned J = 0; J != Width; ++J) {
        raw(Load, *Base + J);
        if (J + 1 != Width)
          BuildMI(BB, I, I->getDebugLoc(), TII.get(RISCV::ADD), Data)
              .addReg(Data)
              .addReg(Stride);
      }
      if (Load)
        Move();
    }
    metaAddress(Info.ZttAccScratchFI);
    for (unsigned M = 0; M != Count; ++M)
      if (Protect[M] && State[M] > 0) {
        scalar(true, Type, Meta, M * 4, 4);
        mset(M, State[M]);
      }
    for (unsigned M = 0; M != Count; ++M)
      if (Protect[M]) {
        dataAddress(Info.ZttAccScratchOffset + M);
        raw(true, M);
      }
    for (unsigned J = 0; J != 5; ++J)
      TII.loadRegFromStackSlot(BB, I, Scratch[J], Info.ZttScratchFIs[J],
                               &RISCV::GPRRegClass, Register());
    I->eraseFromParent();
  }
};
} // namespace

bool llvm::expandZttAccSpills(MachineFunction &MF) {
  if (!MF.getInfo<RISCVMachineFunctionInfo>()->ZttHasAccSpills)
    return false;
  auto In = analyzeZttMLayouts(MF);
  const auto &TRI = *MF.getSubtarget().getRegisterInfo();
  for (auto &BB : MF) {
    ZttMLayout State;
    State.fill(-1);
    if (auto It = In.find(&BB); It != In.end())
      State = It->second;
    DenseMap<const MachineInstr *, ZttMLayout> At;
    SmallVector<MachineInstr *> Original;
    for (auto &MI : BB) {
      bool Load;
      if (getZttAccSpillGroup(MI.getOpcode(), Load))
        At[&MI] = State;
      transferZttMLayout(MI, State, TRI);
      Original.push_back(&MI);
    }
    LivePhysRegs Live(TRI);
    Live.addLiveOuts(BB);
    for (auto *MI : llvm::reverse(Original)) {
      Live.stepBackward(*MI);
      bool Load;
      if (unsigned Group = getZttAccSpillGroup(MI->getOpcode(), Load))
        AccImageEmitter(*MI).emit(At.lookup(MI), Live, Group, Load);
    }
  }
  return true;
}
