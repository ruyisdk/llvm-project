; RUN: split-file %s %t
; RUN: not llvm-as < %t/m.ll -o /dev/null 2>&1 | FileCheck %s
; RUN: not llvm-as < %t/acc.ll -o /dev/null 2>&1 | FileCheck %s

; CHECK: error: invalid type for null constant

;--- m.ll
define target("riscv.ztt.m.i16", i16, 16, 2, 2) @invalid() {
  ret target("riscv.ztt.m.i16", i16, 16, 2, 2) zeroinitializer
}

;--- acc.ll
define target("riscv.ztt.acc.i16", i16, 16, 16) @invalid_accx16() {
  ret target("riscv.ztt.acc.i16", i16, 16, 16) zeroinitializer
}
