; RUN: split-file %s %t
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -asm-verbose=false %t/fixed.ll -o - | FileCheck %s --check-prefixes=CHECK,ZTT
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -asm-verbose=false %t/fixed.ll -o - | FileCheck %s --check-prefixes=CHECK,ZTT
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -asm-verbose=false %t/runtime.ll -o - | FileCheck %s --check-prefixes=CHECK,ZTT
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -asm-verbose=false %t/runtime.ll -o - | FileCheck %s --check-prefixes=CHECK,ZTT
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -asm-verbose=false %t/no-ztt.ll -o - | FileCheck %s --check-prefix=CHECK --implicit-check-not=_ztt
; RUN: llc -mtriple=riscv64 -verify-machineinstrs -asm-verbose=false %t/no-ztt.ll -o - | FileCheck %s --check-prefix=CHECK --implicit-check-not=_ztt

; Configuration is not part of the ISA architecture string. Fixed N must not
; insert a runtime check or otherwise alter ordinary scalar functions.
; ZTT: .attribute 5, "{{.*}}_ztt0p6"
; CHECK-LABEL: test:
; CHECK-NEXT: .cfi_startproc
; CHECK-NEXT: li a0, 1
; CHECK-NEXT: ret
; CHECK-NEXT: .Lfunc_end0:
; CHECK-NEXT: .size test, .Lfunc_end0-test
; CHECK-NEXT: .cfi_endproc

;--- fixed.ll
define i32 @test() "riscv-ztt-profile"="clang-n128-u32-m16-a4" {
  ret i32 1
}

;--- runtime.ll
define i32 @test() "riscv-ztt-profile"="clang-runtime-u32-m16-a4" {
  ret i32 1
}

;--- no-ztt.ll
define i32 @test() {
  ret i32 1
}
