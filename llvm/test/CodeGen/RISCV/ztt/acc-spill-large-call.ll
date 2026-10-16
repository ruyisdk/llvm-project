; ACC values and both Ad words survive an 8192-byte ordinary frame and both
; physical epilogues, with cached stride and reserved-GPR stack fallback.
; RUN: llc -mtriple=riscv32 -enable-tail-merge=false -verify-machineinstrs %s -o %t.32.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV32 < %t.32.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 cross_large_acc_cache 32 1 8 0 none 0
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 cross_large_acc_cache 32 1 8 0 none 1
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 cross_large_acc_stack 32 1 8 0 s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 0
; RUN: %python %S/Inputs/check-spill-frame.py %t.32.s 32 cross_large_acc_stack 32 1 8 0 s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 1
; RUN: llc -mtriple=riscv64 -enable-tail-merge=false -verify-machineinstrs %s -o %t.64.s
; RUN: FileCheck %s --match-full-lines --check-prefix=RV64 < %t.64.s
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 cross_large_acc_cache 32 1 8 0 none 0
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 cross_large_acc_cache 32 1 8 0 none 1
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 cross_large_acc_stack 32 1 8 0 s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 0
; RUN: %python %S/Inputs/check-spill-frame.py %t.64.s 64 cross_large_acc_stack 32 1 8 0 s2,s3,s4,s5,s6,s7,s8,s9,s10,s11 1
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1), i32, i32)

declare void @clobber(ptr) nounwind
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
define i32 @cross_large_acc_cache(ptr %p, ptr %q, i32 %take) nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" {
entry:
  %buf = alloca [8192 x i8], align 16
  %last = getelementptr [8192 x i8], ptr %buf, i32 0, i32 8188
  store volatile i32 17, ptr %buf, align 16
  store volatile i32 23, ptr %last, align 4
  %a = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, i32 1073741856, i32 1)
  %acca = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, i32 1073741856, i32 1)
  %b = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, i32 1073741856, i32 1)
  %accb = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  %cond = icmp eq i32 %take, 0
  br i1 %cond, label %left, label %right
left:
  call void @clobber(ptr %buf)
  %out0 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %acca, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out0, i32 1073741856, i32 1)
  %out1 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accb, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out1, i32 1073741856, i32 1)
  ret i32 17
right:
  call void @clobber(ptr %buf)
  %out2 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %acca, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out2, i32 1073741856, i32 1)
  %out3 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accb, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out3, i32 1073741856, i32 1)
  ret i32 23
}
define i32 @cross_large_acc_stack(ptr %p, ptr %q, i32 %take) nounwind "target-features"="+m,+ztt,+reserve-x18,+reserve-x19,+reserve-x20,+reserve-x21,+reserve-x22,+reserve-x23,+reserve-x24,+reserve-x25,+reserve-x26,+reserve-x27" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" {
entry:
  %buf = alloca [8192 x i8], align 16
  %last = getelementptr [8192 x i8], ptr %buf, i32 0, i32 8188
  store volatile i32 17, ptr %buf, align 16
  store volatile i32 23, ptr %last, align 4
  %a = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, i32 1073741856, i32 1)
  %acca = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, i32 1073741856, i32 1)
  %b = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, i32 1073741856, i32 1)
  %accb = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i32_i32_32_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  %cond = icmp eq i32 %take, 0
  br i1 %cond, label %left, label %right
left:
  call void @clobber(ptr %buf)
  %out4 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %acca, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out4, i32 1073741856, i32 1)
  %out5 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accb, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out5, i32 1073741856, i32 1)
  ret i32 17
right:
  call void @clobber(ptr %buf)
  %out6 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %acca, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %q, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out6, i32 1073741856, i32 1)
  %out7 = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.acc.i32_i32_32_1t(target("riscv.ztt.acc.i32", i32, 32, 1) %accb, i32 1073741856, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 1) %out7, i32 1073741856, i32 1)
  ret i32 23
}

; RV32-LABEL: cross_large_acc_cache:                  # @cross_large_acc_cache
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
; RV32-NEXT: add	a0, a0, a1
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
; RV32-NEXT: addi	sp, sp, -2032
; RV32-NEXT: sw	ra, 2028(sp)                    # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 2024(sp)                    # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 2020(sp)                    # 4-byte Folded Spill
; RV32-NEXT: sw	s2, 2016(sp)                    # 4-byte Folded Spill
; RV32-NEXT: sw	s3, 2012(sp)                    # 4-byte Folded Spill
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, -1920
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a0, 0(a0)
; RV32-NEXT: lui	a3, 2
; RV32-NEXT: add	a3, sp, a3
; RV32-NEXT: lw	s3, 132(a3)
; RV32-NEXT: mv	s0, a0
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a3, sp, 96
; RV32-NEXT: add	a0, a3, a0
; RV32-NEXT: li	a3, 17
; RV32-NEXT: sw	a3, 96(sp)
; RV32-NEXT: li	a3, 23
; RV32-NEXT: sw	a3, -4(a0)
; RV32-NEXT: lui	s2, 262144
; RV32-NEXT: addi	s2, s2, 32
; RV32-NEXT: mv	a0, s0
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s2
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
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
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
; RV32-NEXT: msettyp	m0, s2
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, s2
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: slli	a3, s3, 2
; RV32-NEXT: add	a0, a0, a3
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
; RV32-NEXT: addi	a0, sp, 96
; RV32-NEXT: beqz	a2, .LBB0_2
; RV32-NEXT: # %bb.1:                                # %right
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
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
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
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: slli	a3, s3, 2
; RV32-NEXT: add	a0, a0, a3
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
; RV32-NEXT: li	a0, 23
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, -1904
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: lw	ra, 2028(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 2024(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 2020(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 2016(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 2012(sp)                    # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 2032
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
; RV32-NEXT: .LBB0_2:                                # %left
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
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
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
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 20(sp)
; RV32-NEXT: sw	a1, 16(sp)
; RV32-NEXT: sw	a2, 12(sp)
; RV32-NEXT: sw	a3, 8(sp)
; RV32-NEXT: sw	a4, 4(sp)
; RV32-NEXT: addi	a1, sp, 24
; RV32-NEXT: addi	a1, sp, 92
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: slli	a3, s3, 2
; RV32-NEXT: add	a0, a0, a3
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
; RV32-NEXT: li	a0, 17
; RV32-NEXT: mss.rm	m0, s0
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, -1904
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: lw	ra, 2028(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 2024(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 2020(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s2, 2016(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s3, 2012(sp)                    # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 2032
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

; RV32-LABEL: cross_large_acc_stack:                  # @cross_large_acc_stack
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
; RV32-NEXT: add	a0, a0, a1
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
; RV32-NEXT: addi	sp, sp, -2032
; RV32-NEXT: sw	ra, 2028(sp)                    # 4-byte Folded Spill
; RV32-NEXT: sw	s0, 2024(sp)                    # 4-byte Folded Spill
; RV32-NEXT: sw	s1, 2020(sp)                    # 4-byte Folded Spill
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, -1920
; RV32-NEXT: sub	sp, sp, a0
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a0, 0(a0)
; RV32-NEXT: lui	a4, 2
; RV32-NEXT: addi	a3, sp, 112
; RV32-NEXT: add	a4, a3, a4
; RV32-NEXT: li	a3, 17
; RV32-NEXT: sw	a3, 112(sp)
; RV32-NEXT: li	a3, 23
; RV32-NEXT: sw	a3, -4(a4)
; RV32-NEXT: lui	s0, 262144
; RV32-NEXT: addi	s0, s0, 32
; RV32-NEXT: sw	a0, 108(sp)                     # 4-byte Folded Spill
; RV32-NEXT: msettyp	m0, s0
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: mv	s1, a1
; RV32-NEXT: mv	a0, a1
; RV32-NEXT: asettyp	acc0, s0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 28(sp)
; RV32-NEXT: sw	a2, 24(sp)
; RV32-NEXT: sw	a3, 20(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 128
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a2, 4(a0)
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: lw	a0, 32(sp)
; RV32-NEXT: lw	a1, 28(sp)
; RV32-NEXT: lw	a2, 24(sp)
; RV32-NEXT: lw	a3, 20(sp)
; RV32-NEXT: lw	a4, 16(sp)
; RV32-NEXT: msettyp	m0, s0
; RV32-NEXT: mls.rm	m0, a0
; RV32-NEXT: asettyp	acc0, s0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 28(sp)
; RV32-NEXT: sw	a2, 24(sp)
; RV32-NEXT: sw	a3, 20(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 128
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a2, 4(a0)
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: addi	a1, sp, 104
; RV32-NEXT: agettyp	a4, acc0
; RV32-NEXT: sw	a4, 0(a1)
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: slli	a3, a2, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mss.1r	m0, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mss.1r	m1, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mss.1r	m2, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mss.1r	m3, a0
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: lw	a0, 32(sp)
; RV32-NEXT: lw	a1, 28(sp)
; RV32-NEXT: lw	a2, 24(sp)
; RV32-NEXT: lw	a3, 20(sp)
; RV32-NEXT: lw	a4, 16(sp)
; RV32-NEXT: addi	a0, sp, 112
; RV32-NEXT: beqz	a2, .LBB1_2
; RV32-NEXT: # %bb.1:                                # %right
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 28(sp)
; RV32-NEXT: sw	a2, 24(sp)
; RV32-NEXT: sw	a3, 20(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 128
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a2, 4(a0)
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: lw	a0, 32(sp)
; RV32-NEXT: lw	a1, 28(sp)
; RV32-NEXT: lw	a2, 24(sp)
; RV32-NEXT: lw	a3, 20(sp)
; RV32-NEXT: lw	a4, 16(sp)
; RV32-NEXT: msettyp	m0, s0
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 28(sp)
; RV32-NEXT: sw	a2, 24(sp)
; RV32-NEXT: sw	a3, 20(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 128
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a2, 4(a0)
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: addi	a1, sp, 104
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: slli	a3, a2, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: lw	a0, 32(sp)
; RV32-NEXT: lw	a1, 28(sp)
; RV32-NEXT: lw	a2, 24(sp)
; RV32-NEXT: lw	a3, 20(sp)
; RV32-NEXT: lw	a4, 16(sp)
; RV32-NEXT: msettyp	m0, s0
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: li	a0, 23
; RV32-NEXT: lw	a1, 108(sp)                     # 4-byte Folded Reload
; RV32-NEXT: mss.rm	m0, a1
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, -1904
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: lw	ra, 2028(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 2024(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 2020(sp)                    # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 2032
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
; RV32-NEXT: .LBB1_2:                                # %left
; RV32-NEXT: call	clobber
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 28(sp)
; RV32-NEXT: sw	a2, 24(sp)
; RV32-NEXT: sw	a3, 20(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 128
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a2, 4(a0)
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: addi	a1, sp, 100
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: lw	a0, 32(sp)
; RV32-NEXT: lw	a1, 28(sp)
; RV32-NEXT: lw	a2, 24(sp)
; RV32-NEXT: lw	a3, 20(sp)
; RV32-NEXT: lw	a4, 16(sp)
; RV32-NEXT: msettyp	m0, s0
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: mss.rm	m0, s1
; RV32-NEXT: sw	a0, 32(sp)
; RV32-NEXT: sw	a1, 28(sp)
; RV32-NEXT: sw	a2, 24(sp)
; RV32-NEXT: sw	a3, 20(sp)
; RV32-NEXT: sw	a4, 16(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 128
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: lw	a2, 4(a0)
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: addi	a1, sp, 104
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: asettyp	acc0, a4
; RV32-NEXT: lw	a4, 0(a1)
; RV32-NEXT: msettyp	m0, a4
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, 144
; RV32-NEXT: add	a0, sp, a0
; RV32-NEXT: slli	a3, a2, 2
; RV32-NEXT: add	a0, a0, a3
; RV32-NEXT: mls.1r	m0, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m1, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m2, a0
; RV32-NEXT: add	a0, a0, a2
; RV32-NEXT: mls.1r	m3, a0
; RV32-NEXT: mmov.a.m	acc0, m0
; RV32-NEXT: addi	a1, sp, 36
; RV32-NEXT: lw	a0, 32(sp)
; RV32-NEXT: lw	a1, 28(sp)
; RV32-NEXT: lw	a2, 24(sp)
; RV32-NEXT: lw	a3, 20(sp)
; RV32-NEXT: lw	a4, 16(sp)
; RV32-NEXT: msettyp	m0, s0
; RV32-NEXT: mmov.m.a	m0, acc0
; RV32-NEXT: li	a0, 17
; RV32-NEXT: lw	a1, 108(sp)                     # 4-byte Folded Reload
; RV32-NEXT: mss.rm	m0, a1
; RV32-NEXT: addi	sp, sp, -16
; RV32-NEXT: sw	a0, 0(sp)
; RV32-NEXT: sw	a1, 4(sp)
; RV32-NEXT: lui	a0, 2
; RV32-NEXT: addi	a0, a0, -1904
; RV32-NEXT: add	a1, sp, a0
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: sw	a0, 0(a1)
; RV32-NEXT: lw	a0, 4(sp)
; RV32-NEXT: sw	a0, 4(a1)
; RV32-NEXT: mv	sp, a1
; RV32-NEXT: lw	a0, 0(sp)
; RV32-NEXT: lw	a1, 4(sp)
; RV32-NEXT: addi	sp, sp, 16
; RV32-NEXT: lw	ra, 2028(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s0, 2024(sp)                    # 4-byte Folded Reload
; RV32-NEXT: lw	s1, 2020(sp)                    # 4-byte Folded Reload
; RV32-NEXT: addi	sp, sp, 2032
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

; RV64-LABEL: cross_large_acc_cache:                  # @cross_large_acc_cache
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
; RV64-NEXT: add	a0, a0, a1
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
; RV64-NEXT: addi	sp, sp, -2032
; RV64-NEXT: sd	ra, 2024(sp)                    # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 2016(sp)                    # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 2008(sp)                    # 8-byte Folded Spill
; RV64-NEXT: sd	s2, 2000(sp)                    # 8-byte Folded Spill
; RV64-NEXT: sd	s3, 1992(sp)                    # 8-byte Folded Spill
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, -1872
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a0, 0(a0)
; RV64-NEXT: lui	a3, 2
; RV64-NEXT: add	a3, sp, a3
; RV64-NEXT: ld	s3, 184(a3)
; RV64-NEXT: mv	s0, a0
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a3, sp, 128
; RV64-NEXT: add	a0, a3, a0
; RV64-NEXT: li	a3, 17
; RV64-NEXT: sw	a3, 128(sp)
; RV64-NEXT: li	a3, 23
; RV64-NEXT: sw	a3, -4(a0)
; RV64-NEXT: lui	s2, 262144
; RV64-NEXT: addi	s2, s2, 32
; RV64-NEXT: mv	a0, s0
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 40(sp)
; RV64-NEXT: sd	a2, 32(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 16(sp)
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 192
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: ld	a0, 48(sp)
; RV64-NEXT: ld	a1, 40(sp)
; RV64-NEXT: ld	a2, 32(sp)
; RV64-NEXT: ld	a3, 24(sp)
; RV64-NEXT: ld	a4, 16(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: sext.w	a2, a2
; RV64-NEXT: asettyp	acc0, s2
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 40(sp)
; RV64-NEXT: sd	a2, 32(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 16(sp)
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: addi	a1, sp, 124
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 192
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: slli	a3, s3, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: ld	a0, 48(sp)
; RV64-NEXT: ld	a1, 40(sp)
; RV64-NEXT: ld	a2, 32(sp)
; RV64-NEXT: ld	a3, 24(sp)
; RV64-NEXT: ld	a4, 16(sp)
; RV64-NEXT: addi	a0, sp, 128
; RV64-NEXT: beqz	a2, .LBB0_2
; RV64-NEXT: # %bb.1:                                # %right
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 40(sp)
; RV64-NEXT: sd	a2, 32(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 16(sp)
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 192
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: ld	a0, 48(sp)
; RV64-NEXT: ld	a1, 40(sp)
; RV64-NEXT: ld	a2, 32(sp)
; RV64-NEXT: ld	a3, 24(sp)
; RV64-NEXT: ld	a4, 16(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 40(sp)
; RV64-NEXT: sd	a2, 32(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 16(sp)
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: addi	a1, sp, 124
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 192
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: slli	a3, s3, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: ld	a0, 48(sp)
; RV64-NEXT: ld	a1, 40(sp)
; RV64-NEXT: ld	a2, 32(sp)
; RV64-NEXT: ld	a3, 24(sp)
; RV64-NEXT: ld	a4, 16(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: li	a0, 23
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, -1856
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ld	ra, 2024(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 2016(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 2008(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 2000(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 1992(sp)                    # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 2032
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
; RV64-NEXT: .LBB0_2:                                # %left
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 40(sp)
; RV64-NEXT: sd	a2, 32(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 16(sp)
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: addi	a1, sp, 120
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 192
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: ld	a0, 48(sp)
; RV64-NEXT: ld	a1, 40(sp)
; RV64-NEXT: ld	a2, 32(sp)
; RV64-NEXT: ld	a3, 24(sp)
; RV64-NEXT: ld	a4, 16(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 48(sp)
; RV64-NEXT: sd	a1, 40(sp)
; RV64-NEXT: sd	a2, 32(sp)
; RV64-NEXT: sd	a3, 24(sp)
; RV64-NEXT: sd	a4, 16(sp)
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: addi	a1, sp, 124
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 192
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: slli	a3, s3, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, s3
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 56
; RV64-NEXT: ld	a0, 48(sp)
; RV64-NEXT: ld	a1, 40(sp)
; RV64-NEXT: ld	a2, 32(sp)
; RV64-NEXT: ld	a3, 24(sp)
; RV64-NEXT: ld	a4, 16(sp)
; RV64-NEXT: msettyp	m0, s2
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: li	a0, 17
; RV64-NEXT: mss.rm	m0, s0
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, -1856
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ld	ra, 2024(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 2016(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 2008(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s2, 2000(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s3, 1992(sp)                    # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 2032
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

; RV64-LABEL: cross_large_acc_stack:                  # @cross_large_acc_stack
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
; RV64-NEXT: add	a0, a0, a1
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
; RV64-NEXT: addi	sp, sp, -2032
; RV64-NEXT: sd	ra, 2024(sp)                    # 8-byte Folded Spill
; RV64-NEXT: sd	s0, 2016(sp)                    # 8-byte Folded Spill
; RV64-NEXT: sd	s1, 2008(sp)                    # 8-byte Folded Spill
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, -1888
; RV64-NEXT: sub	sp, sp, a0
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a0, 0(a0)
; RV64-NEXT: lui	a4, 2
; RV64-NEXT: addi	a3, sp, 128
; RV64-NEXT: add	a4, a3, a4
; RV64-NEXT: li	a3, 17
; RV64-NEXT: sw	a3, 128(sp)
; RV64-NEXT: li	a3, 23
; RV64-NEXT: sw	a3, -4(a4)
; RV64-NEXT: lui	s0, 262144
; RV64-NEXT: addi	s0, s0, 32
; RV64-NEXT: sd	a0, 120(sp)                     # 8-byte Folded Spill
; RV64-NEXT: msettyp	m0, s0
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: mv	s1, a1
; RV64-NEXT: mv	a0, a1
; RV64-NEXT: asettyp	acc0, s0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 160
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a2, 8(a0)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 176
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s0
; RV64-NEXT: mls.rm	m0, a0
; RV64-NEXT: sext.w	a2, a2
; RV64-NEXT: asettyp	acc0, s0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 160
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a2, 8(a0)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: agettyp	a4, acc0
; RV64-NEXT: sw	a4, 0(a1)
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 176
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: slli	a3, a2, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mss.1r	m0, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mss.1r	m1, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mss.1r	m2, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mss.1r	m3, a0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: addi	a0, sp, 128
; RV64-NEXT: beqz	a2, .LBB1_2
; RV64-NEXT: # %bb.1:                                # %right
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 160
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a2, 8(a0)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 176
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s0
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 160
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a2, 8(a0)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 176
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: slli	a3, a2, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s0
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: li	a0, 23
; RV64-NEXT: ld	a1, 120(sp)                     # 8-byte Folded Reload
; RV64-NEXT: mss.rm	m0, a1
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, -1872
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ld	ra, 2024(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 2016(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 2008(sp)                    # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 2032
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
; RV64-NEXT: .LBB1_2:                                # %left
; RV64-NEXT: call	clobber
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 160
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a2, 8(a0)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 112
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 176
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s0
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: mss.rm	m0, s1
; RV64-NEXT: sd	a0, 40(sp)
; RV64-NEXT: sd	a1, 32(sp)
; RV64-NEXT: sd	a2, 24(sp)
; RV64-NEXT: sd	a3, 16(sp)
; RV64-NEXT: sd	a4, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 160
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: ld	a2, 8(a0)
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: addi	a1, sp, 116
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: asettyp	acc0, a4
; RV64-NEXT: lw	a4, 0(a1)
; RV64-NEXT: msettyp	m0, a4
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, 176
; RV64-NEXT: add	a0, sp, a0
; RV64-NEXT: slli	a3, a2, 2
; RV64-NEXT: add	a0, a0, a3
; RV64-NEXT: mls.1r	m0, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m1, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m2, a0
; RV64-NEXT: add	a0, a0, a2
; RV64-NEXT: mls.1r	m3, a0
; RV64-NEXT: mmov.a.m	acc0, m0
; RV64-NEXT: addi	a1, sp, 48
; RV64-NEXT: ld	a0, 40(sp)
; RV64-NEXT: ld	a1, 32(sp)
; RV64-NEXT: ld	a2, 24(sp)
; RV64-NEXT: ld	a3, 16(sp)
; RV64-NEXT: ld	a4, 8(sp)
; RV64-NEXT: msettyp	m0, s0
; RV64-NEXT: mmov.m.a	m0, acc0
; RV64-NEXT: li	a0, 17
; RV64-NEXT: ld	a1, 120(sp)                     # 8-byte Folded Reload
; RV64-NEXT: mss.rm	m0, a1
; RV64-NEXT: addi	sp, sp, -16
; RV64-NEXT: sd	a0, 0(sp)
; RV64-NEXT: sd	a1, 8(sp)
; RV64-NEXT: lui	a0, 2
; RV64-NEXT: addi	a0, a0, -1872
; RV64-NEXT: add	a1, sp, a0
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: sd	a0, 0(a1)
; RV64-NEXT: ld	a0, 8(sp)
; RV64-NEXT: sd	a0, 8(a1)
; RV64-NEXT: mv	sp, a1
; RV64-NEXT: ld	a0, 0(sp)
; RV64-NEXT: ld	a1, 8(sp)
; RV64-NEXT: addi	sp, sp, 16
; RV64-NEXT: ld	ra, 2024(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s0, 2016(sp)                    # 8-byte Folded Reload
; RV64-NEXT: ld	s1, 2008(sp)                    # 8-byte Folded Reload
; RV64-NEXT: addi	sp, sp, 2032
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
