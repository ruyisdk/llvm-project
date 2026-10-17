// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -x c++ -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV64
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -x c++ -O2 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -O0 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -O0 -emit-llvm %s -o - | FileCheck %s --check-prefixes=CHECK,RV64

// CSR helpers use size_t, not a fixed-width or matrix type. They require the
// common Ztt configuration. Header aliases must call LLVM directly.
#include <riscv_ztt.h>

#ifdef __cplusplus
extern "C" {
#endif

// CHECK-LABEL: @read_ameown(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.ameown.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.ameown.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_ameown(void) {
  return __riscv_ztt_get_ameown();
}

// CHECK-LABEL: @read_amestype(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.amestype.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.amestype.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_amestype(void) {
  return __riscv_ztt_get_amestype();
}

// CHECK-LABEL: @read_amenlen(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.amenlen.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.amenlen.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_amenlen(void) {
  return __riscv_ztt_get_amenlen();
}

// CHECK-LABEL: @read_ameudsz(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.ameudsz.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.ameudsz.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_ameudsz(void) {
  return __riscv_ztt_get_ameudsz();
}

// CHECK-LABEL: @read_amefflags(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.amefflags.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.amefflags.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_amefflags(void) {
  return __riscv_ztt_get_amefflags();
}

// CHECK-LABEL: @read_amexsat(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.amexsat.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.amexsat.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_amexsat(void) {
  return __riscv_ztt_get_amexsat();
}

// CHECK-LABEL: @read_amestatus(
// RV32: [[VALUE:%.*]] = {{(tail )?}}call i32 @llvm.riscv.ztt.get.amestatus.i32()
// RV32-NEXT: ret i32 [[VALUE]]
// RV64: [[VALUE:%.*]] = {{(tail )?}}call i64 @llvm.riscv.ztt.get.amestatus.i64()
// RV64-NEXT: ret i64 [[VALUE]]
size_t read_amestatus(void) {
  return __riscv_ztt_get_amestatus();
}

// A discarded CSR read must not disappear at -O2, including capability reads.
// CHECK-LABEL: @discard_reads(
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.ameown.{{i32|i64}}()
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.amestype.{{i32|i64}}()
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.amenlen.{{i32|i64}}()
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.ameudsz.{{i32|i64}}()
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.amefflags.{{i32|i64}}()
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.amexsat.{{i32|i64}}()
// CHECK: call {{i32|i64}} @llvm.riscv.ztt.get.amestatus.{{i32|i64}}()
// CHECK-NEXT: ret void
void discard_reads(void) {
  __riscv_ztt_get_ameown();
  __riscv_ztt_get_amestype();
  __riscv_ztt_get_amenlen();
  __riscv_ztt_get_ameudsz();
  __riscv_ztt_get_amefflags();
  __riscv_ztt_get_amexsat();
  __riscv_ztt_get_amestatus();
}

#ifdef __cplusplus
}
#endif
