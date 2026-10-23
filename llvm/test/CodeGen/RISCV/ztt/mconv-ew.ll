; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo < %s | FileCheck %s --check-prefix=FOOTPRINT
; RUN: llc -mtriple=riscv64 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo < %s | FileCheck %s --check-prefix=FOOTPRINT

; Two wide source squares (four registers each) produce two wide result
; squares (two registers each). Metadata reads and every payload tail stay live.
; FOOTPRINT-LABEL: name: case_15_uds8
; FOOTPRINT: $zttm8 = ZTT_MCONV_EW $zttm0, implicit $zttm8, implicit $zttm9, implicit-def $zttm9, implicit $zttm1, implicit $zttm2, implicit $zttm3
; FOOTPRINT-NEXT: $zttm10 = ZTT_MCONV_EW $zttm4, implicit $zttm10, implicit $zttm11, implicit-def $zttm11, implicit $zttm5, implicit $zttm6, implicit $zttm7

; N_sq=max(1,UDS/source_bits,UDS/result_bits); NumOps=K/N_sq.
; Each msettyp/COPY advances one destination square, not one wide register.

define target("riscv.ztt.m.i8", i8, 8, 1, 1) @case_0_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 1) %src) #0 {
; CHECK-LABEL: case_0_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mconv.ew.case0(target("riscv.ztt.m.i8", i8, 8, 1, 1) %src, i32 1073741832, i32 1)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 1) %r
}

define target("riscv.ztt.m.i4", i4, 4, 1, 2) @case_1_uds8(target("riscv.ztt.m.i4", i4, 4, 1, 2) %src) #1 {
; CHECK-LABEL: case_1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mconv.ew.case1(target("riscv.ztt.m.i4", i4, 4, 1, 2) %src, i32 1073741828, i32 2)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 2) %r
}

define target("riscv.ztt.m.i8", i8, 8, 2, 1) @case_2_uds8(target("riscv.ztt.m.i8", i8, 8, 2, 1) %src) #2 {
; CHECK-LABEL: case_2_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mconv.ew m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 2, 1) @llvm.riscv.ztt.mconv.ew.case2(target("riscv.ztt.m.i8", i8, 8, 2, 1) %src, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @case_3_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 1) %src) #3 {
; CHECK-LABEL: case_3_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mconv.ew.case3(target("riscv.ztt.m.i16", i16, 16, 1, 1) %src, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 2) @case_4_uds16(target("riscv.ztt.m.i8", i8, 8, 1, 2) %src) #4 {
; CHECK-LABEL: case_4_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mconv.ew.case4(target("riscv.ztt.m.i8", i8, 8, 1, 2) %src, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @case_5_uds16(target("riscv.ztt.m.i16", i16, 16, 2, 1) %src) #5 {
; CHECK-LABEL: case_5_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mconv.ew m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mconv.ew.case5(target("riscv.ztt.m.i16", i16, 16, 2, 1) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @case_6_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) #6 {
; CHECK-LABEL: case_6_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mconv.ew.case6(target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_7_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 2) %src) #7 {
; CHECK-LABEL: case_7_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case7(target("riscv.ztt.m.i16", i16, 16, 1, 2) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 2, 1) @case_8_uds32(target("riscv.ztt.m.i32", i32, 32, 2, 1) %src) #8 {
; CHECK-LABEL: case_8_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mconv.ew m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mconv.ew.case8(target("riscv.ztt.m.i32", i32, 32, 2, 1) %src, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 2, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 1) @case_9_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 1) %src) #9 {
; CHECK-LABEL: case_9_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mconv.ew.case9(target("riscv.ztt.m.i64", i64, 64, 1, 1) %src, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @case_10_uds64(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src) #10 {
; CHECK-LABEL: case_10_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mconv.ew.case10(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i64", i64, 64, 2, 1) @case_11_uds64(target("riscv.ztt.m.i64", i64, 64, 2, 1) %src) #11 {
; CHECK-LABEL: case_11_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mconv.ew m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.mconv.ew.case11(target("riscv.ztt.m.i64", i64, 64, 2, 1) %src, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 2, 1) %r
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @case_12_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 1) %src) #12 {
; CHECK-LABEL: case_12_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew.case12(target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @case_13_uds128(target("riscv.ztt.m.i64", i64, 64, 1, 2) %src) #13 {
; CHECK-LABEL: case_13_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mconv.ew.case13(target("riscv.ztt.m.i64", i64, 64, 1, 2) %src, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}

define target("riscv.ztt.m.i128", i128, 128, 2, 1) @case_14_uds128(target("riscv.ztt.m.i128", i128, 128, 2, 1) %src) #14 {
; CHECK-LABEL: case_14_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mconv.ew m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mconv.ew.case14(target("riscv.ztt.m.i128", i128, 128, 2, 1) %src, i32 1073741952, i32 2)
  ret target("riscv.ztt.m.i128", i128, 128, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_15_uds8(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src) #15 {
; CHECK-LABEL: case_15_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mconv.ew m8, m0
; CHECK-NEXT:    mconv.ew m10, m4
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case15(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_16_uds16(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src) #16 {
; CHECK-LABEL: case_16_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mconv.ew m4, m0
; CHECK-NEXT:    mconv.ew m5, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case16(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @case_17_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src) #17 {
; CHECK-LABEL: case_17_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case17(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 4, 1) @case_18_uds32(target("riscv.ztt.m.i8", i8, 8, 4, 1) %src) #18 {
; CHECK-LABEL: case_18_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    msettyp m7, a0
; CHECK-NEXT:    mconv.ew m4, m0
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
  %r = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mconv.ew.case18(target("riscv.ztt.m.i8", i8, 8, 4, 1) %src, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 32) @case_19_uds32(target("riscv.ztt.m.i8", i8, 8, 1, 32) %src) #19 {
; CHECK-LABEL: case_19_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    msettyp m13, a0
; CHECK-NEXT:    msettyp m14, a0
; CHECK-NEXT:    msettyp m15, a0
; CHECK-NEXT:    mconv.ew m8, m0
; CHECK-NEXT:    mconv.ew m9, m1
; CHECK-NEXT:    mconv.ew m10, m2
; CHECK-NEXT:    mconv.ew m11, m3
; CHECK-NEXT:    mconv.ew m12, m4
; CHECK-NEXT:    mconv.ew m13, m5
; CHECK-NEXT:    mconv.ew m14, m6
; CHECK-NEXT:    mconv.ew m15, m7
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
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 32) @llvm.riscv.ztt.mconv.ew.case19(target("riscv.ztt.m.i8", i8, 8, 1, 32) %src, i32 1073741832, i32 32)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 32) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @case_20_uds8(target("riscv.ztt.m.f32", float, 32, 1, 2) %src) #20 {
; CHECK-LABEL: case_20_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mconv.ew m8, m0
; CHECK-NEXT:    mconv.ew m10, m4
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case20(target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @case_21_uds16(target("riscv.ztt.m.f32", float, 32, 1, 2) %src) #21 {
; CHECK-LABEL: case_21_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mconv.ew m4, m0
; CHECK-NEXT:    mconv.ew m5, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case21(target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @case_22_uds32(target("riscv.ztt.m.f32", float, 32, 1, 2) %src) #22 {
; CHECK-LABEL: case_22_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mconv.ew m2, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case22(target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @case_23_uds16(target("riscv.ztt.m.f16", half, 16, 1, 1) %src) #23 {
; CHECK-LABEL: case_23_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mconv.ew.case23(target("riscv.ztt.m.f16", half, 16, 1, 1) %src, i32 540016912, i32 1)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @case_24_uds32(target("riscv.ztt.m.f32", float, 32, 1, 1) %src) #24 {
; CHECK-LABEL: case_24_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 288
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mconv.ew.case24(target("riscv.ztt.m.f32", float, 32, 1, 1) %src, i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @case_25_uds64(target("riscv.ztt.m.f64", double, 64, 1, 1) %src) #25 {
; CHECK-LABEL: case_25_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mconv.ew.case25(target("riscv.ztt.m.f64", double, 64, 1, 1) %src, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 2) @case_26_uds128(target("riscv.ztt.m.f64", double, 64, 1, 2) %src) #26 {
; CHECK-LABEL: case_26_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mconv.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mconv.ew.case26(target("riscv.ztt.m.f64", double, 64, 1, 2) %src, i32 741343552, i32 2)
  ret target("riscv.ztt.m.f64", double, 64, 1, 2) %r
}

define target("riscv.ztt.m.f64", double, 64, 4, 1) @case_27_uds64(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %src) #27 {
; CHECK-LABEL: case_27_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    msettyp m7, a0
; CHECK-NEXT:    mconv.ew m4, m0
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
  %r = call target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mconv.ew.case27(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %src, i32 741343552, i32 4)
  ret target("riscv.ztt.m.f64", double, 64, 4, 1) %r
}

define target("riscv.ztt.m.f16", half, 16, 1, 1) @case_28_uds8(target("riscv.ztt.m.f64", double, 64, 1, 1) %src) #28 {
; CHECK-LABEL: case_28_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    mconv.ew m8, m0
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mconv.ew.case28(target("riscv.ztt.m.f64", double, 64, 1, 1) %src, i32 338690320, i32 1)
  ret target("riscv.ztt.m.f16", half, 16, 1, 1) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) @case_29_uds32(target("riscv.ztt.m.f16", half, 16, 16, 1) %src) #29 {
; CHECK-LABEL: case_29_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    msettyp m13, a0
; CHECK-NEXT:    msettyp m14, a0
; CHECK-NEXT:    msettyp m15, a0
; CHECK-NEXT:    mconv.ew m8, m0
; CHECK-NEXT:    mconv.ew m9, m1
; CHECK-NEXT:    mconv.ew m10, m2
; CHECK-NEXT:    mconv.ew m11, m3
; CHECK-NEXT:    mconv.ew m12, m4
; CHECK-NEXT:    mconv.ew m13, m5
; CHECK-NEXT:    mconv.ew m14, m6
; CHECK-NEXT:    mconv.ew m15, m7
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
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) @llvm.riscv.ztt.mconv.ew.case29(target("riscv.ztt.m.f16", half, 16, 16, 1) %src, i32 540016912, i32 16)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mconv.ew.case23(target("riscv.ztt.m.f16", half, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case20(target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case21(target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case22(target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) @llvm.riscv.ztt.mconv.ew.case29(target("riscv.ztt.m.f16", half, 16, 16, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mconv.ew.case28(target("riscv.ztt.m.f64", double, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mconv.ew.case24(target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mconv.ew.case25(target("riscv.ztt.m.f64", double, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mconv.ew.case26(target("riscv.ztt.m.f64", double, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mconv.ew.case27(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew.case12(target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mconv.ew.case14(target("riscv.ztt.m.i128", i128, 128, 2, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mconv.ew.case3(target("riscv.ztt.m.i16", i16, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case15(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case16(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case17(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconv.ew.case7(target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mconv.ew.case5(target("riscv.ztt.m.i16", i16, 16, 2, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mconv.ew.case6(target("riscv.ztt.m.i32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mconv.ew.case10(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 2, 1) @llvm.riscv.ztt.mconv.ew.case8(target("riscv.ztt.m.i32", i32, 32, 2, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mconv.ew.case18(target("riscv.ztt.m.i8", i8, 8, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mconv.ew.case1(target("riscv.ztt.m.i4", i4, 4, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mconv.ew.case9(target("riscv.ztt.m.i64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mconv.ew.case13(target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 2, 1) @llvm.riscv.ztt.mconv.ew.case11(target("riscv.ztt.m.i64", i64, 64, 2, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mconv.ew.case0(target("riscv.ztt.m.i8", i8, 8, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mconv.ew.case4(target("riscv.ztt.m.i8", i8, 8, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 32) @llvm.riscv.ztt.mconv.ew.case19(target("riscv.ztt.m.i8", i8, 8, 1, 32), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 2, 1) @llvm.riscv.ztt.mconv.ew.case2(target("riscv.ztt.m.i8", i8, 8, 2, 1), i32 immarg, i32 immarg)

; A wide square spanning sixteen physical registers still uses one operation.
define target("riscv.ztt.m.i128", i128, 128, 1, 1) @wide_m16() #0 {
; CHECK-LABEL: wide_m16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m16, a0
; CHECK-NEXT:    mzero.2d.m m16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mconv.ew m0, m16
; CHECK-NEXT:    ret
  %a = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.wide(i32 1073741952, i32 1)
  %r = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew.wide(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %r
}
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.wide(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mconv.ew.wide(target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)

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
attributes #15 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #16 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #17 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #18 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #19 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #20 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #21 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #22 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #23 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #24 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #25 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #26 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #27 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #28 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #29 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
