; RUN: split-file %s %t
; RUN: sed 's/iXLEN/i32/g' %t/invalid-scalar.ll | not --crash llc -mtriple=riscv32 -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/invalid-scalar.ll --check-prefix=INVALID
; RUN: sed 's/iXLEN/i64/g' %t/invalid-scalar.ll | not --crash llc -mtriple=riscv64 -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/invalid-scalar.ll --check-prefix=INVALID
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -verify-machineinstrs %t/bf16-payload/input.ll -o - | FileCheck %t/bf16-payload/input.ll
; RUN: sed 's/iXLEN/i32/g' %t/raw-payload/input.ll | llc -mtriple=riscv32 -verify-machineinstrs | FileCheck %t/raw-payload/input.ll
; RUN: sed 's/iXLEN/i64/g' %t/raw-payload/input.ll | llc -mtriple=riscv64 -verify-machineinstrs | FileCheck %t/raw-payload/input.ll

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- bf16-payload/input.ll
; Migrated from the public C regression; retain its assembly expectations.
; CHECK-LABEL: bf16_scalar_bits:
; CHECK-NEXT: # %bb.0: # %entry
; CHECK-NEXT: fmv.x.w a1, fa0
; CHECK-NEXT: lui a2, 262144
; CHECK-NEXT: addi a2, a2, 32
; CHECK-NEXT: msettyp m0, a2
; CHECK-NEXT: mzero.2d.m m0
; CHECK-NEXT: slli a1, a1, 48
; CHECK-NEXT: lui a3, 131840
; CHECK-NEXT: srli a1, a1, 48
; CHECK-NEXT: addi a3, a3, 272
; CHECK-NEXT: csrw amestype, a3
; CHECK-NEXT: msettyp m2, a2
; CHECK-NEXT: madd.ew.x m2, a1, m0
; CHECK-NEXT: mss.rm m2, a0
; CHECK-NEXT: ret


; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn
define dso_local void @bf16_scalar_bits(bfloat noundef %value, ptr nofree noundef writeonly captures(none) %out) local_unnamed_addr #0 {
entry:
  %0 = tail call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32 1073741856, i32 1)
  %1 = bitcast bfloat %value to i16
  %2 = zext i16 %1 to i64
  %3 = tail call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.i64(target("riscv.ztt.m.i32", i32, 32, 1, 1) %0, i64 %2, i32 1073741856, i32 540016912, i32 1)
  tail call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %3, i32 1073741856, i32 1)
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(none)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32 immarg, i32 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.i64(target("riscv.ztt.m.i32", i32, 32, 1, 1), i64, i32 immarg, i32 immarg, i32 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr captures(none), target("riscv.ztt.m.i32", i32, 32, 1, 1), i32 immarg, i32 immarg) #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn "target-features"="+m,+a,+f,+d,+c,+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(none) }
attributes #2 = { mustprogress nocallback nofree nosync nounwind willreturn }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write) }

;--- raw-payload/input.ll
; Raw IR explicitly supplies XLEN bits. Unlike the C scalar-value interface,
; hardware may interpret these under a wider datatype, zero-extending X.
define void @raw_wider_scalar(iXLEN %scalar, ptr %out) #2 {
; CHECK-LABEL: raw_wider_scalar:
; CHECK-NEXT:    # %bb.0:
; CHECK-NEXT:    lui a2, 262144
; CHECK-NEXT:    addi a3, a2, 32
; CHECK-NEXT:    msettyp m0, a3
; CHECK-NEXT:    mzero.2d.m m0
; CHECK-NEXT:    addi a2, a2, 64
; CHECK-NEXT:    csrw amestype, a2
; CHECK-NEXT:    msettyp m1, a3
; CHECK-NEXT:    madd.ew.x m1, a0, m0
; CHECK-NEXT:    mss.rm m1, a1
; CHECK-NEXT:    ret
  %src = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32 1073741856, i32 1)
  %dst = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 1) %src, iXLEN %scalar, i32 1073741856, i32 1073741888, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %dst, i32 1073741856, i32 1)
  ret void
}

declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
attributes #2 = { nounwind "target-features"="+m,+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }

;--- invalid-scalar.ll
; A raw scalar datatype still needs a valid element-size field. The wider-than-
; XLEN positive case above is intentionally not rejected by this basic check.
; INVALID: LLVM ERROR: Ztt scalar datatype has an invalid element size

define void @invalid_scalar(iXLEN %s, ptr %out) nounwind #0 {
  %m = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32 1073741856, i32 1)
  %r = call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 1) %m, iXLEN %s, i32 1073741856, i32 1073741827, i32 1)
  call void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr %out, target("riscv.ztt.m.i32", i32, 32, 1, 1) %r, i32 1073741856, i32 1)
  ret void
}
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mzero.m.triscv.ztt.m.i32_i32_32_1_1t(i32, i32)
declare target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.madd.ew.x.triscv.ztt.m.i32_i32_32_1_1t.triscv.ztt.m.i32_i32_32_1_1t.iXLEN(target("riscv.ztt.m.i32", i32, 32, 1, 1), iXLEN, i32, i32, i32)
declare void @llvm.riscv.ztt.mss.rm.triscv.ztt.m.i32_i32_32_1_1t(ptr, target("riscv.ztt.m.i32", i32, 32, 1, 1), i32, i32)
attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
