; RUN: llc -O0 -mtriple=riscv64 -verify-machineinstrs %s -o - | FileCheck %s
; RUN: llc -O0 -mtriple=riscv64 -verify-machineinstrs -print-after=riscv-ztt-promote-allocas %s -o /dev/null 2>&1 | FileCheck %s --check-prefix=IR
; RUN: llc -enable-new-pm -O0 -mtriple=riscv64 -stop-before=riscv-isel %s -o - | FileCheck %s --check-prefix=IR
;
; Required promotion at optnone, including ACC and control-flow merges.
; The scalar alloca must remain: this is not general -O0 mem2reg.
; These are local values, not matrix C parameters or return values.

define void @matrix_local(ptr %p) #0 {
; CHECK-LABEL: matrix_local:
; CHECK-NEXT: # %bb.0:                                # %entry
; CHECK-NEXT: lui a1, 262144
; CHECK-NEXT: addi a1, a1, 16
; CHECK-NEXT: msettyp m0, a1
; CHECK-NEXT: mzero.2d.m m0
; CHECK-NEXT: li a1, 0
; CHECK-NEXT: mss.rm m0, a0
; CHECK-NEXT: ret
; IR-LABEL: define void @matrix_local(
; IR-NOT: alloca
; IR: call void @llvm.riscv.ztt.mss.rm
entry:
  %a = alloca target("riscv.ztt.m.i16", i16, 16, 1, 2), align 2
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  store target("riscv.ztt.m.i16", i16, 16, 1, 2) %v, ptr %a, align 2
  %r = load target("riscv.ztt.m.i16", i16, 16, 1, 2), ptr %a, align 2
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 2) %r, i32 1073741840, i32 2)
  ret void
}

define void @acc_merge(ptr %p, i1 %cond) #0 {
; CHECK-LABEL: acc_merge:
; CHECK-NEXT: # %bb.0:                                # %entry
; CHECK-NEXT: addi sp, sp, -48
; CHECK-NEXT: sd a0, 0(sp)
; CHECK-NEXT: sd a1, 8(sp)
; CHECK-NEXT: sd a2, 16(sp)
; CHECK-NEXT: sd a3, 24(sp)
; CHECK-NEXT: sd a4, 32(sp)
; CHECK-NEXT: csrr a2, amenlen
; CHECK-NEXT: mul a1, a2, a2
; CHECK-NEXT: slli a1, a1, 2
; CHECK-NEXT: li a0, 0
; CHECK-NEXT: add a0, a0, a1
; CHECK-NEXT: slli a0, a0, 1
; CHECK-NEXT: slli a0, a0, 1
; CHECK-NEXT: slli a0, a0, 1
; CHECK-NEXT: add a0, a0, a1
; CHECK-NEXT: slli a0, a0, 1
; CHECK-NEXT: addi a0, a0, 15
; CHECK-NEXT: andi a0, a0, -16
; CHECK-NEXT: addi a0, a0, 64
; CHECK-NEXT: mv a4, sp
; CHECK-NEXT: sub sp, sp, a0
; CHECK-NEXT: sd a0, 48(sp)
; CHECK-NEXT: sd a1, 56(sp)
; CHECK-NEXT: ld a0, 0(a4)
; CHECK-NEXT: ld a1, 8(a4)
; CHECK-NEXT: ld a2, 16(a4)
; CHECK-NEXT: ld a3, 24(a4)
; CHECK-NEXT: ld a4, 32(a4)
; CHECK-NEXT: addi sp, sp, 48
; CHECK-NEXT: addi sp, sp, -128
; CHECK-NEXT: sd ra, 120(sp)                     # 8-byte Folded Spill
; CHECK-NEXT: ld ra, 136(sp)
; CHECK-NEXT: sd a0, 104(sp)                     # 8-byte Folded Spill
; CHECK-NEXT: andi a0, a1, 1
; CHECK-NEXT: lui a1, 262144
; CHECK-NEXT: addi a1, a1, 32
; CHECK-NEXT: asettyp acc0, a1
; CHECK-NEXT: asettyp acc1, a1
; CHECK-NEXT: mzero.2d.acc acc0
; CHECK-NEXT: mzero.2d.acc acc1
; CHECK-NEXT: sd a0, 32(sp)
; CHECK-NEXT: sd a1, 24(sp)
; CHECK-NEXT: sd a2, 16(sp)
; CHECK-NEXT: sd a3, 8(sp)
; CHECK-NEXT: sd a4, 0(sp)
; CHECK-NEXT: addi a1, sp, 40
; CHECK-NEXT: addi a1, sp, 112
; CHECK-NEXT: agettyp a4, acc0
; CHECK-NEXT: sw a4, 0(a1)
; CHECK-NEXT: agettyp a4, acc1
; CHECK-NEXT: sw a4, 4(a1)
; CHECK-NEXT: lw a4, 0(a1)
; CHECK-NEXT: msettyp m0, a4
; CHECK-NEXT: mmov.m.a m0, acc0
; CHECK-NEXT: addi a0, sp, 144
; CHECK-NEXT: mss.1r m0, a0
; CHECK-NEXT: lw a4, 4(a1)
; CHECK-NEXT: msettyp m0, a4
; CHECK-NEXT: mmov.m.a m0, acc1
; CHECK-NEXT: addi a0, sp, 144
; CHECK-NEXT: slli a3, ra, 0
; CHECK-NEXT: add a0, a0, a3
; CHECK-NEXT: mss.1r m0, a0
; CHECK-NEXT: addi a1, sp, 40
; CHECK-NEXT: ld a0, 32(sp)
; CHECK-NEXT: ld a1, 24(sp)
; CHECK-NEXT: ld a2, 16(sp)
; CHECK-NEXT: ld a3, 8(sp)
; CHECK-NEXT: ld a4, 0(sp)
; CHECK-NEXT: beqz a0, .LBB1_2
; CHECK-NEXT: j .LBB1_1
; CHECK-NEXT: .LBB1_1:                                # %replace
; CHECK-NEXT: lui a0, 262144
; CHECK-NEXT: addi a0, a0, 32
; CHECK-NEXT: asettyp acc0, a0
; CHECK-NEXT: asettyp acc1, a0
; CHECK-NEXT: mzero.2d.acc acc0
; CHECK-NEXT: mzero.2d.acc acc1
; CHECK-NEXT: sd a0, 32(sp)
; CHECK-NEXT: sd a1, 24(sp)
; CHECK-NEXT: sd a2, 16(sp)
; CHECK-NEXT: sd a3, 8(sp)
; CHECK-NEXT: sd a4, 0(sp)
; CHECK-NEXT: addi a1, sp, 40
; CHECK-NEXT: addi a1, sp, 112
; CHECK-NEXT: agettyp a4, acc0
; CHECK-NEXT: sw a4, 0(a1)
; CHECK-NEXT: agettyp a4, acc1
; CHECK-NEXT: sw a4, 4(a1)
; CHECK-NEXT: lw a4, 0(a1)
; CHECK-NEXT: msettyp m0, a4
; CHECK-NEXT: mmov.m.a m0, acc0
; CHECK-NEXT: addi a0, sp, 144
; CHECK-NEXT: mss.1r m0, a0
; CHECK-NEXT: lw a4, 4(a1)
; CHECK-NEXT: msettyp m0, a4
; CHECK-NEXT: mmov.m.a m0, acc1
; CHECK-NEXT: addi a0, sp, 144
; CHECK-NEXT: slli a3, ra, 0
; CHECK-NEXT: add a0, a0, a3
; CHECK-NEXT: mss.1r m0, a0
; CHECK-NEXT: addi a1, sp, 40
; CHECK-NEXT: ld a0, 32(sp)
; CHECK-NEXT: ld a1, 24(sp)
; CHECK-NEXT: ld a2, 16(sp)
; CHECK-NEXT: ld a3, 8(sp)
; CHECK-NEXT: ld a4, 0(sp)
; CHECK-NEXT: j .LBB1_2
; CHECK-NEXT: .LBB1_2:                                # %merge
; CHECK-NEXT: ld a0, 104(sp)                     # 8-byte Folded Reload
; CHECK-NEXT: sd a0, 32(sp)
; CHECK-NEXT: sd a1, 24(sp)
; CHECK-NEXT: sd a2, 16(sp)
; CHECK-NEXT: sd a3, 8(sp)
; CHECK-NEXT: sd a4, 0(sp)
; CHECK-NEXT: addi a1, sp, 40
; CHECK-NEXT: addi a1, sp, 112
; CHECK-NEXT: lw a4, 0(a1)
; CHECK-NEXT: asettyp acc0, a4
; CHECK-NEXT: lw a4, 4(a1)
; CHECK-NEXT: asettyp acc1, a4
; CHECK-NEXT: lw a4, 0(a1)
; CHECK-NEXT: msettyp m0, a4
; CHECK-NEXT: addi a0, sp, 144
; CHECK-NEXT: mls.1r m0, a0
; CHECK-NEXT: mmov.a.m acc0, m0
; CHECK-NEXT: lw a4, 4(a1)
; CHECK-NEXT: msettyp m0, a4
; CHECK-NEXT: addi a0, sp, 144
; CHECK-NEXT: slli a3, ra, 0
; CHECK-NEXT: add a0, a0, a3
; CHECK-NEXT: mls.1r m0, a0
; CHECK-NEXT: mmov.a.m acc1, m0
; CHECK-NEXT: addi a1, sp, 40
; CHECK-NEXT: ld a0, 32(sp)
; CHECK-NEXT: ld a1, 24(sp)
; CHECK-NEXT: ld a2, 16(sp)
; CHECK-NEXT: ld a3, 8(sp)
; CHECK-NEXT: ld a4, 0(sp)
; CHECK-NEXT: lui a1, 262144
; CHECK-NEXT: addi a1, a1, 32
; CHECK-NEXT: msettyp m0, a1
; CHECK-NEXT: mmov.m.a m0, acc0
; CHECK-NEXT: msettyp m1, a1
; CHECK-NEXT: mmov.m.a m1, acc1
; CHECK-NEXT: csrr a1, amenlen
; CHECK-NEXT: mul a1, a1, a1
; CHECK-NEXT: slli a1, a1, 2
; CHECK-NEXT: mss.rm m0, a0
; CHECK-NEXT: add a0, a0, a1
; CHECK-NEXT: mss.rm m1, a0
; CHECK-NEXT: ld ra, 120(sp)                     # 8-byte Folded Reload
; CHECK-NEXT: addi sp, sp, 128
; CHECK-NEXT: addi sp, sp, -16
; CHECK-NEXT: sd a0, 0(sp)
; CHECK-NEXT: sd a1, 8(sp)
; CHECK-NEXT: ld a0, 16(sp)
; CHECK-NEXT: add a1, sp, a0
; CHECK-NEXT: ld a0, 0(sp)
; CHECK-NEXT: sd a0, 0(a1)
; CHECK-NEXT: ld a0, 8(sp)
; CHECK-NEXT: sd a0, 8(a1)
; CHECK-NEXT: mv sp, a1
; CHECK-NEXT: ld a0, 0(sp)
; CHECK-NEXT: ld a1, 8(sp)
; CHECK-NEXT: addi sp, sp, 16
; CHECK-NEXT: ret
; IR-LABEL: define void @acc_merge(
; IR-NOT: alloca
; IR: merge:
; IR-NEXT: %{{.*}} = phi target("riscv.ztt.acc.i32", i32, 32, 2)
entry:
  %a = alloca target("riscv.ztt.acc.i32", i32, 32, 2), align 4
  %v = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.i32_i32_32_2t(i32 1073741856, i32 2)
  store target("riscv.ztt.acc.i32", i32, 32, 2) %v, ptr %a, align 4
  br i1 %cond, label %replace, label %merge
replace:
  %w = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.i32_i32_32_2t(i32 1073741856, i32 2)
  store target("riscv.ztt.acc.i32", i32, 32, 2) %w, ptr %a, align 4
  br label %merge
merge:
  %r = load target("riscv.ztt.acc.i32", i32, 32, 2), ptr %a, align 4
  %m = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2) %r, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %p, target("riscv.ztt.m.i32", i32, 32, 1, 2) %m, i32 1073741856, i32 2)
  ret void
}

define i32 @scalar_local(i32 %v) #0 {
; CHECK-LABEL: scalar_local:
; CHECK-NEXT: # %bb.0:                                # %entry
; CHECK-NEXT: addi sp, sp, -16
; CHECK-NEXT: sw a0, 12(sp)
; CHECK-NEXT: lw a0, 12(sp)
; CHECK-NEXT: addi sp, sp, 16
; CHECK-NEXT: ret
; IR-LABEL: define i32 @scalar_local(
; IR: %a = alloca i32, align 4
; IR-NEXT: store i32 %v, ptr %a, align 4
; IR-NEXT: %r = load i32, ptr %a, align 4
entry:
  %a = alloca i32, align 4
  store i32 %v, ptr %a, align 4
  %r = load i32, ptr %a, align 4
  ret i32 %r
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.i32_i32_32_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.acc.i32_i32_32_2t(target("riscv.ztt.acc.i32", i32, 32, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
; Even a promotable target-typed alloca is untouched when this function has
; disabled Ztt. The unused object does not require matrix instruction lowering.
define void @no_ztt() #1 {
; CHECK-LABEL: no_ztt:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: addi sp, sp, -16
; CHECK-NEXT: addi sp, sp, 16
; CHECK-NEXT: ret
; IR-LABEL: define void @no_ztt(
; IR: %a = alloca target("riscv.ztt.m.i16", i16, 16, 1, 2), align 2
  %a = alloca target("riscv.ztt.m.i16", i16, 16, 1, 2), align 2
  ret void
}

attributes #0 = { noinline nounwind optnone "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a4" }
attributes #1 = { noinline nounwind optnone "target-features"="-zttuds32b,-zttm16,-ztta4,-ztt" }
