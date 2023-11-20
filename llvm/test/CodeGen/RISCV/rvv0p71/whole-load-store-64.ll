; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 1 x i64> @llvm.riscv.xvadd.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  iXLen);

define void @vadd_vint64m1(<vscale x 1 x i64> *%pc, <vscale x 1 x i64> *%pa, <vscale x 1 x i64> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint64m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m1, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m1, d1
; CHECK-NEXT:    vle.v	v9, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e64, m1, d1
; CHECK-NEXT:    vadd.vv v8, v8, v9

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m1, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 1 x i64>, <vscale x 1 x i64>* %pa
  %vb = load <vscale x 1 x i64>, <vscale x 1 x i64>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 1 x i64> %va, %vb
  %vc = call <vscale x 1 x i64> @llvm.riscv.xvadd.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64> %va,
    <vscale x 1 x i64> %vb,
    iXLen %vl)
  store <vscale x 1 x i64> %vc, <vscale x 1 x i64> *%pc
  ret void
}
