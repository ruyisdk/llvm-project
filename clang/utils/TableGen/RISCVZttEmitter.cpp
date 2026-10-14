//===- RISCVZttEmitter.cpp - RISC-V Ztt builtin tables ----------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "TableGenBackends.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/TableGen/Record.h"

using namespace llvm;

void clang::EmitRISCVZtt(const RecordKeeper &Records, raw_ostream &OS) {
  // Use the common generator for builtin IDs, strings and registration.
  EmitClangBuiltins(Records, OS);
  auto Operations = Records.getAllDerivedDefinitions("RISCVZttOperation");

  OS << "#ifdef GET_RISCV_ZTT_OPERATION_ENUM\n";
  for (const Record *Op : Operations)
    OS << "  " << Op->getName() << ",\n";
  OS << "#endif\n\n";

  // One entry per operation; datatype and shape do not add builtin IDs.
  OS << "#ifdef GET_RISCV_ZTT_BUILTIN_TABLE\n";
  for (const Record *Op : Operations) {
    StringRef Name = Op->getValueAsString("Name");
    OS << "  {BI__builtin_riscv_ztt_" << Name
       << ", RISCVZttOperation::" << Op->getName() << ", \"" << Name << "\", "
       << "RISCVZttResultKind::" << Op->getValueAsString("ResultKind") << ", "
       << "RISCVZttResultTypeKind::" << Op->getValueAsString("ResultTypeKind")
       << ", " << Op->getValueAsInt("MaxResultSquares") << ", "
       << Op->getValueAsInt("MinResultSquares") << "},\n";
  }
  OS << "#endif\n";
}
