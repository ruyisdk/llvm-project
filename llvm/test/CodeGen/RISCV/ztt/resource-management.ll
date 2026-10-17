; RUN: split-file %s %t
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/resource-management-ll/input.ll > %t.ztt-profile-0.ll
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs < %t.ztt-profile-0.ll | FileCheck %t/resource-management-ll/input.ll
; RUN: sed 's/i64/i32/g' %t/resource-management-ll/input.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs | FileCheck %t/resource-management-ll/input.ll
; RUN: opt -passes='default<O2>' -S %t/resource-management-ll/input.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs | FileCheck %t/resource-management-ll/input.ll
; RUN: sed 's/i64/i32/g' %t/resource-management-ll/input.ll | opt -passes='default<O2>' -S | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs | FileCheck %t/resource-management-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/resource-management-invalid-ll/tmp/wide.ll > %t.ztt-profile-1.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o /dev/null 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=WIDE
; RUN: sed 's/i64/i32/g' %t/resource-management-invalid-ll/tmp/wide.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=NARROW
; RUN: not opt -passes=verify -disable-output %t/resource-management-invalid-ll/tmp/mismatch.ll 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=TYPE
; RUN: sed 's/ "riscv-ztt-profile"="ZTT_PROFILE"//' %t/resource-management-invalid-ll/tmp/wide.ll | not --crash llc -mtriple=riscv64 -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=ACQUIRE-FEATURE
; RUN: sed -e 's/i64/i32/g' -e 's/ "riscv-ztt-profile"="ZTT_PROFILE"//' %t/resource-management-invalid-ll/tmp/wide.ll | not --crash llc -mtriple=riscv32 -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=ACQUIRE-FEATURE
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/resource-management-invalid-ll/tmp/release.ll -o /dev/null 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=RELEASE-FEATURE
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/resource-management-invalid-ll/tmp/release.ll -o /dev/null 2>&1 | FileCheck %t/resource-management-invalid-ll/checks.txt --check-prefix=RELEASE-FEATURE

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- resource-management-ll/input.ll
declare i64 @llvm.riscv.ztt.ame.acquire.i64(i64)
declare void @llvm.riscv.ztt.ame.release()
declare i64 @llvm.riscv.ztt.get.ameown.i64()

define i64 @acquire_dynamic(i64 %desc) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: acquire_dynamic:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: ame.acquire a0, a0
; CHECK-NEXT: ret
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 %desc)
  ret i64 %r
}

define i64 @acquire_try() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: acquire_try:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: ame.acquire a0, zero
; CHECK-NEXT: ret
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 0)
  ret i64 %r
}

define i64 @acquire_bounded() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: acquire_bounded:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: li a0, 1
; CHECK-NEXT: ame.acquire a0, a0
; CHECK-NEXT: ret
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 1)
  ret i64 %r
}

; Descriptor validation belongs to hardware; do not fold this to BAD_DESC.
define i64 @acquire_reserved() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: acquire_reserved:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: li a0, 64
; CHECK-NEXT: ame.acquire a0, a0
; CHECK-NEXT: ret
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 64)
  ret i64 %r
}

define void @release_twice() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: release_twice:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: ame.release
; CHECK-NEXT: ame.release
; CHECK-NEXT: ret
  call void @llvm.riscv.ztt.ame.release()
  call void @llvm.riscv.ztt.ame.release()
  ret void
}

; A discarded result still attempts acquisition. It is not a pure query.
define void @acquire_twice() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: acquire_twice:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: ame.acquire zero, zero
; CHECK-NEXT: ame.acquire zero, zero
; CHECK-NEXT: ret
  %a = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 0)
  %b = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 0)
  ret void
}

; Observe ownership in source order; do not infer success or insert retries.
define i64 @ownership_sequence() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: ownership_sequence:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr zero, ameown
; CHECK-NEXT: ame.acquire zero, zero
; CHECK-NEXT: csrr zero, ameown
; CHECK-NEXT: ame.release
; CHECK-NEXT: csrr a0, ameown
; CHECK-NEXT: ret
  %before = call i64 @llvm.riscv.ztt.get.ameown.i64()
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 0)
  %during = call i64 @llvm.riscv.ztt.get.ameown.i64()
  call void @llvm.riscv.ztt.ame.release()
  %after = call i64 @llvm.riscv.ztt.get.ameown.i64()
  ret i64 %after
}

; Keep ordinary stores before release and later loads after release. Even a
; store that would otherwise be dead must be visible when release drains it.
define i32 @memory_sequence(ptr %p) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: memory_sequence:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: li a1, 7
; CHECK-NEXT: sw a1, 0(a0)
; CHECK-NEXT: ame.release
; CHECK-NEXT: lw a0, 0(a0)
; CHECK-NEXT: ret
  store i32 7, ptr %p
  call void @llvm.riscv.ztt.ame.release()
  %r = load i32, ptr %p
  ret i32 %r
}

define i32 @memory_acquire_sequence(ptr %p) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: memory_acquire_sequence:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: li a1, 7
; CHECK-NEXT: sw a1, 0(a0)
; CHECK-NEXT: ame.acquire zero, zero
; CHECK-NEXT: lw a0, 0(a0)
; CHECK-NEXT: ret
  store i32 7, ptr %p
  %acquired = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 0)
  %r = load i32, ptr %p
  ret i32 %r
}

;--- resource-management-invalid-ll/checks.txt
; WIDE: ExpandIntegerResult
; WIDE-SAME: i64,ch = llvm.riscv.ztt.ame.acquire
; WIDE: LLVM ERROR: Do not know how to expand the result of this operator!
; NARROW: PromoteIntegerResult
; NARROW-SAME: i32,ch = llvm.riscv.ztt.ame.acquire
; NARROW: LLVM ERROR: Do not know how to promote this operator!
; TYPE: intrinsic argument 0 type (matching overload type 0) expected i64, but got i32
; TYPE-NEXT: declare i64 @llvm.riscv.ztt.ame.acquire.i64(i32)
; ACQUIRE-FEATURE: LLVM ERROR: Cannot select: intrinsic %llvm.riscv.ztt.ame.acquire
; RELEASE-FEATURE: LLVM ERROR: Cannot select: intrinsic %llvm.riscv.ztt.ame.release

;--- resource-management-invalid-ll/tmp/wide.ll
define i64 @acquire(i64 %desc) "riscv-ztt-profile"="ZTT_PROFILE" {
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 %desc)
  ret i64 %r
}
declare i64 @llvm.riscv.ztt.ame.acquire.i64(i64)

;--- resource-management-invalid-ll/tmp/mismatch.ll
define i64 @wrong_argument(i32 %desc) {
  %r = call i64 @llvm.riscv.ztt.ame.acquire.i64(i32 %desc)
  ret i64 %r
}
declare i64 @llvm.riscv.ztt.ame.acquire.i64(i32)

;--- resource-management-invalid-ll/tmp/release.ll
define void @release() {
  call void @llvm.riscv.ztt.ame.release()
  ret void
}
declare void @llvm.riscv.ztt.ame.release()
