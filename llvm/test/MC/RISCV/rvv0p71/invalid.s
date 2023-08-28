# RUN: not llvm-mc -triple=riscv64 --mattr=+xtheadv %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR

vmsge.vx v2, v4, a0, v0.t, v0
# CHECK-ERROR: invalid operand for instruction

vmsgeu.vx v2, v4, a0, v0.t, v0
# CHECK-ERROR: invalid operand for instruction

vmsge.vx v2, v4, a0, v0.t, v2
# CHECK-ERROR: The temporary vector register cannot be the same as the destination register.

vmsgeu.vx v2, v4, a0, v0.t, v2
# CHECK-ERROR: The temporary vector register cannot be the same as the destination register.
