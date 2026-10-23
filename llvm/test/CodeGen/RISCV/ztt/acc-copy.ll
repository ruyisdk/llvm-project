; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m16-a4/g' %s > %t.ztt-profile-0.ll
; RUN: llc -mtriple=riscv32 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o %t.32.s
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m16-a4/g' %s > %t.ztt-profile-1.ll
; RUN: llc -mtriple=riscv64 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o %t.64.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV32 < %t.32.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.64.s
; Matmul's tied destination must not destroy the still-live old ACC. No ACC ABI.
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.acc.i32", i32, 32, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)

define void @preserve_old(ptr %p, ptr %sumout, ptr %oldout) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
  %m = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, i32 1073741856, i32 1)
  %a = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %m, i32 1073741856, i32 1)
  %sum = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %m, target("riscv.ztt.m.i32", i32, 32, 1, 1) %m, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %sum, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %sumout, target("riscv.ztt.m.i32", i32, 32, 1, 1) %r, i32 1073741856, i32 1)
  %old = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %a, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %oldout, target("riscv.ztt.m.i32", i32, 32, 1, 1) %old, i32 1073741856, i32 1)
  ret void
}

; RV32-LABEL: preserve_old:                           # @preserve_old
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
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: slli	a0, a0, 1
; RV32-NEXT: add	a0, a0, a1
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
; RV32-NEXT: lui	a3, 262144
; RV32-NEXT: addi	a3, a3, 32
; RV32-NEXT: msettyp	m0, a3
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, a3
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m1, a4
; RV32-NEXT: mmov.m.a	m1, acc0
; RV32-NEXT: addi	a0, sp, 112
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 88
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc1, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m1, a4
; RV32-NEXT: addi	a0, sp, 112
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: mmov.a.m	acc1, m1
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: mmulacc.2d	acc1, m0, m0
; RV32-NEXT: msettyp	m0, a3
; RV32-NEXT: mmov.m.a	m0, acc1
; RV32-NEXT: mss.rm	m0, a1
; RV32-NEXT: msettyp	m0, a3
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, a2
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

; RV64-LABEL: preserve_old:                           # @preserve_old
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
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: slli	a0, a0, 1
; RV64-NEXT: add	a0, a0, a1
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
; RV64-NEXT: lui	a3, 262144
; RV64-NEXT: addi	a3, a3, 32
; RV64-NEXT: msettyp	m0, a3
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: asettyp	acc0, a3
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m1, a4
; RV64-NEXT: mmov.m.a	m1, acc0
; RV64-NEXT: addi	a0, sp, 144
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc1, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m1, a4
; RV64-NEXT: addi	a0, sp, 144
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: mmov.a.m	acc1, m1
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: mmulacc.2d	acc1, m0, m0
; RV64-NEXT: msettyp	m0, a3
; RV64-NEXT: mmov.m.a	m0, acc1
; RV64-NEXT: mss.rm	m0, a1
; RV64-NEXT: msettyp	m0, a3
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, a2
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
