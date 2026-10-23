; RUN: llc -mtriple=riscv32 -mattr=+m -verify-machineinstrs %s -o %t.32.s
; RUN: llc -mtriple=riscv64 -mattr=+m -verify-machineinstrs %s -o %t.64.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV32 < %t.32.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.64.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 acc_loop 32 1 8
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 acc_loop 32 1 8
; The matmul adds a zero product to a nonzero incoming ACC value. Loop PHIs
; and tied updates must retain its width through repeated spills at calls.
declare void @clobber() nounwind
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i32_i32_32_1_1t(i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1), i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.acc.i32", i32, 32, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
define void @acc_loop(ptr %p, ptr %q, i32 %count) nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" {
entry:
  %m = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, i32 1073741856, i32 1)
  %initial = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %m, i32 1073741856, i32 1)
  br label %loop
loop:
  %a = phi target("riscv.ztt.acc.i32", i32, 32, 1) [ %initial, %entry ], [ %sum, %loop ]
  %i = phi i32 [ %count, %entry ], [ %next, %loop ]
  %z = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i32_i32_32_1_1t(i32 1073741856, i32 1)
  %sum = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmulacc.2d.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %z, target("riscv.ztt.m.i32", i32, 32, 1, 1) %z, i32 1)
  call void @clobber()
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %sum, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %r, i32 1073741856, i32 1)
  %next = add i32 %i, -1
  %more = icmp ne i32 %next, 0
  br i1 %more, label %loop, label %exit
exit:
  ret void
}

; RV32-LABEL: acc_loop:                               # @acc_loop
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
; RV32-NEXT: addi	sp, sp, -112
; RV32-NEXT: sw	ra, 108(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 104(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 100(sp)                     # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 96(sp)                      # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 92(sp)                      # 4-byte Folded Spill
; RV32-NEXT: lw	s3, 116(sp)
; RV32-NEXT: mv	s0, a2
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: lui	s2, 262144
; RV32-NEXT: addi	s2, s2, 32
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: .LBB0_1:                                # %loop
; RV32-NEXT: # =>This Inner Loop Header: Depth=1
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmulacc.2d	acc0, m0, m0
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
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: addi	a0, sp, 128
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, s3
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, s3
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, s3
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
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: addi	a0, sp, 128
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, s3
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, s3
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, s3
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: lw	a0, 20(sp)
; RV32-NEXT: lw	a1, 16(sp)
; RV32-NEXT: lw	a2, 12(sp)
; RV32-NEXT: lw	a3, 8(sp)
; RV32-NEXT: lw	a4, 4(sp)
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mv	a0, s1
; RV32-NEXT: addi	s0, s0, -1
; RV32-NEXT: mss.rm	m0, a0
; RV32-NEXT: bnez	s0, .LBB0_1
; RV32-NEXT: # %bb.2:                                # %exit
; RV32-NEXT: lw	ra, 108(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 104(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 100(sp)                     # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 96(sp)                      # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 92(sp)                      # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 112
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

; RV64-LABEL: acc_loop:                               # @acc_loop
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
; RV64-NEXT: mv	s0, a2
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: lui	s2, 262144
; RV64-NEXT: addi	s2, s2, 32
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: .LBB0_1:                                # %loop
; RV64-NEXT: # =>This Inner Loop Header: Depth=1
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmulacc.2d	acc0, m0, m0
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
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 52
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
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: addi	a0, sp, 176
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 52
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mv	a0, s1
; RV64-NEXT: addiw	s0, s0, -1
; RV64-NEXT: mss.rm	m0, a0
; RV64-NEXT: bnez	s0, .LBB0_1
; RV64-NEXT: # %bb.2:                                # %exit
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
