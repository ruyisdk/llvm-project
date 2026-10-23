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
; CASE0-NEXT: msettyp m2, a0
; CASE0-NEXT: mbcast.m.x m0, a2, a1
; CASE0-NEXT: mbcast.m.x m2, a2, a1
; CASE0-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %s --check-prefix=CASE1
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %s --check-prefix=CASE1
; CASE1-LABEL: layout_1:
; CASE1-NEXT: # %bb.0:
; CASE1-NEXT: msettyp m0, a0
; CASE1-NEXT: msettyp m1, a0
; CASE1-NEXT: mbcast.m.x m0, a2, a1
; CASE1-NEXT: mbcast.m.x m1, a2, a1
; CASE1-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %s --check-prefix=CASE2
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %s --check-prefix=CASE2
; CASE2-LABEL: layout_2:
; CASE2-NEXT: # %bb.0:
; CASE2-NEXT: msettyp m0, a0
; CASE2-NEXT: mbcast.m.x m0, a2, a1
; CASE2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=CASE3
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=CASE3
; CASE3-LABEL: layout_3:
; CASE3-NEXT: # %bb.0:
; CASE3-NEXT: msettyp m0, a0
; CASE3-NEXT: msettyp m1, a0
; CASE3-NEXT: mbcast.m.x m0, a2, a1
; CASE3-NEXT: mbcast.m.x m1, a2, a1
; CASE3-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=CASE4
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=CASE4
; CASE4-LABEL: layout_4:
; CASE4-NEXT: # %bb.0:
; CASE4-NEXT: msettyp m0, a0
; CASE4-NEXT: msettyp m1, a0
; CASE4-NEXT: mbcast.m.x m0, a2, a1
; CASE4-NEXT: mbcast.m.x m1, a2, a1
; CASE4-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_5.mir > %t.ztt-profile-10.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-10.mir -o - | FileCheck %s --check-prefix=CASE5
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_5.mir > %t.ztt-profile-11.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-11.mir -o - | FileCheck %s --check-prefix=CASE5
; CASE5-LABEL: layout_5:
; CASE5-NEXT: # %bb.0:
; CASE5-NEXT: msettyp m0, a0
; CASE5-NEXT: msettyp m1, a0
; CASE5-NEXT: mbcast.m.x m0, a2, a1
; CASE5-NEXT: mbcast.m.x m1, a2, a1
; CASE5-NEXT: ret

;--- layout_0.mir
--- |
  define void @layout_0() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_0
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $x11, $x12
    $zttm0m4 = PseudoZTTMbcastMX_G004 $x12, $x10, $x11, 2, 2
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
    liveins: $x10, $x11, $x12
    $zttm0m2 = PseudoZTTMbcastMX_G002 $x12, $x10, $x11, 2, 1
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
    liveins: $x10, $x11, $x12
    $zttm0 = PseudoZTTMbcastMX_G001 $x12, $x10, $x11, 1, 1
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
    liveins: $x10, $x11, $x12
    $zttm0m2 = PseudoZTTMbcastMX_G002 $x12, $x10, $x11, 2, 1
    PseudoRET implicit $zttm0m2
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
    liveins: $x10, $x11, $x12
    $zttm0m2 = PseudoZTTMbcastMX_G002 $x12, $x10, $x11, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_5.mir
--- |
  define void @layout_5() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_5
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $x11, $x12
    $zttm0m2 = PseudoZTTMbcastMX_G002 $x12, $x10, $x11, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- input.ll
; Full lowering and allocation, including datatype and packed footprints.
; IR-LABEL: ir_0:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m2, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m2, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_1:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m2, a2
; IR-NEXT: msettyp	m4, a2
; IR-NEXT: msettyp	m6, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m2, a0, a1
; IR-NEXT: mbcast.m.x	m4, a0, a1
; IR-NEXT: mbcast.m.x	m6, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_2:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: addi	a2, a1, 272
; IR-NEXT: addi	a1, a1, 288
; IR-NEXT: msettyp	m0, a1
; IR-NEXT: mbcast.m.x	m0, a0, a2
; IR-NEXT: ret
; IR-LABEL: ir_3:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m1, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m1, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_4:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m1, a2
; IR-NEXT: msettyp	m2, a2
; IR-NEXT: msettyp	m3, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m1, a0, a1
; IR-NEXT: mbcast.m.x	m2, a0, a1
; IR-NEXT: mbcast.m.x	m3, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_5:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: addi	a2, a1, 272
; IR-NEXT: addi	a1, a1, 288
; IR-NEXT: msettyp	m0, a1
; IR-NEXT: mbcast.m.x	m0, a0, a2
; IR-NEXT: ret
; IR-LABEL: ir_6:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_7:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m1, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m1, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_8:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: addi	a2, a1, 272
; IR-NEXT: addi	a1, a1, 288
; IR-NEXT: msettyp	m0, a1
; IR-NEXT: mbcast.m.x	m0, a0, a2
; IR-NEXT: ret
; IR-LABEL: ir_9:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_10:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m1, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m1, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_11:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: addi	a2, a1, 272
; IR-NEXT: addi	a1, a1, 288
; IR-NEXT: msettyp	m0, a1
; IR-NEXT: mbcast.m.x	m0, a0, a2
; IR-NEXT: ret
; IR-LABEL: ir_12:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_13:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 16
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: msettyp	m1, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: mbcast.m.x	m1, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_14:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: addi	a2, a1, 272
; IR-NEXT: addi	a1, a1, 288
; IR-NEXT: msettyp	m0, a1
; IR-NEXT: mbcast.m.x	m0, a0, a2
; IR-NEXT: ret
; IR-LABEL: ir_15:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: addi	a2, a2, 4
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: ret
; IR-LABEL: ir_16:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a1, 131840
; IR-NEXT: addi	a1, a1, 272
; IR-NEXT: li	a2, 4
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mbcast.m.x	m0, a0, a1
; IR-NEXT: ret


define target("riscv.ztt.m.i16", i16, 16, 1, 2) @ir_0(iXLEN %scalar) #0 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case0(iXLEN %scalar, i32 1073741840, i32 540016912, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @ir_1(iXLEN %scalar) #1 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mbcast.m.x.case1(iXLEN %scalar, i32 1073741840, i32 540016912, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @ir_2(iXLEN %scalar) #2 {
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x.case2(iXLEN %scalar, i32 540016928, i32 540016912, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @ir_3(iXLEN %scalar) #3 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case3(iXLEN %scalar, i32 1073741840, i32 540016912, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @ir_4(iXLEN %scalar) #4 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mbcast.m.x.case4(iXLEN %scalar, i32 1073741840, i32 540016912, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @ir_5(iXLEN %scalar) #5 {
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x.case5(iXLEN %scalar, i32 540016928, i32 540016912, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @ir_6(iXLEN %scalar) #6 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case6(iXLEN %scalar, i32 1073741840, i32 540016912, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @ir_7(iXLEN %scalar) #7 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mbcast.m.x.case7(iXLEN %scalar, i32 1073741840, i32 540016912, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @ir_8(iXLEN %scalar) #8 {
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x.case8(iXLEN %scalar, i32 540016928, i32 540016912, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @ir_9(iXLEN %scalar) #9 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mbcast.m.x.case9(iXLEN %scalar, i32 1073741840, i32 540016912, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 8, 1) @ir_10(iXLEN %scalar) #10 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mbcast.m.x.case10(iXLEN %scalar, i32 1073741840, i32 540016912, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 8, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 2) @ir_11(iXLEN %scalar) #11 {
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case11(iXLEN %scalar, i32 540016928, i32 540016912, i32 2)
  ret target("riscv.ztt.m.f32", float, 32, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @ir_12(iXLEN %scalar) #12 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mbcast.m.x.case12(iXLEN %scalar, i32 1073741840, i32 540016912, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %r
}

define target("riscv.ztt.m.i16", i16, 16, 16, 1) @ir_13(iXLEN %scalar) #13 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mbcast.m.x.case13(iXLEN %scalar, i32 1073741840, i32 540016912, i32 16)
  ret target("riscv.ztt.m.i16", i16, 16, 16, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 4) @ir_14(iXLEN %scalar) #14 {
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mbcast.m.x.case14(iXLEN %scalar, i32 540016928, i32 540016912, i32 4)
  ret target("riscv.ztt.m.f32", float, 32, 1, 4) %r
}

define target("riscv.ztt.m.i4", i4, 4, 1, 8) @ir_15(iXLEN %scalar) #15 {
  %r = call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mbcast.m.x.case15(iXLEN %scalar, i32 1073741828, i32 540016912, i32 8)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 8) %r
}

define target("riscv.ztt.m.u4", i4, 4, 8, 1) @ir_16(iXLEN %scalar) #16 {
  %r = call target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mbcast.m.x.case16(iXLEN %scalar, i32 4, i32 540016912, i32 8)
  ret target("riscv.ztt.m.u4", i4, 4, 8, 1) %r
}

declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x.case2(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x.case5(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mbcast.m.x.case8(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case11(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mbcast.m.x.case14(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case0(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case3(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mbcast.m.x.case6(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mbcast.m.x.case9(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mbcast.m.x.case12(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mbcast.m.x.case13(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mbcast.m.x.case1(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mbcast.m.x.case4(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mbcast.m.x.case7(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mbcast.m.x.case10(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mbcast.m.x.case15(iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mbcast.m.x.case16(iXLEN, i32 immarg, i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #12 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #13 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #14 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #15 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #16 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
