; RUN: llc -mtriple=riscv64 -mattr=+xtheadv -verify-machineinstrs < %s | \
; RUN: FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare void @llvm.riscv.xvsxe.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  i64);

define void @intrinsic_xvsxe_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i64> %2, 
    <vscale x 1 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  <vscale x 1 x double>,
  i64);

define void @intrinsic_xvsxe_v_nxv1f64_nxv1f64(<vscale x 1 x double>* %0, <vscale x 1 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    <vscale x 1 x double> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  <vscale x 1 x double>,
  <vscale x 1 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x double> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x double> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  i64);

define void @intrinsic_xvsxe_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i64> %2, 
    <vscale x 2 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  <vscale x 2 x double>,
  i64);

define void @intrinsic_xvsxe_v_nxv2f64_nxv2f64(<vscale x 2 x double>* %0, <vscale x 2 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv2f64.nxv2f64(
    <vscale x 2 x double> undef,
    <vscale x 2 x double>* %0,
    <vscale x 2 x double> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  <vscale x 2 x double>,
  <vscale x 2 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double>* %1, <vscale x 2 x double> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double>* %1,
    <vscale x 2 x double> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  i64);

define void @intrinsic_xvsxe_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i64> %2, 
    <vscale x 4 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  <vscale x 4 x double>,
  i64);

define void @intrinsic_xvsxe_v_nxv4f64_nxv4f64(<vscale x 4 x double>* %0, <vscale x 4 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv4f64.nxv4f64(
    <vscale x 4 x double> undef,
    <vscale x 4 x double>* %0,
    <vscale x 4 x double> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  <vscale x 4 x double>,
  <vscale x 4 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double>* %1, <vscale x 4 x double> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double>* %1,
    <vscale x 4 x double> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  i64);

define void @intrinsic_xvsxe_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i64> %2, 
    <vscale x 8 x i1> %3,
    i64 %4)

  ret void
}

declare void @llvm.riscv.xvsxe.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  <vscale x 8 x double>,
  i64);

define void @intrinsic_xvsxe_v_nxv8f64_nxv8f64(<vscale x 8 x double>* %0, <vscale x 8 x double> %1, i64 %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.nxv8f64.nxv8f64(
    <vscale x 8 x double> undef,
    <vscale x 8 x double>* %0,
    <vscale x 8 x double> %1,
    i64 %2)

  ret void
}

declare void @llvm.riscv.xvsxe.mask.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  <vscale x 8 x double>,
  <vscale x 8 x i1>,
  i64);

define void @intrinsic_xvsxe_mask_v_nxv8f64_nxv8f64(<vscale x 8 x double> %0, <vscale x 8 x double>* %1, <vscale x 8 x double> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsxe.mask.nxv8f64.nxv8f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double>* %1,
    <vscale x 8 x double> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret void
}
