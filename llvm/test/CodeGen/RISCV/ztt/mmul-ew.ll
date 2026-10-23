; RUN: split-file %s %t
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/mmul-ew-mir/input.mir > %t.ztt-profile-0.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-0.mir -o - | FileCheck %t/mmul-ew-mir/input.mir
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/mmul-ew-mir/input.mir > %t.ztt-profile-1.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -run-pass=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-1.mir -o - | FileCheck %t/mmul-ew-mir/input.mir
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %t/mmul-ew-ll/input.ll | FileCheck %t/mmul-ew-ll/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %t/mmul-ew-ll/input.ll | FileCheck %t/mmul-ew-ll/input.ll
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/acc-result.ll > %t.ztt-profile-2.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-2.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=ACC-RESULT
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/acc-result.ll > %t.ztt-profile-3.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-3.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=ACC-RESULT
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/acc-source.ll > %t.ztt-profile-4.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-4.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=ACC-SOURCE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/acc-source.ll > %t.ztt-profile-5.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-5.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=ACC-SOURCE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/zero-squares.ll > %t.ztt-profile-6.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-6.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=ZERO-SQUARES
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/zero-squares.ll > %t.ztt-profile-7.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-7.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=ZERO-SQUARES
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/size-mismatch.ll > %t.ztt-profile-8.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-8.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=SIZE-MISMATCH
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/size-mismatch.ll > %t.ztt-profile-9.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-9.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=SIZE-MISMATCH
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/bad-source-layout.ll > %t.ztt-profile-10.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-10.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=BAD-SOURCE-LAYOUT
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/mmul-ew-invalid-ll/tmp/bad-source-layout.ll > %t.ztt-profile-11.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-11.ll -o - 2>&1 | FileCheck %t/mmul-ew-invalid-ll/checks.txt --check-prefix=BAD-SOURCE-LAYOUT

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- mmul-ew-ll/input.ll
;

; Local load -> compute -> store exercises the public data path without matrix ABI.
; UDS32: L/D packed in one register, R two registers, one mmul.ew.
; +m keeps this test focused on packed arithmetic and address advancement.
; Helper calls and live-across-call preservation are covered by spill tests.
define void @load_compute_store(ptr %a, ptr %b, ptr %out) #38 {
; CHECK-LABEL: load_compute_store:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    csrr a3, amenlen
; CHECK-NEXT:    mul a3, a3, a3
; CHECK-NEXT:    lui a4, 262144
; CHECK-NEXT:    addi a5, a4, 16
; CHECK-NEXT:    slli a3, a3, 2
; CHECK-NEXT:    addi a4, a4, 32
; CHECK-NEXT:    msettyp m0, a5
; CHECK-NEXT:    mls.rm m0, a0
; CHECK-NEXT:    msettyp m2, a4
; CHECK-NEXT:    mls.rm m2, a1
; CHECK-NEXT:    add a1, a1, a3
; CHECK-NEXT:    msettyp m3, a4
; CHECK-NEXT:    mls.rm m3, a1
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmul.ew m1, m0, m2
; CHECK-NEXT:    mss.rm m1, a2
; CHECK-NEXT:    ret
  %l = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr %a, i32 1073741840, i32 2)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr %b, i32 1073741856, i32 2)
  %d = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.bf16_bf16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %l, target("riscv.ztt.m.i32", i32, 32, 1, 2) %r, i32 540016912, i32 2)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.bf16_bf16_16_1_2t(ptr %out, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %d, i32 540016912, i32 2)
  ret void
}
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_2t(ptr, i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i32_i32_32_1_2t(ptr, i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.bf16_bf16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.bf16_bf16_16_1_2t(ptr, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), i32, i32)

; Ztt v0.6 section 2.3.2: N_sq=max(1, UDS/TD, UDS/TA, UDS/TB).
; NumOps=K/N_sq; each operand advances GroupSize/NumOps registers.
; Output metadata initialization advances max(1, TD/UDS), NOT one physical
; register for a wide square. Groups are disjoint before any msettyp.

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i128_i128_128_1_1t(i32 immarg, i32 immarg)

; standard_uds8: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i8", i8, 8, 1, 1) @standard_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 1) %a, target("riscv.ztt.m.i8", i8, 8, 1, 1) %b) #0 {
; CHECK-LABEL: standard_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_1t.triscv.ztt.m.i8_i8_8_1_1t.triscv.ztt.m.i8_i8_8_1_1t(target("riscv.ztt.m.i8", i8, 8, 1, 1) %a, target("riscv.ztt.m.i8", i8, 8, 1, 1) %b, i32 1073741832, i32 1)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 1) %d
}

; packed_uds8: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i4", i4, 4, 1, 2) @packed_uds8(target("riscv.ztt.m.i4", i4, 4, 1, 2) %a, target("riscv.ztt.m.i4", i4, 4, 1, 2) %b) #1 {
; CHECK-LABEL: packed_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 4
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i4_i4_4_1_2t.triscv.ztt.m.i4_i4_4_1_2t.triscv.ztt.m.i4_i4_4_1_2t(target("riscv.ztt.m.i4", i4, 4, 1, 2) %a, target("riscv.ztt.m.i4", i4, 4, 1, 2) %b, i32 1073741828, i32 2)
  ret target("riscv.ztt.m.i4", i4, 4, 1, 2) %d
}

; concat_row_uds8: D/L/R groups=2/2/2, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i8", i8, 8, 1, 2) @concat_row_uds8(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b) #2 {
; CHECK-LABEL: concat_row_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mmul.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_2t.triscv.ztt.m.i8_i8_8_1_2t.triscv.ztt.m.i8_i8_8_1_2t(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %d
}

; concat_col_uds8: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.
define target("riscv.ztt.m.i8", i8, 8, 4, 1) @concat_col_uds8(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, target("riscv.ztt.m.i8", i8, 8, 4, 1) %b) #3 {
; CHECK-LABEL: concat_col_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m9, m1, m5
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mmul.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_4_1t.triscv.ztt.m.i8_i8_8_4_1t.triscv.ztt.m.i8_i8_8_4_1t(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, target("riscv.ztt.m.i8", i8, 8, 4, 1) %b, i32 1073741832, i32 4)
  ret target("riscv.ztt.m.i8", i8, 8, 4, 1) %d
}

; wide_uds8: D/L/R groups=2/2/2, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 1) @wide_uds8(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b) #4 {
; CHECK-LABEL: wide_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %d
}

; standard_uds16: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 1) @standard_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b) #5 {
; CHECK-LABEL: standard_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1) %a, target("riscv.ztt.m.i16", i16, 16, 1, 1) %b, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %d
}

; packed_uds16: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i8", i8, 8, 1, 2) @packed_uds16(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b) #6 {
; CHECK-LABEL: packed_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_2t.triscv.ztt.m.i8_i8_8_1_2t.triscv.ztt.m.i8_i8_8_1_2t(target("riscv.ztt.m.i8", i8, 8, 1, 2) %a, target("riscv.ztt.m.i8", i8, 8, 1, 2) %b, i32 1073741832, i32 2)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 2) %d
}

; concat_row_uds16: D/L/R groups=2/2/2, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 2) @concat_row_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) #7 {
; CHECK-LABEL: concat_row_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mmul.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %d
}

; concat_col_uds16: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 4, 1) @concat_col_uds16(target("riscv.ztt.m.i16", i16, 16, 4, 1) %a, target("riscv.ztt.m.i16", i16, 16, 4, 1) %b) #8 {
; CHECK-LABEL: concat_col_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m9, m1, m5
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mmul.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_4_1t.triscv.ztt.m.i16_i16_16_4_1t.triscv.ztt.m.i16_i16_16_4_1t(target("riscv.ztt.m.i16", i16, 16, 4, 1) %a, target("riscv.ztt.m.i16", i16, 16, 4, 1) %b, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 4, 1) %d
}

; wide_uds16: D/L/R groups=2/2/2, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @wide_uds16(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b) #9 {
; CHECK-LABEL: wide_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}

; standard_uds32: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @standard_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b) #10 {
; CHECK-LABEL: standard_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}

; packed_uds32: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 2) @packed_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b) #11 {
; CHECK-LABEL: packed_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i16", i16, 16, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %d
}

; concat_row_uds32: D/L/R groups=2/2/2, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 2) @concat_row_uds32(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #12 {
; CHECK-LABEL: concat_row_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mmul.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %d
}

; concat_col_uds32: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 4, 1) @concat_col_uds32(target("riscv.ztt.m.i32", i32, 32, 4, 1) %a, target("riscv.ztt.m.i32", i32, 32, 4, 1) %b) #13 {
; CHECK-LABEL: concat_col_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m9, m1, m5
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mmul.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i32_i32_32_4_1t(target("riscv.ztt.m.i32", i32, 32, 4, 1) %a, target("riscv.ztt.m.i32", i32, 32, 4, 1) %b, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 4, 1) %d
}

; wide_uds32: D/L/R groups=2/2/2, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i64", i64, 64, 1, 1) @wide_uds32(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b) #14 {
; CHECK-LABEL: wide_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %d
}

; standard_uds64: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i64", i64, 64, 1, 1) @standard_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b) #15 {
; CHECK-LABEL: standard_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t(target("riscv.ztt.m.i64", i64, 64, 1, 1) %a, target("riscv.ztt.m.i64", i64, 64, 1, 1) %b, i32 1073741888, i32 1)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 1) %d
}

; packed_uds64: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 2) @packed_uds64(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #16 {
; CHECK-LABEL: packed_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %d
}

; concat_row_uds64: D/L/R groups=2/2/2, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i64", i64, 64, 1, 2) @concat_row_uds64(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b) #17 {
; CHECK-LABEL: concat_row_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mmul.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %d
}

; concat_col_uds64: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.
define target("riscv.ztt.m.i64", i64, 64, 4, 1) @concat_col_uds64(target("riscv.ztt.m.i64", i64, 64, 4, 1) %a, target("riscv.ztt.m.i64", i64, 64, 4, 1) %b) #18 {
; CHECK-LABEL: concat_col_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m9, m1, m5
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mmul.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i64", i64, 64, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_4_1t.triscv.ztt.m.i64_i64_64_4_1t.triscv.ztt.m.i64_i64_64_4_1t(target("riscv.ztt.m.i64", i64, 64, 4, 1) %a, target("riscv.ztt.m.i64", i64, 64, 4, 1) %b, i32 1073741888, i32 4)
  ret target("riscv.ztt.m.i64", i64, 64, 4, 1) %d
}

; wide_uds64: D/L/R groups=2/2/2, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i128", i128, 128, 1, 1) @wide_uds64(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %b) #19 {
; CHECK-LABEL: wide_uds64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %b, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %d
}

; standard_uds128: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i128", i128, 128, 1, 1) @standard_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %b) #20 {
; CHECK-LABEL: standard_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %b, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %d
}

; packed_uds128: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i64", i64, 64, 1, 2) @packed_uds128(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b) #21 {
; CHECK-LABEL: packed_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 64
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2) %a, target("riscv.ztt.m.i64", i64, 64, 1, 2) %b, i32 1073741888, i32 2)
  ret target("riscv.ztt.m.i64", i64, 64, 1, 2) %d
}

; concat_row_uds128: D/L/R groups=2/2/2, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i128", i128, 128, 1, 2) @concat_row_uds128(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, target("riscv.ztt.m.i128", i128, 128, 1, 2) %b) #22 {
; CHECK-LABEL: concat_row_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m4, a0
; CHECK-NEXT:    msettyp m5, a0
; CHECK-NEXT:    mmul.ew m4, m0, m2
; CHECK-NEXT:    mmul.ew m5, m1, m3
; CHECK-NEXT:    mgettyp a0, m4
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m4
; CHECK-NEXT:    mgettyp a0, m5
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m5
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_1_2t.triscv.ztt.m.i128_i128_128_1_2t.triscv.ztt.m.i128_i128_128_1_2t(target("riscv.ztt.m.i128", i128, 128, 1, 2) %a, target("riscv.ztt.m.i128", i128, 128, 1, 2) %b, i32 1073741952, i32 2)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 2) %d
}

; concat_col_uds128: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.
define target("riscv.ztt.m.i128", i128, 128, 4, 1) @concat_col_uds128(target("riscv.ztt.m.i128", i128, 128, 4, 1) %a, target("riscv.ztt.m.i128", i128, 128, 4, 1) %b) #23 {
; CHECK-LABEL: concat_col_uds128:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m9, m1, m5
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mmul.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_4_1t.triscv.ztt.m.i128_i128_128_4_1t.triscv.ztt.m.i128_i128_128_4_1t(target("riscv.ztt.m.i128", i128, 128, 4, 1) %a, target("riscv.ztt.m.i128", i128, 128, 4, 1) %b, i32 1073741952, i32 4)
  ret target("riscv.ztt.m.i128", i128, 128, 4, 1) %d
}

; document_uds8: D/L/R groups=4/4/8, 2 output msettyp, 2 mmul.ew.
; Build values locally: large matrix parameters have no defined ABI yet.
define target("riscv.ztt.m.i16", i16, 16, 1, 2) @document_uds8() #24 {
; CHECK-LABEL: document_uds8:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a1, a0, 16
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    msettyp m6, a1
; CHECK-NEXT:    mzero.2d.m m4
; CHECK-NEXT:    mzero.2d.m m6
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    mzero.2d.m m8
; CHECK-NEXT:    mzero.2d.m m12
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mmul.ew m0, m4, m8
; CHECK-NEXT:    mmul.ew m2, m6, m12
; CHECK-NEXT:    ret
  %a = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  %b = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_2t(i32 1073741856, i32 2)
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %d
}

; document_uds16: D/L/R groups=2/2/4, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 2) @document_uds16(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #25 {
; CHECK-LABEL: document_uds16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmul.ew m2, m0, m4
; CHECK-NEXT:    mmul.ew m3, m1, m6
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %d
}

; document_uds32: D/L/R groups=1/1/2, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 2) @document_uds32(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #26 {
; CHECK-LABEL: document_uds32:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmul.ew m1, m0, m2
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %d
}

; lhs_sets_coverage: D/L/R groups=4/1/4, 4 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 4) @lhs_sets_coverage(target("riscv.ztt.m.i8", i8, 8, 1, 4) %a, target("riscv.ztt.m.f32", float, 32, 1, 4) %b) #27 {
; CHECK-LABEL: lhs_sets_coverage:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i8_i8_8_1_4t.triscv.ztt.m.f32_f32_32_1_4t(target("riscv.ztt.m.i8", i8, 8, 1, 4) %a, target("riscv.ztt.m.f32", float, 32, 1, 4) %b, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 4) %d
}

; rhs_sets_coverage: D/L/R groups=4/4/1, 4 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 4) @rhs_sets_coverage(target("riscv.ztt.m.f32", float, 32, 1, 4) %a, target("riscv.ztt.m.i8", i8, 8, 1, 4) %b) #28 {
; CHECK-LABEL: rhs_sets_coverage:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.f32_f32_32_1_4t.triscv.ztt.m.i8_i8_8_1_4t(target("riscv.ztt.m.f32", float, 32, 1, 4) %a, target("riscv.ztt.m.i8", i8, 8, 1, 4) %b, i32 1073741856, i32 4)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 4) %d
}

; dst_sets_coverage: D/L/R groups=1/4/4, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.i8", i8, 8, 1, 4) @dst_sets_coverage(target("riscv.ztt.m.i32", i32, 32, 1, 4) %a, target("riscv.ztt.m.f32", float, 32, 1, 4) %b) #29 {
; CHECK-LABEL: dst_sets_coverage:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 8
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.f32_f32_32_1_4t(target("riscv.ztt.m.i32", i32, 32, 1, 4) %a, target("riscv.ztt.m.f32", float, 32, 1, 4) %b, i32 1073741832, i32 4)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 4) %d
}

; packed_multi_op: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.
define target("riscv.ztt.m.i16", i16, 16, 1, 8) @packed_multi_op(target("riscv.ztt.m.i16", i16, 16, 1, 8) %a, target("riscv.ztt.m.i16", i16, 16, 1, 8) %b) #30 {
; CHECK-LABEL: packed_multi_op:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m9, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m11, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m9, m1, m5
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mmul.ew m11, m3, m7
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m9
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m9
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    mgettyp a0, m11
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmov.m.m m3, m11
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8) %a, target("riscv.ztt.m.i16", i16, 16, 1, 8) %b, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %d
}

; wide_concat: D/L/R groups=4/4/4, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 2) @wide_concat(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b) #31 {
; CHECK-LABEL: wide_concat:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
; CHECK-NEXT:    mmul.ew m10, m2, m6
; CHECK-NEXT:    mgettyp a0, m8
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m8
; CHECK-NEXT:    mgettyp a0, m10
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmov.m.m m2, m10
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %b, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %d
}

; float_bf16: D/L/R groups=1/1/2, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @float_bf16(target("riscv.ztt.m.f16", half, 16, 1, 2) %a, target("riscv.ztt.m.u32", i32, 32, 1, 2) %b) #32 {
; CHECK-LABEL: float_bf16:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmul.ew m1, m0, m2
; CHECK-NEXT:    mgettyp a0, m1
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m1
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.bf16_bf16_16_1_2t.triscv.ztt.m.f16_f16_16_1_2t.triscv.ztt.m.u32_i32_32_1_2t(target("riscv.ztt.m.f16", half, 16, 1, 2) %a, target("riscv.ztt.m.u32", i32, 32, 1, 2) %b, i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %d
}

; float_f64: D/L/R groups=8/1/4, 4 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.f64", double, 64, 4, 1) @float_f64(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, target("riscv.ztt.m.f32", float, 32, 4, 1) %b) #33 {
; CHECK-LABEL: float_f64:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m8, a0
; CHECK-NEXT:    msettyp m10, a0
; CHECK-NEXT:    msettyp m12, a0
; CHECK-NEXT:    msettyp m14, a0
; CHECK-NEXT:    mmul.ew m8, m0, m4
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
  %d = call target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.f64_f64_64_4_1t.triscv.ztt.m.i8_i8_8_4_1t.triscv.ztt.m.f32_f32_32_4_1t(target("riscv.ztt.m.i8", i8, 8, 4, 1) %a, target("riscv.ztt.m.f32", float, 32, 4, 1) %b, i32 741343552, i32 4)
  ret target("riscv.ztt.m.f64", double, 64, 4, 1) %d
}

; unsigned_result: D/L/R groups=1/1/1, 1 output msettyp, 1 mmul.ew.
define target("riscv.ztt.m.u32", i32, 32, 1, 1) @unsigned_result(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.f32", float, 32, 1, 1) %b) #34 {
; CHECK-LABEL: unsigned_result:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    mmul.ew m2, m0, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.u32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.f32", float, 32, 1, 1) %b, i32 32, i32 1)
  ret target("riscv.ztt.m.u32", i32, 32, 1, 1) %d
}

; same_input: D/L/R groups=2/2/2, 2 output msettyp, 2 mmul.ew.
define target("riscv.ztt.m.i32", i32, 32, 1, 2) @same_input(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a) #35 {
; CHECK-LABEL: same_input:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 32
; CHECK-NEXT:    msettyp m2, a0
; CHECK-NEXT:    msettyp m3, a0
; CHECK-NEXT:    mmul.ew m2, m0, m0
; CHECK-NEXT:    mmul.ew m3, m1, m1
; CHECK-NEXT:    mgettyp a0, m2
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmov.m.m m0, m2
; CHECK-NEXT:    mgettyp a0, m3
; CHECK-NEXT:    msettyp m1, a0
; CHECK-NEXT:    mmov.m.m m1, m3
; CHECK-NEXT:    ret
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, target("riscv.ztt.m.i32", i32, 32, 1, 2) %a, i32 1073741856, i32 2)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 2) %d
}

; m16_profile: D/L/R groups=4/4/4, 4 output msettyp, 4 mmul.ew.

; m16_group: D/L/R groups=16/16/16, 1 output msettyp, 1 mmul.ew.
; Build values locally: large matrix parameters have no defined ABI yet.
define target("riscv.ztt.m.i128", i128, 128, 1, 1) @m16_group() #37 {
; CHECK-LABEL: m16_group:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 128
; CHECK-NEXT:    msettyp m16, a0
; CHECK-NEXT:    mzero.2d.m m16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    mmul.ew m0, m16, m16
; CHECK-NEXT:    ret
  %a = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i128_i128_128_1_1t(i32 1073741952, i32 1)
  %d = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t(target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, target("riscv.ztt.m.i128", i128, 128, 1, 1) %a, i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %d
}

declare target("riscv.ztt.m.i8", i8, 8, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_1t.triscv.ztt.m.i8_i8_8_1_1t.triscv.ztt.m.i8_i8_8_1_1t(target("riscv.ztt.m.i8", i8, 8, 1, 1), target("riscv.ztt.m.i8", i8, 8, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i4", i4, 4, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i4_i4_4_1_2t.triscv.ztt.m.i4_i4_4_1_2t.triscv.ztt.m.i4_i4_4_1_2t(target("riscv.ztt.m.i4", i4, 4, 1, 2), target("riscv.ztt.m.i4", i4, 4, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_2t.triscv.ztt.m.i8_i8_8_1_2t.triscv.ztt.m.i8_i8_8_1_2t(target("riscv.ztt.m.i8", i8, 8, 1, 2), target("riscv.ztt.m.i8", i8, 8, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_4_1t.triscv.ztt.m.i8_i8_8_4_1t.triscv.ztt.m.i8_i8_8_4_1t(target("riscv.ztt.m.i8", i8, 8, 4, 1), target("riscv.ztt.m.i8", i8, 8, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1), target("riscv.ztt.m.i16", i16, 16, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_4_1t.triscv.ztt.m.i16_i16_16_4_1t.triscv.ztt.m.i16_i16_16_4_1t(target("riscv.ztt.m.i16", i16, 16, 4, 1), target("riscv.ztt.m.i16", i16, 16, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i32", i32, 32, 1, 2), target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i32_i32_32_4_1t.triscv.ztt.m.i32_i32_32_4_1t(target("riscv.ztt.m.i32", i32, 32, 4, 1), target("riscv.ztt.m.i32", i32, 32, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t.triscv.ztt.m.i64_i64_64_1_1t(target("riscv.ztt.m.i64", i64, 64, 1, 1), target("riscv.ztt.m.i64", i64, 64, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_2t.triscv.ztt.m.i64_i64_64_1_2t(target("riscv.ztt.m.i64", i64, 64, 1, 2), target("riscv.ztt.m.i64", i64, 64, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i64", i64, 64, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i64_i64_64_4_1t.triscv.ztt.m.i64_i64_64_4_1t.triscv.ztt.m.i64_i64_64_4_1t(target("riscv.ztt.m.i64", i64, 64, 4, 1), target("riscv.ztt.m.i64", i64, 64, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t.triscv.ztt.m.i128_i128_128_1_1t(target("riscv.ztt.m.i128", i128, 128, 1, 1), target("riscv.ztt.m.i128", i128, 128, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_1_2t.triscv.ztt.m.i128_i128_128_1_2t.triscv.ztt.m.i128_i128_128_1_2t(target("riscv.ztt.m.i128", i128, 128, 1, 2), target("riscv.ztt.m.i128", i128, 128, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i128_i128_128_4_1t.triscv.ztt.m.i128_i128_128_4_1t.triscv.ztt.m.i128_i128_128_4_1t(target("riscv.ztt.m.i128", i128, 128, 4, 1), target("riscv.ztt.m.i128", i128, 128, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i32_i32_32_1_2t(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i8_i8_8_1_4t.triscv.ztt.m.f32_f32_32_1_4t(target("riscv.ztt.m.i8", i8, 8, 1, 4), target("riscv.ztt.m.f32", float, 32, 1, 4), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.f32_f32_32_1_4t.triscv.ztt.m.i8_i8_8_1_4t(target("riscv.ztt.m.f32", float, 32, 1, 4), target("riscv.ztt.m.i8", i8, 8, 1, 4), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i8_i8_8_1_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.f32_f32_32_1_4t(target("riscv.ztt.m.i32", i32, 32, 1, 4), target("riscv.ztt.m.f32", float, 32, 1, 4), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_1_8t(target("riscv.ztt.m.i16", i16, 16, 1, 8), target("riscv.ztt.m.i16", i16, 16, 1, 8), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.bf16_bf16_16_1_2t.triscv.ztt.m.f16_f16_16_1_2t.triscv.ztt.m.u32_i32_32_1_2t(target("riscv.ztt.m.f16", half, 16, 1, 2), target("riscv.ztt.m.u32", i32, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 4, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.f64_f64_64_4_1t.triscv.ztt.m.i8_i8_8_4_1t.triscv.ztt.m.f32_f32_32_4_1t(target("riscv.ztt.m.i8", i8, 8, 4, 1), target("riscv.ztt.m.f32", float, 32, 4, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.u32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.u32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.f32", float, 32, 1, 1), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 4) @llvm.riscv.ztt.mmul.ew.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_1_4t.triscv.ztt.m.i32_i32_32_1_4t(target("riscv.ztt.m.i32", i32, 32, 1, 4), target("riscv.ztt.m.i32", i32, 32, 1, 4), i32 immarg, i32 immarg)

attributes #38 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #0 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #1 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #2 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #3 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #4 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #5 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #6 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #7 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #8 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #9 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #10 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #11 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #12 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #13 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #14 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #15 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #16 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #17 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #18 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #19 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #20 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #21 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #22 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #23 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
attributes #24 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
attributes #25 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #26 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #27 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #28 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #29 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #30 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #31 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #32 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #33 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #34 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #35 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #36 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a16" }
attributes #37 = { nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }

;--- mmul-ew-invalid-ll/checks.txt
; ACC-RESULT: Ztt mmul.ew requires an M result
; ACC-SOURCE: Ztt mmul.ew requires M sources
; ZERO-SQUARES: Ztt mmul.ew has an invalid result layout
; SIZE-MISMATCH: Ztt mmul.ew has an invalid result layout
; BAD-SOURCE-LAYOUT: Ztt mmul.ew has an invalid source layout

;--- mmul-ew-invalid-ll/tmp/acc-result.ll
define target("riscv.ztt.acc.i32", i32, 32, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %d
}
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)

; ACC-SOURCE: Ztt mmul.ew requires M sources

;--- mmul-ew-invalid-ll/tmp/acc-source.ll
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.acc.i32", i32, 32, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.acc.i32", i32, 32, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.acc.i32", i32, 32, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)

; ZERO-SQUARES: Ztt mmul.ew has an invalid result layout

;--- mmul-ew-invalid-ll/tmp/zero-squares.ll
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 0)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)


;--- mmul-ew-invalid-ll/tmp/size-mismatch.ll
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)

; BAD-SOURCE-LAYOUT: Ztt mmul.ew has an invalid source layout

;--- mmul-ew-invalid-ll/tmp/bad-source-layout.ll
; No large matrix parameter ABI is needed to test a malformed intrinsic.
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test() "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i128", i128, 128, 1, 2) poison, target("riscv.ztt.m.i32", i32, 32, 1, 1) poison, i32 1073741856, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mmul.ew.bad(target("riscv.ztt.m.i128", i128, 128, 1, 2), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
;--- mmul-ew-mir/input.mir
# Pseudos already carry physical layouts; check all implicit metadata/data
# dependencies, not only the three registers printed in the assembly.
--- |
  define void @packed_wide_spans() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @multiple_ops() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @equal_sources() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
  define void @wide_sixteen() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: packed_wide_spans
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0, $zttm2m2, $x10

    ; CHECK-LABEL: name: packed_wide_spans
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0, $zttm2m2, $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm4 = ZTT_MSETTYP $x10, implicit-def $zttm5
    ; CHECK-NEXT: $zttm6 = ZTT_MSETTYP $x10, implicit-def $zttm7
    ; CHECK-NEXT: $zttm4 = ZTT_MMUL_EW $zttm0, $zttm2, implicit $zttm4, implicit $zttm5, implicit-def $zttm5, implicit $zttm6, implicit-def $zttm6, implicit $zttm7, implicit-def $zttm7, implicit $zttm3
    ; CHECK-NEXT: PseudoRET implicit $zttm4m4
    early-clobber $zttm4m4 = PseudoZTTMmulEw_G004_G101_G202 killed $zttm0, $zttm2m2, $x10, 1, 2
    PseudoRET implicit $zttm4m4
...
---
name: multiple_ops
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2, $zttm4m4, $x10

    ; CHECK-LABEL: name: multiple_ops
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0m2, $zttm4m4, $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm8 = ZTT_MSETTYP $x10, implicit-def $zttm9
    ; CHECK-NEXT: $zttm10 = ZTT_MSETTYP $x10, implicit-def $zttm11
    ; CHECK-NEXT: $zttm8 = ZTT_MMUL_EW $zttm0, $zttm4, implicit $zttm8, implicit $zttm9, implicit-def $zttm9, implicit $zttm5
    ; CHECK-NEXT: $zttm10 = ZTT_MMUL_EW $zttm1, $zttm6, implicit $zttm10, implicit $zttm11, implicit-def $zttm11, implicit $zttm7
    ; CHECK-NEXT: PseudoRET implicit $zttm8m4
    early-clobber $zttm8m4 = PseudoZTTMmulEw_G004_G102_G204 killed $zttm0m2, $zttm4m4, $x10, 2, 2
    PseudoRET implicit $zttm8m4
...
---
name: equal_sources
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm0m2, $x10

    ; CHECK-LABEL: name: equal_sources
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm0m2, $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm2 = ZTT_MSETTYP $x10
    ; CHECK-NEXT: $zttm3 = ZTT_MSETTYP $x10
    ; CHECK-NEXT: $zttm2 = ZTT_MMUL_EW $zttm0, $zttm0, implicit $zttm2
    ; CHECK-NEXT: $zttm3 = ZTT_MMUL_EW $zttm1, $zttm1, implicit $zttm3
    ; CHECK-NEXT: PseudoRET implicit $zttm2m2
    early-clobber $zttm2m2 = PseudoZTTMmulEw_G002_G102_G202 killed $zttm0m2, $zttm0m2, $x10, 2, 1
    PseudoRET implicit $zttm2m2
...
---
name: wide_sixteen
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $zttm16m16, $x10

    ; CHECK-LABEL: name: wide_sixteen
    ; CHECK: bb.0:
    ; CHECK-NEXT: liveins: $zttm16m16, $x10
    ; CHECK-NEXT: {{  $}}
    ; CHECK-NEXT: $zttm0 = ZTT_MSETTYP $x10, implicit-def $zttm1, implicit-def $zttm2, implicit-def $zttm3, implicit-def $zttm4, implicit-def $zttm5, implicit-def $zttm6, implicit-def $zttm7, implicit-def $zttm8, implicit-def $zttm9, implicit-def $zttm10, implicit-def $zttm11, implicit-def $zttm12, implicit-def $zttm13, implicit-def $zttm14, implicit-def $zttm15
    ; CHECK-NEXT: $zttm0 = ZTT_MMUL_EW $zttm16, $zttm16, implicit $zttm0, implicit $zttm1, implicit-def $zttm1, implicit $zttm2, implicit-def $zttm2, implicit $zttm3, implicit-def $zttm3, implicit $zttm4, implicit-def $zttm4, implicit $zttm5, implicit-def $zttm5, implicit $zttm6, implicit-def $zttm6, implicit $zttm7, implicit-def $zttm7, implicit $zttm8, implicit-def $zttm8, implicit $zttm9, implicit-def $zttm9, implicit $zttm10, implicit-def $zttm10, implicit $zttm11, implicit-def $zttm11, implicit $zttm12, implicit-def $zttm12, implicit $zttm13, implicit-def $zttm13, implicit $zttm14, implicit-def $zttm14, implicit $zttm15, implicit-def $zttm15, implicit $zttm17, implicit $zttm18, implicit $zttm19, implicit $zttm20, implicit $zttm21, implicit $zttm22, implicit $zttm23, implicit $zttm24, implicit $zttm25, implicit $zttm26, implicit $zttm27, implicit $zttm28, implicit $zttm29, implicit $zttm30, implicit $zttm31, implicit $zttm17, implicit $zttm18, implicit $zttm19, implicit $zttm20, implicit $zttm21, implicit $zttm22, implicit $zttm23, implicit $zttm24, implicit $zttm25, implicit $zttm26, implicit $zttm27, implicit $zttm28, implicit $zttm29, implicit $zttm30, implicit $zttm31
    ; CHECK-NEXT: PseudoRET implicit $zttm0m16
    early-clobber $zttm0m16 = PseudoZTTMmulEw_G016_G116_G216 killed $zttm16m16, $zttm16m16, $x10, 1, 16
    PseudoRET implicit $zttm0m16
...
