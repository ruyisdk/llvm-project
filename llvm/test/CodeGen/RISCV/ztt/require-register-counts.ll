; RUN: sed 's/PROFILE/clang-runtime-u16-a4/' %s | not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -o - 2>&1 | FileCheck %s --check-prefix=M
; RUN: sed 's/PROFILE/clang-runtime-u16-a4/' %s | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o - 2>&1 | FileCheck %s --check-prefix=M
; RUN: sed 's/PROFILE/clang-runtime-u16-m16/' %s | not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -o - 2>&1 | FileCheck %s --check-prefix=A
; RUN: sed 's/PROFILE/clang-runtime-u16-m16/' %s | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o - 2>&1 | FileCheck %s --check-prefix=A
; M: LLVM ERROR: invalid Ztt profile 'clang-runtime-u16-a4'
; A: LLVM ERROR: invalid Ztt profile 'clang-runtime-u16-m16'
; RUN: sed 's/PROFILE/clang-runtime-u16-m16-m32-a4/' %s | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o - 2>&1 | FileCheck %s --check-prefix=DUP-M
; RUN: sed 's/PROFILE/clang-runtime-u16-m16-a4-a8/' %s | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o - 2>&1 | FileCheck %s --check-prefix=DUP-A
; DUP-M: LLVM ERROR: invalid Ztt profile 'clang-runtime-u16-m16-m32-a4'
; DUP-A: LLVM ERROR: invalid Ztt profile 'clang-runtime-u16-m16-a4-a8'

; Configuration is checked before instruction selection, even for an intrinsic
; without matrix operands. Matrix capacity has separate register-capacity tests.
declare void @llvm.riscv.ztt.ame.release()
define void @require_profiles() "riscv-ztt-profile"="PROFILE" {
  call void @llvm.riscv.ztt.ame.release()
  ret void
}
