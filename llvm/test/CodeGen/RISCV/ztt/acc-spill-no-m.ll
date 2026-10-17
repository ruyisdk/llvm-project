; RUN: llc -mtriple=riscv32 -verify-machineinstrs %s -o %t.32.s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs %s -o %t.64.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV32 < %t.32.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.64.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_nom 32 2 32
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_nom 32 2 32
; No M extension: existing public concat addressing may call multiplication
; helpers. ACC images must survive those calls too; the spill frame itself
; computes N*N without introducing a helper call.
declare void @clobber() nounwind
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr, i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)
define void @acc_nom(ptr %p, ptr %q) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a4" {
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

; RV32-LABEL: acc_nom:                                # @acc_nom
; RV32-NEXT: # %bb.0:
; RV32-NEXT: addi	sp, sp, -32
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: sw	a2, 8(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: csrr	a2, amenlen
; RV32-NEXT: mv	a3, a2
; RV32-NEXT: li	a1, 0
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
; RV32-NEXT: srli	a2, a2, 1
; RV32-NEXT: slli	a3, a3, 1
; RV32-NEXT: andi	a4, a2, 1
; RV32-NEXT: neg	a4, a4
; RV32-NEXT: and	a4, a4, a3
; RV32-NEXT: add	a1, a1, a4
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
; RV32-NEXT: lw	s3, 132(sp)
; RV32-NEXT: mv	s0, a1
; RV32-NEXT: mv	s1, a0
; RV32-NEXT: csrr	a0, amenlen
; RV32-NEXT: mv	a1, a0
; RV32-NEXT: call	__mulsi3
; RV32-NEXT: lui	a1, 262144
; RV32-NEXT: slli	a0, a0, 2
; RV32-NEXT: addi	s2, a1, 32
; RV32-NEXT: mv	a1, s1
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a1
; RV32-NEXT: add	a1, a1, a0
; RV32-NEXT: msettyp	m1, s2
; RV32-NEXT: mls.rm	m1, a1
; RV32-NEXT: mv	a1, s0
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: mmov.a.m	acc1, m1
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
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a1
; RV32-NEXT: add	a1, a1, a0
; RV32-NEXT: msettyp	m1, s2
; RV32-NEXT: mls.rm	m1, a1
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: asettyp	acc1, s2
; RV32-NEXT: mmov.a.m	acc1, m1
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s3, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: slli	a3, s3, 1
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
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: msettyp	m1, s2
; RV32-NEXT: mmov.m.a	m1, acc1
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a0, sp, 128
; RV32-NEXT: addi	a0, a0, 16
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: mgettyp	a4, m0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: mgettyp	a4, m1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: mv	a3, a0
; RV32-NEXT: mss.1r	m0, a3
; RV32-NEXT: add	a3, a3, s3
; RV32-NEXT: mss.1r	m1, a3
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: csrr	a0, amenlen
; RV32-NEXT: mv	a1, a0
; RV32-NEXT: call	__mulsi3
; RV32-NEXT: slli	a0, a0, 2
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a0, sp, 128
; RV32-NEXT: addi	a0, a0, 16
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m1, a4
; RV32-NEXT: mv	a3, a0
; RV32-NEXT: mls.1r	m0, a3
; RV32-NEXT: add	a3, a3, s3
; RV32-NEXT: mls.1r	m1, a3
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: add	s0, s0, a0
; RV32-NEXT: mss.rm	m1, s0
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s3, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 144
; RV32-NEXT: slli	a3, s3, 0
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: slli	a3, s3, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: addi	a1, sp, 28
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: msettyp	m1, s2
; RV32-NEXT: mmov.m.a	m1, acc1
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a0, sp, 128
; RV32-NEXT: addi	a0, a0, 16
; RV32-NEXT: slli	a3, s3, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: mgettyp	a4, m0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: mgettyp	a4, m1
; RV32-NEXT: sw	a4, 4(a1)
; RV32-NEXT: mv	a3, a0
; RV32-NEXT: mss.1r	m0, a3
; RV32-NEXT: add	a3, a3, s3
; RV32-NEXT: mss.1r	m1, a3
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: csrr	a0, amenlen
; RV32-NEXT: mv	a1, a0
; RV32-NEXT: call	__mulsi3
; RV32-NEXT: slli	a0, a0, 2
; RV32-NEXT: sw	a0, 24(sp)
; RV32-NEXT: sw	a1, 20(sp)
; RV32-NEXT: sw	a2, 16(sp)
; RV32-NEXT: sw	a3, 12(sp)
; RV32-NEXT: sw	a4, 8(sp)
; RV32-NEXT: addi	a0, sp, 128
; RV32-NEXT: addi	a0, a0, 16
; RV32-NEXT: slli	a3, s3, 1
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lw	a4, 4(a1)
; RV32-NEXT: msettyp	m1, a4
; RV32-NEXT: mv	a3, a0
; RV32-NEXT: mls.1r	m0, a3
; RV32-NEXT: add	a3, a3, s3
; RV32-NEXT: mls.1r	m1, a3
; RV32-NEXT: lw	a0, 24(sp)
; RV32-NEXT: lw	a1, 20(sp)
; RV32-NEXT: lw	a2, 16(sp)
; RV32-NEXT: lw	a3, 12(sp)
; RV32-NEXT: lw	a4, 8(sp)
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: add	s1, s1, a0
; RV32-NEXT: mss.rm	m1, s1
; RV32-NEXT: lw	ra, 124(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 120(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 116(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 112(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 108(sp)                     # 4-byte Folded Reload
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

; RV64-LABEL: acc_nom:                                # @acc_nom
; RV64-NEXT: # %bb.0:
; RV64-NEXT: addi	sp, sp, -48
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 32(sp)
; RV64-NEXT: csrr	a2, amenlen
; RV64-NEXT: mv	a3, a2
; RV64-NEXT: li	a1, 0
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
; RV64-NEXT: srli	a2, a2, 1
; RV64-NEXT: slli	a3, a3, 1
; RV64-NEXT: andi	a4, a2, 1
; RV64-NEXT: neg	a4, a4
; RV64-NEXT: and	a4, a4, a3
; RV64-NEXT: add	a1, a1, a4
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
; RV64-NEXT: addi	sp, sp, -160
; RV64-NEXT: sd	ra, 152(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 144(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 136(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 128(sp)                     # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 120(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	s3, 168(sp)
; RV64-NEXT: mv	s0, a1
; RV64-NEXT: mv	s1, a0
; RV64-NEXT: csrr	a0, amenlen
; RV64-NEXT: mv	a1, a0
; RV64-NEXT: call	__muldi3
; RV64-NEXT: lui	a1, 262144
; RV64-NEXT: slli	a0, a0, 2
; RV64-NEXT: addi	s2, a1, 32
; RV64-NEXT: mv	a1, s1
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a1
; RV64-NEXT: add	a1, a1, a0
; RV64-NEXT: msettyp	m1, s2
; RV64-NEXT: mls.rm	m1, a1
; RV64-NEXT: mv	a1, s0
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: mmov.a.m	acc1, m1
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
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a1
; RV64-NEXT: add	a1, a1, a0
; RV64-NEXT: msettyp	m1, s2
; RV64-NEXT: mls.rm	m1, a1
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: asettyp	acc1, s2
; RV64-NEXT: mmov.a.m	acc1, m1
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: slli	a3, s3, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: slli	a3, s3, 1
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
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: msettyp	m1, s2
; RV64-NEXT: mmov.m.a	m1, acc1
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a0, sp, 160
; RV64-NEXT: addi	a0, a0, 16
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: mgettyp	a4, m0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: mgettyp	a4, m1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: mv	a3, a0
; RV64-NEXT: mss.1r	m0, a3
; RV64-NEXT: add	a3, a3, s3
; RV64-NEXT: mss.1r	m1, a3
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: csrr	a0, amenlen
; RV64-NEXT: mv	a1, a0
; RV64-NEXT: call	__muldi3
; RV64-NEXT: slli	a0, a0, 2
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a0, sp, 160
; RV64-NEXT: addi	a0, a0, 16
; RV64-NEXT: addi	a1, sp, 104
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m1, a4
; RV64-NEXT: mv	a3, a0
; RV64-NEXT: mls.1r	m0, a3
; RV64-NEXT: add	a3, a3, s3
; RV64-NEXT: mls.1r	m1, a3
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: add	s0, s0, a0
; RV64-NEXT: mss.rm	m1, s0
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: slli	a3, s3, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: slli	a3, s3, 0
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: slli	a3, s3, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: addi	a1, sp, 40
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: msettyp	m1, s2
; RV64-NEXT: mmov.m.a	m1, acc1
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a0, sp, 160
; RV64-NEXT: addi	a0, a0, 16
; RV64-NEXT: slli	a3, s3, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: mgettyp	a4, m0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: mgettyp	a4, m1
; RV64-NEXT: sw	a4, 4(a1)
; RV64-NEXT: mv	a3, a0
; RV64-NEXT: mss.1r	m0, a3
; RV64-NEXT: add	a3, a3, s3
; RV64-NEXT: mss.1r	m1, a3
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: csrr	a0, amenlen
; RV64-NEXT: mv	a1, a0
; RV64-NEXT: call	__muldi3
; RV64-NEXT: slli	a0, a0, 2
; RV64-NEXT: sd	a0, 32(sp)
; RV64-NEXT: sd	a1, 24(sp)
; RV64-NEXT: sd	a2, 16(sp)
; RV64-NEXT: sd	a3, 8(sp)
; RV64-NEXT: sd	a4, 0(sp)
; RV64-NEXT: addi	a0, sp, 160
; RV64-NEXT: addi	a0, a0, 16
; RV64-NEXT: slli	a3, s3, 1
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lw	a4, 4(a1)
; RV64-NEXT: msettyp	m1, a4
; RV64-NEXT: mv	a3, a0
; RV64-NEXT: mls.1r	m0, a3
; RV64-NEXT: add	a3, a3, s3
; RV64-NEXT: mls.1r	m1, a3
; RV64-NEXT: ld	a0, 32(sp)
; RV64-NEXT: ld	a1, 24(sp)
; RV64-NEXT: ld	a2, 16(sp)
; RV64-NEXT: ld	a3, 8(sp)
; RV64-NEXT: ld	a4, 0(sp)
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: add	s1, s1, a0
; RV64-NEXT: mss.rm	m1, s1
; RV64-NEXT: ld	ra, 152(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 144(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 136(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 128(sp)                     # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 120(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 160
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
