//===-- RISCVInstrInfoXTHeadVPseudos.td - RISC-V 'V' Pseudos -----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------------===//
///
/// This file contains the required infrastructure to support code generation
/// for the standard 'V' (Vector) extension, version 1.0.
///
/// This file is included from RISCVInstrInfoXTHeadV.td

// Redefine `AllIntegerVectors` from RISCVInstrInfoVPseudos.td to remove fractionally-grouped register groups
// like MF2, MF4, MF8, which are not supported by the 'V' extension 0.7.1.
defset list<VTypeInfo> AllXVectors = {
  defset list<VTypeInfo> AllIntegerXVectors = {
    defset list<VTypeInfo> NoGroupIntegerXVectors = {
      def XVI8M1:  VTypeInfo<vint8m1_t,  vbool8_t,   8, VR, V_M1>;
      def XVI16M1: VTypeInfo<vint16m1_t, vbool16_t, 16, VR, V_M1>;
      def XVI32M1: VTypeInfo<vint32m1_t, vbool32_t, 32, VR, V_M1>;
      def XVI64M1: VTypeInfo<vint64m1_t, vbool64_t, 64, VR, V_M1>;
    }
    defset list<GroupVTypeInfo> GroupIntegerXVectors = {
      def XVI8M2: GroupVTypeInfo<vint8m2_t, vint8m1_t, vbool4_t, 8, VRM2, V_M2>;
      def XVI8M4: GroupVTypeInfo<vint8m4_t, vint8m1_t, vbool2_t, 8, VRM4, V_M4>;
      def XVI8M8: GroupVTypeInfo<vint8m8_t, vint8m1_t, vbool1_t, 8, VRM8, V_M8>;

      def XVI16M2: GroupVTypeInfo<vint16m2_t, vint16m1_t, vbool8_t, 16, VRM2, V_M2>;
      def XVI16M4: GroupVTypeInfo<vint16m4_t, vint16m1_t, vbool4_t, 16, VRM4, V_M4>;
      def XVI16M8: GroupVTypeInfo<vint16m8_t, vint16m1_t, vbool2_t, 16, VRM8, V_M8>;

      def XVI32M2: GroupVTypeInfo<vint32m2_t, vint32m1_t, vbool16_t,32, VRM2, V_M2>;
      def XVI32M4: GroupVTypeInfo<vint32m4_t, vint32m1_t, vbool8_t, 32, VRM4, V_M4>;
      def XVI32M8: GroupVTypeInfo<vint32m8_t, vint32m1_t, vbool4_t, 32, VRM8, V_M8>;

      def XVI64M2: GroupVTypeInfo<vint64m2_t, vint64m1_t, vbool32_t,64, VRM2, V_M2>;
      def XVI64M4: GroupVTypeInfo<vint64m4_t, vint64m1_t, vbool16_t,64, VRM4, V_M4>;
      def XVI64M8: GroupVTypeInfo<vint64m8_t, vint64m1_t, vbool8_t, 64, VRM8, V_M8>;
    }
  }

  defset list<VTypeInfo> AllFloatXVectors = {
    defset list<VTypeInfo> NoGroupFloatXVectors = {
      def XVF16M1:  VTypeInfo<vfloat16m1_t, vbool16_t, 16, VR, V_M1, f16, FPR16>;
      def XVF32M1:  VTypeInfo<vfloat32m1_t, vbool32_t, 32, VR, V_M1, f32, FPR32>;
      def XVF64M1:  VTypeInfo<vfloat64m1_t, vbool64_t, 64, VR, V_M1, f64, FPR64>;
    }

    defset list<GroupVTypeInfo> GroupFloatXVectors = {
      def XVF16M2: GroupVTypeInfo<vfloat16m2_t, vfloat16m1_t, vbool8_t, 16,
                                  VRM2, V_M2, f16, FPR16>;
      def XVF16M4: GroupVTypeInfo<vfloat16m4_t, vfloat16m1_t, vbool4_t, 16,
                                  VRM4, V_M4, f16, FPR16>;
      def XVF16M8: GroupVTypeInfo<vfloat16m8_t, vfloat16m1_t, vbool2_t, 16,
                                  VRM8, V_M8, f16, FPR16>;

      def XVF32M2: GroupVTypeInfo<vfloat32m2_t, vfloat32m1_t, vbool16_t, 32,
                                  VRM2, V_M2, f32, FPR32>;
      def XVF32M4: GroupVTypeInfo<vfloat32m4_t, vfloat32m1_t, vbool8_t,  32,
                                  VRM4, V_M4, f32, FPR32>;
      def XVF32M8: GroupVTypeInfo<vfloat32m8_t, vfloat32m1_t, vbool4_t,  32,
                                  VRM8, V_M8, f32, FPR32>;

      def XVF64M2: GroupVTypeInfo<vfloat64m2_t, vfloat64m1_t, vbool32_t, 64,
                                  VRM2, V_M2, f64, FPR64>;
      def XVF64M4: GroupVTypeInfo<vfloat64m4_t, vfloat64m1_t, vbool16_t, 64,
                                  VRM4, V_M4, f64, FPR64>;
      def XVF64M8: GroupVTypeInfo<vfloat64m8_t, vfloat64m1_t, vbool8_t,  64,
                                  VRM8, V_M8, f64, FPR64>;
    }
  }
}

//===----------------------------------------------------------------------===//
// Pseudos.
//===----------------------------------------------------------------------===//

defm PseudoXVADD   : VPseudoVALU_VV_VX_VI;

//===----------------------------------------------------------------------===//
// Patterns. Enabling code generation from intrinsics to pseudos, then to asms.
//===----------------------------------------------------------------------===//

defm : VPatBinaryV_VV_VX_VI<"int_riscv_xvadd", "PseudoXVADD", AllIntegerXVectors>;
