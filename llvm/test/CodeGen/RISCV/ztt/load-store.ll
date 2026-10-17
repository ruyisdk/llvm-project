; RUN: split-file %s %t
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %t/matrix/input.ll | FileCheck %t/matrix/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %t/matrix/input.ll | FileCheck %t/matrix/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs -stop-after=greedy < %t/matrix/input.ll    | FileCheck %t/matrix/input.ll --check-prefix=MIR
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/invalid/tmp/load-i4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/invalid/tmp/load-i4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/invalid/tmp/load-u4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/invalid/tmp/load-u4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/invalid/tmp/store-i4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/invalid/tmp/store-i4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/invalid/tmp/store-u4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/invalid/tmp/store-u4.ll -o /dev/null 2>&1 | FileCheck %t/invalid/checks.txt
; RUN: llc -mtriple=riscv32 -verify-machineinstrs %t/packed-roundtrip/input.ll -o - | FileCheck %t/packed-roundtrip/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs %t/packed-roundtrip/input.ll -o - | FileCheck %t/packed-roundtrip/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs %t/uds128/input.ll -o - | FileCheck %t/uds128/input.ll

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- matrix/input.ll
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 1, 8), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_32t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 1, 32), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 8)
  @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i32_i32_32_1_8t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i32_i32_32_1_1t(
  ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr, i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 4)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_4t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_1_4t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i32_i32_32_1_4t(
  ptr, target("riscv.ztt.m.i32", i32, 32, 1, 4), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i32_i32_32_1_8t(
  ptr, target("riscv.ztt.m.i32", i32, 32, 1, 8), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_4_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_4_1t(
  ptr, target("riscv.ztt.m.i16", i16, 16, 4, 1), i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i8_i8_8_1_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i64_i64_64_1_1t(
  ptr, target("riscv.ztt.m.i64", i64, 64, 1, 1), i32, i32)

; Basic single-square cases.
define target("riscv.ztt.m.i16", i16, 16, 1, 1)
    @load_standard_i16_1x1_uds16(ptr %p) #0 {
; MIR-LABEL: name: load_standard_i16_1x1_uds16
; MIR: PseudoZTTMLoadRMM1 {{.*}} :: (load unknown-size{{.*}}, align 2)
; CHECK-LABEL: load_standard_i16_1x1_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_1t(
      ptr %p, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %v
}

define void @store_standard_i32_1x1_uds32(
    ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %v) #2 {
; MIR-LABEL: name: store_standard_i32_1x1_uds32
; MIR: PseudoZTTMStoreCMM1 {{.*}} :: (store unknown-size{{.*}}, align 4)
; CHECK-LABEL: store_standard_i32_1x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i32_i32_32_1_1t(
    ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %v,
    i32 1073741856, i32 1)
  ret void
}

; The MachineMemOperand uses the element's natural byte alignment, including
; the minimum and larger scalar element widths.
define target("riscv.ztt.m.i8", i8, 8, 1, 1)
    @load_standard_i8_1x1_uds8(ptr %p) #1 {
; MIR-LABEL: name: load_standard_i8_1x1_uds8
; MIR: PseudoZTTMLoadRMM1 {{.*}} :: (load unknown-size{{.*}}, align 1)
; CHECK-LABEL: load_standard_i8_1x1_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 8
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i8", i8, 8, 1, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i8_i8_8_1_1t(
      ptr %p, i32 1073741832, i32 1)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 1) %v
}

define void @store_standard_i64_1x1_uds64(
    ptr %p, target("riscv.ztt.m.i64", i64, 64, 1, 1) %v) #3 {
; MIR-LABEL: name: store_standard_i64_1x1_uds64
; MIR: PseudoZTTMStoreCMM1 {{.*}} :: (store unknown-size{{.*}}, align 8)
; CHECK-LABEL: store_standard_i64_1x1_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i64_i64_64_1_1t(
    ptr %p, target("riscv.ztt.m.i64", i64, 64, 1, 1) %v,
    i32 1073741888, i32 1)
  ret void
}

; A single wide i16 square occupies an aligned M2 group with UDS=8, even
; though it still lowers to one architectural load instruction.
define target("riscv.ztt.m.i16", i16, 16, 1, 1)
    @load_wide_i16_1x1_uds8(ptr %p) #1 {
; MIR-LABEL: name: load_wide_i16_1x1_uds8
; MIR: %{{[0-9]+}}:zttmrm2, {{.*}}%{{[0-9]+}}:gpr = PseudoZTTMLoadRMM2
; CHECK-LABEL: load_wide_i16_1x1_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_1t(
      ptr %p, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %v
}

; Concatenated shapes and larger register groups.
define void @store_m4(ptr %p,
; CHECK-LABEL: store_m4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m1, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m3, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 4) %v) #0 {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 4) %v,
    i32 1073741840, i32 4)
  ret void
}

define void @store_m8(ptr %p,
; CHECK-LABEL: store_m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m1, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m3, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m5, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m6, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m7, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 8) %v) #0 {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 8) %v,
    i32 1073741840, i32 8)
  ret void
}

define void @store_m16(ptr %p,
; CHECK-LABEL: store_m16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m1, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m3, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m5, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m6, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m7, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m8, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m9, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m10, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m11, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m12, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m13, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m14, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m15, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 16) %v) #0 {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 16) %v,
    i32 1073741840, i32 16)
  ret void
}

define void @store_m32(ptr %p,
; CHECK-LABEL: store_m32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m1, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m3, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m5, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m6, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m7, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m8, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m9, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m10, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m11, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m12, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m13, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m14, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m15, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m16, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m17, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m18, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m19, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m20, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m21, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m22, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m23, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m24, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m25, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m26, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m27, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m28, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m29, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m30, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m31, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 32) %v) #0 {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_32t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 32) %v,
    i32 1073741840, i32 32)
  ret void
}

; With UDS=8, one i32 square occupies four M registers.  The eight loads
; therefore start at m0, m4, ..., m28 rather than at consecutive registers.
define target("riscv.ztt.m.i32", i32, 32, 1, 8) @load_wide_units(ptr %p) #1 {
; CHECK-LABEL: load_wide_units:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    addi a2, a2, 32
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m4, a2
; CHECK-NEXT:    mls.cm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m8, a2
; CHECK-NEXT:    mls.cm m8, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m12, a2
; CHECK-NEXT:    mls.cm m12, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m16, a2
; CHECK-NEXT:    mls.cm m16, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m20, a2
; CHECK-NEXT:    mls.cm m20, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m24, a2
; CHECK-NEXT:    mls.cm m24, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m28, a2
; CHECK-NEXT:    mls.cm m28, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i32", i32, 32, 1, 8)
    @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i32_i32_32_1_8t(
      ptr %p, i32 1073741856, i32 8)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 8) %v
}

; Four wide i16 squares use four M2 units at m0, m2, m4, and m6.
define target("riscv.ztt.m.i16", i16, 16, 1, 4)
    @load_wide_i16_1x4_uds8(ptr %p) #1 {
; MIR-LABEL: name: load_wide_i16_1x4_uds8
; MIR: %{{[0-9]+}}:zttmrm8, {{.*}}%{{[0-9]+}}:gpr = PseudoZTTMLoadRMM8
; CHECK-LABEL: load_wide_i16_1x4_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    mls.rm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m4, a2
; CHECK-NEXT:    mls.rm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m6, a2
; CHECK-NEXT:    mls.rm m6, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 4)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(
      ptr %p, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %v
}

define void @store_wide_i16_1x4_uds8(ptr %p,
; CHECK-LABEL: store_wide_i16_1x4_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 1
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m6, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 4) %v) #1 {
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_1_4t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 4) %v,
    i32 1073741840, i32 4)
  ret void
}

; i32 is also wide for UDS=16, so consecutive squares start two registers
; apart rather than at m0, m1, m2, m3.
define target("riscv.ztt.m.i32", i32, 32, 1, 4)
    @load_wide_i32_1x4_uds16(ptr %p) #0 {
; CHECK-LABEL: load_wide_i32_1x4_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    addi a2, a2, 32
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    mls.rm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m4, a2
; CHECK-NEXT:    mls.rm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m6, a2
; CHECK-NEXT:    mls.rm m6, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i32", i32, 32, 1, 4)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_4t(
      ptr %p, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 4) %v
}

define void @store_wide_i32_1x4_uds16(ptr %p,
; CHECK-LABEL: store_wide_i32_1x4_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m2, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m6, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i32", i32, 32, 1, 4) %v) #0 {
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i32_i32_32_1_4t(
    ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 4) %v,
    i32 1073741856, i32 4)
  ret void
}

; Store-side coverage for four-register-wide i32 units with UDS=8.
define void @store_wide_i32_1x8_uds8(ptr %p,
; CHECK-LABEL: store_wide_i32_1x8_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m4, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m8, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m12, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m16, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m20, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m24, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m28, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i32", i32, 32, 1, 8) %v) #1 {
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i32_i32_32_1_8t(
    ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 8) %v,
    i32 1073741856, i32 8)
  ret void
}

; Keep group lowering coverage across all three relationships between logical
; element width and UDS: packed (< UDS), standard (= UDS), and wide (> UDS).
; UDS32 holds two i16 squares per instruction. Cover one packed register
; (1x2) and two packed registers (1x4), whose address stride is 4 * N * N.
define target("riscv.ztt.m.i16", i16, 16, 1, 2)
    @load_packed_i16_1x2_uds32(ptr %p) #2 {
; CHECK-LABEL: load_packed_i16_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(
      ptr %p, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %v
}

define void @store_packed_i16_1x2_uds32(ptr %p,
; CHECK-LABEL: store_packed_i16_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 2) %v) #2 {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 2) %v,
    i32 1073741840, i32 2)
  ret void
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4)
    @load_packed_i16_1x4_uds32(ptr %p) #2 {
; CHECK-LABEL: load_packed_i16_1x4_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m1, a2
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 4)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(
      ptr %p, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %v
}

define void @store_packed_i16_1x4_uds32(ptr %p,
; CHECK-LABEL: store_packed_i16_1x4_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    mss.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.rm m1, a0
; CHECK-NEXT:    ret
    target("riscv.ztt.m.i16", i16, 16, 1, 4) %v) #2 {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 4) %v,
    i32 1073741840, i32 4)
  ret void
}

; Row and column concatenation shapes with the same square count have the same
; physical register and address progression.  Keep a Kx1 case to ensure the
; target type's row/column fields do not accidentally alter that mapping.
define target("riscv.ztt.m.i16", i16, 16, 4, 1)
    @load_packed_i16_4x1_uds32(ptr %p) #2 {
; CHECK-LABEL: load_packed_i16_4x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    msettyp m1, a2
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 4, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_4_1t(
      ptr %p, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %v
}

define void @store_packed_i16_4x1_uds32(ptr %p,
    target("riscv.ztt.m.i16", i16, 16, 4, 1) %v) #2 {
; CHECK-LABEL: store_packed_i16_4x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, amenlen
; CHECK-NEXT:    mul a1, a1, a1
; CHECK-NEXT:    slli a1, a1, 2
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    add a0, a0, a1
; CHECK-NEXT:    mss.cm m1, a0
; CHECK-NEXT:    ret
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_4_1t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 4, 1) %v,
    i32 1073741840, i32 4)
  ret void
}

; UDS=64 packs all four i16 squares into one physical M register, so there is
; no inter-square address increment and a load needs exactly one msettyp.
define target("riscv.ztt.m.i16", i16, 16, 4, 1)
    @load_packed_i16_4x1_uds64(ptr %p) #3 {
; CHECK-LABEL: load_packed_i16_4x1_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 4, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_4_1t(
      ptr %p, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %v
}

define void @store_packed_i16_4x1_uds64(ptr %p,
    target("riscv.ztt.m.i16", i16, 16, 4, 1) %v) #3 {
; CHECK-LABEL: store_packed_i16_4x1_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_4_1t(
    ptr %p, target("riscv.ztt.m.i16", i16, 16, 4, 1) %v,
    i32 1073741840, i32 4)
  ret void
}

declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i16_i16_16_2_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_2_1t(ptr, target("riscv.ztt.m.i16", i16, 16, 2, 1), i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i8_i8_8_1_8t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i8_i8_8_1_8t(ptr, target("riscv.ztt.m.i8", i8, 8, 1, 8), i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 8, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i8_i8_8_8_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i8_i8_8_8_1t(ptr, target("riscv.ztt.m.i8", i8, 8, 8, 1), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bfloat_16_1_4t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.bf16_bfloat_16_1_4t(ptr, target("riscv.ztt.m.bf16", bfloat, 16, 1, 4), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bfloat_16_4_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bfloat_16_4_1t(ptr, target("riscv.ztt.m.bf16", bfloat, 16, 4, 1), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i16_i16_16_16_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_16_1t(ptr, target("riscv.ztt.m.i16", i16, 16, 16, 1), i32, i32)

; Local load/store pipelines avoid matrix arguments and return values.
; Expected instruction counts and byte strides follow the design, not the ABI:
; UDS8/i16: 2 registers per instruction, 2*N*N bytes;
; UDS16/i16: 1 square per instruction, 2*N*N bytes;
; UDS16/i8: 2 squares per instruction, 2*N*N bytes;
; UDS32/bf16: 2 squares per instruction, 4*N*N bytes;
; UDS64/i16: 4 squares per instruction, 8*N*N bytes;
; UDS128/i16: 8 squares per instruction, 16*N*N bytes.
; Four-instruction cases check every increment, not just the first one.
; For each configuration, exercise both RM/1xK and CM/Kx1.

define void @roundtrip_rm_i16_1x2_uds8(ptr %src, ptr %dst) #1 {
; CHECK-LABEL: roundtrip_rm_i16_1x2_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.rm m2, a0
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %src, i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 2) %v, i32 1073741840, i32 2)
  ret void
}

define void @roundtrip_cm_i16_2x1_uds8(ptr %src, ptr %dst) #1 {
; CHECK-LABEL: roundtrip_cm_i16_2x1_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.cm m2, a0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m2, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i16_i16_16_2_1t(ptr %src, i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_2_1t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 2, 1) %v, i32 1073741840, i32 2)
  ret void
}

define void @roundtrip_rm_i16_1x2_uds16(ptr %src, ptr %dst) #0 {
; CHECK-LABEL: roundtrip_rm_i16_1x2_uds16:
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
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %src, i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 2) %v, i32 1073741840, i32 2)
  ret void
}

define void @roundtrip_cm_i16_2x1_uds16(ptr %src, ptr %dst) #0 {
; CHECK-LABEL: roundtrip_cm_i16_2x1_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.cm m1, a0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m1, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i16_i16_16_2_1t(ptr %src, i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_2_1t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 2, 1) %v, i32 1073741840, i32 2)
  ret void
}

define void @roundtrip_rm_i8_1x8_uds16(ptr %src, ptr %dst) #0 {
; CHECK-LABEL: roundtrip_rm_i8_1x8_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 8
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
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m3, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i8", i8, 8, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i8_i8_8_1_8t(ptr %src, i32 1073741832, i32 8)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i8_i8_8_1_8t(ptr %dst, target("riscv.ztt.m.i8", i8, 8, 1, 8) %v, i32 1073741832, i32 8)
  ret void
}

define void @roundtrip_cm_i8_8x1_uds16(ptr %src, ptr %dst) #0 {
; CHECK-LABEL: roundtrip_cm_i8_8x1_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    addi a3, a3, 8
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.cm m1, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.cm m2, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mls.cm m3, a0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m1, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m3, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i8", i8, 8, 8, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i8_i8_8_8_1t(ptr %src, i32 1073741832, i32 8)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i8_i8_8_8_1t(ptr %dst, target("riscv.ztt.m.i8", i8, 8, 8, 1) %v, i32 1073741832, i32 8)
  ret void
}

define void @roundtrip_rm_bf16_1x4_uds32(ptr %src, ptr %dst) #2 {
; CHECK-LABEL: roundtrip_rm_bf16_1x4_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 131840
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    addi a3, a3, 272
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bfloat_16_1_4t(ptr %src, i32 540016912, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.bf16_bfloat_16_1_4t(ptr %dst, target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) %v, i32 540016912, i32 4)
  ret void
}

define void @roundtrip_cm_bf16_4x1_uds32(ptr %src, ptr %dst) #2 {
; CHECK-LABEL: roundtrip_cm_bf16_4x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 131840
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    addi a3, a3, 272
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.cm m1, a0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m1, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bfloat_16_4_1t(ptr %src, i32 540016912, i32 4)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bfloat_16_4_1t(ptr %dst, target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %v, i32 540016912, i32 4)
  ret void
}

define void @roundtrip_rm_i16_1x16_uds64(ptr %src, ptr %dst) #3 {
; CHECK-LABEL: roundtrip_rm_i16_1x16_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 3
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
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m3, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr %src, i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 16) %v, i32 1073741840, i32 16)
  ret void
}

define void @roundtrip_cm_i16_16x1_uds64(ptr %src, ptr %dst) #3 {
; CHECK-LABEL: roundtrip_cm_i16_16x1_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 3
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.cm m1, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mls.cm m2, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mls.cm m3, a0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m1, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m3, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i16_i16_16_16_1t(ptr %src, i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_16_1t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 16, 1) %v, i32 1073741840, i32 16)
  ret void
}

define void @roundtrip_rm_i16_1x16_uds128(ptr %src, ptr %dst) #4 {
; CHECK-LABEL: roundtrip_rm_i16_1x16_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    mss.rm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr %src, i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 16) %v, i32 1073741840, i32 16)
  ret void
}

define void @roundtrip_cm_i16_16x1_uds128(ptr %src, ptr %dst) #4 {
; CHECK-LABEL: roundtrip_cm_i16_16x1_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.cm m1, a0
; CHECK-NEXT:    mss.cm m0, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m1, a1
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.i16_i16_16_16_1t(ptr %src, i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_16_1t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 16, 1) %v, i32 1073741840, i32 16)
  ret void
}

attributes #0 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #1 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #3 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }

attributes #4 = { "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }

;--- invalid/checks.txt
; CHECK: LLVM ERROR: Ztt load/store requires an element width of at least 8 bits

;--- invalid/tmp/load-i4.ll
declare target("riscv.ztt.m.i4", i4, 4, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i4_i4_4_1_4t(ptr, i32, i32)
define target("riscv.ztt.m.i4", i4, 4, 1, 4) @test(ptr %p) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
  %v = call target("riscv.ztt.m.i4", i4, 4, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i4_i4_4_1_4t(ptr %p, i32 1073741828, i32 4)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 4) %v
}

;--- invalid/tmp/load-u4.ll
declare target("riscv.ztt.m.u4", i4, 4, 1, 4) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.u4_i4_4_1_4t(ptr, i32, i32)
define target("riscv.ztt.m.u4", i4, 4, 1, 4) @test(ptr %p) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
  %v = call target("riscv.ztt.m.u4", i4, 4, 1, 4) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.u4_i4_4_1_4t(ptr %p, i32 4, i32 4)
  ret target("riscv.ztt.m.u4", i4, 4, 1, 4) %v
}

;--- invalid/tmp/store-i4.ll
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i4_i4_4_1_4t(ptr, target("riscv.ztt.m.i4", i4, 4, 1, 4), i32, i32)
define void @test(ptr %p, target("riscv.ztt.m.i4", i4, 4, 1, 4) %v) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i4_i4_4_1_4t(ptr %p, target("riscv.ztt.m.i4", i4, 4, 1, 4) %v, i32 1073741828, i32 4)
  ret void
}

;--- invalid/tmp/store-u4.ll
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.u4_i4_4_1_4t(ptr, target("riscv.ztt.m.u4", i4, 4, 1, 4), i32, i32)
define void @test(ptr %p, target("riscv.ztt.m.u4", i4, 4, 1, 4) %v) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.u4_i4_4_1_4t(ptr %p, target("riscv.ztt.m.u4", i4, 4, 1, 4) %v, i32 4, i32 4)
  ret void
}

;--- packed-roundtrip/input.ll
; Migrated from the public C regression; retain its assembly expectations.
; CHECK-LABEL: packed_rm_i16:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.rm m1, a0
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m3, a1
; CHECK-NEXT:    ret
; CHECK-LABEL: packed_cm_bf16:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 131840
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    addi a3, a3, 272
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    add a0, a0, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mls.cm m1, a0
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mss.cm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m3, a1
; CHECK-NEXT:    ret
; CHECK-LABEL: concat_i16:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mmov.m.m m3, m0
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m3, a1
; CHECK-NEXT:    ret
; CHECK-LABEL: concat_bf16:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 131840
; CHECK-NEXT:    addi a3, a3, 272
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mls.cm m0, a0
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mmov.m.m m3, m0
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    mss.cm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.cm m3, a1
; CHECK-NEXT:    ret


; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @packed_rm_i16(ptr nofree noundef readonly captures(none) %src, ptr nofree noundef writeonly captures(none) %dst) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %src, i32 1073741840, i32 4)
  %1 = tail call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_4t(target("riscv.ztt.m.i16", i16, 16, 1, 4) %0, i32 1073741840, i32 4)
  tail call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 4) %1, i32 1073741840, i32 4)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr captures(none), i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_4t(target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr captures(none), target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg) #3

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @packed_cm_bf16(ptr nofree noundef readonly captures(none) %src, ptr nofree noundef writeonly captures(none) %dst) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bf16_16_4_1t(ptr %src, i32 540016912, i32 4)
  %1 = tail call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_4_1t(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %0, i32 540016912, i32 4)
  tail call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_4_1t(ptr %dst, target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %1, i32 540016912, i32 4)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bf16_16_4_1t(ptr captures(none), i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_4_1t(target("riscv.ztt.m.bf16", bfloat, 16, 4, 1), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_4_1t(ptr captures(none), target("riscv.ztt.m.bf16", bfloat, 16, 4, 1), i32 immarg, i32 immarg) #3

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @concat_i16(ptr nofree noundef readonly captures(none) %src, ptr nofree noundef writeonly captures(none) %dst) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %src, i32 1073741840, i32 2)
  %1 = tail call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %0, target("riscv.ztt.m.i16", i16, 16, 1, 2) %0, i32 1073741840, i32 2)
  tail call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %dst, target("riscv.ztt.m.i16", i16, 16, 1, 4) %1, i32 1073741840, i32 4)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr captures(none), i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite)
define dso_local void @concat_bf16(ptr nofree noundef readonly captures(none) %src, ptr nofree noundef writeonly captures(none) %dst) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bf16_16_2_1t(ptr %src, i32 540016912, i32 2)
  %1 = tail call target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bf16_16_4_1t.triscv.ztt.m.bf16_bf16_16_2_1t(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %0, target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) %0, i32 540016912, i32 2)
  tail call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_4_1t(ptr %dst, target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) %1, i32 540016912, i32 4)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare target("riscv.ztt.m.bf16", bfloat, 16, 2, 1) @llvm.riscv.ztt.mls.cm.triscv.ztt.m.bf16_bf16_16_2_1t(ptr captures(none), i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.bf16", bfloat, 16, 4, 1) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bf16_16_4_1t.triscv.ztt.m.bf16_bf16_16_2_1t(target("riscv.ztt.m.bf16", bfloat, 16, 2, 1), target("riscv.ztt.m.bf16", bfloat, 16, 2, 1), i32 immarg, i32 immarg) #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: readwrite) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write) }

;--- uds128/input.ll
declare target("riscv.ztt.m.i128", i128, 128, 1, 1)
  @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i128_i128_128_1_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i128_i128_128_1_1t(
  ptr, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32, i32)

define target("riscv.ztt.m.i128", i128, 128, 1, 1)
    @load_i128_uds128(ptr %p) #0 {
; CHECK-LABEL: load_i128_uds128:
; CHECK-NEXT: .cfi_startproc
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 128
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i128", i128, 128, 1, 1)
    @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i128_i128_128_1_1t(
      ptr %p, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %v
}

define void @store_i128_uds128(
    ptr %p, target("riscv.ztt.m.i128", i128, 128, 1, 1) %v) #0 {
; CHECK-LABEL: store_i128_uds128:
; CHECK-NEXT: .cfi_startproc
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i128_i128_128_1_1t(
    ptr %p, target("riscv.ztt.m.i128", i128, 128, 1, 1) %v,
    i32 1073741952, i32 1)
  ret void
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
