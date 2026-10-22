//===- RISCVZttTypes.h - Ztt IR types ---------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_IR_RISCVZTTTYPES_H
#define LLVM_IR_RISCVZTTTYPES_H

#include "llvm/IR/DerivedTypes.h"
#include <cstdint>
#include <optional>

namespace llvm {

/// Shared parameters for IR layout queries and machine type selection.
struct RISCVZttTypeInfo {
  Type *ElementType;
  unsigned ElementBits;
  uint64_t NumSquares;
  bool IsACC;
  bool HasValidLayout;

  uint64_t getLogicalBits() const { return uint64_t(ElementBits) * NumSquares; }
};

/// Recognize the parameter structure.
inline std::optional<RISCVZttTypeInfo>
getRISCVZttTypeInfo(const TargetExtType *Ty) {
  bool IsACC = Ty->getName().starts_with("riscv.ztt.acc.");
  if ((!IsACC && !Ty->getName().starts_with("riscv.ztt.m.")) ||
      Ty->getNumTypeParameters() != 1 ||
      Ty->getNumIntParameters() != (IsACC ? 2U : 3U))
    return std::nullopt;

  // M: target("riscv.ztt.m.i16", i16, 16, 1, 2).
  // Parameters: name, element type, element bit width, rows, columns.
  // ACC: target("riscv.ztt.acc.i16", i16, 16, 2).
  // Parameters: name, element type, element bit width, square count.
  Type *ElementType = Ty->getTypeParameter(0);
  unsigned ElementBits = Ty->getIntParameter(0);
  uint64_t NumSquares;
  bool ValidShape;
  if (IsACC) {
    NumSquares = Ty->getIntParameter(1);
    ValidShape = NumSquares == 1 || NumSquares == 2 || NumSquares == 4 ||
                 NumSquares == 8 || NumSquares == 16;
  } else {
    unsigned Rows = Ty->getIntParameter(1);
    unsigned Cols = Ty->getIntParameter(2);
    NumSquares = uint64_t(Rows) * Cols;
    auto IsValidExtent = [](unsigned Extent) {
      return Extent == 1 || Extent == 2 || Extent == 4 || Extent == 8 ||
             Extent == 16 || Extent == 32;
    };
    ValidShape =
        IsValidExtent(Rows) && IsValidExtent(Cols) && (Rows == 1 || Cols == 1);
  }
  bool HasValidLayout =
      (ElementType->isIntegerTy() || ElementType->isFloatingPointTy()) &&
      ElementBits != 0 && ValidShape;
  return RISCVZttTypeInfo{ElementType, ElementBits, NumSquares, IsACC,
                          HasValidLayout};
}

} // namespace llvm

#endif // LLVM_IR_RISCVZTTTYPES_H
