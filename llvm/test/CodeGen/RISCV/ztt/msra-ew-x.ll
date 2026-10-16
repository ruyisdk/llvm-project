; RUN: sed 's/iXLEN/i32/g' %s | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLEN/i32/g' %s | llc -mtriple=riscv32 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo | FileCheck %s --check-prefix=FOOTPRINT
; RUN: sed 's/iXLEN/i64/g' %s | llc -mtriple=riscv64 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo | FileCheck %s --check-prefix=FOOTPRINT

; Each instruction reads metadata and the full wide source/result payload.
; FOOTPRINT-LABEL: name: case_25_uds8
; FOOTPRINT: $zttm4 = ZTT_MSRA_EW_X $x10, $zttm0, implicit $zttm4, implicit $zttm5, implicit-def $zttm5, implicit $zttm1
; FOOTPRINT-NEXT: $zttm6 = ZTT_MSRA_EW_X $x10, $zttm2, implicit $zttm6, implicit $zttm7, implicit-def $zttm7, implicit $zttm3
; RUN: sed 's/iXLEN/i64/g' %s | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s

; G = element_bits*K/UDS. One operation processes the largest packed
; square count among operands. Shift controls do not use amestype.

define target("riscv.ztt.m.i8", i8, 8, 1, 1) @case_0_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 1) %a, iXLEN %sh) #0 {
; CHECK-LABEL: case_0_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 8
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.msra.ew.x.case0(target("riscv.ztt.m.i8", i8, 8, 1, 1) %a, iXLEN %sh, i32 1073741832, i32 1)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 1) %r
}

define target("riscv.ztt.m.i4", i4, 4, 2, 1) @case_1_uds8(target("riscv.ztt.m.i4", i4, 4, 2, 1) %a, iXLEN %sh) #1 {
; CHECK-LABEL: case_1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 4
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 2, 1) @llvm.riscv.ztt.msra.ew.x.case1(target("riscv.ztt.m.i4", i4, 4, 2, 1) %a, iXLEN %sh, i32 1073741828, i32 2)
  ret target("riscv.ztt.m.i4", i4, 4, 2, 1) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 2) @case_2_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, iXLEN %sh) #2 {
; CHECK-LABEL: case_2_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 8
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    msra.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.msra.ew.x.case2(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, iXLEN %sh, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %r
}

define target("riscv.ztt.m.i8", i8, 8, 4, 1) @case_3_uds8(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, iXLEN %sh) #3 {
; CHECK-LABEL: case_3_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 8
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msettyp m7, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m5, a0, m1
; CHECK-NEXT:    msra.ew.x m6, a0, m2
; CHECK-NEXT:    msra.ew.x m7, a0, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    mgettyp a0, m7
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.msra.ew.x.case3(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, iXLEN %sh, i32 1073741832, i32 4)
  ret target("riscv.ztt.m.i8", i8, 8, 4, 1) %r
}

define target("riscv.ztt.m.i4", i4, 4, 1, 2) @case_4_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, iXLEN %sh) #4 {
; CHECK-LABEL: case_4_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 4
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.msra.ew.x.case4(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, iXLEN %sh, i32 1073741828, i32 2)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @case_5_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, iXLEN %sh) #5 {
; CHECK-LABEL: case_5_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.msra.ew.x.case5(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, iXLEN %sh, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 2) @case_6_uds16(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, iXLEN %sh) #6 {
; CHECK-LABEL: case_6_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 8
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.msra.ew.x.case6(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, iXLEN %sh, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_7_uds16(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh) #7 {
; CHECK-LABEL: case_7_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    msra.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case7(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @case_8_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 4) %a, iXLEN %sh) #8 {
; CHECK-LABEL: case_8_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msettyp m7, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m5, a0, m1
; CHECK-NEXT:    msra.ew.x m6, a0, m2
; CHECK-NEXT:    msra.ew.x m7, a0, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    mgettyp a0, m7
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.msra.ew.x.case8(target("riscv.ztt.m.i16", i16, 16, 1, 4) %a, iXLEN %sh, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i8", i8, 8, 2, 1) @case_9_uds16(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh) #9 {
; CHECK-LABEL: case_9_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 8
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 2, 1) @llvm.riscv.ztt.msra.ew.x.case9(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 2, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @case_10_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, iXLEN %sh) #10 {
; CHECK-LABEL: case_10_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 32
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msra.ew.x.case10(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, iXLEN %sh, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_11_uds32(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh) #11 {
; CHECK-LABEL: case_11_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case11(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @case_12_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh) #12 {
; CHECK-LABEL: case_12_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 32
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    msra.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.msra.ew.x.case12(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 4, 1) @case_13_uds32(target("riscv.ztt.m.i32", i32, 32, 4, 1) %a, iXLEN %sh) #13 {
; CHECK-LABEL: case_13_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 32
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msettyp m7, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m5, a0, m1
; CHECK-NEXT:    msra.ew.x m6, a0, m2
; CHECK-NEXT:    msra.ew.x m7, a0, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    mgettyp a0, m7
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.msra.ew.x.case13(target("riscv.ztt.m.i32", i32, 32, 4, 1) %a, iXLEN %sh, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_14_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh) #14 {
; CHECK-LABEL: case_14_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.msra.ew.x.case14(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @case_15_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, iXLEN %sh) #15 {
; CHECK-LABEL: case_15_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 64
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.msra.ew.x.case15(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, iXLEN %sh, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @case_16_uds64(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh) #16 {
; CHECK-LABEL: case_16_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 32
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.msra.ew.x.case16(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i64", i64, 64, 2, 1) @case_17_uds64(target("riscv.ztt.m.i64", i64, 64, 2, 1) %a, iXLEN %sh) #17 {
; CHECK-LABEL: case_17_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 64
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    msra.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.msra.ew.x.case17(target("riscv.ztt.m.i64", i64, 64, 2, 1) %a, iXLEN %sh, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 2, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 4) @case_18_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 4) %a, iXLEN %sh) #18 {
; CHECK-LABEL: case_18_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 64
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msettyp m7, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m5, a0, m1
; CHECK-NEXT:    msra.ew.x m6, a0, m2
; CHECK-NEXT:    msra.ew.x m7, a0, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    mgettyp a0, m7
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.msra.ew.x.case18(target("riscv.ztt.m.i64", i64, 64, 1, 4) %a, iXLEN %sh, i32 1073741888, i32 4)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 4) %r
}

define target("riscv.ztt.m.i32", i32, 32, 2, 1) @case_19_uds64(target("riscv.ztt.m.i64", i64, 64, 2, 1) %a, iXLEN %sh) #19 {
; CHECK-LABEL: case_19_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 32
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.msra.ew.x.case19(target("riscv.ztt.m.i64", i64, 64, 2, 1) %a, iXLEN %sh, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 2, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @case_20_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, iXLEN %sh) #20 {
; CHECK-LABEL: case_20_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 128
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.msra.ew.x.case20(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, iXLEN %sh, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 2, 1) @case_21_uds128(target("riscv.ztt.m.i64", i64, 64, 2, 1) %a, iXLEN %sh) #21 {
; CHECK-LABEL: case_21_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 64
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    msra.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.msra.ew.x.case21(target("riscv.ztt.m.i64", i64, 64, 2, 1) %a, iXLEN %sh, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 2, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 2) @case_22_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, iXLEN %sh) #22 {
; CHECK-LABEL: case_22_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 128
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    msra.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.msra.ew.x.case22(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, iXLEN %sh, i32 1073741952, i32 2)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 2) %r
}

define target("riscv.ztt.m.i128", i128, 128, 4, 1) @case_23_uds128(target("riscv.ztt.m.i128", i128, 128, 4, 1) %a, iXLEN %sh) #23 {
; CHECK-LABEL: case_23_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 128
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msettyp m7, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m5, a0, m1
; CHECK-NEXT:    msra.ew.x m6, a0, m2
; CHECK-NEXT:    msra.ew.x m7, a0, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    mgettyp a0, m7
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.msra.ew.x.case23(target("riscv.ztt.m.i128", i128, 128, 4, 1) %a, iXLEN %sh, i32 1073741952, i32 4)
  ret target("riscv.ztt.m.i128", i128, 128, 4, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @case_24_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, iXLEN %sh) #24 {
; CHECK-LABEL: case_24_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 64
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.msra.ew.x.case24(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, iXLEN %sh, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_25_uds8(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh) #25 {
; CHECK-LABEL: case_25_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m6, a0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case25(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %sh, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.u16", i16, 16, 1, 2) @case_26_uds16(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh) #26 {
; CHECK-LABEL: case_26_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msra.ew.x m4, a0, m0
; CHECK-NEXT:    msra.ew.x m5, a0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.msra.ew.x.case26(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, iXLEN %sh, i32 16, i32 2)
  ret target("riscv.ztt.m.u16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_27_uds32(target("riscv.ztt.m.i32", i32, 32, 2, 1) %a, iXLEN %sh) #27 {
; CHECK-LABEL: case_27_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msra.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case27(target("riscv.ztt.m.i32", i32, 32, 2, 1) %a, iXLEN %sh, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.msra.ew.x.case0(target("riscv.ztt.m.i8", i8, 8, 1, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i4", i4, 4, 2, 1) @llvm.riscv.ztt.msra.ew.x.case1(target("riscv.ztt.m.i4", i4, 4, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.msra.ew.x.case2(target("riscv.ztt.m.i8", i8, 8, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.msra.ew.x.case3(target("riscv.ztt.m.i8", i8, 8, 4, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.msra.ew.x.case4(target("riscv.ztt.m.i8", i8, 8, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.msra.ew.x.case5(target("riscv.ztt.m.i16", i16, 16, 1, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.msra.ew.x.case6(target("riscv.ztt.m.i8", i8, 8, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case7(target("riscv.ztt.m.i16", i16, 16, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.msra.ew.x.case8(target("riscv.ztt.m.i16", i16, 16, 1, 4), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 2, 1) @llvm.riscv.ztt.msra.ew.x.case9(target("riscv.ztt.m.i16", i16, 16, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.msra.ew.x.case10(target("riscv.ztt.m.i32", i32, 32, 1, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case11(target("riscv.ztt.m.i16", i16, 16, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.msra.ew.x.case12(target("riscv.ztt.m.i32", i32, 32, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.msra.ew.x.case13(target("riscv.ztt.m.i32", i32, 32, 4, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.msra.ew.x.case14(target("riscv.ztt.m.i32", i32, 32, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.msra.ew.x.case15(target("riscv.ztt.m.i64", i64, 64, 1, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.msra.ew.x.case16(target("riscv.ztt.m.i32", i32, 32, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.msra.ew.x.case17(target("riscv.ztt.m.i64", i64, 64, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.msra.ew.x.case18(target("riscv.ztt.m.i64", i64, 64, 1, 4), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.msra.ew.x.case19(target("riscv.ztt.m.i64", i64, 64, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.msra.ew.x.case20(target("riscv.ztt.m.i128", i128, 128, 1, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.msra.ew.x.case21(target("riscv.ztt.m.i64", i64, 64, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.msra.ew.x.case22(target("riscv.ztt.m.i128", i128, 128, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.msra.ew.x.case23(target("riscv.ztt.m.i128", i128, 128, 4, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.msra.ew.x.case24(target("riscv.ztt.m.i128", i128, 128, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case25(target("riscv.ztt.m.i16", i16, 16, 2, 1), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u16", i16, 16, 1, 2) @llvm.riscv.ztt.msra.ew.x.case26(target("riscv.ztt.m.i32", i32, 32, 1, 2), iXLEN, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.msra.ew.x.case27(target("riscv.ztt.m.i32", i32, 32, 2, 1), iXLEN, i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #12 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #13 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #14 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #15 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #16 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #17 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #18 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #19 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #20 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #21 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #22 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #23 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #24 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #25 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #26 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #27 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
