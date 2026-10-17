; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/input.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLEN/i64/g' %t/input.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLEN/i32/g' %t/input.ll | llc -mtriple=riscv32 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo | FileCheck %s --check-prefix=FOOTPRINT
; RUN: sed 's/iXLEN/i64/g' %t/input.ll | llc -mtriple=riscv64 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo | FileCheck %s --check-prefix=FOOTPRINT

; Two wide squares retain the metadata reads and all source/result payloads.
; FOOTPRINT-LABEL: name: case_10_uds8
; FOOTPRINT: $zttm4 = ZTT_MORNOT_EW_X $x10, $zttm0, implicit $zttm4, implicit $zttm5, implicit-def $zttm5, implicit $zttm1
; FOOTPRINT-NEXT: $zttm6 = ZTT_MORNOT_EW_X $x10, $zttm2, implicit $zttm6, implicit $zttm7, implicit-def $zttm7, implicit $zttm3

; Equal matrix datatypes: group=bits*K/UDS, step=max(1,bits/UDS),
; operations=group/step. Sources remain live until the final slice.
;--- input.ll

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @case_0_uds8(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, iXLEN %scalar) #0 {
; CHECK-LABEL: case_0_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mornot.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mornot.ew.x.case0(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_1_uds8(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %scalar) #1 {
; CHECK-LABEL: case_1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    mornot.ew.x m4, a0, m0
; CHECK-NEXT:    mornot.ew.x m6, a0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mornot.ew.x.case1(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @case_2_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, iXLEN %scalar) #2 {
; CHECK-LABEL: case_2_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mornot.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mornot.ew.x.case2(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_3_uds16(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %scalar) #3 {
; CHECK-LABEL: case_3_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    mornot.ew.x m2, a0, m0
; CHECK-NEXT:    mornot.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mornot.ew.x.case3(target("riscv.ztt.m.i16", i16, 16, 2, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_4_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, iXLEN %scalar) #4 {
; CHECK-LABEL: case_4_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mornot.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mornot.ew.x.case4(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @case_5_uds32(target("riscv.ztt.m.i16", i16, 16, 4, 1) %a, iXLEN %scalar) #5 {
; CHECK-LABEL: case_5_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    mornot.ew.x m2, a0, m0
; CHECK-NEXT:    mornot.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mornot.ew.x.case5(target("riscv.ztt.m.i16", i16, 16, 4, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @case_6_uds64(target("riscv.ztt.m.i16", i16, 16, 1, 4) %a, iXLEN %scalar) #6 {
; CHECK-LABEL: case_6_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mornot.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mornot.ew.x.case6(target("riscv.ztt.m.i16", i16, 16, 1, 4) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 8, 1) @case_7_uds64(target("riscv.ztt.m.i16", i16, 16, 8, 1) %a, iXLEN %scalar) #7 {
; CHECK-LABEL: case_7_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    mornot.ew.x m2, a0, m0
; CHECK-NEXT:    mornot.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mornot.ew.x.case7(target("riscv.ztt.m.i16", i16, 16, 8, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 8, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @case_8_uds128(target("riscv.ztt.m.i16", i16, 16, 1, 8) %a, iXLEN %scalar) #8 {
; CHECK-LABEL: case_8_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mornot.ew.x m1, a0, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mornot.ew.x.case8(target("riscv.ztt.m.i16", i16, 16, 1, 8) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %r
}

define target("riscv.ztt.m.i16", i16, 16, 16, 1) @case_9_uds128(target("riscv.ztt.m.i16", i16, 16, 16, 1) %a, iXLEN %scalar) #9 {
; CHECK-LABEL: case_9_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    msettyp m3, a1
; CHECK-NEXT:    mornot.ew.x m2, a0, m0
; CHECK-NEXT:    mornot.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mornot.ew.x.case9(target("riscv.ztt.m.i16", i16, 16, 16, 1) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 16)
  ret target("riscv.ztt.m.i16", i16, 16, 16, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_10_uds8(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, iXLEN %scalar) #10 {
; CHECK-LABEL: case_10_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    mornot.ew.x m4, a0, m0
; CHECK-NEXT:    mornot.ew.x m6, a0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mornot.ew.x.case10(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.u16", i16, 16, 1, 4) @case_11_uds16(target("riscv.ztt.m.u16", i16, 16, 1, 4) %a, iXLEN %scalar) #11 {
; CHECK-LABEL: case_11_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m5, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    msettyp m7, a1
; CHECK-NEXT:    mornot.ew.x m4, a0, m0
; CHECK-NEXT:    mornot.ew.x m5, a0, m1
; CHECK-NEXT:    mornot.ew.x m6, a0, m2
; CHECK-NEXT:    mornot.ew.x m7, a0, m3
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
  %r = call target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mornot.ew.x.case11(target("riscv.ztt.m.u16", i16, 16, 1, 4) %a, iXLEN %scalar, i32 16, i32 16, i32 4)
  ret target("riscv.ztt.m.u16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 16) @case_12_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 16) %a, iXLEN %scalar) #12 {
; CHECK-LABEL: case_12_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m8, a1
; CHECK-NEXT:    msettyp m9, a1
; CHECK-NEXT:    msettyp m10, a1
; CHECK-NEXT:    msettyp m11, a1
; CHECK-NEXT:    msettyp m12, a1
; CHECK-NEXT:    msettyp m13, a1
; CHECK-NEXT:    msettyp m14, a1
; CHECK-NEXT:    msettyp m15, a1
; CHECK-NEXT:    mornot.ew.x m8, a0, m0
; CHECK-NEXT:    mornot.ew.x m9, a0, m1
; CHECK-NEXT:    mornot.ew.x m10, a0, m2
; CHECK-NEXT:    mornot.ew.x m11, a0, m3
; CHECK-NEXT:    mornot.ew.x m12, a0, m4
; CHECK-NEXT:    mornot.ew.x m13, a0, m5
; CHECK-NEXT:    mornot.ew.x m14, a0, m6
; CHECK-NEXT:    mornot.ew.x m15, a0, m7
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
; CHECK-NEXT:    mgettyp a0, m12
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m12
; CHECK-NEXT:    mgettyp a0, m13
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmov.m.m m5, m13
; CHECK-NEXT:    mgettyp a0, m14
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m14
; CHECK-NEXT:    mgettyp a0, m15
; CHECK-NEXT:    msettyp m7, a0
; CHECK-NEXT:    mmov.m.m m7, m15
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mornot.ew.x.case12(target("riscv.ztt.m.i16", i16, 16, 1, 16) %a, iXLEN %scalar, i32 1073741840, i32 1073741840, i32 16)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 16) %r
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mornot.ew.x.case0(target("riscv.ztt.m.i16", i16, 16, 1, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mornot.ew.x.case2(target("riscv.ztt.m.i16", i16, 16, 1, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mornot.ew.x.case12(target("riscv.ztt.m.i16", i16, 16, 1, 16), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mornot.ew.x.case10(target("riscv.ztt.m.i16", i16, 16, 1, 2), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mornot.ew.x.case4(target("riscv.ztt.m.i16", i16, 16, 1, 2), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mornot.ew.x.case6(target("riscv.ztt.m.i16", i16, 16, 1, 4), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mornot.ew.x.case8(target("riscv.ztt.m.i16", i16, 16, 1, 8), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mornot.ew.x.case9(target("riscv.ztt.m.i16", i16, 16, 16, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mornot.ew.x.case1(target("riscv.ztt.m.i16", i16, 16, 2, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mornot.ew.x.case3(target("riscv.ztt.m.i16", i16, 16, 2, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mornot.ew.x.case5(target("riscv.ztt.m.i16", i16, 16, 4, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mornot.ew.x.case7(target("riscv.ztt.m.i16", i16, 16, 8, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mornot.ew.x.case11(target("riscv.ztt.m.u16", i16, 16, 1, 4), iXLEN, i32 immarg, i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #12 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
