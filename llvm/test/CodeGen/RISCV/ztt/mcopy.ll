; RUN: split-file %s %t
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %t/m/input.ll | FileCheck %t/m/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %t/acc/input.ll | FileCheck %t/acc/input.ll
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %t/acc/input.ll | FileCheck %t/acc/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/datatype/input.ll > %t.ztt-profile-0.ll
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o - | FileCheck %t/datatype/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/datatype/input.ll > %t.ztt-profile-1.ll
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o - | FileCheck %t/datatype/input.ll
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs < %t/invalid/tmp/m2a-non-m.ll 2>&1    | FileCheck %t/invalid/checks.txt --check-prefix=TYPE
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs < %t/invalid/tmp/a2m-non-acc.ll 2>&1    | FileCheck %t/invalid/checks.txt --check-prefix=TYPE
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs < %t/invalid/tmp/square-mismatch.ll 2>&1    | FileCheck %t/invalid/checks.txt --check-prefix=SQUARE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/packed-machine/input.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %t/packed-machine/input.mir
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/packed-machine/input.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %t/packed-machine/input.mir
; RUN: llc -mtriple=riscv32 -verify-machineinstrs %t/packed-roundtrip/input.ll -o - | FileCheck %t/packed-roundtrip/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs %t/packed-roundtrip/input.ll -o - | FileCheck %t/packed-roundtrip/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs %t/uds128/input.ll -o - | FileCheck %t/uds128/input.ll

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- m/input.ll
declare target("riscv.ztt.m.i4", i4, 4, 1, 2)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i4_i4_4_1_2t(
    target("riscv.ztt.m.i4", i4, 4, 1, 2), i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 1)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i8_i8_8_1_1t(
    target("riscv.ztt.m.i8", i8, 8, 1, 1), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_2t(
    target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_4_1t(
    target("riscv.ztt.m.i16", i16, 16, 4, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_1t(
    target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_2t(
    target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)

define target("riscv.ztt.m.i4", i4, 4, 1, 2)
    @mcopy_i4_1x2_uds8(
      target("riscv.ztt.m.i4", i4, 4, 1, 2) %src) #2 {
; CHECK-LABEL: mcopy_i4_1x2_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 1, 2)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i4_i4_4_1_2t(
      target("riscv.ztt.m.i4", i4, 4, 1, 2) %src, i32 1073741828, i32 2)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 2) %r
}

define target("riscv.ztt.m.i8", i8, 8, 1, 1)
    @mcopy_i8_1x1_uds8(
      target("riscv.ztt.m.i8", i8, 8, 1, 1) %src) #2 {
; CHECK-LABEL: mcopy_i8_1x1_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 1)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i8_i8_8_1_1t(
      target("riscv.ztt.m.i8", i8, 8, 1, 1) %src, i32 1073741832, i32 1)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2)
    @mcopy_packed_i16_1x2_uds32(
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %src) #0 {
; CHECK-LABEL: mcopy_packed_i16_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_2t(
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @mcopy_standard_i32_1x1_uds32(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) #0 {
; CHECK-LABEL: mcopy_standard_i32_1x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @mcopy_wide_i32_1x1_uds16(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) #1 {
; CHECK-LABEL: mcopy_wide_i32_1x1_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2)
    @mcopy_concat_i32_1x2_uds32(
      target("riscv.ztt.m.i32", i32, 32, 1, 2) %src) #0 {
; CHECK-LABEL: mcopy_concat_i32_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_2t(
      target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 4, 1)
    @mcopy_concat_i16_4x1_uds32(
      target("riscv.ztt.m.i16", i16, 16, 4, 1) %src) #0 {
; CHECK-LABEL: mcopy_concat_i16_4x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 4, 1)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_4_1t(
      target("riscv.ztt.m.i16", i16, 16, 4, 1) %src, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %r
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #1 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #2 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }

;--- acc/input.ll
declare target("riscv.ztt.acc.i32", i32, 32, 1)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(
    target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.acc.i4", i4, 4, 2)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i4_i4_4_2t.triscv.ztt.m.i4_i4_4_1_2t(
    target("riscv.ztt.m.i4", i4, 4, 1, 2), i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 2)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_2t.triscv.ztt.m.i16_i16_16_1_2t(
    target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 2)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_2t.triscv.ztt.m.i16_i16_16_2_1t(
    target("riscv.ztt.m.i16", i16, 16, 2, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1)
  @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.acc.i32_i32_32_4t(
    target("riscv.ztt.acc.i32", i32, 32, 4), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1)
  @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(
    target("riscv.ztt.acc.i32", i32, 32, 1), i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 8)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(
    target("riscv.ztt.m.i16", i16, 16, 1, 8), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1)
  @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_8_1t.triscv.ztt.acc.i16_i16_16_8t(
    target("riscv.ztt.acc.i16", i16, 16, 8), i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 4)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_4t.triscv.ztt.m.i16_i16_16_1_4t(
    target("riscv.ztt.m.i16", i16, 16, 1, 4), i32, i32)

define target("riscv.ztt.acc.i4", i4, 4, 2)
    @mcopy_m2a_i4_accx2_uds8(
      target("riscv.ztt.m.i4", i4, 4, 1, 2) %src) #1 {
; CHECK-LABEL: mcopy_m2a_i4_accx2_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i4", i4, 4, 2)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i4_i4_4_2t.triscv.ztt.m.i4_i4_4_1_2t(
      target("riscv.ztt.m.i4", i4, 4, 1, 2) %src, i32 1073741828, i32 2)
  ret target("riscv.ztt.acc.i4", i4, 4, 2) %r
}

define target("riscv.ztt.acc.i32", i32, 32, 1)
    @mcopy_m2a_standard_i32_accx1_uds32(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) #0 {
; CHECK-LABEL: mcopy_m2a_standard_i32_accx1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 1)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

define target("riscv.ztt.acc.i32", i32, 32, 1)
    @mcopy_m2a_wide_i32_accx1_uds16(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) #2 {
; CHECK-LABEL: mcopy_m2a_wide_i32_accx1_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i32", i32, 32, 1)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @mcopy_a2m_wide_i32_1x1_uds16(
      target("riscv.ztt.acc.i32", i32, 32, 1) %src) #2 {
; CHECK-LABEL: mcopy_a2m_wide_i32_1x1_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(
      target("riscv.ztt.acc.i32", i32, 32, 1) %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

define target("riscv.ztt.acc.i16", i16, 16, 2)
    @mcopy_m2a_packed_i16_1x2_uds32(
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %src) #0 {
; CHECK-LABEL: mcopy_m2a_packed_i16_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 2)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_2t.triscv.ztt.m.i16_i16_16_1_2t(
      target("riscv.ztt.m.i16", i16, 16, 1, 2) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.acc.i16", i16, 16, 2) %r
}

define target("riscv.ztt.acc.i16", i16, 16, 2)
    @mcopy_m2a_packed_i16_2x1_uds32(
      target("riscv.ztt.m.i16", i16, 16, 2, 1) %src) #0 {
; CHECK-LABEL: mcopy_m2a_packed_i16_2x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 2)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_2t.triscv.ztt.m.i16_i16_16_2_1t(
      target("riscv.ztt.m.i16", i16, 16, 2, 1) %src, i32 1073741840, i32 2)
  ret target("riscv.ztt.acc.i16", i16, 16, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 4, 1)
    @mcopy_a2m_concat_i32_4x1_uds32(
      target("riscv.ztt.acc.i32", i32, 32, 4) %src) #0 {
; CHECK-LABEL: mcopy_a2m_concat_i32_4x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
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
  %r = call target("riscv.ztt.m.i32", i32, 32, 4, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.acc.i32_i32_32_4t(
      target("riscv.ztt.acc.i32", i32, 32, 4) %src, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %r
}

; Packed UDS=32 M registers contain two i16 squares each.  Copying accx8
; therefore consumes four M registers, while all eight ACC metadata registers
; are initialized as required by the C-level accx8 result type.
define target("riscv.ztt.acc.i16", i16, 16, 8)
    @mcopy_m2a_packed_i16_accx8_uds32(
      target("riscv.ztt.m.i16", i16, 16, 1, 8) %src) #0 {
; CHECK-LABEL: mcopy_m2a_packed_i16_accx8_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mmov.a.m acc2, m1
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    mmov.a.m acc4, m2
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc6, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 8)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(
      target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, i32 1073741840, i32 8)
  ret target("riscv.ztt.acc.i16", i16, 16, 8) %r
}

define target("riscv.ztt.m.i16", i16, 16, 8, 1)
    @mcopy_a2m_packed_i16_8x1_uds32(
      target("riscv.ztt.acc.i16", i16, 16, 8) %src) #0 {
; CHECK-LABEL: mcopy_a2m_packed_i16_8x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.a m1, acc2
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.a m2, acc4
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.a m3, acc6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 8, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_8_1t.triscv.ztt.acc.i16_i16_16_8t(
      target("riscv.ztt.acc.i16", i16, 16, 8) %src, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 8, 1) %r
}

; With UDS=64, one packed M register carries four i16 squares.
define target("riscv.ztt.acc.i16", i16, 16, 4)
    @mcopy_m2a_packed_i16_accx4_uds64(
      target("riscv.ztt.m.i16", i16, 16, 1, 4) %src) #3 {
; CHECK-LABEL: mcopy_m2a_packed_i16_accx4_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 4)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_4t.triscv.ztt.m.i16_i16_16_1_4t(
      target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret target("riscv.ztt.acc.i16", i16, 16, 4) %r
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #1 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #3 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }

; Eight packed squares fit in one physical M register. The design requires
; eight asettyp plus ONE mmov.a.m, or ONE msettyp plus ONE mmov.m.a.
; Cover all current datatype/UDS pairs with this layout, in both directions.

declare target("riscv.ztt.acc.i4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i4_i4_4_8t.triscv.ztt.m.i4_i4_4_1_8t(target("riscv.ztt.m.i4", i4, 4, 1, 8), i32, i32)
define target("riscv.ztt.acc.i4", i4, 4, 8) @m2a_i4_1x8_a8_m1(target("riscv.ztt.m.i4", i4, 4, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: m2a_i4_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i4_i4_4_8t.triscv.ztt.m.i4_i4_4_1_8t(target("riscv.ztt.m.i4", i4, 4, 1, 8) %v, i32 1073741828, i32 8)
  ret target("riscv.ztt.acc.i4", i4, 4, 8) %r
}

declare target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i4_i4_4_1_8t.triscv.ztt.acc.i4_i4_4_8t(target("riscv.ztt.acc.i4", i4, 4, 8), i32, i32)
define target("riscv.ztt.m.i4", i4, 4, 1, 8) @a2m_i4_1x8_a8_m1(target("riscv.ztt.acc.i4", i4, 4, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: a2m_i4_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i4_i4_4_1_8t.triscv.ztt.acc.i4_i4_4_8t(target("riscv.ztt.acc.i4", i4, 4, 8) %v, i32 1073741828, i32 8)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 8) %r
}

declare target("riscv.ztt.acc.i4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i4_i4_4_8t.triscv.ztt.m.i4_i4_4_8_1t(target("riscv.ztt.m.i4", i4, 4, 8, 1), i32, i32)
define target("riscv.ztt.acc.i4", i4, 4, 8) @m2a_i4_8x1_a8_m1(target("riscv.ztt.m.i4", i4, 4, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: m2a_i4_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i4_i4_4_8t.triscv.ztt.m.i4_i4_4_8_1t(target("riscv.ztt.m.i4", i4, 4, 8, 1) %v, i32 1073741828, i32 8)
  ret target("riscv.ztt.acc.i4", i4, 4, 8) %r
}

declare target("riscv.ztt.m.i4", i4, 4, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i4_i4_4_8_1t.triscv.ztt.acc.i4_i4_4_8t(target("riscv.ztt.acc.i4", i4, 4, 8), i32, i32)
define target("riscv.ztt.m.i4", i4, 4, 8, 1) @a2m_i4_8x1_a8_m1(target("riscv.ztt.acc.i4", i4, 4, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: a2m_i4_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i4", i4, 4, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i4_i4_4_8_1t.triscv.ztt.acc.i4_i4_4_8t(target("riscv.ztt.acc.i4", i4, 4, 8) %v, i32 1073741828, i32 8)
  ret target("riscv.ztt.m.i4", i4, 4, 8, 1) %r
}

declare target("riscv.ztt.acc.u4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u4_i4_4_8t.triscv.ztt.m.u4_i4_4_1_8t(target("riscv.ztt.m.u4", i4, 4, 1, 8), i32, i32)
define target("riscv.ztt.acc.u4", i4, 4, 8) @m2a_u4_1x8_a8_m1(target("riscv.ztt.m.u4", i4, 4, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: m2a_u4_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 4
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u4_i4_4_8t.triscv.ztt.m.u4_i4_4_1_8t(target("riscv.ztt.m.u4", i4, 4, 1, 8) %v, i32 4, i32 8)
  ret target("riscv.ztt.acc.u4", i4, 4, 8) %r
}

declare target("riscv.ztt.m.u4", i4, 4, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u4_i4_4_1_8t.triscv.ztt.acc.u4_i4_4_8t(target("riscv.ztt.acc.u4", i4, 4, 8), i32, i32)
define target("riscv.ztt.m.u4", i4, 4, 1, 8) @a2m_u4_1x8_a8_m1(target("riscv.ztt.acc.u4", i4, 4, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: a2m_u4_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u4", i4, 4, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u4_i4_4_1_8t.triscv.ztt.acc.u4_i4_4_8t(target("riscv.ztt.acc.u4", i4, 4, 8) %v, i32 4, i32 8)
  ret target("riscv.ztt.m.u4", i4, 4, 1, 8) %r
}

declare target("riscv.ztt.acc.u4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u4_i4_4_8t.triscv.ztt.m.u4_i4_4_8_1t(target("riscv.ztt.m.u4", i4, 4, 8, 1), i32, i32)
define target("riscv.ztt.acc.u4", i4, 4, 8) @m2a_u4_8x1_a8_m1(target("riscv.ztt.m.u4", i4, 4, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: m2a_u4_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 4
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u4", i4, 4, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u4_i4_4_8t.triscv.ztt.m.u4_i4_4_8_1t(target("riscv.ztt.m.u4", i4, 4, 8, 1) %v, i32 4, i32 8)
  ret target("riscv.ztt.acc.u4", i4, 4, 8) %r
}

declare target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u4_i4_4_8_1t.triscv.ztt.acc.u4_i4_4_8t(target("riscv.ztt.acc.u4", i4, 4, 8), i32, i32)
define target("riscv.ztt.m.u4", i4, 4, 8, 1) @a2m_u4_8x1_a8_m1(target("riscv.ztt.acc.u4", i4, 4, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: a2m_u4_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u4", i4, 4, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u4_i4_4_8_1t.triscv.ztt.acc.u4_i4_4_8t(target("riscv.ztt.acc.u4", i4, 4, 8) %v, i32 4, i32 8)
  ret target("riscv.ztt.m.u4", i4, 4, 8, 1) %r
}

declare target("riscv.ztt.acc.i8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i8_i8_8_8t.triscv.ztt.m.i8_i8_8_1_8t(target("riscv.ztt.m.i8", i8, 8, 1, 8), i32, i32)
define target("riscv.ztt.acc.i8", i8, 8, 8) @m2a_i8_1x8_a8_m1(target("riscv.ztt.m.i8", i8, 8, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: m2a_i8_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i8_i8_8_8t.triscv.ztt.m.i8_i8_8_1_8t(target("riscv.ztt.m.i8", i8, 8, 1, 8) %v, i32 1073741832, i32 8)
  ret target("riscv.ztt.acc.i8", i8, 8, 8) %r
}

declare target("riscv.ztt.m.i8", i8, 8, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i8_i8_8_1_8t.triscv.ztt.acc.i8_i8_8_8t(target("riscv.ztt.acc.i8", i8, 8, 8), i32, i32)
define target("riscv.ztt.m.i8", i8, 8, 1, 8) @a2m_i8_1x8_a8_m1(target("riscv.ztt.acc.i8", i8, 8, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: a2m_i8_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i8_i8_8_1_8t.triscv.ztt.acc.i8_i8_8_8t(target("riscv.ztt.acc.i8", i8, 8, 8) %v, i32 1073741832, i32 8)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 8) %r
}

declare target("riscv.ztt.acc.i8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i8_i8_8_8t.triscv.ztt.m.i8_i8_8_8_1t(target("riscv.ztt.m.i8", i8, 8, 8, 1), i32, i32)
define target("riscv.ztt.acc.i8", i8, 8, 8) @m2a_i8_8x1_a8_m1(target("riscv.ztt.m.i8", i8, 8, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: m2a_i8_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i8_i8_8_8t.triscv.ztt.m.i8_i8_8_8_1t(target("riscv.ztt.m.i8", i8, 8, 8, 1) %v, i32 1073741832, i32 8)
  ret target("riscv.ztt.acc.i8", i8, 8, 8) %r
}

declare target("riscv.ztt.m.i8", i8, 8, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i8_i8_8_8_1t.triscv.ztt.acc.i8_i8_8_8t(target("riscv.ztt.acc.i8", i8, 8, 8), i32, i32)
define target("riscv.ztt.m.i8", i8, 8, 8, 1) @a2m_i8_8x1_a8_m1(target("riscv.ztt.acc.i8", i8, 8, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: a2m_i8_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i8", i8, 8, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i8_i8_8_8_1t.triscv.ztt.acc.i8_i8_8_8t(target("riscv.ztt.acc.i8", i8, 8, 8) %v, i32 1073741832, i32 8)
  ret target("riscv.ztt.m.i8", i8, 8, 8, 1) %r
}

declare target("riscv.ztt.acc.u8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u8_i8_8_8t.triscv.ztt.m.u8_i8_8_1_8t(target("riscv.ztt.m.u8", i8, 8, 1, 8), i32, i32)
define target("riscv.ztt.acc.u8", i8, 8, 8) @m2a_u8_1x8_a8_m1(target("riscv.ztt.m.u8", i8, 8, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: m2a_u8_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 8
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u8_i8_8_8t.triscv.ztt.m.u8_i8_8_1_8t(target("riscv.ztt.m.u8", i8, 8, 1, 8) %v, i32 8, i32 8)
  ret target("riscv.ztt.acc.u8", i8, 8, 8) %r
}

declare target("riscv.ztt.m.u8", i8, 8, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u8_i8_8_1_8t.triscv.ztt.acc.u8_i8_8_8t(target("riscv.ztt.acc.u8", i8, 8, 8), i32, i32)
define target("riscv.ztt.m.u8", i8, 8, 1, 8) @a2m_u8_1x8_a8_m1(target("riscv.ztt.acc.u8", i8, 8, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: a2m_u8_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u8", i8, 8, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u8_i8_8_1_8t.triscv.ztt.acc.u8_i8_8_8t(target("riscv.ztt.acc.u8", i8, 8, 8) %v, i32 8, i32 8)
  ret target("riscv.ztt.m.u8", i8, 8, 1, 8) %r
}

declare target("riscv.ztt.acc.u8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u8_i8_8_8t.triscv.ztt.m.u8_i8_8_8_1t(target("riscv.ztt.m.u8", i8, 8, 8, 1), i32, i32)
define target("riscv.ztt.acc.u8", i8, 8, 8) @m2a_u8_8x1_a8_m1(target("riscv.ztt.m.u8", i8, 8, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: m2a_u8_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 8
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u8", i8, 8, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u8_i8_8_8t.triscv.ztt.m.u8_i8_8_8_1t(target("riscv.ztt.m.u8", i8, 8, 8, 1) %v, i32 8, i32 8)
  ret target("riscv.ztt.acc.u8", i8, 8, 8) %r
}

declare target("riscv.ztt.m.u8", i8, 8, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u8_i8_8_8_1t.triscv.ztt.acc.u8_i8_8_8t(target("riscv.ztt.acc.u8", i8, 8, 8), i32, i32)
define target("riscv.ztt.m.u8", i8, 8, 8, 1) @a2m_u8_8x1_a8_m1(target("riscv.ztt.acc.u8", i8, 8, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: a2m_u8_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u8", i8, 8, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u8_i8_8_8_1t.triscv.ztt.acc.u8_i8_8_8t(target("riscv.ztt.acc.u8", i8, 8, 8) %v, i32 8, i32 8)
  ret target("riscv.ztt.m.u8", i8, 8, 8, 1) %r
}


define target("riscv.ztt.acc.i16", i16, 16, 8) @m2a_i16_1x8_a8_m1(target("riscv.ztt.m.i16", i16, 16, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_i16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8) %v, i32 1073741840, i32 8)
  ret target("riscv.ztt.acc.i16", i16, 16, 8) %r
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8), i32, i32)
define target("riscv.ztt.m.i16", i16, 16, 1, 8) @a2m_i16_1x8_a8_m1(target("riscv.ztt.acc.i16", i16, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_i16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8) %v, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %r
}

declare target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_8_1t(target("riscv.ztt.m.i16", i16, 16, 8, 1), i32, i32)
define target("riscv.ztt.acc.i16", i16, 16, 8) @m2a_i16_8x1_a8_m1(target("riscv.ztt.m.i16", i16, 16, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_i16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_8_1t(target("riscv.ztt.m.i16", i16, 16, 8, 1) %v, i32 1073741840, i32 8)
  ret target("riscv.ztt.acc.i16", i16, 16, 8) %r
}


define target("riscv.ztt.m.i16", i16, 16, 8, 1) @a2m_i16_8x1_a8_m1(target("riscv.ztt.acc.i16", i16, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_i16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_8_1t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8) %v, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 8, 1) %r
}

declare target("riscv.ztt.acc.u16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u16_i16_16_8t.triscv.ztt.m.u16_i16_16_1_8t(target("riscv.ztt.m.u16", i16, 16, 1, 8), i32, i32)
define target("riscv.ztt.acc.u16", i16, 16, 8) @m2a_u16_1x8_a8_m1(target("riscv.ztt.m.u16", i16, 16, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_u16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u16_i16_16_8t.triscv.ztt.m.u16_i16_16_1_8t(target("riscv.ztt.m.u16", i16, 16, 1, 8) %v, i32 16, i32 8)
  ret target("riscv.ztt.acc.u16", i16, 16, 8) %r
}

declare target("riscv.ztt.m.u16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u16_i16_16_1_8t.triscv.ztt.acc.u16_i16_16_8t(target("riscv.ztt.acc.u16", i16, 16, 8), i32, i32)
define target("riscv.ztt.m.u16", i16, 16, 1, 8) @a2m_u16_1x8_a8_m1(target("riscv.ztt.acc.u16", i16, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_u16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u16_i16_16_1_8t.triscv.ztt.acc.u16_i16_16_8t(target("riscv.ztt.acc.u16", i16, 16, 8) %v, i32 16, i32 8)
  ret target("riscv.ztt.m.u16", i16, 16, 1, 8) %r
}

declare target("riscv.ztt.acc.u16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u16_i16_16_8t.triscv.ztt.m.u16_i16_16_8_1t(target("riscv.ztt.m.u16", i16, 16, 8, 1), i32, i32)
define target("riscv.ztt.acc.u16", i16, 16, 8) @m2a_u16_8x1_a8_m1(target("riscv.ztt.m.u16", i16, 16, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_u16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u16_i16_16_8t.triscv.ztt.m.u16_i16_16_8_1t(target("riscv.ztt.m.u16", i16, 16, 8, 1) %v, i32 16, i32 8)
  ret target("riscv.ztt.acc.u16", i16, 16, 8) %r
}

declare target("riscv.ztt.m.u16", i16, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u16_i16_16_8_1t.triscv.ztt.acc.u16_i16_16_8t(target("riscv.ztt.acc.u16", i16, 16, 8), i32, i32)
define target("riscv.ztt.m.u16", i16, 16, 8, 1) @a2m_u16_8x1_a8_m1(target("riscv.ztt.acc.u16", i16, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_u16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u16", i16, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u16_i16_16_8_1t.triscv.ztt.acc.u16_i16_16_8t(target("riscv.ztt.acc.u16", i16, 16, 8) %v, i32 16, i32 8)
  ret target("riscv.ztt.m.u16", i16, 16, 8, 1) %r
}

declare target("riscv.ztt.acc.f16", half, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f16_half_16_8t.triscv.ztt.m.f16_half_16_1_8t(target("riscv.ztt.m.f16", half, 16, 1, 8), i32, i32)
define target("riscv.ztt.acc.f16", half, 16, 8) @m2a_f16_1x8_a8_m1(target("riscv.ztt.m.f16", half, 16, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_f16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.f16", half, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f16_half_16_8t.triscv.ztt.m.f16_half_16_1_8t(target("riscv.ztt.m.f16", half, 16, 1, 8) %v, i32 338690320, i32 8)
  ret target("riscv.ztt.acc.f16", half, 16, 8) %r
}

declare target("riscv.ztt.m.f16", half, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f16_half_16_1_8t.triscv.ztt.acc.f16_half_16_8t(target("riscv.ztt.acc.f16", half, 16, 8), i32, i32)
define target("riscv.ztt.m.f16", half, 16, 1, 8) @a2m_f16_1x8_a8_m1(target("riscv.ztt.acc.f16", half, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_f16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f16", half, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f16_half_16_1_8t.triscv.ztt.acc.f16_half_16_8t(target("riscv.ztt.acc.f16", half, 16, 8) %v, i32 338690320, i32 8)
  ret target("riscv.ztt.m.f16", half, 16, 1, 8) %r
}

declare target("riscv.ztt.acc.f16", half, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f16_half_16_8t.triscv.ztt.m.f16_half_16_8_1t(target("riscv.ztt.m.f16", half, 16, 8, 1), i32, i32)
define target("riscv.ztt.acc.f16", half, 16, 8) @m2a_f16_8x1_a8_m1(target("riscv.ztt.m.f16", half, 16, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_f16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.f16", half, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f16_half_16_8t.triscv.ztt.m.f16_half_16_8_1t(target("riscv.ztt.m.f16", half, 16, 8, 1) %v, i32 338690320, i32 8)
  ret target("riscv.ztt.acc.f16", half, 16, 8) %r
}

declare target("riscv.ztt.m.f16", half, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f16_half_16_8_1t.triscv.ztt.acc.f16_half_16_8t(target("riscv.ztt.acc.f16", half, 16, 8), i32, i32)
define target("riscv.ztt.m.f16", half, 16, 8, 1) @a2m_f16_8x1_a8_m1(target("riscv.ztt.acc.f16", half, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_f16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f16", half, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f16_half_16_8_1t.triscv.ztt.acc.f16_half_16_8t(target("riscv.ztt.acc.f16", half, 16, 8) %v, i32 338690320, i32 8)
  ret target("riscv.ztt.m.f16", half, 16, 8, 1) %r
}

declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bfloat_16_8t.triscv.ztt.m.bf16_bfloat_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), i32, i32)
define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @m2a_bf16_1x8_a8_m1(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_bf16_1x8_a8_m1:
; CHECK:       # %bb.0:
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
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bfloat_16_8t.triscv.ztt.m.bf16_bfloat_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %v, i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bfloat_16_1_8t.triscv.ztt.acc.bf16_bfloat_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8), i32, i32)
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @a2m_bf16_1x8_a8_m1(target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_bf16_1x8_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bfloat_16_1_8t.triscv.ztt.acc.bf16_bfloat_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v, i32 540016912, i32 8)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %r
}

declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bfloat_16_8t.triscv.ztt.m.bf16_bfloat_16_8_1t(target("riscv.ztt.m.bf16", bfloat, 16, 8, 1), i32, i32)
define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @m2a_bf16_8x1_a8_m1(target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: m2a_bf16_8x1_a8_m1:
; CHECK:       # %bb.0:
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
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bfloat_16_8t.triscv.ztt.m.bf16_bfloat_16_8_1t(target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) %v, i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bfloat_16_8_1t.triscv.ztt.acc.bf16_bfloat_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8), i32, i32)
define target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @a2m_bf16_8x1_a8_m1(target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: a2m_bf16_8x1_a8_m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bfloat_16_8_1t.triscv.ztt.acc.bf16_bfloat_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8) %v, i32 540016912, i32 8)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) %r
}

;--- datatype/input.ll
; No ABI return copy is needed here: the intrinsic writes a disjoint wide
; square and the store consumes it directly. There must be no metadata read.

define void @copy_store_i32(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: copy_store_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 32
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    ret
  %copy = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %copy, i32 1073741856, i32 1)
  ret void
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)

define void @copy_store_u32(ptr %p, target("riscv.ztt.m.u32", i32, 32, 1, 1) %src) "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: copy_store_u32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    ret
  %copy = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.u32_i32_32_1_1t(target("riscv.ztt.m.u32", i32, 32, 1, 1) %src, i32 32, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.u32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.u32", i32, 32, 1, 1) %copy, i32 32, i32 1)
  ret void
}
declare target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.u32_i32_32_1_1t(target("riscv.ztt.m.u32", i32, 32, 1, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.u32_i32_32_1_1t(ptr, target("riscv.ztt.m.u32", i32, 32, 1, 1), i32, i32)

define void @copy_store_f32(ptr %p, target("riscv.ztt.m.f32", float, 32, 1, 1) %src) "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: copy_store_f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 288
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    ret
  %copy = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1) %src, i32 540016928, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.f32_f32_32_1_1t(ptr %p, target("riscv.ztt.m.f32", float, 32, 1, 1) %copy, i32 540016928, i32 1)
  ret void
}
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.f32_f32_32_1_1t(ptr, target("riscv.ztt.m.f32", float, 32, 1, 1), i32, i32)

;--- invalid/checks.txt
; TYPE: LLVM ERROR: Ztt cross-register mcopy requires one M type and one Acc type
; SQUARE: LLVM ERROR: Ztt cross-register mcopy M and Acc square counts must match

;--- invalid/tmp/m2a-non-m.ll
declare target("riscv.ztt.acc.i32", i32, 32, 1)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.i32(i32, i32, i32)

define target("riscv.ztt.acc.i32", i32, 32, 1) @m2a_non_m(i32 %src) #0 {
  %r = call target("riscv.ztt.acc.i32", i32, 32, 1)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.i32(
      i32 %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }

;--- invalid/tmp/a2m-non-acc.ll
declare target("riscv.ztt.m.i32", i32, 32, 1, 1)
  @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.i32(i32, i32, i32)

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @a2m_non_acc(i32 %src) #0 {
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.i32(
      i32 %src, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %r
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }

;--- invalid/tmp/square-mismatch.ll
declare target("riscv.ztt.acc.i32", i32, 32, 2)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_1t(
    target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)

define target("riscv.ztt.acc.i32", i32, 32, 2)
    @m2a_square_mismatch(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src) #0 {
  %r = call target("riscv.ztt.acc.i32", i32, 32, 2)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_1t(
      target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, i32 1073741856, i32 2)
  ret target("riscv.ztt.acc.i32", i32, 32, 2) %r
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }

;--- packed-machine/input.mir
# Nonzero ACC base, with no group-size alignment: acc3 through acc10.
--- |
  define void @m2a() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @a2m() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: m2a
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm5, $x11
    ; CHECK-LABEL: name: m2a
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm5, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $ztta3 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta4 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta5 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta6 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta7 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta8 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta9 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta10 = ZTT_ASETTYP $x11
    ; CHECK-NEXT: $ztta3 = ZTT_MMOV_A_M $zttm5, implicit-def $ztta4, implicit-def $ztta5, implicit-def $ztta6, implicit-def $ztta7, implicit-def $ztta8, implicit-def $ztta9, implicit-def $ztta10
    ; CHECK-NEXT: PseudoRET
    $ztta3m8 = PseudoZTTMCopyM2A_A8_M1 $zttm5, 1, 8, $x11
    PseudoRET
...
---
name: a2m
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $ztta3m8, $x11
    ; CHECK-LABEL: name: a2m
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $ztta3m8, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm5 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm5 = ZTT_MMOV_M_A $ztta3, implicit $ztta4, implicit $ztta5, implicit $ztta6, implicit $ztta7, implicit $ztta8, implicit $ztta9, implicit $ztta10
    ; CHECK-NEXT: PseudoRET
    $zttm5 = PseudoZTTMCopyA2M_A8_M1 $ztta3m8, 1, 8, $x11
    PseudoRET
...

;--- packed-roundtrip/input.ll
; Migrated from the public C regression; retain its assembly expectations.
; CHECK-LABEL: roundtrip_i16:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    asettyp acc0, a2
; CHECK-NEXT:    asettyp acc1, a2
; CHECK-NEXT:    asettyp acc2, a2
; CHECK-NEXT:    asettyp acc3, a2
; CHECK-NEXT:    asettyp acc4, a2
; CHECK-NEXT:    asettyp acc5, a2
; CHECK-NEXT:    asettyp acc6, a2
; CHECK-NEXT:    asettyp acc7, a2
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    ret
; CHECK-LABEL: roundtrip_bf16:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    lui a2, 131840
; CHECK-NEXT:    addi a2, a2, 272
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    asettyp acc0, a2
; CHECK-NEXT:    asettyp acc1, a2
; CHECK-NEXT:    asettyp acc2, a2
; CHECK-NEXT:    asettyp acc3, a2
; CHECK-NEXT:    asettyp acc4, a2
; CHECK-NEXT:    asettyp acc5, a2
; CHECK-NEXT:    asettyp acc6, a2
; CHECK-NEXT:    asettyp acc7, a2
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    ret


; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @roundtrip_i16(ptr nofree noundef readonly captures(none) %src, ptr nofree noundef writeonly captures(none) %dst) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %src, i32 1073741840, i32 8)
  %1 = tail call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8) %0, i32 1073741840, i32 8)
  %2 = tail call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8) %1, i32 1073741840, i32 8)
  tail call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 8) %2, i32 1073741840, i32 8)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr captures(none), i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr captures(none), target("riscv.ztt.m.i16", i16, 16, 1, 8), i32 immarg, i32 immarg) #3

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @roundtrip_bf16(ptr nofree noundef readonly captures(none) %src, ptr nofree noundef writeonly captures(none) %dst) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bf16_16_8_1t(ptr %src, i32 540016912, i32 8)
  %1 = tail call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_8t.triscv.ztt.m.bf16_bf16_16_8_1t(target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) %0, i32 540016912, i32 8)
  %2 = tail call target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_8_1t.triscv.ztt.acc.bf16_bf16_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8) %1, i32 540016912, i32 8)
  tail call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_8_1t(ptr %dst, target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) %2, i32 540016912, i32 8)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bf16_16_8_1t(ptr captures(none), i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_8t.triscv.ztt.m.bf16_bf16_16_8_1t(target("riscv.ztt.m.bf16", bfloat, 16, 8, 1), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.bf16", bfloat, 16, 8, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_8_1t.triscv.ztt.acc.bf16_bf16_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_8_1t(ptr captures(none), target("riscv.ztt.m.bf16", bfloat, 16, 8, 1), i32 immarg, i32 immarg) #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write) }

;--- uds128/input.ll
declare target("riscv.ztt.m.i128", i128, 128, 1, 1)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i128_i128_128_1_1t(
    target("riscv.ztt.m.i128", i128, 128, 1, 1), i32, i32)
declare target("riscv.ztt.acc.i128", i128, 128, 1)
  @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i128_i128_128_1t.triscv.ztt.m.i128_i128_128_1_1t(
    target("riscv.ztt.m.i128", i128, 128, 1, 1), i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1)
  @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.acc.i128_i128_128_1t(
    target("riscv.ztt.acc.i128", i128, 128, 1), i32, i32)

define target("riscv.ztt.m.i128", i128, 128, 1, 1)
    @mcopy_m2m_i128_uds128(
      target("riscv.ztt.m.i128", i128, 128, 1, 1) %src) #0 {
; CHECK-LABEL: mcopy_m2m_i128_uds128:
; CHECK-NEXT: .cfi_startproc
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i128", i128, 128, 1, 1)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i128_i128_128_1_1t(
      target("riscv.ztt.m.i128", i128, 128, 1, 1) %src,
      i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %v
}

define target("riscv.ztt.acc.i128", i128, 128, 1)
    @mcopy_m2a_i128_uds128(
      target("riscv.ztt.m.i128", i128, 128, 1, 1) %src) #0 {
; CHECK-LABEL: mcopy_m2a_i128_uds128:
; CHECK-NEXT: .cfi_startproc
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    mmov.a.m acc0, m0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.acc.i128", i128, 128, 1)
    @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i128_i128_128_1t.triscv.ztt.m.i128_i128_128_1_1t(
      target("riscv.ztt.m.i128", i128, 128, 1, 1) %src,
      i32 1073741952, i32 1)
  ret target("riscv.ztt.acc.i128", i128, 128, 1) %v
}

define target("riscv.ztt.m.i128", i128, 128, 1, 1)
    @mcopy_a2m_i128_uds128(
      target("riscv.ztt.acc.i128", i128, 128, 1) %src) #0 {
; CHECK-LABEL: mcopy_a2m_i128_uds128:
; CHECK-NEXT: .cfi_startproc
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i128", i128, 128, 1, 1)
    @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.acc.i128_i128_128_1t(
      target("riscv.ztt.acc.i128", i128, 128, 1) %src,
      i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %v
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
