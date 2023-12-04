; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+a,+xtheadvector,+xtheadvamo \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+a,+xtheadvector,+xtheadvamo \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 2 x i32> @llvm.riscv.th.vamominu.nxv2i32.nxv2i32(
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvamominu_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vamominuw.v v9, v8, (a0), v9
; CHECK-NEXT:    th.vmv.v.v v8, v9
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vamominu.nxv2i32.nxv2i32(
    <vscale x 2 x i32>* %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vamominu.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvamominu_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vamominuw.v v9, v8, (a0), v9, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v9
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vamominu.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32>* %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vamominu.nxv4i32.nxv4i32(
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvamominu_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vamominuw.v v10, v8, (a0), v10
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vamominu.nxv4i32.nxv4i32(
    <vscale x 4 x i32>* %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i32> %2,
    iXLen %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vamominu.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvamominu_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vamominuw.v v10, v8, (a0), v10, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vamominu.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32>* %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vamominu.nxv8i32.nxv8i32(
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvamominu_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, <vscale x 8 x i32> %1, <vscale x 8 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vamominuw.v v12, v8, (a0), v12
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vamominu.nxv8i32.nxv8i32(
    <vscale x 8 x i32>* %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i32> %2,
    iXLen %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vamominu.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvamominu_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, <vscale x 8 x i32> %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vamominuw.v v12, v8, (a0), v12, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vamominu.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32>* %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vamominu.nxv16i32.nxv16i32(
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvamominu_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, <vscale x 16 x i32> %1, <vscale x 16 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vamominuw.v v16, v8, (a0), v16
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vamominu.nxv16i32.nxv16i32(
    <vscale x 16 x i32>* %0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i32> %2,
    iXLen %3)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vamominu.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvamominu_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, <vscale x 16 x i32> %1, <vscale x 16 x i32> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vamominuw.v v16, v8, (a0), v16, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vamominu.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32>* %0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i32> %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vamominu.nxv2i64.nxv2i32(
  <vscale x 2 x i64>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i64>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvamominu_v_nxv2i64_nxv2i32(<vscale x 2 x i64>* %0, <vscale x 2 x i32> %1, <vscale x 2 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv2i64_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vamominud.v v10, v8, (a0), v10
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vamominu.nxv2i64.nxv2i32(
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i64> %2,
    iXLen %3)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vamominu.mask.nxv2i64.nxv2i32(
  <vscale x 2 x i64>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvamominu_mask_v_nxv2i64_nxv2i32(<vscale x 2 x i64>* %0, <vscale x 2 x i32> %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv2i64_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vamominud.v v10, v8, (a0), v10, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vamominu.mask.nxv2i64.nxv2i32(
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i64> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vamominu.nxv4i64.nxv4i32(
  <vscale x 4 x i64>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i64>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvamominu_v_nxv4i64_nxv4i32(<vscale x 4 x i64>* %0, <vscale x 4 x i32> %1, <vscale x 4 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv4i64_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vamominud.v v12, v8, (a0), v12
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vamominu.nxv4i64.nxv4i32(
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i64> %2,
    iXLen %3)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vamominu.mask.nxv4i64.nxv4i32(
  <vscale x 4 x i64>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvamominu_mask_v_nxv4i64_nxv4i32(<vscale x 4 x i64>* %0, <vscale x 4 x i32> %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv4i64_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vamominud.v v12, v8, (a0), v12, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vamominu.mask.nxv4i64.nxv4i32(
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i64> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vamominu.nxv8i64.nxv8i32(
  <vscale x 8 x i64>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i64>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvamominu_v_nxv8i64_nxv8i32(<vscale x 8 x i64>* %0, <vscale x 8 x i32> %1, <vscale x 8 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv8i64_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vamominud.v v16, v8, (a0), v16
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vamominu.nxv8i64.nxv8i32(
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i64> %2,
    iXLen %3)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vamominu.mask.nxv8i64.nxv8i32(
  <vscale x 8 x i64>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvamominu_mask_v_nxv8i64_nxv8i32(<vscale x 8 x i64>* %0, <vscale x 8 x i32> %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv8i64_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vamominud.v v16, v8, (a0), v16, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vamominu.mask.nxv8i64.nxv8i32(
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i64> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vamominu.nxv2i32.nxv2i64(
  <vscale x 2 x i32>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvamominu_v_nxv2i32_nxv2i64(<vscale x 2 x i32>* %0, <vscale x 2 x i64> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv2i32_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vamominuw.v v10, v8, (a0), v10
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vamominu.nxv2i32.nxv2i64(
    <vscale x 2 x i32>* %0,
    <vscale x 2 x i64> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vamominu.mask.nxv2i32.nxv2i64(
  <vscale x 2 x i32>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvamominu_mask_v_nxv2i32_nxv2i64(<vscale x 2 x i32>* %0, <vscale x 2 x i64> %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv2i32_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vamominuw.v v10, v8, (a0), v10, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vamominu.mask.nxv2i32.nxv2i64(
    <vscale x 2 x i32>* %0,
    <vscale x 2 x i64> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vamominu.nxv4i32.nxv4i64(
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i32>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvamominu_v_nxv4i32_nxv4i64(<vscale x 4 x i32>* %0, <vscale x 4 x i64> %1, <vscale x 4 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv4i32_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vamominuw.v v12, v8, (a0), v12
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vamominu.nxv4i32.nxv4i64(
    <vscale x 4 x i32>* %0,
    <vscale x 4 x i64> %1,
    <vscale x 4 x i32> %2,
    iXLen %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vamominu.mask.nxv4i32.nxv4i64(
  <vscale x 4 x i32>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvamominu_mask_v_nxv4i32_nxv4i64(<vscale x 4 x i32>* %0, <vscale x 4 x i64> %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv4i32_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vamominuw.v v12, v8, (a0), v12, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vamominu.mask.nxv4i32.nxv4i64(
    <vscale x 4 x i32>* %0,
    <vscale x 4 x i64> %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vamominu.nxv8i32.nxv8i64(
  <vscale x 8 x i32>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i32>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvamominu_v_nxv8i32_nxv8i64(<vscale x 8 x i32>* %0, <vscale x 8 x i64> %1, <vscale x 8 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv8i32_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vamominuw.v v16, v8, (a0), v16
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vamominu.nxv8i32.nxv8i64(
    <vscale x 8 x i32>* %0,
    <vscale x 8 x i64> %1,
    <vscale x 8 x i32> %2,
    iXLen %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vamominu.mask.nxv8i32.nxv8i64(
  <vscale x 8 x i32>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvamominu_mask_v_nxv8i32_nxv8i64(<vscale x 8 x i32>* %0, <vscale x 8 x i64> %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv8i32_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vamominuw.v v16, v8, (a0), v16, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vamominu.mask.nxv8i32.nxv8i64(
    <vscale x 8 x i32>* %0,
    <vscale x 8 x i64> %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vamominu.nxv1i64.nxv1i64(
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvamominu_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, <vscale x 1 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vamominud.v v9, v8, (a0), v9
; CHECK-NEXT:    th.vmv.v.v v8, v9
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vamominu.nxv1i64.nxv1i64(
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    <vscale x 1 x i64> %2,
    iXLen %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vamominu.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>*,
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvamominu_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, <vscale x 1 x i64> %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    th.vamominud.v v9, v8, (a0), v9, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v9
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vamominu.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64>* %0,
    <vscale x 1 x i64> %1,
    <vscale x 1 x i64> %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vamominu.nxv2i64.nxv2i64(
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i64>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvamominu_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, <vscale x 2 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vamominud.v v10, v8, (a0), v10
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vamominu.nxv2i64.nxv2i64(
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    <vscale x 2 x i64> %2,
    iXLen %3)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vamominu.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>*,
  <vscale x 2 x i64>,
  <vscale x 2 x i64>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvamominu_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, <vscale x 2 x i64> %1, <vscale x 2 x i64> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    th.vamominud.v v10, v8, (a0), v10, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v10
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vamominu.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64>* %0,
    <vscale x 2 x i64> %1,
    <vscale x 2 x i64> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vamominu.nxv4i64.nxv4i64(
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i64>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvamominu_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, <vscale x 4 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vamominud.v v12, v8, (a0), v12
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vamominu.nxv4i64.nxv4i64(
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    <vscale x 4 x i64> %2,
    iXLen %3)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vamominu.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>*,
  <vscale x 4 x i64>,
  <vscale x 4 x i64>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvamominu_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, <vscale x 4 x i64> %1, <vscale x 4 x i64> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    th.vamominud.v v12, v8, (a0), v12, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v12
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vamominu.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64>* %0,
    <vscale x 4 x i64> %1,
    <vscale x 4 x i64> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vamominu.nxv8i64.nxv8i64(
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i64>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvamominu_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, <vscale x 8 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vamominud.v v16, v8, (a0), v16
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vamominu.nxv8i64.nxv8i64(
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    <vscale x 8 x i64> %2,
    iXLen %3)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vamominu.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>*,
  <vscale x 8 x i64>,
  <vscale x 8 x i64>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvamominu_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, <vscale x 8 x i64> %1, <vscale x 8 x i64> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvamominu_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    th.vamominud.v v16, v8, (a0), v16, v0.t
; CHECK-NEXT:    th.vmv.v.v v8, v16
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vamominu.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64>* %0,
    <vscale x 8 x i64> %1,
    <vscale x 8 x i64> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

