; RUN: split-file %s %t
; RUN: not llvm-as %t/types.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=TYPE
; RUN: not llvm-as %t/immediates.ll -o /dev/null 2>&1 | FileCheck %s --check-prefix=IMM

;--- types.ll

; Datatype and square count arguments are i32, for both M and ACC.
; TYPE: intrinsic argument 0 type expected i32, but got i64
; TYPE-NEXT: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m(i64, i32)

; TYPE: intrinsic has incorrect number of args. Expected 2, but got 1
; TYPE-NEXT: declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mclear.acc
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mclear.acc(i32)

; M-to-M copy requires identical source and result types.
; TYPE: intrinsic argument 0 type (matching overload type 0) expected target("riscv.ztt.m.i16", i16, 16, 1, 2), but got target("riscv.ztt.m.i32", i32, 32, 1, 2)
; TYPE-NEXT: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcopy.m2m
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcopy.m2m(target("riscv.ztt.m.i32", i32, 32, 1, 2), i32, i32)

; Concat requires identical input types, including shape direction.
; TYPE: intrinsic argument 1 type (matching overload type 1) expected target("riscv.ztt.m.i16", i16, 16, 1, 2), but got target("riscv.ztt.m.i16", i16, 16, 2, 1)
; TYPE-NEXT: declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 2, 1), i32, i32)

; Matmul's old ACC must have the result type, including its square count.
; TYPE: intrinsic argument 0 type (matching overload type 0) expected target("riscv.ztt.acc.i32", i32, 32, 2), but got target("riscv.ztt.acc.i32", i32, 32, 1)
; TYPE-NEXT: declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d(target("riscv.ztt.acc.i32", i32, 32, 1), target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i32", i32, 32, 2, 1), i32)

; Scalar bits use an integer IR operand, even for floating-point data.
; TYPE: intrinsic argument 1 type (overload type 2) expected any integer or integer vector, but got float
; TYPE-NEXT: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x(target("riscv.ztt.m.i16", i16, 16, 1, 2), float, i32, i32, i32)

; Acquire matches its integer input and result; CSR reads return an integer.
; TYPE: intrinsic argument 0 type (matching overload type 0) expected i64, but got i32
; TYPE-NEXT: declare i64 @llvm.riscv.ztt.ame.acquire.i64(i32)
declare i64 @llvm.riscv.ztt.ame.acquire.i64(i32)

; TYPE: intrinsic return type (overload type 0) expected any integer or integer vector, but got float
; TYPE-NEXT: declare float @llvm.riscv.ztt.get.amenlen.f32()
declare float @llvm.riscv.ztt.get.amenlen.f32()

;--- immediates.ll

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m(i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc(i32, i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x(target("riscv.ztt.m.i16", i16, 16, 1, 2), i64, i32, i32, i32)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d(target("riscv.ztt.acc.i32", i32, 32, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 2, 1), i32)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract(target("riscv.ztt.m.i16", i16, 16, 1, 4), i64, i32, i32)

define void @nonconstant_arguments(i32 %metadata, i64 %index) {
  ; IMM: immarg operand has non-immediate parameter
  ; IMM-NEXT: i32 %metadata
  ; IMM-NEXT: %bad_datatype = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.
  %bad_datatype = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m(i32 %metadata, i32 2)

  ; IMM: immarg operand has non-immediate parameter
  ; IMM-NEXT: i32 %metadata
  ; IMM-NEXT: %bad_m_squares = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.
  %bad_m_squares = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m(i32 1073741840, i32 %metadata)

  ; IMM: immarg operand has non-immediate parameter
  ; IMM-NEXT: i32 %metadata
  ; IMM-NEXT: %bad_acc_squares = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc.
  %bad_acc_squares = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc(i32 1073741856, i32 %metadata)

  ; IMM: immarg operand has non-immediate parameter
  ; IMM-NEXT: i32 %metadata
  ; IMM-NEXT: %bad_scalar_datatype = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x.
  %bad_scalar_datatype = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x(target("riscv.ztt.m.i16", i16, 16, 1, 2) poison, i64 1, i32 1073741840, i32 %metadata, i32 2)

  ; IMM: immarg operand has non-immediate parameter
  ; IMM-NEXT: i32 %metadata
  ; IMM-NEXT: %bad_matmul_squares = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d.
  %bad_matmul_squares = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d(target("riscv.ztt.acc.i32", i32, 32, 2) poison, target("riscv.ztt.m.i16", i16, 16, 1, 2) poison, target("riscv.ztt.m.i16", i16, 16, 2, 1) poison, i32 %metadata)

  ; IMM: immarg operand has non-immediate parameter
  ; IMM-NEXT: i64 %index
  ; IMM-NEXT: %bad_index = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.
  %bad_index = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract(target("riscv.ztt.m.i16", i16, 16, 1, 4) poison, i64 %index, i32 1073741840, i32 2)
  ret void
}
