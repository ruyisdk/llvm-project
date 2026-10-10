; RUN: split-file %s %t
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt %t/invalid.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=INVALID
; RUN: not --crash llc -mtriple=riscv64 %t/no-ztt.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=NOZTT
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt %t/empty.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=EMPTY
; RUN: not llc -ztt-profile=clang-runtime-u32-m16-a4 %t/no-ztt.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=OPTION
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt %t/missing.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=MISSING
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt %t/missing.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=MISSING

; INVALID: LLVM ERROR: invalid Ztt profile 'clang-runtime-u24-m16-a4'
; NOZTT: LLVM ERROR: Ztt profile requires the Ztt extension
; EMPTY: LLVM ERROR: invalid Ztt profile ''
; OPTION: Unknown command line argument '-ztt-profile=clang-runtime-u32-m16-a4'
; MISSING: LLVM ERROR: Ztt code generation requires a Ztt profile

;--- invalid.ll
define void @test() "riscv-ztt-profile"="clang-runtime-u24-m16-a4" {
  ret void
}

;--- no-ztt.ll
define void @plain() {
  ret void
}

define void @test() "riscv-ztt-profile"="clang-runtime-u32-m16-a4" {
  ret void
}

;--- empty.ll
define void @test() "riscv-ztt-profile"="" {
  ret void
}

;--- missing.ll
define void @configured() "riscv-ztt-profile"="clang-runtime-u32-m16-a4" {
  ret void
}

define void @missing() {
  ret void
}
