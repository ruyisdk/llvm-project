// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadv \
// RUN: -O0 -emit-llvm %s -o - | FileCheck %s

#include <riscv_vector.h>

// This test case tests the typedef generated under riscv_vector_xtheadv.h

// CHECK-LABEL: define dso_local void @_Z3foov
// CHECK-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[B64:%.*]] = alloca <vscale x 1 x i1>, align 1
// CHECK-NEXT:    [[B32:%.*]] = alloca <vscale x 2 x i1>, align 1
// CHECK-NEXT:    [[B16:%.*]] = alloca <vscale x 4 x i1>, align 1
// CHECK-NEXT:    [[B8:%.*]] = alloca <vscale x 8 x i1>, align 1
// CHECK-NEXT:    [[I8M1:%.*]] = alloca <vscale x 8 x i8>, align 1
// CHECK-NEXT:    [[I8M2:%.*]] = alloca <vscale x 16 x i8>, align 1
// CHECK-NEXT:    [[I8M4:%.*]] = alloca <vscale x 32 x i8>, align 1
// CHECK-NEXT:    [[I8M8:%.*]] = alloca <vscale x 64 x i8>, align 1
// CHECK-NEXT:    [[U8M1:%.*]] = alloca <vscale x 8 x i8>, align 1
// CHECK-NEXT:    [[U8M2:%.*]] = alloca <vscale x 16 x i8>, align 1
// CHECK-NEXT:    [[U8M4:%.*]] = alloca <vscale x 32 x i8>, align 1
// CHECK-NEXT:    [[U8M8:%.*]] = alloca <vscale x 64 x i8>, align 1
// CHECK-NEXT:    [[I16M1:%.*]] = alloca <vscale x 4 x i16>, align 2
// CHECK-NEXT:    [[I16M2:%.*]] = alloca <vscale x 8 x i16>, align 2
// CHECK-NEXT:    [[I16M4:%.*]] = alloca <vscale x 16 x i16>, align 2
// CHECK-NEXT:    [[I16M8:%.*]] = alloca <vscale x 32 x i16>, align 2
// CHECK-NEXT:    [[U16M1:%.*]] = alloca <vscale x 4 x i16>, align 2
// CHECK-NEXT:    [[U16M2:%.*]] = alloca <vscale x 8 x i16>, align 2
// CHECK-NEXT:    [[U16M4:%.*]] = alloca <vscale x 16 x i16>, align 2
// CHECK-NEXT:    [[U16M8:%.*]] = alloca <vscale x 32 x i16>, align 2
// CHECK-NEXT:    [[I32M1:%.*]] = alloca <vscale x 2 x i32>, align 4
// CHECK-NEXT:    [[I32M2:%.*]] = alloca <vscale x 4 x i32>, align 4
// CHECK-NEXT:    [[I32M4:%.*]] = alloca <vscale x 8 x i32>, align 4
// CHECK-NEXT:    [[I32M8:%.*]] = alloca <vscale x 16 x i32>, align 4
// CHECK-NEXT:    [[U32M1:%.*]] = alloca <vscale x 2 x i32>, align 4
// CHECK-NEXT:    [[U32M2:%.*]] = alloca <vscale x 4 x i32>, align 4
// CHECK-NEXT:    [[U32M4:%.*]] = alloca <vscale x 8 x i32>, align 4
// CHECK-NEXT:    [[U32M8:%.*]] = alloca <vscale x 16 x i32>, align 4
// CHECK-NEXT:    [[I64M1:%.*]] = alloca <vscale x 1 x i64>, align 8
// CHECK-NEXT:    [[I64M2:%.*]] = alloca <vscale x 2 x i64>, align 8
// CHECK-NEXT:    [[I64M4:%.*]] = alloca <vscale x 4 x i64>, align 8
// CHECK-NEXT:    [[I64M8:%.*]] = alloca <vscale x 8 x i64>, align 8
// CHECK-NEXT:    [[U64M1:%.*]] = alloca <vscale x 1 x i64>, align 8
// CHECK-NEXT:    [[U64M2:%.*]] = alloca <vscale x 2 x i64>, align 8
// CHECK-NEXT:    [[U64M4:%.*]] = alloca <vscale x 4 x i64>, align 8
// CHECK-NEXT:    [[U64M8:%.*]] = alloca <vscale x 8 x i64>, align 8
// CHECK-NEXT:    [[F16M1:%.*]] = alloca <vscale x 4 x half>, align 2
// CHECK-NEXT:    [[F16M2:%.*]] = alloca <vscale x 8 x half>, align 2
// CHECK-NEXT:    [[F16M4:%.*]] = alloca <vscale x 16 x half>, align 2
// CHECK-NEXT:    [[F16M8:%.*]] = alloca <vscale x 32 x half>, align 2
// CHECK-NEXT:    [[F32M1:%.*]] = alloca <vscale x 2 x float>, align 4
// CHECK-NEXT:    [[F32M2:%.*]] = alloca <vscale x 4 x float>, align 4
// CHECK-NEXT:    [[F32M4:%.*]] = alloca <vscale x 8 x float>, align 4
// CHECK-NEXT:    [[F32M8:%.*]] = alloca <vscale x 16 x float>, align 4
// CHECK-NEXT:    [[F64M1:%.*]] = alloca <vscale x 1 x double>, align 8
// CHECK-NEXT:    [[F64M2:%.*]] = alloca <vscale x 2 x double>, align 8
// CHECK-NEXT:    [[F64M4:%.*]] = alloca <vscale x 4 x double>, align 8
// CHECK-NEXT:    [[F64M8:%.*]] = alloca <vscale x 8 x double>, align 8
// CHECK-NEXT:    [[I8M1X2:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M1X3:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M1X4:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M1X5:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M1X6:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M1X7:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M1X8:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[I8M2X2:%.*]] = alloca { <vscale x 16 x i8>, <vscale x 16 x i8> }, align 1
// CHECK-NEXT:    [[I8M2X3:%.*]] = alloca { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> }, align 1
// CHECK-NEXT:    [[I8M2X4:%.*]] = alloca { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> }, align 1
// CHECK-NEXT:    [[I8M4X2:%.*]] = alloca { <vscale x 32 x i8>, <vscale x 32 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X2:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X3:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X4:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X5:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X6:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X7:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M1X8:%.*]] = alloca { <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8>, <vscale x 8 x i8> }, align 1
// CHECK-NEXT:    [[U8M2X2:%.*]] = alloca { <vscale x 16 x i8>, <vscale x 16 x i8> }, align 1
// CHECK-NEXT:    [[U8M2X3:%.*]] = alloca { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> }, align 1
// CHECK-NEXT:    [[U8M2X4:%.*]] = alloca { <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8> }, align 1
// CHECK-NEXT:    [[U8M4X2:%.*]] = alloca { <vscale x 32 x i8>, <vscale x 32 x i8> }, align 1
// CHECK-NEXT:    [[I16M1X2:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M1X3:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M1X4:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M1X5:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M1X6:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M1X7:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M1X8:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[I16M2X2:%.*]] = alloca { <vscale x 8 x i16>, <vscale x 8 x i16> }, align 2
// CHECK-NEXT:    [[I16M2X3:%.*]] = alloca { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> }, align 2
// CHECK-NEXT:    [[I16M2X4:%.*]] = alloca { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> }, align 2
// CHECK-NEXT:    [[I16M4X2:%.*]] = alloca { <vscale x 16 x i16>, <vscale x 16 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X2:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X3:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X4:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X5:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X6:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X7:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M1X8:%.*]] = alloca { <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16>, <vscale x 4 x i16> }, align 2
// CHECK-NEXT:    [[U16M2X2:%.*]] = alloca { <vscale x 8 x i16>, <vscale x 8 x i16> }, align 2
// CHECK-NEXT:    [[U16M2X3:%.*]] = alloca { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> }, align 2
// CHECK-NEXT:    [[U16M2X4:%.*]] = alloca { <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16> }, align 2
// CHECK-NEXT:    [[U16M4X2:%.*]] = alloca { <vscale x 16 x i16>, <vscale x 16 x i16> }, align 2
// CHECK-NEXT:    [[I32M1X2:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M1X3:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M1X4:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M1X5:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M1X6:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M1X7:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M1X8:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[I32M2X2:%.*]] = alloca { <vscale x 4 x i32>, <vscale x 4 x i32> }, align 4
// CHECK-NEXT:    [[I32M2X3:%.*]] = alloca { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> }, align 4
// CHECK-NEXT:    [[I32M2X4:%.*]] = alloca { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> }, align 4
// CHECK-NEXT:    [[I32M4X2:%.*]] = alloca { <vscale x 8 x i32>, <vscale x 8 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X2:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X3:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X4:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X5:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X6:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X7:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M1X8:%.*]] = alloca { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> }, align 4
// CHECK-NEXT:    [[U32M2X2:%.*]] = alloca { <vscale x 4 x i32>, <vscale x 4 x i32> }, align 4
// CHECK-NEXT:    [[U32M2X3:%.*]] = alloca { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> }, align 4
// CHECK-NEXT:    [[U32M2X4:%.*]] = alloca { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> }, align 4
// CHECK-NEXT:    [[U32M4X2:%.*]] = alloca { <vscale x 8 x i32>, <vscale x 8 x i32> }, align 4
// CHECK-NEXT:    [[I64M1X2:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M1X3:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M1X4:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M1X5:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M1X6:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M1X7:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M1X8:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[I64M2X2:%.*]] = alloca { <vscale x 2 x i64>, <vscale x 2 x i64> }, align 8
// CHECK-NEXT:    [[I64M2X3:%.*]] = alloca { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> }, align 8
// CHECK-NEXT:    [[I64M2X4:%.*]] = alloca { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> }, align 8
// CHECK-NEXT:    [[I64M4X2:%.*]] = alloca { <vscale x 4 x i64>, <vscale x 4 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X2:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X3:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X4:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X5:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X6:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X7:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M1X8:%.*]] = alloca { <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64>, <vscale x 1 x i64> }, align 8
// CHECK-NEXT:    [[U64M2X2:%.*]] = alloca { <vscale x 2 x i64>, <vscale x 2 x i64> }, align 8
// CHECK-NEXT:    [[U64M2X3:%.*]] = alloca { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> }, align 8
// CHECK-NEXT:    [[U64M2X4:%.*]] = alloca { <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64>, <vscale x 2 x i64> }, align 8
// CHECK-NEXT:    [[U64M4X2:%.*]] = alloca { <vscale x 4 x i64>, <vscale x 4 x i64> }, align 8
// CHECK-NEXT:    [[F16M1X2:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M1X3:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M1X4:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M1X5:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M1X6:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M1X7:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M1X8:%.*]] = alloca { <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half> }, align 2
// CHECK-NEXT:    [[F16M2X2:%.*]] = alloca { <vscale x 8 x half>, <vscale x 8 x half> }, align 2
// CHECK-NEXT:    [[F16M2X3:%.*]] = alloca { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> }, align 2
// CHECK-NEXT:    [[F16M2X4:%.*]] = alloca { <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half> }, align 2
// CHECK-NEXT:    [[F16M4X2:%.*]] = alloca { <vscale x 16 x half>, <vscale x 16 x half> }, align 2
// CHECK-NEXT:    [[F32M1X2:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M1X3:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M1X4:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M1X5:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M1X6:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M1X7:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M1X8:%.*]] = alloca { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> }, align 4
// CHECK-NEXT:    [[F32M2X2:%.*]] = alloca { <vscale x 4 x float>, <vscale x 4 x float> }, align 4
// CHECK-NEXT:    [[F32M2X3:%.*]] = alloca { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> }, align 4
// CHECK-NEXT:    [[F32M2X4:%.*]] = alloca { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> }, align 4
// CHECK-NEXT:    [[F32M4X2:%.*]] = alloca { <vscale x 8 x float>, <vscale x 8 x float> }, align 4
// CHECK-NEXT:    [[F64M1X2:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M1X3:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M1X4:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M1X5:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M1X6:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M1X7:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M1X8:%.*]] = alloca { <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double> }, align 8
// CHECK-NEXT:    [[F64M2X2:%.*]] = alloca { <vscale x 2 x double>, <vscale x 2 x double> }, align 8
// CHECK-NEXT:    [[F64M2X3:%.*]] = alloca { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> }, align 8
// CHECK-NEXT:    [[F64M2X4:%.*]] = alloca { <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double> }, align 8
// CHECK-NEXT:    [[F64M4X2:%.*]] = alloca { <vscale x 4 x double>, <vscale x 4 x double> }, align 8
// CHECK-NEXT:    ret void
//
void foo () {
  // Mask Types
  vbool64_t b64;
  vbool32_t b32;
  vbool16_t b16;
  vbool8_t b8;

  // Data Types
  vint8m1_t i8m1;
  vint8m2_t i8m2;
  vint8m4_t i8m4;
  vint8m8_t i8m8;

  vuint8m1_t u8m1;
  vuint8m2_t u8m2;
  vuint8m4_t u8m4;
  vuint8m8_t u8m8;

  vint16m1_t i16m1;
  vint16m2_t i16m2;
  vint16m4_t i16m4;
  vint16m8_t i16m8;

  vuint16m1_t u16m1;
  vuint16m2_t u16m2;
  vuint16m4_t u16m4;
  vuint16m8_t u16m8;

  vint32m1_t i32m1;
  vint32m2_t i32m2;
  vint32m4_t i32m4;
  vint32m8_t i32m8;

  vuint32m1_t u32m1;
  vuint32m2_t u32m2;
  vuint32m4_t u32m4;
  vuint32m8_t u32m8;

  vint64m1_t i64m1;
  vint64m2_t i64m2;
  vint64m4_t i64m4;
  vint64m8_t i64m8;

  vuint64m1_t u64m1;
  vuint64m2_t u64m2;
  vuint64m4_t u64m4;
  vuint64m8_t u64m8;

  vfloat16m1_t f16m1;
  vfloat16m2_t f16m2;
  vfloat16m4_t f16m4;
  vfloat16m8_t f16m8;

  vfloat32m1_t f32m1;
  vfloat32m2_t f32m2;
  vfloat32m4_t f32m4;
  vfloat32m8_t f32m8;

  vfloat64m1_t f64m1;
  vfloat64m2_t f64m2;
  vfloat64m4_t f64m4;
  vfloat64m8_t f64m8;

  // Types for Segment Load/Store

  // i8
  vint8m1x2_t i8m1x2;
  vint8m1x3_t i8m1x3;
  vint8m1x4_t i8m1x4;
  vint8m1x5_t i8m1x5;
  vint8m1x6_t i8m1x6;
  vint8m1x7_t i8m1x7;
  vint8m1x8_t i8m1x8;

  vint8m2x2_t i8m2x2;
  vint8m2x3_t i8m2x3;
  vint8m2x4_t i8m2x4;

  vint8m4x2_t i8m4x2;

  // u8
  vuint8m1x2_t u8m1x2;
  vuint8m1x3_t u8m1x3;
  vuint8m1x4_t u8m1x4;
  vuint8m1x5_t u8m1x5;
  vuint8m1x6_t u8m1x6;
  vuint8m1x7_t u8m1x7;
  vuint8m1x8_t u8m1x8;

  vuint8m2x2_t u8m2x2;
  vuint8m2x3_t u8m2x3;
  vuint8m2x4_t u8m2x4;

  vuint8m4x2_t u8m4x2;

  // i16
  vint16m1x2_t i16m1x2;
  vint16m1x3_t i16m1x3;
  vint16m1x4_t i16m1x4;
  vint16m1x5_t i16m1x5;
  vint16m1x6_t i16m1x6;
  vint16m1x7_t i16m1x7;
  vint16m1x8_t i16m1x8;

  vint16m2x2_t i16m2x2;
  vint16m2x3_t i16m2x3;
  vint16m2x4_t i16m2x4;

  vint16m4x2_t i16m4x2;

  // u16
  vuint16m1x2_t u16m1x2;
  vuint16m1x3_t u16m1x3;
  vuint16m1x4_t u16m1x4;
  vuint16m1x5_t u16m1x5;
  vuint16m1x6_t u16m1x6;
  vuint16m1x7_t u16m1x7;
  vuint16m1x8_t u16m1x8;

  vuint16m2x2_t u16m2x2;
  vuint16m2x3_t u16m2x3;
  vuint16m2x4_t u16m2x4;

  vuint16m4x2_t u16m4x2;

  // i32
  vint32m1x2_t i32m1x2;
  vint32m1x3_t i32m1x3;
  vint32m1x4_t i32m1x4;
  vint32m1x5_t i32m1x5;
  vint32m1x6_t i32m1x6;
  vint32m1x7_t i32m1x7;
  vint32m1x8_t i32m1x8;

  vint32m2x2_t i32m2x2;
  vint32m2x3_t i32m2x3;
  vint32m2x4_t i32m2x4;

  vint32m4x2_t i32m4x2;

  // u32
  vuint32m1x2_t u32m1x2;
  vuint32m1x3_t u32m1x3;
  vuint32m1x4_t u32m1x4;
  vuint32m1x5_t u32m1x5;
  vuint32m1x6_t u32m1x6;
  vuint32m1x7_t u32m1x7;
  vuint32m1x8_t u32m1x8;

  vuint32m2x2_t u32m2x2;
  vuint32m2x3_t u32m2x3;
  vuint32m2x4_t u32m2x4;

  vuint32m4x2_t u32m4x2;

  // i64
  vint64m1x2_t i64m1x2;
  vint64m1x3_t i64m1x3;
  vint64m1x4_t i64m1x4;
  vint64m1x5_t i64m1x5;
  vint64m1x6_t i64m1x6;
  vint64m1x7_t i64m1x7;
  vint64m1x8_t i64m1x8;

  vint64m2x2_t i64m2x2;
  vint64m2x3_t i64m2x3;
  vint64m2x4_t i64m2x4;

  vint64m4x2_t i64m4x2;

  // u64
  vuint64m1x2_t u64m1x2;
  vuint64m1x3_t u64m1x3;
  vuint64m1x4_t u64m1x4;
  vuint64m1x5_t u64m1x5;
  vuint64m1x6_t u64m1x6;
  vuint64m1x7_t u64m1x7;
  vuint64m1x8_t u64m1x8;

  vuint64m2x2_t u64m2x2;
  vuint64m2x3_t u64m2x3;
  vuint64m2x4_t u64m2x4;

  vuint64m4x2_t u64m4x2;

  // f16
  vfloat16m1x2_t f16m1x2;
  vfloat16m1x3_t f16m1x3;
  vfloat16m1x4_t f16m1x4;
  vfloat16m1x5_t f16m1x5;
  vfloat16m1x6_t f16m1x6;
  vfloat16m1x7_t f16m1x7;
  vfloat16m1x8_t f16m1x8;

  vfloat16m2x2_t f16m2x2;
  vfloat16m2x3_t f16m2x3;
  vfloat16m2x4_t f16m2x4;

  vfloat16m4x2_t f16m4x2;

  // f32
  vfloat32m1x2_t f32m1x2;
  vfloat32m1x3_t f32m1x3;
  vfloat32m1x4_t f32m1x4;
  vfloat32m1x5_t f32m1x5;
  vfloat32m1x6_t f32m1x6;
  vfloat32m1x7_t f32m1x7;
  vfloat32m1x8_t f32m1x8;

  vfloat32m2x2_t f32m2x2;
  vfloat32m2x3_t f32m2x3;
  vfloat32m2x4_t f32m2x4;

  vfloat32m4x2_t f32m4x2;

  //f64
  vfloat64m1x2_t f64m1x2;
  vfloat64m1x3_t f64m1x3;
  vfloat64m1x4_t f64m1x4;
  vfloat64m1x5_t f64m1x5;
  vfloat64m1x6_t f64m1x6;
  vfloat64m1x7_t f64m1x7;
  vfloat64m1x8_t f64m1x8;

  vfloat64m2x2_t f64m2x2;
  vfloat64m2x3_t f64m2x3;
  vfloat64m2x4_t f64m2x4;

  vfloat64m4x2_t f64m4x2;
}
