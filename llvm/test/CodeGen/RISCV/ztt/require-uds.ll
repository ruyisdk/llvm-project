; RUN: split-file %s %t
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t/csr.ll -o - 2>&1 | FileCheck %s
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t/acquire.ll -o - 2>&1 | FileCheck %s
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t/release.ll -o - 2>&1 | FileCheck %s
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t/input.ll -o - 2>&1 | FileCheck %s
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t/input.mir -o - 2>&1 | FileCheck %s
; CHECK: LLVM ERROR: Ztt code generation requires a Ztt profile

; The profile supplies UDS and register counts for every Ztt function.
; Exercise the shared diagnostic through IR lowering and direct MIR expansion,
; which bypasses lowering. Do not repeat it for each intrinsic or spill opcode.
; CSR/resource intrinsics are regressions for the former matrix-only checking.
;--- input.ll
declare target("riscv.ztt.m.i16", i16, 16, 1, 1)
  @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_1t(i32 immarg, i32 immarg)

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @without_uds() {
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 1)
    @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_1t(i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %res
}

;--- input.mir
--- |
  define void @without_uds() { ret void }
...
---
name: without_uds
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $x11, $x12
    $zttm0m4, early-clobber $x13, early-clobber $x14 = PseudoZTTMRestoreM4 $x10, $x11, $x12, 4
    PseudoRET implicit $zttm0m4
...

;--- csr.ll
declare i64 @llvm.riscv.ztt.get.ameown.i64()
define i64 @csr() {
  %v = call i64 @llvm.riscv.ztt.get.ameown.i64()
  ret i64 %v
}

;--- acquire.ll
declare i64 @llvm.riscv.ztt.ame.acquire.i64(i64)
define i64 @acquire() {
  %v = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 0)
  ret i64 %v
}

;--- release.ll
declare void @llvm.riscv.ztt.ame.release()
define void @release() {
  call void @llvm.riscv.ztt.ame.release()
  ret void
}
