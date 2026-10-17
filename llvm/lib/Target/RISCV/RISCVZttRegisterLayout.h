//===-- RISCVZttRegisterLayout.h - Ztt layouts --------------------*- C++
//-*-===//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef LLVM_LIB_TARGET_RISCV_RISCVZTTREGISTERLAYOUT_H
#define LLVM_LIB_TARGET_RISCV_RISCVZTTREGISTERLAYOUT_H

#include "llvm/ADT/DenseMap.h"
#include "llvm/CodeGen/Register.h"
#include <array>
#include <optional>

namespace llvm {
class MachineBasicBlock;
class MachineFunction;
class MachineInstr;
class TargetRegisterInfo;
class MCRegisterClass;
using TargetRegisterClass = MCRegisterClass;

/// Return the register class for a physical group, or nullptr if unsupported.
const TargetRegisterClass *getZttMRegisterClass(unsigned Group);
const TargetRegisterClass *getZttAccRegisterClass(unsigned Group);

/// Physical M layout, independent of data liveness: a square leader stores its
/// width in registers, continuations store zero, and unknown entries store -1.
/// Consumers must combine this with liveness before borrowing any register.
using ZttMLayout = std::array<int, 32>;
/// Entry layouts of reachable blocks.
using ZttMBlockLayouts = DenseMap<const MachineBasicBlock *, ZttMLayout>;

/// Return the physical M group size, or zero for a non-M register.
unsigned getZttMGroupSize(Register Reg);
/// Return the physical ACC group size, or zero for a non-ACC register.
unsigned getZttAccGroupSize(Register Reg);
/// Apply one expanded instruction to the layout. COPY propagates layout;
/// unmodelled definitions and call clobbers invalidate affected registers.
void transferZttMLayout(const MachineInstr &MI, ZttMLayout &State,
                        const TargetRegisterInfo &TRI);
/// Combine predecessor layouts; conflicting entries become unknown.
ZttMBlockLayouts analyzeZttMLayouts(MachineFunction &MF);

/// Element widths of physical ACCs before typed pseudos are expanded. Unknown
/// or conflicting widths are -1. ACC inputs have no supported ABI type seed.
using ZttAccLayout = std::array<int, 16>;
using ZttAccBlockLayouts = DenseMap<const MachineBasicBlock *, ZttAccLayout>;
void transferZttAccLayout(const MachineInstr &MI, ZttAccLayout &State,
                          const TargetRegisterInfo &TRI, unsigned UdsBits);
ZttAccBlockLayouts analyzeZttAccLayouts(MachineFunction &MF);

/// Find the ACC element width through producers, COPY/PHI and tied updates.
/// Unknown or conflicting widths return none.
std::optional<unsigned>
getZttAccElementBits(Register Reg, const MachineFunction &MF, unsigned UdsBits);

/// ACC transfers through M. Units counts M-register images in memory.
struct ZttAccTransferLayout {
  unsigned MRegsPerMove;
  unsigned AccsPerMove;
  unsigned NumMoves;
  unsigned Units;
};
/// Reject incomplete packed batches without changing frontend type legality.
std::optional<ZttAccTransferLayout>
getZttAccTransferLayout(unsigned ElementBits, unsigned Squares,
                        unsigned UdsBits);
} // namespace llvm

#endif
