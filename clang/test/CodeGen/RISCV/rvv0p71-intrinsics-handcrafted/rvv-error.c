// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector -disable-O0-optnone -emit-llvm %s -o - | opt -S -passes=mem2reg | FileCheck --check-prefix=CHECK-RV64V %s
// RUN: not %clang_cc1 -triple riscv64 -emit-llvm-only %s 2>&1 | FileCheck %s --check-prefix=CHECK-RV64-ERR

// CHECK-RV64V-LABEL: @test(
// CHECK-RV64V-NEXT:  entry:
// CHECK-RV64V-NEXT:    [[TMP0:%.*]] = call i64 @llvm.riscv.th.vsetvl.i64(i64 1, i64 0, i64 0)
// CHECK-RV64V-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK-RV64V-NEXT:    ret i32 [[CONV]]
//

// CHECK-RV64-ERR: error: builtin requires at least one of the following extensions to be enabled: 'Xtheadvector'

#include <riscv_th_vector.h>

int test() {
  return __builtin_rvv_vsetvli(1, 0, 0); // e8m1
}
