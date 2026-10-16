; RUN: sed 's/iXLEN/i32/g' %s | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLEN/i64/g' %s | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLEN/i32/g' %s | llc -mtriple=riscv32 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo | FileCheck %s --check-prefix=FOOTPRINT
; RUN: sed 's/iXLEN/i64/g' %s | llc -mtriple=riscv64 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo | FileCheck %s --check-prefix=FOOTPRINT

; Two wide squares retain the metadata reads and all source/result payloads.
; FOOTPRINT-LABEL: name: case_20_uds8
; FOOTPRINT: $zttm8 = ZTT_MOR_EW $zttm0, $zttm4, implicit $zttm8, implicit $zttm9, implicit-def $zttm9, implicit $zttm1, implicit $zttm5
; FOOTPRINT-NEXT: $zttm10 = ZTT_MOR_EW $zttm2, $zttm6, implicit $zttm10, implicit $zttm11, implicit-def $zttm11, implicit $zttm3, implicit $zttm7

; Equal matrix datatypes: group=bits*K/UDS, step=max(1,bits/UDS),
; operations=group/step. Sources remain live until the final slice.

define target("riscv.ztt.m.i8", i8, 8, 1, 1) @case_0_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 1) %a, target("riscv.ztt.m.i8", i8, 8, 1, 1) %b) #0 {
; CHECK-LABEL: case_0_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mor.ew.case0(target("riscv.ztt.m.i8", i8, 8, 1, 1) %a, target("riscv.ztt.m.i8", i8, 8, 1, 1) %b, i32 1073741832, i32 1)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 1) %r
}

define target("riscv.ztt.m.i4", i4, 4, 1, 2) @case_1_uds8(target("riscv.ztt.m.i4", i4, 4, 1, 2) %a, target("riscv.ztt.m.i4", i4, 4, 1, 2) %b) #1 {
; CHECK-LABEL: case_1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mor.ew.case1(target("riscv.ztt.m.i4", i4, 4, 1, 2) %a, target("riscv.ztt.m.i4", i4, 4, 1, 2) %b, i32 1073741828, i32 2)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 2) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 2) @case_2_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b) #2 {
; CHECK-LABEL: case_2_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mor.ew m4, m0, m2
; CHECK-NEXT:    mor.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mor.ew.case2(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %r
}

define target("riscv.ztt.m.i8", i8, 8, 4, 1) @case_3_uds8(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, target("riscv.ztt.m.i8", i8, 8, 4, 1) %b) #3 {
; CHECK-LABEL: case_3_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m9, m1, m5
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mor.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mor.ew.case3(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, target("riscv.ztt.m.i8", i8, 8, 4, 1) %b, i32 1073741832, i32 4)
  ret target("riscv.ztt.m.i8", i8, 8, 4, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @case_4_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b) #4 {
; CHECK-LABEL: case_4_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mor.ew.case4(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 2) @case_5_uds16(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b) #5 {
; CHECK-LABEL: case_5_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mor.ew.case5(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_6_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) #6 {
; CHECK-LABEL: case_6_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mor.ew m4, m0, m2
; CHECK-NEXT:    mor.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mor.ew.case6(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @case_7_uds16(target("riscv.ztt.m.i16", i16, 16, 4, 1) %a, target("riscv.ztt.m.i16", i16, 16, 4, 1) %b) #7 {
; CHECK-LABEL: case_7_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m9, m1, m5
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mor.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mor.ew.case7(target("riscv.ztt.m.i16", i16, 16, 4, 1) %a, target("riscv.ztt.m.i16", i16, 16, 4, 1) %b, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @case_8_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b) #8 {
; CHECK-LABEL: case_8_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mor.ew.case8(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_9_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) #9 {
; CHECK-LABEL: case_9_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mor.ew.case9(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @case_10_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #10 {
; CHECK-LABEL: case_10_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mor.ew m4, m0, m2
; CHECK-NEXT:    mor.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mor.ew.case10(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 4, 1) @case_11_uds32(target("riscv.ztt.m.i32", i32, 32, 4, 1) %a, target("riscv.ztt.m.i32", i32, 32, 4, 1) %b) #11 {
; CHECK-LABEL: case_11_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m9, m1, m5
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mor.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mor.ew.case11(target("riscv.ztt.m.i32", i32, 32, 4, 1) %a, target("riscv.ztt.m.i32", i32, 32, 4, 1) %b, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @case_12_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b) #12 {
; CHECK-LABEL: case_12_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mor.ew.case12(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @case_13_uds64(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #13 {
; CHECK-LABEL: case_13_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mor.ew.case13(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @case_14_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b) #14 {
; CHECK-LABEL: case_14_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mor.ew m4, m0, m2
; CHECK-NEXT:    mor.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mor.ew.case14(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}

define target("riscv.ztt.m.i64", i64, 64, 4, 1) @case_15_uds64(target("riscv.ztt.m.i64", i64, 64, 4, 1) %a, target("riscv.ztt.m.i64", i64, 64, 4, 1) %b) #15 {
; CHECK-LABEL: case_15_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m9, m1, m5
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mor.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 4, 1) @llvm.riscv.ztt.mor.ew.case15(target("riscv.ztt.m.i64", i64, 64, 4, 1) %a, target("riscv.ztt.m.i64", i64, 64, 4, 1) %b, i32 1073741888, i32 4)
  ret target("riscv.ztt.m.i64", i64, 64, 4, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @case_16_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %b) #16 {
; CHECK-LABEL: case_16_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mor.ew.case16(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %b, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @case_17_uds128(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b) #17 {
; CHECK-LABEL: case_17_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mor.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mor.ew.case17(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 2) @case_18_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, target("riscv.ztt.m.i128", i128, 128, 1, 2) %b) #18 {
; CHECK-LABEL: case_18_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mor.ew m4, m0, m2
; CHECK-NEXT:    mor.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mor.ew.case18(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, target("riscv.ztt.m.i128", i128, 128, 1, 2) %b, i32 1073741952, i32 2)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 2) %r
}

define target("riscv.ztt.m.i128", i128, 128, 4, 1) @case_19_uds128(target("riscv.ztt.m.i128", i128, 128, 4, 1) %a, target("riscv.ztt.m.i128", i128, 128, 4, 1) %b) #19 {
; CHECK-LABEL: case_19_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m9, m1, m5
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mor.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.mor.ew.case19(target("riscv.ztt.m.i128", i128, 128, 4, 1) %a, target("riscv.ztt.m.i128", i128, 128, 4, 1) %b, i32 1073741952, i32 4)
  ret target("riscv.ztt.m.i128", i128, 128, 4, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_20_uds8(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) #20 {
; CHECK-LABEL: case_20_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mor.ew.case20(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 2, 1) @case_21_uds16(target("riscv.ztt.m.i32", i32, 32, 2, 1) %a, target("riscv.ztt.m.i32", i32, 32, 2, 1) %b) #21 {
; CHECK-LABEL: case_21_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mor.ew.case21(target("riscv.ztt.m.i32", i32, 32, 2, 1) %a, target("riscv.ztt.m.i32", i32, 32, 2, 1) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 2, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @case_22_uds32(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b) #22 {
; CHECK-LABEL: case_22_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mor.ew.case22(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}

define target("riscv.ztt.m.u8", i8, 8, 1, 16) @case_23_uds32(target("riscv.ztt.m.u8", i8, 8, 1, 16) %a, target("riscv.ztt.m.u8", i8, 8, 1, 16) %b) #23 {
; CHECK-LABEL: case_23_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    li a0, 8
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mor.ew m8, m0, m4
; CHECK-NEXT:    mor.ew m9, m1, m5
; CHECK-NEXT:    mor.ew m10, m2, m6
; CHECK-NEXT:    mor.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u8", i8, 8, 1, 16) @llvm.riscv.ztt.mor.ew.case23(target("riscv.ztt.m.u8", i8, 8, 1, 16) %a, target("riscv.ztt.m.u8", i8, 8, 1, 16) %b, i32 8, i32 16)
  ret target("riscv.ztt.m.u8", i8, 8, 1, 16) %r
}

declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mor.ew.case16(target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mor.ew.case18(target("riscv.ztt.m.i128", i128, 128, 1, 2), target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.mor.ew.case19(target("riscv.ztt.m.i128", i128, 128, 4, 1), target("riscv.ztt.m.i128", i128, 128, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mor.ew.case4(target("riscv.ztt.m.i16", i16, 16, 1, 1), target("riscv.ztt.m.i16", i16, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mor.ew.case20(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mor.ew.case6(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mor.ew.case9(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mor.ew.case7(target("riscv.ztt.m.i16", i16, 16, 4, 1), target("riscv.ztt.m.i16", i16, 16, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mor.ew.case8(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mor.ew.case10(target("riscv.ztt.m.i32", i32, 32, 1, 2), target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mor.ew.case13(target("riscv.ztt.m.i32", i32, 32, 1, 2), target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mor.ew.case21(target("riscv.ztt.m.i32", i32, 32, 2, 1), target("riscv.ztt.m.i32", i32, 32, 2, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mor.ew.case11(target("riscv.ztt.m.i32", i32, 32, 4, 1), target("riscv.ztt.m.i32", i32, 32, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mor.ew.case1(target("riscv.ztt.m.i4", i4, 4, 1, 2), target("riscv.ztt.m.i4", i4, 4, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mor.ew.case12(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.i64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mor.ew.case14(target("riscv.ztt.m.i64", i64, 64, 1, 2), target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mor.ew.case17(target("riscv.ztt.m.i64", i64, 64, 1, 2), target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mor.ew.case22(target("riscv.ztt.m.i64", i64, 64, 1, 2), target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 4, 1) @llvm.riscv.ztt.mor.ew.case15(target("riscv.ztt.m.i64", i64, 64, 4, 1), target("riscv.ztt.m.i64", i64, 64, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mor.ew.case0(target("riscv.ztt.m.i8", i8, 8, 1, 1), target("riscv.ztt.m.i8", i8, 8, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mor.ew.case2(target("riscv.ztt.m.i8", i8, 8, 1, 2), target("riscv.ztt.m.i8", i8, 8, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mor.ew.case5(target("riscv.ztt.m.i8", i8, 8, 1, 2), target("riscv.ztt.m.i8", i8, 8, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mor.ew.case3(target("riscv.ztt.m.i8", i8, 8, 4, 1), target("riscv.ztt.m.i8", i8, 8, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u8", i8, 8, 1, 16) @llvm.riscv.ztt.mor.ew.case23(target("riscv.ztt.m.u8", i8, 8, 1, 16), target("riscv.ztt.m.u8", i8, 8, 1, 16), i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #12 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #13 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #14 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #15 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #16 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #17 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #18 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #19 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #20 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #21 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #22 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #23 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
