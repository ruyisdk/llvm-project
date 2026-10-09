//===-- RISCVInstrInfoZtt.td - Ztt instructions ----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

def ZTTMAsmOperand : AsmOperandClass {
  let Name = "ZTTMRegister";
  let RenderMethod = "addRegOperands";
  let PredicateMethod = "isZTTMRegister";
  let ParserMethod = "parseZTTMRegister";
  let DiagnosticType = "InvalidZTTMRegister";
}

def ZTTMOp : RegisterOperand<ZTTMR> {
  let ParserMatchClass = ZTTMAsmOperand;
  let DecoderMethod = "DecodeZTTMRRegisterClass";
}

def ZTTAAsmOperand : AsmOperandClass {
  let Name = "ZTTARegister";
  let RenderMethod = "addRegOperands";
  let PredicateMethod = "isZTTARegister";
  let ParserMethod = "parseZTTARegister";
  let DiagnosticType = "InvalidZTTARegister";
}

def ZTTAOp : RegisterOperand<ZTTAR> {
  let ParserMatchClass = ZTTAAsmOperand;
  let DecoderMethod = "DecodeZTTARRegisterClass";
}
