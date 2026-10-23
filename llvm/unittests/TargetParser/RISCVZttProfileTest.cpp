//===-- RISCVZttProfileTest.cpp - Ztt profile tests ---------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/TargetParser/RISCVZttProfile.h"
#include "llvm/Testing/Support/Error.h"
#include "gtest/gtest.h"

using namespace llvm;

TEST(RISCVZttProfile, Configurations) {
  for (unsigned N : {0U, 2U, 128U, 4294967295U})
    for (unsigned U : {8U, 16U, 32U, 64U, 128U})
      for (unsigned M : {16U, 32U})
        for (unsigned A : {1U, 2U, 4U, 8U, 16U}) {
          std::string Name =
              (Twine("clang-") +
               (N ? (Twine("n") + Twine(N)).str() : "runtime") + "-u" +
               Twine(U) + "-m" + Twine(M) + "-a" + Twine(A))
                  .str();
          SCOPED_TRACE(Name);
          auto P = RISCV::ZttProfile::parse(Name);
          ASSERT_THAT_EXPECTED(P, Succeeded());
          EXPECT_EQ(P->N, N);
          EXPECT_EQ(P->UdsBits, U);
          EXPECT_EQ(P->MRegs, M);
          EXPECT_EQ(P->ARegs, A);
        }
}

TEST(RISCVZttProfile, Invalid) {
  for (StringRef Name : {"",
                         "gcc-runtime-u32-m16-a4",
                         "clang-p0-n128-u8-m16-a4",
                         "clang-n0-u32-m16-a4",
                         "clang-n4294967296-u32-m16-a4",
                         "clang-n+2-u32-m16-a4",
                         "clang-n02-u32-m16-a4",
                         "clang-n-u32-m16-a4",
                         "clang-runtime-u0-m16-a4",
                         "clang-runtime-u4-m16-a4",
                         "clang-runtime-u24-m16-a4",
                         "clang-runtime-u256-m16-a4",
                         "clang-runtime-u32-m8-a4",
                         "clang-runtime-u32-m64-a4",
                         "clang-runtime-u32-m16-a0",
                         "clang-runtime-u32-m16-a3",
                         "clang-runtime-u32-m16-a32",
                         "clang-runtime-u32-m16",
                         "clang-runtime-u32-m16-a4-extra",
                         "clang-runtime-u32-m16-a4-",
                         "clang-runtime-u32-m16-a4 ",
                         "clang-runtime-m16-u32-a4"}) {
    SCOPED_TRACE(Name);
    auto P = RISCV::ZttProfile::parse(Name);
    EXPECT_THAT_EXPECTED(P, Failed());
  }
}
