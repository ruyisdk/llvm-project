; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s

declare target("riscv.ztt.acc.i32", i32, 32, 1)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_2_1t(
    target("riscv.ztt.acc.i32", i32, 32, 1),
    target("riscv.ztt.m.i16", i16, 16, 1, 2),
    target("riscv.ztt.m.i16", i16, 16, 2, 1), i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 2)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.bf16_bf16_16_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.f32_f32_32_2_1t(
    target("riscv.ztt.acc.bf16", bfloat, 16, 2),
    target("riscv.ztt.m.i16", i16, 16, 1, 2),
    target("riscv.ztt.m.f32", float, 32, 2, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 1)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(
    target("riscv.ztt.acc.i32", i32, 32, 1),
    target("riscv.ztt.m.i32", i32, 32, 1, 1),
    target("riscv.ztt.m.i32", i32, 32, 1, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 8)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_8t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(
    target("riscv.ztt.acc.i32", i32, 32, 8),
    target("riscv.ztt.m.i32", i32, 32, 1, 1),
    target("riscv.ztt.m.i32", i32, 32, 1, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 4)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_4_1t(
    target("riscv.ztt.acc.i32", i32, 32, 4),
    target("riscv.ztt.m.i32", i32, 32, 1, 4),
    target("riscv.ztt.m.i32", i32, 32, 4, 1), i32)
declare target("riscv.ztt.acc.i16", i16, 16, 2)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i16_i16_16_2t.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t(
    target("riscv.ztt.acc.i16", i16, 16, 2),
    target("riscv.ztt.m.i16", i16, 16, 1, 1),
    target("riscv.ztt.m.i16", i16, 16, 1, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 4)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i8_i8_8_1_4t.triscv.ztt.m.i16_i16_16_4_1t(
    target("riscv.ztt.acc.i32", i32, 32, 4),
    target("riscv.ztt.m.i8", i8, 8, 1, 4),
    target("riscv.ztt.m.i16", i16, 16, 4, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 4)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i8_i8_8_4_1t(
    target("riscv.ztt.acc.i32", i32, 32, 4),
    target("riscv.ztt.m.i16", i16, 16, 1, 4),
    target("riscv.ztt.m.i8", i8, 8, 4, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 1)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_8_1t(
    target("riscv.ztt.acc.i32", i32, 32, 1),
    target("riscv.ztt.m.i16", i16, 16, 1, 8),
    target("riscv.ztt.m.i16", i16, 16, 8, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 2)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_8_1t(
    target("riscv.ztt.acc.i32", i32, 32, 2),
    target("riscv.ztt.m.i16", i16, 16, 1, 8),
    target("riscv.ztt.m.i16", i16, 16, 8, 1), i32)
declare target("riscv.ztt.acc.i64", i64, 64, 4)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i64_i64_64_4t.triscv.ztt.m.i64_i64_64_1_8t.triscv.ztt.m.i64_i64_64_8_1t(
    target("riscv.ztt.acc.i64", i64, 64, 4),
    target("riscv.ztt.m.i64", i64, 64, 1, 8),
    target("riscv.ztt.m.i64", i64, 64, 8, 1), i32)
declare target("riscv.ztt.acc.i32", i32, 32, 4)
  @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i16_i16_16_1_16t.triscv.ztt.m.i16_i16_16_16_1t(
    target("riscv.ztt.acc.i32", i32, 32, 4),
    target("riscv.ztt.m.i16", i16, 16, 1, 16),
    target("riscv.ztt.m.i16", i16, 16, 16, 1), i32)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1)
  @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.acc.i32_i32_32_4t(
    target("riscv.ztt.acc.i32", i32, 32, 4), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_8_1t(ptr, i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 1, 8)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i64_i64_64_1_8t(ptr, i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 8, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i64_i64_64_8_1t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 16)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 16, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_16_1t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2)
  @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 2, 1)
  @llvm.riscv.ztt.mzero.m.triscv.ztt.m.f32_f32_32_2_1t(i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_4_1t(
  ptr, target("riscv.ztt.m.i32", i32, 32, 4, 1), i32, i32)

; Packed sources occupy one M register each with UDS=32.
define target("riscv.ztt.acc.i32", i32, 32, 1) @packed_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 1) %acc,
    target("riscv.ztt.m.i16", i16, 16, 1, 2) %lhs,
    target("riscv.ztt.m.i16", i16, 16, 2, 1) %rhs) #0 {
; CHECK-LABEL: packed_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 1)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_2_1t(
      target("riscv.ztt.acc.i32", i32, 32, 1) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %lhs,
      target("riscv.ztt.m.i16", i16, 16, 2, 1) %rhs, i32 2)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

; One instruction processes the largest square count represented by any
; operand.  With UDS=32, i16_1x2 represents two packed squares while f32_2x1
; uses two registers containing one square each, so K=2 needs one instruction.
define target("riscv.ztt.acc.bf16", bfloat, 16, 2)
    @mixed_i16_f32_uds32(
      target("riscv.ztt.acc.bf16", bfloat, 16, 2) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %lhs,
      target("riscv.ztt.m.f32", float, 32, 2, 1) %rhs) #0 {
; CHECK-LABEL: mixed_i16_f32_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 2)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.bf16_bf16_16_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.f32_f32_32_2_1t(
      target("riscv.ztt.acc.bf16", bfloat, 16, 2) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %lhs,
      target("riscv.ztt.m.f32", float, 32, 2, 1) %rhs, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %r
}

; With UDS=8, an i16 square occupies two M registers and an f32 square
; occupies four.  Each instruction processes one f32 square (and the matching
; two-register portion of the i16 source), so K=2 requires two instructions.
define target("riscv.ztt.acc.bf16", bfloat, 16, 2)
    @mixed_i16_f32_uds8(
      target("riscv.ztt.acc.bf16", bfloat, 16, 2) %acc) #1 {
; CHECK-LABEL: mixed_i16_f32_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    addi a1, a1, 288
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    msettyp m8, a1
; CHECK-NEXT:    msettyp m12, a1
; CHECK-NEXT:    mzero.2d.m m8
; CHECK-NEXT:    mzero.2d.m m12
; CHECK-NEXT:    mmulacc.2d acc0, m0, m8
; CHECK-NEXT:    mmulacc.2d acc0, m2, m12
; CHECK-NEXT:    ret
  %lhs = call target("riscv.ztt.m.i16", i16, 16, 1, 2)
    @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(
      i32 1073741840, i32 2)
  %rhs = call target("riscv.ztt.m.f32", float, 32, 2, 1)
    @llvm.riscv.ztt.mzero.m.triscv.ztt.m.f32_f32_32_2_1t(
      i32 540016928, i32 2)
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 2)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.bf16_bf16_16_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.f32_f32_32_2_1t(
      target("riscv.ztt.acc.bf16", bfloat, 16, 2) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %lhs,
      target("riscv.ztt.m.f32", float, 32, 2, 1) %rhs, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %r
}

; Standard one-square sources also occupy one register with UDS=32.
define target("riscv.ztt.acc.i32", i32, 32, 1) @standard_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 1) %acc,
    target("riscv.ztt.m.i32", i32, 32, 1, 1) %lhs,
    target("riscv.ztt.m.i32", i32, 32, 1, 1) %rhs) #0 {
; CHECK-LABEL: standard_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 1)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.acc.i32", i32, 32, 1) %acc,
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %lhs,
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %rhs, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

; Only acc0 is read and written even though the C/IR accumulator contains
; eight squares. The remaining squares stay in acc1-acc7 unchanged.
define target("riscv.ztt.acc.i32", i32, 32, 8) @accx8_first_square_only(
    target("riscv.ztt.acc.i32", i32, 32, 8) %acc,
    target("riscv.ztt.m.i32", i32, 32, 1, 1) %lhs,
    target("riscv.ztt.m.i32", i32, 32, 1, 1) %rhs) #0 {
; CHECK-LABEL: accx8_first_square_only:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 8)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_8t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.acc.i32", i32, 32, 8) %acc,
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %lhs,
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %rhs, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 8) %r
}

; Concatenated 1x4 and 4x1 sources use aligned M4 groups.
define target("riscv.ztt.acc.i32", i32, 32, 4) @concat_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
    target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
    target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs) #0 {
; CHECK-LABEL: concat_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m4
; CHECK-NEXT:    mmulacc.2d acc0, m1, m5
; CHECK-NEXT:    mmulacc.2d acc0, m2, m6
; CHECK-NEXT:    mmulacc.2d acc0, m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_4_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
      target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
      target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs, i32 4)
  ret target("riscv.ztt.acc.i32", i32, 32, 4) %r
}

; A 16-bit square is wide on UDS=8 and therefore each source starts an M2
; group. The instruction still names only each group's base register.
define target("riscv.ztt.acc.i16", i16, 16, 2) @wide_uds8(
    target("riscv.ztt.acc.i16", i16, 16, 2) %acc,
    target("riscv.ztt.m.i16", i16, 16, 1, 1) %lhs,
    target("riscv.ztt.m.i16", i16, 16, 1, 1) %rhs) #1 {
; CHECK-LABEL: wide_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 2)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i16_i16_16_2t.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t(
      target("riscv.ztt.acc.i16", i16, 16, 2) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 1) %lhs,
      target("riscv.ztt.m.i16", i16, 16, 1, 1) %rhs, i32 1)
  ret target("riscv.ztt.acc.i16", i16, 16, 2) %r
}

; Mixed source element widths may produce different physical group sizes.
define target("riscv.ztt.acc.i32", i32, 32, 4) @mixed_groups_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
    target("riscv.ztt.m.i8", i8, 8, 1, 4) %lhs,
    target("riscv.ztt.m.i16", i16, 16, 4, 1) %rhs) #0 {
; CHECK-LABEL: mixed_groups_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i8_i8_8_1_4t.triscv.ztt.m.i16_i16_16_4_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
      target("riscv.ztt.m.i8", i8, 8, 1, 4) %lhs,
      target("riscv.ztt.m.i16", i16, 16, 4, 1) %rhs, i32 4)
  ret target("riscv.ztt.acc.i32", i32, 32, 4) %r
}

; Reverse the source group-size relation: lhs is M2 and rhs is M1.  Together
; with mixed_groups_uds32 this covers independent L/R pseudo selection.
define target("riscv.ztt.acc.i32", i32, 32, 4) @mixed_groups_reverse_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
    target("riscv.ztt.m.i16", i16, 16, 1, 4) %lhs,
    target("riscv.ztt.m.i8", i8, 8, 4, 1) %rhs) #0 {
; CHECK-LABEL: mixed_groups_reverse_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i8_i8_8_4_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 4) %lhs,
      target("riscv.ztt.m.i8", i8, 8, 4, 1) %rhs, i32 4)
  ret target("riscv.ztt.acc.i32", i32, 32, 4) %r
}

; A packed 1x8/8x1 pair exactly fills one 128-bit UDS register.
define target("riscv.ztt.acc.i32", i32, 32, 1) @packed_uds128(
    target("riscv.ztt.acc.i32", i32, 32, 1) %acc,
    target("riscv.ztt.m.i16", i16, 16, 1, 8) %lhs,
    target("riscv.ztt.m.i16", i16, 16, 8, 1) %rhs) #2 {
; CHECK-LABEL: packed_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mmulacc.2d acc0, m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 1)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_8_1t(
      target("riscv.ztt.acc.i32", i32, 32, 1) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 8) %lhs,
      target("riscv.ztt.m.i16", i16, 16, 8, 1) %rhs, i32 8)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

; UDS=16 makes each 1x8/8x1 source an M8 group.  The accx2 value remains
; allocated as one tied ACC2 group while only its first register is encoded.
define target("riscv.ztt.acc.i32", i32, 32, 2) @m8_accx2_uds16(
    target("riscv.ztt.acc.i32", i32, 32, 2) %acc,
    ptr %lhs.base, ptr %rhs.base) #3 {
; CHECK-LABEL: m8_accx2_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.rm m2, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mls.rm m3, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m4, a3
; CHECK-NEXT:    mls.rm m4, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m5, a3
; CHECK-NEXT:    mls.rm m5, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m6, a3
; CHECK-NEXT:    mls.rm m6, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m7, a3
; CHECK-NEXT:    mls.rm m7, a0
; CHECK-NEXT:    msettyp m8, a3
; CHECK-NEXT:    mls.rm m8, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m9, a3
; CHECK-NEXT:    mls.rm m9, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m10, a3
; CHECK-NEXT:    mls.rm m10, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m11, a3
; CHECK-NEXT:    mls.rm m11, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m12, a3
; CHECK-NEXT:    mls.rm m12, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m13, a3
; CHECK-NEXT:    mls.rm m13, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m14, a3
; CHECK-NEXT:    mls.rm m14, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m15, a3
; CHECK-NEXT:    mls.rm m15, a1
; CHECK-NEXT:    mmulacc.2d acc0, m0, m8
; CHECK-NEXT:    mmulacc.2d acc0, m1, m9
; CHECK-NEXT:    mmulacc.2d acc0, m2, m10
; CHECK-NEXT:    mmulacc.2d acc0, m3, m11
; CHECK-NEXT:    mmulacc.2d acc0, m4, m12
; CHECK-NEXT:    mmulacc.2d acc0, m5, m13
; CHECK-NEXT:    mmulacc.2d acc0, m6, m14
; CHECK-NEXT:    mmulacc.2d acc0, m7, m15
; CHECK-NEXT:    ret
  %lhs = call target("riscv.ztt.m.i16", i16, 16, 1, 8)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(
      ptr %lhs.base, i32 1073741840, i32 8)
  %rhs = call target("riscv.ztt.m.i16", i16, 16, 8, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_8_1t(
      ptr %rhs.base, i32 1073741840, i32 8)
  %r = call target("riscv.ztt.acc.i32", i32, 32, 2)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_8_1t(
      target("riscv.ztt.acc.i32", i32, 32, 2) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 8) %lhs,
      target("riscv.ztt.m.i16", i16, 16, 8, 1) %rhs, i32 8)
  ret target("riscv.ztt.acc.i32", i32, 32, 2) %r
}

; UDS=64 makes each eight-square i64 source an M8 group and exercises an
; accx4 accumulator independently of the source group size.
define target("riscv.ztt.acc.i64", i64, 64, 4) @m8_accx4_uds64(
    target("riscv.ztt.acc.i64", i64, 64, 4) %acc,
    ptr %lhs.base, ptr %rhs.base) #4 {
; CHECK-LABEL: m8_accx4_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 3
; CHECK-NEXT:    addi a3, a3, 64
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.rm m2, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mls.rm m3, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m4, a3
; CHECK-NEXT:    mls.rm m4, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m5, a3
; CHECK-NEXT:    mls.rm m5, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m6, a3
; CHECK-NEXT:    mls.rm m6, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m7, a3
; CHECK-NEXT:    mls.rm m7, a0
; CHECK-NEXT:    msettyp m8, a3
; CHECK-NEXT:    mls.rm m8, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m9, a3
; CHECK-NEXT:    mls.rm m9, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m10, a3
; CHECK-NEXT:    mls.rm m10, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m11, a3
; CHECK-NEXT:    mls.rm m11, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m12, a3
; CHECK-NEXT:    mls.rm m12, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m13, a3
; CHECK-NEXT:    mls.rm m13, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m14, a3
; CHECK-NEXT:    mls.rm m14, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m15, a3
; CHECK-NEXT:    mls.rm m15, a1
; CHECK-NEXT:    mmulacc.2d acc0, m0, m8
; CHECK-NEXT:    mmulacc.2d acc0, m1, m9
; CHECK-NEXT:    mmulacc.2d acc0, m2, m10
; CHECK-NEXT:    mmulacc.2d acc0, m3, m11
; CHECK-NEXT:    mmulacc.2d acc0, m4, m12
; CHECK-NEXT:    mmulacc.2d acc0, m5, m13
; CHECK-NEXT:    mmulacc.2d acc0, m6, m14
; CHECK-NEXT:    mmulacc.2d acc0, m7, m15
; CHECK-NEXT:    ret
  %lhs = call target("riscv.ztt.m.i64", i64, 64, 1, 8)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i64_i64_64_1_8t(
      ptr %lhs.base, i32 1073741888, i32 8)
  %rhs = call target("riscv.ztt.m.i64", i64, 64, 8, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i64_i64_64_8_1t(
      ptr %rhs.base, i32 1073741888, i32 8)
  %r = call target("riscv.ztt.acc.i64", i64, 64, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i64_i64_64_4t.triscv.ztt.m.i64_i64_64_1_8t.triscv.ztt.m.i64_i64_64_8_1t(
      target("riscv.ztt.acc.i64", i64, 64, 4) %acc,
      target("riscv.ztt.m.i64", i64, 64, 1, 8) %lhs,
      target("riscv.ztt.m.i64", i64, 64, 8, 1) %rhs, i32 8)
  ret target("riscv.ztt.acc.i64", i64, 64, 4) %r
}

; Two M16 operands consume all 32 M registers and form the largest pair of
; disjoint source groups accepted by one intrinsic call. With UDS=16, each
; instruction processes one square, so K=16 requires sixteen instructions.
define target("riscv.ztt.acc.i32", i32, 32, 4) @m16_m16_uds16(
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
    ptr %lhs.base, ptr %rhs.base) #3 {
; CHECK-LABEL: m16_m16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.rm m2, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mls.rm m3, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m4, a3
; CHECK-NEXT:    mls.rm m4, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m5, a3
; CHECK-NEXT:    mls.rm m5, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m6, a3
; CHECK-NEXT:    mls.rm m6, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m7, a3
; CHECK-NEXT:    mls.rm m7, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m8, a3
; CHECK-NEXT:    mls.rm m8, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m9, a3
; CHECK-NEXT:    mls.rm m9, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m10, a3
; CHECK-NEXT:    mls.rm m10, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m11, a3
; CHECK-NEXT:    mls.rm m11, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m12, a3
; CHECK-NEXT:    mls.rm m12, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m13, a3
; CHECK-NEXT:    mls.rm m13, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m14, a3
; CHECK-NEXT:    mls.rm m14, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m15, a3
; CHECK-NEXT:    mls.rm m15, a0
; CHECK-NEXT:    msettyp m16, a3
; CHECK-NEXT:    mls.rm m16, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m17, a3
; CHECK-NEXT:    mls.rm m17, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m18, a3
; CHECK-NEXT:    mls.rm m18, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m19, a3
; CHECK-NEXT:    mls.rm m19, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m20, a3
; CHECK-NEXT:    mls.rm m20, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m21, a3
; CHECK-NEXT:    mls.rm m21, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m22, a3
; CHECK-NEXT:    mls.rm m22, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m23, a3
; CHECK-NEXT:    mls.rm m23, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m24, a3
; CHECK-NEXT:    mls.rm m24, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m25, a3
; CHECK-NEXT:    mls.rm m25, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m26, a3
; CHECK-NEXT:    mls.rm m26, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m27, a3
; CHECK-NEXT:    mls.rm m27, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m28, a3
; CHECK-NEXT:    mls.rm m28, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m29, a3
; CHECK-NEXT:    mls.rm m29, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m30, a3
; CHECK-NEXT:    mls.rm m30, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    msettyp m31, a3
; CHECK-NEXT:    mls.rm m31, a1
; CHECK-NEXT:    mmulacc.2d acc0, m0, m16
; CHECK-NEXT:    mmulacc.2d acc0, m1, m17
; CHECK-NEXT:    mmulacc.2d acc0, m2, m18
; CHECK-NEXT:    mmulacc.2d acc0, m3, m19
; CHECK-NEXT:    mmulacc.2d acc0, m4, m20
; CHECK-NEXT:    mmulacc.2d acc0, m5, m21
; CHECK-NEXT:    mmulacc.2d acc0, m6, m22
; CHECK-NEXT:    mmulacc.2d acc0, m7, m23
; CHECK-NEXT:    mmulacc.2d acc0, m8, m24
; CHECK-NEXT:    mmulacc.2d acc0, m9, m25
; CHECK-NEXT:    mmulacc.2d acc0, m10, m26
; CHECK-NEXT:    mmulacc.2d acc0, m11, m27
; CHECK-NEXT:    mmulacc.2d acc0, m12, m28
; CHECK-NEXT:    mmulacc.2d acc0, m13, m29
; CHECK-NEXT:    mmulacc.2d acc0, m14, m30
; CHECK-NEXT:    mmulacc.2d acc0, m15, m31
; CHECK-NEXT:    ret
  %lhs = call target("riscv.ztt.m.i16", i16, 16, 1, 16)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_16t(
      ptr %lhs.base, i32 1073741840, i32 16)
  %rhs = call target("riscv.ztt.m.i16", i16, 16, 16, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_16_1t(
      ptr %rhs.base, i32 1073741840, i32 16)
  %r = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i16_i16_16_1_16t.triscv.ztt.m.i16_i16_16_16_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
      target("riscv.ztt.m.i16", i16, 16, 1, 16) %lhs,
      target("riscv.ztt.m.i16", i16, 16, 16, 1) %rhs, i32 16)
  ret target("riscv.ztt.acc.i32", i32, 32, 4) %r
}

; Copying the complete accx4 result afterwards observes all four squares.
; mmulacc.2d changes acc0 only; the a2m sequence must still read acc1-acc3.
define target("riscv.ztt.m.i32", i32, 32, 4, 1) @accx4_tail_to_m_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
    target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
    target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs) #0 {
; CHECK-LABEL: accx4_tail_to_m_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    mmulacc.2d acc0, m0, m4
; CHECK-NEXT:    mmulacc.2d acc0, m1, m5
; CHECK-NEXT:    mmulacc.2d acc0, m2, m6
; CHECK-NEXT:    mmulacc.2d acc0, m3, m7
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.a m1, acc1
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.a m2, acc2
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.a m3, acc3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_4_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc,
      target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
      target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs, i32 4)
  %m = call target("riscv.ztt.m.i32", i32, 32, 4, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.acc.i32_i32_32_4t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %r, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %m
}

; Both accx4 results are simultaneously live after the second multiply.  They
; must occupy disjoint ACC groups even though each instruction writes only the
; first register of its own group.
define void @two_live_accx4_uds32(
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc0,
    target("riscv.ztt.acc.i32", i32, 32, 4) %acc1,
    target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
    target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs,
    ptr %out0, ptr %out1) #5 {
; CHECK-LABEL: two_live_accx4_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    mmulacc.2d acc0, m0, m4
; CHECK-NEXT:    mmulacc.2d acc0, m1, m5
; CHECK-NEXT:    mmulacc.2d acc0, m2, m6
; CHECK-NEXT:    mmulacc.2d acc0, m3, m7
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    mmulacc.2d acc4, m0, m4
; CHECK-NEXT:    mmulacc.2d acc4, m1, m5
; CHECK-NEXT:    mmulacc.2d acc4, m2, m6
; CHECK-NEXT:    mmulacc.2d acc4, m3, m7
; CHECK-NEXT:    addi a3, a3, 32
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mmov.m.a m1, acc1
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mmov.m.a m2, acc2
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mmov.m.a m3, acc3
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    mss.rm m1, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    mss.rm m3, a0
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mmov.m.a m0, acc4
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mmov.m.a m1, acc5
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mmov.m.a m2, acc6
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mmov.m.a m3, acc7
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m3, a1
; CHECK-NEXT:    ret
  %r0 = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_4_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc0,
      target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
      target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs, i32 4)
  %r1 = call target("riscv.ztt.acc.i32", i32, 32, 4)
    @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_4_1t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %acc1,
      target("riscv.ztt.m.i32", i32, 32, 1, 4) %lhs,
      target("riscv.ztt.m.i32", i32, 32, 4, 1) %rhs, i32 4)
  %m = call target("riscv.ztt.m.i32", i32, 32, 4, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.acc.i32_i32_32_4t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %r0, i32 1073741856, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_4_1t(
    ptr %out0, target("riscv.ztt.m.i32", i32, 32, 4, 1) %m,
    i32 1073741856, i32 4)
  %n = call target("riscv.ztt.m.i32", i32, 32, 4, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.acc.i32_i32_32_4t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %r1, i32 1073741856, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_4_1t(
    ptr %out1, target("riscv.ztt.m.i32", i32, 32, 4, 1) %n,
    i32 1073741856, i32 4)
  ret void
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #1 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #3 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #4 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #5 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
