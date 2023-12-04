; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s

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

declare iXLen @llvm.riscv.th.vsetvl.iXLen   (iXLen %avl, iXLen %sew, iXLen %lmul);
declare iXLen @llvm.riscv.th.vsetvlmax.iXLen(            iXLen %sew, iXLen %lmul);


define iXLen @intrinsic_xvsetvlmax_e8m1() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e8m1
; CHECK: vsetvli a0, zero, e8, m1, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 0, iXLen 0)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e8m2() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e8m2
; CHECK: vsetvli a0, zero, e8, m2, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 0, iXLen 1)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e8m4() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e8m4
; CHECK: vsetvli a0, zero, e8, m4, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 0, iXLen 2)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e8m8() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e8m8
; CHECK: vsetvli a0, zero, e8, m8, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 0, iXLen 3)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e16m1() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e16m1
; CHECK: vsetvli a0, zero, e16, m1, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 1, iXLen 0)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e16m2() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e16m2
; CHECK: vsetvli a0, zero, e16, m2, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 1, iXLen 1)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e16m4() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e16m4
; CHECK: vsetvli a0, zero, e16, m4, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 1, iXLen 2)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e16m8() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e16m8
; CHECK: vsetvli a0, zero, e16, m8, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 1, iXLen 3)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e32m1() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e32m1
; CHECK: vsetvli a0, zero, e32, m1, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 2, iXLen 0)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e32m2() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e32m2
; CHECK: vsetvli a0, zero, e32, m2, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 2, iXLen 1)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e32m4() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e32m4
; CHECK: vsetvli a0, zero, e32, m4, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 2, iXLen 2)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e32m8() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e32m8
; CHECK: vsetvli a0, zero, e32, m8, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 2, iXLen 3)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e64m1() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e64m1
; CHECK: vsetvli a0, zero, e64, m1, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 3, iXLen 0)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e64m2() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e64m2
; CHECK: vsetvli a0, zero, e64, m2, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 3, iXLen 1)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e64m4() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e64m4
; CHECK: vsetvli a0, zero, e64, m4, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 3, iXLen 2)
  ret iXLen %v
}


define iXLen @intrinsic_xvsetvlmax_e64m8() {
entry:
; CHECK-LABEL: intrinsic_xvsetvlmax_e64m8
; CHECK: vsetvli a0, zero, e64, m8, d1
  %v = call iXLen @llvm.riscv.th.vsetvlmax.iXLen(iXLen 3, iXLen 3)
  ret iXLen %v
}
