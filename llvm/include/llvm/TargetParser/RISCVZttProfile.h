//===-- RISCVZttProfile.h - Ztt configuration -------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TARGETPARSER_RISCVZTTPROFILE_H
#define LLVM_TARGETPARSER_RISCVZTTPROFILE_H

#include "llvm/ADT/StringRef.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/Error.h"

namespace llvm::RISCV {

/// Matrix dimensions and register resources shared by Clang and LLVM.
struct ZttProfile {
  /// Side length of a matrix square. Zero means N is unknown at compile time
  /// but constant at runtime.
  /// Fixed N is recorded but does not specialize matrix sizing or lowering.
  unsigned N = 0;
  unsigned UdsBits = 0; ///< Hardware UDS in bits.
  unsigned MRegs = 0;   ///< Number of available M registers.
  unsigned ARegs = 0;   ///< Number of available ACC registers.

  /// Parse clang-n<N>-u<UDS>-m<M>-a<A> or
  /// clang-runtime-u<UDS>-m<M>-a<A>. No configuration is selected implicitly.
  /// For example, clang-n128-u32-m16-a4 selects N=128, UDS=32 bits,
  /// 16 M registers and 4 ACC registers.
  LLVM_ABI static Expected<ZttProfile> parse(StringRef Name);
};

} // namespace llvm::RISCV

#endif
