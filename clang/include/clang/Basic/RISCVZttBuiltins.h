//===- RISCVZttBuiltins.h - RISC-V Ztt builtins -----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_BASIC_RISCVZTTBUILTINS_H
#define LLVM_CLANG_BASIC_RISCVZTTBUILTINS_H

#include "llvm/ADT/ArrayRef.h"

namespace clang::RISCV {

enum class RISCVZttOperation {
#define GET_RISCV_ZTT_OPERATION_ENUM
#include "clang/Basic/riscv_ztt_builtins.inc"
#undef GET_RISCV_ZTT_OPERATION_ENUM
};

enum class RISCVZttResultKind { NonMatrix, M, ACC };
enum class RISCVZttResultTypeKind { Numeric, Integer, Float };

// One builtin serves all datatype and shape suffixes of an operation.
struct RISCVZttBuiltinInfo {
  unsigned ID;
  RISCVZttOperation Operation;
  const char *Name;
  RISCVZttResultKind ResultKind;
  RISCVZttResultTypeKind ResultTypeKind;
  unsigned MaxResultSquares; // Maximum logical squares in the return type.
  unsigned MinResultSquares; // Minimum logical squares in the return type.

  // Check the return type before declaring a suffixed intrinsic name.
  bool acceptsResult(bool IsACC, bool IsInteger, unsigned ElementBits,
                     unsigned Rows, unsigned Columns, unsigned Squares) const;
};

const RISCVZttBuiltinInfo *getRISCVZttBuiltinInfo(unsigned ID);
llvm::ArrayRef<RISCVZttBuiltinInfo> getRISCVZttBuiltins();

} // namespace clang::RISCV

#endif // LLVM_CLANG_BASIC_RISCVZTTBUILTINS_H
