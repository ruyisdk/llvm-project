; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 4 x i16> @llvm.riscv.xvadd.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define void @vadd_vint16m1(<vscale x 4 x i16> *%pc, <vscale x 4 x i16> *%pa, <vscale x 4 x i16> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint16m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m1, d1
; CHECK-NEXT:    th.vle.v	v8, (a1)
; CHECK-NEXT:    th.vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m1, d1
; CHECK-NEXT:    th.vle.v	v9, (a2)
; CHECK-NEXT:    th.vsetvl	zero, a1, a4

; CHECK-NEXT:    th.vsetvli zero, a3, e16, m1, d1
; CHECK-NEXT:    th.vadd.vv v8, v8, v9

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m1, d1
; CHECK-NEXT:    th.vse.v	v8, (a0)
; CHECK-NEXT:    th.vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 4 x i16>, <vscale x 4 x i16>* %pa
  %vb = load <vscale x 4 x i16>, <vscale x 4 x i16>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 4 x i16> %va, %vb
  %vc = call <vscale x 4 x i16> @llvm.riscv.xvadd.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16> %va,
    <vscale x 4 x i16> %vb,
    iXLen %vl)
  store <vscale x 4 x i16> %vc, <vscale x 4 x i16> *%pc
  ret void
}

declare <vscale x 8 x i16> @llvm.riscv.xvadd.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>,
  <vscale x 8 x i16>,
  iXLen);

define void @vadd_vint16m2(<vscale x 8 x i16> *%pc, <vscale x 8 x i16> *%pa, <vscale x 8 x i16> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint16m2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m2, d1
; CHECK-NEXT:    th.vle.v	v8, (a1)
; CHECK-NEXT:    th.vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m2, d1
; CHECK-NEXT:    th.vle.v	v10, (a2)
; CHECK-NEXT:    th.vsetvl	zero, a1, a4

; CHECK-NEXT:    th.vsetvli zero, a3, e16, m2, d1
; CHECK-NEXT:    th.vadd.vv v8, v8, v10

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m2, d1
; CHECK-NEXT:    th.vse.v	v8, (a0)
; CHECK-NEXT:    th.vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 8 x i16>, <vscale x 8 x i16>* %pa
  %vb = load <vscale x 8 x i16>, <vscale x 8 x i16>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 8 x i16> %va, %vb
  %vc = call <vscale x 8 x i16> @llvm.riscv.xvadd.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16> %va,
    <vscale x 8 x i16> %vb,
    iXLen %vl)
  store <vscale x 8 x i16> %vc, <vscale x 8 x i16> *%pc
  ret void
}

declare <vscale x 16 x i16> @llvm.riscv.xvadd.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>,
  <vscale x 16 x i16>,
  iXLen);

define void @vadd_vint16m4(<vscale x 16 x i16> *%pc, <vscale x 16 x i16> *%pa, <vscale x 16 x i16> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint16m4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m4, d1
; CHECK-NEXT:    th.vle.v	v8, (a1)
; CHECK-NEXT:    th.vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m4, d1
; CHECK-NEXT:    th.vle.v	v12, (a2)
; CHECK-NEXT:    th.vsetvl	zero, a1, a4

; CHECK-NEXT:    th.vsetvli zero, a3, e16, m4, d1
; CHECK-NEXT:    th.vadd.vv v8, v8, v12

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m4, d1
; CHECK-NEXT:    th.vse.v	v8, (a0)
; CHECK-NEXT:    th.vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 16 x i16>, <vscale x 16 x i16>* %pa
  %vb = load <vscale x 16 x i16>, <vscale x 16 x i16>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 16 x i16> %va, %vb
  %vc = call <vscale x 16 x i16> @llvm.riscv.xvadd.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16> %va,
    <vscale x 16 x i16> %vb,
    iXLen %vl)
  store <vscale x 16 x i16> %vc, <vscale x 16 x i16> *%pc
  ret void
}

declare <vscale x 32 x i16> @llvm.riscv.xvadd.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>,
  <vscale x 32 x i16>,
  iXLen);

define void @vadd_vint16m8(<vscale x 32 x i16> *%pc, <vscale x 32 x i16> *%pa, <vscale x 32 x i16> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint16m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m8, d1
; CHECK-NEXT:    th.vle.v	v8, (a1)
; CHECK-NEXT:    th.vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m8, d1
; CHECK-NEXT:    th.vle.v	v16, (a2)
; CHECK-NEXT:    th.vsetvl	zero, a1, a4

; CHECK-NEXT:    th.vsetvli zero, a3, e16, m8, d1
; CHECK-NEXT:    th.vadd.vv v8, v8, v16

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    th.vsetvli	zero, zero, e16, m8, d1
; CHECK-NEXT:    th.vse.v	v8, (a0)
; CHECK-NEXT:    th.vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 32 x i16>, <vscale x 32 x i16>* %pa
  %vb = load <vscale x 32 x i16>, <vscale x 32 x i16>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 32 x i16> %va, %vb
  %vc = call <vscale x 32 x i16> @llvm.riscv.xvadd.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16> %va,
    <vscale x 32 x i16> %vb,
    iXLen %vl)
  store <vscale x 32 x i16> %vc, <vscale x 32 x i16> *%pc
  ret void
}
