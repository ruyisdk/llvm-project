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
; CASE0-NEXT: mreduceadd.row m0, m8
; CASE0-NEXT: mreduceadd.row m2, m12
; CASE0-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %s --check-prefix=CASE1
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %s --check-prefix=CASE1
; CASE1-LABEL: layout_1:
; CASE1-NEXT: # %bb.0:
; CASE1-NEXT: msettyp m0, a0
; CASE1-NEXT: msettyp m1, a0
; CASE1-NEXT: mreduceadd.row m0, m4
; CASE1-NEXT: mreduceadd.row m1, m6
; CASE1-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %s --check-prefix=CASE2
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %s --check-prefix=CASE2
; CASE2-LABEL: layout_2:
; CASE2-NEXT: # %bb.0:
; CASE2-NEXT: msettyp m0, a0
; CASE2-NEXT: mreduceadd.row m0, m2
; CASE2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=CASE3
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=CASE3
; CASE3-LABEL: layout_3:
; CASE3-NEXT: # %bb.0:
; CASE3-NEXT: msettyp m0, a0
; CASE3-NEXT: msettyp m1, a0
; CASE3-NEXT: mreduceadd.row m0, m4
; CASE3-NEXT: mreduceadd.row m1, m6
; CASE3-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=CASE4
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=CASE4
; CASE4-LABEL: layout_4:
; CASE4-NEXT: # %bb.0:
; CASE4-NEXT: msettyp m0, a0
; CASE4-NEXT: msettyp m1, a0
; CASE4-NEXT: mreduceadd.row m0, m4
; CASE4-NEXT: mreduceadd.row m1, m6
; CASE4-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_5.mir > %t.ztt-profile-10.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-10.mir -o - | FileCheck %s --check-prefix=CASE5
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_5.mir > %t.ztt-profile-11.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-11.mir -o - | FileCheck %s --check-prefix=CASE5
; CASE5-LABEL: layout_5:
; CASE5-NEXT: # %bb.0:
; CASE5-NEXT: msettyp m0, a0
; CASE5-NEXT: msettyp m1, a0
; CASE5-NEXT: mreduceadd.row m0, m4
; CASE5-NEXT: mreduceadd.row m1, m6
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
    liveins: $x10, $zttm8m8
    $zttm0m4 = PseudoZTTMreduceaddRow_G004_G108 $zttm8m8, $x10, 2, 2
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
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMreduceaddRow_G002_G104 $zttm4m4, $x10, 2, 1
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
    liveins: $x10, $zttm2m2
    $zttm0 = PseudoZTTMreduceaddRow_G001_G102 $zttm2m2, $x10, 1, 1
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
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMreduceaddRow_G002_G104 $zttm4m4, $x10, 2, 1
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
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMreduceaddRow_G002_G104 $zttm4m4, $x10, 2, 1
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
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMreduceaddRow_G002_G104 $zttm4m4, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- input.ll
; Full lowering and allocation, including datatype and packed footprints.
; IR-LABEL: ir_0:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m8, a1
; IR-NEXT: msettyp	m12, a1
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: mzero.2d.m	m12
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: mreduceadd.row	m0, m8
; IR-NEXT: mreduceadd.row	m2, m12
; IR-NEXT: ret
; IR-LABEL: ir_1:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m16, a1
; IR-NEXT: msettyp	m20, a1
; IR-NEXT: msettyp	m24, a1
; IR-NEXT: msettyp	m28, a1
; IR-NEXT: mzero.2d.m	m16
; IR-NEXT: mzero.2d.m	m20
; IR-NEXT: mzero.2d.m	m24
; IR-NEXT: mzero.2d.m	m28
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: msettyp	m4, a0
; IR-NEXT: msettyp	m6, a0
; IR-NEXT: mreduceadd.row	m0, m16
; IR-NEXT: mreduceadd.row	m2, m20
; IR-NEXT: mreduceadd.row	m4, m24
; IR-NEXT: mreduceadd.row	m6, m28
; IR-NEXT: ret
; IR-LABEL: ir_2:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 131840
; IR-NEXT: addi	a1, a0, 272
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: addi	a0, a0, 288
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m4
; IR-NEXT: ret
; IR-LABEL: ir_3:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: msettyp	m6, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: mzero.2d.m	m6
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mreduceadd.row	m0, m4
; IR-NEXT: mreduceadd.row	m1, m6
; IR-NEXT: ret
; IR-LABEL: ir_4:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m8, a1
; IR-NEXT: msettyp	m10, a1
; IR-NEXT: msettyp	m12, a1
; IR-NEXT: msettyp	m14, a1
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: mzero.2d.m	m10
; IR-NEXT: mzero.2d.m	m12
; IR-NEXT: mzero.2d.m	m14
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: msettyp	m3, a0
; IR-NEXT: mreduceadd.row	m0, m8
; IR-NEXT: mreduceadd.row	m1, m10
; IR-NEXT: mreduceadd.row	m2, m12
; IR-NEXT: mreduceadd.row	m3, m14
; IR-NEXT: ret
; IR-LABEL: ir_5:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 131840
; IR-NEXT: addi	a1, a0, 272
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: addi	a0, a0, 288
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_6:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: msettyp	m3, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mzero.2d.m	m3
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_7:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: msettyp	m5, a1
; IR-NEXT: msettyp	m6, a1
; IR-NEXT: msettyp	m7, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: mzero.2d.m	m5
; IR-NEXT: mzero.2d.m	m6
; IR-NEXT: mzero.2d.m	m7
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mreduceadd.row	m0, m4
; IR-NEXT: mreduceadd.row	m1, m6
; IR-NEXT: ret
; IR-LABEL: ir_8:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: lui	a1, 131840
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: addi	a0, a1, 288
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_9:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: msettyp	m3, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mzero.2d.m	m3
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_10:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: msettyp	m5, a1
; IR-NEXT: msettyp	m6, a1
; IR-NEXT: msettyp	m7, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: mzero.2d.m	m5
; IR-NEXT: mzero.2d.m	m6
; IR-NEXT: mzero.2d.m	m7
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mreduceadd.row	m0, m4
; IR-NEXT: mreduceadd.row	m1, m6
; IR-NEXT: ret
; IR-LABEL: ir_11:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: lui	a1, 131840
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: msettyp	m3, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mzero.2d.m	m3
; IR-NEXT: addi	a0, a1, 288
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_12:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: msettyp	m3, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mzero.2d.m	m3
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_13:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a1, a0, 32
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: msettyp	m5, a1
; IR-NEXT: msettyp	m6, a1
; IR-NEXT: msettyp	m7, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: mzero.2d.m	m5
; IR-NEXT: mzero.2d.m	m6
; IR-NEXT: mzero.2d.m	m7
; IR-NEXT: addi	a0, a0, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mreduceadd.row	m0, m4
; IR-NEXT: mreduceadd.row	m1, m6
; IR-NEXT: ret
; IR-LABEL: ir_14:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: lui	a1, 131840
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: msettyp	m3, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mzero.2d.m	m3
; IR-NEXT: addi	a0, a1, 288
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mreduceadd.row	m0, m2
; IR-NEXT: ret


define target("riscv.ztt.m.i16", i16, 16, 1, 2) @ir_0() #0 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.i32_1x2(i32 1073741856, i32 2)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case0(target("riscv.ztt.m.i32", i32, 32, 1, 2) %v0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @ir_1() #1 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mzero.m.i32_4x1(i32 1073741856, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mreduceadd.row.case1(target("riscv.ztt.m.i32", i32, 32, 4, 1) %v0, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @ir_2() #2 {
  %v0 = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mzero.m.bf16_1x1(i32 540016912, i32 1)
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mreduceadd.row.case2(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %v0, i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @ir_3() #3 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.i32_1x2(i32 1073741856, i32 2)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case3(target("riscv.ztt.m.i32", i32, 32, 1, 2) %v0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @ir_4() #4 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mzero.m.i32_4x1(i32 1073741856, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mreduceadd.row.case4(target("riscv.ztt.m.i32", i32, 32, 4, 1) %v0, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @ir_5() #5 {
  %v0 = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mzero.m.bf16_1x1(i32 540016912, i32 1)
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mreduceadd.row.case5(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %v0, i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @ir_6() #6 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.i32_1x2(i32 1073741856, i32 2)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case6(target("riscv.ztt.m.i32", i32, 32, 1, 2) %v0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @ir_7() #7 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mzero.m.i32_4x1(i32 1073741856, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mreduceadd.row.case7(target("riscv.ztt.m.i32", i32, 32, 4, 1) %v0, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @ir_8() #8 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mreduceadd.row.case8(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @ir_9() #9 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mzero.m.i32_1x4(i32 1073741856, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mreduceadd.row.case9(target("riscv.ztt.m.i32", i32, 32, 1, 4) %v0, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 8, 1) @ir_10() #10 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 8, 1) @llvm.riscv.ztt.mzero.m.i32_8x1(i32 1073741856, i32 8)
  %r = call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mreduceadd.row.case10(target("riscv.ztt.m.i32", i32, 32, 8, 1) %v0, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 8, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 2) @ir_11() #11 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mzero.m.f64_1x2(i32 741343552, i32 2)
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case11(target("riscv.ztt.m.f64", double, 64, 1, 2) %v0, i32 540016928, i32 2)
  ret target("riscv.ztt.m.f32", float, 32, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @ir_12() #12 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mzero.m.i32_1x8(i32 1073741856, i32 8)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mreduceadd.row.case12(target("riscv.ztt.m.i32", i32, 32, 1, 8) %v0, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %r
}

define target("riscv.ztt.m.i16", i16, 16, 16, 1) @ir_13() #13 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 16, 1) @llvm.riscv.ztt.mzero.m.i32_16x1(i32 1073741856, i32 16)
  %r = call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mreduceadd.row.case13(target("riscv.ztt.m.i32", i32, 32, 16, 1) %v0, i32 1073741840, i32 16)
  ret target("riscv.ztt.m.i16", i16, 16, 16, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 4) @ir_14() #14 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 4) @llvm.riscv.ztt.mzero.m.f64_1x4(i32 741343552, i32 4)
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mreduceadd.row.case14(target("riscv.ztt.m.f64", double, 64, 1, 4) %v0, i32 540016928, i32 4)
  ret target("riscv.ztt.m.f32", float, 32, 1, 4) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mzero.m.bf16_1x1(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mreduceadd.row.case2(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mreduceadd.row.case5(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mreduceadd.row.case8(target("riscv.ztt.m.f64", double, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case11(target("riscv.ztt.m.f64", double, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mreduceadd.row.case14(target("riscv.ztt.m.f64", double, 64, 1, 4), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32, i32)
declare target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mzero.m.f64_1x2(i32, i32)
declare target("riscv.ztt.m.f64", double, 64, 1, 4) @llvm.riscv.ztt.mzero.m.f64_1x4(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case0(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case3(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mreduceadd.row.case6(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mreduceadd.row.case9(target("riscv.ztt.m.i32", i32, 32, 1, 4), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mreduceadd.row.case12(target("riscv.ztt.m.i32", i32, 32, 1, 8), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mreduceadd.row.case13(target("riscv.ztt.m.i32", i32, 32, 16, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mreduceadd.row.case1(target("riscv.ztt.m.i32", i32, 32, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mreduceadd.row.case4(target("riscv.ztt.m.i32", i32, 32, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mreduceadd.row.case7(target("riscv.ztt.m.i32", i32, 32, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mreduceadd.row.case10(target("riscv.ztt.m.i32", i32, 32, 8, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.i32_1x2(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mzero.m.i32_1x4(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mzero.m.i32_1x8(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 16, 1) @llvm.riscv.ztt.mzero.m.i32_16x1(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mzero.m.i32_4x1(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 8, 1) @llvm.riscv.ztt.mzero.m.i32_8x1(i32, i32)
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
