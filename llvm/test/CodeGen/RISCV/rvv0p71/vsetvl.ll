; RUN: llc -mtriple=riscv64 -mattr=+xtheadv < %s | FileCheck -check-prefix=CHECK %s

; https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/v0.7.1/rvv_intrinsic_funcs/01_configuration-setting_and_utility_functions.md

; The spec allowed e128, but intrinsic only support e8, e16, e32, e64
; vtype = ((ediv & 0b11) << 5) | ((sew & 0b111) << 2) | ((lmul & 0b11) << 0)
; -------------------------------------------
; | ASM name | e8  | e16 | e32 | e64 | e128 |
; | SEW      | 0   | 1   | 2   | 3   | 4    |
; | SEW bin  | 000 | 001 | 010 | 011 | 100  |
; -------------------------------------------
; | ASM name | m1 | m2  | m4  | m8  |
; | LMUL     | 0  | 1   | 2   | 3   |
; | LMUL bin | 00 | 01  | 10  | 11  |
; -----------------------------------

declare i64 @llvm.riscv.xvsetvl(i64 %avl, i64 %vtype);

define i64 @intrinsic_xvsetvl_e8m1(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e8m1
; CHECK: vsetvl a0, a0, zero
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 0)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e8m2(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e8m2
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 1)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e8m4(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e8m4
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 2)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e8m8(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e8m8
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 3)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m1(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e16m1
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 4)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m2(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e16m2
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 5)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m4(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e16m4
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 6)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m8(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e16m8
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 7)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m1(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e32m1
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 8)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m2(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e32m2
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 9)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m4(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e32m4
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 10)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m8(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e32m8
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 11)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m1(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e64m1
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 12)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m2(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e64m2
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 13)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m4(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e64m4
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 14)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m8(i64 %avl) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e64m8
; CHECK: vsetvl a0, a0, a1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 15)
  ret i64 %v
}
