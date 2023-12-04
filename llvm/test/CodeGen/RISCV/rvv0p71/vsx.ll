; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+xtheadvector \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK,CHECK-LABEL,CHECK-NEXT

declare void @llvm.riscv.th.vsxb.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i8>,
  iXLen);

define void @intrinsic_xvsxb_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, <vscale x 8 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    <vscale x 8 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxb.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxb_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    <vscale x 8 x i8> %2, 
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxb.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i8>,
  iXLen);

define void @intrinsic_xvsxb_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, <vscale x 16 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    <vscale x 16 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxb.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxb_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, <vscale x 16 x i8> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    <vscale x 16 x i8> %2, 
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxb.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i8>,
  iXLen);

define void @intrinsic_xvsxb_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, <vscale x 32 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    <vscale x 32 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxb.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsxb_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, <vscale x 32 x i8> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    <vscale x 32 x i8> %2, 
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxb.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i8>,
  iXLen);

define void @intrinsic_xvsxb_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, <vscale x 64 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    <vscale x 64 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxb.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i8>,
  <vscale x 64 x i1>,
  iXLen);

define void @intrinsic_xvsxb_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, <vscale x 64 x i8> %2, <vscale x 64 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxb_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    th.vsxb.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxb.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    <vscale x 64 x i8> %2, 
    <vscale x 64 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxh.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i16>,
  iXLen);

define void @intrinsic_xvsxh_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, <vscale x 4 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    <vscale x 4 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxh.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsxh_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, <vscale x 4 x i16> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    <vscale x 4 x i16> %2, 
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxh.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i16>,
  iXLen);

define void @intrinsic_xvsxh_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, <vscale x 8 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    <vscale x 8 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxh.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxh_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, <vscale x 8 x i16> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    <vscale x 8 x i16> %2, 
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxh.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i16>,
  iXLen);

define void @intrinsic_xvsxh_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, <vscale x 16 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    <vscale x 16 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxh.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i16>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxh_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, <vscale x 16 x i16> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    <vscale x 16 x i16> %2, 
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxh.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i16>,
  iXLen);

define void @intrinsic_xvsxh_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, <vscale x 32 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    <vscale x 32 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxh.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i16>,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsxh_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, <vscale x 32 x i16> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxh_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    th.vsxh.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxh.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    <vscale x 32 x i16> %2, 
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxw.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  iXLen);

define void @intrinsic_xvsxw_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, <vscale x 2 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    <vscale x 2 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxw.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvsxw_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    <vscale x 2 x i32> %2, 
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxw.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  iXLen);

define void @intrinsic_xvsxw_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, <vscale x 4 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    <vscale x 4 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxw.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsxw_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    <vscale x 4 x i32> %2, 
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxw.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  iXLen);

define void @intrinsic_xvsxw_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, <vscale x 8 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    <vscale x 8 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxw.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxw_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    <vscale x 8 x i32> %2, 
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxw.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  iXLen);

define void @intrinsic_xvsxw_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, <vscale x 16 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    <vscale x 16 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxw.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxw_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, <vscale x 16 x i32> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxw_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vsxw.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxw.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    <vscale x 16 x i32> %2, 
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i8>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv8i8_nxv8i8(<vscale x 8 x i8>* %0, <vscale x 8 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv8i8.nxv8i8(
    <vscale x 8 x i8> undef,
    <vscale x 8 x i8>* %0,
    <vscale x 8 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>*,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8>* %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8i8_nxv8i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8>* %1,
    <vscale x 8 x i8> %2, 
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i8>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv16i8_nxv16i8(<vscale x 16 x i8>* %0, <vscale x 16 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv16i8.nxv16i8(
    <vscale x 16 x i8> undef,
    <vscale x 16 x i8>* %0,
    <vscale x 16 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv16i8.nxv16i8(
  <vscale x 16 x i8>,
  <vscale x 16 x i8>*,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv16i8_nxv16i8(<vscale x 16 x i8> %0, <vscale x 16 x i8>* %1, <vscale x 16 x i8> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv16i8_nxv16i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv16i8.nxv16i8(
    <vscale x 16 x i8> %0,
    <vscale x 16 x i8>* %1,
    <vscale x 16 x i8> %2, 
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i8>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv32i8_nxv32i8(<vscale x 32 x i8>* %0, <vscale x 32 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv32i8.nxv32i8(
    <vscale x 32 x i8> undef,
    <vscale x 32 x i8>* %0,
    <vscale x 32 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv32i8.nxv32i8(
  <vscale x 32 x i8>,
  <vscale x 32 x i8>*,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv32i8_nxv32i8(<vscale x 32 x i8> %0, <vscale x 32 x i8>* %1, <vscale x 32 x i8> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv32i8_nxv32i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv32i8.nxv32i8(
    <vscale x 32 x i8> %0,
    <vscale x 32 x i8>* %1,
    <vscale x 32 x i8> %2, 
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i8>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv64i8_nxv64i8(<vscale x 64 x i8>* %0, <vscale x 64 x i8> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv64i8.nxv64i8(
    <vscale x 64 x i8> undef,
    <vscale x 64 x i8>* %0,
    <vscale x 64 x i8> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv64i8.nxv64i8(
  <vscale x 64 x i8>,
  <vscale x 64 x i8>*,
  <vscale x 64 x i8>,
  <vscale x 64 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv64i8_nxv64i8(<vscale x 64 x i8> %0, <vscale x 64 x i8>* %1, <vscale x 64 x i8> %2, <vscale x 64 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv64i8_nxv64i8
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e8, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv64i8.nxv64i8(
    <vscale x 64 x i8> %0,
    <vscale x 64 x i8>* %1,
    <vscale x 64 x i8> %2, 
    <vscale x 64 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i16>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv4i16_nxv4i16(<vscale x 4 x i16>* %0, <vscale x 4 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv4i16.nxv4i16(
    <vscale x 4 x i16> undef,
    <vscale x 4 x i16>* %0,
    <vscale x 4 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>*,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16>* %1, <vscale x 4 x i16> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv4i16_nxv4i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16>* %1,
    <vscale x 4 x i16> %2, 
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  <vscale x 4 x half>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv4f16_nxv4f16(<vscale x 4 x half>* %0, <vscale x 4 x half> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv4f16_nxv4f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv4f16.nxv4f16(
    <vscale x 4 x half> undef,
    <vscale x 4 x half>* %0,
    <vscale x 4 x half> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv4f16.nxv4f16(
  <vscale x 4 x half>,
  <vscale x 4 x half>*,
  <vscale x 4 x half>,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv4f16_nxv4f16(<vscale x 4 x half> %0, <vscale x 4 x half>* %1, <vscale x 4 x half> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv4f16_nxv4f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv4f16.nxv4f16(
    <vscale x 4 x half> %0,
    <vscale x 4 x half>* %1,
    <vscale x 4 x half> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i16>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv8i16_nxv8i16(<vscale x 8 x i16>* %0, <vscale x 8 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv8i16.nxv8i16(
    <vscale x 8 x i16> undef,
    <vscale x 8 x i16>* %0,
    <vscale x 8 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv8i16.nxv8i16(
  <vscale x 8 x i16>,
  <vscale x 8 x i16>*,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv8i16_nxv8i16(<vscale x 8 x i16> %0, <vscale x 8 x i16>* %1, <vscale x 8 x i16> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8i16_nxv8i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv8i16.nxv8i16(
    <vscale x 8 x i16> %0,
    <vscale x 8 x i16>* %1,
    <vscale x 8 x i16> %2, 
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  <vscale x 8 x half>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv8f16_nxv8f16(<vscale x 8 x half>* %0, <vscale x 8 x half> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8f16_nxv8f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv8f16.nxv8f16(
    <vscale x 8 x half> undef,
    <vscale x 8 x half>* %0,
    <vscale x 8 x half> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv8f16.nxv8f16(
  <vscale x 8 x half>,
  <vscale x 8 x half>*,
  <vscale x 8 x half>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv8f16_nxv8f16(<vscale x 8 x half> %0, <vscale x 8 x half>* %1, <vscale x 8 x half> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8f16_nxv8f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv8f16.nxv8f16(
    <vscale x 8 x half> %0,
    <vscale x 8 x half>* %1,
    <vscale x 8 x half> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i16>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv16i16_nxv16i16(<vscale x 16 x i16>* %0, <vscale x 16 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv16i16.nxv16i16(
    <vscale x 16 x i16> undef,
    <vscale x 16 x i16>* %0,
    <vscale x 16 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv16i16.nxv16i16(
  <vscale x 16 x i16>,
  <vscale x 16 x i16>*,
  <vscale x 16 x i16>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv16i16_nxv16i16(<vscale x 16 x i16> %0, <vscale x 16 x i16>* %1, <vscale x 16 x i16> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv16i16_nxv16i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv16i16.nxv16i16(
    <vscale x 16 x i16> %0,
    <vscale x 16 x i16>* %1,
    <vscale x 16 x i16> %2, 
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  <vscale x 16 x half>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv16f16_nxv16f16(<vscale x 16 x half>* %0, <vscale x 16 x half> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv16f16_nxv16f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv16f16.nxv16f16(
    <vscale x 16 x half> undef,
    <vscale x 16 x half>* %0,
    <vscale x 16 x half> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv16f16.nxv16f16(
  <vscale x 16 x half>,
  <vscale x 16 x half>*,
  <vscale x 16 x half>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv16f16_nxv16f16(<vscale x 16 x half> %0, <vscale x 16 x half>* %1, <vscale x 16 x half> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv16f16_nxv16f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv16f16.nxv16f16(
    <vscale x 16 x half> %0,
    <vscale x 16 x half>* %1,
    <vscale x 16 x half> %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i16>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv32i16_nxv32i16(<vscale x 32 x i16>* %0, <vscale x 32 x i16> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv32i16.nxv32i16(
    <vscale x 32 x i16> undef,
    <vscale x 32 x i16>* %0,
    <vscale x 32 x i16> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv32i16.nxv32i16(
  <vscale x 32 x i16>,
  <vscale x 32 x i16>*,
  <vscale x 32 x i16>,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv32i16_nxv32i16(<vscale x 32 x i16> %0, <vscale x 32 x i16>* %1, <vscale x 32 x i16> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv32i16_nxv32i16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv32i16.nxv32i16(
    <vscale x 32 x i16> %0,
    <vscale x 32 x i16>* %1,
    <vscale x 32 x i16> %2, 
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  <vscale x 32 x half>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv32f16_nxv32f16(<vscale x 32 x half>* %0, <vscale x 32 x half> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv32f16_nxv32f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv32f16.nxv32f16(
    <vscale x 32 x half> undef,
    <vscale x 32 x half>* %0,
    <vscale x 32 x half> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv32f16.nxv32f16(
  <vscale x 32 x half>,
  <vscale x 32 x half>*,
  <vscale x 32 x half>,
  <vscale x 32 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv32f16_nxv32f16(<vscale x 32 x half> %0, <vscale x 32 x half>* %1, <vscale x 32 x half> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv32f16_nxv32f16
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e16, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv32f16.nxv32f16(
    <vscale x 32 x half> %0,
    <vscale x 32 x half>* %1,
    <vscale x 32 x half> %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv2i32_nxv2i32(<vscale x 2 x i32>* %0, <vscale x 2 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv2i32.nxv2i32(
    <vscale x 2 x i32> undef,
    <vscale x 2 x i32>* %0,
    <vscale x 2 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>*,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32>* %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv2i32_nxv2i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32>* %1,
    <vscale x 2 x i32> %2, 
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  <vscale x 2 x float>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv2f32_nxv2f32(<vscale x 2 x float>* %0, <vscale x 2 x float> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv2f32_nxv2f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv2f32.nxv2f32(
    <vscale x 2 x float> undef,
    <vscale x 2 x float>* %0,
    <vscale x 2 x float> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv2f32.nxv2f32(
  <vscale x 2 x float>,
  <vscale x 2 x float>*,
  <vscale x 2 x float>,
  <vscale x 2 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv2f32_nxv2f32(<vscale x 2 x float> %0, <vscale x 2 x float>* %1, <vscale x 2 x float> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv2f32_nxv2f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m1, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v9, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv2f32.nxv2f32(
    <vscale x 2 x float> %0,
    <vscale x 2 x float>* %1,
    <vscale x 2 x float> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv4i32_nxv4i32(<vscale x 4 x i32>* %0, <vscale x 4 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv4i32.nxv4i32(
    <vscale x 4 x i32> undef,
    <vscale x 4 x i32>* %0,
    <vscale x 4 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>*,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32>* %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv4i32_nxv4i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32>* %1,
    <vscale x 4 x i32> %2, 
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  <vscale x 4 x float>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv4f32_nxv4f32(<vscale x 4 x float>* %0, <vscale x 4 x float> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv4f32_nxv4f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv4f32.nxv4f32(
    <vscale x 4 x float> undef,
    <vscale x 4 x float>* %0,
    <vscale x 4 x float> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv4f32.nxv4f32(
  <vscale x 4 x float>,
  <vscale x 4 x float>*,
  <vscale x 4 x float>,
  <vscale x 4 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv4f32_nxv4f32(<vscale x 4 x float> %0, <vscale x 4 x float>* %1, <vscale x 4 x float> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv4f32_nxv4f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m2, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v10, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv4f32.nxv4f32(
    <vscale x 4 x float> %0,
    <vscale x 4 x float>* %1,
    <vscale x 4 x float> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv8i32_nxv8i32(<vscale x 8 x i32>* %0, <vscale x 8 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv8i32.nxv8i32(
    <vscale x 8 x i32> undef,
    <vscale x 8 x i32>* %0,
    <vscale x 8 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>*,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32>* %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8i32_nxv8i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32>* %1,
    <vscale x 8 x i32> %2, 
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  <vscale x 8 x float>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv8f32_nxv8f32(<vscale x 8 x float>* %0, <vscale x 8 x float> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv8f32_nxv8f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv8f32.nxv8f32(
    <vscale x 8 x float> undef,
    <vscale x 8 x float>* %0,
    <vscale x 8 x float> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv8f32.nxv8f32(
  <vscale x 8 x float>,
  <vscale x 8 x float>*,
  <vscale x 8 x float>,
  <vscale x 8 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv8f32_nxv8f32(<vscale x 8 x float> %0, <vscale x 8 x float>* %1, <vscale x 8 x float> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv8f32_nxv8f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m4, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v12, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv8f32.nxv8f32(
    <vscale x 8 x float> %0,
    <vscale x 8 x float>* %1,
    <vscale x 8 x float> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv16i32_nxv16i32(<vscale x 16 x i32>* %0, <vscale x 16 x i32> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv16i32.nxv16i32(
    <vscale x 16 x i32> undef,
    <vscale x 16 x i32>* %0,
    <vscale x 16 x i32> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>*,
  <vscale x 16 x i32>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32>* %1, <vscale x 16 x i32> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv16i32_nxv16i32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32>* %1,
    <vscale x 16 x i32> %2, 
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}

declare void @llvm.riscv.th.vsxe.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  <vscale x 16 x float>,
  iXLen);

define void @intrinsic_xvsxe_v_nxv16f32_nxv16f32(<vscale x 16 x float>* %0, <vscale x 16 x float> %1, iXLen %2) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_v_nxv16f32_nxv16f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v8
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.nxv16f32.nxv16f32(
    <vscale x 16 x float> undef,
    <vscale x 16 x float>* %0,
    <vscale x 16 x float> %1,
    iXLen %2)

  ret void
}

declare void @llvm.riscv.th.vsxe.mask.nxv16f32.nxv16f32(
  <vscale x 16 x float>,
  <vscale x 16 x float>*,
  <vscale x 16 x float>,
  <vscale x 16 x i1>,
  iXLen);

define void @intrinsic_xvsxe_mask_v_nxv16f32_nxv16f32(<vscale x 16 x float> %0, <vscale x 16 x float>* %1, <vscale x 16 x float> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_xvsxe_mask_v_nxv16f32_nxv16f32
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    th.vsetvli zero, a1, e32, m8, d1
; CHECK-NEXT:    th.vsxe.v v8, (a0), v16, v0.t
; CHECK-NEXT:    ret

entry:
  call void @llvm.riscv.th.vsxe.mask.nxv16f32.nxv16f32(
    <vscale x 16 x float> %0,
    <vscale x 16 x float>* %1,
    <vscale x 16 x float> %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret void
}
