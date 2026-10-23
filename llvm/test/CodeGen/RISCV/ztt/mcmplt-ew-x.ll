; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/input.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %t/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/footprint.mir > %t.ztt-profile-0.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-0.mir -o - | FileCheck %t/footprint.mir --check-prefix=MIR
; RUN: sed 's/iXLEN/i64/g' %t/input.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %t/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/footprint.mir > %t.ztt-profile-1.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-1.mir -o - | FileCheck %t/footprint.mir --check-prefix=MIR

; Predicate values are integer all-ones/zero, computed by hardware.
; Scalar is the left comparison operand; amestype describes it, not the result.

;--- input.ll
;
; Scalar width never contributes to packing. Hardware covers
; max(1, UDS/D, UDS/S) squares; destination metadata steps max(1,D/UDS).
; All matrices are defined locally, without relying on a matrix argument ABI.

; standard8: D/S groups 1/1; 1 mcmplt.ew.x operations.
define void @standard8(iXLEN %scalar, ptr %out) #0 {
; CHECK-LABEL: standard8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a3, a2, 8
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    addi a2, a2, 32
; CHECK-NEXT:    csrw amestype, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mcmplt.ew.x m1, a0, m0
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i8_i8_8_1_1t(i32 1073741832, i32 1)
  %dst = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i8_i8_8_1_1t.triscv.ztt.m.i8_i8_8_1_1t.iXLEN(target("riscv.ztt.m.i8", i8, 8, 1, 1) %src, iXLEN %scalar, i32 1073741832, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i8_i8_8_1_1t(ptr %out, target("riscv.ztt.m.i8", i8, 8, 1, 1) %dst, i32 1073741832, i32 1)
  ret void
}

; standard16: D/S groups 1/1; 1 mcmplt.ew.x operations.
define void @standard16(iXLEN %scalar, ptr %out) #1 {
; CHECK-LABEL: standard16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    li a3, 16
; CHECK-NEXT:    csrw amestype, a3
; CHECK-NEXT:    msettyp m1, a2
; CHECK-NEXT:    mcmplt.ew.x m1, a0, m0
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_1t(i32 1073741840, i32 1)
  %dst = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 1) %src, iXLEN %scalar, i32 1073741840, i32 16, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_1t(ptr %out, target("riscv.ztt.m.i16", i16, 16, 1, 1) %dst, i32 1073741840, i32 1)
  ret void
}

; standard32: D/S groups 1/1; 1 mcmplt.ew.x operations.
define void @standard32(iXLEN %scalar, ptr %out) #2 {
; CHECK-LABEL: standard32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a2, a2, 32
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    csrw amestype, a2
; CHECK-NEXT:    msettyp m1, a2
; CHECK-NEXT:    mcmplt.ew.x m1, a0, m0
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32 1073741856, i32 1)
  %dst = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, iXLEN %scalar, i32 1073741856, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %dst, i32 1073741856, i32 1)
  ret void
}

; standard64: D/S groups 1/1; 1 mcmplt.ew.x operations.
define void @standard64(iXLEN %scalar, ptr %out) #3 {
; CHECK-LABEL: standard64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a2, a2, 64
; CHECK-NEXT:    lui a3, 131840
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    addi a3, a3, 288
; CHECK-NEXT:    csrw amestype, a3
; CHECK-NEXT:    msettyp m1, a2
; CHECK-NEXT:    mcmplt.ew.x m1, a0, m0
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i64_i64_64_1_1t(i32 1073741888, i32 1)
  %dst = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t.iXLEN(target("riscv.ztt.m.i64", i64, 64, 1, 1) %src, iXLEN %scalar, i32 1073741888, i32 540016928, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i64_i64_64_1_1t(ptr %out, target("riscv.ztt.m.i64", i64, 64, 1, 1) %dst, i32 1073741888, i32 1)
  ret void
}

; standard128: D/S groups 1/1; 1 mcmplt.ew.x operations.
define void @standard128(iXLEN %scalar, ptr %out) #4 {
; CHECK-LABEL: standard128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a3, a2, 128
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    addi a2, a2, 32
; CHECK-NEXT:    csrw amestype, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mcmplt.ew.x m1, a0, m0
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i128_i128_128_1_1t(i32 1073741952, i32 1)
  %dst = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t.iXLEN(target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, iXLEN %scalar, i32 1073741952, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i128_i128_128_1_1t(ptr %out, target("riscv.ztt.m.i128", i128, 128, 1, 1) %dst, i32 1073741952, i32 1)
  ret void
}

; doc8: D/S groups 4/8; 2 mcmplt.ew.x operations.
define void @doc8(iXLEN %scalar, ptr %out) #5 {
; CHECK-LABEL: doc8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a4, a3, 32
; CHECK-NEXT:    msettyp m0, a4
; CHECK-NEXT:    msettyp m4, a4
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m4
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    csrw amestype, a4
; CHECK-NEXT:    msettyp m8, a3
; CHECK-NEXT:    msettyp m10, a3
; CHECK-NEXT:    mcmplt.ew.x m8, a0, m0
; CHECK-NEXT:    mcmplt.ew.x m10, a0, m4
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    mss.rm m8, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m10, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_2t(i32 1073741856, i32 2)
  %dst = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, iXLEN %scalar, i32 1073741840, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %out, target("riscv.ztt.m.i16", i16, 16, 1, 2) %dst, i32 1073741840, i32 2)
  ret void
}

; doc16: D/S groups 2/4; 2 mcmplt.ew.x operations.
define void @doc16(iXLEN %scalar, ptr %out) #6 {
; CHECK-LABEL: doc16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a4, a3, 32
; CHECK-NEXT:    msettyp m0, a4
; CHECK-NEXT:    msettyp m2, a4
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    csrw amestype, a4
; CHECK-NEXT:    msettyp m4, a3
; CHECK-NEXT:    msettyp m5, a3
; CHECK-NEXT:    mcmplt.ew.x m4, a0, m0
; CHECK-NEXT:    mcmplt.ew.x m5, a0, m2
; CHECK-NEXT:    slli a2, a2, 1
; CHECK-NEXT:    mss.rm m4, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m5, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_2t(i32 1073741856, i32 2)
  %dst = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, iXLEN %scalar, i32 1073741840, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %out, target("riscv.ztt.m.i16", i16, 16, 1, 2) %dst, i32 1073741840, i32 2)
  ret void
}

; doc32: D/S groups 1/2; 1 mcmplt.ew.x operations.
define void @doc32(iXLEN %scalar, ptr %out) #7 {
; CHECK-LABEL: doc32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a3, a2, 32
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    addi a2, a2, 16
; CHECK-NEXT:    csrw amestype, a3
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    mcmplt.ew.x m2, a0, m0
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_2t(i32 1073741856, i32 2)
  %dst = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, iXLEN %scalar, i32 1073741840, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %out, target("riscv.ztt.m.i16", i16, 16, 1, 2) %dst, i32 1073741840, i32 2)
  ret void
}

; packed_source: D/S groups 4/2; 2 mcmplt.ew.x operations.
define void @packed_source(iXLEN %scalar, ptr %out) #8 {
; CHECK-LABEL: packed_source:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a4, a3, 16
; CHECK-NEXT:    msettyp m0, a4
; CHECK-NEXT:    msettyp m1, a4
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    lui a4, 131840
; CHECK-NEXT:    addi a4, a4, 288
; CHECK-NEXT:    addi a3, a3, 32
; CHECK-NEXT:    csrw amestype, a4
; CHECK-NEXT:    msettyp m4, a3
; CHECK-NEXT:    msettyp m5, a3
; CHECK-NEXT:    msettyp m6, a3
; CHECK-NEXT:    msettyp m7, a3
; CHECK-NEXT:    mcmplt.ew.x m4, a0, m0
; CHECK-NEXT:    mcmplt.ew.x m6, a0, m1
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    mss.rm m4, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m5, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m6, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m7, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %dst = call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN %scalar, i32 1073741856, i32 540016928, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_4t(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 4) %dst, i32 1073741856, i32 4)
  ret void
}

; packed_both: D/S groups 2/1; 1 mcmplt.ew.x operations.
define void @packed_both(iXLEN %scalar, ptr %out) #9 {
; CHECK-LABEL: packed_both:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a4, a3, 8
; CHECK-NEXT:    msettyp m0, a4
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    csrw amestype, a4
; CHECK-NEXT:    msettyp m2, a3
; CHECK-NEXT:    msettyp m3, a3
; CHECK-NEXT:    mcmplt.ew.x m2, a0, m0
; CHECK-NEXT:    slli a2, a2, 3
; CHECK-NEXT:    mss.rm m2, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m3, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i8", i8, 8, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i8_i8_8_1_8t(i32 1073741832, i32 8)
  %dst = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i8_i8_8_1_8t.iXLEN(target("riscv.ztt.m.i8", i8, 8, 1, 8) %src, iXLEN %scalar, i32 1073741840, i32 1073741832, i32 8)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %out, target("riscv.ztt.m.i16", i16, 16, 1, 8) %dst, i32 1073741840, i32 8)
  ret void
}

; packed128: D/S groups 2/4; 2 mcmplt.ew.x operations.
define void @packed128(iXLEN %scalar, ptr %out) #10 {
; CHECK-LABEL: packed128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a4, a3, 32
; CHECK-NEXT:    msettyp m0, a4
; CHECK-NEXT:    msettyp m1, a4
; CHECK-NEXT:    msettyp m2, a4
; CHECK-NEXT:    msettyp m3, a4
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    mzero.2d.m m3
; CHECK-NEXT:    addi a3, a3, 16
; CHECK-NEXT:    csrw amestype, a4
; CHECK-NEXT:    msettyp m4, a3
; CHECK-NEXT:    msettyp m5, a3
; CHECK-NEXT:    mcmplt.ew.x m4, a0, m0
; CHECK-NEXT:    mcmplt.ew.x m5, a0, m2
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    mss.rm m4, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m5, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 16) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_16t(i32 1073741856, i32 16)
  %dst = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_16t.triscv.ztt.m.i32_i32_32_1_16t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 16) %src, iXLEN %scalar, i32 1073741840, i32 1073741856, i32 16)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr %out, target("riscv.ztt.m.i16", i16, 16, 1, 16) %dst, i32 1073741840, i32 16)
  ret void
}

; vertical_wide: D/S groups 16/8; 4 mcmplt.ew.x operations.
define void @vertical_wide(iXLEN %scalar, ptr %out) #11 {
; CHECK-LABEL: vertical_wide:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a2, amenlen
; CHECK-NEXT:    mul a2, a2, a2
; CHECK-NEXT:    lui a3, 262144
; CHECK-NEXT:    addi a4, a3, 16
; CHECK-NEXT:    msettyp m0, a4
; CHECK-NEXT:    msettyp m2, a4
; CHECK-NEXT:    msettyp m4, a4
; CHECK-NEXT:    msettyp m6, a4
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    mzero.2d.m m4
; CHECK-NEXT:    mzero.2d.m m6
; CHECK-NEXT:    addi a3, a3, 32
; CHECK-NEXT:    csrw amestype, a3
; CHECK-NEXT:    msettyp m16, a3
; CHECK-NEXT:    msettyp m20, a3
; CHECK-NEXT:    msettyp m24, a3
; CHECK-NEXT:    msettyp m28, a3
; CHECK-NEXT:    mcmplt.ew.x m16, a0, m0
; CHECK-NEXT:    mcmplt.ew.x m20, a0, m2
; CHECK-NEXT:    mcmplt.ew.x m24, a0, m4
; CHECK-NEXT:    mcmplt.ew.x m28, a0, m6
; CHECK-NEXT:    slli a2, a2, 2
; CHECK-NEXT:    mss.rm m16, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m20, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m24, a1
; CHECK-NEXT:    add a1, a1, a2
; CHECK-NEXT:    mss.rm m28, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_4_1t(i32 1073741840, i32 4)
  %dst = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i16_i16_16_4_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 4, 1) %src, iXLEN %scalar, i32 1073741856, i32 1073741856, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_4_1t(ptr %out, target("riscv.ztt.m.i32", i32, 32, 4, 1) %dst, i32 1073741856, i32 4)
  ret void
}

; subbyte_output: D/S groups 1/4; 1 mcmplt.ew.x operations.
define void @subbyte_output(iXLEN %scalar, ptr %out) #12 {
; CHECK-LABEL: subbyte_output:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a2, a1, 16
; CHECK-NEXT:    msettyp m0, a2
; CHECK-NEXT:    msettyp m1, a2
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    msettyp m3, a2
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    mzero.2d.m m1
; CHECK-NEXT:    mzero.2d.m m2
; CHECK-NEXT:    mzero.2d.m m3
; CHECK-NEXT:    addi a2, a1, 32
; CHECK-NEXT:    addi a1, a1, 4
; CHECK-NEXT:    csrw amestype, a2
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    mcmplt.ew.x m4, a0, m0
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  %dst = call target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i4_i4_4_1_8t.triscv.ztt.m.i16_i16_16_1_8t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, iXLEN %scalar, i32 1073741828, i32 1073741856, i32 8)
  ; The amestype write remains observable even when the result is unused.
  ret void
}

declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i8_i8_8_1_1t(i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i8_i8_8_1_1t.triscv.ztt.m.i8_i8_8_1_1t.iXLEN(target("riscv.ztt.m.i8", i8, 8, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i8_i8_8_1_1t(ptr, target("riscv.ztt.m.i8", i8, 8, 1, 1), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_1t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_1t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 1), i32, i32)

declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i64_i64_64_1_1t(i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t.iXLEN(target("riscv.ztt.m.i64", i64, 64, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i64_i64_64_1_1t(ptr, target("riscv.ztt.m.i64", i64, 64, 1, 1), i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i128_i128_128_1_1t(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t.iXLEN(target("riscv.ztt.m.i128", i128, 128, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i128_i128_128_1_1t(ptr, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_2t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 2), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_4t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 4), i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i8_i8_8_1_8t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i8_i8_8_1_8t.iXLEN(target("riscv.ztt.m.i8", i8, 8, 1, 8), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 8), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 16) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_16t(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i16_i16_16_1_16t.triscv.ztt.m.i32_i32_32_1_16t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 16), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_16t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_4_1t(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i16_i16_16_4_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 4, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_4_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 4, 1), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32, i32)
declare target("riscv.ztt.m.i4", i4, 4, 1, 8) @llvm.riscv.ztt.mcmplt.ew.x.triscv.ztt.m.i4_i4_4_1_8t.triscv.ztt.m.i16_i16_16_1_8t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 8), iXLEN, i32, i32, i32)


attributes #0 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #2 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #3 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #4 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #5 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #6 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #7 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #8 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #9 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #10 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #11 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #12 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @float_sources_0(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %a, iXLEN %scalar) #100 {
; CHECK-LABEL: float_sources_0:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    addi a2, a2, 32
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    msettyp m3, a2
; CHECK-NEXT:    mcmplt.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.float0(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %a, iXLEN %scalar, i32 1073741856, i32 540016912, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}
attributes #100 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }

define target("riscv.ztt.m.u32", i32, 32, 1, 1) @float_sources_1(target("riscv.ztt.m.f32", float, 32, 1, 1) %a, iXLEN %scalar) #101 {
; CHECK-LABEL: float_sources_1:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    mcmplt.ew.x m2, a0, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.float1(target("riscv.ztt.m.f32", float, 32, 1, 1) %a, iXLEN %scalar, i32 32, i32 540016912, i32 1)
  ret target("riscv.ztt.m.u32", i32, 32, 1, 1) %r
}
attributes #101 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @float_sources_2(target("riscv.ztt.m.f64", double, 64, 1, 2) %a, iXLEN %scalar) #102 {
; CHECK-LABEL: float_sources_2:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    addi a2, a2, 64
; CHECK-NEXT:    csrw amestype, a1
; CHECK-NEXT:    msettyp m2, a2
; CHECK-NEXT:    msettyp m3, a2
; CHECK-NEXT:    mcmplt.ew.x m2, a0, m0
; CHECK-NEXT:    mcmplt.ew.x m3, a0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.float2(target("riscv.ztt.m.f64", double, 64, 1, 2) %a, iXLEN %scalar, i32 1073741888, i32 540016912, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}
attributes #102 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }

declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.float0(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mcmplt.ew.x.float1(target("riscv.ztt.m.f32", float, 32, 1, 1), iXLEN, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mcmplt.ew.x.float2(target("riscv.ztt.m.f64", double, 64, 1, 2), iXLEN, i32 immarg, i32 immarg, i32 immarg)

;--- footprint.mir
--- |
  define void @packed_to_wide() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @wide_to_standard() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: packed_to_wide
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0, $x10, $x11, $x12
    ; MIR-LABEL: name: packed_to_wide
    ; MIR: bb.0:
    ; MIR-NEXT: liveins: $zttm0, $x10, $x11, $x12
    ; MIR-NEXT: {{  $}}
    ; MIR-NEXT: $x0 = CSRRW 2064, $x12
    ; MIR-NEXT: $zttm4 = ZTT_MSETTYP $x11, implicit-def $zttm5
    ; MIR-NEXT: $zttm6 = ZTT_MSETTYP $x11, implicit-def $zttm7
    ; MIR-NEXT: $zttm4 = ZTT_MCMPLT_EW_X $x10, $zttm0, implicit $zttm4, implicit $zttm5, implicit-def $zttm5, implicit $zttm6, implicit-def $zttm6, implicit $zttm7, implicit-def $zttm7
    ; MIR-NEXT: PseudoRET implicit $zttm4m4
    early-clobber $zttm4m4 = PseudoZTTMcmpltEwX_G004_G101 killed $zttm0, $x10, $x11, $x12, 1, 2
    PseudoRET implicit $zttm4m4
...
---
name: wide_to_standard
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m4, $x10, $x11, $x12
    ; MIR-LABEL: name: wide_to_standard
    ; MIR: bb.0:
    ; MIR-NEXT: liveins: $zttm0m4, $x10, $x11, $x12
    ; MIR-NEXT: {{  $}}
    ; MIR-NEXT: $x0 = CSRRW 2064, $x12
    ; MIR-NEXT: $zttm4 = ZTT_MSETTYP $x11
    ; MIR-NEXT: $zttm5 = ZTT_MSETTYP $x11
    ; MIR-NEXT: $zttm4 = ZTT_MCMPLT_EW_X $x10, $zttm0, implicit $zttm4, implicit $zttm1
    ; MIR-NEXT: $zttm5 = ZTT_MCMPLT_EW_X $x10, $zttm2, implicit $zttm5, implicit $zttm3
    ; MIR-NEXT: PseudoRET implicit $zttm4m2
    early-clobber $zttm4m2 = PseudoZTTMcmpltEwX_G002_G104 killed $zttm0m4, $x10, $x11, $x12, 2, 1
    PseudoRET implicit $zttm4m2
...
