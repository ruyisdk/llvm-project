; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/end-to-end.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %s --check-prefix=E2E
; RUN: sed 's/iXLEN/i64/g' %t/end-to-end.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %s --check-prefix=E2E
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_0.mir > %t.ztt-profile-0.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-0.mir -o - | FileCheck %s --check-prefix=CASE0
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_0.mir > %t.ztt-profile-1.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-1.mir -o - | FileCheck %s --check-prefix=CASE0
; CASE0-LABEL: layout_0:
; CASE0-NEXT: .cfi_startproc
; CASE0-NEXT: # %bb.0:
; CASE0-NEXT: msettyp m0, a0
; CASE0-NEXT: msettyp m2, a0
; CASE0-NEXT: mmov.m.m m0, m8
; CASE0-NEXT: mmov.m.m m2, m10
; CASE0-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-2.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-2.mir -o - | FileCheck %s --check-prefix=CASE1
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u8-m32-a16/g' %t/layout_1.mir > %t.ztt-profile-3.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-3.mir -o - | FileCheck %s --check-prefix=CASE1
; CASE1-LABEL: layout_1:
; CASE1-NEXT: .cfi_startproc
; CASE1-NEXT: # %bb.0:
; CASE1-NEXT: msettyp m0, a0
; CASE1-NEXT: msettyp m2, a0
; CASE1-NEXT: mmov.m.m m0, m12
; CASE1-NEXT: mmov.m.m m2, m14
; CASE1-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-4.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-4.mir -o - | FileCheck %s --check-prefix=CASE2
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_2.mir > %t.ztt-profile-5.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-5.mir -o - | FileCheck %s --check-prefix=CASE2
; CASE2-LABEL: layout_2:
; CASE2-NEXT: .cfi_startproc
; CASE2-NEXT: # %bb.0:
; CASE2-NEXT: msettyp m0, a0
; CASE2-NEXT: msettyp m1, a0
; CASE2-NEXT: mmov.m.m m0, m4
; CASE2-NEXT: mmov.m.m m1, m5
; CASE2-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-6.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-6.mir -o - | FileCheck %s --check-prefix=CASE3
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/layout_3.mir > %t.ztt-profile-7.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-7.mir -o - | FileCheck %s --check-prefix=CASE3
; CASE3-LABEL: layout_3:
; CASE3-NEXT: .cfi_startproc
; CASE3-NEXT: # %bb.0:
; CASE3-NEXT: msettyp m0, a0
; CASE3-NEXT: msettyp m1, a0
; CASE3-NEXT: mmov.m.m m0, m6
; CASE3-NEXT: mmov.m.m m1, m7
; CASE3-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-8.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-8.mir -o - | FileCheck %s --check-prefix=CASE4
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_4.mir > %t.ztt-profile-9.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-9.mir -o - | FileCheck %s --check-prefix=CASE4
; CASE4-LABEL: layout_4:
; CASE4-NEXT: .cfi_startproc
; CASE4-NEXT: # %bb.0:
; CASE4-NEXT: msettyp m0, a0
; CASE4-NEXT: mmov.m.m m0, m2
; CASE4-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_5.mir > %t.ztt-profile-10.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-10.mir -o - | FileCheck %s --check-prefix=CASE5
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_5.mir > %t.ztt-profile-11.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-11.mir -o - | FileCheck %s --check-prefix=CASE5
; CASE5-LABEL: layout_5:
; CASE5-NEXT: .cfi_startproc
; CASE5-NEXT: # %bb.0:
; CASE5-NEXT: msettyp m0, a0
; CASE5-NEXT: mmov.m.m m0, m3
; CASE5-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_6.mir > %t.ztt-profile-12.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-12.mir -o - | FileCheck %s --check-prefix=CASE6
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_6.mir > %t.ztt-profile-13.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-13.mir -o - | FileCheck %s --check-prefix=CASE6
; CASE6-LABEL: layout_6:
; CASE6-NEXT: .cfi_startproc
; CASE6-NEXT: # %bb.0:
; CASE6-NEXT: msettyp m0, a0
; CASE6-NEXT: msettyp m1, a0
; CASE6-NEXT: mmov.m.m m0, m4
; CASE6-NEXT: mmov.m.m m1, m5
; CASE6-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_7.mir > %t.ztt-profile-14.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-14.mir -o - | FileCheck %s --check-prefix=CASE7
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/layout_7.mir > %t.ztt-profile-15.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-15.mir -o - | FileCheck %s --check-prefix=CASE7
; CASE7-LABEL: layout_7:
; CASE7-NEXT: .cfi_startproc
; CASE7-NEXT: # %bb.0:
; CASE7-NEXT: msettyp m0, a0
; CASE7-NEXT: msettyp m1, a0
; CASE7-NEXT: mmov.m.m m0, m6
; CASE7-NEXT: mmov.m.m m1, m7
; CASE7-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_8.mir > %t.ztt-profile-16.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-16.mir -o - | FileCheck %s --check-prefix=CASE8
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_8.mir > %t.ztt-profile-17.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-17.mir -o - | FileCheck %s --check-prefix=CASE8
; CASE8-LABEL: layout_8:
; CASE8-NEXT: .cfi_startproc
; CASE8-NEXT: # %bb.0:
; CASE8-NEXT: msettyp m0, a0
; CASE8-NEXT: msettyp m1, a0
; CASE8-NEXT: mmov.m.m m0, m4
; CASE8-NEXT: mmov.m.m m1, m5
; CASE8-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_9.mir > %t.ztt-profile-18.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-18.mir -o - | FileCheck %s --check-prefix=CASE9
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u64-m32-a16/g' %t/layout_9.mir > %t.ztt-profile-19.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-19.mir -o - | FileCheck %s --check-prefix=CASE9
; CASE9-LABEL: layout_9:
; CASE9-NEXT: .cfi_startproc
; CASE9-NEXT: # %bb.0:
; CASE9-NEXT: msettyp m0, a0
; CASE9-NEXT: msettyp m1, a0
; CASE9-NEXT: mmov.m.m m0, m6
; CASE9-NEXT: mmov.m.m m1, m7
; CASE9-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_10.mir > %t.ztt-profile-20.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-20.mir -o - | FileCheck %s --check-prefix=CASE10
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_10.mir > %t.ztt-profile-21.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-21.mir -o - | FileCheck %s --check-prefix=CASE10
; CASE10-LABEL: layout_10:
; CASE10-NEXT: .cfi_startproc
; CASE10-NEXT: # %bb.0:
; CASE10-NEXT: msettyp m0, a0
; CASE10-NEXT: msettyp m1, a0
; CASE10-NEXT: mmov.m.m m0, m4
; CASE10-NEXT: mmov.m.m m1, m5
; CASE10-NEXT: ret
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_11.mir > %t.ztt-profile-22.mir
; RUN: llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-22.mir -o - | FileCheck %s --check-prefix=CASE11
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u128-m32-a16/g' %t/layout_11.mir > %t.ztt-profile-23.mir
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -start-before=riscv-ztt-post-ra-expand-pseudo %t.ztt-profile-23.mir -o - | FileCheck %s --check-prefix=CASE11
; CASE11-LABEL: layout_11:
; CASE11-NEXT: .cfi_startproc
; CASE11-NEXT: # %bb.0:
; CASE11-NEXT: msettyp m0, a0
; CASE11-NEXT: msettyp m1, a0
; CASE11-NEXT: mmov.m.m m0, m6
; CASE11-NEXT: mmov.m.m m1, m7
; CASE11-NEXT: ret

;--- end-to-end.ll
; Check actual IR selection and allocation, not only post-RA expansion.
; The expected slice starts at source_base + index * result_register_count.
; IR return values keep the result live; this does not define a C matrix ABI.

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @extract_i16_1x2_uds8_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
; E2E-LABEL: extract_i16_1x2_uds8_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m8, a0
; E2E-NEXT: msettyp m10, a0
; E2E-NEXT: msettyp m12, a0
; E2E-NEXT: msettyp m14, a0
; E2E-NEXT: mzero.2d.m m8
; E2E-NEXT: mzero.2d.m m10
; E2E-NEXT: mzero.2d.m m12
; E2E-NEXT: mzero.2d.m m14
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: mmov.m.m m0, m8
; E2E-NEXT: mmov.m.m m2, m10
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN 0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @extract_i16_1x2_uds8_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
; E2E-LABEL: extract_i16_1x2_uds8_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m8, a0
; E2E-NEXT: msettyp m10, a0
; E2E-NEXT: msettyp m12, a0
; E2E-NEXT: msettyp m14, a0
; E2E-NEXT: mzero.2d.m m8
; E2E-NEXT: mzero.2d.m m10
; E2E-NEXT: mzero.2d.m m12
; E2E-NEXT: mzero.2d.m m14
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: mmov.m.m m0, m12
; E2E-NEXT: mmov.m.m m2, m14
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN 1, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @extract_i16_1x2_uds16_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; E2E-LABEL: extract_i16_1x2_uds16_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m4, a0
; E2E-NEXT: msettyp m5, a0
; E2E-NEXT: msettyp m6, a0
; E2E-NEXT: msettyp m7, a0
; E2E-NEXT: mzero.2d.m m4
; E2E-NEXT: mzero.2d.m m5
; E2E-NEXT: mzero.2d.m m6
; E2E-NEXT: mzero.2d.m m7
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m1, a0
; E2E-NEXT: mmov.m.m m0, m4
; E2E-NEXT: mmov.m.m m1, m5
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN 0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @extract_i16_1x2_uds16_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; E2E-LABEL: extract_i16_1x2_uds16_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m4, a0
; E2E-NEXT: msettyp m5, a0
; E2E-NEXT: msettyp m6, a0
; E2E-NEXT: msettyp m7, a0
; E2E-NEXT: mzero.2d.m m4
; E2E-NEXT: mzero.2d.m m5
; E2E-NEXT: mzero.2d.m m6
; E2E-NEXT: mzero.2d.m m7
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m1, a0
; E2E-NEXT: mmov.m.m m0, m6
; E2E-NEXT: mmov.m.m m1, m7
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN 1, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @extract_i16_1x2_uds32_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; E2E-LABEL: extract_i16_1x2_uds32_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m2
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN 0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @extract_i16_1x2_uds32_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; E2E-LABEL: extract_i16_1x2_uds32_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m3
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_2t.triscv.ztt.m.i16_i16_16_1_4t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 4) %src, iXLEN 1, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @extract_i16_1x4_uds32_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; E2E-LABEL: extract_i16_1x4_uds32_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m4, a0
; E2E-NEXT: msettyp m5, a0
; E2E-NEXT: msettyp m6, a0
; E2E-NEXT: msettyp m7, a0
; E2E-NEXT: mzero.2d.m m4
; E2E-NEXT: mzero.2d.m m5
; E2E-NEXT: mzero.2d.m m6
; E2E-NEXT: mzero.2d.m m7
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m1, a0
; E2E-NEXT: mmov.m.m m0, m4
; E2E-NEXT: mmov.m.m m1, m5
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_8t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, iXLEN 0, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @extract_i16_1x4_uds32_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; E2E-LABEL: extract_i16_1x4_uds32_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m4, a0
; E2E-NEXT: msettyp m5, a0
; E2E-NEXT: msettyp m6, a0
; E2E-NEXT: msettyp m7, a0
; E2E-NEXT: mzero.2d.m m4
; E2E-NEXT: mzero.2d.m m5
; E2E-NEXT: mzero.2d.m m6
; E2E-NEXT: mzero.2d.m m7
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m1, a0
; E2E-NEXT: mmov.m.m m0, m6
; E2E-NEXT: mmov.m.m m1, m7
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_8t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, iXLEN 1, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @extract_i16_1x4_uds64_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; E2E-LABEL: extract_i16_1x4_uds64_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m2
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_8t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, iXLEN 0, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @extract_i16_1x4_uds64_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" {
; E2E-LABEL: extract_i16_1x4_uds64_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m3
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_4t.triscv.ztt.m.i16_i16_16_1_8t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 8) %src, iXLEN 1, i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @extract_i16_1x8_uds128_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; E2E-LABEL: extract_i16_1x8_uds128_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m2
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_16t(i32 1073741840, i32 16)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_1_16t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 16) %src, iXLEN 0, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @extract_i16_1x8_uds128_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; E2E-LABEL: extract_i16_1x8_uds128_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m3
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 1, 16) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_1_16t(i32 1073741840, i32 16)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_8t.triscv.ztt.m.i16_i16_16_1_16t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 1, 16) %src, iXLEN 1, i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @extract_i16_2x1_uds16_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; E2E-LABEL: extract_i16_2x1_uds16_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m4, a0
; E2E-NEXT: msettyp m5, a0
; E2E-NEXT: msettyp m6, a0
; E2E-NEXT: msettyp m7, a0
; E2E-NEXT: mzero.2d.m m4
; E2E-NEXT: mzero.2d.m m5
; E2E-NEXT: mzero.2d.m m6
; E2E-NEXT: mzero.2d.m m7
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m1, a0
; E2E-NEXT: mmov.m.m m0, m4
; E2E-NEXT: mmov.m.m m1, m5
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_4_1t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_2_1t.triscv.ztt.m.i16_i16_16_4_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 4, 1) %src, iXLEN 0, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 2, 1) @extract_i16_2x1_uds16_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; E2E-LABEL: extract_i16_2x1_uds16_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m4, a0
; E2E-NEXT: msettyp m5, a0
; E2E-NEXT: msettyp m6, a0
; E2E-NEXT: msettyp m7, a0
; E2E-NEXT: mzero.2d.m m4
; E2E-NEXT: mzero.2d.m m5
; E2E-NEXT: mzero.2d.m m6
; E2E-NEXT: mzero.2d.m m7
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: msettyp m1, a0
; E2E-NEXT: mmov.m.m m0, m6
; E2E-NEXT: mmov.m.m m1, m7
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 4, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_4_1t(i32 1073741840, i32 4)
  %r = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_2_1t.triscv.ztt.m.i16_i16_16_4_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 4, 1) %src, iXLEN 1, i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 2, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @extract_i16_1x1_uds16_0() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; E2E-LABEL: extract_i16_1x1_uds16_0:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m2
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_2_1t(i32 1073741840, i32 2)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_2_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 2, 1) %src, iXLEN 0, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @extract_i16_1x1_uds16_1() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; E2E-LABEL: extract_i16_1x1_uds16_1:
; E2E-NEXT: .cfi_startproc
; E2E-NEXT: # %bb.0:
; E2E-NEXT: lui a0, 262144
; E2E-NEXT: addi a0, a0, 16
; E2E-NEXT: msettyp m2, a0
; E2E-NEXT: msettyp m3, a0
; E2E-NEXT: mzero.2d.m m2
; E2E-NEXT: mzero.2d.m m3
; E2E-NEXT: msettyp m0, a0
; E2E-NEXT: mmov.m.m m0, m3
; E2E-NEXT: ret
  %src = call target("riscv.ztt.m.i16", i16, 16, 2, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i16_i16_16_2_1t(i32 1073741840, i32 2)
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mextract.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.m.i16_i16_16_2_1t.iXLEN(target("riscv.ztt.m.i16", i16, 16, 2, 1) %src, iXLEN 1, i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

;--- layout_0.mir
--- |
  define void @layout_0() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_0
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm8m8
    $zttm0m4 = PseudoZTTMextract_G004_G108 $zttm8m8, 0, $x10, 2, 2
    PseudoRET implicit $zttm0m4
...

;--- layout_1.mir
--- |
  define void @layout_1() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_1
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm8m8
    $zttm0m4 = PseudoZTTMextract_G004_G108 $zttm8m8, 1, $x10, 2, 2
    PseudoRET implicit $zttm0m4
...

;--- layout_2.mir
--- |
  define void @layout_2() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_2
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 0, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_3.mir
--- |
  define void @layout_3() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_3
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 1, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_4.mir
--- |
  define void @layout_4() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_4
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm2m2
    $zttm0 = PseudoZTTMextract_G001_G102 $zttm2m2, 0, $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- layout_5.mir
--- |
  define void @layout_5() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_5
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm2m2
    $zttm0 = PseudoZTTMextract_G001_G102 $zttm2m2, 1, $x10, 1, 1
    PseudoRET implicit $zttm0
...

;--- layout_6.mir
--- |
  define void @layout_6() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_6
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 0, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_7.mir
--- |
  define void @layout_7() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_7
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 1, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_8.mir
--- |
  define void @layout_8() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_8
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 0, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_9.mir
--- |
  define void @layout_9() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_9
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 1, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_10.mir
--- |
  define void @layout_10() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_10
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 0, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...

;--- layout_11.mir
--- |
  define void @layout_11() "riscv-ztt-profile"="ZTT_PROFILE" { ret void }
...
---
name: layout_11
tracksRegLiveness: true
body: |
  bb.0:
    liveins: $x10, $zttm4m4
    $zttm0m2 = PseudoZTTMextract_G002_G104 $zttm4m4, 1, $x10, 2, 1
    PseudoRET implicit $zttm0m2
...
