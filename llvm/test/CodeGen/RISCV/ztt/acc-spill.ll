; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs %s -o %t.32.s
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs %s -o %t.64.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV32 < %t.32.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.64.s
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs -stop-after=riscv-ztt-post-ra-expand-pseudo %s -o %t.mir
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs -start-after=riscv-ztt-post-ra-expand-pseudo %t.mir -o %t.roundtrip.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.roundtrip.s
; ACC values remain entirely inside the function; these are not ACC ABI tests.
declare void @clobber() nounwind

declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr, i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)
define void @acc_standard(ptr %p, ptr %q) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a4" {
  %m0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %p, i32 1073741856, i32 2)
  %a0 = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %m0, i32 1073741856, i32 2)
  %m1 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %q, i32 1073741856, i32 2)
  %a1 = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %m1, i32 1073741856, i32 2)
  call void @clobber()
  %r0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2) %a0, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 2) %r0, i32 1073741856, i32 2)
  %r1 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2) %a1, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 2) %r1, i32 1073741856, i32 2)
  ret void
}
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_standard 32 2 32
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_standard 32 2 32

define void @acc_wide(ptr %p, ptr %q) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" {
  %m0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %p, i32 1073741856, i32 2)
  %a0 = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %m0, i32 1073741856, i32 2)
  %m1 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %q, i32 1073741856, i32 2)
  %a1 = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %m1, i32 1073741856, i32 2)
  call void @clobber()
  %r0 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2) %a0, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 2) %r0, i32 1073741856, i32 2)
  %r1 = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2) %a1, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 2) %r1, i32 1073741856, i32 2)
  ret void
}
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_wide 32 2 8
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_wide 32 2 8

declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr, i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 4) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_4t.triscv.ztt.m.i16_i16_16_1_4t(target("riscv.ztt.m.i16", i16, 16, 1, 4), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.acc.i16_i16_16_4t(target("riscv.ztt.acc.i16", i16, 16, 4), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 4), i32, i32)
define void @acc_packed(ptr %p, ptr %q) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m16-a8" {
  %m0 = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %p, i32 1073741840, i32 4)
  %a0 = call target("riscv.ztt.acc.i16", i16, 16, 4) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_4t.triscv.ztt.m.i16_i16_16_1_4t(target("riscv.ztt.m.i16", i16, 16, 1, 4) %m0, i32 1073741840, i32 4)
  %m1 = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %q, i32 1073741840, i32 4)
  %a1 = call target("riscv.ztt.acc.i16", i16, 16, 4) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_4t.triscv.ztt.m.i16_i16_16_1_4t(target("riscv.ztt.m.i16", i16, 16, 1, 4) %m1, i32 1073741840, i32 4)
  call void @clobber()
  %r0 = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.acc.i16_i16_16_4t(target("riscv.ztt.acc.i16", i16, 16, 4) %a0, i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %q, target("riscv.ztt.m.i16", i16, 16, 1, 4) %r0, i32 1073741840, i32 4)
  %r1 = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.acc.i16_i16_16_4t(target("riscv.ztt.acc.i16", i16, 16, 4) %a1, i32 1073741840, i32 4)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_4t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 4) %r1, i32 1073741840, i32 4)
  ret void
}
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_packed 16 4 64
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_packed 16 4 64

declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr, i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 8), i32, i32)
define void @acc_uds128(ptr %p, ptr %q) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m16-a16" {
  %m0 = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %p, i32 1073741840, i32 8)
  %a0 = call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8) %m0, i32 1073741840, i32 8)
  %m1 = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %q, i32 1073741840, i32 8)
  %a1 = call target("riscv.ztt.acc.i16", i16, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8) %m1, i32 1073741840, i32 8)
  call void @clobber()
  %r0 = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8) %a0, i32 1073741840, i32 8)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %q, target("riscv.ztt.m.i16", i16, 16, 1, 8) %r0, i32 1073741840, i32 8)
  %r1 = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.acc.i16_i16_16_8t(target("riscv.ztt.acc.i16", i16, 16, 8) %a1, i32 1073741840, i32 8)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_8t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 8) %r1, i32 1073741840, i32 8)
  ret void
}
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_uds128 16 8 128
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_uds128 16 8 128

; All sixteen Ad entries and their packed payload must survive the call.
declare target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mls.rm.a16(ptr, i32, i32)
declare target("riscv.ztt.acc.i8", i8, 8, 16) @llvm.riscv.ztt.mcopy.m2a.a16(target("riscv.ztt.m.i8", i8, 8, 1, 16), i32, i32)
declare target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mcopy.a2m.a16(target("riscv.ztt.acc.i8", i8, 8, 16), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.a16(ptr, target("riscv.ztt.m.i8", i8, 8, 1, 16), i32, i32)
define void @acc16_packed(ptr %p, ptr %q) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m16-a16" {
  %m = call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mls.rm.a16(ptr %p, i32 1073741832, i32 16)
  %a = call target("riscv.ztt.acc.i8", i8, 8, 16) @llvm.riscv.ztt.mcopy.m2a.a16(target("riscv.ztt.m.i8", i8, 8, 1, 16) %m, i32 1073741832, i32 16)
  %n = call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mls.rm.a16(ptr %q, i32 1073741832, i32 16)
  %b = call target("riscv.ztt.acc.i8", i8, 8, 16) @llvm.riscv.ztt.mcopy.m2a.a16(target("riscv.ztt.m.i8", i8, 8, 1, 16) %n, i32 1073741832, i32 16)
  call void @clobber()
  %r = call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mcopy.a2m.a16(target("riscv.ztt.acc.i8", i8, 8, 16) %a, i32 1073741832, i32 16)
  call void @llvm.riscv.ztt.mss.rm.a16(ptr %q, target("riscv.ztt.m.i8", i8, 8, 1, 16) %r, i32 1073741832, i32 16)
  %s = call target("riscv.ztt.m.i8", i8, 8, 1, 16) @llvm.riscv.ztt.mcopy.a2m.a16(target("riscv.ztt.acc.i8", i8, 8, 16) %b, i32 1073741832, i32 16)
  call void @llvm.riscv.ztt.mss.rm.a16(ptr %p, target("riscv.ztt.m.i8", i8, 8, 1, 16) %s, i32 1073741832, i32 16)
  ret void
}
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc16_packed 8 16 128
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc16_packed 8 16 128

; RV32-LABEL: acc_standard:                           # @acc_standard
; RV32-NEXT: # %bb.0:
; RV32-NEXT: addi	sp, sp, -32
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: sw	a2, 8(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: csrr	a2, amenlen
; RV32-NEXT: mul	a1, a2, a2
; RV32-NEXT: slli	a1, a1, 2
; RV32-NEXT: li	a0, 0
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: addi	a0, a0, 15
; RV32-NEXT: andi	a0, a0, -16
; RV32-NEXT: addi	a0, a0, 64
; RV32-NEXT: mv	a4, sp
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 36(sp)
; RV32-NEXT: lw	a0, 0(a4)
; RV32-NEXT: lw	a1, 4(a4)
; RV32-NEXT: lw	a2, 8(a4)
; RV32-NEXT: lw	a3, 12(a4)
; RV32-NEXT: lw	a4, 16(a4)
; RV32-NEXT: addi	sp, sp, 32
; RV32-NEXT: addi	sp, sp, -128
; RV32-NEXT: sw	ra, 124(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 120(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 116(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 112(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 108(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s4, 104(sp)                     # 4-byte Folded Spill
; RV32-NEXT: lw	s4, 132(sp)
; RV32-NEXT: mv	s0, a0
; RV32-NEXT: csrr	a0, amenlen
; RV32-NEXT: mul	a0, a0, a0
; RV32-NEXT: lui	a2, 262144
; RV32-NEXT: slli	s2, a0, 2
; RV32-NEXT: addi	s3, a2, 32
; RV32-NEXT: mv	a0, s0
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: add	a0, a0, s2
; RV32-NEXT: msettyp	m1, s3
; RV32-NEXT: mls.rm	m1, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s3
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: asettyp	acc1, s3
; RV32-NEXT: mmov.a.m	acc1, m1
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: slli	a3, s4, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: add	a0, a0, s2
; RV32-NEXT: msettyp	m1, s3
; RV32-NEXT: mls.rm	m1, a0
; RV32-NEXT: asettyp	acc0, s3
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: asettyp	acc1, s3
; RV32-NEXT: mmov.a.m	acc1, m1
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 96
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: slli	a3, s4, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: slli	a3, s4, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: msettyp	m1, s3
; RV32-NEXT: mmov.m.a	m1, acc1
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: add	s1, s1, s2
; RV32-NEXT: mss.rm	m1, s1
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 96
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: slli	a3, s4, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: msettyp	m1, s3
; RV32-NEXT: mmov.m.a	m1, acc1
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: add	s0, s0, s2
; RV32-NEXT: mss.rm	m1, s0
; RV32-NEXT: lw	ra, 124(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 120(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 116(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 112(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 108(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s4, 104(sp)                     # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 128
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lw	a0, 16(sp)
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: ret
; RV32-NEXT: .Lfunc_end0:

; RV32-LABEL: acc_wide:                               # @acc_wide
; RV32-NEXT: # %bb.0:
; RV32-NEXT: addi	sp, sp, -32
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: sw	a2, 8(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: csrr	a2, amenlen
; RV32-NEXT: mul	a1, a2, a2
; RV32-NEXT: li	a0, 0
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: addi	a0, a0, 15
; RV32-NEXT: andi	a0, a0, -16
; RV32-NEXT: addi	a0, a0, 64
; RV32-NEXT: mv	a4, sp
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 36(sp)
; RV32-NEXT: lw	a0, 0(a4)
; RV32-NEXT: lw	a1, 4(a4)
; RV32-NEXT: lw	a2, 8(a4)
; RV32-NEXT: lw	a3, 12(a4)
; RV32-NEXT: lw	a4, 16(a4)
; RV32-NEXT: addi	sp, sp, 32
; RV32-NEXT: addi	sp, sp, -128
; RV32-NEXT: sw	ra, 124(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 120(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 116(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 112(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 108(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s4, 104(sp)                     # 4-byte Folded Spill
; RV32-NEXT: lw	s4, 132(sp)
; RV32-NEXT: mv	s0, a0
; RV32-NEXT: csrr	a0, amenlen
; RV32-NEXT: mul	a0, a0, a0
; RV32-NEXT: lui	a2, 262144
; RV32-NEXT: slli	s2, a0, 2
; RV32-NEXT: addi	s3, a2, 32
; RV32-NEXT: mv	a0, s0
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: add	a0, a0, s2
; RV32-NEXT: msettyp	m4, s3
; RV32-NEXT: mls.rm	m4, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s3
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: asettyp	acc1, s3
; RV32-NEXT: mmov.a.m	acc1, m4
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: add	a0, a0, s2
; RV32-NEXT: msettyp	m4, s3
; RV32-NEXT: mls.rm	m4, a0
; RV32-NEXT: asettyp	acc0, s3
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: asettyp	acc1, s3
; RV32-NEXT: mmov.a.m	acc1, m4
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 96
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 3
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: slli	a3, s4, 3
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: msettyp	m4, s3
; RV32-NEXT: mmov.m.a	m4, acc1
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: add	s1, s1, s2
; RV32-NEXT: mss.rm	m4, s1
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 96
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 3
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s4, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: slli	a3, s4, 3
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, s4
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s3
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: msettyp	m4, s3
; RV32-NEXT: mmov.m.a	m4, acc1
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: add	s0, s0, s2
; RV32-NEXT: mss.rm	m4, s0
; RV32-NEXT: lw	ra, 124(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 120(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 116(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 112(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 108(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s4, 104(sp)                     # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 128
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lw	a0, 16(sp)
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: ret
; RV32-NEXT: .Lfunc_end1:

; RV32-LABEL: acc_packed:                             # @acc_packed
; RV32-NEXT: # %bb.0:
; RV32-NEXT: addi	sp, sp, -32
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: sw	a2, 8(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: csrr	a2, amenlen
; RV32-NEXT: mul	a1, a2, a2
; RV32-NEXT: slli	a1, a1, 3
; RV32-NEXT: li	a0, 0
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: addi	a0, a0, 15
; RV32-NEXT: andi	a0, a0, -16
; RV32-NEXT: addi	a0, a0, 64
; RV32-NEXT: mv	a4, sp
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 36(sp)
; RV32-NEXT: lw	a0, 0(a4)
; RV32-NEXT: lw	a1, 4(a4)
; RV32-NEXT: lw	a2, 8(a4)
; RV32-NEXT: lw	a3, 12(a4)
; RV32-NEXT: lw	a4, 16(a4)
; RV32-NEXT: addi	sp, sp, 32
; RV32-NEXT: addi	sp, sp, -144
; RV32-NEXT: sw	ra, 140(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 136(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 132(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 128(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 124(sp)                     # 4-byte Folded Spill
; RV32-NEXT: lw	s3, 148(sp)
; RV32-NEXT: mv	s0, a0
; RV32-NEXT: lui	a0, 262144
; RV32-NEXT: addi	s2, a0, 16
; RV32-NEXT: mv	a0, s0
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: asettyp	acc2, s2
; RV32-NEXT: asettyp	acc3, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: agettyp	a4, acc2
; RV32-NEXT: sw	a4, 8(a1)
; RV32-NEXT: agettyp	a4, acc3
; RV32-NEXT: sw	a4, 12(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 160
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: asettyp	acc2, s2
; RV32-NEXT: asettyp	acc3, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 108
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: agettyp	a4, acc2
; RV32-NEXT: sw	a4, 8(a1)
; RV32-NEXT: agettyp	a4, acc3
; RV32-NEXT: sw	a4, 12(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 160
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 8(a1)
; RV32-NEXT: asettyp	acc2, a4
; RV32-NEXT: lw	a4, 12(a1)
; RV32-NEXT: asettyp	acc3, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 160
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 108
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 8(a1)
; RV32-NEXT: asettyp	acc2, a4
; RV32-NEXT: lw	a4, 12(a1)
; RV32-NEXT: asettyp	acc3, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 160
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: lw	ra, 140(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 136(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 132(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 128(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 124(sp)                     # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 144
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lw	a0, 16(sp)
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: ret
; RV32-NEXT: .Lfunc_end2:

; RV32-LABEL: acc_uds128:                             # @acc_uds128
; RV32-NEXT: # %bb.0:
; RV32-NEXT: addi	sp, sp, -32
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: sw	a2, 8(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: csrr	a2, amenlen
; RV32-NEXT: mul	a1, a2, a2
; RV32-NEXT: slli	a1, a1, 4
; RV32-NEXT: li	a0, 0
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: addi	a0, a0, 15
; RV32-NEXT: andi	a0, a0, -16
; RV32-NEXT: addi	a0, a0, 64
; RV32-NEXT: mv	a4, sp
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 36(sp)
; RV32-NEXT: lw	a0, 0(a4)
; RV32-NEXT: lw	a1, 4(a4)
; RV32-NEXT: lw	a2, 8(a4)
; RV32-NEXT: lw	a3, 12(a4)
; RV32-NEXT: lw	a4, 16(a4)
; RV32-NEXT: addi	sp, sp, 32
; RV32-NEXT: addi	sp, sp, -176
; RV32-NEXT: sw	ra, 172(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 168(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 164(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 160(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 156(sp)                     # 4-byte Folded Spill
; RV32-NEXT: lw	s3, 180(sp)
; RV32-NEXT: mv	s0, a0
; RV32-NEXT: lui	a0, 262144
; RV32-NEXT: addi	s2, a0, 16
; RV32-NEXT: mv	a0, s0
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: asettyp	acc2, s2
; RV32-NEXT: asettyp	acc3, s2
; RV32-NEXT: asettyp	acc4, s2
; RV32-NEXT: asettyp	acc5, s2
; RV32-NEXT: asettyp	acc6, s2
; RV32-NEXT: asettyp	acc7, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: agettyp	a4, acc2
; RV32-NEXT: sw	a4, 8(a1)
; RV32-NEXT: agettyp	a4, acc3
; RV32-NEXT: sw	a4, 12(a1)
; RV32-NEXT: agettyp	a4, acc4
; RV32-NEXT: sw	a4, 16(a1)
; RV32-NEXT: agettyp	a4, acc5
; RV32-NEXT: sw	a4, 20(a1)
; RV32-NEXT: agettyp	a4, acc6
; RV32-NEXT: sw	a4, 24(a1)
; RV32-NEXT: agettyp	a4, acc7
; RV32-NEXT: sw	a4, 28(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 192
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: asettyp	acc2, s2
; RV32-NEXT: asettyp	acc3, s2
; RV32-NEXT: asettyp	acc4, s2
; RV32-NEXT: asettyp	acc5, s2
; RV32-NEXT: asettyp	acc6, s2
; RV32-NEXT: asettyp	acc7, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 124
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: agettyp	a4, acc2
; RV32-NEXT: sw	a4, 8(a1)
; RV32-NEXT: agettyp	a4, acc3
; RV32-NEXT: sw	a4, 12(a1)
; RV32-NEXT: agettyp	a4, acc4
; RV32-NEXT: sw	a4, 16(a1)
; RV32-NEXT: agettyp	a4, acc5
; RV32-NEXT: sw	a4, 20(a1)
; RV32-NEXT: agettyp	a4, acc6
; RV32-NEXT: sw	a4, 24(a1)
; RV32-NEXT: agettyp	a4, acc7
; RV32-NEXT: sw	a4, 28(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 192
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 8(a1)
; RV32-NEXT: asettyp	acc2, a4
; RV32-NEXT: lw	a4, 12(a1)
; RV32-NEXT: asettyp	acc3, a4
; RV32-NEXT: lw	a4, 16(a1)
; RV32-NEXT: asettyp	acc4, a4
; RV32-NEXT: lw	a4, 20(a1)
; RV32-NEXT: asettyp	acc5, a4
; RV32-NEXT: lw	a4, 24(a1)
; RV32-NEXT: asettyp	acc6, a4
; RV32-NEXT: lw	a4, 28(a1)
; RV32-NEXT: asettyp	acc7, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 192
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 124
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 8(a1)
; RV32-NEXT: asettyp	acc2, a4
; RV32-NEXT: lw	a4, 12(a1)
; RV32-NEXT: asettyp	acc3, a4
; RV32-NEXT: lw	a4, 16(a1)
; RV32-NEXT: asettyp	acc4, a4
; RV32-NEXT: lw	a4, 20(a1)
; RV32-NEXT: asettyp	acc5, a4
; RV32-NEXT: lw	a4, 24(a1)
; RV32-NEXT: asettyp	acc6, a4
; RV32-NEXT: lw	a4, 28(a1)
; RV32-NEXT: asettyp	acc7, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 192
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: lw	ra, 172(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 168(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 164(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 160(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 156(sp)                     # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 176
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lw	a0, 16(sp)
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: ret
; RV32-NEXT: .Lfunc_end3:

; RV64-LABEL: acc_standard:                           # @acc_standard
; RV64-NEXT: # %bb.0:
; RV64-NEXT: addi	sp, sp, -48
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 32(sp)
; RV64-NEXT: csrr	a2, amenlen
; RV64-NEXT: mul	a1, a2, a2
; RV64-NEXT: slli	a1, a1, 2
; RV64-NEXT: li	a0, 0
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: addi	a0, a0, 15
; RV64-NEXT: andi	a0, a0, -16
; RV64-NEXT: addi	a0, a0, 64
; RV64-NEXT: mv	a4, sp
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 56(sp)
; RV64-NEXT: ld	a0, 0(a4)
; RV64-NEXT: ld	a1, 8(a4)
; RV64-NEXT: ld	a2, 16(a4)
; RV64-NEXT: ld	a3, 24(a4)
; RV64-NEXT: ld	a4, 32(a4)
; RV64-NEXT: addi	sp, sp, 48
; RV64-NEXT: addi	sp, sp, -176
; RV64-NEXT: sd	ra, 168(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 160(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 152(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 144(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 136(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s4, 128(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	s4, 184(sp)
; RV64-NEXT: mv	s0, a0
; RV64-NEXT: csrr	a0, amenlen
; RV64-NEXT: mul	a0, a0, a0
; RV64-NEXT: lui	a2, 262144
; RV64-NEXT: slli	s2, a0, 2
; RV64-NEXT: addi	s3, a2, 32
; RV64-NEXT: mv	a0, s0
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: add	a0, a0, s2
; RV64-NEXT: msettyp	m1, s3
; RV64-NEXT: mls.rm	m1, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s3
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: asettyp	acc1, s3
; RV64-NEXT: mmov.a.m	acc1, m1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: slli	a3, s4, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: add	a0, a0, s2
; RV64-NEXT: msettyp	m1, s3
; RV64-NEXT: mls.rm	m1, a0
; RV64-NEXT: asettyp	acc0, s3
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: asettyp	acc1, s3
; RV64-NEXT: mmov.a.m	acc1, m1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: slli	a3, s4, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: slli	a3, s4, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: msettyp	m1, s3
; RV64-NEXT: mmov.m.a	m1, acc1
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: add	s1, s1, s2
; RV64-NEXT: mss.rm	m1, s1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: slli	a3, s4, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: msettyp	m1, s3
; RV64-NEXT: mmov.m.a	m1, acc1
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: add	s0, s0, s2
; RV64-NEXT: mss.rm	m1, s0
; RV64-NEXT: ld	ra, 168(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 160(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 152(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 144(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 136(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s4, 128(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 176
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: ld	a0, 16(sp)
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ret
; RV64-NEXT: .Lfunc_end0:

; RV64-LABEL: acc_wide:                               # @acc_wide
; RV64-NEXT: # %bb.0:
; RV64-NEXT: addi	sp, sp, -48
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 32(sp)
; RV64-NEXT: csrr	a2, amenlen
; RV64-NEXT: mul	a1, a2, a2
; RV64-NEXT: li	a0, 0
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: addi	a0, a0, 15
; RV64-NEXT: andi	a0, a0, -16
; RV64-NEXT: addi	a0, a0, 64
; RV64-NEXT: mv	a4, sp
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 56(sp)
; RV64-NEXT: ld	a0, 0(a4)
; RV64-NEXT: ld	a1, 8(a4)
; RV64-NEXT: ld	a2, 16(a4)
; RV64-NEXT: ld	a3, 24(a4)
; RV64-NEXT: ld	a4, 32(a4)
; RV64-NEXT: addi	sp, sp, 48
; RV64-NEXT: addi	sp, sp, -176
; RV64-NEXT: sd	ra, 168(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 160(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 152(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 144(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 136(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s4, 128(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	s4, 184(sp)
; RV64-NEXT: mv	s0, a0
; RV64-NEXT: csrr	a0, amenlen
; RV64-NEXT: mul	a0, a0, a0
; RV64-NEXT: lui	a2, 262144
; RV64-NEXT: slli	s2, a0, 2
; RV64-NEXT: addi	s3, a2, 32
; RV64-NEXT: mv	a0, s0
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: add	a0, a0, s2
; RV64-NEXT: msettyp	m4, s3
; RV64-NEXT: mls.rm	m4, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s3
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: asettyp	acc1, s3
; RV64-NEXT: mmov.a.m	acc1, m4
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: add	a0, a0, s2
; RV64-NEXT: msettyp	m4, s3
; RV64-NEXT: mls.rm	m4, a0
; RV64-NEXT: asettyp	acc0, s3
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: asettyp	acc1, s3
; RV64-NEXT: mmov.a.m	acc1, m4
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 3
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: slli	a3, s4, 3
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: msettyp	m4, s3
; RV64-NEXT: mmov.m.a	m4, acc1
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: add	s1, s1, s2
; RV64-NEXT: mss.rm	m4, s1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 3
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s4, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: slli	a3, s4, 3
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s4
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s3
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: msettyp	m4, s3
; RV64-NEXT: mmov.m.a	m4, acc1
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: add	s0, s0, s2
; RV64-NEXT: mss.rm	m4, s0
; RV64-NEXT: ld	ra, 168(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 160(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 152(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 144(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 136(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s4, 128(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 176
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: ld	a0, 16(sp)
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ret
; RV64-NEXT: .Lfunc_end1:

; RV64-LABEL: acc_packed:                             # @acc_packed
; RV64-NEXT: # %bb.0:
; RV64-NEXT: addi	sp, sp, -48
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 32(sp)
; RV64-NEXT: csrr	a2, amenlen
; RV64-NEXT: mul	a1, a2, a2
; RV64-NEXT: slli	a1, a1, 3
; RV64-NEXT: li	a0, 0
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: addi	a0, a0, 15
; RV64-NEXT: andi	a0, a0, -16
; RV64-NEXT: addi	a0, a0, 64
; RV64-NEXT: mv	a4, sp
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 56(sp)
; RV64-NEXT: ld	a0, 0(a4)
; RV64-NEXT: ld	a1, 8(a4)
; RV64-NEXT: ld	a2, 16(a4)
; RV64-NEXT: ld	a3, 24(a4)
; RV64-NEXT: ld	a4, 32(a4)
; RV64-NEXT: addi	sp, sp, 48
; RV64-NEXT: addi	sp, sp, -176
; RV64-NEXT: sd	ra, 168(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 160(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 152(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 144(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 136(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	s3, 184(sp)
; RV64-NEXT: mv	s0, a0
; RV64-NEXT: lui	a0, 262144
; RV64-NEXT: addi	s2, a0, 16
; RV64-NEXT: mv	a0, s0
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: asettyp	acc2, s2
; RV64-NEXT: asettyp	acc3, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: agettyp	a4, acc2
; RV64-NEXT: sw	a4, 8(a1)
; RV64-NEXT: agettyp	a4, acc3
; RV64-NEXT: sw	a4, 12(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: asettyp	acc2, s2
; RV64-NEXT: asettyp	acc3, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: agettyp	a4, acc2
; RV64-NEXT: sw	a4, 8(a1)
; RV64-NEXT: agettyp	a4, acc3
; RV64-NEXT: sw	a4, 12(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 8(a1)
; RV64-NEXT: asettyp	acc2, a4
; RV64-NEXT: lw	a4, 12(a1)
; RV64-NEXT: asettyp	acc3, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 8(a1)
; RV64-NEXT: asettyp	acc2, a4
; RV64-NEXT: lw	a4, 12(a1)
; RV64-NEXT: asettyp	acc3, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 192
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: ld	ra, 168(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 160(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 152(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 144(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 136(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 176
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: ld	a0, 16(sp)
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ret
; RV64-NEXT: .Lfunc_end2:

; RV64-LABEL: acc_uds128:                             # @acc_uds128
; RV64-NEXT: # %bb.0:
; RV64-NEXT: addi	sp, sp, -48
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 32(sp)
; RV64-NEXT: csrr	a2, amenlen
; RV64-NEXT: mul	a1, a2, a2
; RV64-NEXT: slli	a1, a1, 4
; RV64-NEXT: li	a0, 0
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: addi	a0, a0, 15
; RV64-NEXT: andi	a0, a0, -16
; RV64-NEXT: addi	a0, a0, 64
; RV64-NEXT: mv	a4, sp
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 56(sp)
; RV64-NEXT: ld	a0, 0(a4)
; RV64-NEXT: ld	a1, 8(a4)
; RV64-NEXT: ld	a2, 16(a4)
; RV64-NEXT: ld	a3, 24(a4)
; RV64-NEXT: ld	a4, 32(a4)
; RV64-NEXT: addi	sp, sp, 48
; RV64-NEXT: addi	sp, sp, -208
; RV64-NEXT: sd	ra, 200(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 192(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 184(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 176(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 168(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	s3, 216(sp)
; RV64-NEXT: mv	s0, a0
; RV64-NEXT: lui	a0, 262144
; RV64-NEXT: addi	s2, a0, 16
; RV64-NEXT: mv	a0, s0
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: asettyp	acc2, s2
; RV64-NEXT: asettyp	acc3, s2
; RV64-NEXT: asettyp	acc4, s2
; RV64-NEXT: asettyp	acc5, s2
; RV64-NEXT: asettyp	acc6, s2
; RV64-NEXT: asettyp	acc7, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: agettyp	a4, acc2
; RV64-NEXT: sw	a4, 8(a1)
; RV64-NEXT: agettyp	a4, acc3
; RV64-NEXT: sw	a4, 12(a1)
; RV64-NEXT: agettyp	a4, acc4
; RV64-NEXT: sw	a4, 16(a1)
; RV64-NEXT: agettyp	a4, acc5
; RV64-NEXT: sw	a4, 20(a1)
; RV64-NEXT: agettyp	a4, acc6
; RV64-NEXT: sw	a4, 24(a1)
; RV64-NEXT: agettyp	a4, acc7
; RV64-NEXT: sw	a4, 28(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 224
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: asettyp	acc2, s2
; RV64-NEXT: asettyp	acc3, s2
; RV64-NEXT: asettyp	acc4, s2
; RV64-NEXT: asettyp	acc5, s2
; RV64-NEXT: asettyp	acc6, s2
; RV64-NEXT: asettyp	acc7, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 136
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: agettyp	a4, acc2
; RV64-NEXT: sw	a4, 8(a1)
; RV64-NEXT: agettyp	a4, acc3
; RV64-NEXT: sw	a4, 12(a1)
; RV64-NEXT: agettyp	a4, acc4
; RV64-NEXT: sw	a4, 16(a1)
; RV64-NEXT: agettyp	a4, acc5
; RV64-NEXT: sw	a4, 20(a1)
; RV64-NEXT: agettyp	a4, acc6
; RV64-NEXT: sw	a4, 24(a1)
; RV64-NEXT: agettyp	a4, acc7
; RV64-NEXT: sw	a4, 28(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 224
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 8(a1)
; RV64-NEXT: asettyp	acc2, a4
; RV64-NEXT: lw	a4, 12(a1)
; RV64-NEXT: asettyp	acc3, a4
; RV64-NEXT: lw	a4, 16(a1)
; RV64-NEXT: asettyp	acc4, a4
; RV64-NEXT: lw	a4, 20(a1)
; RV64-NEXT: asettyp	acc5, a4
; RV64-NEXT: lw	a4, 24(a1)
; RV64-NEXT: asettyp	acc6, a4
; RV64-NEXT: lw	a4, 28(a1)
; RV64-NEXT: asettyp	acc7, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 224
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 136
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 8(a1)
; RV64-NEXT: asettyp	acc2, a4
; RV64-NEXT: lw	a4, 12(a1)
; RV64-NEXT: asettyp	acc3, a4
; RV64-NEXT: lw	a4, 16(a1)
; RV64-NEXT: asettyp	acc4, a4
; RV64-NEXT: lw	a4, 20(a1)
; RV64-NEXT: asettyp	acc5, a4
; RV64-NEXT: lw	a4, 24(a1)
; RV64-NEXT: asettyp	acc6, a4
; RV64-NEXT: lw	a4, 28(a1)
; RV64-NEXT: asettyp	acc7, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 224
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: ld	ra, 200(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 192(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 184(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 176(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 168(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 208
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: ld	a0, 16(sp)
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ret
; RV64-NEXT: .Lfunc_end3:

; RV32-LABEL: acc16_packed:                           # @acc16_packed
; RV32-NEXT: # %bb.0:
; RV32-NEXT: addi	sp, sp, -32
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: sw	a2, 8(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: csrr	a2, amenlen
; RV32-NEXT: mul	a1, a2, a2
; RV32-NEXT: slli	a1, a1, 4
; RV32-NEXT: li	a0, 0
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: add	a0, a0, a1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: addi	a0, a0, 15
; RV32-NEXT: andi	a0, a0, -16
; RV32-NEXT: addi	a0, a0, 64
; RV32-NEXT: mv	a4, sp
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 36(sp)
; RV32-NEXT: lw	a0, 0(a4)
; RV32-NEXT: lw	a1, 4(a4)
; RV32-NEXT: lw	a2, 8(a4)
; RV32-NEXT: lw	a3, 12(a4)
; RV32-NEXT: lw	a4, 16(a4)
; RV32-NEXT: addi	sp, sp, 32
; RV32-NEXT: addi	sp, sp, -240
; RV32-NEXT: sw	ra, 236(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 232(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 228(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 224(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 220(sp)                     # 4-byte Folded Spill
; RV32-NEXT: lw	s3, 244(sp)
; RV32-NEXT: mv	s0, a0
; RV32-NEXT: lui	a0, 262144
; RV32-NEXT: addi	s2, a0, 8
; RV32-NEXT: mv	a0, s0
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: asettyp	acc2, s2
; RV32-NEXT: asettyp	acc3, s2
; RV32-NEXT: asettyp	acc4, s2
; RV32-NEXT: asettyp	acc5, s2
; RV32-NEXT: asettyp	acc6, s2
; RV32-NEXT: asettyp	acc7, s2
; RV32-NEXT: asettyp	acc8, s2
; RV32-NEXT: asettyp	acc9, s2
; RV32-NEXT: asettyp	acc10, s2
; RV32-NEXT: asettyp	acc11, s2
; RV32-NEXT: asettyp	acc12, s2
; RV32-NEXT: asettyp	acc13, s2
; RV32-NEXT: asettyp	acc14, s2
; RV32-NEXT: asettyp	acc15, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: agettyp	a4, acc2
; RV32-NEXT: sw	a4, 8(a1)
; RV32-NEXT: agettyp	a4, acc3
; RV32-NEXT: sw	a4, 12(a1)
; RV32-NEXT: agettyp	a4, acc4
; RV32-NEXT: sw	a4, 16(a1)
; RV32-NEXT: agettyp	a4, acc5
; RV32-NEXT: sw	a4, 20(a1)
; RV32-NEXT: agettyp	a4, acc6
; RV32-NEXT: sw	a4, 24(a1)
; RV32-NEXT: agettyp	a4, acc7
; RV32-NEXT: sw	a4, 28(a1)
; RV32-NEXT: agettyp	a4, acc8
; RV32-NEXT: sw	a4, 32(a1)
; RV32-NEXT: agettyp	a4, acc9
; RV32-NEXT: sw	a4, 36(a1)
; RV32-NEXT: agettyp	a4, acc10
; RV32-NEXT: sw	a4, 40(a1)
; RV32-NEXT: agettyp	a4, acc11
; RV32-NEXT: sw	a4, 44(a1)
; RV32-NEXT: agettyp	a4, acc12
; RV32-NEXT: sw	a4, 48(a1)
; RV32-NEXT: agettyp	a4, acc13
; RV32-NEXT: sw	a4, 52(a1)
; RV32-NEXT: agettyp	a4, acc14
; RV32-NEXT: sw	a4, 56(a1)
; RV32-NEXT: agettyp	a4, acc15
; RV32-NEXT: sw	a4, 60(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 256
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: asettyp	acc2, s2
; RV32-NEXT: asettyp	acc3, s2
; RV32-NEXT: asettyp	acc4, s2
; RV32-NEXT: asettyp	acc5, s2
; RV32-NEXT: asettyp	acc6, s2
; RV32-NEXT: asettyp	acc7, s2
; RV32-NEXT: asettyp	acc8, s2
; RV32-NEXT: asettyp	acc9, s2
; RV32-NEXT: asettyp	acc10, s2
; RV32-NEXT: asettyp	acc11, s2
; RV32-NEXT: asettyp	acc12, s2
; RV32-NEXT: asettyp	acc13, s2
; RV32-NEXT: asettyp	acc14, s2
; RV32-NEXT: asettyp	acc15, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 156
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: agettyp	a4, acc2
; RV32-NEXT: sw	a4, 8(a1)
; RV32-NEXT: agettyp	a4, acc3
; RV32-NEXT: sw	a4, 12(a1)
; RV32-NEXT: agettyp	a4, acc4
; RV32-NEXT: sw	a4, 16(a1)
; RV32-NEXT: agettyp	a4, acc5
; RV32-NEXT: sw	a4, 20(a1)
; RV32-NEXT: agettyp	a4, acc6
; RV32-NEXT: sw	a4, 24(a1)
; RV32-NEXT: agettyp	a4, acc7
; RV32-NEXT: sw	a4, 28(a1)
; RV32-NEXT: agettyp	a4, acc8
; RV32-NEXT: sw	a4, 32(a1)
; RV32-NEXT: agettyp	a4, acc9
; RV32-NEXT: sw	a4, 36(a1)
; RV32-NEXT: agettyp	a4, acc10
; RV32-NEXT: sw	a4, 40(a1)
; RV32-NEXT: agettyp	a4, acc11
; RV32-NEXT: sw	a4, 44(a1)
; RV32-NEXT: agettyp	a4, acc12
; RV32-NEXT: sw	a4, 48(a1)
; RV32-NEXT: agettyp	a4, acc13
; RV32-NEXT: sw	a4, 52(a1)
; RV32-NEXT: agettyp	a4, acc14
; RV32-NEXT: sw	a4, 56(a1)
; RV32-NEXT: agettyp	a4, acc15
; RV32-NEXT: sw	a4, 60(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 256
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 8(a1)
; RV32-NEXT: asettyp	acc2, a4
; RV32-NEXT: lw	a4, 12(a1)
; RV32-NEXT: asettyp	acc3, a4
; RV32-NEXT: lw	a4, 16(a1)
; RV32-NEXT: asettyp	acc4, a4
; RV32-NEXT: lw	a4, 20(a1)
; RV32-NEXT: asettyp	acc5, a4
; RV32-NEXT: lw	a4, 24(a1)
; RV32-NEXT: asettyp	acc6, a4
; RV32-NEXT: lw	a4, 28(a1)
; RV32-NEXT: asettyp	acc7, a4
; RV32-NEXT: lw	a4, 32(a1)
; RV32-NEXT: asettyp	acc8, a4
; RV32-NEXT: lw	a4, 36(a1)
; RV32-NEXT: asettyp	acc9, a4
; RV32-NEXT: lw	a4, 40(a1)
; RV32-NEXT: asettyp	acc10, a4
; RV32-NEXT: lw	a4, 44(a1)
; RV32-NEXT: asettyp	acc11, a4
; RV32-NEXT: lw	a4, 48(a1)
; RV32-NEXT: asettyp	acc12, a4
; RV32-NEXT: lw	a4, 52(a1)
; RV32-NEXT: asettyp	acc13, a4
; RV32-NEXT: lw	a4, 56(a1)
; RV32-NEXT: asettyp	acc14, a4
; RV32-NEXT: lw	a4, 60(a1)
; RV32-NEXT: asettyp	acc15, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 256
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 156
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 8(a1)
; RV32-NEXT: asettyp	acc2, a4
; RV32-NEXT: lw	a4, 12(a1)
; RV32-NEXT: asettyp	acc3, a4
; RV32-NEXT: lw	a4, 16(a1)
; RV32-NEXT: asettyp	acc4, a4
; RV32-NEXT: lw	a4, 20(a1)
; RV32-NEXT: asettyp	acc5, a4
; RV32-NEXT: lw	a4, 24(a1)
; RV32-NEXT: asettyp	acc6, a4
; RV32-NEXT: lw	a4, 28(a1)
; RV32-NEXT: asettyp	acc7, a4
; RV32-NEXT: lw	a4, 32(a1)
; RV32-NEXT: asettyp	acc8, a4
; RV32-NEXT: lw	a4, 36(a1)
; RV32-NEXT: asettyp	acc9, a4
; RV32-NEXT: lw	a4, 40(a1)
; RV32-NEXT: asettyp	acc10, a4
; RV32-NEXT: lw	a4, 44(a1)
; RV32-NEXT: asettyp	acc11, a4
; RV32-NEXT: lw	a4, 48(a1)
; RV32-NEXT: asettyp	acc12, a4
; RV32-NEXT: lw	a4, 52(a1)
; RV32-NEXT: asettyp	acc13, a4
; RV32-NEXT: lw	a4, 56(a1)
; RV32-NEXT: asettyp	acc14, a4
; RV32-NEXT: lw	a4, 60(a1)
; RV32-NEXT: asettyp	acc15, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 256
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: lw	ra, 236(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 232(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 228(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 224(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 220(sp)                     # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 240
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lw	a0, 16(sp)
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: ret
; RV32-NEXT: .Lfunc_end4:
; RV32-NEXT: .size	acc16_packed, .Lfunc_end4-acc16_packed
; RV32-NEXT: # -- End function

; RV64-LABEL: acc16_packed:                           # @acc16_packed
; RV64-NEXT: # %bb.0:
; RV64-NEXT: addi	sp, sp, -48
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 32(sp)
; RV64-NEXT: csrr	a2, amenlen
; RV64-NEXT: mul	a1, a2, a2
; RV64-NEXT: slli	a1, a1, 4
; RV64-NEXT: li	a0, 0
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: add	a0, a0, a1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: addi	a0, a0, 15
; RV64-NEXT: andi	a0, a0, -16
; RV64-NEXT: addi	a0, a0, 64
; RV64-NEXT: mv	a4, sp
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 56(sp)
; RV64-NEXT: ld	a0, 0(a4)
; RV64-NEXT: ld	a1, 8(a4)
; RV64-NEXT: ld	a2, 16(a4)
; RV64-NEXT: ld	a3, 24(a4)
; RV64-NEXT: ld	a4, 32(a4)
; RV64-NEXT: addi	sp, sp, 48
; RV64-NEXT: addi	sp, sp, -272
; RV64-NEXT: sd	ra, 264(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 256(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 248(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 240(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 232(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	s3, 280(sp)
; RV64-NEXT: mv	s0, a0
; RV64-NEXT: lui	a0, 262144
; RV64-NEXT: addi	s2, a0, 8
; RV64-NEXT: mv	a0, s0
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: asettyp	acc2, s2
; RV64-NEXT: asettyp	acc3, s2
; RV64-NEXT: asettyp	acc4, s2
; RV64-NEXT: asettyp	acc5, s2
; RV64-NEXT: asettyp	acc6, s2
; RV64-NEXT: asettyp	acc7, s2
; RV64-NEXT: asettyp	acc8, s2
; RV64-NEXT: asettyp	acc9, s2
; RV64-NEXT: asettyp	acc10, s2
; RV64-NEXT: asettyp	acc11, s2
; RV64-NEXT: asettyp	acc12, s2
; RV64-NEXT: asettyp	acc13, s2
; RV64-NEXT: asettyp	acc14, s2
; RV64-NEXT: asettyp	acc15, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: agettyp	a4, acc2
; RV64-NEXT: sw	a4, 8(a1)
; RV64-NEXT: agettyp	a4, acc3
; RV64-NEXT: sw	a4, 12(a1)
; RV64-NEXT: agettyp	a4, acc4
; RV64-NEXT: sw	a4, 16(a1)
; RV64-NEXT: agettyp	a4, acc5
; RV64-NEXT: sw	a4, 20(a1)
; RV64-NEXT: agettyp	a4, acc6
; RV64-NEXT: sw	a4, 24(a1)
; RV64-NEXT: agettyp	a4, acc7
; RV64-NEXT: sw	a4, 28(a1)
; RV64-NEXT: agettyp	a4, acc8
; RV64-NEXT: sw	a4, 32(a1)
; RV64-NEXT: agettyp	a4, acc9
; RV64-NEXT: sw	a4, 36(a1)
; RV64-NEXT: agettyp	a4, acc10
; RV64-NEXT: sw	a4, 40(a1)
; RV64-NEXT: agettyp	a4, acc11
; RV64-NEXT: sw	a4, 44(a1)
; RV64-NEXT: agettyp	a4, acc12
; RV64-NEXT: sw	a4, 48(a1)
; RV64-NEXT: agettyp	a4, acc13
; RV64-NEXT: sw	a4, 52(a1)
; RV64-NEXT: agettyp	a4, acc14
; RV64-NEXT: sw	a4, 56(a1)
; RV64-NEXT: agettyp	a4, acc15
; RV64-NEXT: sw	a4, 60(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 288
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: asettyp	acc2, s2
; RV64-NEXT: asettyp	acc3, s2
; RV64-NEXT: asettyp	acc4, s2
; RV64-NEXT: asettyp	acc5, s2
; RV64-NEXT: asettyp	acc6, s2
; RV64-NEXT: asettyp	acc7, s2
; RV64-NEXT: asettyp	acc8, s2
; RV64-NEXT: asettyp	acc9, s2
; RV64-NEXT: asettyp	acc10, s2
; RV64-NEXT: asettyp	acc11, s2
; RV64-NEXT: asettyp	acc12, s2
; RV64-NEXT: asettyp	acc13, s2
; RV64-NEXT: asettyp	acc14, s2
; RV64-NEXT: asettyp	acc15, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 168
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: agettyp	a4, acc2
; RV64-NEXT: sw	a4, 8(a1)
; RV64-NEXT: agettyp	a4, acc3
; RV64-NEXT: sw	a4, 12(a1)
; RV64-NEXT: agettyp	a4, acc4
; RV64-NEXT: sw	a4, 16(a1)
; RV64-NEXT: agettyp	a4, acc5
; RV64-NEXT: sw	a4, 20(a1)
; RV64-NEXT: agettyp	a4, acc6
; RV64-NEXT: sw	a4, 24(a1)
; RV64-NEXT: agettyp	a4, acc7
; RV64-NEXT: sw	a4, 28(a1)
; RV64-NEXT: agettyp	a4, acc8
; RV64-NEXT: sw	a4, 32(a1)
; RV64-NEXT: agettyp	a4, acc9
; RV64-NEXT: sw	a4, 36(a1)
; RV64-NEXT: agettyp	a4, acc10
; RV64-NEXT: sw	a4, 40(a1)
; RV64-NEXT: agettyp	a4, acc11
; RV64-NEXT: sw	a4, 44(a1)
; RV64-NEXT: agettyp	a4, acc12
; RV64-NEXT: sw	a4, 48(a1)
; RV64-NEXT: agettyp	a4, acc13
; RV64-NEXT: sw	a4, 52(a1)
; RV64-NEXT: agettyp	a4, acc14
; RV64-NEXT: sw	a4, 56(a1)
; RV64-NEXT: agettyp	a4, acc15
; RV64-NEXT: sw	a4, 60(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 288
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 8(a1)
; RV64-NEXT: asettyp	acc2, a4
; RV64-NEXT: lw	a4, 12(a1)
; RV64-NEXT: asettyp	acc3, a4
; RV64-NEXT: lw	a4, 16(a1)
; RV64-NEXT: asettyp	acc4, a4
; RV64-NEXT: lw	a4, 20(a1)
; RV64-NEXT: asettyp	acc5, a4
; RV64-NEXT: lw	a4, 24(a1)
; RV64-NEXT: asettyp	acc6, a4
; RV64-NEXT: lw	a4, 28(a1)
; RV64-NEXT: asettyp	acc7, a4
; RV64-NEXT: lw	a4, 32(a1)
; RV64-NEXT: asettyp	acc8, a4
; RV64-NEXT: lw	a4, 36(a1)
; RV64-NEXT: asettyp	acc9, a4
; RV64-NEXT: lw	a4, 40(a1)
; RV64-NEXT: asettyp	acc10, a4
; RV64-NEXT: lw	a4, 44(a1)
; RV64-NEXT: asettyp	acc11, a4
; RV64-NEXT: lw	a4, 48(a1)
; RV64-NEXT: asettyp	acc12, a4
; RV64-NEXT: lw	a4, 52(a1)
; RV64-NEXT: asettyp	acc13, a4
; RV64-NEXT: lw	a4, 56(a1)
; RV64-NEXT: asettyp	acc14, a4
; RV64-NEXT: lw	a4, 60(a1)
; RV64-NEXT: asettyp	acc15, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 288
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 168
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 8(a1)
; RV64-NEXT: asettyp	acc2, a4
; RV64-NEXT: lw	a4, 12(a1)
; RV64-NEXT: asettyp	acc3, a4
; RV64-NEXT: lw	a4, 16(a1)
; RV64-NEXT: asettyp	acc4, a4
; RV64-NEXT: lw	a4, 20(a1)
; RV64-NEXT: asettyp	acc5, a4
; RV64-NEXT: lw	a4, 24(a1)
; RV64-NEXT: asettyp	acc6, a4
; RV64-NEXT: lw	a4, 28(a1)
; RV64-NEXT: asettyp	acc7, a4
; RV64-NEXT: lw	a4, 32(a1)
; RV64-NEXT: asettyp	acc8, a4
; RV64-NEXT: lw	a4, 36(a1)
; RV64-NEXT: asettyp	acc9, a4
; RV64-NEXT: lw	a4, 40(a1)
; RV64-NEXT: asettyp	acc10, a4
; RV64-NEXT: lw	a4, 44(a1)
; RV64-NEXT: asettyp	acc11, a4
; RV64-NEXT: lw	a4, 48(a1)
; RV64-NEXT: asettyp	acc12, a4
; RV64-NEXT: lw	a4, 52(a1)
; RV64-NEXT: asettyp	acc13, a4
; RV64-NEXT: lw	a4, 56(a1)
; RV64-NEXT: asettyp	acc14, a4
; RV64-NEXT: lw	a4, 60(a1)
; RV64-NEXT: asettyp	acc15, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 288
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: ld	ra, 264(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 256(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 248(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 240(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 232(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 272
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: ld	a0, 16(sp)
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ret
; RV64-NEXT: .Lfunc_end4:
; RV64-NEXT: .size	acc16_packed, .Lfunc_end4-acc16_packed
; RV64-NEXT: # -- End function
