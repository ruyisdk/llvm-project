; Five live ACC squares exceed ztta4, without calls or ACC parameters/returns.
; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs %s -o %t.32.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV32 < %t.32.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_pressure 32 1 8
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs %s -o %t.64.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.64.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_pressure 32 1 8
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
define void @acc_pressure(ptr %p, ptr %q, ptr %r, ptr %s, ptr %t) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" {
  %a = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, i32 1073741856, i32 1)
  %acca = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, i32 1073741856, i32 1)
  %b = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, i32 1073741856, i32 1)
  %accb = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  %c = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %r, i32 1073741856, i32 1)
  %accc = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %c, i32 1073741856, i32 1)
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %s, i32 1073741856, i32 1)
  %accd = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %d, i32 1073741856, i32 1)
  %e = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %t, i32 1073741856, i32 1)
  %acce = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %e, i32 1073741856, i32 1)
  %outa = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %acca, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %outa, i32 1073741856, i32 1)
  %outb = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accb, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %outb, i32 1073741856, i32 1)
  %outc = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accc, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %outc, i32 1073741856, i32 1)
  %outd = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accd, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %outd, i32 1073741856, i32 1)
  %oute = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %acce, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %oute, i32 1073741856, i32 1)
  ret void
}

; RV32-LABEL: acc_pressure:                           # @acc_pressure
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
; RV32-NEXT: addi	sp, sp, -96
; RV32-NEXT: sw	ra, 92(sp)                      # 4-byte Folded Spill
; RV32-NEXT: lw	ra, 100(sp)
; RV32-NEXT: lui	a5, 262144
; RV32-NEXT: addi	a5, a5, 32
; RV32-NEXT: mv	a6, a0
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mls.rm	m0, a6
; RV32-NEXT: mv	a6, a1
; RV32-NEXT: asettyp	acc0, a5
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mls.rm	m0, a6
; RV32-NEXT: asettyp	acc1, a5
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: agettyp	a4, acc1
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: addi	a0, sp, 112
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, ra
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, ra
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, ra
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mls.rm	m0, a2
; RV32-NEXT: asettyp	acc1, a5
; RV32-NEXT: mmov.a.m	acc1, m0
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mls.rm	m0, a3
; RV32-NEXT: asettyp	acc2, a5
; RV32-NEXT: mmov.a.m	acc2, m0
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mls.rm	m0, a4
; RV32-NEXT: asettyp	acc3, a5
; RV32-NEXT: mmov.a.m	acc3, m0
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mv	a2, a1
; RV32-NEXT: mss.rm	m0, a2
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 112
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, ra
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, ra
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, ra
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mv	a2, a0
; RV32-NEXT: mss.rm	m0, a2
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: mv	a2, a1
; RV32-NEXT: mss.rm	m0, a2
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mmov.m.a	m0, acc2
; RV32-NEXT: mss.rm	m0, a0
; RV32-NEXT: msettyp	m0, a5
; RV32-NEXT: mmov.m.a	m0, acc3
; RV32-NEXT: mss.rm	m0, a1
; RV32-NEXT: lw	ra, 92(sp)                      # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 96
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

; RV64-LABEL: acc_pressure:                           # @acc_pressure
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
; RV64-NEXT: addi	sp, sp, -128
; RV64-NEXT: sd	ra, 120(sp)                     # 8-byte Folded Spill
; RV64-NEXT: ld	ra, 136(sp)
; RV64-NEXT: lui	a5, 262144
; RV64-NEXT: addi	a5, a5, 32
; RV64-NEXT: mv	a6, a0
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mls.rm	m0, a6
; RV64-NEXT: mv	a6, a1
; RV64-NEXT: asettyp	acc0, a5
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mls.rm	m0, a6
; RV64-NEXT: asettyp	acc1, a5
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: agettyp	a4, acc1
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: addi	a0, sp, 144
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, ra
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, ra
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, ra
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mls.rm	m0, a2
; RV64-NEXT: asettyp	acc1, a5
; RV64-NEXT: mmov.a.m	acc1, m0
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mls.rm	m0, a3
; RV64-NEXT: asettyp	acc2, a5
; RV64-NEXT: mmov.a.m	acc2, m0
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mls.rm	m0, a4
; RV64-NEXT: asettyp	acc3, a5
; RV64-NEXT: mmov.a.m	acc3, m0
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mv	a2, a1
; RV64-NEXT: mss.rm	m0, a2
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 144
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, ra
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, ra
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, ra
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mv	a2, a0
; RV64-NEXT: mss.rm	m0, a2
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: mv	a2, a1
; RV64-NEXT: mss.rm	m0, a2
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mmov.m.a	m0, acc2
; RV64-NEXT: mss.rm	m0, a0
; RV64-NEXT: msettyp	m0, a5
; RV64-NEXT: mmov.m.a	m0, acc3
; RV64-NEXT: mss.rm	m0, a1
; RV64-NEXT: ld	ra, 120(sp)                     # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 128
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
