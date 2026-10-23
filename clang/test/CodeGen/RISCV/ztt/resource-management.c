// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -x c++ -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -x c++ -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV64

#include <riscv_ztt.h>
#ifdef __cplusplus
extern "C" {
#endif

// CHECK-LABEL: @acquire_dynamic(
// RV32: call i32 @llvm.riscv.ztt.ame.acquire.i32(i32
// RV64: call i64 @llvm.riscv.ztt.ame.acquire.i64(i64
size_t acquire_dynamic(size_t desc) { return __riscv_ztt_ame_acquire(desc); }

// CHECK-LABEL: @acquire_signed(
// RV64: [[DESC:%.*]] = sext i32 {{%.*}} to i64
// RV64-NEXT: {{.*}}call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 [[DESC]])
// RV32: call i32 @llvm.riscv.ztt.ame.acquire.i32(i32
size_t acquire_signed(int desc) { return __riscv_ztt_ame_acquire(desc); }

// CHECK-LABEL: @acquire_unsigned(
// RV64: [[DESC:%.*]] = zext i32 {{%.*}} to i64
// RV64-NEXT: {{.*}}call i64 @llvm.riscv.ztt.ame.acquire.i64(i64 [[DESC]])
// RV32: call i32 @llvm.riscv.ztt.ame.acquire.i32(i32
size_t acquire_unsigned(unsigned desc) { return __riscv_ztt_ame_acquire(desc); }

// CHECK-LABEL: @acquire_wide(
// RV32: [[DESC:%.*]] = trunc i64 {{%.*}} to i32
// RV32-NEXT: {{.*}}call i32 @llvm.riscv.ztt.ame.acquire.i32(i32 [[DESC]])
// RV64: call i64 @llvm.riscv.ztt.ame.acquire.i64(i64
size_t acquire_wide(unsigned long long desc) { return __riscv_ztt_ame_acquire(desc); }

// CHECK-LABEL: @acquire_constants(
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.ame.acquire.{{i32|i64}}({{i32|i64}} 0)
// CHECK-NEXT: {{.*}}call {{i32|i64}} @llvm.riscv.ztt.ame.acquire.{{i32|i64}}({{i32|i64}} 1)
// CHECK-NEXT: {{.*}}call {{i32|i64}} @llvm.riscv.ztt.ame.acquire.{{i32|i64}}({{i32|i64}} 64)
// CHECK-NEXT: {{.*}}call {{i32|i64}} @llvm.riscv.ztt.ame.acquire.{{i32|i64}}({{i32|i64}} -1)
// CHECK-NEXT: ret void
void acquire_constants(void) {
  __riscv_ztt_ame_acquire(0);
  __riscv_ztt_ame_acquire(0x1);
  __riscv_ztt_ame_acquire(64);
  __riscv_ztt_ame_acquire(-1);
}

// CHECK-LABEL: @release_twice(
// CHECK: call void @llvm.riscv.ztt.ame.release()
// CHECK-NEXT: {{.*}}call void @llvm.riscv.ztt.ame.release()
// CHECK-NEXT: ret void
void release_twice(void) {
  __riscv_ztt_ame_release();
  __riscv_ztt_ame_release();
}

#ifdef __cplusplus
}
#endif
