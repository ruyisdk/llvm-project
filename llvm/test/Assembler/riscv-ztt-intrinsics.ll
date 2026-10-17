; RUN: llvm-as < %s | llvm-dis | FileCheck %s

; State operations support both XLENs without matrix metadata.
; CHECK: declare i32 @llvm.riscv.ztt.ame.acquire.i32(i32)
declare i32 @llvm.riscv.ztt.ame.acquire.i32(i32)
; CHECK: declare i64 @llvm.riscv.ztt.ame.acquire.i64(i64)
declare i64 @llvm.riscv.ztt.ame.acquire.i64(i64)
; CHECK: declare void @llvm.riscv.ztt.ame.release()
declare void @llvm.riscv.ztt.ame.release()
; CHECK: declare i32 @llvm.riscv.ztt.get.amenlen.i32()
declare i32 @llvm.riscv.ztt.get.amenlen.i32()
; CHECK: declare i64 @llvm.riscv.ztt.get.amenlen.i64()
declare i64 @llvm.riscv.ztt.get.amenlen.i64()

; Both register kinds carry a datatype and a square count.
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m.
; CHECK-SAME: (i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mzero.m(i32, i32)
; CHECK: declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc.
; CHECK-SAME: (i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mzero.acc(i32, i32)

; Results and ordinary matrix sources have independent overload types.
; CHECK: declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mconv.ew.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.mconv.ew(target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
; CHECK: declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.madd.ew.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.f32", float, 32, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.f32", float, 32, 1, 2) @llvm.riscv.ztt.madd.ew(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.f32", float, 32, 1, 2), i32, i32)

; Data and control scalars have different metadata counts. Both XLENs work.
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 2), i64, i32 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.madd.ew.x(target("riscv.ztt.m.i16", i16, 16, 1, 2), i64, i32, i32, i32)
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.msll.ew.x.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.msll.ew.x(target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32, i32)

; Matmul takes an old ACC of the result type and two independent M types.
; CHECK: declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d.
; CHECK-SAME: (target("riscv.ztt.acc.i32", i32, 32, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i32", i32, 32, 2, 1), i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mmulacc.2d(target("riscv.ztt.acc.i32", i32, 32, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i32", i32, 32, 2, 1), i32)

; Concat matches its two inputs, not its result. Extract also fixes the index.
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mconcat.m(target("riscv.ztt.m.i16", i16, 16, 1, 2), target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 4), i64 immarg, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mextract(target("riscv.ztt.m.i16", i16, 16, 1, 4), i64, i32, i32)

; Zip/unzip have one input of the result type.
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcolzip.ew.
; CHECK-SAME: (target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mcolzip.ew(target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)

; A strided memory operation adds an overloaded integer, not an immediate.
; CHECK: declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.st.
; CHECK-SAME: (ptr captures(none), i32, i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mls.st(ptr, i32, i32, i32)
; CHECK: declare void @llvm.riscv.ztt.mss.st.
; CHECK-SAME: (ptr captures(none), i64, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32 immarg, i32 immarg)
declare void @llvm.riscv.ztt.mss.st(ptr, i64, target("riscv.ztt.m.i16", i16, 16, 1, 2), i32, i32)
