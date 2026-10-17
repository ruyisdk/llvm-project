// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-n128-u32-m16-a4 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,FIXED --implicit-check-not=+ztt-profile=
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RUNTIME --implicit-check-not=+ztt-profile=
// RUN: %clang --target=riscv64 -march=rv64i_ztt -mztt-profile=clang-runtime-u32-m16-a4 -S -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RUNTIME --implicit-check-not=+ztt-profile=
// RUN: %clang_cc1 -triple riscv64 -emit-llvm -o - %s | FileCheck %s --check-prefix=NONE --implicit-check-not=riscv-ztt-profile --implicit-check-not=+ztt-profile=
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -x c++ -emit-llvm -o - %s | FileCheck %s --check-prefix=CXX --implicit-check-not=+ztt-profile=

#ifndef __cplusplus
// CHECK-LABEL: define{{.*}} i32 @f(
// CHECK-SAME: #[[PROFILE:[0-9]+]]
// CHECK: ret i32
// NONE-LABEL: define{{.*}} i32 @f(
int f(int x) { return x + 1; }

// CHECK-LABEL: define{{.*}} i32 @plain(
// CHECK-SAME: #[[PLAIN:[0-9]+]]
__attribute__((target("arch=-ztt"))) int plain(int x) { return x - 1; }

// FIXED: attributes #[[PROFILE]] = { {{.*}}"riscv-ztt-profile"="clang-n128-u32-m16-a4"
// RUNTIME: attributes #[[PROFILE]] = { {{.*}}"riscv-ztt-profile"="clang-runtime-u32-m16-a4"
// CHECK: attributes #[[PLAIN]] = {
// CHECK-NOT: riscv-ztt-profile
// CHECK-SAME: }
#else
// Compiler-generated initialization functions inherit the profile too.
extern int init();
int value = init();
// CXX-LABEL: define internal void @__cxx_global_var_init()
// CXX-SAME: #[[INIT:[0-9]+]]
// CXX-LABEL: define internal void @_GLOBAL__sub_I_
// CXX-SAME: #[[INIT]]
// CXX: attributes #[[INIT]] = { {{.*}}"riscv-ztt-profile"="clang-runtime-u32-m16-a4"
#endif
