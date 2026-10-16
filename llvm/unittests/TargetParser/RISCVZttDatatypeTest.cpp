//===- RISCVZttDatatypeTest.cpp - RISC-V Ztt datatype tests -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/TargetParser/RISCVZttDatatype.h"
#include "gtest/gtest.h"

using namespace llvm::RISCVZtt;

TEST(RISCVZttDatatype, Integers) {
  // Literal descriptor prefixes keep the expectations independent of the
  // encoder's masks and shifts. Options 0..3 select RNU/RNE/RDN/ROD.
  const uint32_t Prefixes[] = {0x00000000, 0x08000000, 0x10000000, 0x18000000,
                               0x20000000, 0x28000000, 0x30000000, 0x38000000};
  for (unsigned Bits : {4U, 8U, 16U, 32U, 64U, 128U}) {
    for (unsigned I = 0; I != 8; ++I) {
      unsigned Options = (I % 4) | (I >= 4 ? 8U : 0U);
      for (bool IsSigned : {false, true}) {
        uint32_t Expected = Prefixes[I] | Bits | (IsSigned ? 0x40000000U : 0U);
        EXPECT_EQ(integerType(Bits, IsSigned, Options), Expected);
      }
    }
    EXPECT_EQ(integerType(Bits, false), Bits);
    EXPECT_EQ(integerType(Bits, true), 0x40000000U | Bits);
  }
}

TEST(RISCVZttDatatype, FloatingPoint) {
  const struct {
    unsigned Bits;
    unsigned ExponentBits;
    uint32_t DefaultDescriptor;
  } Cases[] = {{16, 5, 0x14300110},   // f16
               {16, 8, 0x20300110},   // bf16
               {32, 8, 0x20300120},   // f32
               {64, 11, 0x2c300140}}; // f64
  // RNE, RTZ, RDN, RUP, RMM and RNO.
  const uint32_t RoundingBits[] = {0x00000000, 0x00400000, 0x00800000,
                                   0x00c00000, 0x01000000, 0x01400000};
  for (const auto &C : Cases) {
    EXPECT_EQ(floatingType(C.Bits, C.ExponentBits), C.DefaultDescriptor);
    for (unsigned Mode = 0; Mode != 6; ++Mode) {
      uint32_t Expected = C.DefaultDescriptor | RoundingBits[Mode];
      EXPECT_EQ(floatingType(C.Bits, C.ExponentBits, Mode), Expected);
    }
  }
}
