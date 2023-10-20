; RUN: llc -mtriple=riscv64 -mattr=+xtheadv < %s | FileCheck -check-prefix=CHECK %s

; https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/v0.7.1/rvv_intrinsic_funcs/01_configuration-setting_and_utility_functions.md

; The spec allowed e128, but intrinsic only support e8, e16, e32, e64
; vtype = ((ediv & 0b11) << 5) | ((sew & 0b111) << 2) | ((lmul & 0b11) << 0)
; -------------------------------------------
; | ASM name | e8  | e16 | e32 | e64 | e128 |
; | SEW      | 0   | 1   | 2   | 3   | 4    |
; -------------------------------------------
; | ASM name | m1 | m2  | m4  | m8  |
; | LMUL     | 0  | 1   | 2   | 3   |
; -----------------------------------
; In intrinsic, ediv is always 0 for ASM name `d1`

declare i64 @llvm.riscv.xvsetvl   (i64 %avl, i64 %sew, i64 %lmul);
declare i64 @llvm.riscv.xvsetvlmax(          i64 %sew, i64 %lmul);


define i64 @intrinsic_xvsetvl_e8m1(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e8m1
; CHECK: vsetvli a0, a0, e8, m1, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 0, i64 0)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e8m2(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e8m2
; CHECK: vsetvli a0, a0, e8, m2, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 0, i64 1)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e8m4(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e8m4
; CHECK: vsetvli a0, a0, e8, m4, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 0, i64 2)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e8m8(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e8m8
; CHECK: vsetvli a0, a0, e8, m8, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 0, i64 3)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m1(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e16m1
; CHECK: vsetvli a0, a0, e16, m1, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 1, i64 0)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m2(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e16m2
; CHECK: vsetvli a0, a0, e16, m2, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 1, i64 1)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m4(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e16m4
; CHECK: vsetvli a0, a0, e16, m4, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 1, i64 2)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e16m8(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e16m8
; CHECK: vsetvli a0, a0, e16, m8, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 1, i64 3)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m1(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e32m1
; CHECK: vsetvli a0, a0, e32, m1, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 2, i64 0)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m2(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e32m2
; CHECK: vsetvli a0, a0, e32, m2, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 2, i64 1)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m4(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e32m4
; CHECK: vsetvli a0, a0, e32, m4, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 2, i64 2)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e32m8(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e32m8
; CHECK: vsetvli a0, a0, e32, m8, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 2, i64 3)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m1(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e64m1
; CHECK: vsetvli a0, a0, e64, m1, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 3, i64 0)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m2(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e64m2
; CHECK: vsetvli a0, a0, e64, m2, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 3, i64 1)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m4(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e64m4
; CHECK: vsetvli a0, a0, e64, m4, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 3, i64 2)
  ret i64 %v
}


define i64 @intrinsic_xvsetvl_e64m8(i64 %avl) {
; CHECK-LABEL: intrinsic_xvsetvl_e64m8
; CHECK: vsetvli a0, a0, e64, m8, d1
  %v = call i64 @llvm.riscv.xvsetvl(i64 %avl, i64 3, i64 3)
  ret i64 %v
}
