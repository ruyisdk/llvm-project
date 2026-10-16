; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo < %s | FileCheck %s --check-prefix=FOOTPRINT
; RUN: llc -mtriple=riscv64 -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo < %s | FileCheck %s --check-prefix=FOOTPRINT

; Two wide source squares (four registers each) produce two wide result
; squares (two registers each). Metadata reads and every payload tail stay live.
; FOOTPRINT-LABEL: name: case_0_uds8
; FOOTPRINT: $zttm8 = ZTT_MTANH_EW $zttm0, implicit $zttm8, implicit $zttm9, implicit-def $zttm9, implicit $zttm1, implicit $zttm2, implicit $zttm3
; FOOTPRINT-NEXT: $zttm10 = ZTT_MTANH_EW $zttm4, implicit $zttm10, implicit $zttm11, implicit-def $zttm11, implicit $zttm5, implicit $zttm6, implicit $zttm7

; N_sq=max(1,UDS/source_bits,UDS/result_bits); NumOps=K/N_sq.
; Each msettyp/COPY advances one destination square, not one wide register.

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @case_0_uds8(target("riscv.ztt.m.f32", float, 32, 1, 2) %src) #0 {
; CHECK-LABEL: case_0_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mtanh.ew m8, m0
; CHECK-NEXT:    mtanh.ew m10, m4
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mtanh.ew.case0(target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @case_1_uds16(target("riscv.ztt.m.f32", float, 32, 1, 2) %src) #1 {
; CHECK-LABEL: case_1_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mtanh.ew m4, m0
; CHECK-NEXT:    mtanh.ew m5, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mtanh.ew.case1(target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @case_2_uds32(target("riscv.ztt.m.f32", float, 32, 1, 2) %src) #2 {
; CHECK-LABEL: case_2_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mtanh.ew m2, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mtanh.ew.case2(target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @case_3_uds16(target("riscv.ztt.m.f16", half, 16, 1, 1) %src) #3 {
; CHECK-LABEL: case_3_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mtanh.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mtanh.ew.case3(target("riscv.ztt.m.f16", half, 16, 1, 1) %src, i32 540016912, i32 1)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %r
}

define target("riscv.ztt.m.f32", float, 32, 1, 1) @case_4_uds32(target("riscv.ztt.m.f32", float, 32, 1, 1) %src) #4 {
; CHECK-LABEL: case_4_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 288
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mtanh.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mtanh.ew.case4(target("riscv.ztt.m.f32", float, 32, 1, 1) %src, i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 1) @case_5_uds64(target("riscv.ztt.m.f64", double, 64, 1, 1) %src) #5 {
; CHECK-LABEL: case_5_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mtanh.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mtanh.ew.case5(target("riscv.ztt.m.f64", double, 64, 1, 1) %src, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.m.f64", double, 64, 1, 2) @case_6_uds128(target("riscv.ztt.m.f64", double, 64, 1, 2) %src) #6 {
; CHECK-LABEL: case_6_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mtanh.ew m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mtanh.ew.case6(target("riscv.ztt.m.f64", double, 64, 1, 2) %src, i32 741343552, i32 2)
  ret target("riscv.ztt.m.f64", double, 64, 1, 2) %r
}

define target("riscv.ztt.m.f64", double, 64, 4, 1) @case_7_uds64(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %src) #7 {
; CHECK-LABEL: case_7_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    msettyp m7, a0
; CHECK-NEXT:    mtanh.ew m4, m0
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
  %r = call target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mtanh.ew.case7(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %src, i32 741343552, i32 4)
  ret target("riscv.ztt.m.f64", double, 64, 4, 1) %r
}

define target("riscv.ztt.m.f16", half, 16, 1, 1) @case_8_uds8(target("riscv.ztt.m.f64", double, 64, 1, 1) %src) #8 {
; CHECK-LABEL: case_8_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    mtanh.ew m8, m0
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mtanh.ew.case8(target("riscv.ztt.m.f64", double, 64, 1, 1) %src, i32 338690320, i32 1)
  ret target("riscv.ztt.m.f16", half, 16, 1, 1) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) @case_9_uds32(target("riscv.ztt.m.f16", half, 16, 16, 1) %src) #9 {
; CHECK-LABEL: case_9_uds32:
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
; CHECK-NEXT:    mtanh.ew m8, m0
; CHECK-NEXT:    mtanh.ew m9, m1
; CHECK-NEXT:    mtanh.ew m10, m2
; CHECK-NEXT:    mtanh.ew m11, m3
; CHECK-NEXT:    mtanh.ew m12, m4
; CHECK-NEXT:    mtanh.ew m13, m5
; CHECK-NEXT:    mtanh.ew m14, m6
; CHECK-NEXT:    mtanh.ew m15, m7
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
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) @llvm.riscv.ztt.mtanh.ew.case9(target("riscv.ztt.m.f16", half, 16, 16, 1) %src, i32 540016912, i32 16)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mtanh.ew.case3(target("riscv.ztt.m.f16", half, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mtanh.ew.case0(target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mtanh.ew.case1(target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mtanh.ew.case2(target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 16, 1) @llvm.riscv.ztt.mtanh.ew.case9(target("riscv.ztt.m.f16", half, 16, 16, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mtanh.ew.case8(target("riscv.ztt.m.f64", double, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mtanh.ew.case4(target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mtanh.ew.case5(target("riscv.ztt.m.f64", double, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mtanh.ew.case6(target("riscv.ztt.m.f64", double, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mtanh.ew.case7(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1), i32 immarg, i32 immarg)

attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
