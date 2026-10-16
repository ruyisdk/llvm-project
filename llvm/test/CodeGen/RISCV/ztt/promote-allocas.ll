; RUN: llc -O0 -mtriple=riscv32 -stop-before=riscv-isel %s -o - | FileCheck %s
; RUN: llc -O0 -mtriple=riscv64 -stop-before=riscv-isel %s -o - | FileCheck %s
; RUN: llc -enable-new-pm -O0 -mtriple=riscv32 -stop-before=riscv-isel %s -o - | FileCheck %s
; RUN: llc -enable-new-pm -O0 -mtriple=riscv64 -stop-before=riscv-isel %s -o - | FileCheck %s

; Matrix locals are promoted even at optnone. Ordinary scalar locals remain.
define void @matrix_local(ptr %p) #0 {
; CHECK-LABEL: define void @matrix_local(
; CHECK-NEXT: entry:
; CHECK-NEXT: %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m
; CHECK-NEXT: call void @llvm.riscv.ztt.mss.rm{{.*}} %v,
; CHECK-NEXT: ret void
; CHECK-NEXT: }
entry:
  %a = alloca target("riscv.ztt.m.i16", i16, 16, 1, 2), align 2
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  store target("riscv.ztt.m.i16", i16, 16, 1, 2) %v, ptr %a, align 2
  %r = load target("riscv.ztt.m.i16", i16, 16, 1, 2), ptr %a, align 2
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 2) %r, i32 1073741840, i32 2)
  ret void
}

define target("riscv.ztt.acc.i32", i32, 32, 1) @acc_local() #0 {
; CHECK-LABEL: define target("riscv.ztt.acc.i32", i32, 32, 1) @acc_local(
; CHECK-NEXT: entry:
; CHECK-NEXT: %v = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mzero.acc
; CHECK-NEXT: ret target("riscv.ztt.acc.i32", i32, 32, 1) %v
; CHECK-NEXT: }
entry:
  %a = alloca target("riscv.ztt.acc.i32", i32, 32, 1), align 4
  %v = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.i32_i32_32_1t(i32 1073741856, i32 1)
  store target("riscv.ztt.acc.i32", i32, 32, 1) %v, ptr %a, align 4
  %r = load target("riscv.ztt.acc.i32", i32, 32, 1), ptr %a, align 4
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %r
}

define i32 @scalar_local(i32 %v) #0 {
; CHECK-LABEL: define i32 @scalar_local(
; CHECK-NEXT: entry:
; CHECK-NEXT: %a = alloca i32, align 4
; CHECK-NEXT: store i32 %v, ptr %a, align 4
; CHECK-NEXT: %r = load i32, ptr %a, align 4
; CHECK-NEXT: ret i32 %r
; CHECK-NEXT: }
entry:
  %a = alloca i32, align 4
  store i32 %v, ptr %a, align 4
  %r = load i32, ptr %a, align 4
  ret i32 %r
}

define i32 @without_ztt(i32 %v) #1 {
; CHECK-LABEL: define i32 @without_ztt(
; CHECK-NEXT: entry:
; CHECK-NEXT: %a = alloca i32, align 4
; CHECK-NEXT: store i32 %v, ptr %a, align 4
; CHECK-NEXT: %r = load i32, ptr %a, align 4
; CHECK-NEXT: ret i32 %r
; CHECK-NEXT: }
entry:
  %a = alloca i32, align 4
  store i32 %v, ptr %a, align 4
  %r = load i32, ptr %a, align 4
  ret i32 %r
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mzero.acc.triscv.ztt.acc.i32_i32_32_1t(i32 immarg, i32 immarg)

attributes #0 = { noinline nounwind optnone "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a4" }
attributes #1 = { noinline nounwind optnone }
