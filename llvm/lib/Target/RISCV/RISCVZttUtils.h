//===-- RISCVZttUtils.h - RISC-V Ztt utility functions ---------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_RISCV_RISCVZTTUTILS_H
#define LLVM_LIB_TARGET_RISCV_RISCVZTTUTILS_H

#include "llvm/CodeGenTypes/MachineValueType.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/MathExtras.h"
#include <algorithm>
#include <cassert>

namespace llvm {

/// Return whether VT is a Ztt M type, excluding ACC.
inline bool isZttMatrixVT(MVT VT) {
  return VT.SimpleTy >= MVT::riscv_zttm4 && VT.SimpleTy <= MVT::riscv_zttm4096;
}

/// Return logical capacity: element bits times square count.
inline unsigned getZttMatrixLogicalBits(MVT VT) {
  assert(isZttMatrixVT(VT) && "not a Ztt matrix value type");
  return VT.getSizeInBits().getKnownMinValue();
}

/// Return whether an M value would occupy less than one physical M register.
inline bool isZttMHalfRegister(unsigned LogicalBits, unsigned UdsBits) {
  return LogicalBits < UdsBits;
}

/// Return the power-of-two physical M-register group needed to hold Bits.
/// The caller is responsible for rejecting half-register values and groups
/// larger than the architectural limit.
inline unsigned getZttMRegisterGroupSize(unsigned Bits, unsigned UdsBits) {
  assert(Bits && UdsBits && "Ztt register sizing requires nonzero bit sizes");
  return PowerOf2Ceil(std::max(1U, unsigned(divideCeil(Bits, UdsBits))));
}

/// Return how many logical squares of ElementBits fit in one physical M
/// register. Wide squares return one and use RegsPerSquare to describe their
/// multi-register allocation.
inline unsigned getZttSquaresPerMRegister(unsigned ElementBits,
                                          unsigned UdsBits) {
  assert(ElementBits && UdsBits && "Ztt packing requires nonzero bit sizes");
  return std::max(1U, UdsBits / ElementBits);
}

/// Physical M-register layout of a logical Ztt M value for a selected UDS.
struct ZttMRegisterLayout {
  /// Power-of-two register group allocated for the complete logical M value.
  unsigned GroupSize;
  /// Number of consecutive physical M registers occupied by one square.
  unsigned RegsPerSquare;
  /// Number of packed logical squares held in one physical M register.
  unsigned SquaresPerRegister;
};

/// Derive the register layout from logical capacity, element bits and UDS.
inline ZttMRegisterLayout getZttMRegisterLayout(unsigned LogicalBits,
                                                unsigned ElementBits,
                                                unsigned UdsBits) {
  assert(LogicalBits && ElementBits && UdsBits &&
         "Ztt layout requires nonzero bit sizes");
  return {getZttMRegisterGroupSize(LogicalBits, UdsBits),
          getZttMRegisterGroupSize(ElementBits, UdsBits),
          getZttSquaresPerMRegister(ElementBits, UdsBits)};
}

} // namespace llvm

#endif
