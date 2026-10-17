; RUN: split-file %s %t
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/load-zero.ll -o /dev/null 2>&1 | FileCheck %t/load-zero.ll --check-prefix=DTYPE
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/load-zero.ll -o /dev/null 2>&1 | FileCheck %t/load-zero.ll --check-prefix=DTYPE
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/store-zero.ll -o /dev/null 2>&1 | FileCheck %t/store-zero.ll --check-prefix=DTYPE
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/store-zero.ll -o /dev/null 2>&1 | FileCheck %t/store-zero.ll --check-prefix=DTYPE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/zero-descriptor.ll > %t.ztt-profile-0.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-0.ll -o - 2>&1 | FileCheck %t/zero-descriptor.ll --check-prefix=DTYPE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/zero-descriptor.ll > %t.ztt-profile-1.ll
; RUN: not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o - 2>&1 | FileCheck %t/zero-descriptor.ll --check-prefix=DTYPE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/dynamic-descriptor.ll > %t.ztt-profile-2.ll
; RUN: not llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-2.ll -o - 2>&1 | FileCheck %t/dynamic-descriptor.ll --check-prefix=IMMARG
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/dynamic-descriptor.ll > %t.ztt-profile-3.ll
; RUN: not llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-3.ll -o - 2>&1 | FileCheck %t/dynamic-descriptor.ll --check-prefix=IMMARG
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/dynamic-squares.ll > %t.ztt-profile-4.ll
; RUN: not llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-4.ll -o - 2>&1 | FileCheck %t/dynamic-squares.ll --check-prefix=IMMARG
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u32-m32-a16/g' %t/dynamic-squares.ll > %t.ztt-profile-5.ll
; RUN: not llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-5.ll -o - 2>&1 | FileCheck %t/dynamic-squares.ll --check-prefix=IMMARG
; RUN: llc -mtriple=riscv32 -verify-machineinstrs %t/encodings/input.ll -o - | FileCheck %t/encodings/input.ll
; RUN: llc -mtriple=riscv64 -verify-machineinstrs %t/encodings/input.ll -o - | FileCheck %t/encodings/input.ll
; RUN: not --crash llc -mtriple=riscv32 -verify-machineinstrs %t/invalid/input.ll -o /dev/null 2>&1 | FileCheck %t/invalid/input.ll
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/invalid/input.ll -o /dev/null 2>&1 | FileCheck %t/invalid/input.ll

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- encodings/input.ll
; Descriptor constants are derived from Ztt v0.6 section 2.4, independently of
; instruction selection. Check M/ACC clear and a load -> mcopy -> m2a -> a2m
; -> store pipeline. The pipeline uses no matrix function arguments or returns.
; bf16 covers wide (UDS8), standard (UDS16) and packed (UDS32/128).
; Wide continuation registers must not get extra settyp or move instructions.

; i16: 0x40000010, UDS=16, 1 square(s).
define target("riscv.ztt.m.i16", i16, 16, 1, 1) @clear_m_i16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_m_i16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_1t(i32 1073741840, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.acc.i16", i16, 16, 1) @clear_acc_i16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_acc_i16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 262144
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i16_i16_16_1t(i32 1073741840, i32 1)
  ret target("riscv.ztt.acc.i16", i16, 16, 1) %r
}

define void @pipeline_i16_uds16(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: pipeline_i16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 262144
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m1
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_1t(ptr %p, i32 1073741840, i32 1)
  %copy = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1) %v, i32 1073741840, i32 1)
  %acc = call target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_1t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1) %copy, i32 1073741840, i32 1)
  %back = call target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.acc.i16_i16_16_1t(target("riscv.ztt.acc.i16", i16, 16, 1) %acc, i32 1073741840, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_1_1t(ptr %p, target("riscv.ztt.m.i16", i16, 16, 1, 1) %back, i32 1073741840, i32 1)
  ret void
}

; u16: 0x10, UDS=16, 1 square(s).
define target("riscv.ztt.m.u16", i16, 16, 1, 1) @clear_m_u16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_m_u16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.u16_i16_16_1_1t(i32 16, i32 1)
  ret target("riscv.ztt.m.u16", i16, 16, 1, 1) %r
}

define target("riscv.ztt.acc.u16", i16, 16, 1) @clear_acc_u16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_acc_u16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.u16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.u16_i16_16_1t(i32 16, i32 1)
  ret target("riscv.ztt.acc.u16", i16, 16, 1) %r
}

define void @pipeline_u16_uds16(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: pipeline_u16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m1
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.u16_i16_16_1_1t(ptr %p, i32 16, i32 1)
  %copy = call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.u16_i16_16_1_1t(target("riscv.ztt.m.u16", i16, 16, 1, 1) %v, i32 16, i32 1)
  %acc = call target("riscv.ztt.acc.u16", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u16_i16_16_1t.triscv.ztt.m.u16_i16_16_1_1t(target("riscv.ztt.m.u16", i16, 16, 1, 1) %copy, i32 16, i32 1)
  %back = call target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u16_i16_16_1_1t.triscv.ztt.acc.u16_i16_16_1t(target("riscv.ztt.acc.u16", i16, 16, 1) %acc, i32 16, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.u16_i16_16_1_1t(ptr %p, target("riscv.ztt.m.u16", i16, 16, 1, 1) %back, i32 16, i32 1)
  ret void
}

; f16: 0x14300110, UDS=16, 1 square(s).
define target("riscv.ztt.m.f16", half, 16, 1, 1) @clear_m_f16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_m_f16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.f16_f16_16_1_1t(i32 338690320, i32 1)
  ret target("riscv.ztt.m.f16", half, 16, 1, 1) %r
}

define target("riscv.ztt.acc.f16", half, 16, 1) @clear_acc_f16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_acc_f16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 82688
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.f16", half, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.f16_f16_16_1t(i32 338690320, i32 1)
  ret target("riscv.ztt.acc.f16", half, 16, 1) %r
}

define void @pipeline_f16_uds16(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: pipeline_f16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 82688
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m1
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.f16_f16_16_1_1t(ptr %p, i32 338690320, i32 1)
  %copy = call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f16_f16_16_1_1t(target("riscv.ztt.m.f16", half, 16, 1, 1) %v, i32 338690320, i32 1)
  %acc = call target("riscv.ztt.acc.f16", half, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f16_f16_16_1t.triscv.ztt.m.f16_f16_16_1_1t(target("riscv.ztt.m.f16", half, 16, 1, 1) %copy, i32 338690320, i32 1)
  %back = call target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f16_f16_16_1_1t.triscv.ztt.acc.f16_f16_16_1t(target("riscv.ztt.acc.f16", half, 16, 1) %acc, i32 338690320, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.f16_f16_16_1_1t(ptr %p, target("riscv.ztt.m.f16", half, 16, 1, 1) %back, i32 338690320, i32 1)
  ret void
}

; bf16: 0x20300110, UDS=16, 1 square(s).
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @clear_m_bf16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_m_bf16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %r
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @clear_acc_bf16_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_acc_bf16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %r
}

define void @pipeline_bf16_uds16(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: pipeline_bf16_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m1
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_1t(ptr %p, i32 540016912, i32 1)
  %copy = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %v, i32 540016912, i32 1)
  %acc = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_1t.triscv.ztt.m.bf16_bf16_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %copy, i32 540016912, i32 1)
  %back = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_1_1t.triscv.ztt.acc.bf16_bf16_16_1t(target("riscv.ztt.acc.bf16", bfloat, 16, 1) %acc, i32 540016912, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_1t(ptr %p, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %back, i32 540016912, i32 1)
  ret void
}

; f32: 0x20300120, UDS=16, 1 square(s).
define target("riscv.ztt.m.f32", float, 32, 1, 1) @clear_m_f32_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_m_f32_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 288
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.f32_f32_32_1_1t(i32 540016928, i32 1)
  ret target("riscv.ztt.m.f32", float, 32, 1, 1) %r
}

define target("riscv.ztt.acc.f32", float, 32, 1) @clear_acc_f32_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_acc_f32_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 288
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.f32", float, 32, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.f32_f32_32_1t(i32 540016928, i32 1)
  ret target("riscv.ztt.acc.f32", float, 32, 1) %r
}

define void @pipeline_f32_uds16(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: pipeline_f32_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 288
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m2
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.f32_f32_32_1_1t(ptr %p, i32 540016928, i32 1)
  %copy = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1) %v, i32 540016928, i32 1)
  %acc = call target("riscv.ztt.acc.f32", float, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f32_f32_32_1t.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1) %copy, i32 540016928, i32 1)
  %back = call target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f32_f32_32_1_1t.triscv.ztt.acc.f32_f32_32_1t(target("riscv.ztt.acc.f32", float, 32, 1) %acc, i32 540016928, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.f32_f32_32_1_1t(ptr %p, target("riscv.ztt.m.f32", float, 32, 1, 1) %back, i32 540016928, i32 1)
  ret void
}

; f64: 0x2c300140, UDS=16, 1 square(s).
define target("riscv.ztt.m.f64", double, 64, 1, 1) @clear_m_f64_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_m_f64_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.f64_f64_64_1_1t(i32 741343552, i32 1)
  ret target("riscv.ztt.m.f64", double, 64, 1, 1) %r
}

define target("riscv.ztt.acc.f64", double, 64, 1) @clear_acc_f64_uds16() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: clear_acc_f64_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 180992
; CHECK-NEXT:    addi a0, a0, 320
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.f64", double, 64, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.f64_f64_64_1t(i32 741343552, i32 1)
  ret target("riscv.ztt.acc.f64", double, 64, 1) %r
}

define void @pipeline_f64_uds16(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" {
; CHECK-LABEL: pipeline_f64_uds16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 180992
; CHECK-NEXT:    addi a1, a1, 320
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m4, a1
; CHECK-NEXT:    mmov.m.m m4, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m4
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.f64_f64_64_1_1t(ptr %p, i32 741343552, i32 1)
  %copy = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f64_f64_64_1_1t(target("riscv.ztt.m.f64", double, 64, 1, 1) %v, i32 741343552, i32 1)
  %acc = call target("riscv.ztt.acc.f64", double, 64, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f64_f64_64_1t.triscv.ztt.m.f64_f64_64_1_1t(target("riscv.ztt.m.f64", double, 64, 1, 1) %copy, i32 741343552, i32 1)
  %back = call target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f64_f64_64_1_1t.triscv.ztt.acc.f64_f64_64_1t(target("riscv.ztt.acc.f64", double, 64, 1) %acc, i32 741343552, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.f64_f64_64_1_1t(ptr %p, target("riscv.ztt.m.f64", double, 64, 1, 1) %back, i32 741343552, i32 1)
  ret void
}

; bf16: 0x20300110, UDS=8, 1 square(s).
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @clear_m_bf16_uds8() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
; CHECK-LABEL: clear_m_bf16_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %r
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 1) @clear_acc_bf16_uds8() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
; CHECK-LABEL: clear_acc_bf16_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_1t(i32 540016912, i32 1)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 1) %r
}

define void @pipeline_bf16_uds8(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
; CHECK-LABEL: pipeline_bf16_uds8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m2, a1
; CHECK-NEXT:    mmov.m.m m2, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    mmov.a.m acc0, m2
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_1t(ptr %p, i32 540016912, i32 1)
  %copy = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %v, i32 540016912, i32 1)
  %acc = call target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_1t.triscv.ztt.m.bf16_bf16_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %copy, i32 540016912, i32 1)
  %back = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_1_1t.triscv.ztt.acc.bf16_bf16_16_1t(target("riscv.ztt.acc.bf16", bfloat, 16, 1) %acc, i32 540016912, i32 1)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_1t(ptr %p, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) %back, i32 540016912, i32 1)
  ret void
}

; bf16: 0x20300110, UDS=32, 2 square(s).
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @clear_m_bf16_uds32() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: clear_m_bf16_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %r
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 2) @clear_acc_bf16_uds32() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: clear_acc_bf16_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_2t(i32 540016912, i32 2)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 2) %r
}

define void @pipeline_bf16_uds32(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" {
; CHECK-LABEL: pipeline_bf16_uds32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    asettyp acc1, a1
; CHECK-NEXT:    mmov.a.m acc0, m1
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_2t(ptr %p, i32 540016912, i32 2)
  %copy = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_2t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %v, i32 540016912, i32 2)
  %acc = call target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_2t.triscv.ztt.m.bf16_bf16_16_1_2t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %copy, i32 540016912, i32 2)
  %back = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_1_2t.triscv.ztt.acc.bf16_bf16_16_2t(target("riscv.ztt.acc.bf16", bfloat, 16, 2) %acc, i32 540016912, i32 2)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_2t(ptr %p, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) %back, i32 540016912, i32 2)
  ret void
}

; bf16: 0x20300110, UDS=128, 8 square(s).
define target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @clear_m_bf16_uds128() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: clear_m_bf16_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    msettyp m0, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %r
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @clear_acc_bf16_uds128() "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: clear_acc_bf16_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 131840
; CHECK-NEXT:    addi a0, a0, 272
; CHECK-NEXT:    asettyp acc0, a0
; CHECK-NEXT:    asettyp acc1, a0
; CHECK-NEXT:    asettyp acc2, a0
; CHECK-NEXT:    asettyp acc3, a0
; CHECK-NEXT:    asettyp acc4, a0
; CHECK-NEXT:    asettyp acc5, a0
; CHECK-NEXT:    asettyp acc6, a0
; CHECK-NEXT:    asettyp acc7, a0
; CHECK-NEXT:    ret
  %r = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_8t(i32 540016912, i32 8)
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) %r
}

; Exercise the complete A8/M1 packed round trip at UDS128.
define void @pipeline_bf16_uds128(ptr %p) "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" {
; CHECK-LABEL: pipeline_bf16_uds128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a1, 131840
; CHECK-NEXT:    addi a1, a1, 272
; CHECK-NEXT:    mv a2, a0
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mls.rm m0, a2
; CHECK-NEXT:    msettyp m1, a1
; CHECK-NEXT:    mmov.m.m m1, m0
; CHECK-NEXT:    asettyp acc0, a1
; CHECK-NEXT:    asettyp acc1, a1
; CHECK-NEXT:    asettyp acc2, a1
; CHECK-NEXT:    asettyp acc3, a1
; CHECK-NEXT:    asettyp acc4, a1
; CHECK-NEXT:    asettyp acc5, a1
; CHECK-NEXT:    asettyp acc6, a1
; CHECK-NEXT:    asettyp acc7, a1
; CHECK-NEXT:    mmov.a.m acc0, m1
; CHECK-NEXT:    msettyp m0, a1
; CHECK-NEXT:    mmov.m.a m0, acc0
; CHECK-NEXT:    mss.cm m0, a0
; CHECK-NEXT:    ret
  %v = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_8t(ptr %p, i32 540016912, i32 8)
  %copy = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %v, i32 540016912, i32 8)
  %acc = call target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bfloat_16_8t.triscv.ztt.m.bf16_bfloat_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %copy, i32 540016912, i32 8)
  %back = call target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bfloat_16_1_8t.triscv.ztt.acc.bf16_bfloat_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8) %acc, i32 540016912, i32 8)
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_8t(ptr %p, target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) %back, i32 540016912, i32 8)
  ret void
}

declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_1t(i32, i32)

declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bfloat_16_8t.triscv.ztt.m.bf16_bfloat_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bfloat_16_1_8t.triscv.ztt.acc.bf16_bfloat_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8), i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i16_i16_16_1t(i32, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i16_i16_16_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1), i32, i32)
declare target("riscv.ztt.acc.i16", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.i16_i16_16_1t.triscv.ztt.m.i16_i16_16_1_1t(target("riscv.ztt.m.i16", i16, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.i16_i16_16_1_1t.triscv.ztt.acc.i16_i16_16_1t(target("riscv.ztt.acc.i16", i16, 16, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i16_i16_16_1_1t(ptr, target("riscv.ztt.m.i16", i16, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.u16_i16_16_1_1t(i32, i32)
declare target("riscv.ztt.acc.u16", i16, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.u16_i16_16_1t(i32, i32 immarg)
declare target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.u16_i16_16_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.u16_i16_16_1_1t(target("riscv.ztt.m.u16", i16, 16, 1, 1), i32, i32)
declare target("riscv.ztt.acc.u16", i16, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.u16_i16_16_1t.triscv.ztt.m.u16_i16_16_1_1t(target("riscv.ztt.m.u16", i16, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.u16", i16, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.u16_i16_16_1_1t.triscv.ztt.acc.u16_i16_16_1t(target("riscv.ztt.acc.u16", i16, 16, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.u16_i16_16_1_1t(ptr, target("riscv.ztt.m.u16", i16, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.f16_f16_16_1_1t(i32, i32)
declare target("riscv.ztt.acc.f16", half, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.f16_f16_16_1t(i32, i32 immarg)
declare target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.f16_f16_16_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f16_f16_16_1_1t(target("riscv.ztt.m.f16", half, 16, 1, 1), i32, i32)
declare target("riscv.ztt.acc.f16", half, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f16_f16_16_1t.triscv.ztt.m.f16_f16_16_1_1t(target("riscv.ztt.m.f16", half, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.f16", half, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f16_f16_16_1_1t.triscv.ztt.acc.f16_f16_16_1t(target("riscv.ztt.acc.f16", half, 16, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.f16_f16_16_1_1t(ptr, target("riscv.ztt.m.f16", half, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_1t(i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_1t(i32, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_1t.triscv.ztt.m.bf16_bf16_16_1_1t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_1_1t.triscv.ztt.acc.bf16_bf16_16_1t(target("riscv.ztt.acc.bf16", bfloat, 16, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_1t(ptr, target("riscv.ztt.m.bf16", bfloat, 16, 1, 1), i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.f32_f32_32_1_1t(i32, i32)
declare target("riscv.ztt.acc.f32", float, 32, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.f32_f32_32_1t(i32, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.f32_f32_32_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1), i32, i32)
declare target("riscv.ztt.acc.f32", float, 32, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f32_f32_32_1t.triscv.ztt.m.f32_f32_32_1_1t(target("riscv.ztt.m.f32", float, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.f32", float, 32, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f32_f32_32_1_1t.triscv.ztt.acc.f32_f32_32_1t(target("riscv.ztt.acc.f32", float, 32, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.f32_f32_32_1_1t(ptr, target("riscv.ztt.m.f32", float, 32, 1, 1), i32, i32)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.f64_f64_64_1_1t(i32, i32)
declare target("riscv.ztt.acc.f64", double, 64, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.f64_f64_64_1t(i32, i32 immarg)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.f64_f64_64_1_1t(ptr, i32, i32)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.f64_f64_64_1_1t(target("riscv.ztt.m.f64", double, 64, 1, 1), i32, i32)
declare target("riscv.ztt.acc.f64", double, 64, 1) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.f64_f64_64_1t.triscv.ztt.m.f64_f64_64_1_1t(target("riscv.ztt.m.f64", double, 64, 1, 1), i32, i32)
declare target("riscv.ztt.m.f64", double, 64, 1, 1) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.f64_f64_64_1_1t.triscv.ztt.acc.f64_f64_64_1t(target("riscv.ztt.acc.f64", double, 64, 1), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.f64_f64_64_1_1t(ptr, target("riscv.ztt.m.f64", double, 64, 1, 1), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_2t(i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_2t(i32, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_2t(ptr, i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_2t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 2) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_2t.triscv.ztt.m.bf16_bf16_16_1_2t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 2) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_1_2t.triscv.ztt.acc.bf16_bf16_16_2t(target("riscv.ztt.acc.bf16", bfloat, 16, 2), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_2t(ptr, target("riscv.ztt.m.bf16", bfloat, 16, 1, 2), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.bf16_bf16_16_1_8t(i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.bf16_bf16_16_8t(i32, i32 immarg)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.bf16_bf16_16_1_8t(ptr, i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.bf16_bf16_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), i32, i32)
declare target("riscv.ztt.acc.bf16", bfloat, 16, 8) @llvm.riscv.ztt.mcopy.m2a.triscv.ztt.acc.bf16_bf16_16_8t.triscv.ztt.m.bf16_bf16_16_1_8t(target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), i32, i32)
declare target("riscv.ztt.m.bf16", bfloat, 16, 1, 8) @llvm.riscv.ztt.mcopy.a2m.triscv.ztt.m.bf16_bf16_16_1_8t.triscv.ztt.acc.bf16_bf16_16_8t(target("riscv.ztt.acc.bf16", bfloat, 16, 8), i32, i32)
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.bf16_bf16_16_1_8t(ptr, target("riscv.ztt.m.bf16", bfloat, 16, 1, 8), i32, i32)

;--- invalid/input.ll
; CHECK: LLVM ERROR: Ztt datatype has an invalid element size

; Descriptor layout validation is shared by all matrix-producing families.
; mcopy is a representative consumer, not the owner of this constraint.
; A descriptor with properties but no element-size bits must not reach layout.
define target("riscv.ztt.m.i16", i16, 16, 1, 1) @zero_size(
    target("riscv.ztt.m.i16", i16, 16, 1, 1) %src) #0 {
  %r = call target("riscv.ztt.m.i16", i16, 16, 1, 1)
    @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_1t(
      target("riscv.ztt.m.i16", i16, 16, 1, 1) %src, i32 1073741824, i32 1)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) %r
}
declare target("riscv.ztt.m.i16", i16, 16, 1, 1)
  @llvm.riscv.ztt.mcopy.m2m.triscv.ztt.m.i16_i16_16_1_1t(
    target("riscv.ztt.m.i16", i16, 16, 1, 1), i32, i32)
attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }

;--- load-zero.ll
; DTYPE: LLVM ERROR: Ztt datatype has an invalid element size
declare target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i8_i8_8_1_4t(ptr, i32, i32)
define target("riscv.ztt.m.i8", i8, 8, 1, 4) @test(ptr %p) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
  %v = call target("riscv.ztt.m.i8", i8, 8, 1, 4) @llvm.riscv.ztt.mls.rm.triscv.ztt.m.i8_i8_8_1_4t(ptr %p, i32 0, i32 4)
  ret target("riscv.ztt.m.i8", i8, 8, 1, 4) %v
}


;--- store-zero.ll
; DTYPE: LLVM ERROR: Ztt datatype has an invalid element size
declare void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i8_i8_8_1_4t(ptr, target("riscv.ztt.m.i8", i8, 8, 1, 4), i32, i32)
define void @test(ptr %p, target("riscv.ztt.m.i8", i8, 8, 1, 4) %v) "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" {
  call void @llvm.riscv.ztt.mss.cm.triscv.ztt.m.i8_i8_8_1_4t(ptr %p, target("riscv.ztt.m.i8", i8, 8, 1, 4) %v, i32 0, i32 4)
  ret void
}


;--- zero-descriptor.ll
; DTYPE: LLVM ERROR: Ztt datatype has an invalid element size
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 0, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)



;--- dynamic-descriptor.ll
; IMMARG: immarg operand has non-immediate parameter
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control, i32 1)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)



;--- dynamic-squares.ll
; IMMARG: immarg operand has non-immediate parameter
define target("riscv.ztt.m.i32", i32, 32, 1, 1) @test(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 %control) "riscv-ztt-profile"="ZTT_PROFILE" {
  %d = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1) %a, target("riscv.ztt.m.i32", i32, 32, 1, 1) %b, i32 1073741856, i32 %control)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 1) %d
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.bad(target("riscv.ztt.m.i32", i32, 32, 1, 1), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
