; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/input.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s --check-prefix=RV32
; RUN: sed 's/iXLEN/i64/g' %t/input.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s --check-prefix=RV64

; Slice order and byte offsets follow the intrinsic contract, including
; zero/odd strides; no software exception or overlap emulation is expected.
;--- input.ll


; i16 1x1, UDS=8.
; RV32-LABEL: i16_1x1_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x1_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x1_uds8(ptr %base, iXLEN %stride) #0 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.i16_1x1(i32 1073741840, i32 1)
  call void @llvm.riscv.ztt.mss.st.case0(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 1) %src, i32 1073741840, i32 1)
  ret void
}

; i16 1x2, UDS=8.
; RV32-LABEL: i16_1x2_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    slli	a3, a3, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x2_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    slli	a3, a3, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x2_uds8(ptr %base, iXLEN %stride) #1 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.i16_1x2(i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.st.case1(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 2) %src, i32 1073741840, i32 2)
  ret void
}

; i16 2x1, UDS=8.
; RV32-LABEL: i16_2x1_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    slli	a3, a3, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_2x1_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    slli	a3, a3, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    ret

define void @i16_2x1_uds8(ptr %base, iXLEN %stride) #2 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mzero.m.i16_2x1(i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.st.case2(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 2, 1) %src, i32 1073741840, i32 2)
  ret void
}

; f32 1x1, UDS=8.
; RV32-LABEL: f32_1x1_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x1_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x1_uds8(ptr %base, iXLEN %stride) #3 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.f32_1x1(i32 540016928, i32 1)
  call void @llvm.riscv.ztt.mss.st.case3(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 1) %src, i32 540016928, i32 1)
  ret void
}

; f32 1x2, UDS=8.
; RV32-LABEL: f32_1x2_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m4, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m4, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x2_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m4, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m4, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x2_uds8(ptr %base, iXLEN %stride) #4 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mzero.m.f32_1x2(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case4(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016928, i32 2)
  ret void
}

; f32 2x1, UDS=8.
; RV32-LABEL: f32_2x1_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m4, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m4, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_2x1_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m4, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m4, (a0), a1
; RV64-NEXT:    ret

define void @f32_2x1_uds8(ptr %base, iXLEN %stride) #5 {
  %src = call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mzero.m.f32_2x1(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case5(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 2, 1) %src, i32 540016928, i32 2)
  ret void
}

; i128 1x1, UDS=8.
; RV32-LABEL: i128_1x1_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x1_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x1_uds8(ptr %base, iXLEN %stride) #6 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  call void @llvm.riscv.ztt.mss.st.case6(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, i32 1073741952, i32 1)
  ret void
}

; i128 1x2, UDS=8.
; RV32-LABEL: i128_1x2_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m16, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m16
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m16, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x2_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m16, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m16
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m16, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x2_uds8(ptr %base, iXLEN %stride) #7 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mzero.m.i128_1x2(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case7(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 2) %src, i32 1073741952, i32 2)
  ret void
}

; i128 2x1, UDS=8.
; RV32-LABEL: i128_2x1_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m16, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m16
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m16, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_2x1_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m16, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m16
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m16, (a0), a1
; RV64-NEXT:    ret

define void @i128_2x1_uds8(ptr %base, iXLEN %stride) #8 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mzero.m.i128_2x1(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case8(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 2, 1) %src, i32 1073741952, i32 2)
  ret void
}

; i16 1x1, UDS=16.
; RV32-LABEL: i16_1x1_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x1_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x1_uds16(ptr %base, iXLEN %stride) #9 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.i16_1x1(i32 1073741840, i32 1)
  call void @llvm.riscv.ztt.mss.st.case9(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 1) %src, i32 1073741840, i32 1)
  ret void
}

; i16 1x2, UDS=16.
; RV32-LABEL: i16_1x2_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x2_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x2_uds16(ptr %base, iXLEN %stride) #10 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.i16_1x2(i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.st.case10(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 2) %src, i32 1073741840, i32 2)
  ret void
}

; i16 2x1, UDS=16.
; RV32-LABEL: i16_2x1_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_2x1_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_2x1_uds16(ptr %base, iXLEN %stride) #11 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mzero.m.i16_2x1(i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.st.case11(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 2, 1) %src, i32 1073741840, i32 2)
  ret void
}

; f32 1x1, UDS=16.
; RV32-LABEL: f32_1x1_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x1_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x1_uds16(ptr %base, iXLEN %stride) #12 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.f32_1x1(i32 540016928, i32 1)
  call void @llvm.riscv.ztt.mss.st.case12(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 1) %src, i32 540016928, i32 1)
  ret void
}

; f32 1x2, UDS=16.
; RV32-LABEL: f32_1x2_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x2_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x2_uds16(ptr %base, iXLEN %stride) #13 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mzero.m.f32_1x2(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case13(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016928, i32 2)
  ret void
}

; f32 2x1, UDS=16.
; RV32-LABEL: f32_2x1_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_2x1_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    ret

define void @f32_2x1_uds16(ptr %base, iXLEN %stride) #14 {
  %src = call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mzero.m.f32_2x1(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case14(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 2, 1) %src, i32 540016928, i32 2)
  ret void
}

; i128 1x1, UDS=16.
; RV32-LABEL: i128_1x1_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x1_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x1_uds16(ptr %base, iXLEN %stride) #15 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  call void @llvm.riscv.ztt.mss.st.case15(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, i32 1073741952, i32 1)
  ret void
}

; i128 1x2, UDS=16.
; RV32-LABEL: i128_1x2_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m8, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m8
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m8, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x2_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m8, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m8
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m8, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x2_uds16(ptr %base, iXLEN %stride) #16 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mzero.m.i128_1x2(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case16(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 2) %src, i32 1073741952, i32 2)
  ret void
}

; i128 2x1, UDS=16.
; RV32-LABEL: i128_2x1_uds16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m8, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m8
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m8, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_2x1_uds16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m8, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m8
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m8, (a0), a1
; RV64-NEXT:    ret

define void @i128_2x1_uds16(ptr %base, iXLEN %stride) #17 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mzero.m.i128_2x1(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case17(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 2, 1) %src, i32 1073741952, i32 2)
  ret void
}

; i16 1x2, UDS=32.
; RV32-LABEL: i16_1x2_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x2_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x2_uds32(ptr %base, iXLEN %stride) #18 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.i16_1x2(i32 1073741840, i32 2)
  call void @llvm.riscv.ztt.mss.st.case18(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 2) %src, i32 1073741840, i32 2)
  ret void
}

; i16 1x4, UDS=32.
; RV32-LABEL: i16_1x4_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds32(ptr %base, iXLEN %stride) #19 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case19(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 4x1, UDS=32.
; RV32-LABEL: i16_4x1_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_4x1_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_4x1_uds32(ptr %base, iXLEN %stride) #20 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.i16_4x1(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case20(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 4, 1) %src, i32 1073741840, i32 4)
  ret void
}

; f32 1x1, UDS=32.
; RV32-LABEL: f32_1x1_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x1_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x1_uds32(ptr %base, iXLEN %stride) #21 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.f32_1x1(i32 540016928, i32 1)
  call void @llvm.riscv.ztt.mss.st.case21(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 1) %src, i32 540016928, i32 1)
  ret void
}

; f32 1x2, UDS=32.
; RV32-LABEL: f32_1x2_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x2_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x2_uds32(ptr %base, iXLEN %stride) #22 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mzero.m.f32_1x2(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case22(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016928, i32 2)
  ret void
}

; f32 2x1, UDS=32.
; RV32-LABEL: f32_2x1_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_2x1_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @f32_2x1_uds32(ptr %base, iXLEN %stride) #23 {
  %src = call target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mzero.m.f32_2x1(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case23(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 2, 1) %src, i32 540016928, i32 2)
  ret void
}

; i128 1x1, UDS=32.
; RV32-LABEL: i128_1x1_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x1_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x1_uds32(ptr %base, iXLEN %stride) #24 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  call void @llvm.riscv.ztt.mss.st.case24(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, i32 1073741952, i32 1)
  ret void
}

; i128 1x2, UDS=32.
; RV32-LABEL: i128_1x2_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m4, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m4, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x2_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m4, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m4, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x2_uds32(ptr %base, iXLEN %stride) #25 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mzero.m.i128_1x2(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case25(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 2) %src, i32 1073741952, i32 2)
  ret void
}

; i128 2x1, UDS=32.
; RV32-LABEL: i128_2x1_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m4, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m4, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_2x1_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m4, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m4, (a0), a1
; RV64-NEXT:    ret

define void @i128_2x1_uds32(ptr %base, iXLEN %stride) #26 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mzero.m.i128_2x1(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case26(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 2, 1) %src, i32 1073741952, i32 2)
  ret void
}

; i16 1x4, UDS=64.
; RV32-LABEL: i16_1x4_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds64(ptr %base, iXLEN %stride) #27 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case27(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x8, UDS=64.
; RV32-LABEL: i16_1x8_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 3
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x8_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 3
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x8_uds64(ptr %base, iXLEN %stride) #28 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.i16_1x8(i32 1073741840, i32 8)
  call void @llvm.riscv.ztt.mss.st.case28(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, i32 1073741840, i32 8)
  ret void
}

; i16 8x1, UDS=64.
; RV32-LABEL: i16_8x1_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 3
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_8x1_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 3
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_8x1_uds64(ptr %base, iXLEN %stride) #29 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mzero.m.i16_8x1(i32 1073741840, i32 8)
  call void @llvm.riscv.ztt.mss.st.case29(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 8, 1) %src, i32 1073741840, i32 8)
  ret void
}

; f32 1x2, UDS=64.
; RV32-LABEL: f32_1x2_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x2_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x2_uds64(ptr %base, iXLEN %stride) #30 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mzero.m.f32_1x2(i32 540016928, i32 2)
  call void @llvm.riscv.ztt.mss.st.case30(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 2) %src, i32 540016928, i32 2)
  ret void
}

; f32 1x4, UDS=64.
; RV32-LABEL: f32_1x4_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 3
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x4_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 3
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x4_uds64(ptr %base, iXLEN %stride) #31 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mzero.m.f32_1x4(i32 540016928, i32 4)
  call void @llvm.riscv.ztt.mss.st.case31(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 4) %src, i32 540016928, i32 4)
  ret void
}

; f32 4x1, UDS=64.
; RV32-LABEL: f32_4x1_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 3
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_4x1_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 3
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @f32_4x1_uds64(ptr %base, iXLEN %stride) #32 {
  %src = call target("riscv.ztt.m.f32", float, 32, 4, 1) @llvm.riscv.ztt.mzero.m.f32_4x1(i32 540016928, i32 4)
  call void @llvm.riscv.ztt.mss.st.case32(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 4, 1) %src, i32 540016928, i32 4)
  ret void
}

; i128 1x1, UDS=64.
; RV32-LABEL: i128_1x1_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x1_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x1_uds64(ptr %base, iXLEN %stride) #33 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  call void @llvm.riscv.ztt.mss.st.case33(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, i32 1073741952, i32 1)
  ret void
}

; i128 1x2, UDS=64.
; RV32-LABEL: i128_1x2_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x2_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x2_uds64(ptr %base, iXLEN %stride) #34 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mzero.m.i128_1x2(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case34(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 2) %src, i32 1073741952, i32 2)
  ret void
}

; i128 2x1, UDS=64.
; RV32-LABEL: i128_2x1_uds64:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_2x1_uds64:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    ret

define void @i128_2x1_uds64(ptr %base, iXLEN %stride) #35 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mzero.m.i128_2x1(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case35(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 2, 1) %src, i32 1073741952, i32 2)
  ret void
}

; i16 1x8, UDS=128.
; RV32-LABEL: i16_1x8_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x8_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x8_uds128(ptr %base, iXLEN %stride) #36 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.i16_1x8(i32 1073741840, i32 8)
  call void @llvm.riscv.ztt.mss.st.case36(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, i32 1073741840, i32 8)
  ret void
}

; i16 1x16, UDS=128.
; RV32-LABEL: i16_1x16_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x16_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x16_uds128(ptr %base, iXLEN %stride) #37 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.i16_1x16(i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.st.case37(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 16) %src, i32 1073741840, i32 16)
  ret void
}

; i16 16x1, UDS=128.
; RV32-LABEL: i16_16x1_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_16x1_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_16x1_uds128(ptr %base, iXLEN %stride) #38 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mzero.m.i16_16x1(i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.st.case38(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 16, 1) %src, i32 1073741840, i32 16)
  ret void
}

; f32 1x4, UDS=128.
; RV32-LABEL: f32_1x4_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x4_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x4_uds128(ptr %base, iXLEN %stride) #39 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mzero.m.f32_1x4(i32 540016928, i32 4)
  call void @llvm.riscv.ztt.mss.st.case39(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 4) %src, i32 540016928, i32 4)
  ret void
}

; f32 1x8, UDS=128.
; RV32-LABEL: f32_1x8_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_1x8_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @f32_1x8_uds128(ptr %base, iXLEN %stride) #40 {
  %src = call target("riscv.ztt.m.f32", float, 32, 1, 8) @llvm.riscv.ztt.mzero.m.f32_1x8(i32 540016928, i32 8)
  call void @llvm.riscv.ztt.mss.st.case40(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 1, 8) %src, i32 540016928, i32 8)
  ret void
}

; f32 8x1, UDS=128.
; RV32-LABEL: f32_8x1_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 131840
; RV32-NEXT:    addi	a2, a2, 288
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: f32_8x1_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 131840
; RV64-NEXT:    addi	a2, a2, 288
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @f32_8x1_uds128(ptr %base, iXLEN %stride) #41 {
  %src = call target("riscv.ztt.m.f32", float, 32, 8, 1) @llvm.riscv.ztt.mzero.m.f32_8x1(i32 540016928, i32 8)
  call void @llvm.riscv.ztt.mss.st.case41(ptr %base, iXLEN %stride, target("riscv.ztt.m.f32", float, 32, 8, 1) %src, i32 540016928, i32 8)
  ret void
}

; i128 1x1, UDS=128.
; RV32-LABEL: i128_1x1_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x1_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x1_uds128(ptr %base, iXLEN %stride) #42 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32 1073741952, i32 1)
  call void @llvm.riscv.ztt.mss.st.case42(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 1) %src, i32 1073741952, i32 1)
  ret void
}

; i128 1x2, UDS=128.
; RV32-LABEL: i128_1x2_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_1x2_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i128_1x2_uds128(ptr %base, iXLEN %stride) #43 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mzero.m.i128_1x2(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case43(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 1, 2) %src, i32 1073741952, i32 2)
  ret void
}

; i128 2x1, UDS=128.
; RV32-LABEL: i128_2x1_uds128:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 128
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 4
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i128_2x1_uds128:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 128
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 4
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i128_2x1_uds128(ptr %base, iXLEN %stride) #44 {
  %src = call target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mzero.m.i128_2x1(i32 1073741952, i32 2)
  call void @llvm.riscv.ztt.mss.st.case44(ptr %base, iXLEN %stride, target("riscv.ztt.m.i128", i128, 128, 2, 1) %src, i32 1073741952, i32 2)
  ret void
}

; i16 1x4, UDS=8.
; RV32-LABEL: i16_1x4_uds8_stride0:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m2, a1
; RV32-NEXT:    msettyp	m4, a1
; RV32-NEXT:    msettyp	m6, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    mzero.2d.m	m6
; RV32-NEXT:    slli	a2, a2, 1
; RV32-NEXT:    mss.st	m0, (a0), zero
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m2, (a0), zero
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m4, (a0), zero
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m6, (a0), zero
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds8_stride0:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m2, a1
; RV64-NEXT:    msettyp	m4, a1
; RV64-NEXT:    msettyp	m6, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    mzero.2d.m	m6
; RV64-NEXT:    slli	a2, a2, 1
; RV64-NEXT:    mss.st	m0, (a0), zero
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m2, (a0), zero
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m4, (a0), zero
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m6, (a0), zero
; RV64-NEXT:    ret

define void @i16_1x4_uds8_stride0(ptr %base, iXLEN %stride) #45 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case45(ptr %base, iXLEN 0, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x4, UDS=32.
; RV32-LABEL: i16_1x4_uds32_stride0:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a2, a2, 2
; RV32-NEXT:    mss.st	m0, (a0), zero
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), zero
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds32_stride0:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a2, a2, 2
; RV64-NEXT:    mss.st	m0, (a0), zero
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), zero
; RV64-NEXT:    ret

define void @i16_1x4_uds32_stride0(ptr %base, iXLEN %stride) #46 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case46(ptr %base, iXLEN 0, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x16, UDS=128.
; RV32-LABEL: i16_1x16_uds128_stride0:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a2, a2, 4
; RV32-NEXT:    mss.st	m0, (a0), zero
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), zero
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x16_uds128_stride0:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a2, a2, 4
; RV64-NEXT:    mss.st	m0, (a0), zero
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), zero
; RV64-NEXT:    ret

define void @i16_1x16_uds128_stride0(ptr %base, iXLEN %stride) #47 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.i16_1x16(i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.st.case47(ptr %base, iXLEN 0, target("riscv.ztt.m.i16", i16, 16, 1, 16) %src, i32 1073741840, i32 16)
  ret void
}

; i16 1x4, UDS=8.
; RV32-LABEL: i16_1x4_uds8_stride1:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m2, a1
; RV32-NEXT:    msettyp	m4, a1
; RV32-NEXT:    msettyp	m6, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    mzero.2d.m	m6
; RV32-NEXT:    slli	a2, a2, 1
; RV32-NEXT:    li	a1, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m4, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m6, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds8_stride1:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m2, a1
; RV64-NEXT:    msettyp	m4, a1
; RV64-NEXT:    msettyp	m6, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    mzero.2d.m	m6
; RV64-NEXT:    slli	a2, a2, 1
; RV64-NEXT:    li	a1, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m4, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m6, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds8_stride1(ptr %base, iXLEN %stride) #48 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case48(ptr %base, iXLEN 1, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x4, UDS=32.
; RV32-LABEL: i16_1x4_uds32_stride1:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a2, a2, 2
; RV32-NEXT:    li	a1, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds32_stride1:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a2, a2, 2
; RV64-NEXT:    li	a1, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds32_stride1(ptr %base, iXLEN %stride) #49 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case49(ptr %base, iXLEN 1, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x16, UDS=128.
; RV32-LABEL: i16_1x16_uds128_stride1:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a2, a2, 4
; RV32-NEXT:    li	a1, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x16_uds128_stride1:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a2, a2, 4
; RV64-NEXT:    li	a1, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x16_uds128_stride1(ptr %base, iXLEN %stride) #50 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.i16_1x16(i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.st.case50(ptr %base, iXLEN 1, target("riscv.ztt.m.i16", i16, 16, 1, 16) %src, i32 1073741840, i32 16)
  ret void
}

; i16 1x4, UDS=8.
; RV32-LABEL: i16_1x4_uds8_stride16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m2, a1
; RV32-NEXT:    msettyp	m4, a1
; RV32-NEXT:    msettyp	m6, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    mzero.2d.m	m4
; RV32-NEXT:    mzero.2d.m	m6
; RV32-NEXT:    slli	a2, a2, 1
; RV32-NEXT:    li	a1, 16
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m4, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m6, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds8_stride16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m2, a1
; RV64-NEXT:    msettyp	m4, a1
; RV64-NEXT:    msettyp	m6, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    mzero.2d.m	m4
; RV64-NEXT:    mzero.2d.m	m6
; RV64-NEXT:    slli	a2, a2, 1
; RV64-NEXT:    li	a1, 16
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m4, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m6, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds8_stride16(ptr %base, iXLEN %stride) #51 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case51(ptr %base, iXLEN 16, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x4, UDS=32.
; RV32-LABEL: i16_1x4_uds32_stride16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a2, a2, 2
; RV32-NEXT:    li	a1, 16
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds32_stride16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a2, a2, 2
; RV64-NEXT:    li	a1, 16
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds32_stride16(ptr %base, iXLEN %stride) #52 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case52(ptr %base, iXLEN 16, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x16, UDS=128.
; RV32-LABEL: i16_1x16_uds128_stride16:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a2, a2, 4
; RV32-NEXT:    li	a1, 16
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x16_uds128_stride16:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a2, a2, 4
; RV64-NEXT:    li	a1, 16
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x16_uds128_stride16(ptr %base, iXLEN %stride) #53 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.i16_1x16(i32 1073741840, i32 16)
  call void @llvm.riscv.ztt.mss.st.case53(ptr %base, iXLEN 16, target("riscv.ztt.m.i16", i16, 16, 1, 16) %src, i32 1073741840, i32 16)
  ret void
}

; i16 1x4, UDS=16.
; RV32-LABEL: i16_1x4_uds16_shared_base_stride:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a1, 262144
; RV32-NEXT:    addi	a1, a1, 16
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    msettyp	m0, a1
; RV32-NEXT:    msettyp	m1, a1
; RV32-NEXT:    msettyp	m2, a1
; RV32-NEXT:    msettyp	m3, a1
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    mzero.2d.m	m3
; RV32-NEXT:    slli	a2, a2, 1
; RV32-NEXT:    mv	a1, a0
; RV32-NEXT:    mss.st	m0, (a1), a0
; RV32-NEXT:    add	a1, a1, a2
; RV32-NEXT:    mss.st	m1, (a1), a0
; RV32-NEXT:    add	a1, a1, a2
; RV32-NEXT:    mss.st	m2, (a1), a0
; RV32-NEXT:    add	a1, a1, a2
; RV32-NEXT:    mss.st	m3, (a1), a0
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds16_shared_base_stride:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a1, 262144
; RV64-NEXT:    addi	a1, a1, 16
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    msettyp	m0, a1
; RV64-NEXT:    msettyp	m1, a1
; RV64-NEXT:    msettyp	m2, a1
; RV64-NEXT:    msettyp	m3, a1
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    mzero.2d.m	m3
; RV64-NEXT:    slli	a2, a2, 1
; RV64-NEXT:    mv	a1, a0
; RV64-NEXT:    mss.st	m0, (a1), a0
; RV64-NEXT:    add	a1, a1, a2
; RV64-NEXT:    mss.st	m1, (a1), a0
; RV64-NEXT:    add	a1, a1, a2
; RV64-NEXT:    mss.st	m2, (a1), a0
; RV64-NEXT:    add	a1, a1, a2
; RV64-NEXT:    mss.st	m3, (a1), a0
; RV64-NEXT:    ret

define void @i16_1x4_uds16_shared_base_stride(iXLEN %stride) #54 {
  %base = inttoptr iXLEN %stride to ptr
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case54(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

; i16 1x4, UDS=16.
; RV32-LABEL: i16_1x4_uds16_keep_base:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    msettyp	m3, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    mzero.2d.m	m3
; RV32-NEXT:    slli	a3, a3, 1
; RV32-NEXT:    mv	a2, a0
; RV32-NEXT:    mss.st	m0, (a2), a1
; RV32-NEXT:    add	a2, a2, a3
; RV32-NEXT:    mss.st	m1, (a2), a1
; RV32-NEXT:    add	a2, a2, a3
; RV32-NEXT:    mss.st	m2, (a2), a1
; RV32-NEXT:    add	a2, a2, a3
; RV32-NEXT:    mss.st	m3, (a2), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds16_keep_base:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    msettyp	m3, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    mzero.2d.m	m3
; RV64-NEXT:    slli	a3, a3, 1
; RV64-NEXT:    mv	a2, a0
; RV64-NEXT:    mss.st	m0, (a2), a1
; RV64-NEXT:    add	a2, a2, a3
; RV64-NEXT:    mss.st	m1, (a2), a1
; RV64-NEXT:    add	a2, a2, a3
; RV64-NEXT:    mss.st	m2, (a2), a1
; RV64-NEXT:    add	a2, a2, a3
; RV64-NEXT:    mss.st	m3, (a2), a1
; RV64-NEXT:    ret

define ptr @i16_1x4_uds16_keep_base(ptr %base, iXLEN %stride) #55 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case55(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret ptr %base
}

; i16 1x4, UDS=16.
; RV32-LABEL: i16_1x4_uds16_nom:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 16
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    msettyp	m2, a2
; RV32-NEXT:    msettyp	m3, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    mzero.2d.m	m2
; RV32-NEXT:    mzero.2d.m	m3
; RV32-NEXT:    slli	a3, a3, 1
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m2, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m3, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i16_1x4_uds16_nom:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 16
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    msettyp	m2, a2
; RV64-NEXT:    msettyp	m3, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    mzero.2d.m	m2
; RV64-NEXT:    mzero.2d.m	m3
; RV64-NEXT:    slli	a3, a3, 1
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m2, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m3, (a0), a1
; RV64-NEXT:    ret

define void @i16_1x4_uds16_nom(ptr %base, iXLEN %stride) #56 {
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.st.case56(ptr %base, iXLEN %stride, target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, i32 1073741840, i32 4)
  ret void
}

declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mzero.m.f32_1x1(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mzero.m.f32_1x2(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 4) @llvm.riscv.ztt.mzero.m.f32_1x4(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 8) @llvm.riscv.ztt.mzero.m.f32_1x8(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 2, 1) @llvm.riscv.ztt.mzero.m.f32_2x1(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 4, 1) @llvm.riscv.ztt.mzero.m.f32_4x1(i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 8, 1) @llvm.riscv.ztt.mzero.m.f32_8x1(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.i128_1x1(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mzero.m.i128_1x2(i32, i32)
declare target("riscv.ztt.m.i128", i128, 128, 2, 1) @llvm.riscv.ztt.mzero.m.i128_2x1(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mzero.m.i16_1x1(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.i16_1x16(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.i16_1x2(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.i16_1x4(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.i16_1x8(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 16, 1) @llvm.riscv.ztt.mzero.m.i16_16x1(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mzero.m.i16_2x1(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.i16_4x1(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 8, 1) @llvm.riscv.ztt.mzero.m.i16_8x1(i32, i32)
declare void @llvm.riscv.ztt.mss.st.case0(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case1(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case10(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case11(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case12(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case13(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case14(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case15(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case16(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case17(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case18(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case19(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case2(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case20(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 4, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case21(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case22(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case23(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case24(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case25(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case26(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case27(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case28(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 8), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case29(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 8, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case3(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case30(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case31(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case32(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 4, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case33(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case34(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case35(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case36(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 8), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case37(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case38(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 16, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case39(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case4(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case40(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 1, 8), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case41(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 8, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case42(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case43(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case44(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case45(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case46(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case47(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case48(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case49(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case5(ptr, iXLEN, target("riscv.ztt.m.f32", float, 32, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case50(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case51(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case52(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case53(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 16), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case54(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case55(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case56(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case6(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case7(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case8(ptr, iXLEN, target("riscv.ztt.m.i128", i128, 128, 2, 1), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st.case9(ptr, iXLEN, target("riscv.ztt.m.i16", i16, 16, 1, 1), i32 immarg, i32 immarg)
attributes #0 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #12 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #13 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #14 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #15 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #16 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #17 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #18 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #19 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #20 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #21 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #22 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #23 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #24 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #25 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #26 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #27 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #28 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #29 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #30 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #31 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #32 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #33 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #34 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #35 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #36 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #37 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #38 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #39 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #40 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #41 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #42 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #43 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #44 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #45 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #46 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #47 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #48 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #49 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #50 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #51 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #52 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #53 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #54 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #55 = { nounwind "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #56 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }

; u8 1x2, UDS=8.
; RV32-LABEL: u8_1x2_uds8:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    li	a2, 8
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    csrr	a2, amenlen
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a2
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: u8_1x2_uds8:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    li	a2, 8
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    csrr	a2, amenlen
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a2
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @u8_1x2_uds8(ptr %base, iXLEN %stride) #57 {
  %src = call target("riscv.ztt.m.u8", i8, 8, 1, 2) @llvm.riscv.ztt.mzero.m.byte57(i32 8, i32 2)
  call void @llvm.riscv.ztt.mss.st.byte57(ptr %base, iXLEN %stride, target("riscv.ztt.m.u8", i8, 8, 1, 2) %src, i32 8, i32 2)
  ret void
}
declare void @llvm.riscv.ztt.mss.st.byte57(ptr, iXLEN, target("riscv.ztt.m.u8", i8, 8, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u8", i8, 8, 1, 2) @llvm.riscv.ztt.mzero.m.byte57(i32 immarg, i32 immarg)
attributes #57 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }

; i8 8x1, UDS=32.
; RV32-LABEL: i8_8x1_uds32:
; RV32-NEXT:    # %bb.0:
; RV32-NEXT:    lui	a2, 262144
; RV32-NEXT:    addi	a2, a2, 8
; RV32-NEXT:    csrr	a3, amenlen
; RV32-NEXT:    msettyp	m0, a2
; RV32-NEXT:    msettyp	m1, a2
; RV32-NEXT:    mzero.2d.m	m0
; RV32-NEXT:    mzero.2d.m	m1
; RV32-NEXT:    slli	a3, a3, 2
; RV32-NEXT:    mss.st	m0, (a0), a1
; RV32-NEXT:    add	a0, a0, a3
; RV32-NEXT:    mss.st	m1, (a0), a1
; RV32-NEXT:    ret
; RV64-LABEL: i8_8x1_uds32:
; RV64-NEXT:    # %bb.0:
; RV64-NEXT:    lui	a2, 262144
; RV64-NEXT:    addi	a2, a2, 8
; RV64-NEXT:    csrr	a3, amenlen
; RV64-NEXT:    msettyp	m0, a2
; RV64-NEXT:    msettyp	m1, a2
; RV64-NEXT:    mzero.2d.m	m0
; RV64-NEXT:    mzero.2d.m	m1
; RV64-NEXT:    slli	a3, a3, 2
; RV64-NEXT:    mss.st	m0, (a0), a1
; RV64-NEXT:    add	a0, a0, a3
; RV64-NEXT:    mss.st	m1, (a0), a1
; RV64-NEXT:    ret

define void @i8_8x1_uds32(ptr %base, iXLEN %stride) #58 {
  %src = call target("riscv.ztt.m.i8", i8, 8, 8, 1) @llvm.riscv.ztt.mzero.m.byte58(i32 1073741832, i32 8)
  call void @llvm.riscv.ztt.mss.st.byte58(ptr %base, iXLEN %stride, target("riscv.ztt.m.i8", i8, 8, 8, 1) %src, i32 1073741832, i32 8)
  ret void
}
declare void @llvm.riscv.ztt.mss.st.byte58(ptr, iXLEN, target("riscv.ztt.m.i8", i8, 8, 8, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 8, 1) @llvm.riscv.ztt.mzero.m.byte58(i32 immarg, i32 immarg)
attributes #58 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
