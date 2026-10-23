//===- BuiltinsRISCVZtt.td - RISC-V Ztt builtins ------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

include "clang/Basic/BuiltinsBase.td"
include "llvm/IR/RISCVZttOperations.td"

foreach Op = !instances<RISCVZttOperation>() in
{
  // Matrix arguments and results need custom type checking. State interfaces
  // have ordinary C prototypes.
  def riscv_ztt_#Op.Name : TargetBuiltin
  {
    let Spellings = ["__builtin_riscv_ztt_" # Op.Name];
    let Features = "ztt";
    let Attributes = !if(!isa<RISCVZttState>(Op), [NoThrow],
                         [NoThrow, CustomTypeChecking]);
    let Prototype = !cond(
        !isa<RISCVZttCSRRead>(Op): "size_t()",
        !eq(Op.Name, "ame_acquire"): "size_t(size_t)",
        !eq(Op.Name, "ame_release"): "void()",
        true: "void(...)");
  }
}
