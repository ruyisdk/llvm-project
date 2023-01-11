// RUN: %clang_cc1 -triple riscv64 -target-abi ilp32 -emit-llvm -o - %s | FileCheck %s

struct Foo {
  char a;
  int b : 1;
};

int BitfieldOffset = sizeof(struct Foo);
// CHECK: @BitfieldOffset = global i32 4

int PointerSize = sizeof(void *);
// CHECK: @PointerSize = global i32 4

int PointerAlign = __alignof(void *);
// CHECK: @PointerAlign = global i32 4

int LongSize = sizeof(long);
// CHECK: @LongSize = global i32 4

int LongAlign = __alignof(long);
// CHECK: @LongAlign = global i32 4
