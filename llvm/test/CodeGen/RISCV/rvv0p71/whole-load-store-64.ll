; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvector \
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

declare <vscale x 2 x i64> @llvm.riscv.xvadd.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>,
  <vscale x 2 x i64>,
  iXLen);

define void @vadd_vint32m2(<vscale x 2 x i64> *%pc, <vscale x 2 x i64> *%pa, <vscale x 2 x i64> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint32m2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m2, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m2, d1
; CHECK-NEXT:    vle.v	v10, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e64, m2, d1
; CHECK-NEXT:    vadd.vv v8, v8, v10

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m2, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 2 x i64>, <vscale x 2 x i64>* %pa
  %vb = load <vscale x 2 x i64>, <vscale x 2 x i64>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 2 x i64> %va, %vb
  %vc = call <vscale x 2 x i64> @llvm.riscv.xvadd.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64> %va,
    <vscale x 2 x i64> %vb,
    iXLen %vl)
  store <vscale x 2 x i64> %vc, <vscale x 2 x i64> *%pc
  ret void
}

declare <vscale x 4 x i64> @llvm.riscv.xvadd.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>,
  <vscale x 4 x i64>,
  iXLen);

define void @vadd_vint32m4(<vscale x 4 x i64> *%pc, <vscale x 4 x i64> *%pa, <vscale x 4 x i64> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint32m4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m4, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m4, d1
; CHECK-NEXT:    vle.v	v12, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e64, m4, d1
; CHECK-NEXT:    vadd.vv v8, v8, v12

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m4, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 4 x i64>, <vscale x 4 x i64>* %pa
  %vb = load <vscale x 4 x i64>, <vscale x 4 x i64>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 4 x i64> %va, %vb
  %vc = call <vscale x 4 x i64> @llvm.riscv.xvadd.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64> %va,
    <vscale x 4 x i64> %vb,
    iXLen %vl)
  store <vscale x 4 x i64> %vc, <vscale x 4 x i64> *%pc
  ret void
}

declare <vscale x 8 x i64> @llvm.riscv.xvadd.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>,
  <vscale x 8 x i64>,
  iXLen);

define void @vadd_vint32m8(<vscale x 8 x i64> *%pc, <vscale x 8 x i64> *%pa, <vscale x 8 x i64> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint32m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m8, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m8, d1
; CHECK-NEXT:    vle.v	v16, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e64, m8, d1
; CHECK-NEXT:    vadd.vv v8, v8, v16

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e64, m8, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 8 x i64>, <vscale x 8 x i64>* %pa
  %vb = load <vscale x 8 x i64>, <vscale x 8 x i64>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 8 x i64> %va, %vb
  %vc = call <vscale x 8 x i64> @llvm.riscv.xvadd.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64> %va,
    <vscale x 8 x i64> %vb,
    iXLen %vl)
  store <vscale x 8 x i64> %vc, <vscale x 8 x i64> *%pc
  ret void
}
