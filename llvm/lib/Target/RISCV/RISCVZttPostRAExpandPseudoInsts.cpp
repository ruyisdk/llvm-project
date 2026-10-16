//===-- RISCVZttPostRAExpandPseudoInsts.cpp - Expand Ztt pseudos ----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/RISCVBaseInfo.h"
#include "RISCV.h"
#include "RISCVInstrInfo.h"
#include "RISCVMachineFunctionInfo.h"
#include "RISCVSubtarget.h"
#include "RISCVZttRegisterLayout.h"
#include "llvm/CodeGen/LivePhysRegs.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/RegisterClassInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include <optional>

using namespace llvm;

namespace {

static constexpr unsigned ZttMSubRegs[] = {
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
static constexpr unsigned ZttASubRegs[] = {
    RISCV::sub_ztta_0, RISCV::sub_ztta_1, RISCV::sub_ztta_2, RISCV::sub_ztta_3,
    RISCV::sub_ztta_4, RISCV::sub_ztta_5, RISCV::sub_ztta_6, RISCV::sub_ztta_7};

class RISCVZttPostRAExpandPseudo : public MachineFunctionPass {
public:
  static char ID;
  RISCVZttPostRAExpandPseudo() : MachineFunctionPass(ID) {
    initializeRISCVZttPostRAExpandPseudoPass(*PassRegistry::getPassRegistry());
  }

  bool runOnMachineFunction(MachineFunction &MF) override;
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addPreserved<MachineRegisterClassInfoWrapperPass>();
    MachineFunctionPass::getAnalysisUsage(AU);
  }
  StringRef getPassName() const override {
    return "RISC-V Ztt post-regalloc pseudo instruction expansion pass";
  }

private:
  const RISCVInstrInfo *TII;
  const TargetRegisterInfo *TRI;

  // Accumulate M slices into the first ACC square; keep the full ACC
  // read/write.
  bool expandMatmul(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                    unsigned AccGroup, unsigned LGroup, unsigned RGroup,
                    unsigned Opcode);

  // Set AMESTYPE for data-scalar operations that read it.
  void emitScalarType(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                      Register SType);
  // Expand matrix, scalar and old-result operations one slice at a time.
  bool expandSlice(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                   const RISCVZttInstrInfo::PseudoInfo &P,
                   const RISCVZttInstrInfo::OperationInfo &Info);

  // A matrix source slice; extract also supplies its selected base and width.
  struct MInput {
    Register Reg;
    unsigned Group;
    unsigned Base = 0;
    unsigned Width = 0;
  };
  // Emit slices and their full register uses/definitions after metadata setup.
  void emitMOperations(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                       unsigned Opcode, Register Dst, unsigned DGroup,
                       unsigned NumOps, ArrayRef<MInput> Sources,
                       ArrayRef<Register> Scalars = {});
  bool expandMemory(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                    unsigned GroupSize, unsigned MemoryOpcode, bool IsLoad,
                    bool Strided);
  bool expandMCopy(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                   unsigned GroupSize);
  bool expandMConcat(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                     unsigned GroupSize);
  bool expandCrossCopy(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                       unsigned AccGroup, unsigned MGroup, bool IsM2A);
  bool expandMextract(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                      unsigned DGroup, unsigned S0Group);

  // Resolve a physical register within an M or ACC group.
  Register getMReg(Register Group, unsigned GroupSize, unsigned Index) const;
  Register getAReg(Register Group, unsigned GroupSize, unsigned Index) const;
  // Remove identity copies and reject other overlapping groups.
  bool needsMCopy(Register DstGroup, Register SrcGroup) const;
  // Set a square's metadata, including implicit definitions of wide tails.
  void emitMSetTyp(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                   Register Group, unsigned GroupSize, unsigned Base,
                   unsigned RegsPerSquare, Register DType);
  // Copy one square. Read source metadata unless DType supplies it.
  void emitMCopySquare(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                       Register Scratch, Register DstGroup,
                       unsigned DstGroupSize, unsigned DstBase,
                       Register SrcGroup, unsigned SrcGroupSize,
                       unsigned SrcBase, unsigned RegsPerSquare,
                       Register DType = Register());
  // Expand internal COPYs using layouts exposed by datatype-setting operations.
  bool expandMCopies(MachineFunction &MF);
  bool expandMI(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI);
  bool expandZero(MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
                  unsigned GroupSize, bool IsAcc);
  bool expandMSetTyp(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                     unsigned GroupSize);
  bool expandAClear(MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI,
                    unsigned GroupSize);
};

char RISCVZttPostRAExpandPseudo::ID = 0;

bool RISCVZttPostRAExpandPseudo::expandMCopies(MachineFunction &MF) {
  auto BaseIndex = [&](Register R) {
    unsigned Group = getZttMGroupSize(R);
    assert(Group && "expected M register");
    return unsigned(getMReg(R, Group, 0) - RISCV::ZTTM0);
  };
  auto IsMCopy = [](const MachineInstr &MI) {
    return MI.isCopy() && getZttMGroupSize(MI.getOperand(0).getReg());
  };
  if (!llvm::any_of(MF, [&](const MachineBasicBlock &MBB) {
        return llvm::any_of(MBB, IsMCopy);
      }))
    return false;

  const auto In = analyzeZttMLayouts(MF);

  DenseMap<const MachineInstr *, unsigned> CopyWidths;
  for (MachineBasicBlock &MBB : MF) {
    ZttMLayout State;
    State.fill(-1);
    if (auto It = In.find(&MBB); It != In.end())
      State = It->second;
    for (MachineInstr &MI : MBB) {
      if (IsMCopy(MI)) {
        Register Dst = MI.getOperand(0).getReg();
        Register Src = MI.getOperand(1).getReg();
        unsigned Group = getZttMGroupSize(Dst);
        if (needsMCopy(Dst, Src)) {
          if (getZttMGroupSize(Src) != Group)
            report_fatal_error("Ztt M COPY requires equal M register groups");
          unsigned S = BaseIndex(Src);
          int Width = State[S];
          if (Width <= 0 || !isPowerOf2_32(Width) || unsigned(Width) > Group ||
              Group % Width)
            report_fatal_error("Ztt M COPY source square layout is unknown");
          for (unsigned I = 0; I != Group; ++I)
            if (State[S + I] != (I % Width ? 0 : Width))
              report_fatal_error(
                  "Ztt M COPY source square layout is inconsistent");
          CopyWidths[&MI] = Width;
        }
      }
      transferZttMLayout(MI, State, *TRI);
    }
  }

  // Liveness at COPY, rather than at its producer, determines the scratch.
  // Walk backwards so intervening uses and successor live-ins are respected.
  const MachineRegisterInfo &MRI = MF.getRegInfo();
  // This pass runs before PEI. A single ordinary XLEN spill slot can be reused
  // by all COPYs: each save/restore pair encloses only its own expansion.
  std::optional<int> ScratchFI;
  for (MachineBasicBlock &MBB : MF) {
    LivePhysRegs Live(*TRI);
    Live.addLiveOuts(MBB);
    SmallVector<MachineInstr *> OriginalInstructions;
    for (MachineInstr &MI : MBB)
      OriginalInstructions.push_back(&MI);
    for (MachineInstr *Original : llvm::reverse(OriginalInstructions)) {
      MachineInstr &MI = *Original;
      auto It = MI.getIterator();
      Live.stepBackward(MI);
      if (!IsMCopy(MI))
        continue;
      Register Dst = MI.getOperand(0).getReg();
      Register Src = MI.getOperand(1).getReg();
      if (Dst != Src) {
        Register Scratch;
        bool RestoreScratch = false;
        for (MCPhysReg R :
             TRI->getRawAllocationOrder(RISCV::GPRNoX0RegClass, MF))
          if (Live.available(MRI, R)) {
            Scratch = R;
            break;
          }
        if (!Scratch) {
          // Never borrow reserved registers (in particular SP/FP). Preserve a
          // live allocatable GPR using the target's normal scalar spill path.
          for (MCPhysReg R :
               TRI->getRawAllocationOrder(RISCV::GPRNoX0RegClass, MF))
            if (!MRI.isReserved(R)) {
              Scratch = R;
              break;
            }
          if (!Scratch)
            report_fatal_error("Ztt M COPY has no allocatable scratch GPR");
          if (!ScratchFI)
            ScratchFI = MF.getFrameInfo().CreateSpillStackObject(
                TRI->getSpillSize(RISCV::GPRRegClass),
                TRI->getSpillAlign(RISCV::GPRRegClass));
          TII->storeRegToStackSlot(MBB, It, Scratch, false, *ScratchFI,
                                   &RISCV::GPRRegClass, Register());
          RestoreScratch = true;
        }
        unsigned Group = getZttMGroupSize(Dst);
        unsigned Width = CopyWidths.lookup(&MI);
        for (unsigned Base = 0; Base != Group; Base += Width)
          emitMCopySquare(MBB, It, Scratch, Dst, Group, Base, Src, Group, Base,
                          Width);
        if (RestoreScratch)
          TII->loadRegFromStackSlot(MBB, It, Scratch, *ScratchFI,
                                    &RISCV::GPRRegClass, Register());
      }
      // The new sequence has the same matrix boundary liveness as COPY; its
      // scratch is either dead or restored. Do not revisit inserted moves.
      MBB.erase(It);
    }
  }
  return true;
}

bool RISCVZttPostRAExpandPseudo::runOnMachineFunction(MachineFunction &MF) {
  const auto &ST = MF.getSubtarget<RISCVSubtarget>();
  if (!ST.hasStdExtZtt())
    return false;

  TII = static_cast<const RISCVInstrInfo *>(MF.getSubtarget().getInstrInfo());
  TRI = MF.getSubtarget().getRegisterInfo();
  bool Modified = false;
  for (MachineBasicBlock &MBB : MF) {
    auto MBBI = MBB.begin();
    while (MBBI != MBB.end()) {
      auto NextMBBI = std::next(MBBI);
      Modified |= expandMI(MBB, MBBI);
      MBBI = NextMBBI;
    }
  }
  Modified |= expandMCopies(MF);
  return Modified;
}

Register RISCVZttPostRAExpandPseudo::getMReg(Register Group, unsigned GroupSize,
                                             unsigned Index) const {
  assert(Index < GroupSize && "Ztt M subregister index out of range");
  return GroupSize == 1 ? Group
                        : Register(TRI->getSubReg(Group, ZttMSubRegs[Index]));
}

Register RISCVZttPostRAExpandPseudo::getAReg(Register Group, unsigned GroupSize,
                                             unsigned Index) const {
  assert(Index < GroupSize && "Ztt Acc subregister index out of range");
  return GroupSize == 1 ? Group
                        : Register(TRI->getSubReg(Group, ZttASubRegs[Index]));
}

void RISCVZttPostRAExpandPseudo::emitMSetTyp(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI, Register Group,
    unsigned GroupSize, unsigned Base, unsigned RegsPerSquare, Register DType) {
  assert(RegsPerSquare && Base + RegsPerSquare <= GroupSize &&
         "invalid Ztt M square register range");
  MachineInstrBuilder MIB =
      BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_MSETTYP),
              getMReg(Group, GroupSize, Base))
          .addReg(DType);
  for (unsigned I = 1; I != RegsPerSquare; ++I)
    MIB.addReg(getMReg(Group, GroupSize, Base + I), RegState::ImplicitDefine);
}

bool RISCVZttPostRAExpandPseudo::needsMCopy(Register DstGroup,
                                            Register SrcGroup) const {
  if (DstGroup == SrcGroup)
    return false;
  if (TRI->regsOverlap(DstGroup, SrcGroup))
    report_fatal_error(
        "Ztt copy destination register group overlaps its source");
  return true;
}

void RISCVZttPostRAExpandPseudo::emitMCopySquare(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI, Register Scratch,
    Register DstGroup, unsigned DstGroupSize, unsigned DstBase,
    Register SrcGroup, unsigned SrcGroupSize, unsigned SrcBase,
    unsigned RegsPerSquare, Register DType) {
  assert(DstBase + RegsPerSquare <= DstGroupSize &&
         SrcBase + RegsPerSquare <= SrcGroupSize &&
         "invalid Ztt M copy square range");
  // Also protect direct square-copy callers. Group-copy callers check the
  // entire groups first, so an earlier square cannot clobber a later source.
  if (getMReg(DstGroup, DstGroupSize, DstBase) ==
      getMReg(SrcGroup, SrcGroupSize, SrcBase))
    return;
  for (unsigned D = 0; D != RegsPerSquare; ++D)
    for (unsigned S = 0; S != RegsPerSquare; ++S)
      if (TRI->regsOverlap(getMReg(DstGroup, DstGroupSize, DstBase + D),
                           getMReg(SrcGroup, SrcGroupSize, SrcBase + S)))
        report_fatal_error(
            "Ztt copy destination register group overlaps its source");
  // Metadata and moves address the base of a physical square, including wide
  // squares spanning several M registers.
  // Only compiler-generated copies need to recover metadata from the source.
  if (!DType) {
    BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_MGETTYP),
            Scratch)
        .addReg(getMReg(SrcGroup, SrcGroupSize, SrcBase));
    DType = Scratch;
  }
  emitMSetTyp(MBB, MBBI, DstGroup, DstGroupSize, DstBase, RegsPerSquare, DType);
  auto Move =
      BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_MMOV_M_M),
              getMReg(DstGroup, DstGroupSize, DstBase))
          .addReg(getMReg(SrcGroup, SrcGroupSize, SrcBase));
  for (unsigned I = 1; I != RegsPerSquare; ++I) {
    Move.addReg(getMReg(DstGroup, DstGroupSize, DstBase + I),
                RegState::ImplicitDefine);
    Move.addReg(getMReg(SrcGroup, SrcGroupSize, SrcBase + I),
                RegState::Implicit);
  }
}

bool RISCVZttPostRAExpandPseudo::expandMI(MachineBasicBlock &MBB,
                                          MachineBasicBlock::iterator MBBI) {
  if (const auto *P = RISCVZttInstrInfo::getPseudoInfo(MBBI->getOpcode())) {
    const auto *Info = RISCVZttInstrInfo::getOperationInfo(P->Operation);
    assert(Info && "missing Ztt operation metadata");
    using RISCVZttInstrInfo::OperandLayout;
    switch (Info->Kind) {
    case RISCVZttInstrInfo::CodeGenKind::Slice:
      if (Info->Layout == OperandLayout::Clear)
        return Info->IsAcc ? expandAClear(MBB, MBBI, P->DstGroup)
                           : expandMSetTyp(MBB, MBBI, P->DstGroup);
      if (Info->Layout == OperandLayout::Zero)
        return expandZero(MBB, MBBI, P->DstGroup, Info->IsAcc);
      return expandSlice(MBB, MBBI, *P, *Info);
    case RISCVZttInstrInfo::CodeGenKind::Matmul:
      return expandMatmul(MBB, MBBI, P->DstGroup, P->Src0Group, P->Src1Group,
                          Info->BaseOpcode);
    case RISCVZttInstrInfo::CodeGenKind::Transfer:
      switch (Info->Layout) {
      case OperandLayout::Copy:
        return expandMCopy(MBB, MBBI, P->DstGroup);
      case OperandLayout::Concat:
        return expandMConcat(MBB, MBBI, P->DstGroup);
      case OperandLayout::CrossCopy:
        return expandCrossCopy(
            MBB, MBBI, Info->IsAcc ? P->DstGroup : P->Src0Group,
            Info->IsAcc ? P->Src0Group : P->DstGroup, Info->IsAcc);
      case OperandLayout::Extract:
        return expandMextract(MBB, MBBI, P->DstGroup, P->Src0Group);
      default:
        llvm_unreachable("invalid transfer operand layout");
      }
    case RISCVZttInstrInfo::CodeGenKind::Memory:
      return expandMemory(MBB, MBBI, P->DstGroup, Info->BaseOpcode,
                          Info->IsLoad,
                          Info->Layout == OperandLayout::StridedMemory);
    default:
      break;
    }
  }
  return false;
}

bool RISCVZttPostRAExpandPseudo::expandZero(MachineBasicBlock &MBB,
                                            MachineBasicBlock::iterator MI,
                                            unsigned GroupSize, bool IsAcc) {
  Register Group = MI->getOperand(0).getReg();
  Register DType = MI->getOperand(1).getReg();
  unsigned Step = IsAcc ? 1 : MI->getOperand(2).getImm();
  assert(Step && GroupSize % Step == 0 && "invalid Ztt zero layout");
  for (unsigned I = 0; I != GroupSize; I += Step) {
    if (IsAcc)
      BuildMI(MBB, MI, MI->getDebugLoc(), TII->get(RISCV::ZTT_ASETTYP),
              getAReg(Group, GroupSize, I))
          .addReg(DType);
    else
      emitMSetTyp(MBB, MI, Group, GroupSize, I, Step, DType);
  }
  for (unsigned I = 0; I != GroupSize; I += Step) {
    Register Base =
        IsAcc ? getAReg(Group, GroupSize, I) : getMReg(Group, GroupSize, I);
    auto Zero = BuildMI(
        MBB, MI, MI->getDebugLoc(),
        TII->get(IsAcc ? RISCV::ZTT_MZERO_2D_ACC : RISCV::ZTT_MZERO_2D_M),
        Base);
    // The operation consumes the newly installed Md/Ad and defines payload.
    Zero.addReg(Base, RegState::Implicit);
    for (unsigned J = 1; J != Step; ++J) {
      Register Tail = getMReg(Group, GroupSize, I + J);
      Zero.addReg(Tail, RegState::Implicit);
      Zero.addReg(Tail, RegState::ImplicitDefine);
    }
  }
  MI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandMSetTyp(MachineBasicBlock &MBB,
                                               MachineBasicBlock::iterator MBBI,
                                               unsigned GroupSize) {
  Register GroupReg = MBBI->getOperand(0).getReg();
  unsigned RegsPerUnit = MBBI->getOperand(2).getImm();
  assert(RegsPerUnit && GroupSize % RegsPerUnit == 0 &&
         "invalid Ztt registers-per-unit");
  for (unsigned Base = 0; Base != GroupSize; Base += RegsPerUnit)
    emitMSetTyp(MBB, MBBI, GroupReg, GroupSize, Base, RegsPerUnit,
                MBBI->getOperand(1).getReg());
  MBBI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandAClear(MachineBasicBlock &MBB,
                                              MachineBasicBlock::iterator MBBI,
                                              unsigned GroupSize) {
  Register GroupReg = MBBI->getOperand(0).getReg();
  for (unsigned I = 0; I != GroupSize; ++I) {
    BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_ASETTYP),
            getAReg(GroupReg, GroupSize, I))
        .addReg(MBBI->getOperand(1).getReg());
  }
  MBBI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandMemory(MachineBasicBlock &MBB,
                                              MachineBasicBlock::iterator MBBI,
                                              unsigned GroupSize,
                                              unsigned MemoryOpcode,
                                              bool IsLoad, bool Strided) {
  // Named operands isolate signature differences from the slice walk.
  auto Operand = [&](RISCV::OpName Name) -> const MachineOperand & {
    int Index = RISCV::getNamedOperandIdx(MBBI->getOpcode(), Name);
    assert(Index >= 0 && "missing Ztt memory operand");
    return MBBI->getOperand(Index);
  };
  Register GroupReg =
      Operand(IsLoad ? RISCV::OpName::rd : RISCV::OpName::src).getReg();
  Register AddressReg = Operand(RISCV::OpName::scratch).getReg();
  Register Step =
      Operand(Strided ? RISCV::OpName::step : RISCV::OpName::stride).getReg();
  Register ByteStride =
      Strided ? Operand(RISCV::OpName::stride).getReg() : Register();
  Register DType = IsLoad ? Operand(RISCV::OpName::dtype).getReg() : Register();
  unsigned RegsPerUnit = Operand(Strided ? RISCV::OpName::regs_per_square
                                         : RISCV::OpName::regs_per_unit)
                             .getImm();
  assert(RegsPerUnit && GroupSize % RegsPerUnit == 0 &&
         "invalid Ztt memory register group");
  for (unsigned Base = 0; Base != GroupSize; Base += RegsPerUnit) {
    if (Base)
      BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ADD), AddressReg)
          .addReg(AddressReg)
          .addReg(Step);
    Register BaseReg = getMReg(GroupReg, GroupSize, Base);
    if (IsLoad)
      emitMSetTyp(MBB, MBBI, GroupReg, GroupSize, Base, RegsPerUnit, DType);
    MachineInstrBuilder Mem =
        IsLoad ? BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(MemoryOpcode),
                         BaseReg)
                     .addReg(AddressReg)
               : BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(MemoryOpcode))
                     .addReg(BaseReg)
                     .addReg(AddressReg);
    if (Strided)
      Mem.addReg(ByteStride);
    // The encoded base names the entire square, including wide continuation
    // registers. Loads define them; stores read them.
    for (unsigned I = 1; I != RegsPerUnit; ++I)
      Mem.addReg(getMReg(GroupReg, GroupSize, Base + I),
                 IsLoad ? RegState::ImplicitDefine : RegState::Implicit);
    Mem.cloneMemRefs(*MBBI);
  }
  MBBI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandMCopy(MachineBasicBlock &MBB,
                                             MachineBasicBlock::iterator MBBI,
                                             unsigned GroupSize) {
  Register DstGroup = MBBI->getOperand(0).getReg();
  Register SrcGroup = MBBI->getOperand(1).getReg();
  unsigned RegsPerUnit = MBBI->getOperand(2).getImm();
  assert(RegsPerUnit && GroupSize % RegsPerUnit == 0 &&
         "invalid Ztt mcopy register group");

  if (needsMCopy(DstGroup, SrcGroup))
    for (unsigned Base = 0; Base != GroupSize; Base += RegsPerUnit)
      emitMCopySquare(MBB, MBBI, Register(), DstGroup, GroupSize, Base,
                      SrcGroup, GroupSize, Base, RegsPerUnit,
                      MBBI->getOperand(3).getReg());

  MBBI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandMConcat(MachineBasicBlock &MBB,
                                               MachineBasicBlock::iterator MBBI,
                                               unsigned GroupSize) {
  assert(GroupSize >= 2 && isPowerOf2_32(GroupSize) &&
         "invalid Ztt mconcat.m destination group");
  unsigned SrcGroupSize = GroupSize / 2;
  Register DstGroup = MBBI->getOperand(0).getReg();
  Register LhsGroup = MBBI->getOperand(1).getReg();
  Register RhsGroup = MBBI->getOperand(2).getReg();
  // Check aliases of the whole groups, not just their starting registers.
  // MSETTYP clears data, so even a partially overlapping destination is unsafe.
  // The two read-only sources may still alias each other.
  if (TRI->regsOverlap(DstGroup, LhsGroup) ||
      TRI->regsOverlap(DstGroup, RhsGroup))
    report_fatal_error(
        "Ztt mconcat.m destination register group overlaps a source");
  unsigned RegsPerSquare = MBBI->getOperand(3).getImm();
  // Intrinsic sources and result have the same statically known datatype.
  Register DType = MBBI->getOperand(4).getReg();
  assert(RegsPerSquare && SrcGroupSize % RegsPerSquare == 0 &&
         "invalid Ztt mconcat.m source layout");

  // The first source forms the low half and the second source forms the high
  // half of the contiguous destination group.
  for (unsigned Base = 0; Base != SrcGroupSize; Base += RegsPerSquare) {
    emitMCopySquare(MBB, MBBI, Register(), DstGroup, GroupSize, Base, LhsGroup,
                    SrcGroupSize, Base, RegsPerSquare, DType);
    emitMCopySquare(MBB, MBBI, Register(), DstGroup, GroupSize,
                    SrcGroupSize + Base, RhsGroup, SrcGroupSize, Base,
                    RegsPerSquare, DType);
  }

  MBBI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandCrossCopy(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MBBI, unsigned AccGroup,
    unsigned MGroup, bool IsM2A) {
  Register DstGroup = MBBI->getOperand(0).getReg();
  Register DType = MBBI->getOperand(4).getReg();
  Register SrcGroup = MBBI->getOperand(1).getReg();
  unsigned MRegsPerSquare = MBBI->getOperand(2).getImm();
  unsigned AccsPerMove = MBBI->getOperand(3).getImm();
  assert(MRegsPerSquare && AccsPerMove && AccGroup % AccsPerMove == 0 &&
         MGroup == (AccGroup / AccsPerMove) * MRegsPerSquare &&
         "invalid Ztt M/Acc copy grouping");

  Register MGroupReg = IsM2A ? SrcGroup : DstGroup;
  Register AGroupReg = IsM2A ? DstGroup : SrcGroup;
  for (unsigned AccBase = 0, MBase = 0; AccBase != AccGroup;
       AccBase += AccsPerMove, MBase += MRegsPerSquare) {
    Register MBaseReg = getMReg(MGroupReg, MGroup, MBase);
    Register ABaseReg = getAReg(AGroupReg, AccGroup, AccBase);
    if (IsM2A) {
      for (unsigned I = 0; I != AccsPerMove; ++I)
        BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(RISCV::ZTT_ASETTYP),
                getAReg(AGroupReg, AccGroup, AccBase + I))
            .addReg(DType);
      auto Move = BuildMI(MBB, MBBI, MBBI->getDebugLoc(),
                          TII->get(RISCV::ZTT_MMOV_A_M), ABaseReg)
                      .addReg(MBaseReg);
      for (unsigned I = 1; I != MRegsPerSquare; ++I)
        Move.addReg(getMReg(MGroupReg, MGroup, MBase + I), RegState::Implicit);
      for (unsigned I = 1; I != AccsPerMove; ++I)
        Move.addReg(getAReg(AGroupReg, AccGroup, AccBase + I),
                    RegState::ImplicitDefine);
    } else {
      emitMSetTyp(MBB, MBBI, MGroupReg, MGroup, MBase, MRegsPerSquare, DType);
      auto Move = BuildMI(MBB, MBBI, MBBI->getDebugLoc(),
                          TII->get(RISCV::ZTT_MMOV_M_A), MBaseReg)
                      .addReg(ABaseReg);
      for (unsigned I = 1; I != MRegsPerSquare; ++I)
        Move.addReg(getMReg(MGroupReg, MGroup, MBase + I),
                    RegState::ImplicitDefine);
      for (unsigned I = 1; I != AccsPerMove; ++I)
        Move.addReg(getAReg(AGroupReg, AccGroup, AccBase + I),
                    RegState::Implicit);
    }
  }

  MBBI->eraseFromParent();
  return true;
}

void RISCVZttPostRAExpandPseudo::emitMOperations(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MI, unsigned Opcode,
    Register Dst, unsigned DGroup, unsigned NumOps, ArrayRef<MInput> Sources,
    ArrayRef<Register> Scalars) {
  unsigned DWidth = DGroup / NumOps;
  for (unsigned I = 0; I != NumOps; ++I) {
    auto Inst = BuildMI(MBB, MI, MI->getDebugLoc(), TII->get(Opcode),
                        getMReg(Dst, DGroup, I * DWidth));
    for (Register Scalar : Scalars)
      Inst.addReg(Scalar);
    for (const MInput &Src : Sources) {
      unsigned Width = Src.Width ? Src.Width : Src.Group / NumOps;
      Inst.addReg(getMReg(Src.Reg, Src.Group, Src.Base + I * Width));
    }
    // The explicit destination defines its leader payload; its metadata and
    // all continuation payloads remain dependencies of this instruction.
    for (unsigned J = 0; J != DWidth; ++J) {
      Register R = getMReg(Dst, DGroup, I * DWidth + J);
      Inst.addReg(R, RegState::Implicit);
      if (J)
        Inst.addReg(R, RegState::ImplicitDefine);
    }
    for (const MInput &Src : Sources) {
      unsigned Width = Src.Width ? Src.Width : Src.Group / NumOps;
      for (unsigned J = 1; J != Width; ++J)
        Inst.addReg(getMReg(Src.Reg, Src.Group, Src.Base + I * Width + J),
                    RegState::Implicit);
    }
  }
}

bool RISCVZttPostRAExpandPseudo::expandMextract(MachineBasicBlock &MBB,
                                                MachineBasicBlock::iterator MI,
                                                unsigned DGroup,
                                                unsigned S0Group) {
  Register Dst = MI->getOperand(0).getReg();
  Register S0 = MI->getOperand(1).getReg();
  // The prototype keeps the entire source live and disjoint from the result.
  // TODO: Select a half-group before allocation so full-capacity sources do
  // not require additional registers alongside the complete source group.
  if (TRI->regsOverlap(Dst, S0))
    report_fatal_error("Ztt mextract destination overlaps a source");
  unsigned NumOps = MI->getOperand(4).getImm();
  unsigned Width = MI->getOperand(5).getImm();
  assert(NumOps && DGroup % NumOps == 0 && Width && DGroup % Width == 0 &&
         "invalid Ztt operation layout");
  for (unsigned I = 0; I != DGroup; I += Width)
    emitMSetTyp(MBB, MI, Dst, DGroup, I, Width, MI->getOperand(3).getReg());
  emitMOperations(
      MBB, MI, RISCV::ZTT_MMOV_M_M, Dst, DGroup, NumOps,
      {{S0, S0Group, unsigned(MI->getOperand(2).getImm()) * DGroup, Width}});

  MI->eraseFromParent();
  return true;
}

void RISCVZttPostRAExpandPseudo::emitScalarType(MachineBasicBlock &MBB,
                                                MachineBasicBlock::iterator MI,
                                                Register SType) {
  const auto *CSR = RISCVSysReg::lookupSysRegByName("AMESTYPE");
  assert(CSR && "missing AMESTYPE CSR");
  BuildMI(MBB, MI, MI->getDebugLoc(), TII->get(RISCV::CSRRW), RISCV::X0)
      .addImm(CSR->Encoding)
      .addReg(SType);
}

bool RISCVZttPostRAExpandPseudo::expandSlice(
    MachineBasicBlock &MBB, MachineBasicBlock::iterator MI,
    const RISCVZttInstrInfo::PseudoInfo &P,
    const RISCVZttInstrInfo::OperationInfo &Info) {
  Register Dst = MI->getOperand(0).getReg();
  unsigned First = 1 + Info.HasOld;
  unsigned ScalarIndex = First + Info.NumSources;
  unsigned DIndex = ScalarIndex + Info.HasScalar;
  unsigned CountIndex = DIndex + 1 + Info.HasScalarType;
  unsigned NumOps = MI->getOperand(CountIndex).getImm();
  unsigned Width = MI->getOperand(CountIndex + 1).getImm();
  assert(NumOps && P.DstGroup % NumOps == 0 && Width &&
         P.DstGroup % Width == 0 && "invalid Ztt operation layout");
  if (Info.HasOld)
    assert(Dst == MI->getOperand(1).getReg() && "tied Ztt destination");
  if (Info.Pairwise) {
    assert(NumOps == 1 && P.DstGroup == 2 * Width &&
           "zip/unzip needs two disjoint square groups");
    Register FirstSquare = getMReg(Dst, P.DstGroup, 0);
    Register SecondSquare = getMReg(Dst, P.DstGroup, Width);
    auto Pair = BuildMI(MBB, MI, MI->getDebugLoc(), TII->get(Info.BaseOpcode),
                        FirstSquare)
                    .addDef(SecondSquare)
                    .addUse(FirstSquare)
                    .addUse(SecondSquare);
    // The encoded leaders read and write all wide continuation registers.
    for (unsigned I = 0; I != P.DstGroup; ++I)
      if (I != 0 && I != Width) {
        Register Tail = getMReg(Dst, P.DstGroup, I);
        Pair.addReg(Tail, RegState::Implicit);
        Pair.addReg(Tail, RegState::ImplicitDefine);
      }
    MI->eraseFromParent();
    return true;
  }
  SmallVector<MInput, 2> Sources;
  unsigned Groups[] = {P.Src0Group, P.Src1Group};
  for (unsigned I = 0; I != Info.NumSources; ++I) {
    Register Src = MI->getOperand(First + I).getReg();
    if (!Info.HasOld && TRI->regsOverlap(Dst, Src)) {
      report_fatal_error(
          Info.HasScalar
              ? "Ztt scalar operation destination overlaps its source"
          : Info.NumSources == 1
              ? "Ztt unary destination overlaps its source"
              : "Ztt elementwise destination overlaps a source");
    }
    assert(Groups[I] % NumOps == 0 && "invalid Ztt source slice");
    Sources.push_back({Src, Groups[I]});
  }
  SmallVector<Register, 2> Scalars;
  if (Info.HasScalar)
    Scalars.push_back(MI->getOperand(ScalarIndex).getReg());
  if (Info.HasScalarType) {
    Register SType = MI->getOperand(DIndex + 1).getReg();
    if (Info.ScalarType == RISCVZttInstrInfo::ScalarTypeLocation::CSR)
      emitScalarType(MBB, MI, SType);
    else
      Scalars.push_back(SType);
  }
  // old_d carries its metadata; resetting it would erase the input payload.
  if (!Info.HasOld)
    for (unsigned I = 0; I != P.DstGroup; I += Width)
      emitMSetTyp(MBB, MI, Dst, P.DstGroup, I, Width,
                  MI->getOperand(DIndex).getReg());
  emitMOperations(MBB, MI, Info.BaseOpcode, Dst, P.DstGroup, NumOps, Sources,
                  Scalars);
  MI->eraseFromParent();
  return true;
}

bool RISCVZttPostRAExpandPseudo::expandMatmul(MachineBasicBlock &MBB,
                                              MachineBasicBlock::iterator MBBI,
                                              unsigned AccGroup,
                                              unsigned LGroup, unsigned RGroup,
                                              unsigned Opcode) {
  Register Acc = MBBI->getOperand(0).getReg();
  Register AccInput = MBBI->getOperand(1).getReg();
  Register Lhs = MBBI->getOperand(2).getReg();
  Register Rhs = MBBI->getOperand(3).getReg();
  unsigned NumOps = MBBI->getOperand(4).getImm();
  assert(Acc == AccInput && "Ztt matmul accumulator must be tied");
  assert(NumOps && "Ztt matmul must emit at least one instruction");
  assert(LGroup % NumOps == 0 && RGroup % NumOps == 0 &&
         "Ztt matmul must partition whole M register groups");
  Register AccRegs = Acc;
  Acc = getAReg(Acc, AccGroup, 0);
  for (unsigned I = 0; I != NumOps; ++I) {
    Register LhsPart = getMReg(Lhs, LGroup, (I * LGroup) / NumOps);
    Register RhsPart = getMReg(Rhs, RGroup, (I * RGroup) / NumOps);
    auto Mul = BuildMI(MBB, MBBI, MBBI->getDebugLoc(), TII->get(Opcode), Acc)
                   .addReg(LhsPart)
                   .addReg(RhsPart)
                   .addReg(Acc, RegState::Implicit);
    // Each instruction consumes its own slice of both input groups. A slice
    // can span several registers for wide or mixed packed/standard operands.
    for (unsigned J = 1; J != LGroup / NumOps; ++J)
      Mul.addReg(getMReg(Lhs, LGroup, I * (LGroup / NumOps) + J),
                 RegState::Implicit);
    for (unsigned J = 1; J != RGroup / NumOps; ++J)
      Mul.addReg(getMReg(Rhs, RGroup, I * (RGroup / NumOps) + J),
                 RegState::Implicit);
    // Model the entire C-level accumulator as read/write, preserving its
    // logical dependency even though hardware only updates the first square.
    for (unsigned J = 1; J != AccGroup; ++J) {
      Register Tail = getAReg(AccRegs, AccGroup, J);
      Mul.addReg(Tail, RegState::Implicit);
      Mul.addReg(Tail, RegState::ImplicitDefine);
    }
  }
  MBBI->eraseFromParent();
  return true;
}

} // end of anonymous namespace

INITIALIZE_PASS(RISCVZttPostRAExpandPseudo, "riscv-ztt-post-ra-expand-pseudo",
                "RISC-V Ztt post-regalloc pseudo instruction expansion pass",
                false, false)

namespace llvm {
FunctionPass *createRISCVZttPostRAExpandPseudoPass() {
  return new RISCVZttPostRAExpandPseudo();
}
} // end of namespace llvm
