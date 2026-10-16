; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs %s -o %t.rv32.s
; RUN: FileCheck %s --check-prefix=RV32 < %t.rv32.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.rv32.s 32 loop 32 1 8
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs %s -o %t.rv64.s
; RUN: FileCheck %s --check-prefix=RV64 < %t.rv64.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.rv64.s 64 loop 32 1 8
;
; One image survives repeated call clobbers. Its stack slot and cached stride
; are shared across the backedge; reload restores leader Md on every iteration.
; RV32-LABEL: loop:
; RV32-NEXT: # %bb.0:                                # %entry
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
; RV32-NEXT: addi	sp, sp, -64
; RV32-NEXT: sw	ra, 60(sp)
; RV32-NEXT: sw	s0, 56(sp)
; RV32-NEXT: sw	s1, 52(sp)
; RV32-NEXT: sw	s2, 48(sp)
; RV32-NEXT: lw	s2, 68(sp)
; RV32-NEXT: mv	s0, a2
; RV32-NEXT: lui	a2, 262144
; RV32-NEXT: addi	a2, a2, 32
; RV32-NEXT: msettyp	m0, a2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: sw	a0, 28(sp)
; RV32-NEXT: sw	a1, 24(sp)
; RV32-NEXT: sw	a2, 20(sp)
; RV32-NEXT: sw	a3, 16(sp)
; RV32-NEXT: sw	a4, 12(sp)
; RV32-NEXT: addi	a0, sp, 64
; RV32-NEXT: addi	a0, a0, 16
; RV32-NEXT: addi	a1, sp, 32
; RV32-NEXT: mgettyp	a4, m0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: mv	a3, a0
; RV32-NEXT: mss.1r	m0, a3
; RV32-NEXT: add	a3, a3, s2
; RV32-NEXT: mss.1r	m1, a3
; RV32-NEXT: add	a3, a3, s2
; RV32-NEXT: mss.1r	m2, a3
; RV32-NEXT: add	a3, a3, s2
; RV32-NEXT: mss.1r	m3, a3
; RV32-NEXT: lw	a0, 28(sp)
; RV32-NEXT: lw	a1, 24(sp)
; RV32-NEXT: lw	a2, 20(sp)
; RV32-NEXT: lw	a3, 16(sp)
; RV32-NEXT: lw	a4, 12(sp)
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: .LBB0_1:
; RV32-NEXT: # =>This Inner Loop Header: Depth=1
; RV32-NEXT: call	clobber
; RV32-NEXT: mv	a0, s1
; RV32-NEXT: addi	s0, s0, -1
; RV32-NEXT: sw	a0, 28(sp)
; RV32-NEXT: sw	a1, 24(sp)
; RV32-NEXT: sw	a2, 20(sp)
; RV32-NEXT: sw	a3, 16(sp)
; RV32-NEXT: sw	a4, 12(sp)
; RV32-NEXT: addi	a0, sp, 64
; RV32-NEXT: addi	a0, a0, 16
; RV32-NEXT: addi	a1, sp, 32
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mv	a3, a0
; RV32-NEXT: mls.1r	m0, a3
; RV32-NEXT: add	a3, a3, s2
; RV32-NEXT: mls.1r	m1, a3
; RV32-NEXT: add	a3, a3, s2
; RV32-NEXT: mls.1r	m2, a3
; RV32-NEXT: add	a3, a3, s2
; RV32-NEXT: mls.1r	m3, a3
; RV32-NEXT: lw	a0, 28(sp)
; RV32-NEXT: lw	a1, 24(sp)
; RV32-NEXT: lw	a2, 20(sp)
; RV32-NEXT: lw	a3, 16(sp)
; RV32-NEXT: lw	a4, 12(sp)
; RV32-NEXT: mss.rm	m0, a0
; RV32-NEXT: bnez	s0, .LBB0_1
; RV32-NEXT: # %bb.2:                                # %exit
; RV32-NEXT: lw	ra, 60(sp)
; RV32-NEXT: lw	s0, 56(sp)
; RV32-NEXT: lw	s1, 52(sp)
; RV32-NEXT: lw	s2, 48(sp)
; RV32-NEXT: addi	sp, sp, 64
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
; RV64-LABEL: loop:
; RV64-NEXT: # %bb.0:                                # %entry
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
; RV64-NEXT: addi	sp, sp, -96
; RV64-NEXT: sd	ra, 88(sp)
; RV64-NEXT: sd	s0, 80(sp)
; RV64-NEXT: sd	s1, 72(sp)
; RV64-NEXT: sd	s2, 64(sp)
; RV64-NEXT: ld	s2, 104(sp)
; RV64-NEXT: mv	s0, a2
; RV64-NEXT: lui	a2, 262144
; RV64-NEXT: addi	a2, a2, 32
; RV64-NEXT: msettyp	m0, a2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a0, sp, 96
; RV64-NEXT: addi	a0, a0, 16
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: mgettyp	a4, m0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: mv	a3, a0
; RV64-NEXT: mss.1r	m0, a3
; RV64-NEXT: add	a3, a3, s2
; RV64-NEXT: mss.1r	m1, a3
; RV64-NEXT: add	a3, a3, s2
; RV64-NEXT: mss.1r	m2, a3
; RV64-NEXT: add	a3, a3, s2
; RV64-NEXT: mss.1r	m3, a3
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: .LBB0_1:
; RV64-NEXT: # =>This Inner Loop Header: Depth=1
; RV64-NEXT: call	clobber
; RV64-NEXT: mv	a0, s1
; RV64-NEXT: addiw	s0, s0, -1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: addi	a0, sp, 96
; RV64-NEXT: addi	a0, a0, 16
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mv	a3, a0
; RV64-NEXT: mls.1r	m0, a3
; RV64-NEXT: add	a3, a3, s2
; RV64-NEXT: mls.1r	m1, a3
; RV64-NEXT: add	a3, a3, s2
; RV64-NEXT: mls.1r	m2, a3
; RV64-NEXT: add	a3, a3, s2
; RV64-NEXT: mls.1r	m3, a3
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: mss.rm	m0, a0
; RV64-NEXT: bnez	s0, .LBB0_1
; RV64-NEXT: # %bb.2:                                # %exit
; RV64-NEXT: ld	ra, 88(sp)
; RV64-NEXT: ld	s0, 80(sp)
; RV64-NEXT: ld	s1, 72(sp)
; RV64-NEXT: ld	s2, 64(sp)
; RV64-NEXT: addi	sp, sp, 96
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
declare void @clobber() nounwind
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
define void @loop(ptr %p, ptr %q, i32 %n) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" {
entry:
  %a = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, i32 1073741856, i32 1)
  br label %body
body:
  %i = phi i32 [ %n, %entry ], [ %next, %body ]
  call void @clobber()
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, i32 1073741856, i32 1)
  %next = add i32 %i, -1
  %more = icmp ne i32 %next, 0
  br i1 %more, label %body, label %exit
exit:
  ret void
}
