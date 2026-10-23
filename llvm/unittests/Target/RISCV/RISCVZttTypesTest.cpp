//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/SmallVector.h"
#include "llvm/CodeGen/ValueTypes.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/RISCVZttTypes.h"
#include "gtest/gtest.h"

using namespace llvm;

TEST(RISCVZttTypes, MCapacityCarriers) {
  LLVMContext Context;
  const DataLayout DL("e-m:e-p:64:64-i64:64-i128:128-n32:64-S128");
  // Check every nominal MVT width independently of the conversion.
  const struct {
    MVT VT;
    unsigned Bits;
  } Cases[] = {
      {MVT::riscv_zttm4, 4},       {MVT::riscv_zttm8, 8},       {MVT::riscv_zttm16, 16},
      {MVT::riscv_zttm32, 32},     {MVT::riscv_zttm64, 64},     {MVT::riscv_zttm128, 128},
      {MVT::riscv_zttm256, 256},   {MVT::riscv_zttm512, 512},   {MVT::riscv_zttm1024, 1024},
      {MVT::riscv_zttm2048, 2048}, {MVT::riscv_zttm4096, 4096},
  };
  for (const auto &C : Cases) {
    SCOPED_TRACE(C.Bits);
    EXPECT_EQ(C.VT.getSizeInBits(), TypeSize::getScalable(C.Bits));
    Type *Actual = EVT(C.VT).getTypeForEVT(Context);
    EXPECT_EQ(Actual, Type::getIntNTy(Context, C.Bits));
    EXPECT_EQ(DL.getTypeSizeInBits(Actual), TypeSize::getFixed(C.Bits));
    EXPECT_EQ(DL.getTypeStoreSize(Actual),
              TypeSize::getFixed((C.Bits + 7) / 8));
    EXPECT_NE(EVT::getEVT(Actual), EVT(C.VT));
  }
}

TEST(RISCVZttTypes, MTypeDoesNotRetainDatatypeOrShape) {
  LLVMContext Context;
  for (auto *Ty : {
           TargetExtType::get(Context, "riscv.ztt.m.i16",
                              {Type::getInt16Ty(Context)}, {16, 1, 4}),
           TargetExtType::get(Context, "riscv.ztt.m.i16",
                              {Type::getInt16Ty(Context)}, {16, 4, 1}),
           TargetExtType::get(Context, "riscv.ztt.m.f32",
                              {Type::getFloatTy(Context)}, {32, 1, 2}),
           TargetExtType::get(Context, "riscv.ztt.m.i64",
                              {Type::getInt64Ty(Context)}, {64, 1, 1}),
       })
    EXPECT_EQ(MVT::getVT(Ty), MVT::riscv_zttm64);
}

TEST(RISCVZttTypes, AccCarriersAndSquareCounts) {
  LLVMContext Context;
  const struct {
    MVT VT;
    unsigned Squares;
    unsigned NominalBits;
  } Cases[] = {
      {MVT::riscv_ztta1, 1, 16},
      {MVT::riscv_ztta2, 2, 32},
      {MVT::riscv_ztta4, 4, 64},
      {MVT::riscv_ztta8, 8, 128},
      {MVT::riscv_ztta16, 16, 256},
  };
  const struct {
    const char *Name;
    Type *ElementTy;
    unsigned ElementBits;
  } Elements[] = {
      {"riscv.ztt.acc.i8", Type::getInt8Ty(Context), 8},
      {"riscv.ztt.acc.i16", Type::getInt16Ty(Context), 16},
      {"riscv.ztt.acc.f32", Type::getFloatTy(Context), 32},
      {"riscv.ztt.acc.f64", Type::getDoubleTy(Context), 64},
  };
  for (const auto &C : Cases) {
    SCOPED_TRACE(C.Squares);
    EXPECT_EQ(C.VT.getSizeInBits(), TypeSize::getScalable(C.NominalBits));
    Type *Carrier = EVT(C.VT).getTypeForEVT(Context);
    EXPECT_EQ(Carrier, Type::getIntNTy(Context, C.NominalBits));
    EXPECT_NE(EVT::getEVT(Carrier), EVT(C.VT));
    // Register count depends on squares, not the original datatype.
    for (const auto &E : Elements) {
      SCOPED_TRACE(E.Name);
      auto *Ty = TargetExtType::get(Context, E.Name, {E.ElementTy},
                                    {E.ElementBits, C.Squares});
      EXPECT_EQ(MVT::getVT(Ty), C.VT);
    }
  }
}

TEST(RISCVZttTypes, SharedIRTypeInfo) {
  LLVMContext Context;
  const struct {
    const char *Name;
    Type *ElementType;
    SmallVector<unsigned, 3> Params;
    uint64_t Squares;
    bool IsACC;
    MVT VT;
  } Cases[] = {
      {"riscv.ztt.m.u4", Type::getIntNTy(Context, 4), {4, 1, 32}, 32, false,
       MVT::riscv_zttm128},
      {"riscv.ztt.m.i16_rne_sat", Type::getInt16Ty(Context), {16, 2, 1}, 2,
       false, MVT::riscv_zttm32},
      {"riscv.ztt.acc.bf16", Type::getBFloatTy(Context), {16, 8}, 8, true,
       MVT::riscv_ztta8},
      {"riscv.ztt.acc.i4", Type::getIntNTy(Context, 4), {4, 16}, 16, true,
       MVT::riscv_ztta16},
  };
  for (const auto &C : Cases) {
    SCOPED_TRACE(C.Name);
    auto *Ty = TargetExtType::get(Context, C.Name, {C.ElementType}, C.Params);
    auto Info = getRISCVZttTypeInfo(Ty);
    ASSERT_TRUE(Info);
    EXPECT_EQ(Info->ElementType, C.ElementType);
    EXPECT_EQ(Info->ElementBits, C.Params[0]);
    EXPECT_EQ(Info->NumSquares, C.Squares);
    EXPECT_EQ(Info->IsACC, C.IsACC);
    EXPECT_TRUE(Info->HasValidLayout);
    EXPECT_EQ(Info->getLogicalBits(), C.Params[0] * C.Squares);
    EXPECT_EQ(Ty->getLayoutType(), ArrayType::get(C.ElementType, C.Squares));
    EXPECT_TRUE(Ty->hasProperty(TargetExtType::HasZeroInit));
    EXPECT_TRUE(Ty->hasProperty(TargetExtType::CanBeLocal));
    EXPECT_EQ(MVT::getVT(Ty), C.VT);
  }
}

TEST(RISCVZttTypes, UnrecognizedIRTypeParameters) {
  LLVMContext Context;
  Type *I16 = Type::getInt16Ty(Context);
  for (auto *Ty : {
           TargetExtType::get(Context, "other.matrix", {I16}, {16, 1, 2}),
           TargetExtType::get(Context, "riscv.ztt.m.i16", {}, {16, 1, 2}),
           TargetExtType::get(Context, "riscv.ztt.m.i16", {I16}, {16, 2}),
           TargetExtType::get(Context, "riscv.ztt.acc.i16", {I16}, {16, 1, 2}),
       }) {
    EXPECT_FALSE(getRISCVZttTypeInfo(Ty));
    EXPECT_TRUE(Ty->getLayoutType()->isVoidTy());
    EXPECT_EQ(MVT::getVT(Ty, /*HandleUnknown=*/true), MVT::Other);
  }
}

TEST(RISCVZttTypes, LayoutValidityDoesNotControlMachineType) {
  LLVMContext Context;
  auto *Ty = TargetExtType::get(Context, "riscv.ztt.m.i16",
                               {Type::getInt16Ty(Context)}, {16, 2, 2});
  auto Info = getRISCVZttTypeInfo(Ty);
  ASSERT_TRUE(Info);
  EXPECT_FALSE(Info->HasValidLayout);
  EXPECT_TRUE(Ty->getLayoutType()->isVoidTy());
  EXPECT_FALSE(Ty->hasProperty(TargetExtType::HasZeroInit));
  // Machine type lookup uses capacity; IR shape legality is a separate query.
  EXPECT_EQ(MVT::getVT(Ty), MVT::riscv_zttm64);
}
