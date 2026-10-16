//===-- RISCVZttSpill.h - Ztt spill frames --------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_RISCV_RISCVZTTSPILL_H
#define LLVM_LIB_TARGET_RISCV_RISCVZTTSPILL_H

#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"

namespace llvm {
/// Two XLEN words fit in a 16-byte header on both RV32 and RV64. Keep payloads
/// aligned to the largest supported UDS (128 bits), independently of vscale.
inline constexpr unsigned ZttMFrameHeaderSize = 16;
/// Five RV64 scratch saves rounded to the ABI's 16-byte alignment. This tail
/// also supplies safe temporary storage while returning SP to its entry value.
inline constexpr unsigned ZttMFrameScratchTailSize = 48;
/// Handle M/ACC allocator images; return false for other register classes.
bool emitZttSpill(MachineBasicBlock &MBB, MachineBasicBlock::iterator I,
                  Register Reg, bool IsLoad, bool Kill, int FI,
                  const TargetRegisterClass *RC, Register VReg,
                  MachineInstr::MIFlag Flags);
/// Decode allocator image pseudos. Zero means an unrelated instruction.
unsigned getZttSpillGroup(unsigned Opcode, bool &IsLoad);
/// Finalize M/ACC image slots after allocation and stack-slot coloring.
bool prepareZttSpillFrame(MachineFunction &MF);
/// Borrowable (not necessarily dead) GPRs, excluding every reserved register.
/// Callers must preserve live values; no globally free registers are required.
SmallVector<Register, 5> getZttSpillScratchRegs(const MachineFunction &MF);
/// Directly expand sizing during PEI without changing the common pass order.
void expandZttFrameSize(MachineInstr &MI);
/// Allocate/free the M area surrounding the conventional frame lowering.
void emitZttFrameAllocation(MachineFunction &MF, MachineBasicBlock &MBB);
void emitZttFrameDeallocation(MachineFunction &MF, MachineBasicBlock &MBB);
/// Adjust a large fixed SP offset without scavenging across an SP change.
/// Only used in Ztt M spill prologues/epilogues; borrowed GPRs are preserved.
void emitZttFixedSPAdjustment(MachineFunction &MF, MachineBasicBlock &MBB,
                              MachineBasicBlock::iterator I, int64_t Offset,
                              MachineInstr::MIFlag Flag);
/// Initialize the optional stride cache after its caller value has been saved.
void emitZttStrideCache(MachineFunction &MF, MachineBasicBlock &MBB,
                        MachineBasicBlock::iterator I);
} // namespace llvm
#endif
