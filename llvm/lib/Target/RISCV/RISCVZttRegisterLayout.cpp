//===-- RISCVZttRegisterLayout.cpp - Ztt physical layouts
//-------------------===//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#include "RISCVZttRegisterLayout.h"
#include "RISCVInstrInfo.h"
#include "RISCVMachineFunctionInfo.h"
#include "RISCVSubtarget.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"

using namespace llvm;

std::optional<unsigned> llvm::getZttAccElementBits(Register Reg,
                                                   const MachineFunction &MF,
                                                   unsigned UdsBits) {
  const auto &MRI = MF.getRegInfo();
  SmallVector<Register> Worklist{Reg};
  SmallSet<Register, 16> Visited;
  std::optional<unsigned> Bits;
  auto Remember = [&](int64_t B) {
    if (B < 4 || B > 128 || !isPowerOf2_64(B) || (Bits && *Bits != B))
      return false;
    Bits = B;
    return true;
  };
  while (!Worklist.empty()) {
    Register R = Worklist.pop_back_val();
    if (!Visited.insert(R).second)
      continue;
    // ACC arguments have no supported ABI/type seed. Never guess their width.
    if (!R.isVirtual() || MRI.def_empty(R))
      return std::nullopt;
    const auto *RC = MRI.getRegClass(R);
    if (!RISCV::ZTTARRegClass.hasSubClassEq(RC) &&
        !RISCV::ZTTARM2RegClass.hasSubClassEq(RC) &&
        !RISCV::ZTTARM4RegClass.hasSubClassEq(RC) &&
        !RISCV::ZTTARM8RegClass.hasSubClassEq(RC) &&
        !RISCV::ZTTARM16RegClass.hasSubClassEq(RC))
      return std::nullopt;
    for (const MachineInstr &Def : MRI.def_instructions(R)) {
      int Index = RISCV::getNamedOperandIdx(Def.getOpcode(),
                                            RISCV::OpName::element_bits);
      if (Index >= 0) {
        if (!Def.getOperand(Index).isImm() ||
            !Remember(Def.getOperand(Index).getImm()))
          return std::nullopt;
        continue;
      }
      int M = RISCV::getNamedOperandIdx(Def.getOpcode(),
                                        RISCV::OpName::mregs_per_square);
      int A = RISCV::getNamedOperandIdx(Def.getOpcode(),
                                        RISCV::OpName::accs_per_move);
      if (M >= 0 && A >= 0) {
        if (!Def.getOperand(M).isImm() || !Def.getOperand(A).isImm())
          return std::nullopt;
        int64_t MR = Def.getOperand(M).getImm();
        int64_t AR = Def.getOperand(A).getImm();
        if (MR < 1 || MR > 32 || AR < 1 || AR > 16 || !isPowerOf2_64(MR) ||
            !isPowerOf2_64(AR) || (MR > 1 && AR > 1) || !UdsBits ||
            UdsBits > 128 || !isPowerOf2_32(UdsBits) || (UdsBits * MR) % AR ||
            !Remember(UdsBits * MR / AR))
          return std::nullopt;
        continue;
      }
      if (Def.isCopy()) {
        Worklist.push_back(Def.getOperand(1).getReg());
        continue;
      }
      if (Def.isPHI()) {
        for (unsigned I = 1; I < Def.getNumOperands(); I += 2)
          Worklist.push_back(Def.getOperand(I).getReg());
        continue;
      }
      // Matmul keeps its input ACC type; follow the tied operand.
      int DefIndex = Def.findRegisterDefOperandIdx(R, nullptr);
      if (DefIndex >= 0 && Def.getOperand(DefIndex).isTied()) {
        Worklist.push_back(
            Def.getOperand(Def.findTiedOperandIdx(DefIndex)).getReg());
        continue;
      }
      return std::nullopt;
    }
  }
  return Bits;
}

std::optional<ZttAccTransferLayout>
llvm::getZttAccTransferLayout(unsigned ElementBits, unsigned Squares,
                              unsigned UdsBits) {
  if (ElementBits < 4 || ElementBits > 128 || UdsBits < 8 || UdsBits > 128 ||
      Squares < 1 || Squares > 16 || !isPowerOf2_32(ElementBits) ||
      !isPowerOf2_32(UdsBits) || !isPowerOf2_32(Squares))
    return std::nullopt;
  unsigned M = std::max(1u, ElementBits / UdsBits);
  unsigned A = std::max(1u, UdsBits / ElementBits);
  if (Squares % A)
    return std::nullopt;
  return ZttAccTransferLayout{M, A, Squares / A, Squares / A * M};
}

const TargetRegisterClass *llvm::getZttMRegisterClass(unsigned Group) {
  switch (Group) {
#define RISCV_ZTT_M_GROUP(Size, Class)                                         \
  case Size:                                                                   \
    return &RISCV::Class;
#include "RISCVZttRegisterGroups.def"
  default:
    return nullptr;
  }
}

const TargetRegisterClass *llvm::getZttAccRegisterClass(unsigned Group) {
  switch (Group) {
#define RISCV_ZTT_ACC_GROUP(Size, Class)                                       \
  case Size:                                                                   \
    return &RISCV::Class;
#include "RISCVZttRegisterGroups.def"
  default:
    return nullptr;
  }
}

unsigned llvm::getZttMGroupSize(Register Reg) {
#define RISCV_ZTT_M_GROUP(Size, Class)                                         \
  if (RISCV::Class.contains(Reg))                                              \
    return Size;
#include "RISCVZttRegisterGroups.def"
  return 0;
}

unsigned llvm::getZttAccGroupSize(Register Reg) {
#define RISCV_ZTT_ACC_GROUP(Size, Class)                                       \
  if (RISCV::Class.contains(Reg))                                              \
    return Size;
#include "RISCVZttRegisterGroups.def"
  return 0;
}

void llvm::transferZttAccLayout(const MachineInstr &MI, ZttAccLayout &State,
                                const TargetRegisterInfo &TRI,
                                unsigned UdsBits) {
  auto Base = [&](Register R) {
    return unsigned((getZttAccGroupSize(R) == 1
                         ? R
                         : Register(TRI.getSubReg(R, RISCV::sub_ztta_0))) -
                    RISCV::ZTTA0);
  };
  const ZttAccLayout Before = State;
  // Invalidate unmodelled definitions and regmask clobbers first. Typed
  // producers, COPY and tied updates below restore only the known entries.
  for (const MachineOperand &MO : MI.operands()) {
    if (MO.isRegMask()) {
      for (unsigned I = 0; I != State.size(); ++I)
        if (MO.clobbersPhysReg(RISCV::ZTTA0 + I))
          State[I] = -1;
    } else if (MO.isReg() && MO.isDef()) {
      if (unsigned Group = getZttAccGroupSize(MO.getReg()))
        std::fill_n(State.begin() + Base(MO.getReg()), Group, -1);
    }
  }
  if (!MI.getNumExplicitDefs() || !MI.getOperand(0).isReg())
    return;
  Register Dst = MI.getOperand(0).getReg();
  unsigned Group = getZttAccGroupSize(Dst);
  if (!Group)
    return;
  unsigned D = Base(Dst);
  int64_t Bits = -1;
  int E =
      RISCV::getNamedOperandIdx(MI.getOpcode(), RISCV::OpName::element_bits);
  int M = RISCV::getNamedOperandIdx(MI.getOpcode(),
                                    RISCV::OpName::mregs_per_square);
  int A =
      RISCV::getNamedOperandIdx(MI.getOpcode(), RISCV::OpName::accs_per_move);
  if (E >= 0 && MI.getOperand(E).isImm())
    Bits = MI.getOperand(E).getImm();
  else if (M >= 0 && A >= 0 && MI.getOperand(M).isImm() &&
           MI.getOperand(A).isImm()) {
    int64_t MR = MI.getOperand(M).getImm(), AR = MI.getOperand(A).getImm();
    if (MR > 0 && MR <= 32 && AR > 0 && AR <= 16 && isPowerOf2_64(MR) &&
        isPowerOf2_64(AR) && (MR == 1 || AR == 1) && !(UdsBits * MR % AR))
      Bits = UdsBits * MR / AR;
  } else if (MI.isCopy() || MI.getOperand(0).isTied()) {
    unsigned Use = MI.isCopy() ? 1 : MI.findTiedOperandIdx(0);
    Register Src = MI.getOperand(Use).getReg();
    if (getZttAccGroupSize(Src) == Group)
      std::copy_n(Before.begin() + Base(Src), Group, State.begin() + D);
    return;
  }
  if (Bits >= 4 && Bits <= 128 && isPowerOf2_32(Bits))
    std::fill_n(State.begin() + D, Group, Bits);
}

static unsigned baseIndex(Register R, const TargetRegisterInfo &TRI) {
  unsigned Group = getZttMGroupSize(R);
  assert(Group && "expected M register");
  Register Base =
      Group == 1 ? R : Register(TRI.getSubReg(R, RISCV::sub_zttm_0));
  return unsigned(Base - RISCV::ZTTM0);
}

void llvm::transferZttMLayout(const MachineInstr &MI, ZttMLayout &State,
                              const TargetRegisterInfo &TRI) {
  if (MI.isCopy() && getZttMGroupSize(MI.getOperand(0).getReg())) {
    Register Dst = MI.getOperand(0).getReg();
    Register Src = MI.getOperand(1).getReg();
    unsigned Group = getZttMGroupSize(Dst), D = baseIndex(Dst, TRI);
    if (getZttMGroupSize(Src) != Group) {
      std::fill_n(State.begin() + D, Group, -1);
      return;
    }
    ZttMLayout Before = State;
    std::copy_n(Before.begin() + baseIndex(Src, TRI), Group, State.begin() + D);
    return;
  }
  if (MI.getOpcode() == RISCV::ZTT_MSETTYP) {
    unsigned D = baseIndex(MI.getOperand(0).getReg(), TRI);
    unsigned Width = 1;
    for (const MachineOperand &MO : MI.implicit_operands())
      if (MO.isReg() && MO.isDef() && getZttMGroupSize(MO.getReg())) {
        if (getZttMGroupSize(MO.getReg()) != 1 ||
            baseIndex(MO.getReg(), TRI) != D + Width)
          report_fatal_error("invalid Ztt msettyp square layout");
        ++Width;
      }
    if (!isPowerOf2_32(Width) || D + Width > State.size())
      report_fatal_error("invalid Ztt msettyp square layout");
    State[D] = Width;
    std::fill_n(State.begin() + D + 1, Width - 1, 0);
    return;
  }
  // These instructions change data, but preserve the already-set Md.
  if (RISCVZttInstrInfo::getMDPreservingInfo(MI.getOpcode()))
    return;
  // A clobber or an unmodelled definition invalidates only affected M
  // registers. In particular, do not propagate metadata across a call.
  for (const MachineOperand &MO : MI.operands()) {
    if (MO.isRegMask()) {
      for (unsigned I = 0; I != State.size(); ++I)
        if (MO.clobbersPhysReg(RISCV::ZTTM0 + I))
          State[I] = -1;
    } else if (MO.isReg() && MO.isDef() && getZttMGroupSize(MO.getReg())) {
      unsigned D = baseIndex(MO.getReg(), TRI);
      std::fill_n(State.begin() + D, getZttMGroupSize(MO.getReg()), -1);
    }
  }
}

/// Combine predecessor layouts until every reachable block is stable.
template <typename Layout, typename Transfer>
static DenseMap<const MachineBasicBlock *, Layout>
analyzeLayouts(MachineFunction &MF, const Layout &Entry, Transfer Apply) {
  // Ignore unvisited predecessors so loop inputs keep their known layout.
  DenseMap<const MachineBasicBlock *, Layout> In, Out;
  bool Changed;
  do {
    Changed = false;
    for (MachineBasicBlock &MBB : MF) {
      std::optional<Layout> State;
      if (&MBB == &MF.front())
        State = Entry;
      for (MachineBasicBlock *Pred : MBB.predecessors()) {
        auto It = Out.find(Pred);
        if (It == Out.end())
          continue;
        if (!State)
          State = It->second;
        else
          for (unsigned I = 0; I != State->size(); ++I)
            if ((*State)[I] != It->second[I])
              (*State)[I] = -1;
      }
      if (!State)
        continue;
      In[&MBB] = *State;
      for (const MachineInstr &MI : MBB)
        Apply(MI, *State);
      auto It = Out.find(&MBB);
      if (It == Out.end() || It->second != *State) {
        Out[&MBB] = *State;
        Changed = true;
      }
    }
  } while (Changed);

  return In;
}

ZttMBlockLayouts llvm::analyzeZttMLayouts(MachineFunction &MF) {
  ZttMLayout Entry;
  Entry.fill(-1);
  ArrayRef<int> Args =
      MF.getInfo<RISCVMachineFunctionInfo>()->getZttMArgLayout();
  if (!Args.empty()) {
    if (Args.size() != Entry.size())
      report_fatal_error("invalid Ztt M argument layout");
    llvm::copy(Args, Entry.begin());
  }
  return analyzeLayouts(
      MF, Entry, [&](const MachineInstr &MI, ZttMLayout &State) {
        transferZttMLayout(MI, State, *MF.getSubtarget().getRegisterInfo());
      });
}

ZttAccBlockLayouts llvm::analyzeZttAccLayouts(MachineFunction &MF) {
  ZttAccLayout Entry;
  Entry.fill(-1);
  const auto &ST = MF.getSubtarget<RISCVSubtarget>();
  return analyzeLayouts(MF, Entry,
                        [&](const MachineInstr &MI, ZttAccLayout &State) {
                          transferZttAccLayout(MI, State, *ST.getRegisterInfo(),
                                               ST.getZttUdsBits());
                        });
}
