//===- RISCVZttDatatype.h - RISC-V Ztt datatype encoding --------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TARGETPARSER_RISCVZTTDATATYPE_H
#define LLVM_TARGETPARSER_RISCVZTTDATATYPE_H

#include <cstdint>

namespace llvm::RISCVZtt {

// Md, Ad and AMESTYPE use the same 32-bit datatype encoding.
inline constexpr uint32_t Signed = 1U << 30;
inline constexpr uint32_t Saturation = 1U << 29;
inline constexpr unsigned IntegerRoundingShift = 27;
inline constexpr unsigned ExponentShift = 26;
inline constexpr unsigned FloatRoundingShift = 22;
inline constexpr uint32_t Infinity = 1U << 21;
inline constexpr uint32_t Denormal = 1U << 20;
inline constexpr uint32_t FloatingPoint = 1U << 8;

// RISC-V Ztt DatatypeOptions: low 3 bits select rounding;
// bit 3 enables integer saturation.
inline constexpr unsigned RoundingMask = 0b111;
inline constexpr unsigned SaturationOption = 0b1000;

// Encode an integer; default options select RNU and natural overflow.
inline constexpr uint32_t integerType(unsigned Bits, bool IsSigned,
                                      unsigned Options = 0) {
  return (IsSigned ? Signed : 0) | Bits |
         ((Options & RoundingMask) << IntegerRoundingShift) |
         ((Options & SaturationOption) ? Saturation : 0);
}

// Encode IEEE/bfloat with rounding; infinity and denormals are enabled.
inline constexpr uint32_t floatingType(unsigned Bits, unsigned ExponentBits,
                                       unsigned Options = 0) {
  return (ExponentBits << ExponentShift) | Infinity | Denormal | FloatingPoint |
         Bits | ((Options & RoundingMask) << FloatRoundingShift);
}

} // namespace llvm::RISCVZtt

#endif
