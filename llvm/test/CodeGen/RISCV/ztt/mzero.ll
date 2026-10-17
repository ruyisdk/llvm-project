; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s
;
; Numeric zero is not storage-bit clear. Set every square's metadata first,
; then zero each physical M square group or each individual accumulator.
; IR-only return values keep all defined registers live; no C matrix ABI is implied.

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @m_i16_uds8() #0 {
; CHECK-LABEL: m_i16_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @acc_bf16_x1_uds8() #1 {
; CHECK-LABEL: acc_bf16_x1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 2) @acc_bf16_x2_uds8() #2 {
; CHECK-LABEL: acc_bf16_x2_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 4) @acc_bf16_x4_uds8() #3 {
; CHECK-LABEL: acc_bf16_x4_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 4) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_4t(i32 540016912, i32 4)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 4) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @acc_bf16_x8_uds8() #4 {
; CHECK-LABEL: acc_bf16_x8_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    mzero.2d.acc acc4
; CHECK-NEXT:    mzero.2d.acc acc5
; CHECK-NEXT:    mzero.2d.acc acc6
; CHECK-NEXT:    mzero.2d.acc acc7
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @m_i16_uds16() #5 {
; CHECK-LABEL: m_i16_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @acc_bf16_x1_uds16() #6 {
; CHECK-LABEL: acc_bf16_x1_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 2) @acc_bf16_x2_uds16() #7 {
; CHECK-LABEL: acc_bf16_x2_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 4) @acc_bf16_x4_uds16() #8 {
; CHECK-LABEL: acc_bf16_x4_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 4) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_4t(i32 540016912, i32 4)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 4) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @acc_bf16_x8_uds16() #9 {
; CHECK-LABEL: acc_bf16_x8_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    mzero.2d.acc acc4
; CHECK-NEXT:    mzero.2d.acc acc5
; CHECK-NEXT:    mzero.2d.acc acc6
; CHECK-NEXT:    mzero.2d.acc acc7
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @m_i16_uds32() #10 {
; CHECK-LABEL: m_i16_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @acc_bf16_x1_uds32() #11 {
; CHECK-LABEL: acc_bf16_x1_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 2) @acc_bf16_x2_uds32() #12 {
; CHECK-LABEL: acc_bf16_x2_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 4) @acc_bf16_x4_uds32() #13 {
; CHECK-LABEL: acc_bf16_x4_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 4) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_4t(i32 540016912, i32 4)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 4) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @acc_bf16_x8_uds32() #14 {
; CHECK-LABEL: acc_bf16_x8_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    mzero.2d.acc acc4
; CHECK-NEXT:    mzero.2d.acc acc5
; CHECK-NEXT:    mzero.2d.acc acc6
; CHECK-NEXT:    mzero.2d.acc acc7
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @m_i16_uds64() #15 {
; CHECK-LABEL: m_i16_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @acc_bf16_x1_uds64() #16 {
; CHECK-LABEL: acc_bf16_x1_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 2) @acc_bf16_x2_uds64() #17 {
; CHECK-LABEL: acc_bf16_x2_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 4) @acc_bf16_x4_uds64() #18 {
; CHECK-LABEL: acc_bf16_x4_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 4) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_4t(i32 540016912, i32 4)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 4) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @acc_bf16_x8_uds64() #19 {
; CHECK-LABEL: acc_bf16_x8_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    mzero.2d.acc acc4
; CHECK-NEXT:    mzero.2d.acc acc5
; CHECK-NEXT:    mzero.2d.acc acc6
; CHECK-NEXT:    mzero.2d.acc acc7
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @m_i16_uds128() #20 {
; CHECK-LABEL: m_i16_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @acc_bf16_x1_uds128() #21 {
; CHECK-LABEL: acc_bf16_x1_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 2) @acc_bf16_x2_uds128() #22 {
; CHECK-LABEL: acc_bf16_x2_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 4) @acc_bf16_x4_uds128() #23 {
; CHECK-LABEL: acc_bf16_x4_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 4) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_4t(i32 540016912, i32 4)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 4) %v
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @acc_bf16_x8_uds128() #24 {
; CHECK-LABEL: acc_bf16_x8_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mzero.2d.acc acc0
; CHECK-NEXT:    mzero.2d.acc acc1
; CHECK-NEXT:    mzero.2d.acc acc2
; CHECK-NEXT:    mzero.2d.acc acc3
; CHECK-NEXT:    mzero.2d.acc acc4
; CHECK-NEXT:    mzero.2d.acc acc5
; CHECK-NEXT:    mzero.2d.acc acc6
; CHECK-NEXT:    mzero.2d.acc acc7
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @m_i16_1x4_uds8() #25 {
; CHECK-LABEL: m_i16_1x4_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    mzero.2d.m m4
; CHECK-NEXT:    mzero.2d.m m6
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %v
}

define target("riscv.ztt.m.i16", i16, 16, 8, 1) @m_i16_8x1_uds8() #26 {
; CHECK-LABEL: m_i16_8x1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    msettyp m14, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    mzero.2d.m m4
; CHECK-NEXT:    mzero.2d.m m6
; CHECK-NEXT:    mzero.2d.m m8
; CHECK-NEXT:    mzero.2d.m m10
; CHECK-NEXT:    mzero.2d.m m12
; CHECK-NEXT:    mzero.2d.m m14
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_8_1t(i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 8, 1) %v
}

define target("riscv.ztt.m.i32", i32, 32, 1, 8) @m_i32_1x8_uds8() #27 {
; CHECK-LABEL: m_i32_1x8_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    msettyp m16, a0
; CHECK-NEXT:    msettyp m20, a0
; CHECK-NEXT:    msettyp m24, a0
; CHECK-NEXT:    msettyp m28, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m4
; CHECK-NEXT:    mzero.2d.m m8
; CHECK-NEXT:    mzero.2d.m m12
; CHECK-NEXT:    mzero.2d.m m16
; CHECK-NEXT:    mzero.2d.m m20
; CHECK-NEXT:    mzero.2d.m m24
; CHECK-NEXT:    mzero.2d.m m28
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_8t(i32 1073741856, i32 8)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 8) %v
}

define target("riscv.ztt.m.i4", i4, 4, 1, 32) @m_i4_1x32_uds128() #28 {
; CHECK-LABEL: m_i4_1x32_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i4", i4, 4, 1, 32) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i4_i4_4_1_32t(i32 1073741828, i32 32)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 32) %v
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1) @m_i128_1x1_uds8() #29 {
; CHECK-LABEL: m_i128_1x1_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i128_i128_128_1_1t(i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %v
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1) @m_i16_4x1_uds32() #30 {
; CHECK-LABEL: m_i16_4x1_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_4_1t(i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %v
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @m_i16_1x8_uds32() #31 {
; CHECK-LABEL: m_i16_1x8_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    mzero.2d.m m3
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %v
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_1t(i32, i32 immarg)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_2t(i32, i32 immarg)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 4) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_4t(i32, i32 immarg)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.bf16_bfloat_16_8t(i32, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_8_1t(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_8t(i32, i32)
declare target("riscv.ztt.m.i4", i4, 4, 1, 32) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i4_i4_4_1_32t(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i128_i128_128_1_1t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_4_1t(i32, i32)

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
attributes #26 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #27 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #28 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #29 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #30 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #31 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
