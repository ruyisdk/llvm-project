; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 8 x i8> @llvm.riscv.xvadd.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define void @vadd_vint8m1(<vscale x 8 x i8> *%pc, <vscale x 8 x i8> *%pa, <vscale x 8 x i8> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint8m1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m1, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m1, d1
; CHECK-NEXT:    vle.v	v9, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e8, m1, d1
; CHECK-NEXT:    vadd.vv v8, v8, v9

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m1, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 8 x i8>, <vscale x 8 x i8>* %pa
  %vb = load <vscale x 8 x i8>, <vscale x 8 x i8>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 8 x i8> %va, %vb
  %vc = call <vscale x 8 x i8> @llvm.riscv.xvadd.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8> %va,
    <vscale x 8 x i8> %vb,
    iXLen %vl)
  store <vscale x 8 x i8> %vc, <vscale x 8 x i8> *%pc
  ret void
}

declare <vscale x 16 x i8> @llvm.riscv.xvadd.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>,
  <vscale x 16 x i8>,
  iXLen);

define void @vadd_vint8m2(<vscale x 16 x i8> *%pc, <vscale x 16 x i8> *%pa, <vscale x 16 x i8> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint8m2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m2, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m2, d1
; CHECK-NEXT:    vle.v	v10, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e8, m2, d1
; CHECK-NEXT:    vadd.vv v8, v8, v10

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m2, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 16 x i8>, <vscale x 16 x i8>* %pa
  %vb = load <vscale x 16 x i8>, <vscale x 16 x i8>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 16 x i8> %va, %vb
  %vc = call <vscale x 16 x i8> @llvm.riscv.xvadd.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8> %va,
    <vscale x 16 x i8> %vb,
    iXLen %vl)
  store <vscale x 16 x i8> %vc, <vscale x 16 x i8> *%pc
  ret void
}

declare <vscale x 32 x i8> @llvm.riscv.xvadd.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>,
  <vscale x 32 x i8>,
  iXLen);

define void @vadd_vint8m4(<vscale x 32 x i8> *%pc, <vscale x 32 x i8> *%pa, <vscale x 32 x i8> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint8m4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m4, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m4, d1
; CHECK-NEXT:    vle.v	v12, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e8, m4, d1
; CHECK-NEXT:    vadd.vv v8, v8, v12

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m4, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 32 x i8>, <vscale x 32 x i8>* %pa
  %vb = load <vscale x 32 x i8>, <vscale x 32 x i8>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 32 x i8> %va, %vb
  %vc = call <vscale x 32 x i8> @llvm.riscv.xvadd.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8> %va,
    <vscale x 32 x i8> %vb,
    iXLen %vl)
  store <vscale x 32 x i8> %vc, <vscale x 32 x i8> *%pc
  ret void
}

declare <vscale x 64 x i8> @llvm.riscv.xvadd.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>,
  <vscale x 64 x i8>,
  iXLen);

define void @vadd_vint8m8(<vscale x 64 x i8> *%pc, <vscale x 64 x i8> *%pa, <vscale x 64 x i8> *%pb, iXLen %vl) nounwind {
; CHECK-LABEL: vadd_vint8m8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr	a4, vl
; CHECK-NEXT:    csrr	a5, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m8, d1
; CHECK-NEXT:    vle.v	v8, (a1)
; CHECK-NEXT:    vsetvl	zero, a4, a5

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a4, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m8, d1
; CHECK-NEXT:    vle.v	v16, (a2)
; CHECK-NEXT:    vsetvl	zero, a1, a4

; CHECK-NEXT:    vsetvli zero, a3, e8, m8, d1
; CHECK-NEXT:    vadd.vv v8, v8, v16

; CHECK-NEXT:    csrr	a1, vl
; CHECK-NEXT:    csrr	a2, vtype
; CHECK-NEXT:    vsetvli	zero, zero, e8, m8, d1
; CHECK-NEXT:    vse.v	v8, (a0)
; CHECK-NEXT:    vsetvl	zero, a1, a2

; CHECK-NEXT:    ret
  %va = load <vscale x 64 x i8>, <vscale x 64 x i8>* %pa
  %vb = load <vscale x 64 x i8>, <vscale x 64 x i8>* %pb
  ; TODO: support select `add` to `llvm.riscv.xvadd`
  ; %vc = add <vscale x 64 x i8> %va, %vb
  %vc = call <vscale x 64 x i8> @llvm.riscv.xvadd.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8> %va,
    <vscale x 64 x i8> %vb,
    iXLen %vl)
  store <vscale x 64 x i8> %vc, <vscale x 64 x i8> *%pc
  ret void
}
