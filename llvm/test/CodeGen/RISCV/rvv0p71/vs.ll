; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadv \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare void @llvm.riscv.xvsb.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen);

define void @intrinsic_xvsb_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsb_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    vsb.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsb.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsb_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsb_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    vsb.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsb.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen);

define void @intrinsic_xvsb_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsb_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    vsb.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsb.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsb_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsb_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    vsb.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsb.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen);

define void @intrinsic_xvsb_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsb_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    vsb.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsb.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsb_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsb_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    vsb.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsb.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen);

define void @intrinsic_xvsb_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsb_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    vsb.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsb.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i1>,
  iXLen);

define void @intrinsic_xvsb_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, <vscale x 64 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsb_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    vsb.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsb.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    <vscale x 64 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsh.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen);

define void @intrinsic_xvsh_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsh_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    vsh.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsh.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsh_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsh_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    vsh.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsh.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen);

define void @intrinsic_xvsh_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsh_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    vsh.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsh.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsh_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsh_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    vsh.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsh.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen);

define void @intrinsic_xvsh_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsh_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    vsh.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsh.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsh_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsh_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    vsh.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsh.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen);

define void @intrinsic_xvsh_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsh_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    vsh.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsh.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsh_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsh_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    vsh.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsh.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsw.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen);

define void @intrinsic_xvsw_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsw_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    vsw.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsw.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvsw_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsw_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    vsw.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsw.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen);

define void @intrinsic_xvsw_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsw_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    vsw.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsw.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsw_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsw_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    vsw.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsw.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen);

define void @intrinsic_xvsw_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsw_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    vsw.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsw.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsw_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsw_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    vsw.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvsw.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen);

define void @intrinsic_xvsw_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvsw_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    vsw.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvsw.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsw_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvsw_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    vsw.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvsw.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  iXLen);

define void @intrinsic_xvse_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  iXLen);

define void @intrinsic_xvse_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  iXLen);

define void @intrinsic_xvse_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, <vscale x 64 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    <vscale x 64 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  iXLen);

define void @intrinsic_xvse_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  iXLen);

define void @intrinsic_xvse_v_nxv4f16_nxv4f16(<vscale x 4 x half>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv4f16_nxv4f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv4f16.nxv4f16(
    <vscale x 4 x half> undef,
    <vscale x 4 x half>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv4f16_nxv4f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv4f16.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8f16_nxv8f16(<vscale x 8 x half>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8f16_nxv8f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8f16.nxv8f16(
    <vscale x 8 x half> undef,
    <vscale x 8 x half>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8f16_nxv8f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8f16.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  iXLen);

define void @intrinsic_xvse_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  iXLen);

define void @intrinsic_xvse_v_nxv16f16_nxv16f16(<vscale x 16 x half>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv16f16_nxv16f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv16f16.nxv16f16(
    <vscale x 16 x half> undef,
    <vscale x 16 x half>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv16f16_nxv16f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv16f16.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  iXLen);

define void @intrinsic_xvse_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  iXLen);

define void @intrinsic_xvse_v_nxv32f16_nxv32f16(<vscale x 32 x half>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv32f16_nxv32f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv32f16.nxv32f16(
    <vscale x 32 x half> undef,
    <vscale x 32 x half>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv32f16_nxv32f16(<vscale x 32 x half> %0, <vscale x 32 x half>* %1, <vscale x 32 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv32f16_nxv32f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv32f16.nxv32f16(
    <vscale x 32 x half> %0,
    <vscale x 32 x half>* %1,
    <vscale x 32 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  iXLen);

define void @intrinsic_xvse_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  iXLen);

define void @intrinsic_xvse_v_nxv2f32_nxv2f32(<vscale x 2 x float>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv2f32_nxv2f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv2f32.nxv2f32(
    <vscale x 2 x float> undef,
    <vscale x 2 x float>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float>* %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv2f32_nxv2f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv2f32.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  iXLen);

define void @intrinsic_xvse_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  iXLen);

define void @intrinsic_xvse_v_nxv4f32_nxv4f32(<vscale x 4 x float>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv4f32_nxv4f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv4f32.nxv4f32(
    <vscale x 4 x float> undef,
    <vscale x 4 x float>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv4f32_nxv4f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv4f32.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8f32_nxv8f32(<vscale x 8 x float>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8f32_nxv8f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8f32.nxv8f32(
    <vscale x 8 x float> undef,
    <vscale x 8 x float>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8f32_nxv8f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8f32.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  iXLen);

define void @intrinsic_xvse_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  iXLen);

define void @intrinsic_xvse_v_nxv16f32_nxv16f32(<vscale x 16 x float>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv16f32_nxv16f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv16f32.nxv16f32(
    <vscale x 16 x float> undef,
    <vscale x 16 x float>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv16f32_nxv16f32(<vscale x 16 x float> %0, <vscale x 16 x float>* %1, <vscale x 16 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv16f32_nxv16f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv16f32.nxv16f32(
    <vscale x 16 x float> %0,
    <vscale x 16 x float>* %1,
    <vscale x 16 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  iXLen);

define void @intrinsic_xvse_v_nxv1i64_nxv1i64(<vscale x 1 x i64>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv1i64.nxv1i64(
    <vscale x 1 x i64> undef,
    <vscale x 1 x i64>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>*,
  <vscale x 1 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64>* %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv1i64_nxv1i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  iXLen);

define void @intrinsic_xvse_v_nxv1f64_nxv1f64(<vscale x 1 x double>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv1f64.nxv1f64(
    <vscale x 1 x double> undef,
    <vscale x 1 x double>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv1f64.nxv1f64(
  <vscale x 1 x double>,
  <vscale x 1 x double>*,
  <vscale x 1 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv1f64_nxv1f64(<vscale x 1 x double> %0, <vscale x 1 x double>* %1, <vscale x 1 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv1f64_nxv1f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv1f64.nxv1f64(
    <vscale x 1 x double> %0,
    <vscale x 1 x double>* %1,
    <vscale x 1 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  iXLen);

define void @intrinsic_xvse_v_nxv2i64_nxv2i64(<vscale x 2 x i64>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv2i64.nxv2i64(
    <vscale x 2 x i64> undef,
    <vscale x 2 x i64>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv2i64.nxv2i64(
  <vscale x 2 x i64>,
  <vscale x 2 x i64>*,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv2i64_nxv2i64(<vscale x 2 x i64> %0, <vscale x 2 x i64>* %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv2i64_nxv2i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv2i64.nxv2i64(
    <vscale x 2 x i64> %0,
    <vscale x 2 x i64>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  iXLen);

define void @intrinsic_xvse_v_nxv2f64_nxv2f64(<vscale x 2 x double>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv2f64.nxv2f64(
    <vscale x 2 x double> undef,
    <vscale x 2 x double>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv2f64.nxv2f64(
  <vscale x 2 x double>,
  <vscale x 2 x double>*,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv2f64_nxv2f64(<vscale x 2 x double> %0, <vscale x 2 x double>* %1, <vscale x 2 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv2f64_nxv2f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv2f64.nxv2f64(
    <vscale x 2 x double> %0,
    <vscale x 2 x double>* %1,
    <vscale x 2 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  iXLen);

define void @intrinsic_xvse_v_nxv4i64_nxv4i64(<vscale x 4 x i64>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv4i64.nxv4i64(
    <vscale x 4 x i64> undef,
    <vscale x 4 x i64>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv4i64.nxv4i64(
  <vscale x 4 x i64>,
  <vscale x 4 x i64>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv4i64_nxv4i64(<vscale x 4 x i64> %0, <vscale x 4 x i64>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv4i64_nxv4i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv4i64.nxv4i64(
    <vscale x 4 x i64> %0,
    <vscale x 4 x i64>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  iXLen);

define void @intrinsic_xvse_v_nxv4f64_nxv4f64(<vscale x 4 x double>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv4f64.nxv4f64(
    <vscale x 4 x double> undef,
    <vscale x 4 x double>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv4f64.nxv4f64(
  <vscale x 4 x double>,
  <vscale x 4 x double>*,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv4f64_nxv4f64(<vscale x 4 x double> %0, <vscale x 4 x double>* %1, <vscale x 4 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv4f64_nxv4f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv4f64.nxv4f64(
    <vscale x 4 x double> %0,
    <vscale x 4 x double>* %1,
    <vscale x 4 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8i64_nxv8i64(<vscale x 8 x i64>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8i64.nxv8i64(
    <vscale x 8 x i64> undef,
    <vscale x 8 x i64>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8i64.nxv8i64(
  <vscale x 8 x i64>,
  <vscale x 8 x i64>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8i64_nxv8i64(<vscale x 8 x i64> %0, <vscale x 8 x i64>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8i64_nxv8i64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8i64.nxv8i64(
    <vscale x 8 x i64> %0,
    <vscale x 8 x i64>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

declare void @llvm.riscv.xvse.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  iXLen);

define void @intrinsic_xvse_v_nxv8f64_nxv8f64(<vscale x 8 x double>* %0, iXLen %1) nounwind {
; CHECK-LABEL: intrinsic_xvse_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vse.v v8, (a0)
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.nxv8f64.nxv8f64(
    <vscale x 8 x double> undef,
    <vscale x 8 x double>* %0,
    iXLen %1)

  ret void
}

declare void @llvm.riscv.xvse.mask.nxv8f64.nxv8f64(
  <vscale x 8 x double>,
  <vscale x 8 x double>*,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvse_mask_v_nxv8f64_nxv8f64(<vscale x 8 x double> %0, <vscale x 8 x double>* %1, <vscale x 8 x i1> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_xvse_mask_v_nxv8f64_nxv8f64
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, d1
; CHECK-NEXT:    vse.v v8, (a0), v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.xvse.mask.nxv8f64.nxv8f64(
    <vscale x 8 x double> %0,
    <vscale x 8 x double>* %1,
    <vscale x 8 x i1> %2,
    iXLen %3)

  ret void
}

