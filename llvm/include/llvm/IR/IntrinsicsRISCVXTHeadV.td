//===- IntrinsicsRISCVXTHeadV.td - RVV 0.7.1 intrinsics ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines all of RISC-V Vector Extension version 0.7.1 intrinsics.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Vectors version 0.7.1

let TargetPrefix = "riscv" in {
  // 6. Configuration-Setting and Utility
  def int_riscv_xvsetvl    : Intrinsic<[llvm_i64_ty],
                                       [/* AVL */ llvm_i64_ty, /* SEW */ llvm_i64_ty, /* LMUL */ llvm_i64_ty],
                                       [IntrNoMem]>;
  def int_riscv_xvsetvlmax : Intrinsic<[llvm_i64_ty],
                                       [/* SEW */ llvm_i64_ty, /* LMUL */ llvm_i64_ty],
                                       [IntrNoMem]>;

  defm xvadd : RISCVBinaryAAX;

} // TargetPrefix = "riscv"
