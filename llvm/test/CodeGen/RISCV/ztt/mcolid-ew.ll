; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/input.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s --check-prefix=IR
; RUN: sed 's/iXLEN/i64/g' %t/input.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s --check-prefix=IR
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_0.mir > %t.ztt-profile-0.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-0.mir -o - | FileCheck %s --check-prefix=CASE0
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_0.mir > %t.ztt-profile-1.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-1.mir -o - | FileCheck %s --check-prefix=CASE0
; CASE0-LABEL: layout_0:
; CASE0-NEXT: # %bb.0:
; CASE0-NEXT: msettyp m0, a0
; CASE0-NEXT: mcolid.ew m0
; CASE0-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %s --check-prefix=CASE1
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %s --check-prefix=CASE1
; CASE1-LABEL: layout_1:
; CASE1-NEXT: # %bb.0:
; CASE1-NEXT: msettyp m0, a0
; CASE1-NEXT: mcolid.ew m0
; CASE1-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %s --check-prefix=CASE2
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %s --check-prefix=CASE2
; CASE2-LABEL: layout_2:
; CASE2-NEXT: # %bb.0:
; CASE2-NEXT: msettyp m0, a0
; CASE2-NEXT: mcolid.ew m0
; CASE2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=CASE3
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=CASE3
; CASE3-LABEL: layout_3:
; CASE3-NEXT: # %bb.0:
; CASE3-NEXT: msettyp m0, a0
; CASE3-NEXT: mcolid.ew m0
; CASE3-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=CASE4
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=CASE4
; CASE4-LABEL: layout_4:
; CASE4-NEXT: # %bb.0:
; CASE4-NEXT: msettyp m0, a0
; CASE4-NEXT: mcolid.ew m0
; CASE4-NEXT: ret

;--- layout_0.mir
--- |
  define void @layout_0() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_0
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    $zttm0m4 = PseudoZTTMcolidEw_G004 $x10, 1, 4
    PseudoRET implicit $zttm0m4
...

;--- layout_1.mir
--- |
  define void @layout_1() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_1
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    $zttm0m2 = PseudoZTTMcolidEw_G002 $x10, 1, 2
    PseudoRET implicit $zttm0m2
...

;--- layout_2.mir
--- |
  define void @layout_2() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_2
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    $zttm0 = PseudoZTTMcolidEw_G001 $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- layout_3.mir
--- |
  define void @layout_3() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_3
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    $zttm0 = PseudoZTTMcolidEw_G001 $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- layout_4.mir
--- |
  define void @layout_4() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_4
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    $zttm0 = PseudoZTTMcolidEw_G001 $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- input.ll
; Full lowering and allocation, including datatype and packed footprints.
; IR-LABEL: ir_0:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret
; IR-LABEL: ir_1:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret
; IR-LABEL: ir_2:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret
; IR-LABEL: ir_3:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 64
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret
; IR-LABEL: ir_4:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 64
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret
; IR-LABEL: ir_5:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret
; IR-LABEL: ir_6:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolid.ew	m0
; IR-NEXT: ret


define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_0() #0 {
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew.case0(i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_1() #1 {
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew.case1(i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_2() #2 {
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew.case2(i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @ir_3() #3 {
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolid.ew.case3(i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @ir_4() #4 {
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolid.ew.case4(i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @ir_5() #5 {
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolid.ew.case5(i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @ir_6() #6 {
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolid.ew.case6(i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolid.ew.case5(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolid.ew.case6(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew.case0(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew.case1(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolid.ew.case2(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolid.ew.case3(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolid.ew.case4(i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
