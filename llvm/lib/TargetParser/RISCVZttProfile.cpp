//===-- RISCVZttProfile.cpp - Ztt configuration -------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/TargetParser/RISCVZttProfile.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/MathExtras.h"

using namespace llvm;

Expected<RISCV::ZttProfile> RISCV::ZttProfile::parse(StringRef Name) {
  auto Invalid = [&]() {
    return createStringError(inconvertibleErrorCode(),
                             "invalid Ztt profile '" + Name +
                                 "'; expected clang-n<N>-u<UDS>-m<M>-a<A> or "
                                 "clang-runtime-u<UDS>-m<M>-a<A> (positive "
                                 "32-bit N, UDS=8/16/32/64/128, M=16/32, "
                                 "A=1/2/4/8/16)");
  };
  SmallVector<StringRef, 5> Parts;
  Name.split(Parts, '-');
  if (Parts.size() != 5 || Parts[0] != "clang")
    return Invalid();

  // Require canonical decimal spelling. Only runtime represents N=0.
  auto ParseNumber = [](StringRef Text, StringRef Prefix, unsigned &Value) {
    return Text.consume_front(Prefix) && !Text.empty() && Text[0] != '0' &&
           Text.find_first_not_of("0123456789") == StringRef::npos &&
           !Text.getAsInteger(10, Value);
  };
  ZttProfile Profile;
  if ((Parts[1] != "runtime" && !ParseNumber(Parts[1], "n", Profile.N)) ||
      !ParseNumber(Parts[2], "u", Profile.UdsBits) ||
      !ParseNumber(Parts[3], "m", Profile.MRegs) ||
      !ParseNumber(Parts[4], "a", Profile.ARegs))
    return Invalid();
  if (!isPowerOf2_32(Profile.UdsBits) || Profile.UdsBits < 8 ||
      Profile.UdsBits > 128 || (Profile.MRegs != 16 && Profile.MRegs != 32) ||
      !isPowerOf2_32(Profile.ARegs) || Profile.ARegs > 16)
    return Invalid();
  return Profile;
}
