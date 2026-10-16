; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s
;
; Suffix option bits must survive descriptor materialization without changing
; layout. Use one wide, concatenated M and one ACC representative; the complete
; datatype/alias matrix belongs to the frontend tests.

define target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 2) @integer_options() #0 {
; CHECK-LABEL: integer_options:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 491520
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_rod_sat_i16_16_1_2t(i32 2013265936, i32 2)
  ret target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 2) %v
}

define target("riscv.ztt.acc.f32_rno", float, 32, 2) @float_options() #0 {
; CHECK-LABEL: float_options:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 136960
; CHECK-NEXT:    addi a0, a0, 288
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.f32_rno", float, 32, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.f32_rno_float_32_2t(i32 560988448, i32 2)
  ret target("riscv.ztt.acc.f32_rno", float, 32, 2) %v
}

declare target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_rod_sat_i16_16_1_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.f32_rno", float, 32, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.f32_rno_float_32_2t(i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
