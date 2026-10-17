; RUN: split-file %s %t
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-ll/input.ll > %t.ztt-profile-0.ll
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs < %t.ztt-profile-0.ll | FileCheck %t/internal-copy-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-ll/input.ll > %t.ztt-profile-1.ll
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs < %t.ztt-profile-1.ll | FileCheck %t/internal-copy-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-ll/input.ll > %t.ztt-profile-2.ll
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -stop-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.ll -o %t/internal-copy-ll/tmp.rv32.mir
; RUN: llc -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t/internal-copy-ll/tmp.rv32.mir -o - | FileCheck %t/internal-copy-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-ll/input.ll > %t.ztt-profile-3.ll
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -stop-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.ll -o %t/internal-copy-ll/tmp.rv64.mir
; RUN: llc -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t/internal-copy-ll/tmp.rv64.mir -o - | FileCheck %t/internal-copy-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-mir/input.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %t/internal-copy-mir/input.mir
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-mir/input.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %t/internal-copy-mir/input.mir
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-invalid-mir/tmp/unknown.mir > %t.ztt-profile-6.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - 2>&1 | FileCheck %t/internal-copy-invalid-mir/checks.txt --check-prefix=UNKNOWN
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-invalid-mir/tmp/conflict.mir > %t.ztt-profile-7.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - 2>&1 | FileCheck %t/internal-copy-invalid-mir/checks.txt --check-prefix=UNKNOWN
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-invalid-mir/tmp/inconsistent.mir > %t.ztt-profile-8.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - 2>&1 | FileCheck %t/internal-copy-invalid-mir/checks.txt --check-prefix=INCONSISTENT
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-scratch-mir/input.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %t/internal-copy-scratch-mir/input.mir --check-prefixes=MIR,RV32
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-scratch-mir/input.mir > %t.ztt-profile-10.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-10.mir -o - | FileCheck %t/internal-copy-scratch-mir/input.mir --check-prefixes=MIR,RV64
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-scratch-mir/input.mir > %t.ztt-profile-11.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-11.mir -o - | FileCheck %t/internal-copy-scratch-mir/input.mir --check-prefixes=ASM,ASM32
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/internal-copy-scratch-mir/input.mir > %t.ztt-profile-12.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-12.mir -o - | FileCheck %t/internal-copy-scratch-mir/input.mir --check-prefixes=ASM,ASM64
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/copy-identity-mir/input.mir > %t.ztt-profile-13.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-13.mir -o - | FileCheck %t/copy-identity-mir/input.mir
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/copy-overlap-mir/tmp/copy.mir > %t.ztt-profile-14.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-14.mir -o - 2>&1 | FileCheck %t/copy-overlap-mir/checks.txt
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/copy-overlap-mir/tmp/concat.mir > %t.ztt-profile-15.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-15.mir -o - 2>&1 | FileCheck %t/copy-overlap-mir/checks.txt

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- internal-copy-ll/input.ll
; Exercise the existing small-M parameter prototype, without changing the ABI.
; No producing intrinsic supplies a temporary register or a square stride.
; All three values occupy two M registers but wide needs only one move.
define target("riscv.ztt.m.i16", i16, 16, 1, 2) @standard(
    target("riscv.ztt.m.i16", i16, 16, 1, 2) %a,
    target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: standard:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %b
}

define target("riscv.ztt.m.i32", i32, 32, 1, 1) @wide(
    target("riscv.ztt.m.i32", i32, 32, 1, 1) %a,
    target("riscv.ztt.m.i32", i32, 32, 1, 1) %b) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: wide:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %b
}

define target("riscv.ztt.m.i8", i8, 8, 1, 4) @packed_concat(
    target("riscv.ztt.m.i8", i8, 8, 1, 4) %a,
    target("riscv.ztt.m.i8", i8, 8, 1, 4) %b) nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: packed_concat:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  ret target("riscv.ztt.m.i8", i8, 8, 1, 4) %b
}

;--- internal-copy-mir/input.mir
# The same two-register group can hold either two standard squares or one
# wide square. An internal COPY must preserve Md and use square-sized moves.
# Keep x10 live across each COPY: scratch selection must not clobber it.
--- |
  define void @standard_nonadjacent() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @wide_cross_block() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @identity_unknown() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @loop_layout() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: standard_nonadjacent
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    ; CHECK-LABEL: name: standard_nonadjacent
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm0 = ZTT_MSETTYP $x10
    ; CHECK-NEXT: $zttm1 = ZTT_MSETTYP $x10
    ; CHECK-NEXT: $x12 = ADDI $x10, 1
    ; CHECK-NEXT: $x11 = ZTT_MGETTYP $zttm0
    ; CHECK-NEXT: $zttm2 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm2 = ZTT_MMOV_M_M $zttm0
    ; CHECK-NEXT: $x11 = ZTT_MGETTYP $zttm1
    ; CHECK-NEXT: $zttm3 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm3 = ZTT_MMOV_M_M $zttm1
    ; CHECK-NEXT: PseudoRET implicit $zttm2m2, implicit $x10, implicit $x12
    $zttm0 = ZTT_MSETTYP $x10
    $zttm1 = ZTT_MSETTYP $x10
    $x12 = ADDI $x10, 1
    $zttm2m2 = COPY $zttm0m2
    PseudoRET implicit $zttm2m2, implicit $x10, implicit $x12
...
---
name: wide_cross_block
tracksRegLiveness: true
body: |
  bb.0:
    successors: %bb.1
    liveins: $x10
    ; CHECK-LABEL: name: wide_cross_block
    ; CHECK: bb.0:
    ; CHECK-NEXT: successors: %bb.1(0x80000000)
    ; CHECK-NEXT: liveins: $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    ; CHECK-NEXT: PseudoBR %bb.1
    ; CHECK-NEXT: {{  $}}
    $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    PseudoBR %bb.1
  bb.1:
    liveins: $zttm0m2, $x10
    ; CHECK-NEXT: bb.1:
    ; CHECK-NEXT: liveins: $zttm0m2, $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $x11 = ZTT_MGETTYP $zttm0
    ; CHECK-NEXT: $zttm2 = ZTT_MSETTYP $x11, implicit-def $zttm3
    ; CHECK-NEXT: $zttm2 = ZTT_MMOV_M_M $zttm0, implicit-def $zttm3, implicit $zttm1
    ; CHECK-NEXT: $x11 = ZTT_MGETTYP $zttm2
    ; CHECK-NEXT: $zttm4 = ZTT_MSETTYP $x11, implicit-def $zttm5
    ; CHECK-NEXT: $zttm4 = ZTT_MMOV_M_M $zttm2, implicit-def $zttm5, implicit $zttm3
    ; CHECK-NEXT: PseudoRET implicit $zttm4m2, implicit $x10
    $zttm2m2 = COPY $zttm0m2
    $zttm4m2 = COPY $zttm2m2
    PseudoRET implicit $zttm4m2, implicit $x10
...
---
name: identity_unknown
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2
    ; CHECK-LABEL: name: identity_unknown
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0m2
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: PseudoRET implicit $zttm0m2
    $zttm0m2 = COPY $zttm0m2
    PseudoRET implicit $zttm0m2
...
---
name: loop_layout
tracksRegLiveness: true
body: |
  bb.0:
    successors: %bb.1
    liveins: $x10
    ; CHECK-LABEL: name: loop_layout
    ; CHECK: bb.0:
    ; CHECK-NEXT: successors: %bb.1(0x80000000)
    ; CHECK-NEXT: liveins: $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    ; CHECK-NEXT: PseudoBR %bb.1
    ; CHECK-NEXT: {{  $}}
    $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    PseudoBR %bb.1
  bb.1:
    successors: %bb.1, %bb.2
    liveins: $zttm0m2, $x10
    ; CHECK-NEXT: bb.1:
    ; CHECK-NEXT: successors: %bb.1(0x40000000), %bb.2(0x40000000)
    ; CHECK-NEXT: liveins: $zttm0m2, $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $x11 = ZTT_MGETTYP $zttm0
    ; CHECK-NEXT: $zttm2 = ZTT_MSETTYP $x11, implicit-def $zttm3
    ; CHECK-NEXT: $zttm2 = ZTT_MMOV_M_M $zttm0, implicit-def $zttm3, implicit $zttm1
    ; CHECK-NEXT: BNE $x10, $x0, %bb.1
    ; CHECK-NEXT: PseudoBR %bb.2
    ; CHECK-NEXT: {{  $}}
    $zttm2m2 = COPY $zttm0m2
    BNE $x10, $x0, %bb.1
    PseudoBR %bb.2
  bb.2:
    liveins: $zttm2m2
    ; CHECK-NEXT: bb.2:
    ; CHECK-NEXT: liveins: $zttm2m2
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: PseudoRET implicit $zttm2m2
    PseudoRET implicit $zttm2m2
...

;--- internal-copy-invalid-mir/checks.txt
# UNKNOWN: LLVM ERROR: Ztt M COPY source square layout is unknown
# INCONSISTENT: LLVM ERROR: Ztt M COPY source square layout is inconsistent

;--- internal-copy-invalid-mir/tmp/unknown.mir
--- |
  define void @unknown() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: unknown
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2
    $zttm2m2 = COPY $zttm0m2
    PseudoRET implicit $zttm2m2
...

# Incompatible predecessor layouts must not be resolved by visit order.

;--- internal-copy-invalid-mir/tmp/conflict.mir
--- |
  define void @conflict() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: conflict
tracksRegLiveness: true
body: |
  bb.0:
    successors: %bb.1, %bb.2
    liveins: $x10
    BNE $x10, $x0, %bb.1
    PseudoBR %bb.2
  bb.1:
    successors: %bb.3
    liveins: $x10
    $zttm0 = ZTT_MSETTYP $x10
    $zttm1 = ZTT_MSETTYP $x10
    PseudoBR %bb.3
  bb.2:
    successors: %bb.3
    liveins: $x10
    $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    PseudoBR %bb.3
  bb.3:
    liveins: $zttm0m2
    $zttm2m2 = COPY $zttm0m2
    PseudoRET implicit $zttm2m2
...

# A clobbered continuation register invalidates the square as a whole.

;--- internal-copy-invalid-mir/tmp/inconsistent.mir
--- |
  define void @inconsistent() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: inconsistent
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10
    $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    $zttm1 = IMPLICIT_DEF
    $zttm2m2 = COPY $zttm0m2
    PseudoRET implicit $zttm2m2
...

;--- internal-copy-scratch-mir/input.mir
# Every GPR is live: preserve one scalar register around each internal COPY.
# Both copies reuse a single XLEN stack slot; no matrix data is spilled.
# MIR-LABEL: name: no_scratch
# MIR: stack:
# RV32-NEXT: - { id: 0, name: '', type: spill-slot, offset: 0, size: 4, alignment: 4,
# RV64-NEXT: - { id: 0, name: '', type: spill-slot, offset: 0, size: 8, alignment: 8,
# MIR: $zttm0 = ZTT_MSETTYP $x10
# RV32-NEXT: SW $x10, %stack.0, 0 :: (store (s32) into %stack.0)
# RV64-NEXT: SD $x10, %stack.0, 0 :: (store (s64) into %stack.0)
# MIR-NEXT: $x10 = ZTT_MGETTYP $zttm0
# MIR-NEXT: $zttm1 = ZTT_MSETTYP $x10
# MIR-NEXT: $zttm1 = ZTT_MMOV_M_M $zttm0
# RV32-NEXT: $x10 = LW %stack.0, 0 :: (load (s32) from %stack.0)
# RV64-NEXT: $x10 = LD %stack.0, 0 :: (load (s64) from %stack.0)
# RV32-NEXT: SW $x10, %stack.0, 0 :: (store (s32) into %stack.0)
# RV64-NEXT: SD $x10, %stack.0, 0 :: (store (s64) into %stack.0)
# MIR-NEXT: $x10 = ZTT_MGETTYP $zttm1
# MIR-NEXT: $zttm2 = ZTT_MSETTYP $x10
# MIR-NEXT: $zttm2 = ZTT_MMOV_M_M $zttm1
# RV32-NEXT: $x10 = LW %stack.0, 0 :: (load (s32) from %stack.0)
# RV64-NEXT: $x10 = LD %stack.0, 0 :: (load (s64) from %stack.0)
# MIR-NEXT: PseudoRET implicit $zttm2, implicit $x1,
# ASM-LABEL: no_scratch:
# ASM-NEXT: .cfi_startproc
# ASM-NEXT: # %bb.0:
# ASM-NEXT: addi sp, sp, -16
# ASM-NEXT: .cfi_def_cfa_offset 16
# ASM-NEXT: msettyp m0, a0
# ASM32-NEXT: sw a0, 12(sp)
# ASM64-NEXT: sd a0, 8(sp)
# ASM-NEXT: mgettyp a0, m0
# ASM-NEXT: msettyp m1, a0
# ASM-NEXT: mmov.m.m m1, m0
# ASM32-NEXT: lw a0, 12(sp)
# ASM64-NEXT: ld a0, 8(sp)
# ASM32-NEXT: sw a0, 12(sp)
# ASM64-NEXT: sd a0, 8(sp)
# ASM-NEXT: mgettyp a0, m1
# ASM-NEXT: msettyp m2, a0
# ASM-NEXT: mmov.m.m m2, m1
# ASM32-NEXT: lw a0, 12(sp)
# ASM64-NEXT: ld a0, 8(sp)
# ASM-NEXT: addi sp, sp, 16
# ASM-NEXT: .cfi_def_cfa_offset 0
# ASM-NEXT: ret

# A four-register group contains two wide squares. Save a0 once for the whole
# COPY, not once per physical register or square. FP remains reserved.
# ASM-LABEL: wide_frame_pointer:
# ASM-NEXT: # %bb.0:
# ASM32-NEXT: addi sp, sp, -16
# ASM64-NEXT: addi sp, sp, -32
# ASM32-NEXT: sw ra, 12(sp)
# ASM64-NEXT: sd ra, 24(sp)
# ASM32-NEXT: sw s0, 8(sp)
# ASM64-NEXT: sd s0, 16(sp)
# ASM32-NEXT: addi s0, sp, 16
# ASM64-NEXT: addi s0, sp, 32
# ASM-NEXT: msettyp m0, a0
# ASM-NEXT: msettyp m2, a0
# ASM32-NEXT: sw a0, 4(sp)
# ASM64-NEXT: sd a0, 8(sp)
# ASM-NEXT: mgettyp a0, m0
# ASM-NEXT: msettyp m4, a0
# ASM-NEXT: mmov.m.m m4, m0
# ASM-NEXT: mgettyp a0, m2
# ASM-NEXT: msettyp m6, a0
# ASM-NEXT: mmov.m.m m6, m2
# ASM32-NEXT: lw a0, 4(sp)
# ASM64-NEXT: ld a0, 8(sp)
# ASM32-NEXT: lw ra, 12(sp)
# ASM64-NEXT: ld ra, 24(sp)
# ASM32-NEXT: lw s0, 8(sp)
# ASM64-NEXT: ld s0, 16(sp)
# ASM32-NEXT: addi sp, sp, 16
# ASM64-NEXT: addi sp, sp, 32
# ASM-NEXT: ret
--- |
  define void @no_scratch() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @wide_frame_pointer() nounwind "frame-pointer"="all" "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: no_scratch
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x1, $x2, $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10, $x11, $x12, $x13, $x14, $x15, $x16, $x17, $x18, $x19, $x20, $x21, $x22, $x23, $x24, $x25, $x26, $x27, $x28, $x29, $x30, $x31
    $zttm0 = ZTT_MSETTYP $x10
    $zttm1 = COPY $zttm0
    $zttm2 = COPY $zttm1
    PseudoRET implicit $zttm2, implicit $x1, implicit $x2, implicit $x3, implicit $x4, implicit $x5, implicit $x6, implicit $x7, implicit $x8, implicit $x9, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit $x18, implicit $x19, implicit $x20, implicit $x21, implicit $x22, implicit $x23, implicit $x24, implicit $x25, implicit $x26, implicit $x27, implicit $x28, implicit $x29, implicit $x30, implicit $x31
...
---
name: wide_frame_pointer
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x1, $x2, $x3, $x4, $x5, $x6, $x7, $x8, $x9, $x10, $x11, $x12, $x13, $x14, $x15, $x16, $x17, $x18, $x19, $x20, $x21, $x22, $x23, $x24, $x25, $x26, $x27, $x28, $x29, $x30, $x31
    $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1
    $zttm2 = ZTT_MSETTYP $x10, implicit-def $zttm3
    $zttm4m4 = COPY $zttm0m4
    PseudoRET implicit $zttm4m4, implicit $x1, implicit $x2, implicit $x3, implicit $x4, implicit $x5, implicit $x6, implicit $x7, implicit $x8, implicit $x9, implicit $x10, implicit $x11, implicit $x12, implicit $x13, implicit $x14, implicit $x15, implicit $x16, implicit $x17, implicit $x18, implicit $x19, implicit $x20, implicit $x21, implicit $x22, implicit $x23, implicit $x24, implicit $x25, implicit $x26, implicit $x27, implicit $x28, implicit $x29, implicit $x30, implicit $x31
...

;--- copy-identity-mir/input.mir
--- |
  define void @identity_m1() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @identity_wide_m4() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @identity_m32() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @copy_identity_tail() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @concat_identity_tail() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: identity_m1
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0, $x11
    ; CHECK-LABEL: name: identity_m1
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: PseudoRET
    $zttm0 = PseudoZTTMCopyM1 $zttm0, 1, $x11
    PseudoRET
...
---
name: identity_wide_m4
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m4, $x11
    ; CHECK-LABEL: name: identity_wide_m4
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0m4, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: PseudoRET
    $zttm0m4 = PseudoZTTMCopyM4 $zttm0m4, 2, $x11
    PseudoRET
...
---
name: identity_m32
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m32, $x11
    ; CHECK-LABEL: name: identity_m32
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0m32, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: PseudoRET
    $zttm0m32 = PseudoZTTMCopyM32 $zttm0m32, 1, $x11
    PseudoRET
...
---
name: copy_identity_tail
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2, $x11
    ; CHECK-LABEL: name: copy_identity_tail
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0m2, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm2 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm2 = ZTT_MMOV_M_M $zttm0
    ; CHECK-NEXT: $zttm3 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm3 = ZTT_MMOV_M_M $zttm1
    ; CHECK-NEXT: PseudoRET
    $zttm2m2 = PseudoZTTMCopyM2 $zttm0m2, 1, $x11
    $zttm2m2 = COPY $zttm2m2
    PseudoRET
...
---
name: concat_identity_tail
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0, $zttm1, $x11
    ; CHECK-LABEL: name: concat_identity_tail
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0, $zttm1, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm2 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm2 = ZTT_MMOV_M_M $zttm0
    ; CHECK-NEXT: $zttm3 = ZTT_MSETTYP $x11
    ; CHECK-NEXT: $zttm3 = ZTT_MMOV_M_M $zttm1
    ; CHECK-NEXT: PseudoRET
    $zttm2m2 = PseudoZTTMConcatM2 $zttm0, $zttm1, 1, $x11
    $zttm2m2 = COPY $zttm2m2
    PseudoRET
...

;--- copy-overlap-mir/checks.txt
# CHECK: LLVM ERROR: Ztt copy destination register group overlaps its source

;--- copy-overlap-mir/tmp/copy.mir
--- |
  define void @copy() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: copy
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m4, $x11
    $zttm4m4 = PseudoZTTMCopyM4 $zttm0m4, 1, $x11
    $zttm6m2 = COPY $zttm4m4
    PseudoRET
...

;--- copy-overlap-mir/tmp/concat.mir
--- |
  define void @concat() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: concat
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2, $zttm2m2, $x11
    $zttm4m4 = PseudoZTTMConcatM4 $zttm0m2, $zttm2m2, 1, $x11
    $zttm6m2 = COPY $zttm4m4
    PseudoRET
...
