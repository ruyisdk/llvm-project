; RUN: llc -mtriple=riscv64 -mattr=+xtheadvector -verify-machineinstrs < %s | \
; RUN: FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 1 x i64> @llvm.riscv.th.vlxb.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxb_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxb.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    i64 %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxb.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxb_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxb.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i64> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxb.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxb_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxb.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    i64 %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxb.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxb_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxb.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i64> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxb.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxb_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxb.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    i64 %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxb.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxb_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxb.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i64> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxb.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxb_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxb.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    i64 %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxb.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxb_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxb_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxb.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxb.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i64> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxh.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxh_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxh.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    i64 %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxh.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxh_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxh.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i64> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxh.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxh_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxh.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    i64 %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxh.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxh_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxh.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i64> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxh.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxh_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxh.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    i64 %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxh.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxh_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxh.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i64> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxh.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxh_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxh.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    i64 %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxh.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxh_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxh_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxh.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxh.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i64> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxw.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxw_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxw.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    i64 %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxw.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxw_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxw.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i64> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxw.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxw_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxw.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    i64 %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxw.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxw_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxw.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i64> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxw.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxw_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxw.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    i64 %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxw.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxw_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxw.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i64> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxw.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxw_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxw.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    i64 %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxw.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxw_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxw_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxw.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxw.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i64> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxe.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxe_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxe.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    i64 %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlxe.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i64> @intrinsic_xvlxe_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlxe.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i64> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxe.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxe_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxe.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    i64 %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlxe.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i64> @intrinsic_xvlxe_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlxe.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i64> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxe.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxe_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxe.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    i64 %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlxe.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i64> @intrinsic_xvlxe_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlxe.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i64> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxe.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxe_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxe.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    i64 %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlxe.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i64> @intrinsic_xvlxe_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlxe.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i64> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x double> @llvm.riscv.th.vlxe.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  <vscale x 1 x double>,
  i64);

define <vscale x 1 x double> @intrinsic_xvlxe_v_nxv1f64_nxv1f64(<vscale x 1 x double>* %0, <vscale x 1 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x double> @llvm.riscv.th.vlxe.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    <vscale x 1 x double> %1,
    i64 %2)

  ret <vscale x 1 x double> %a
}

declare <vscale x 1 x double> @llvm.riscv.th.vlxe.mask.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  <vscale x 1 x double>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x double> @intrinsic_xvlxe_mask_v_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x double> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x double> @llvm.riscv.th.vlxe.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x double> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.th.vlxe.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  <vscale x 2 x double>,
  i64);

define <vscale x 2 x double> @intrinsic_xvlxe_v_nxv2f64_nxv2f64(<vscale x 2 x double>* %0, <vscale x 2 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x double> @llvm.riscv.th.vlxe.nxv2f64.nxv2f64(
    <vscale x 2 x double> undef,
    <vscale x 2 x double>* %0,
    <vscale x 2 x double> %1,
    i64 %2)

  ret <vscale x 2 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.th.vlxe.mask.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  <vscale x 2 x double>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x double> @intrinsic_xvlxe_mask_v_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double>* %1, <vscale x 2 x double> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x double> @llvm.riscv.th.vlxe.mask.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double>* %1,
    <vscale x 2 x double> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.th.vlxe.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  <vscale x 4 x double>,
  i64);

define <vscale x 4 x double> @intrinsic_xvlxe_v_nxv4f64_nxv4f64(<vscale x 4 x double>* %0, <vscale x 4 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x double> @llvm.riscv.th.vlxe.nxv4f64.nxv4f64(
    <vscale x 4 x double> undef,
    <vscale x 4 x double>* %0,
    <vscale x 4 x double> %1,
    i64 %2)

  ret <vscale x 4 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.th.vlxe.mask.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  <vscale x 4 x double>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x double> @intrinsic_xvlxe_mask_v_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double>* %1, <vscale x 4 x double> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x double> @llvm.riscv.th.vlxe.mask.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double>* %1,
    <vscale x 4 x double> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.th.vlxe.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  <vscale x 8 x double>,
  i64);

define <vscale x 8 x double> @intrinsic_xvlxe_v_nxv8f64_nxv8f64(<vscale x 8 x double>* %0, <vscale x 8 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x double> @llvm.riscv.th.vlxe.nxv8f64.nxv8f64(
    <vscale x 8 x double> undef,
    <vscale x 8 x double>* %0,
    <vscale x 8 x double> %1,
    i64 %2)

  ret <vscale x 8 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.th.vlxe.mask.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  <vscale x 8 x double>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x double> @intrinsic_xvlxe_mask_v_nxv8f64_nxv8f64(<vscale x 8 x double> %0, <vscale x 8 x double>* %1, <vscale x 8 x double> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvlxe_mask_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vlxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x double> @llvm.riscv.th.vlxe.mask.nxv8f64.nxv8f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double>* %1,
    <vscale x 8 x double> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x double> %a
}