//===-- RISCVZttSpill.cpp - Ztt spill frames -----------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "RISCVZttSpill.h"
#include "RISCVFrameLowering.h"
#include "RISCVInstrInfo.h"
#include "RISCVMachineFunctionInfo.h"
#include "RISCVSubtarget.h"
#include "RISCVZttRegisterLayout.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"

using namespace llvm;

SmallVector<Register, 5>
llvm::getZttSpillScratchRegs(const MachineFunction &MF) {
  SmallVector<Register, 5> Registers;
  for (MCPhysReg R : RISCV::GPRRegClass) {
    if (!MF.getRegInfo().isReserved(R))
      Registers.push_back(R);
    if (Registers.size() == 5)
      return Registers;
  }
  reportFatalUsageError("Ztt M spill requires five non-reserved GPRs");
}

unsigned llvm::getZttSpillGroup(unsigned Opcode, bool &IsLoad) {
  switch (Opcode) {
#define RISCV_ZTT_M_GROUP(G, Class)                                            \
  case RISCV::PseudoZTTMSpillM##G:                                             \
    IsLoad = false;                                                            \
    return G;                                                                  \
  case RISCV::PseudoZTTMReloadM##G:                                            \
    IsLoad = true;                                                             \
    return G;
#include "RISCVZttRegisterGroups.def"
  default:
    return 0;
  }
}

unsigned llvm::getZttAccSpillGroup(unsigned Opcode, bool &IsLoad) {
  switch (Opcode) {
#define RISCV_ZTT_ACC_GROUP(G, Class)                                          \
  case RISCV::PseudoZTTASpillA##G:                                             \
    IsLoad = false;                                                            \
    return G;                                                                  \
  case RISCV::PseudoZTTAReloadA##G:                                            \
    IsLoad = true;                                                             \
    return G;
#include "RISCVZttRegisterGroups.def"
  default:
    return 0;
  }
}

bool llvm::emitZttSpill(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                        Register Reg, bool IsLoad, bool Kill, int FI,
                        const TargetRegisterClass *RC, Register VReg,
                        MachineInstr::MIFlag Flags) {
  unsigned Group = 0, Spill = 0, Reload = 0;
  auto &MF = *MBB.getParent();
  const auto &ST = MF.getSubtarget<RISCVSubtarget>();
#define RISCV_ZTT_ACC_GROUP(N, Class)                                          \
  if (RISCV::Class.hasSubClassEq(RC)) {                                        \
    Group = N;                                                                 \
    Spill = RISCV::PseudoZTTASpillA##N;                                        \
    Reload = RISCV::PseudoZTTAReloadA##N;                                      \
  }
#include "RISCVZttRegisterGroups.def"
  if (Group) {
    auto Bits = getZttAccElementBits(VReg ? VReg : Reg, MF, ST.getZttUdsBits());
    auto &Saved = MF.getInfo<RISCVMachineFunctionInfo>()->ZttAccSpillBits;
    if (!Bits && Saved.count(FI))
      Bits = Saved.lookup(FI);
    if (!Bits)
      reportFatalUsageError("Ztt ACC spill element width is unavailable");
    if (!getZttAccTransferLayout(*Bits, Group, ST.getZttUdsBits()))
      reportFatalUsageError("Ztt ACC spill requires a complete transfer group");
    Saved[FI] = *Bits;
    auto *MMO = MF.getMachineMemOperand(
        MachinePointerInfo::getFixedStack(MF, FI),
        IsLoad ? MachineMemOperand::MOLoad : MachineMemOperand::MOStore,
        LocationSize::beforeOrAfterPointer(), Align(1));
    BuildMI(MBB, I, DebugLoc(), ST.getInstrInfo()->get(IsLoad ? Reload : Spill))
        .addReg(Reg, IsLoad ? RegState::Define : getKillRegState(Kill))
        .addFrameIndex(FI)
        .addImm(*Bits)
        .addMemOperand(MMO)
        .setMIFlag(Flags);
    return true;
  }
#define RISCV_ZTT_M_GROUP(N, Class)                                            \
  if (RISCV::Class.hasSubClassEq(RC)) {                                        \
    Group = N;                                                                 \
    Spill = RISCV::PseudoZTTMSpillM##N;                                        \
    Reload = RISCV::PseudoZTTMReloadM##N;                                      \
  }
#include "RISCVZttRegisterGroups.def"
  if (!Group)
    return false;
  auto &MRI = MF.getRegInfo();
  const auto *TII = ST.getInstrInfo();
  // Recover the value's square width, not merely the register-class size.
  // COPY/PHI webs include allocator splits and PHI elimination.
  SmallVector<Register> Worklist{VReg ? VReg : Reg};
  SmallSet<Register, 16> Visited;
  unsigned Width = 0;
  auto Remember = [&](unsigned W) {
    if (!W || W > Group || !isPowerOf2_32(W) || (Width && Width != W))
      report_fatal_error("inconsistent Ztt M spill square layout");
    Width = W;
  };
  while (!Worklist.empty()) {
    Register R = Worklist.pop_back_val();
    if (!Visited.insert(R).second)
      continue;
    if (R.isPhysical()) {
      Register Base = R;
      if (!RISCV::ZTTMRRegClass.contains(Base))
        Base = ST.getRegisterInfo()->getSubReg(Base, RISCV::sub_zttm_0);
      auto Args = MF.getInfo<RISCVMachineFunctionInfo>()->getZttMArgLayout();
      if (RISCV::ZTTMRRegClass.contains(Base) && Args.size() == 32 &&
          Args[Base - RISCV::ZTTM0] > 0)
        Remember(Args[Base - RISCV::ZTTM0]);
      continue;
    }
    for (MachineInstr &Def : MRI.def_instructions(R)) {
      int Index = -1;
      for (auto Name :
           {RISCV::OpName::regs_per_square, RISCV::OpName::regs_per_unit,
            RISCV::OpName::mregs_per_square}) {
        Index = RISCV::getNamedOperandIdx(Def.getOpcode(), Name);
        if (Index >= 0)
          break;
      }
      if (Index >= 0 && Def.getOperand(Index).isImm())
        Remember(Def.getOperand(Index).getImm());
      else if (Def.isCopy())
        Worklist.push_back(Def.getOperand(1).getReg());
      else if (Def.isPHI())
        for (unsigned J = 1; J < Def.getNumOperands(); J += 2)
          Worklist.push_back(Def.getOperand(J).getReg());
    }
  }
  auto &Widths = MF.getInfo<RISCVMachineFunctionInfo>()->ZttSpillWidths;
  if (!Width)
    Width = Widths.lookup(FI);
  if (!Width)
    report_fatal_error("Ztt M spill square layout is unavailable");
  Widths[FI] = Width;
  auto *MMO = MF.getMachineMemOperand(
      MachinePointerInfo::getFixedStack(MF, FI),
      IsLoad ? MachineMemOperand::MOLoad : MachineMemOperand::MOStore,
      LocationSize::beforeOrAfterPointer(), Align(1));
  BuildMI(MBB, I, DebugLoc(), TII->get(IsLoad ? Reload : Spill))
      .addReg(Reg, IsLoad ? RegState::Define : getKillRegState(Kill))
      .addFrameIndex(FI)
      .addImm(Width)
      .addMemOperand(MMO)
      .setMIFlag(Flags);
  return true;
}

bool llvm::prepareZttSpillFrame(MachineFunction &MF) {
  auto &Info = *MF.getInfo<RISCVMachineFunctionInfo>();
  auto &Frame = MF.getFrameInfo();
  for (auto &MBB : MF)
    for (auto &MI : MBB) {
      bool IsLoad;
      unsigned Group = getZttSpillGroup(MI.getOpcode(), IsLoad);
      unsigned Units = Group;
      if (!Group) {
        Group = getZttAccSpillGroup(MI.getOpcode(), IsLoad);
        if (Group) {
          auto L = getZttAccTransferLayout(
              MI.getOperand(2).getImm(), Group,
              MF.getSubtarget<RISCVSubtarget>().getZttUdsBits());
          if (!L)
            reportFatalUsageError(
                "Ztt ACC spill requires a complete transfer group");
          Units = L->Units;
          Info.ZttHasAccSpills = true;
        }
      }
      if (!Group)
        continue;
      int FI = MI.getOperand(1).getIndex();
      auto It = llvm::find_if(Info.ZttMSpillSlots,
                              [&](auto S) { return S.FI == FI; });
      if (It != Info.ZttMSpillSlots.end()) {
        // Slot coloring may reuse the image for a different element width,
        // or even another register class. Reserve the largest payload/metadata
        // capacity while each operation retains its own actual layout.
        It->Group = std::max(It->Group, Group);
        It->Units = std::max(It->Units, Units);
        continue;
      }
      Info.ZttMSpillSlots.push_back({FI, Group, 0, Units});
    }
  for (auto &Slot : Info.ZttMSpillSlots) {
    Slot.Offset = Info.ZttMSpillUnits;
    Info.ZttMSpillUnits += Slot.Units;
    // A colored M/ACC slot can also hold scalar spills at other times. Grow
    // it for Md/Ad, but preserve the capacity and alignment of every other
    // occupant. Only valid square leaders are transferred for M images.
    Frame.setObjectSize(Slot.FI, std::max<int64_t>(Frame.getObjectSize(Slot.FI),
                                                   Slot.Group * 4));
    Frame.setObjectAlignment(Slot.FI,
                             std::max(Frame.getObjectAlign(Slot.FI), Align(4)));
  }
  if (Info.ZttHasAccSpills) {
    unsigned Count = MF.getSubtarget<RISCVSubtarget>().getZttMRegs();
    Info.ZttAccScratchOffset = Info.ZttMSpillUnits;
    Info.ZttMSpillUnits += Count;
    Info.ZttAccScratchFI = Frame.CreateStackObject(Count * 4, Align(4), false);
  }
  if (!Info.hasZttMSpills())
    return false;
  if (MF.getFunction().hasFnAttribute("interrupt") ||
      MF.getFunction().getCallingConv() == CallingConv::GHC)
    reportFatalUsageError(
        "Ztt M spill in special-entry functions is not supported");
  // The first frame implementation must not silently misaddress incoming
  // stack arguments or emit ordinary CFA rules for a runtime-sized frame.
  if (Frame.getNumFixedObjects() || Frame.hasVarSizedObjects() ||
      Frame.isFrameAddressTaken() || MF.needsFrameMoves() ||
      MF.getFunction().isVarArg() ||
      MF.getFunction().hasFnAttribute("probe-stack"))
    reportFatalUsageError(
        "Ztt M spill with incoming stack objects, dynamic alloca, "
        "frame address, unwind information or stack probing is "
        "not yet supported");
  Info.ZttMFrameFI = Frame.CreateFixedObject(ZttMFrameHeaderSize, 0, false);
  // Allocation is complete. Only an entirely unused saved GPR may become a
  // persistent cache; lack of one is normal and retains the header fallback.
  auto &MRI = MF.getRegInfo();
  const auto &TRI = *MF.getSubtarget().getRegisterInfo();
  const uint32_t *Preserved =
      TRI.getCallPreservedMask(MF, MF.getFunction().getCallingConv());
  unsigned Borrowable = llvm::count_if(
      RISCV::GPRRegClass, [&](MCPhysReg R) { return !MRI.isReserved(R); });
  for (const MCPhysReg *R = MRI.getCalleeSavedRegs(); *R; ++R) {
    // A cache must not consume one of the five temporary registers needed by
    // the fallback, including configurations with many user-fixed registers.
    if (Borrowable <= 5)
      break;
    if (!RISCV::GPRRegClass.contains(*R) || MRI.isReserved(*R) ||
        MRI.isPhysRegUsed(*R) || !Preserved ||
        MachineOperand::clobbersPhysReg(Preserved, *R))
      continue;
    if (llvm::any_of(MF, [&](const auto &BB) {
          return llvm::any_of(BB.liveins(), [&](auto L) {
            return TRI.regsOverlap(*R, L.PhysReg);
          });
        }))
      continue;
    Info.ZttMStrideReg = *R;
    // Protect the new cache from later scavenging, including paired aliases.
    MRI.freezeReservedRegs();
    break;
  }
  unsigned Bytes = MF.getSubtarget<RISCVSubtarget>().getXLen() / 8;
  for (unsigned I = 0; I != 5; ++I)
    Info.ZttScratchFIs.push_back(
        Frame.CreateStackObject(Bytes, Align(Bytes), false));
  return true;
}

namespace {
/// Raw temporary-stack operations are used only around prologue/epilogue,
/// outside the ordinary frame. They preserve every borrowed argument GPR.
struct FrameEmitter {
  MachineFunction &MF;
  MachineBasicBlock &MBB;
  MachineBasicBlock::iterator I;
  const RISCVInstrInfo &TII;
  unsigned Bytes;
  MachineInstr::MIFlag Flag;
  SmallVector<Register, 5> R;
  FrameEmitter(MachineFunction &MF, MachineBasicBlock &MBB,
               MachineBasicBlock::iterator I,
               MachineInstr::MIFlag Flag = MachineInstr::NoFlags)
      : MF(MF), MBB(MBB), I(I),
        TII(*MF.getSubtarget<RISCVSubtarget>().getInstrInfo()),
        Bytes(MF.getSubtarget<RISCVSubtarget>().getXLen() / 8), Flag(Flag),
        R(getZttSpillScratchRegs(MF)) {}
  void imm(unsigned Opc, Register D, Register S, int64_t V) {
    BuildMI(MBB, I, DebugLoc(), TII.get(Opc), D)
        .addReg(S)
        .addImm(V)
        .setMIFlag(Flag);
  }
  void reg(unsigned Opc, Register D, Register L, Register R) {
    BuildMI(MBB, I, DebugLoc(), TII.get(Opc), D)
        .addReg(L)
        .addReg(R)
        .setMIFlag(Flag);
  }
  void memory(bool Load, Register Value, Register Base, int Offset,
              bool Undef = false) {
    unsigned Opc = Load ? (Bytes == 8 ? RISCV::LD : RISCV::LW)
                        : (Bytes == 8 ? RISCV::SD : RISCV::SW);
    auto B = BuildMI(MBB, I, DebugLoc(), TII.get(Opc));
    B.setMIFlag(Flag);
    B.addReg(Value, Load ? RegState::Define : getUndefRegState(Undef))
        .addReg(Base)
        .addImm(Offset);
    B.addMemOperand(MF.getMachineMemOperand(MachinePointerInfo(),
                                            Load ? MachineMemOperand::MOLoad
                                                 : MachineMemOperand::MOStore,
                                            Bytes, Align(Bytes)));
  }
};
} // namespace

void llvm::emitZttFixedSPAdjustment(MachineFunction &MF, MachineBasicBlock &MBB,
                                    MachineBasicBlock::iterator I,
                                    int64_t Offset, MachineInstr::MIFlag Flag) {
  assert((Offset <= -4096 || Offset > 2048) &&
         "expected a large SP adjustment");
  FrameEmitter E(MF, MBB, I, Flag);
  constexpr Register SP = RISCV::X2;
  Register Value = E.R[0], Address = E.R[1];
  LivePhysRegs Live(*MF.getSubtarget().getRegisterInfo());
  Live.addLiveOuts(MBB);
  for (auto It = MBB.end(); It != I;)
    Live.stepBackward(*--It);

  // Use newly allocated temporary space, never the Ztt header at incoming SP.
  E.imm(RISCV::ADDI, SP, SP, -16);
  E.memory(false, Value, SP, 0, !Live.contains(Value));
  if (Offset < 0) {
    // Keep the distance to the saved word in Value until SP reaches its final
    // position; the reload remains within the allocated frame at all times.
    E.TII.movImm(MBB, I, DebugLoc(), Value, -(Offset + 16), Flag);
    E.reg(RISCV::SUB, SP, SP, Value);
    E.reg(RISCV::ADD, Value, SP, Value);
    E.memory(true, Value, Value, 0);
    return;
  }

  E.memory(false, Address, SP, E.Bytes, !Live.contains(Address));
  E.TII.movImm(MBB, I, DebugLoc(), Value, Offset, Flag);
  // Before releasing the fixed frame, move both borrowed values into its last
  // 16 bytes. Reload there before raising SP to the exact final address.
  E.reg(RISCV::ADD, Address, SP, Value);
  E.memory(true, Value, SP, 0);
  E.memory(false, Value, Address, 0);
  E.memory(true, Value, SP, E.Bytes);
  E.memory(false, Value, Address, E.Bytes);
  E.imm(RISCV::ADDI, SP, Address, 0);
  E.memory(true, Value, SP, 0);
  E.memory(true, Address, SP, E.Bytes);
  E.imm(RISCV::ADDI, SP, SP, 16);
}

void llvm::emitZttStrideCache(MachineFunction &MF, MachineBasicBlock &MBB,
                              MachineBasicBlock::iterator I) {
  const auto &Info = *MF.getInfo<RISCVMachineFunctionInfo>();
  if (!Info.ZttMStrideReg)
    return;
  const auto &ST = MF.getSubtarget<RISCVSubtarget>();
  const auto &TII = *ST.getInstrInfo();
  unsigned Bytes = ST.getXLen() / 8;
  BuildMI(MBB, I, DebugLoc(), TII.get(Bytes == 8 ? RISCV::LD : RISCV::LW),
          Info.ZttMStrideReg)
      .addFrameIndex(Info.ZttMFrameFI)
      .addImm(Bytes)
      .addMemOperand(MF.getMachineMemOperand(MachinePointerInfo(),
                                             MachineMemOperand::MOLoad, Bytes,
                                             Align(Bytes)));
}

void llvm::emitZttFrameAllocation(MachineFunction &MF, MachineBasicBlock &MBB) {
  const auto &Info = *MF.getInfo<RISCVMachineFunctionInfo>();
  FrameEmitter E(MF, MBB, MBB.begin());
  constexpr Register SP = RISCV::X2;
  // 16-byte header plus 48-byte tail. The tail keeps the saved scratch words
  // disjoint from the header/payload even for the smallest runtime N.
  unsigned Temporary = alignTo(5 * E.Bytes, 16);
  LivePhysRegs Live(*MF.getSubtarget().getRegisterInfo());
  Live.addLiveIns(MBB);
  E.imm(RISCV::ADDI, SP, SP, -int(Temporary));
  for (unsigned J = 0; J != 5; ++J)
    E.memory(false, E.R[J], SP, J * E.Bytes, !Live.contains(E.R[J]));
  auto Size =
      BuildMI(MBB, E.I, DebugLoc(), E.TII.get(RISCV::PseudoZTTMFrameSize));
  for (unsigned J = 0; J != 5; ++J)
    Size.addReg(E.R[J], RegState::Define | RegState::EarlyClobber);
  Size.addImm(Info.ZttMSpillUnits).addImm(16);
  expandZttFrameSize(*Size);
  E.imm(RISCV::ADDI, E.R[0], E.R[0],
        ZttMFrameHeaderSize + ZttMFrameScratchTailSize);
  E.imm(RISCV::ADDI, E.R[4], SP, 0);
  E.reg(RISCV::SUB, SP, SP, E.R[0]);
  // ILP32E permits only four-byte incoming stack alignment. Align the arena,
  // and cache the actual adjustment including padding so return restores the
  // exact incoming SP. Ordinary 16-byte-aligned ABIs need neither instruction.
  if (MF.getSubtarget<RISCVSubtarget>().getFrameLowering()->getStackAlign() <
      Align(ZttMFrameHeaderSize)) {
    E.imm(RISCV::ANDI, SP, SP, -int(ZttMFrameHeaderSize));
    E.reg(RISCV::SUB, E.R[0], E.R[4], SP);
  }
  E.memory(false, E.R[0], SP, Temporary);
  E.memory(false, E.R[1], SP, Temporary + E.Bytes);
  for (unsigned J = 0; J != 5; ++J)
    E.memory(true, E.R[J], E.R[4], J * E.Bytes);
  E.imm(RISCV::ADDI, SP, SP, Temporary);
}

void llvm::emitZttFrameDeallocation(MachineFunction &MF,
                                    MachineBasicBlock &MBB) {
  FrameEmitter E(MF, MBB, MBB.getFirstTerminator());
  constexpr Register SP = RISCV::X2;
  // The ordinary frame has already been restored: SP addresses the header.
  // Move borrowed values to the reserved tail before raising SP, so no reload
  // ever accesses memory below the current SP (including interrupt windows).
  E.imm(RISCV::ADDI, SP, SP, -16);
  LivePhysRegs Live(*MF.getSubtarget().getRegisterInfo());
  Live.addLiveOuts(MBB);
  for (auto I = MBB.end(); I != E.I;)
    Live.stepBackward(*--I);
  E.memory(false, E.R[0], SP, 0, !Live.contains(E.R[0]));
  E.memory(false, E.R[1], SP, E.Bytes, !Live.contains(E.R[1]));
  E.memory(true, E.R[0], SP, 16);
  E.reg(RISCV::ADD, E.R[1], SP, E.R[0]);
  E.memory(true, E.R[0], SP, 0);
  E.memory(false, E.R[0], E.R[1], 0);
  E.memory(true, E.R[0], SP, E.Bytes);
  E.memory(false, E.R[0], E.R[1], E.Bytes);
  E.imm(RISCV::ADDI, SP, E.R[1], 0);
  E.memory(true, E.R[0], SP, 0);
  E.memory(true, E.R[1], SP, E.Bytes);
  E.imm(RISCV::ADDI, SP, SP, 16);
}
