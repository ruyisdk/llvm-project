; RUN: split-file %s %t
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/input.ll > %t.ztt-profile-0.ll
; RUN: llc -mtriple=riscv32 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o - | FileCheck %s --check-prefix=UDS8
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/input.ll > %t.ztt-profile-1.ll
; RUN: llc -mtriple=riscv32 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o - | FileCheck %s --check-prefix=UDS16
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/input.ll > %t.ztt-profile-2.ll
; RUN: llc -mtriple=riscv32 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-2.ll -o - | FileCheck %s --check-prefix=UDS32
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/input.ll > %t.ztt-profile-3.ll
; RUN: llc -mtriple=riscv64 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-3.ll -o - | FileCheck %s --check-prefix=UDS8
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/input.ll > %t.ztt-profile-4.ll
; RUN: llc -mtriple=riscv64 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-4.ll -o - | FileCheck %s --check-prefix=UDS16
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/input.ll > %t.ztt-profile-5.ll
; RUN: llc -mtriple=riscv64 -mattr=+m,+ztt -verify-machineinstrs %t.ztt-profile-5.ll -o - | FileCheck %s --check-prefix=UDS32
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/pair2.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=PAIR2
; PAIR2-LABEL: pair2:
; PAIR2-NEXT: # %bb.0:
; PAIR2-NEXT: mcolunzip.ew m0, m1
; PAIR2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/pair4.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=PAIR4
; PAIR4-LABEL: pair4:
; PAIR4-NEXT: # %bb.0:
; PAIR4-NEXT: mcolunzip.ew m0, m2
; PAIR4-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/pair8.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=PAIR8
; PAIR8-LABEL: pair8:
; PAIR8-NEXT: # %bb.0:
; PAIR8-NEXT: mcolunzip.ew m0, m4
; PAIR8-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/pair16.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=PAIR16
; PAIR16-LABEL: pair16:
; PAIR16-NEXT: # %bb.0:
; PAIR16-NEXT: mcolunzip.ew m0, m8
; PAIR16-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/pair32.mir > %t.ztt-profile-10.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-10.mir -o - | FileCheck %s --check-prefix=PAIR32
; PAIR32-LABEL: pair32:
; PAIR32-NEXT: # %bb.0:
; PAIR32-NEXT: mcolunzip.ew m0, m16
; PAIR32-NEXT: ret

; Expected: two square leaders, one pair instruction, and exactly two
; square COPYs only when the original value remains live. Address steps are
; N*N*4 bytes, independent of UDS; continuation registers are not extra squares.
; UDS32-LABEL: dead_source:
; UDS32-NEXT: # %bb.0:
; UDS32-NEXT: lui a0, 262144
; UDS32-NEXT: addi a0, a0, 32
; UDS32-NEXT: msettyp m0, a0
; UDS32-NEXT: msettyp m1, a0
; UDS32-NEXT: mzero.2d.m m0
; UDS32-NEXT: mzero.2d.m m1
; UDS32-NEXT: mcolunzip.ew m0, m1
; UDS32-NEXT: ret

; UDS32-LABEL: live_source:
; UDS32-NEXT: # %bb.0:
; UDS32-NEXT: csrr a2, amenlen
; UDS32-NEXT: mul a2, a2, a2
; UDS32-NEXT: lui a3, 262144
; UDS32-NEXT: addi a3, a3, 32
; UDS32-NEXT: msettyp m0, a3
; UDS32-NEXT: msettyp m1, a3
; UDS32-NEXT: mzero.2d.m m0
; UDS32-NEXT: mzero.2d.m m1
; UDS32-NEXT: mgettyp a3, m0
; UDS32-NEXT: msettyp m2, a3
; UDS32-NEXT: mmov.m.m m2, m0
; UDS32-NEXT: mgettyp a3, m1
; UDS32-NEXT: msettyp m3, a3
; UDS32-NEXT: mmov.m.m m3, m1
; UDS32-NEXT: mcolunzip.ew m2, m3
; UDS32-NEXT: slli a2, a2, 2
; UDS32-NEXT: mss.rm m2, a0
; UDS32-NEXT: add a0, a0, a2
; UDS32-NEXT: mss.rm m3, a0
; UDS32-NEXT: mss.rm m0, a1
; UDS32-NEXT: add a1, a1, a2
; UDS32-NEXT: mss.rm m1, a1
; UDS32-NEXT: ret

; UDS16-LABEL: dead_source:
; UDS16-NEXT: # %bb.0:
; UDS16-NEXT: lui a0, 262144
; UDS16-NEXT: addi a0, a0, 32
; UDS16-NEXT: msettyp m0, a0
; UDS16-NEXT: msettyp m2, a0
; UDS16-NEXT: mzero.2d.m m0
; UDS16-NEXT: mzero.2d.m m2
; UDS16-NEXT: mcolunzip.ew m0, m2
; UDS16-NEXT: ret

; UDS16-LABEL: live_source:
; UDS16-NEXT: # %bb.0:
; UDS16-NEXT: csrr a2, amenlen
; UDS16-NEXT: mul a2, a2, a2
; UDS16-NEXT: lui a3, 262144
; UDS16-NEXT: addi a3, a3, 32
; UDS16-NEXT: msettyp m0, a3
; UDS16-NEXT: msettyp m2, a3
; UDS16-NEXT: mzero.2d.m m0
; UDS16-NEXT: mzero.2d.m m2
; UDS16-NEXT: mgettyp a3, m0
; UDS16-NEXT: msettyp m4, a3
; UDS16-NEXT: mmov.m.m m4, m0
; UDS16-NEXT: mgettyp a3, m2
; UDS16-NEXT: msettyp m6, a3
; UDS16-NEXT: mmov.m.m m6, m2
; UDS16-NEXT: mcolunzip.ew m4, m6
; UDS16-NEXT: slli a2, a2, 2
; UDS16-NEXT: mss.rm m4, a0
; UDS16-NEXT: add a0, a0, a2
; UDS16-NEXT: mss.rm m6, a0
; UDS16-NEXT: mss.rm m0, a1
; UDS16-NEXT: add a1, a1, a2
; UDS16-NEXT: mss.rm m2, a1
; UDS16-NEXT: ret

; UDS8-LABEL: dead_source:
; UDS8-NEXT: # %bb.0:
; UDS8-NEXT: lui a0, 262144
; UDS8-NEXT: addi a0, a0, 32
; UDS8-NEXT: msettyp m0, a0
; UDS8-NEXT: msettyp m4, a0
; UDS8-NEXT: mzero.2d.m m0
; UDS8-NEXT: mzero.2d.m m4
; UDS8-NEXT: mcolunzip.ew m0, m4
; UDS8-NEXT: ret

; UDS8-LABEL: live_source:
; UDS8-NEXT: # %bb.0:
; UDS8-NEXT: csrr a2, amenlen
; UDS8-NEXT: mul a2, a2, a2
; UDS8-NEXT: lui a3, 262144
; UDS8-NEXT: addi a3, a3, 32
; UDS8-NEXT: msettyp m0, a3
; UDS8-NEXT: msettyp m4, a3
; UDS8-NEXT: mzero.2d.m m0
; UDS8-NEXT: mzero.2d.m m4
; UDS8-NEXT: mgettyp a3, m0
; UDS8-NEXT: msettyp m8, a3
; UDS8-NEXT: mmov.m.m m8, m0
; UDS8-NEXT: mgettyp a3, m4
; UDS8-NEXT: msettyp m12, a3
; UDS8-NEXT: mmov.m.m m12, m4
; UDS8-NEXT: mcolunzip.ew m8, m12
; UDS8-NEXT: slli a2, a2, 2
; UDS8-NEXT: mss.rm m8, a0
; UDS8-NEXT: add a0, a0, a2
; UDS8-NEXT: mss.rm m12, a0
; UDS8-NEXT: mss.rm m0, a1
; UDS8-NEXT: add a1, a1, a2
; UDS8-NEXT: mss.rm m4, a1
; UDS8-NEXT: ret
; A dead source coalesces with the tied result, with no metadata reset or COPY.
;--- input.ll
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.pair(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcolunzip.ew.pair(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.rm.pair(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @dead_source() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.pair(i32 1073741856, i32 2)
  %dst = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcolunzip.ew.pair(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %dst
}

; Both snapshots are observable; the original must survive the destructive op.
define void @live_source(ptr %out, ptr %old) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.pair(i32 1073741856, i32 2)
  %dst = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mcolunzip.ew.pair(target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.pair(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 2) %dst, i32 1073741856, i32 2)
  call void @llvm.riscv.ztt.mss.rm.pair(ptr %old, target("riscv.ztt.m.i32", i32, 32, 1, 2) %src, i32 1073741856, i32 2)
  ret void
}

;--- pair2.mir
--- |
  define void @pair2() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: pair2
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2
    $zttm0m2 = PseudoZTT_mcolunzip_ew_G002 $zttm0m2, 1073741856, 1, 1
    PseudoRET implicit $zttm0m2
...

;--- pair4.mir
--- |
  define void @pair4() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: pair4
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m4
    $zttm0m4 = PseudoZTT_mcolunzip_ew_G004 $zttm0m4, 1073741856, 1, 2
    PseudoRET implicit $zttm0m4
...

;--- pair8.mir
--- |
  define void @pair8() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: pair8
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m8
    $zttm0m8 = PseudoZTT_mcolunzip_ew_G008 $zttm0m8, 1073741856, 1, 4
    PseudoRET implicit $zttm0m8
...

;--- pair16.mir
--- |
  define void @pair16() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: pair16
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m16
    $zttm0m16 = PseudoZTT_mcolunzip_ew_G016 $zttm0m16, 1073741888, 1, 8
    PseudoRET implicit $zttm0m16
...

;--- pair32.mir
--- |
  define void @pair32() nounwind "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: pair32
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m32
    $zttm0m32 = PseudoZTT_mcolunzip_ew_G032 $zttm0m32, 1073741952, 1, 16
    PseudoRET implicit $zttm0m32
...
