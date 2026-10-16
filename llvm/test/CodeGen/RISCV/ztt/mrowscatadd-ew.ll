; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/input.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s --check-prefix=IR
; RUN: sed 's/iXLEN/i64/g' %t/input.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s --check-prefix=IR
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_0.mir > %t.ztt-profile-0.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-0.mir -o - | FileCheck %s --check-prefix=CASE0
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_0.mir > %t.ztt-profile-1.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-1.mir -o - | FileCheck %s --check-prefix=CASE0
; CASE0-LABEL: layout_0:
; CASE0-NEXT: # %bb.0:
; CASE0-NEXT: mrowscatadd.ew m0, m4, m8
; CASE0-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %s --check-prefix=CASE1
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %s --check-prefix=CASE1
; CASE1-LABEL: layout_1:
; CASE1-NEXT: # %bb.0:
; CASE1-NEXT: mrowscatadd.ew m0, m2, m4
; CASE1-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %s --check-prefix=CASE2
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %s --check-prefix=CASE2
; CASE2-LABEL: layout_2:
; CASE2-NEXT: # %bb.0:
; CASE2-NEXT: mrowscatadd.ew m0, m1, m2
; CASE2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=CASE3
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=CASE3
; CASE3-LABEL: layout_3:
; CASE3-NEXT: # %bb.0:
; CASE3-NEXT: mrowscatadd.ew m0, m1, m2
; CASE3-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=CASE4
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=CASE4
; CASE4-LABEL: layout_4:
; CASE4-NEXT: # %bb.0:
; CASE4-NEXT: mrowscatadd.ew m0, m1, m2
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
    liveins: $x10, $zttm0m4, $zttm4m4, $zttm8m4
    $zttm0m4 = PseudoZTTMrowscataddEw_G004_G104_G204 $zttm0m4, $zttm4m4, $zttm8m4, $x10, 1, 4
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
    liveins: $x10, $zttm0m2, $zttm2m2, $zttm4m2
    $zttm0m2 = PseudoZTTMrowscataddEw_G002_G102_G202 $zttm0m2, $zttm2m2, $zttm4m2, $x10, 1, 2
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
    liveins: $x10, $zttm0, $zttm1, $zttm2
    $zttm0 = PseudoZTTMrowscataddEw_G001_G101_G201 $zttm0, $zttm1, $zttm2, $x10, 1, 1
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
    liveins: $x10, $zttm0, $zttm1, $zttm2
    $zttm0 = PseudoZTTMrowscataddEw_G001_G101_G201 $zttm0, $zttm1, $zttm2, $x10, 1, 1
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
    liveins: $x10, $zttm0, $zttm1, $zttm2
    $zttm0 = PseudoZTTMrowscataddEw_G001_G101_G201 $zttm0, $zttm1, $zttm2, $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- input.ll
; Full lowering and allocation, including datatype and packed footprints.
; IR-LABEL: ir_0:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: mrowscatadd.ew	m0, m0, m4
; IR-NEXT: ret
; IR-LABEL: ir_1:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: lui	a1, 262144
; IR-NEXT: li	a2, 8
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: addi	a1, a1, 8
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m8, a1
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: msettyp	m9, a2
; IR-NEXT: mzero.2d.m	m9
; IR-NEXT: mrowscatadd.ew	m0, m8, m9
; IR-NEXT: ret
; IR-LABEL: ir_2:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mrowscatadd.ew	m0, m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_3:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: lui	a1, 262144
; IR-NEXT: li	a2, 16
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: addi	a1, a1, 16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m5, a2
; IR-NEXT: mzero.2d.m	m5
; IR-NEXT: mrowscatadd.ew	m0, m4, m5
; IR-NEXT: ret
; IR-LABEL: ir_4:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m1, a1
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: mrowscatadd.ew	m0, m0, m1
; IR-NEXT: ret
; IR-LABEL: ir_5:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 64
; IR-NEXT: li	a1, 64
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mrowscatadd.ew	m0, m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_6:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: lui	a1, 262144
; IR-NEXT: li	a2, 32
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: addi	a1, a1, 32
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m3, a2
; IR-NEXT: mzero.2d.m	m3
; IR-NEXT: mrowscatadd.ew	m0, m2, m3
; IR-NEXT: ret
; IR-LABEL: ir_7:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 64
; IR-NEXT: li	a1, 64
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m1, a1
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: mrowscatadd.ew	m0, m0, m1
; IR-NEXT: ret
; IR-LABEL: ir_8:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: li	a1, 128
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mrowscatadd.ew	m0, m0, m2
; IR-NEXT: ret
; IR-LABEL: ir_9:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: lui	a1, 262144
; IR-NEXT: li	a2, 64
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: addi	a1, a1, 64
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m1, a1
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: msettyp	m2, a2
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mrowscatadd.ew	m0, m1, m2
; IR-NEXT: ret
; IR-LABEL: ir_10:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: li	a1, 128
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m1, a1
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: mrowscatadd.ew	m0, m0, m1
; IR-NEXT: ret
; IR-LABEL: ir_11:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: li	a1, 128
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: msettyp	m0, a1
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: mrowscatadd.ew	m0, m1, m0
; IR-NEXT: ret


define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_0() #0 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v1 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v2 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case0(target("riscv.ztt.m.i32", i32, 32, 1, 1) %v0, target("riscv.ztt.m.i32", i32, 32, 1, 1) %v1, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v2, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_1() #1 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.i8_1x1(i32 1073741832, i32 1)
  %v2 = call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.u8_1x1(i32 8, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case1(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.i8", i8, 8, 1, 1) %v1, target("riscv.ztt.m.u8", i8, 8, 1, 1) %v2, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_2() #2 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v1 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v2 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case2(target("riscv.ztt.m.i32", i32, 32, 1, 1) %v0, target("riscv.ztt.m.i32", i32, 32, 1, 1) %v1, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v2, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_3() #3 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.i16_1x1(i32 1073741840, i32 1)
  %v2 = call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.u16_1x1(i32 16, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case3(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.i16", i16, 16, 1, 1) %v1, target("riscv.ztt.m.u16", i16, 16, 1, 1) %v2, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_4() #4 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v1 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v2 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case4(target("riscv.ztt.m.i32", i32, 32, 1, 1) %v0, target("riscv.ztt.m.i32", i32, 32, 1, 1) %v1, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v2, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @ir_5() #5 {
  %v0 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v1 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v2 = call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32 64, i32 1)
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case5(target("riscv.ztt.m.i64", i64, 64, 1, 1) %v0, target("riscv.ztt.m.i64", i64, 64, 1, 1) %v1, target("riscv.ztt.m.u64", i64, 64, 1, 1) %v2, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_6() #6 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v2 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case6(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.i32", i32, 32, 1, 1) %v1, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v2, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @ir_7() #7 {
  %v0 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v1 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v2 = call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32 64, i32 1)
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case7(target("riscv.ztt.m.i64", i64, 64, 1, 1) %v0, target("riscv.ztt.m.i64", i64, 64, 1, 1) %v1, target("riscv.ztt.m.u64", i64, 64, 1, 1) %v2, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @ir_8() #8 {
  %v0 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v1 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v2 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case8(target("riscv.ztt.m.i128", i128, 128, 1, 1) %v0, target("riscv.ztt.m.i128", i128, 128, 1, 1) %v1, target("riscv.ztt.m.u128", i128, 128, 1, 1) %v2, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_9() #9 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v2 = call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32 64, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case9(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.i64", i64, 64, 1, 1) %v1, target("riscv.ztt.m.u64", i64, 64, 1, 1) %v2, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @ir_10() #10 {
  %v0 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v1 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v2 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case10(target("riscv.ztt.m.i128", i128, 128, 1, 1) %v0, target("riscv.ztt.m.i128", i128, 128, 1, 1) %v1, target("riscv.ztt.m.u128", i128, 128, 1, 1) %v2, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.u128", i128, 128, 1, 1) @ir_11() #11 {
  %v0 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %v1 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v2 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %r = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case11(target("riscv.ztt.m.u128", i128, 128, 1, 1) %v0, target("riscv.ztt.m.i128", i128, 128, 1, 1) %v1, target("riscv.ztt.m.u128", i128, 128, 1, 1) %v2, i32 128, i32 1)
  ret target("riscv.ztt.m.u128", i128, 128, 1, 1) %r
}

declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case1(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.i8", i8, 8, 1, 1), target("riscv.ztt.m.u8", i8, 8, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case3(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.i16", i16, 16, 1, 1), target("riscv.ztt.m.u16", i16, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case6(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case9(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.u64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case10(target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.u128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case8(target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.u128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.i16_1x1(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case0(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case2(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case4(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case5(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.u64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case7(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.u64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.i8_1x1(i32, i32)
declare target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.case11(target("riscv.ztt.m.u128", i128, 128, 1, 1), target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.u128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32, i32)
declare target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.u16_1x1(i32, i32)
declare target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32, i32)
declare target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32, i32)
declare target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.u8_1x1(i32, i32)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }

; Preserve old_d across the tied update at standard and wide layouts.
; IR-LABEL: live_0:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a2, a2, 32
; IR-NEXT: lui	a3, 131840
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: addi	a3, a3, 288
; IR-NEXT: msettyp	m4, a3
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: li	a3, 32
; IR-NEXT: msettyp	m8, a3
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: mgettyp	a2, m0
; IR-NEXT: msettyp	m12, a2
; IR-NEXT: mmov.m.m	m12, m0
; IR-NEXT: mrowscatadd.ew	m12, m4, m8
; IR-NEXT: mss.rm	m12, a0
; IR-NEXT: mss.rm	m0, a1
; IR-NEXT: ret
define void @live_0(ptr %out, ptr %oldout) #100 {
  %old = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_old(i32 1073741856, i32 1)
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_src(i32 540016928, i32 1)
  %idx = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_idx(i32 32, i32 1)
  %result = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.live(target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, target("riscv.ztt.m.f32", float, 32, 1, 1) %src, target("riscv.ztt.m.u32", i32, 32, 1, 1) %idx, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.live(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %result, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.live(ptr %oldout, target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, i32 1073741856, i32 1)
  ret void
}
attributes #100 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_old(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_src(i32, i32)
declare target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_idx(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.live(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.f32", float, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.rm.live(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
; IR-LABEL: live_1:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a2, a2, 32
; IR-NEXT: lui	a3, 131840
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: addi	a3, a3, 288
; IR-NEXT: msettyp	m2, a3
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: li	a3, 32
; IR-NEXT: msettyp	m4, a3
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: mgettyp	a2, m0
; IR-NEXT: msettyp	m6, a2
; IR-NEXT: mmov.m.m	m6, m0
; IR-NEXT: mrowscatadd.ew	m6, m2, m4
; IR-NEXT: mss.rm	m6, a0
; IR-NEXT: mss.rm	m0, a1
; IR-NEXT: ret
define void @live_1(ptr %out, ptr %oldout) #101 {
  %old = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_old(i32 1073741856, i32 1)
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_src(i32 540016928, i32 1)
  %idx = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_idx(i32 32, i32 1)
  %result = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.live(target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, target("riscv.ztt.m.f32", float, 32, 1, 1) %src, target("riscv.ztt.m.u32", i32, 32, 1, 1) %idx, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.live(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %result, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.live(ptr %oldout, target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, i32 1073741856, i32 1)
  ret void
}
attributes #101 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
; IR-LABEL: live_2:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a2, 262144
; IR-NEXT: addi	a2, a2, 32
; IR-NEXT: lui	a3, 131840
; IR-NEXT: msettyp	m0, a2
; IR-NEXT: mzero.2d.m	m0
; IR-NEXT: addi	a3, a3, 288
; IR-NEXT: msettyp	m1, a3
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: li	a3, 32
; IR-NEXT: msettyp	m2, a3
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: mgettyp	a2, m0
; IR-NEXT: msettyp	m3, a2
; IR-NEXT: mmov.m.m	m3, m0
; IR-NEXT: mrowscatadd.ew	m3, m1, m2
; IR-NEXT: mss.rm	m3, a0
; IR-NEXT: mss.rm	m0, a1
; IR-NEXT: ret
define void @live_2(ptr %out, ptr %oldout) #102 {
  %old = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_old(i32 1073741856, i32 1)
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_src(i32 540016928, i32 1)
  %idx = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.live_idx(i32 32, i32 1)
  %result = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mrowscatadd.ew.live(target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, target("riscv.ztt.m.f32", float, 32, 1, 1) %src, target("riscv.ztt.m.u32", i32, 32, 1, 1) %idx, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.live(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %result, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.live(ptr %oldout, target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, i32 1073741856, i32 1)
  ret void
}
attributes #102 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
