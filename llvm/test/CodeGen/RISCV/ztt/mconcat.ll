; RUN: split-file %s %t
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %t/mconcat-ll/input.ll | FileCheck %t/mconcat-ll/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %t/mconcat-ll/input.ll | FileCheck %t/mconcat-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/mconcat-m32-ll/input.ll > %t.ztt-profile-0.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o - 2>&1 | FileCheck %t/mconcat-m32-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mconcat-mir/input.mir > %t.ztt-profile-1.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs    -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-1.mir -o - | FileCheck %t/mconcat-mir/input.mir
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mconcat-overlap-mir/tmp/lhs.mir > %t.ztt-profile-2.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - 2>&1 | FileCheck %t/mconcat-overlap-mir/checks.txt
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mconcat-overlap-mir/tmp/rhs.mir > %t.ztt-profile-3.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - 2>&1 | FileCheck %t/mconcat-overlap-mir/checks.txt
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mconcat-overlap-mir/tmp/wide.mir > %t.ztt-profile-4.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - 2>&1 | FileCheck %t/mconcat-overlap-mir/checks.txt
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mconcat-overlap-mir/tmp/m32.mir > %t.ztt-profile-5.mir
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - 2>&1 | FileCheck %t/mconcat-overlap-mir/checks.txt

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- mconcat-ll/input.ll
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i32_i32_32_2_1t(target("riscv.ztt.m.i32", i32, 32, 2, 1), target("riscv.ztt.m.i32", i32, 32, 2, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_1t(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.i64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i64_i64_64_1_4t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2), target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @packed_i16_1x4_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) #0 {
; CHECK-LABEL: packed_i16_1x4_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i32", i32, 32, 1, 2) @standard_i32_1x2_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b) #0 {
; CHECK-LABEL: standard_i32_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

define target("riscv.ztt.m.i32", i32, 32, 4, 1) @column_i32_4x1_uds32(target("riscv.ztt.m.i32", i32, 32, 2, 1) %a, target("riscv.ztt.m.i32", i32, 32, 2, 1) %b) #0 {
; CHECK-LABEL: column_i32_4x1_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m2
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmov.m.m m5, m1
; CHECK-NEXT:    msettyp m7, a0
; CHECK-NEXT:    mmov.m.m m7, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    mgettyp a0, m7
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m7
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i32_i32_32_2_1t(target("riscv.ztt.m.i32", i32, 32, 2, 1) %a, target("riscv.ztt.m.i32", i32, 32, 2, 1) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 2) @wide_i64_1x2_uds32(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b) #0 {
; CHECK-LABEL: wide_i64_1x2_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_1t(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %r
}

define target("riscv.ztt.m.i64", i64, 64, 1, 4) @wide_concat_i64_1x4_uds32(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b) #0 {
; CHECK-LABEL: wide_concat_i64_1x4_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    mmov.m.m m8, m0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    mmov.m.m m12, m4
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mmov.m.m m10, m2
; CHECK-NEXT:    msettyp m14, a0
; CHECK-NEXT:    mmov.m.m m14, m6
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m12
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m12
; CHECK-NEXT:    mgettyp a0, m14
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m14
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i64_i64_64_1_4t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @wide_i16_1x2_uds8(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b) #1 {
; CHECK-LABEL: wide_i16_1x2_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1), target("riscv.ztt.m.i16", i16, 16, 1, 1), i32 immarg, i32 immarg)

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #1 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }

; Source-source aliasing is legal; only destination-source aliasing is forbidden.
define target("riscv.ztt.m.i32", i32, 32, 1, 2) @same_source_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a) #0 {
; CHECK-LABEL: same_source_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m0
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %r
}

; Descriptor-sensitive cases. Intrinsic moves use the supplied encoding;
; the following return COPY still obtains its metadata from the source.

declare target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.u16_i16_16_1_4t.triscv.ztt.m.u16_i16_16_1_2t(target("riscv.ztt.m.u16", i16, 16, 1, 2), target("riscv.ztt.m.u16", i16, 16, 1, 2), i32 immarg, i32 immarg)
define target("riscv.ztt.m.u16", i16, 16, 1, 4) @datatype_u16_uds32(target("riscv.ztt.m.u16", i16, 16, 1, 2) %a, target("riscv.ztt.m.u16", i16, 16, 1, 2) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: datatype_u16_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.u16_i16_16_1_4t.triscv.ztt.m.u16_i16_16_1_2t(target("riscv.ztt.m.u16", i16, 16, 1, 2) %a, target("riscv.ztt.m.u16", i16, 16, 1, 2) %b, i32 16, i32 2)
  ret target("riscv.ztt.m.u16", i16, 16, 1, 4) %r
}

declare target("riscv.ztt.m.f16", half, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.f16_half_16_1_4t.triscv.ztt.m.f16_half_16_1_2t(target("riscv.ztt.m.f16", half, 16, 1, 2), target("riscv.ztt.m.f16", half, 16, 1, 2), i32 immarg, i32 immarg)
define target("riscv.ztt.m.f16", half, 16, 1, 4) @datatype_f16_uds32(target("riscv.ztt.m.f16", half, 16, 1, 2) %a, target("riscv.ztt.m.f16", half, 16, 1, 2) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: datatype_f16_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f16", half, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.f16_half_16_1_4t.triscv.ztt.m.f16_half_16_1_2t(target("riscv.ztt.m.f16", half, 16, 1, 2) %a, target("riscv.ztt.m.f16", half, 16, 1, 2) %b, i32 338690320, i32 2)
  ret target("riscv.ztt.m.f16", half, 16, 1, 4) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_2t.triscv.ztt.m.bf16_bfloat_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), i32 immarg, i32 immarg)
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @datatype_bf16_uds8(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
; CHECK-LABEL: datatype_bf16_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_2t.triscv.ztt.m.bf16_bfloat_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %b, i32 540016912, i32 1)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @datatype_bf16_uds16(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: datatype_bf16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_2t.triscv.ztt.m.bf16_bfloat_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %b, i32 540016912, i32 1)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_4t.triscv.ztt.m.bf16_bfloat_16_1_2t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), i32 immarg, i32 immarg)
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @datatype_bf16_uds32(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: datatype_bf16_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_4t.triscv.ztt.m.bf16_bfloat_16_1_2t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %b, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_8t.triscv.ztt.m.bf16_bfloat_16_1_4t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 4), target("riscv.ztt.m.bf16", bfloat, 16, 1, 4), i32 immarg, i32 immarg)
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @datatype_bf16_uds64(target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; CHECK-LABEL: datatype_bf16_uds64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_8t.triscv.ztt.m.bf16_bfloat_16_1_4t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 4) %b, i32 540016912, i32 4)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %r
}

declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 16) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_16t.triscv.ztt.m.bf16_bfloat_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), i32 immarg, i32 immarg)
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 16) @datatype_bf16_uds128(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: datatype_bf16_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 16) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.bf16_bfloat_16_1_16t.triscv.ztt.m.bf16_bfloat_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %a, target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %b, i32 540016912, i32 8)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 16) %r
}

declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.f32_float_32_1_2t.triscv.ztt.m.f32_float_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1), target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
define target("riscv.ztt.m.f32", float, 32, 1, 2) @datatype_f32_uds32(target("riscv.ztt.m.f32", float, 32, 1, 1) %a, target("riscv.ztt.m.f32", float, 32, 1, 1) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: datatype_f32_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 288
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.f32_float_32_1_2t.triscv.ztt.m.f32_float_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1) %a, target("riscv.ztt.m.f32", float, 32, 1, 1) %b, i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 2) %r
}

declare target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.f64_double_64_1_2t.triscv.ztt.m.f64_double_64_1_1t(target("riscv.ztt.m.f64", double, 64, 1, 1), target("riscv.ztt.m.f64", double, 64, 1, 1), i32 immarg, i32 immarg)
define target("riscv.ztt.m.f64", double, 64, 1, 2) @datatype_f64_uds32(target("riscv.ztt.m.f64", double, 64, 1, 1) %a, target("riscv.ztt.m.f64", double, 64, 1, 1) %b) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: datatype_f64_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmov.m.m m4, m0
; CHECK-NEXT:    msettyp m6, a0
; CHECK-NEXT:    mmov.m.m m6, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m6
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m6
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 2) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.f64_double_64_1_2t.triscv.ztt.m.f64_double_64_1_1t(target("riscv.ztt.m.f64", double, 64, 1, 1) %a, target("riscv.ztt.m.f64", double, 64, 1, 1) %b, i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 2) %r
}

;--- mconcat-m32-ll/input.ll
; CHECK: LLVM ERROR: Ztt mconcat.m requires a destination register group disjoint from both sources; M32 results are unsupported

; Each input occupies M16, and the result occupies all 32 M registers.
; Fail in lowering, before attempting an impossible disjoint allocation.
define void @m32_result(ptr %p) "riscv-ztt-profile"="ZTT_PROFILE" {
  %a = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i64_i64_64_1_2t(ptr %p, i32 1073741888, i32 2)
  %r = call target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i64_i64_64_1_4t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, i32 1073741888, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i64_i64_64_1_4t(ptr %p, target("riscv.ztt.m.i64", i64, 64, 1, 4) %r, i32 1073741888, i32 4)
  ret void
}
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i64_i64_64_1_2t(ptr, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i64_i64_64_1_4t(ptr, target("riscv.ztt.m.i64", i64, 64, 1, 4), i32, i32)
declare target("riscv.ztt.m.i64", i64, 64, 1, 4) @llvm.riscv.ztt.mconcat.m.triscv.ztt.m.i64_i64_64_1_4t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2), target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)

;--- mconcat-mir/input.mir
--- |
  define void @m4_nonoverlap() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @m16_nonoverlap() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name:            m4_nonoverlap
tracksRegLiveness: true
body:             |
  bb.0:
    liveins: $zttm0m2, $zttm2m2, $x10, $x11

    ; CHECK-LABEL: name: m4_nonoverlap
    ; CHECK: bb.0:
    ; CHECK-NEXT:   liveins: $zttm0m2, $zttm2m2, $x10, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT:   $zttm4 = ZTT_MSETTYP $x11
    ; CHECK-NEXT:   $zttm4 = ZTT_MMOV_M_M $zttm0
    ; CHECK-NEXT:   $zttm6 = ZTT_MSETTYP $x11
    ; CHECK-NEXT:   $zttm6 = ZTT_MMOV_M_M $zttm2
    ; CHECK-NEXT:   $zttm5 = ZTT_MSETTYP $x11
    ; CHECK-NEXT:   $zttm5 = ZTT_MMOV_M_M $zttm1
    ; CHECK-NEXT:   $zttm7 = ZTT_MSETTYP $x11
    ; CHECK-NEXT:   $zttm7 = ZTT_MMOV_M_M $zttm3
    ; CHECK-NEXT:   PseudoRET
    $zttm4m4 = PseudoZTTMConcatM4 $zttm0m2, $zttm2m2, 1, $x11
    PseudoRET
...
---
name: m16_nonoverlap
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m8, $zttm8m8, $x11

    ; CHECK-LABEL: name: m16_nonoverlap
    ; CHECK: bb.0:
    ; CHECK-NEXT:   liveins: $zttm0m8, $zttm8m8, $x11
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT:   $zttm16 = ZTT_MSETTYP $x11, implicit-def $zttm17, implicit-def $zttm18, implicit-def $zttm19, implicit-def $zttm20, implicit-def $zttm21, implicit-def $zttm22, implicit-def $zttm23
    ; CHECK-NEXT:   $zttm16 = ZTT_MMOV_M_M $zttm0, implicit-def $zttm17, implicit $zttm1, implicit-def $zttm18, implicit $zttm2, implicit-def $zttm19, implicit $zttm3, implicit-def $zttm20, implicit $zttm4, implicit-def $zttm21, implicit $zttm5, implicit-def $zttm22, implicit $zttm6, implicit-def $zttm23, implicit $zttm7
    ; CHECK-NEXT:   $zttm24 = ZTT_MSETTYP $x11, implicit-def $zttm25, implicit-def $zttm26, implicit-def $zttm27, implicit-def $zttm28, implicit-def $zttm29, implicit-def $zttm30, implicit-def $zttm31
    ; CHECK-NEXT:   $zttm24 = ZTT_MMOV_M_M $zttm8, implicit-def $zttm25, implicit $zttm9, implicit-def $zttm26, implicit $zttm10, implicit-def $zttm27, implicit $zttm11, implicit-def $zttm28, implicit $zttm12, implicit-def $zttm29, implicit $zttm13, implicit-def $zttm30, implicit $zttm14, implicit-def $zttm31, implicit $zttm15
    ; CHECK-NEXT:   PseudoRET
    $zttm16m16 = PseudoZTTMConcatM16 $zttm0m8, $zttm8m8, 8, $x11
    PseudoRET
...

;--- mconcat-overlap-mir/checks.txt
# CHECK: LLVM ERROR: Ztt mconcat.m destination register group overlaps a source

;--- mconcat-overlap-mir/tmp/lhs.mir
--- |
  define void @lhs() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: lhs
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm2m2, $zttm4m2, $x11
    $zttm0m4 = PseudoZTTMConcatM4 $zttm2m2, $zttm4m2, 1, $x11
    PseudoRET
...

;--- mconcat-overlap-mir/tmp/rhs.mir
--- |
  define void @rhs() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: rhs
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm4m2, $zttm2m2, $x11
    $zttm0m4 = PseudoZTTMConcatM4 $zttm4m2, $zttm2m2, 1, $x11
    PseudoRET
...

;--- mconcat-overlap-mir/tmp/wide.mir
--- |
  define void @wide() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: wide
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm4m4, $zttm8m4, $x11
    $zttm0m8 = PseudoZTTMConcatM8 $zttm4m4, $zttm8m4, 2, $x11
    PseudoRET
...

;--- mconcat-overlap-mir/tmp/m32.mir
--- |
  define void @m32() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: m32
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m16, $zttm16m16, $x11
    $zttm0m32 = PseudoZTTMConcatM32 $zttm0m16, $zttm16m16, 1, $x11
    PseudoRET
...
