; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 8 x i8> @llvm.riscv.xvlsb.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen,
  iXLen);

define <vscale x 8 x i8> @intrinsic_xvlsb_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.xvlsb.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.xvlsb.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_xvlsb_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.xvlsb.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.xvlsb.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen,
  iXLen);

define <vscale x 16 x i8> @intrinsic_xvlsb_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.xvlsb.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.xvlsb.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i8> @intrinsic_xvlsb_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.xvlsb.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.xvlsb.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen,
  iXLen);

define <vscale x 32 x i8> @intrinsic_xvlsb_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.xvlsb.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.xvlsb.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i8> @intrinsic_xvlsb_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.xvlsb.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.xvlsb.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen,
  iXLen);

define <vscale x 64 x i8> @intrinsic_xvlsb_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.xvlsb.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.xvlsb.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen,
  <vscale x 64 x i1>,
  iXLen);

define <vscale x 64 x i8> @intrinsic_xvlsb_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, iXLen %2, <vscale x 64 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.xvlsb.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    iXLen %2,
    <vscale x 64 x i1> %3,
    iXLen %4)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 4 x i16> @llvm.riscv.xvlsb.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlsb_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.xvlsb.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.xvlsb.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlsb_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.xvlsb.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.xvlsb.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlsb_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.xvlsb.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.xvlsb.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlsb_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.xvlsb.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.xvlsb.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlsb_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.xvlsb.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.xvlsb.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlsb_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.xvlsb.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.xvlsb.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlsb_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.xvlsb.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.xvlsb.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlsb_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.xvlsb.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlsb.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsb_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlsb.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlsb.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsb_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlsb.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlsb.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsb_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlsb.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlsb.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsb_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlsb.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlsb.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsb_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlsb.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlsb.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsb_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlsb.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlsb.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsb_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlsb.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlsb.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsb_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlsb.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlsb.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsb_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlsb.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlsb.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsb_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlsb.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlsb.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsb_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlsb.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlsb.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsb_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlsb.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlsb.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsb_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlsb.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlsb.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsb_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlsb.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlsb.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsb_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlsb.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlsb.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsb_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsb_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlsb.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlsb.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 4 x i16> @llvm.riscv.xvlsh.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlsh_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.xvlsh.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.xvlsh.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlsh_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.xvlsh.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.xvlsh.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlsh_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.xvlsh.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.xvlsh.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlsh_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.xvlsh.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.xvlsh.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlsh_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.xvlsh.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.xvlsh.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlsh_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.xvlsh.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.xvlsh.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlsh_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.xvlsh.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.xvlsh.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlsh_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.xvlsh.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlsh.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsh_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlsh.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlsh.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsh_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlsh.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlsh.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsh_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlsh.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlsh.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsh_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlsh.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlsh.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsh_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlsh.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlsh.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsh_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlsh.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlsh.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsh_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlsh.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlsh.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsh_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlsh.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlsh.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsh_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlsh.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlsh.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsh_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlsh.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlsh.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsh_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlsh.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlsh.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsh_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlsh.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlsh.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsh_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlsh.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlsh.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsh_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlsh.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlsh.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsh_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlsh.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlsh.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsh_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsh_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlsh.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlsh.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlsw.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsw_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlsw.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlsw.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsw_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlsw.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlsw.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsw_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlsw.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlsw.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsw_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlsw.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlsw.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsw_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlsw.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlsw.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsw_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlsw.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlsw.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsw_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlsw.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlsw.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsw_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlsw.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlsw.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsw_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlsw.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlsw.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsw_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlsw.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlsw.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsw_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlsw.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlsw.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsw_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlsw.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlsw.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsw_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlsw.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlsw.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsw_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlsw.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlsw.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsw_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlsw.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlsw.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsw_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsw_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlsw.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlsw.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i8> @llvm.riscv.xvlse.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen,
  iXLen);

define <vscale x 8 x i8> @intrinsic_xvlse_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.xvlse.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.xvlse.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_xvlse_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.xvlse.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.xvlse.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen,
  iXLen);

define <vscale x 16 x i8> @intrinsic_xvlse_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.xvlse.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.xvlse.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i8> @intrinsic_xvlse_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.xvlse.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.xvlse.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen,
  iXLen);

define <vscale x 32 x i8> @intrinsic_xvlse_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.xvlse.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.xvlse.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i8> @intrinsic_xvlse_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.xvlse.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.xvlse.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen,
  iXLen);

define <vscale x 64 x i8> @intrinsic_xvlse_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.xvlse.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.xvlse.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen,
  <vscale x 64 x i1>,
  iXLen);

define <vscale x 64 x i8> @intrinsic_xvlse_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, iXLen %2, <vscale x 64 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.xvlse.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    iXLen %2,
    <vscale x 64 x i1> %3,
    iXLen %4)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 4 x i16> @llvm.riscv.xvlse.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlse_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.xvlse.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.xvlse.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlse_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.xvlse.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.xvlse.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlse_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.xvlse.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.xvlse.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlse_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.xvlse.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.xvlse.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlse_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.xvlse.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.xvlse.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlse_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.xvlse.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.xvlse.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlse_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.xvlse.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.xvlse.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlse_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.xvlse.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 4 x half> @llvm.riscv.xvlse.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  iXLen,
  iXLen);

define <vscale x 4 x half> @intrinsic_xvlse_v_nxv4f16_nxv4f16(<vscale x 4 x half>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv4f16_nxv4f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x half> @llvm.riscv.xvlse.nxv4f16.nxv4f16(
    <vscale x 4 x half> undef,
    <vscale x 4 x half>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x half> %a
}

declare <vscale x 4 x half> @llvm.riscv.xvlse.mask.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x half> @intrinsic_xvlse_mask_v_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv4f16_nxv4f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x half> @llvm.riscv.xvlse.mask.nxv4f16.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.xvlse.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  iXLen,
  iXLen);

define <vscale x 8 x half> @intrinsic_xvlse_v_nxv8f16_nxv8f16(<vscale x 8 x half>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8f16_nxv8f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x half> @llvm.riscv.xvlse.nxv8f16.nxv8f16(
    <vscale x 8 x half> undef,
    <vscale x 8 x half>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x half> %a
}

declare <vscale x 8 x half> @llvm.riscv.xvlse.mask.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x half> @intrinsic_xvlse_mask_v_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8f16_nxv8f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x half> @llvm.riscv.xvlse.mask.nxv8f16.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.xvlse.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  iXLen,
  iXLen);

define <vscale x 16 x half> @intrinsic_xvlse_v_nxv16f16_nxv16f16(<vscale x 16 x half>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv16f16_nxv16f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x half> @llvm.riscv.xvlse.nxv16f16.nxv16f16(
    <vscale x 16 x half> undef,
    <vscale x 16 x half>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x half> %a
}

declare <vscale x 16 x half> @llvm.riscv.xvlse.mask.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x half> @intrinsic_xvlse_mask_v_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv16f16_nxv16f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x half> @llvm.riscv.xvlse.mask.nxv16f16.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x half> %a
}

declare <vscale x 32 x half> @llvm.riscv.xvlse.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  iXLen,
  iXLen);

define <vscale x 32 x half> @intrinsic_xvlse_v_nxv32f16_nxv32f16(<vscale x 32 x half>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv32f16_nxv32f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x half> @llvm.riscv.xvlse.nxv32f16.nxv32f16(
    <vscale x 32 x half> undef,
    <vscale x 32 x half>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x half> %a
}

declare <vscale x 32 x half> @llvm.riscv.xvlse.mask.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x half> @intrinsic_xvlse_mask_v_nxv32f16_nxv32f16(<vscale x 32 x half> %0, <vscale x 32 x half>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv32f16_nxv32f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x half> @llvm.riscv.xvlse.mask.nxv32f16.nxv32f16(
    <vscale x 32 x half> %0,
    <vscale x 32 x half>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x half> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlse.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlse_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlse.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.xvlse.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlse_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.xvlse.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlse.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlse_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlse.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.xvlse.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlse_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.xvlse.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlse.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlse_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlse.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.xvlse.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlse_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.xvlse.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlse.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlse_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlse.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.xvlse.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlse_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.xvlse.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 2 x float> @llvm.riscv.xvlse.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  iXLen,
  iXLen);

define <vscale x 2 x float> @intrinsic_xvlse_v_nxv2f32_nxv2f32(<vscale x 2 x float>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv2f32_nxv2f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x float> @llvm.riscv.xvlse.nxv2f32.nxv2f32(
    <vscale x 2 x float> undef,
    <vscale x 2 x float>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.xvlse.mask.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x float> @intrinsic_xvlse_mask_v_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv2f32_nxv2f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x float> @llvm.riscv.xvlse.mask.nxv2f32.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.xvlse.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  iXLen,
  iXLen);

define <vscale x 4 x float> @intrinsic_xvlse_v_nxv4f32_nxv4f32(<vscale x 4 x float>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv4f32_nxv4f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x float> @llvm.riscv.xvlse.nxv4f32.nxv4f32(
    <vscale x 4 x float> undef,
    <vscale x 4 x float>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.xvlse.mask.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x float> @intrinsic_xvlse_mask_v_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv4f32_nxv4f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x float> @llvm.riscv.xvlse.mask.nxv4f32.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.xvlse.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  iXLen,
  iXLen);

define <vscale x 8 x float> @intrinsic_xvlse_v_nxv8f32_nxv8f32(<vscale x 8 x float>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8f32_nxv8f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x float> @llvm.riscv.xvlse.nxv8f32.nxv8f32(
    <vscale x 8 x float> undef,
    <vscale x 8 x float>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.xvlse.mask.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x float> @intrinsic_xvlse_mask_v_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8f32_nxv8f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x float> @llvm.riscv.xvlse.mask.nxv8f32.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.xvlse.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  iXLen,
  iXLen);

define <vscale x 16 x float> @intrinsic_xvlse_v_nxv16f32_nxv16f32(<vscale x 16 x float>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv16f32_nxv16f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x float> @llvm.riscv.xvlse.nxv16f32.nxv16f32(
    <vscale x 16 x float> undef,
    <vscale x 16 x float>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.xvlse.mask.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x float> @intrinsic_xvlse_mask_v_nxv16f32_nxv16f32(<vscale x 16 x float> %0, <vscale x 16 x float>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv16f32_nxv16f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x float> @llvm.riscv.xvlse.mask.nxv16f32.nxv16f32(
    <vscale x 16 x float> %0,
    <vscale x 16 x float>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x float> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlse.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlse_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlse.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.xvlse.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlse_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.xvlse.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlse.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlse_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlse.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.xvlse.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlse_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.xvlse.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlse.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlse_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlse.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.xvlse.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlse_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.xvlse.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlse.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlse_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlse.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.xvlse.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlse_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.xvlse.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 1 x double> @llvm.riscv.xvlse.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  iXLen,
  iXLen);

define <vscale x 1 x double> @intrinsic_xvlse_v_nxv1f64_nxv1f64(<vscale x 1 x double>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x double> @llvm.riscv.xvlse.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x double> %a
}

declare <vscale x 1 x double> @llvm.riscv.xvlse.mask.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x double> @intrinsic_xvlse_mask_v_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x double> @llvm.riscv.xvlse.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.xvlse.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  iXLen,
  iXLen);

define <vscale x 2 x double> @intrinsic_xvlse_v_nxv2f64_nxv2f64(<vscale x 2 x double>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x double> @llvm.riscv.xvlse.nxv2f64.nxv2f64(
    <vscale x 2 x double> undef,
    <vscale x 2 x double>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x double> %a
}

declare <vscale x 2 x double> @llvm.riscv.xvlse.mask.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x double> @intrinsic_xvlse_mask_v_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x double> @llvm.riscv.xvlse.mask.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.xvlse.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  iXLen,
  iXLen);

define <vscale x 4 x double> @intrinsic_xvlse_v_nxv4f64_nxv4f64(<vscale x 4 x double>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x double> @llvm.riscv.xvlse.nxv4f64.nxv4f64(
    <vscale x 4 x double> undef,
    <vscale x 4 x double>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x double> %a
}

declare <vscale x 4 x double> @llvm.riscv.xvlse.mask.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x double> @intrinsic_xvlse_mask_v_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x double> @llvm.riscv.xvlse.mask.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.xvlse.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  iXLen,
  iXLen);

define <vscale x 8 x double> @intrinsic_xvlse_v_nxv8f64_nxv8f64(<vscale x 8 x double>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlse_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x double> @llvm.riscv.xvlse.nxv8f64.nxv8f64(
    <vscale x 8 x double> undef,
    <vscale x 8 x double>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x double> %a
}

declare <vscale x 8 x double> @llvm.riscv.xvlse.mask.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x double> @intrinsic_xvlse_mask_v_nxv8f64_nxv8f64(<vscale x 8 x double> %0, <vscale x 8 x double>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlse_mask_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    vlse.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x double> @llvm.riscv.xvlse.mask.nxv8f64.nxv8f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x double> %a
}

