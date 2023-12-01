; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare <vscale x 8 x i8> @llvm.riscv.th.vlsbu.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen,
  iXLen);

define <vscale x 8 x i8> @intrinsic_xvlsbu_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.th.vlsbu.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.th.vlsbu.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_xvlsbu_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.th.vlsbu.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.th.vlsbu.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen,
  iXLen);

define <vscale x 16 x i8> @intrinsic_xvlsbu_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.th.vlsbu.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 16 x i8> @llvm.riscv.th.vlsbu.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i8> @intrinsic_xvlsbu_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i8> @llvm.riscv.th.vlsbu.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.th.vlsbu.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen,
  iXLen);

define <vscale x 32 x i8> @intrinsic_xvlsbu_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.th.vlsbu.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 32 x i8> @llvm.riscv.th.vlsbu.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i8> @intrinsic_xvlsbu_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i8> @llvm.riscv.th.vlsbu.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.th.vlsbu.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen,
  iXLen);

define <vscale x 64 x i8> @intrinsic_xvlsbu_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.th.vlsbu.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 64 x i8> @llvm.riscv.th.vlsbu.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen,
  <vscale x 64 x i1>,
  iXLen);

define <vscale x 64 x i8> @intrinsic_xvlsbu_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, iXLen %2, <vscale x 64 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e8, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 64 x i8> @llvm.riscv.th.vlsbu.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    iXLen %2,
    <vscale x 64 x i1> %3,
    iXLen %4)

  ret <vscale x 64 x i8> %a
}

declare <vscale x 4 x i16> @llvm.riscv.th.vlsbu.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlsbu_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.th.vlsbu.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.th.vlsbu.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlsbu_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.th.vlsbu.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.th.vlsbu.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlsbu_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.th.vlsbu.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.th.vlsbu.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlsbu_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.th.vlsbu.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.th.vlsbu.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlsbu_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.th.vlsbu.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.th.vlsbu.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlsbu_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.th.vlsbu.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.th.vlsbu.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlsbu_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.th.vlsbu.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.th.vlsbu.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlsbu_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.th.vlsbu.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vlsbu.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsbu_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vlsbu.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vlsbu.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlsbu_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vlsbu.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vlsbu.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsbu_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vlsbu.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vlsbu.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlsbu_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vlsbu.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vlsbu.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsbu_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vlsbu.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vlsbu.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlsbu_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vlsbu.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vlsbu.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsbu_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vlsbu.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vlsbu.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlsbu_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vlsbu.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlsbu.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsbu_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlsbu.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlsbu.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlsbu_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlsbu.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlsbu.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsbu_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlsbu.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlsbu.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlsbu_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlsbu.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlsbu.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsbu_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlsbu.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlsbu.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlsbu_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlsbu.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlsbu.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsbu_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlsbu.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlsbu.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlsbu_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlsbu_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    th.vlsbu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlsbu.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 4 x i16> @llvm.riscv.th.vlshu.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlshu_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.th.vlshu.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.th.vlshu.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_xvlshu_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m1, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.th.vlshu.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.th.vlshu.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlshu_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.th.vlshu.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.th.vlshu.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_xvlshu_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m2, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.th.vlshu.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.th.vlshu.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlshu_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.th.vlshu.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.th.vlshu.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_xvlshu_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m4, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.th.vlshu.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.th.vlshu.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlshu_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.th.vlshu.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.th.vlshu.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_xvlshu_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, iXLen %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e16, m8, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.th.vlshu.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    iXLen %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vlshu.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlshu_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vlshu.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vlshu.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlshu_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vlshu.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vlshu.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlshu_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vlshu.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vlshu.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlshu_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vlshu.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vlshu.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlshu_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vlshu.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vlshu.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlshu_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vlshu.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vlshu.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlshu_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vlshu.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vlshu.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlshu_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vlshu.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlshu.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlshu_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlshu.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlshu.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlshu_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlshu.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlshu.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlshu_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlshu.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlshu.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlshu_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlshu.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlshu.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlshu_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlshu.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlshu.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlshu_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlshu.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlshu.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlshu_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlshu.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlshu.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlshu_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlshu_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    th.vlshu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlshu.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vlswu.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlswu_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vlswu.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.th.vlswu.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_xvlswu_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m1, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.th.vlswu.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vlswu.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlswu_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vlswu.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.th.vlswu.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_xvlswu_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m2, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.th.vlswu.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vlswu.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlswu_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vlswu.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.th.vlswu.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_xvlswu_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m4, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.th.vlswu.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vlswu.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlswu_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vlswu.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.th.vlswu.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_xvlswu_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, iXLen %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e32, m8, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.th.vlswu.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    iXLen %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlswu.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlswu_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlswu.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.th.vlswu.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_xvlswu_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, iXLen %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m1, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.th.vlswu.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    iXLen %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlswu.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlswu_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlswu.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.th.vlswu.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_xvlswu_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, iXLen %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m2, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.th.vlswu.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    iXLen %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlswu.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlswu_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlswu.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.th.vlswu.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_xvlswu_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, iXLen %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m4, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.th.vlswu.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    iXLen %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlswu.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlswu_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlswu.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1,
    iXLen %2)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.th.vlswu.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_xvlswu_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, iXLen %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvlswu_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a2, e64, m8, d1
; CHECK-NEXT:    th.vlswu.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret

entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.th.vlswu.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    iXLen %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i64> %a
}

