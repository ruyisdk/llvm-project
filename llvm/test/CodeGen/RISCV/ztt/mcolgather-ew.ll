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
; CASE0-NEXT: mcolgather.ew m0, m4, m8
; CASE0-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %s --check-prefix=CASE1
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %s --check-prefix=CASE1
; CASE1-LABEL: layout_1:
; CASE1-NEXT: # %bb.0:
; CASE1-NEXT: msettyp m0, a0
; CASE1-NEXT: mcolgather.ew m0, m2, m4
; CASE1-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %s --check-prefix=CASE2
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %s --check-prefix=CASE2
; CASE2-LABEL: layout_2:
; CASE2-NEXT: # %bb.0:
; CASE2-NEXT: msettyp m0, a0
; CASE2-NEXT: mcolgather.ew m0, m1, m2
; CASE2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=CASE3
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=CASE3
; CASE3-LABEL: layout_3:
; CASE3-NEXT: # %bb.0:
; CASE3-NEXT: msettyp m0, a0
; CASE3-NEXT: mcolgather.ew m0, m1, m2
; CASE3-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=CASE4
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=CASE4
; CASE4-LABEL: layout_4:
; CASE4-NEXT: # %bb.0:
; CASE4-NEXT: msettyp m0, a0
; CASE4-NEXT: mcolgather.ew m0, m1, m2
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
    liveins: $x10, $zttm4m4, $zttm8m4
    $zttm0m4 = PseudoZTTMcolgatherEw_G004_G104_G204 $zttm4m4, $zttm8m4, $x10, 1, 4
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
    liveins: $x10, $zttm2m2, $zttm4m2
    $zttm0m2 = PseudoZTTMcolgatherEw_G002_G102_G202 $zttm2m2, $zttm4m2, $x10, 1, 2
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
    liveins: $x10, $zttm1, $zttm2
    $zttm0 = PseudoZTTMcolgatherEw_G001_G101_G201 $zttm1, $zttm2, $x10, 1, 1
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
    liveins: $x10, $zttm1, $zttm2
    $zttm0 = PseudoZTTMcolgatherEw_G001_G101_G201 $zttm1, $zttm2, $x10, 1, 1
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
    liveins: $x10, $zttm1, $zttm2
    $zttm0 = PseudoZTTMcolgatherEw_G001_G101_G201 $zttm1, $zttm2, $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- input.ll
; Full lowering and allocation, including datatype and packed footprints.
; IR-LABEL: ir_0:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m4, a0
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m8, a1
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m4, m8
; IR-NEXT: ret
; IR-LABEL: ir_1:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: li	a1, 8
; IR-NEXT: msettyp	m8, a0
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: msettyp	m16, a1
; IR-NEXT: mzero.2d.m	m16
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m8, m16
; IR-NEXT: ret
; IR-LABEL: ir_2:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m2, m4
; IR-NEXT: ret
; IR-LABEL: ir_3:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: li	a1, 16
; IR-NEXT: msettyp	m4, a0
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m8, a1
; IR-NEXT: mzero.2d.m	m8
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m4, m8
; IR-NEXT: ret
; IR-LABEL: ir_4:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 32
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m1, m2
; IR-NEXT: ret
; IR-LABEL: ir_5:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 64
; IR-NEXT: li	a1, 64
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m2, m4
; IR-NEXT: ret
; IR-LABEL: ir_6:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: li	a1, 32
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m2, m4
; IR-NEXT: ret
; IR-LABEL: ir_7:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 64
; IR-NEXT: li	a1, 64
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m1, m2
; IR-NEXT: ret
; IR-LABEL: ir_8:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: li	a1, 128
; IR-NEXT: msettyp	m2, a0
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m4, a1
; IR-NEXT: mzero.2d.m	m4
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m2, m4
; IR-NEXT: ret
; IR-LABEL: ir_9:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 180992
; IR-NEXT: addi	a0, a0, 320
; IR-NEXT: li	a1, 64
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m1, m2
; IR-NEXT: ret
; IR-LABEL: ir_10:
; IR-NEXT: # %bb.0:
; IR-NEXT: lui	a0, 262144
; IR-NEXT: addi	a0, a0, 128
; IR-NEXT: li	a1, 128
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: msettyp	m2, a1
; IR-NEXT: mzero.2d.m	m2
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m1, m2
; IR-NEXT: ret
; IR-LABEL: ir_11:
; IR-NEXT: # %bb.0:
; IR-NEXT: li	a0, 128
; IR-NEXT: msettyp	m1, a0
; IR-NEXT: mzero.2d.m	m1
; IR-NEXT: msettyp	m0, a0
; IR-NEXT: mcolgather.ew	m0, m1, m1
; IR-NEXT: ret


define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_0() #0 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v1 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case0(target("riscv.ztt.m.i32", i32, 32, 1, 1) %v0, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v1, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_1() #1 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.u8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.u8_1x1(i32 8, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case1(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.u8", i8, 8, 1, 1) %v1, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_2() #2 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v1 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case2(target("riscv.ztt.m.i32", i32, 32, 1, 1) %v0, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v1, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_3() #3 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.u16_1x1(i32 16, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case3(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.u16", i16, 16, 1, 1) %v1, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @ir_4() #4 {
  %v0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32 1073741856, i32 1)
  %v1 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case4(target("riscv.ztt.m.i32", i32, 32, 1, 1) %v0, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v1, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @ir_5() #5 {
  %v0 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v1 = call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32 64, i32 1)
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case5(target("riscv.ztt.m.i64", i64, 64, 1, 1) %v0, target("riscv.ztt.m.u64", i64, 64, 1, 1) %v1, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_6() #6 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.u32_1x1(i32 32, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case6(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.u32", i32, 32, 1, 1) %v1, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @ir_7() #7 {
  %v0 = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32 1073741888, i32 1)
  %v1 = call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32 64, i32 1)
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case7(target("riscv.ztt.m.i64", i64, 64, 1, 1) %v0, target("riscv.ztt.m.u64", i64, 64, 1, 1) %v1, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @ir_8() #8 {
  %v0 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v1 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case8(target("riscv.ztt.m.i128", i128, 128, 1, 1) %v0, target("riscv.ztt.m.u128", i128, 128, 1, 1) %v1, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @ir_9() #9 {
  %v0 = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32 741343552, i32 1)
  %v1 = call target("riscv.ztt.m.u64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.u64_1x1(i32 64, i32 1)
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case9(target("riscv.ztt.m.f64", double, 64, 1, 1) %v0, target("riscv.ztt.m.u64", i64, 64, 1, 1) %v1, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @ir_10() #10 {
  %v0 = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  %v1 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case10(target("riscv.ztt.m.i128", i128, 128, 1, 1) %v0, target("riscv.ztt.m.u128", i128, 128, 1, 1) %v1, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.u128", i128, 128, 1, 1) @ir_11() #11 {
  %v0 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %v1 = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.u128_1x1(i32 128, i32 1)
  %r = call target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case11(target("riscv.ztt.m.u128", i128, 128, 1, 1) %v0, target("riscv.ztt.m.u128", i128, 128, 1, 1) %v1, i32 128, i32 1)
  ret target("riscv.ztt.m.u128", i128, 128, 1, 1) %r
}

declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case1(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.u8", i8, 8, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case3(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.u16", i16, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case6(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case9(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.u64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mzero.m.f64_1x1(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case10(target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.u128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case8(target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.u128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case0(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case2(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case4(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.u32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.i32_1x1(i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case5(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.u64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case7(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.u64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.i64_1x1(i32, i32)
declare target("riscv.ztt.m.u128", i128, 128, 1, 1) @llvm.riscv.ztt.mcolgather.ew.case11(target("riscv.ztt.m.u128", i128, 128, 1, 1), target("riscv.ztt.m.u128", i128, 128, 1, 1), i32 immarg, i32 immarg)
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
