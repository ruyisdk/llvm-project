; RUN: llc -mtriple=riscv64 -mattr=+xtheadv < %s | FileCheck -check-prefix=CHECK %s

declare i64 @llvm.riscv.xvsetvl(i64, i64);
define i64 @intrinsic_xvsetvl_e8m1(i64 %0) {
entry:
; CHECK-LABEL: intrinsic_xvsetvl_e8m1
; CHECK: vsetvl a0, a0, zero
; CHECK: ret
  %v = tail call i64 @llvm.riscv.xvsetvl(i64 %0, i64 0)
  ret i64 %v
}
