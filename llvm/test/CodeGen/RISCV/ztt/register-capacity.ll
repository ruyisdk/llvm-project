; RUN: split-file %s %t
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a4/g' %t/architecture.ll > %t.ztt-profile-0.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o - 2>&1 | FileCheck %s --check-prefix=ARCH
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a4/g' %t/architecture.ll > %t.ztt-profile-1.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o - 2>&1 | FileCheck %s --check-prefix=ARCH
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m16-a4/g' %t/architecture.ll > %t.ztt-profile-2.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-2.ll -o - 2>&1 | FileCheck %s --check-prefix=ARCH
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m16-a4/g' %t/m.ll > %t.ztt-profile-3.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-3.ll -o - 2>&1 | FileCheck %s --check-prefix=M
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m16-a4/g' %t/a.ll > %t.ztt-profile-4.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-4.ll -o - 2>&1 | FileCheck %s --check-prefix=A
; M: LLVM ERROR: Ztt M type exceeds the configured register count
; A: LLVM ERROR: Ztt ACC type exceeds the configured register count
; ARCH: LLVM ERROR: Ztt M-register group requires more than 32 registers

; Architectural overflow must be diagnosed for both M32 and M16. The logical
; value occupies 64 physical M registers at UDS8; no allocation is attempted.
;--- architecture.ll
define void @architecture(ptr %p) "riscv-ztt-profile"="ZTT_PROFILE" {
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 32) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_32t(i32 1073741840, i32 32)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_32t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 32) %v, i32 1073741840, i32 32)
  ret void
}
declare target("riscv.ztt.m.i16", i16, 16, 1, 32) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_32t(i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_32t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 32), i32, i32)

;--- m.ll
define void @too_many_m(ptr %p) "riscv-ztt-profile"="ZTT_PROFILE" {
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_16t(i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 16) %v, i32 1073741840, i32 16)
  ret void
}
declare target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_16t(i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32, i32)

;--- a.ll
define target("riscv.ztt.acc.i16", i16, 16, 8) @too_many_acc() "riscv-ztt-profile"="ZTT_PROFILE" {
  %v = call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i16_i16_16_8t(i32 1073741840, i32 8)
  ret target("riscv.ztt.acc.i16", i16, 16, 8) %v
}
declare target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i16_i16_16_8t(i32, i32 immarg)
