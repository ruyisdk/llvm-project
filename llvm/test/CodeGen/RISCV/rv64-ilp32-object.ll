; RUN: llc -mtriple=riscv64 -target-abi=ilp32 -filetype=obj < %s | llvm-readobj -h - | FileCheck %s
;
; CHECK:      Class: 32-bit (0x1)
; CHECK:      Flags [ (0x0)
; CHECK-NEXT: ]
define void @foo() {
  ret void
}
