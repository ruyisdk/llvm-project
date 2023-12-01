; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,RV64

declare { <vscale x 8 x i8>, iXLen } @llvm.riscv.th.vleff.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vleff_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8i8_nxv8i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8i8_nxv8i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i8>, iXLen } @llvm.riscv.th.vleff.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x i8> %b
}

declare { <vscale x 8 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vleff_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8i8_nxv8i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8i8_nxv8i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x i8> %b
}

declare { <vscale x 16 x i8>, iXLen } @llvm.riscv.th.vleff.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen);

define <vscale x 16 x i8> @intrinsic_vleff_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv16i8_nxv16i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv16i8_nxv16i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x i8>, iXLen } @llvm.riscv.th.vleff.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 16 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 16 x i8> %b
}

declare { <vscale x 16 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i8> @intrinsic_vleff_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, <vscale x 16 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv16i8_nxv16i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv16i8_nxv16i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 16 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 16 x i8> %b
}

declare { <vscale x 32 x i8>, iXLen } @llvm.riscv.th.vleff.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen);

define <vscale x 32 x i8> @intrinsic_vleff_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv32i8_nxv32i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv32i8_nxv32i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 32 x i8>, iXLen } @llvm.riscv.th.vleff.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 32 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 32 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 32 x i8> %b
}

declare { <vscale x 32 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i8> @intrinsic_vleff_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, <vscale x 32 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv32i8_nxv32i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv32i8_nxv32i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 32 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 32 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 32 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 32 x i8> %b
}

declare { <vscale x 64 x i8>, iXLen } @llvm.riscv.th.vleff.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen);

define <vscale x 64 x i8> @intrinsic_vleff_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv64i8_nxv64i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv64i8_nxv64i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 64 x i8>, iXLen } @llvm.riscv.th.vleff.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 64 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 64 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 64 x i8> %b
}

declare { <vscale x 64 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i1>,
  iXLen);

define <vscale x 64 x i8> @intrinsic_vleff_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, <vscale x 64 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv64i8_nxv64i8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e8, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv64i8_nxv64i8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e8, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 64 x i8>, iXLen } @llvm.riscv.th.vleff.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    <vscale x 64 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 64 x i8>, iXLen } %a, 0
  %c = extractvalue { <vscale x 64 x i8>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 64 x i8> %b
}

declare { <vscale x 4 x i16>, iXLen } @llvm.riscv.th.vleff.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vleff_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv4i16_nxv4i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv4i16_nxv4i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x i16>, iXLen } @llvm.riscv.th.vleff.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 4 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 4 x i16> %b
}

declare { <vscale x 4 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vleff_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, <vscale x 4 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv4i16_nxv4i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv4i16_nxv4i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 4 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 4 x i16> %b
}

declare { <vscale x 8 x i16>, iXLen } @llvm.riscv.th.vleff.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen);

define <vscale x 8 x i16> @intrinsic_vleff_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8i16_nxv8i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8i16_nxv8i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i16>, iXLen } @llvm.riscv.th.vleff.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x i16> %b
}

declare { <vscale x 8 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i16> @intrinsic_vleff_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8i16_nxv8i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8i16_nxv8i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x i16> %b
}

declare { <vscale x 16 x i16>, iXLen } @llvm.riscv.th.vleff.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen);

define <vscale x 16 x i16> @intrinsic_vleff_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv16i16_nxv16i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv16i16_nxv16i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x i16>, iXLen } @llvm.riscv.th.vleff.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 16 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 16 x i16> %b
}

declare { <vscale x 16 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i16> @intrinsic_vleff_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, <vscale x 16 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv16i16_nxv16i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv16i16_nxv16i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 16 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 16 x i16> %b
}

declare { <vscale x 32 x i16>, iXLen } @llvm.riscv.th.vleff.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen);

define <vscale x 32 x i16> @intrinsic_vleff_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv32i16_nxv32i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv32i16_nxv32i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 32 x i16>, iXLen } @llvm.riscv.th.vleff.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 32 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 32 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 32 x i16> %b
}

declare { <vscale x 32 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x i16> @intrinsic_vleff_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, <vscale x 32 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv32i16_nxv32i16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv32i16_nxv32i16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 32 x i16>, iXLen } @llvm.riscv.th.vleff.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 32 x i16>, iXLen } %a, 0
  %c = extractvalue { <vscale x 32 x i16>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 32 x i16> %b
}

declare { <vscale x 4 x half>, iXLen } @llvm.riscv.th.vleff.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  iXLen);

define <vscale x 4 x half> @intrinsic_vleff_v_nxv4f16_nxv4f16(<vscale x 4 x half>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv4f16_nxv4f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv4f16_nxv4f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x half>, iXLen } @llvm.riscv.th.vleff.nxv4f16.nxv4f16(
    <vscale x 4 x half> undef,
    <vscale x 4 x half>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 4 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 4 x half> %b
}

declare { <vscale x 4 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x half> @intrinsic_vleff_mask_v_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half>* %1, <vscale x 4 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv4f16_nxv4f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv4f16_nxv4f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv4f16.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 4 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 4 x half> %b
}

declare { <vscale x 8 x half>, iXLen } @llvm.riscv.th.vleff.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  iXLen);

define <vscale x 8 x half> @intrinsic_vleff_v_nxv8f16_nxv8f16(<vscale x 8 x half>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8f16_nxv8f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8f16_nxv8f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x half>, iXLen } @llvm.riscv.th.vleff.nxv8f16.nxv8f16(
    <vscale x 8 x half> undef,
    <vscale x 8 x half>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x half> %b
}

declare { <vscale x 8 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x half> @intrinsic_vleff_mask_v_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8f16_nxv8f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8f16_nxv8f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv8f16.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x half> %b
}

declare { <vscale x 16 x half>, iXLen } @llvm.riscv.th.vleff.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  iXLen);

define <vscale x 16 x half> @intrinsic_vleff_v_nxv16f16_nxv16f16(<vscale x 16 x half>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv16f16_nxv16f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv16f16_nxv16f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x half>, iXLen } @llvm.riscv.th.vleff.nxv16f16.nxv16f16(
    <vscale x 16 x half> undef,
    <vscale x 16 x half>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 16 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 16 x half> %b
}

declare { <vscale x 16 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x half> @intrinsic_vleff_mask_v_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half>* %1, <vscale x 16 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv16f16_nxv16f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv16f16_nxv16f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv16f16.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 16 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 16 x half> %b
}

declare { <vscale x 32 x half>, iXLen } @llvm.riscv.th.vleff.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  iXLen);

define <vscale x 32 x half> @intrinsic_vleff_v_nxv32f16_nxv32f16(<vscale x 32 x half>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv32f16_nxv32f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv32f16_nxv32f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 32 x half>, iXLen } @llvm.riscv.th.vleff.nxv32f16.nxv32f16(
    <vscale x 32 x half> undef,
    <vscale x 32 x half>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 32 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 32 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 32 x half> %b
}

declare { <vscale x 32 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 32 x half> @intrinsic_vleff_mask_v_nxv32f16_nxv32f16(<vscale x 32 x half> %0, <vscale x 32 x half>* %1, <vscale x 32 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv32f16_nxv32f16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv32f16_nxv32f16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e16, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 32 x half>, iXLen } @llvm.riscv.th.vleff.mask.nxv32f16.nxv32f16(
    <vscale x 32 x half> %0,
    <vscale x 32 x half>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 32 x half>, iXLen } %a, 0
  %c = extractvalue { <vscale x 32 x half>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 32 x half> %b
}

declare { <vscale x 2 x i32>, iXLen } @llvm.riscv.th.vleff.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vleff_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv2i32_nxv2i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv2i32_nxv2i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x i32>, iXLen } @llvm.riscv.th.vleff.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 2 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 2 x i32> %b
}

declare { <vscale x 2 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vleff_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, <vscale x 2 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv2i32_nxv2i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv2i32_nxv2i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 2 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 2 x i32> %b
}

declare { <vscale x 4 x i32>, iXLen } @llvm.riscv.th.vleff.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vleff_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv4i32_nxv4i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv4i32_nxv4i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x i32>, iXLen } @llvm.riscv.th.vleff.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 4 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 4 x i32> %b
}

declare { <vscale x 4 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i32> @intrinsic_vleff_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, <vscale x 4 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv4i32_nxv4i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv4i32_nxv4i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 4 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 4 x i32> %b
}

declare { <vscale x 8 x i32>, iXLen } @llvm.riscv.th.vleff.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vleff_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8i32_nxv8i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8i32_nxv8i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i32>, iXLen } @llvm.riscv.th.vleff.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x i32> %b
}

declare { <vscale x 8 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i32> @intrinsic_vleff_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8i32_nxv8i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8i32_nxv8i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x i32> %b
}

declare { <vscale x 16 x i32>, iXLen } @llvm.riscv.th.vleff.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vleff_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv16i32_nxv16i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv16i32_nxv16i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x i32>, iXLen } @llvm.riscv.th.vleff.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 16 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 16 x i32> %b
}

declare { <vscale x 16 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x i32> @intrinsic_vleff_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, <vscale x 16 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv16i32_nxv16i32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv16i32_nxv16i32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x i32>, iXLen } @llvm.riscv.th.vleff.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 16 x i32>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x i32>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 16 x i32> %b
}

declare { <vscale x 2 x float>, iXLen } @llvm.riscv.th.vleff.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  iXLen);

define <vscale x 2 x float> @intrinsic_vleff_v_nxv2f32_nxv2f32(<vscale x 2 x float>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv2f32_nxv2f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv2f32_nxv2f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x float>, iXLen } @llvm.riscv.th.vleff.nxv2f32.nxv2f32(
    <vscale x 2 x float> undef,
    <vscale x 2 x float>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 2 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 2 x float> %b
}

declare { <vscale x 2 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x float> @intrinsic_vleff_mask_v_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float>* %1, <vscale x 2 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv2f32_nxv2f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv2f32_nxv2f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv2f32.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 2 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 2 x float> %b
}

declare { <vscale x 4 x float>, iXLen } @llvm.riscv.th.vleff.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  iXLen);

define <vscale x 4 x float> @intrinsic_vleff_v_nxv4f32_nxv4f32(<vscale x 4 x float>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv4f32_nxv4f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv4f32_nxv4f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x float>, iXLen } @llvm.riscv.th.vleff.nxv4f32.nxv4f32(
    <vscale x 4 x float> undef,
    <vscale x 4 x float>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 4 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 4 x float> %b
}

declare { <vscale x 4 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x float> @intrinsic_vleff_mask_v_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float>* %1, <vscale x 4 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv4f32_nxv4f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv4f32_nxv4f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv4f32.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 4 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 4 x float> %b
}

declare { <vscale x 8 x float>, iXLen } @llvm.riscv.th.vleff.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  iXLen);

define <vscale x 8 x float> @intrinsic_vleff_v_nxv8f32_nxv8f32(<vscale x 8 x float>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8f32_nxv8f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8f32_nxv8f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x float>, iXLen } @llvm.riscv.th.vleff.nxv8f32.nxv8f32(
    <vscale x 8 x float> undef,
    <vscale x 8 x float>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x float> %b
}

declare { <vscale x 8 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x float> @intrinsic_vleff_mask_v_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8f32_nxv8f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8f32_nxv8f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv8f32.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x float> %b
}

declare { <vscale x 16 x float>, iXLen } @llvm.riscv.th.vleff.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  iXLen);

define <vscale x 16 x float> @intrinsic_vleff_v_nxv16f32_nxv16f32(<vscale x 16 x float>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv16f32_nxv16f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv16f32_nxv16f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x float>, iXLen } @llvm.riscv.th.vleff.nxv16f32.nxv16f32(
    <vscale x 16 x float> undef,
    <vscale x 16 x float>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 16 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 16 x float> %b
}

declare { <vscale x 16 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 16 x float> @intrinsic_vleff_mask_v_nxv16f32_nxv16f32(<vscale x 16 x float> %0, <vscale x 16 x float>* %1, <vscale x 16 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv16f32_nxv16f32:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv16f32_nxv16f32:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e32, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 16 x float>, iXLen } @llvm.riscv.th.vleff.mask.nxv16f32.nxv16f32(
    <vscale x 16 x float> %0,
    <vscale x 16 x float>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 16 x float>, iXLen } %a, 0
  %c = extractvalue { <vscale x 16 x float>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 16 x float> %b
}

declare { <vscale x 1 x i64>, iXLen } @llvm.riscv.th.vleff.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vleff_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv1i64_nxv1i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv1i64_nxv1i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 1 x i64>, iXLen } @llvm.riscv.th.vleff.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 1 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 1 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 1 x i64> %b
}

declare { <vscale x 1 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vleff_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv1i64_nxv1i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv1i64_nxv1i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 1 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 1 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 1 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 1 x i64> %b
}

declare { <vscale x 2 x i64>, iXLen } @llvm.riscv.th.vleff.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vleff_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv2i64_nxv2i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv2i64_nxv2i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x i64>, iXLen } @llvm.riscv.th.vleff.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 2 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 2 x i64> %b
}

declare { <vscale x 2 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i64> @intrinsic_vleff_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv2i64_nxv2i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv2i64_nxv2i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 2 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 2 x i64> %b
}

declare { <vscale x 4 x i64>, iXLen } @llvm.riscv.th.vleff.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vleff_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv4i64_nxv4i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv4i64_nxv4i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x i64>, iXLen } @llvm.riscv.th.vleff.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 4 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 4 x i64> %b
}

declare { <vscale x 4 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i64> @intrinsic_vleff_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv4i64_nxv4i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv4i64_nxv4i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 4 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 4 x i64> %b
}

declare { <vscale x 8 x i64>, iXLen } @llvm.riscv.th.vleff.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vleff_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8i64_nxv8i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8i64_nxv8i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i64>, iXLen } @llvm.riscv.th.vleff.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x i64> %b
}

declare { <vscale x 8 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i64> @intrinsic_vleff_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8i64_nxv8i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8i64_nxv8i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x i64>, iXLen } @llvm.riscv.th.vleff.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x i64>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x i64>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x i64> %b
}

declare { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  iXLen);

define <vscale x 1 x double> @intrinsic_vleff_v_nxv1f64_nxv1f64(<vscale x 1 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv1f64_nxv1f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv1f64_nxv1f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 1 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 1 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 1 x double> %b
}

declare { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x double> @intrinsic_vleff_mask_v_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv1f64_nxv1f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv1f64_nxv1f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 1 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 1 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 1 x double> %b
}

declare { <vscale x 2 x double>, iXLen } @llvm.riscv.th.vleff.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  iXLen);

define <vscale x 2 x double> @intrinsic_vleff_v_nxv2f64_nxv2f64(<vscale x 2 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv2f64_nxv2f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv2f64_nxv2f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x double>, iXLen } @llvm.riscv.th.vleff.nxv2f64.nxv2f64(
    <vscale x 2 x double> undef,
    <vscale x 2 x double>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 2 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 2 x double> %b
}

declare { <vscale x 2 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x double> @intrinsic_vleff_mask_v_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double>* %1, <vscale x 2 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv2f64_nxv2f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv2f64_nxv2f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m2, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 2 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 2 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 2 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 2 x double> %b
}

declare { <vscale x 4 x double>, iXLen } @llvm.riscv.th.vleff.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  iXLen);

define <vscale x 4 x double> @intrinsic_vleff_v_nxv4f64_nxv4f64(<vscale x 4 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv4f64_nxv4f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv4f64_nxv4f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x double>, iXLen } @llvm.riscv.th.vleff.nxv4f64.nxv4f64(
    <vscale x 4 x double> undef,
    <vscale x 4 x double>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 4 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 4 x double> %b
}

declare { <vscale x 4 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x double> @intrinsic_vleff_mask_v_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double>* %1, <vscale x 4 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv4f64_nxv4f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv4f64_nxv4f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m4, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 4 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 4 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 4 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 4 x double> %b
}

declare { <vscale x 8 x double>, iXLen } @llvm.riscv.th.vleff.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  iXLen);

define <vscale x 8 x double> @intrinsic_vleff_v_nxv8f64_nxv8f64(<vscale x 8 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_v_nxv8f64_nxv8f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_v_nxv8f64_nxv8f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x double>, iXLen } @llvm.riscv.th.vleff.nxv8f64.nxv8f64(
    <vscale x 8 x double> undef,
    <vscale x 8 x double>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 8 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %2

  ret <vscale x 8 x double> %b
}

declare { <vscale x 8 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x double> @intrinsic_vleff_mask_v_nxv8f64_nxv8f64(<vscale x 8 x double> %0, <vscale x 8 x double>* %1, <vscale x 8 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_v_nxv8f64_nxv8f64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_v_nxv8f64_nxv8f64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m8, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 8 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv8f64.nxv8f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 8 x double>, iXLen } %a, 0
  %c = extractvalue { <vscale x 8 x double>, iXLen } %a, 1
  store iXLen %c, iXLen* %4

  ret <vscale x 8 x double> %b
}

; Test with the VL output unused
define <vscale x 1 x double> @intrinsic_vleff_dead_vl(<vscale x 1 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; CHECK-LABEL: intrinsic_vleff_dead_vl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vleff.v v8, (a0)
; CHECK-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 1 x double>, iXLen } %a, 0
  ret <vscale x 1 x double> %b
}

define <vscale x 1 x double> @intrinsic_vleff_mask_dead_vl(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vleff_mask_dead_vl:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vleff.v v8, (a0), v0.t
; CHECK-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 1 x double>, iXLen } %a, 0

  ret <vscale x 1 x double> %b
}

; Test with the loaded value unused
define void @intrinsic_vleff_dead_value(<vscale x 1 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; RV32-LABEL: intrinsic_vleff_dead_value:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV32-NEXT:    vleff.v v8, (a0)
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_dead_value:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV64-NEXT:    vleff.v v8, (a0)
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    iXLen %1)
  %b = extractvalue { <vscale x 1 x double>, iXLen } %a, 1
  store iXLen %b, iXLen* %2
  ret void
}

define void @intrinsic_vleff_mask_dead_value(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x i1> %2, iXLen %3, iXLen* %4) nounwind {
; RV32-LABEL: intrinsic_vleff_mask_dead_value:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV32-NEXT:    vleff.v v8, (a0), v0.t
; RV32-NEXT:    csrr a0, vl
; RV32-NEXT:    sw a0, 0(a2)
; RV32-NEXT:    ret
;
; RV64-LABEL: intrinsic_vleff_mask_dead_value:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli zero, a1, e64, m1, d1
; RV64-NEXT:    vleff.v v8, (a0), v0.t
; RV64-NEXT:    csrr a0, vl
; RV64-NEXT:    sd a0, 0(a2)
; RV64-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)
  %b = extractvalue { <vscale x 1 x double>, iXLen } %a, 1
  store iXLen %b, iXLen* %4

  ret void
}

; Test with both outputs dead. Make sure the vleff isn't deleted.
define void @intrinsic_vleff_dead_all(<vscale x 1 x double>* %0, iXLen %1, iXLen* %2) nounwind {
; CHECK-LABEL: intrinsic_vleff_dead_all:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vleff.v v8, (a0)
; CHECK-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    iXLen %1)
  ret void
}

define void @intrinsic_vleff_mask_dead_all(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vleff_mask_dead_all:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vleff.v v8, (a0), v0.t
; CHECK-NEXT:    ret
entry:
  %a = call { <vscale x 1 x double>, iXLen } @llvm.riscv.th.vleff.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret void
}
