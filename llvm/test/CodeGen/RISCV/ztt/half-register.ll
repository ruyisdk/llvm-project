; RUN: split-file %s %t
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/i4.ll -o - 2>&1 | FileCheck %s
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/i4.ll -o - 2>&1 | FileCheck %s
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/half-result.ll > %t.ztt-profile-0.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o - 2>&1 | FileCheck %s
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/half-result.ll > %t.ztt-profile-1.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o - 2>&1 | FileCheck %s
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/half-source.ll > %t.ztt-profile-2.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-2.ll -o - 2>&1 | FileCheck %s
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/half-source.ll > %t.ztt-profile-3.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-3.ll -o - 2>&1 | FileCheck %s

; CHECK: LLVM ERROR: Ztt half-register M types are not supported

; Cover a sub-byte result and mixed-width operation result/source layouts.
; These are common register-layout restrictions, not arithmetic restrictions.
;--- i4.ll
declare target("riscv.ztt.m.i4", i4, 4, 1, 1)
  @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i4_i4_4_1_1t(i32, i32)

define target("riscv.ztt.m.i4", i4, 4, 1, 1)
    @mclear_half_register_i4_1x1_uds8() #0 {
  %res = call target("riscv.ztt.m.i4", i4, 4, 1, 1)
    @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i4_i4_4_1_1t(i32 1073741828, i32 1)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 1) %res
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }

;--- half-result.ll
define target("riscv.ztt.m.i16", i16, 16, 1, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %d
}
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)


;--- half-source.ll
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i16", i16, 16, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
