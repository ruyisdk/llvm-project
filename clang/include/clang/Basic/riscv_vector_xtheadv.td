//==--- riscv_vector_xtheadv.td - RISC-V V-ext Builtin function list ------===//
//
//  Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
//  See https://llvm.org/LICENSE.txt for license information.
//  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the builtins for RISC-V V-extension. See:
//
//     https://github.com/riscv-non-isa/rvv-intrinsic-doc/tree/v0.7.1
//
//===----------------------------------------------------------------------===//

include "riscv_vector_common.td"

class RVVOutBuiltin<string suffix, string prototype, string type_range>
    : RVVBuiltin<suffix, prototype, type_range> {
  let IntrinsicTypes = [-1];
}

multiclass RVVBuiltinSet<string intrinsic_name, string type_range,
                         list<list<string>> suffixes_prototypes,
                         list<int> intrinsic_types> {
  let IRName = intrinsic_name, MaskedIRName = intrinsic_name # "_mask",
      IntrinsicTypes = intrinsic_types in {
    foreach s_p = suffixes_prototypes in {
      let Name = NAME # "_" # s_p[0] in {
        defvar suffix = s_p[1];
        defvar prototype = s_p[2];
        def : RVVBuiltin<suffix, prototype, type_range>;
      }
    }
  }
}

// IntrinsicTypes is output, op1 [-1, 1]
multiclass RVVOutOp1BuiltinSet<string intrinsic_name, string type_range,
                               list<list<string>> suffixes_prototypes>
    : RVVBuiltinSet<intrinsic_name, type_range, suffixes_prototypes, [-1, 1]>;

multiclass RVVSignedBinBuiltinSet
    : RVVOutOp1BuiltinSet<NAME, "csil",
                          [["vv", "v", "vvv"],
                           ["vx", "v", "vve"]]>;

multiclass RVVUnsignedBinBuiltinSet
    : RVVOutOp1BuiltinSet<NAME, "csil",
                          [["vv", "Uv", "UvUvUv"],
                           ["vx", "Uv", "UvUvUe"]]>;

multiclass RVVIntBinBuiltinSet
    : RVVSignedBinBuiltinSet,
      RVVUnsignedBinBuiltinSet;


//===----------------------------------------------------------------------===//
// 6. Configuration-Setting and Utility
//===----------------------------------------------------------------------===//

// Define vread_csr&vwrite_csr described in RVV intrinsics doc.
let HeaderCode =
[{
enum RVV_CSR {
  RVV_VSTART = 0,
  RVV_VXSAT,
  RVV_VXRM,
};

static __inline__ __attribute__((__always_inline__, __nodebug__))
unsigned long __riscv_vread_csr(enum RVV_CSR __csr) {
  unsigned long __rv = 0;
  switch (__csr) {
    case RVV_VSTART:
      __asm__ __volatile__ ("csrr\t%0, vstart" : "=r"(__rv) : : "memory");
      break;
    case RVV_VXSAT:
      __asm__ __volatile__ ("csrr\t%0, vxsat" : "=r"(__rv) : : "memory");
      break;
    case RVV_VXRM:
      __asm__ __volatile__ ("csrr\t%0, vxrm" : "=r"(__rv) : : "memory");
      break;
  }
  return __rv;
}

static __inline__ __attribute__((__always_inline__, __nodebug__))
void __riscv_vwrite_csr(enum RVV_CSR __csr, unsigned long __value) {
  switch (__csr) {
    case RVV_VSTART:
      __asm__ __volatile__ ("csrw\tvstart, %z0" : : "rJ"(__value) : "memory");
      break;
    case RVV_VXSAT:
      __asm__ __volatile__ ("csrw\tvxsat, %z0" : : "rJ"(__value) : "memory");
      break;
    case RVV_VXRM:
      __asm__ __volatile__ ("csrw\tvxrm, %z0" : : "rJ"(__value) : "memory");
      break;
  }
}
}] in
def th_vread_th_vwrite_csr: RVVHeader;

// vsetvl/vsetvlmax are a macro because they require constant integers in SEW
// and LMUL.
let HeaderCode =
[{

/* These two builtins comes from the 1.0 implementation, */
/* for compatibility, we forward these calls to the corresponding 0.7 builtins. */
#define __builtin_rvv_vsetvli(avl, sew, lmul) __builtin_rvv_th_vsetvl((size_t)(avl), sew, lmul)
#define __builtin_rvv_vsetvlimax(sew, lmul)   __builtin_rvv_th_vsetvlmax(sew, lmul)

#define __riscv_vsetvl_e8m1(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 0, 0)
#define __riscv_vsetvl_e8m2(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 0, 1)
#define __riscv_vsetvl_e8m4(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 0, 2)
#define __riscv_vsetvl_e8m8(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 0, 3)

#define __riscv_vsetvl_e16m1(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 1, 0)
#define __riscv_vsetvl_e16m2(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 1, 1)
#define __riscv_vsetvl_e16m4(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 1, 2)
#define __riscv_vsetvl_e16m8(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 1, 3)

#define __riscv_vsetvl_e32m1(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 2, 0)
#define __riscv_vsetvl_e32m2(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 2, 1)
#define __riscv_vsetvl_e32m4(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 2, 2)
#define __riscv_vsetvl_e32m8(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 2, 3)

#if __riscv_v_elen >= 64
#define __riscv_vsetvl_e64m1(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 3, 0)
#define __riscv_vsetvl_e64m2(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 3, 1)
#define __riscv_vsetvl_e64m4(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 3, 2)
#define __riscv_vsetvl_e64m8(avl) __builtin_rvv_th_vsetvl((size_t)(avl), 3, 3)
#endif

#define __riscv_vsetvlmax_e8m1() __builtin_rvv_th_vsetvlmax(0, 0)
#define __riscv_vsetvlmax_e8m2() __builtin_rvv_th_vsetvlmax(0, 1)
#define __riscv_vsetvlmax_e8m4() __builtin_rvv_th_vsetvlmax(0, 2)
#define __riscv_vsetvlmax_e8m8() __builtin_rvv_th_vsetvlmax(0, 3)

#define __riscv_vsetvlmax_e16m1() __builtin_rvv_th_vsetvlmax(1, 0)
#define __riscv_vsetvlmax_e16m2() __builtin_rvv_th_vsetvlmax(1, 1)
#define __riscv_vsetvlmax_e16m4() __builtin_rvv_th_vsetvlmax(1, 2)
#define __riscv_vsetvlmax_e16m8() __builtin_rvv_th_vsetvlmax(1, 3)

#define __riscv_vsetvlmax_e32m1() __builtin_rvv_th_vsetvlmax(2, 0)
#define __riscv_vsetvlmax_e32m2() __builtin_rvv_th_vsetvlmax(2, 1)
#define __riscv_vsetvlmax_e32m4() __builtin_rvv_th_vsetvlmax(2, 2)
#define __riscv_vsetvlmax_e32m8() __builtin_rvv_th_vsetvlmax(2, 3)

#if __riscv_v_elen >= 64
#define __riscv_vsetvlmax_e64m1() __builtin_rvv_th_vsetvlmax(3, 0)
#define __riscv_vsetvlmax_e64m2() __builtin_rvv_th_vsetvlmax(3, 1)
#define __riscv_vsetvlmax_e64m4() __builtin_rvv_th_vsetvlmax(3, 2)
#define __riscv_vsetvlmax_e64m8() __builtin_rvv_th_vsetvlmax(3, 3)
#endif

}] in
def th_vsetvl_macro: RVVHeader;

let HasBuiltinAlias = false,
    HasVL = false,
    HasMasked = false,
    MaskedPolicyScheme = NonePolicy,
    Log2LMUL = [0],
    ManualCodegen = [{IntrinsicTypes = {ResultType};}] in // Set XLEN type
{
  def th_vsetvl : RVVBuiltin<"", "zzKzKz", "i">;
  def th_vsetvlmax : RVVBuiltin<"", "zKzKz", "i">;
}

//===----------------------------------------------------------------------===//
// 7. Vector Loads and Stores
//===----------------------------------------------------------------------===//

let HeaderCode =
[{
// Vector Unit-stride loads
#define __riscv_vlb_v_i8m1(base, vl) __riscv_th_vlb_v_i8m1(base, vl)
#define __riscv_vlb_v_i8m2(base, vl) __riscv_th_vlb_v_i8m2(base, vl)
#define __riscv_vlb_v_i8m4(base, vl) __riscv_th_vlb_v_i8m4(base, vl)
#define __riscv_vlb_v_i8m8(base, vl) __riscv_th_vlb_v_i8m8(base, vl)
#define __riscv_vlb_v_i16m1(base, vl) __riscv_th_vlb_v_i16m1(base, vl)
#define __riscv_vlb_v_i16m2(base, vl) __riscv_th_vlb_v_i16m2(base, vl)
#define __riscv_vlb_v_i16m4(base, vl) __riscv_th_vlb_v_i16m4(base, vl)
#define __riscv_vlb_v_i16m8(base, vl) __riscv_th_vlb_v_i16m8(base, vl)
#define __riscv_vlb_v_i32m1(base, vl) __riscv_th_vlb_v_i32m1(base, vl)
#define __riscv_vlb_v_i32m2(base, vl) __riscv_th_vlb_v_i32m2(base, vl)
#define __riscv_vlb_v_i32m4(base, vl) __riscv_th_vlb_v_i32m4(base, vl)
#define __riscv_vlb_v_i32m8(base, vl) __riscv_th_vlb_v_i32m8(base, vl)
#define __riscv_vlb_v_i64m1(base, vl) __riscv_th_vlb_v_i64m1(base, vl)
#define __riscv_vlb_v_i64m2(base, vl) __riscv_th_vlb_v_i64m2(base, vl)
#define __riscv_vlb_v_i64m4(base, vl) __riscv_th_vlb_v_i64m4(base, vl)
#define __riscv_vlb_v_i64m8(base, vl) __riscv_th_vlb_v_i64m8(base, vl)
#define __riscv_vlh_v_i8m1(base, vl) __riscv_th_vlh_v_i8m1(base, vl)
#define __riscv_vlh_v_i8m2(base, vl) __riscv_th_vlh_v_i8m2(base, vl)
#define __riscv_vlh_v_i8m4(base, vl) __riscv_th_vlh_v_i8m4(base, vl)
#define __riscv_vlh_v_i8m8(base, vl) __riscv_th_vlh_v_i8m8(base, vl)
#define __riscv_vlh_v_i16m1(base, vl) __riscv_th_vlh_v_i16m1(base, vl)
#define __riscv_vlh_v_i16m2(base, vl) __riscv_th_vlh_v_i16m2(base, vl)
#define __riscv_vlh_v_i16m4(base, vl) __riscv_th_vlh_v_i16m4(base, vl)
#define __riscv_vlh_v_i16m8(base, vl) __riscv_th_vlh_v_i16m8(base, vl)
#define __riscv_vlh_v_i32m1(base, vl) __riscv_th_vlh_v_i32m1(base, vl)
#define __riscv_vlh_v_i32m2(base, vl) __riscv_th_vlh_v_i32m2(base, vl)
#define __riscv_vlh_v_i32m4(base, vl) __riscv_th_vlh_v_i32m4(base, vl)
#define __riscv_vlh_v_i32m8(base, vl) __riscv_th_vlh_v_i32m8(base, vl)
#define __riscv_vlh_v_i64m1(base, vl) __riscv_th_vlh_v_i64m1(base, vl)
#define __riscv_vlh_v_i64m2(base, vl) __riscv_th_vlh_v_i64m2(base, vl)
#define __riscv_vlh_v_i64m4(base, vl) __riscv_th_vlh_v_i64m4(base, vl)
#define __riscv_vlh_v_i64m8(base, vl) __riscv_th_vlh_v_i64m8(base, vl)
#define __riscv_vlw_v_i8m1(base, vl) __riscv_th_vlw_v_i8m1(base, vl)
#define __riscv_vlw_v_i8m2(base, vl) __riscv_th_vlw_v_i8m2(base, vl)
#define __riscv_vlw_v_i8m4(base, vl) __riscv_th_vlw_v_i8m4(base, vl)
#define __riscv_vlw_v_i8m8(base, vl) __riscv_th_vlw_v_i8m8(base, vl)
#define __riscv_vlw_v_i16m1(base, vl) __riscv_th_vlw_v_i16m1(base, vl)
#define __riscv_vlw_v_i16m2(base, vl) __riscv_th_vlw_v_i16m2(base, vl)
#define __riscv_vlw_v_i16m4(base, vl) __riscv_th_vlw_v_i16m4(base, vl)
#define __riscv_vlw_v_i16m8(base, vl) __riscv_th_vlw_v_i16m8(base, vl)
#define __riscv_vlw_v_i32m1(base, vl) __riscv_th_vlw_v_i32m1(base, vl)
#define __riscv_vlw_v_i32m2(base, vl) __riscv_th_vlw_v_i32m2(base, vl)
#define __riscv_vlw_v_i32m4(base, vl) __riscv_th_vlw_v_i32m4(base, vl)
#define __riscv_vlw_v_i32m8(base, vl) __riscv_th_vlw_v_i32m8(base, vl)
#define __riscv_vlw_v_i64m1(base, vl) __riscv_th_vlw_v_i64m1(base, vl)
#define __riscv_vlw_v_i64m2(base, vl) __riscv_th_vlw_v_i64m2(base, vl)
#define __riscv_vlw_v_i64m4(base, vl) __riscv_th_vlw_v_i64m4(base, vl)
#define __riscv_vlw_v_i64m8(base, vl) __riscv_th_vlw_v_i64m8(base, vl)
#define __riscv_vlbu_v_u8m1(base, vl) __riscv_th_vlbu_v_u8m1(base, vl)
#define __riscv_vlbu_v_u8m2(base, vl) __riscv_th_vlbu_v_u8m2(base, vl)
#define __riscv_vlbu_v_u8m4(base, vl) __riscv_th_vlbu_v_u8m4(base, vl)
#define __riscv_vlbu_v_u8m8(base, vl) __riscv_th_vlbu_v_u8m8(base, vl)
#define __riscv_vlbu_v_u16m1(base, vl) __riscv_th_vlbu_v_u16m1(base, vl)
#define __riscv_vlbu_v_u16m2(base, vl) __riscv_th_vlbu_v_u16m2(base, vl)
#define __riscv_vlbu_v_u16m4(base, vl) __riscv_th_vlbu_v_u16m4(base, vl)
#define __riscv_vlbu_v_u16m8(base, vl) __riscv_th_vlbu_v_u16m8(base, vl)
#define __riscv_vlbu_v_u32m1(base, vl) __riscv_th_vlbu_v_u32m1(base, vl)
#define __riscv_vlbu_v_u32m2(base, vl) __riscv_th_vlbu_v_u32m2(base, vl)
#define __riscv_vlbu_v_u32m4(base, vl) __riscv_th_vlbu_v_u32m4(base, vl)
#define __riscv_vlbu_v_u32m8(base, vl) __riscv_th_vlbu_v_u32m8(base, vl)
#define __riscv_vlbu_v_u64m1(base, vl) __riscv_th_vlbu_v_u64m1(base, vl)
#define __riscv_vlbu_v_u64m2(base, vl) __riscv_th_vlbu_v_u64m2(base, vl)
#define __riscv_vlbu_v_u64m4(base, vl) __riscv_th_vlbu_v_u64m4(base, vl)
#define __riscv_vlbu_v_u64m8(base, vl) __riscv_th_vlbu_v_u64m8(base, vl)
#define __riscv_vlhu_v_u8m1(base, vl) __riscv_th_vlhu_v_u8m1(base, vl)
#define __riscv_vlhu_v_u8m2(base, vl) __riscv_th_vlhu_v_u8m2(base, vl)
#define __riscv_vlhu_v_u8m4(base, vl) __riscv_th_vlhu_v_u8m4(base, vl)
#define __riscv_vlhu_v_u8m8(base, vl) __riscv_th_vlhu_v_u8m8(base, vl)
#define __riscv_vlhu_v_u16m1(base, vl) __riscv_th_vlhu_v_u16m1(base, vl)
#define __riscv_vlhu_v_u16m2(base, vl) __riscv_th_vlhu_v_u16m2(base, vl)
#define __riscv_vlhu_v_u16m4(base, vl) __riscv_th_vlhu_v_u16m4(base, vl)
#define __riscv_vlhu_v_u16m8(base, vl) __riscv_th_vlhu_v_u16m8(base, vl)
#define __riscv_vlhu_v_u32m1(base, vl) __riscv_th_vlhu_v_u32m1(base, vl)
#define __riscv_vlhu_v_u32m2(base, vl) __riscv_th_vlhu_v_u32m2(base, vl)
#define __riscv_vlhu_v_u32m4(base, vl) __riscv_th_vlhu_v_u32m4(base, vl)
#define __riscv_vlhu_v_u32m8(base, vl) __riscv_th_vlhu_v_u32m8(base, vl)
#define __riscv_vlhu_v_u64m1(base, vl) __riscv_th_vlhu_v_u64m1(base, vl)
#define __riscv_vlhu_v_u64m2(base, vl) __riscv_th_vlhu_v_u64m2(base, vl)
#define __riscv_vlhu_v_u64m4(base, vl) __riscv_th_vlhu_v_u64m4(base, vl)
#define __riscv_vlhu_v_u64m8(base, vl) __riscv_th_vlhu_v_u64m8(base, vl)
#define __riscv_vlwu_v_u8m1(base, vl) __riscv_th_vlwu_v_u8m1(base, vl)
#define __riscv_vlwu_v_u8m2(base, vl) __riscv_th_vlwu_v_u8m2(base, vl)
#define __riscv_vlwu_v_u8m4(base, vl) __riscv_th_vlwu_v_u8m4(base, vl)
#define __riscv_vlwu_v_u8m8(base, vl) __riscv_th_vlwu_v_u8m8(base, vl)
#define __riscv_vlwu_v_u16m1(base, vl) __riscv_th_vlwu_v_u16m1(base, vl)
#define __riscv_vlwu_v_u16m2(base, vl) __riscv_th_vlwu_v_u16m2(base, vl)
#define __riscv_vlwu_v_u16m4(base, vl) __riscv_th_vlwu_v_u16m4(base, vl)
#define __riscv_vlwu_v_u16m8(base, vl) __riscv_th_vlwu_v_u16m8(base, vl)
#define __riscv_vlwu_v_u32m1(base, vl) __riscv_th_vlwu_v_u32m1(base, vl)
#define __riscv_vlwu_v_u32m2(base, vl) __riscv_th_vlwu_v_u32m2(base, vl)
#define __riscv_vlwu_v_u32m4(base, vl) __riscv_th_vlwu_v_u32m4(base, vl)
#define __riscv_vlwu_v_u32m8(base, vl) __riscv_th_vlwu_v_u32m8(base, vl)
#define __riscv_vlwu_v_u64m1(base, vl) __riscv_th_vlwu_v_u64m1(base, vl)
#define __riscv_vlwu_v_u64m2(base, vl) __riscv_th_vlwu_v_u64m2(base, vl)
#define __riscv_vlwu_v_u64m4(base, vl) __riscv_th_vlwu_v_u64m4(base, vl)
#define __riscv_vlwu_v_u64m8(base, vl) __riscv_th_vlwu_v_u64m8(base, vl)
#define __riscv_vle8_v_i8m1(base, vl) __riscv_th_vle8_v_i8m1(base, vl)
#define __riscv_vle8_v_i8m2(base, vl) __riscv_th_vle8_v_i8m2(base, vl)
#define __riscv_vle8_v_i8m4(base, vl) __riscv_th_vle8_v_i8m4(base, vl)
#define __riscv_vle8_v_i8m8(base, vl) __riscv_th_vle8_v_i8m8(base, vl)
#define __riscv_vle16_v_i16m1(base, vl) __riscv_th_vle16_v_i16m1(base, vl)
#define __riscv_vle16_v_i16m2(base, vl) __riscv_th_vle16_v_i16m2(base, vl)
#define __riscv_vle16_v_i16m4(base, vl) __riscv_th_vle16_v_i16m4(base, vl)
#define __riscv_vle16_v_i16m8(base, vl) __riscv_th_vle16_v_i16m8(base, vl)
#define __riscv_vle32_v_i32m1(base, vl) __riscv_th_vle32_v_i32m1(base, vl)
#define __riscv_vle32_v_i32m2(base, vl) __riscv_th_vle32_v_i32m2(base, vl)
#define __riscv_vle32_v_i32m4(base, vl) __riscv_th_vle32_v_i32m4(base, vl)
#define __riscv_vle32_v_i32m8(base, vl) __riscv_th_vle32_v_i32m8(base, vl)
#define __riscv_vle64_v_i64m1(base, vl) __riscv_th_vle64_v_i64m1(base, vl)
#define __riscv_vle64_v_i64m2(base, vl) __riscv_th_vle64_v_i64m2(base, vl)
#define __riscv_vle64_v_i64m4(base, vl) __riscv_th_vle64_v_i64m4(base, vl)
#define __riscv_vle64_v_i64m8(base, vl) __riscv_th_vle64_v_i64m8(base, vl)
#define __riscv_vle8_v_u8m1(base, vl) __riscv_th_vle8_v_u8m1(base, vl)
#define __riscv_vle8_v_u8m2(base, vl) __riscv_th_vle8_v_u8m2(base, vl)
#define __riscv_vle8_v_u8m4(base, vl) __riscv_th_vle8_v_u8m4(base, vl)
#define __riscv_vle8_v_u8m8(base, vl) __riscv_th_vle8_v_u8m8(base, vl)
#define __riscv_vle16_v_u16m1(base, vl) __riscv_th_vle16_v_u16m1(base, vl)
#define __riscv_vle16_v_u16m2(base, vl) __riscv_th_vle16_v_u16m2(base, vl)
#define __riscv_vle16_v_u16m4(base, vl) __riscv_th_vle16_v_u16m4(base, vl)
#define __riscv_vle16_v_u16m8(base, vl) __riscv_th_vle16_v_u16m8(base, vl)
#define __riscv_vle32_v_u32m1(base, vl) __riscv_th_vle32_v_u32m1(base, vl)
#define __riscv_vle32_v_u32m2(base, vl) __riscv_th_vle32_v_u32m2(base, vl)
#define __riscv_vle32_v_u32m4(base, vl) __riscv_th_vle32_v_u32m4(base, vl)
#define __riscv_vle32_v_u32m8(base, vl) __riscv_th_vle32_v_u32m8(base, vl)
#define __riscv_vle64_v_u64m1(base, vl) __riscv_th_vle64_v_u64m1(base, vl)
#define __riscv_vle64_v_u64m2(base, vl) __riscv_th_vle64_v_u64m2(base, vl)
#define __riscv_vle64_v_u64m4(base, vl) __riscv_th_vle64_v_u64m4(base, vl)
#define __riscv_vle64_v_u64m8(base, vl) __riscv_th_vle64_v_u64m8(base, vl)
#define __riscv_vle16_v_f16m1(base, vl) __riscv_th_vle16_v_f16m1(base, vl)
#define __riscv_vle16_v_f16m2(base, vl) __riscv_th_vle16_v_f16m2(base, vl)
#define __riscv_vle16_v_f16m4(base, vl) __riscv_th_vle16_v_f16m4(base, vl)
#define __riscv_vle16_v_f16m8(base, vl) __riscv_th_vle16_v_f16m8(base, vl)
#define __riscv_vle32_v_f32m1(base, vl) __riscv_th_vle32_v_f32m1(base, vl)
#define __riscv_vle32_v_f32m2(base, vl) __riscv_th_vle32_v_f32m2(base, vl)
#define __riscv_vle32_v_f32m4(base, vl) __riscv_th_vle32_v_f32m4(base, vl)
#define __riscv_vle32_v_f32m8(base, vl) __riscv_th_vle32_v_f32m8(base, vl)
#define __riscv_vle64_v_f64m1(base, vl) __riscv_th_vle64_v_f64m1(base, vl)
#define __riscv_vle64_v_f64m2(base, vl) __riscv_th_vle64_v_f64m2(base, vl)
#define __riscv_vle64_v_f64m4(base, vl) __riscv_th_vle64_v_f64m4(base, vl)
#define __riscv_vle64_v_f64m8(base, vl) __riscv_th_vle64_v_f64m8(base, vl)

// Vector Unit-stride stores
#define __riscv_vsb_v_i8m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i8m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i8m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i8m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i8m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i8m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i8m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i8m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i16m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i16m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i16m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i16m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i16m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i16m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i16m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i16m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i32m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i32m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i32m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i32m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i32m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i32m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i32m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i32m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i64m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i64m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i64m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i64m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i64m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i64m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_i64m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_i64m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i8m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i8m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i8m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i8m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i8m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i8m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i8m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i8m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i16m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i16m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i16m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i16m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i16m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i16m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i16m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i16m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i32m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i32m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i32m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i32m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i32m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i32m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i32m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i32m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i64m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i64m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i64m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i64m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i64m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i64m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_i64m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_i64m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i8m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i8m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i8m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i8m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i8m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i8m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i8m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i8m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i16m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i16m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i16m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i16m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i16m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i16m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i16m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i16m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i32m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i32m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i32m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i32m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i32m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i32m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i32m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i32m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i64m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i64m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i64m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i64m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i64m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i64m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_i64m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_i64m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u8m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u8m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u8m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u8m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u8m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u8m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u8m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u8m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u16m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u16m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u16m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u16m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u16m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u16m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u16m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u16m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u32m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u32m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u32m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u32m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u32m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u32m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u32m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u32m8(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u64m1(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u64m1(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u64m2(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u64m2(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u64m4(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u64m4(dst_ptr, vector_value, vl)
#define __riscv_vsb_v_u64m8(dst_ptr, vector_value, vl) __riscv_th_vsb_v_u64m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u8m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u8m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u8m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u8m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u8m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u8m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u8m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u8m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u16m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u16m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u16m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u16m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u16m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u16m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u16m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u16m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u32m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u32m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u32m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u32m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u32m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u32m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u32m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u32m8(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u64m1(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u64m1(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u64m2(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u64m2(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u64m4(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u64m4(dst_ptr, vector_value, vl)
#define __riscv_vsh_v_u64m8(dst_ptr, vector_value, vl) __riscv_th_vsh_v_u64m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u8m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u8m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u8m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u8m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u8m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u8m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u8m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u8m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u16m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u16m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u16m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u16m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u16m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u16m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u16m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u16m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u32m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u32m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u32m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u32m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u32m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u32m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u32m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u32m8(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u64m1(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u64m1(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u64m2(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u64m2(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u64m4(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u64m4(dst_ptr, vector_value, vl)
#define __riscv_vsw_v_u64m8(dst_ptr, vector_value, vl) __riscv_th_vsw_v_u64m8(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_i8m1(dst_ptr, vector_value, vl) __riscv_th_vse8_v_i8m1(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_i8m2(dst_ptr, vector_value, vl) __riscv_th_vse8_v_i8m2(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_i8m4(dst_ptr, vector_value, vl) __riscv_th_vse8_v_i8m4(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_i8m8(dst_ptr, vector_value, vl) __riscv_th_vse8_v_i8m8(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_i16m1(dst_ptr, vector_value, vl) __riscv_th_vse16_v_i16m1(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_i16m2(dst_ptr, vector_value, vl) __riscv_th_vse16_v_i16m2(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_i16m4(dst_ptr, vector_value, vl) __riscv_th_vse16_v_i16m4(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_i16m8(dst_ptr, vector_value, vl) __riscv_th_vse16_v_i16m8(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_i32m1(dst_ptr, vector_value, vl) __riscv_th_vse32_v_i32m1(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_i32m2(dst_ptr, vector_value, vl) __riscv_th_vse32_v_i32m2(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_i32m4(dst_ptr, vector_value, vl) __riscv_th_vse32_v_i32m4(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_i32m8(dst_ptr, vector_value, vl) __riscv_th_vse32_v_i32m8(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_i64m1(dst_ptr, vector_value, vl) __riscv_th_vse64_v_i64m1(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_i64m2(dst_ptr, vector_value, vl) __riscv_th_vse64_v_i64m2(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_i64m4(dst_ptr, vector_value, vl) __riscv_th_vse64_v_i64m4(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_i64m8(dst_ptr, vector_value, vl) __riscv_th_vse64_v_i64m8(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_u8m1(dst_ptr, vector_value, vl) __riscv_th_vse8_v_u8m1(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_u8m2(dst_ptr, vector_value, vl) __riscv_th_vse8_v_u8m2(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_u8m4(dst_ptr, vector_value, vl) __riscv_th_vse8_v_u8m4(dst_ptr, vector_value, vl)
#define __riscv_vse8_v_u8m8(dst_ptr, vector_value, vl) __riscv_th_vse8_v_u8m8(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_u16m1(dst_ptr, vector_value, vl) __riscv_th_vse16_v_u16m1(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_u16m2(dst_ptr, vector_value, vl) __riscv_th_vse16_v_u16m2(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_u16m4(dst_ptr, vector_value, vl) __riscv_th_vse16_v_u16m4(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_u16m8(dst_ptr, vector_value, vl) __riscv_th_vse16_v_u16m8(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_u32m1(dst_ptr, vector_value, vl) __riscv_th_vse32_v_u32m1(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_u32m2(dst_ptr, vector_value, vl) __riscv_th_vse32_v_u32m2(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_u32m4(dst_ptr, vector_value, vl) __riscv_th_vse32_v_u32m4(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_u32m8(dst_ptr, vector_value, vl) __riscv_th_vse32_v_u32m8(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_u64m1(dst_ptr, vector_value, vl) __riscv_th_vse64_v_u64m1(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_u64m2(dst_ptr, vector_value, vl) __riscv_th_vse64_v_u64m2(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_u64m4(dst_ptr, vector_value, vl) __riscv_th_vse64_v_u64m4(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_u64m8(dst_ptr, vector_value, vl) __riscv_th_vse64_v_u64m8(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_f16m1(dst_ptr, vector_value, vl) __riscv_th_vse16_v_f16m1(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_f16m2(dst_ptr, vector_value, vl) __riscv_th_vse16_v_f16m2(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_f16m4(dst_ptr, vector_value, vl) __riscv_th_vse16_v_f16m4(dst_ptr, vector_value, vl)
#define __riscv_vse16_v_f16m8(dst_ptr, vector_value, vl) __riscv_th_vse16_v_f16m8(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_f32m1(dst_ptr, vector_value, vl) __riscv_th_vse32_v_f32m1(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_f32m2(dst_ptr, vector_value, vl) __riscv_th_vse32_v_f32m2(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_f32m4(dst_ptr, vector_value, vl) __riscv_th_vse32_v_f32m4(dst_ptr, vector_value, vl)
#define __riscv_vse32_v_f32m8(dst_ptr, vector_value, vl) __riscv_th_vse32_v_f32m8(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_f64m1(dst_ptr, vector_value, vl) __riscv_th_vse64_v_f64m1(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_f64m2(dst_ptr, vector_value, vl) __riscv_th_vse64_v_f64m2(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_f64m4(dst_ptr, vector_value, vl) __riscv_th_vse64_v_f64m4(dst_ptr, vector_value, vl)
#define __riscv_vse64_v_f64m8(dst_ptr, vector_value, vl) __riscv_th_vse64_v_f64m8(dst_ptr, vector_value, vl)

}] in
def th_unit_stride_wrapper_macros: RVVHeader;

let SupportOverloading = false,
    UnMaskedPolicyScheme = HasPassthruOperand in {
  multiclass RVVVLEBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `vPCe` is type `const T * -> VectorType`
        def : RVVOutBuiltin<"v", "vPCe", type>;
        if !not(IsFloat<type>.val) then {
          // `UvPCUe` is type `const unsigned T * -> unsigned VectorType`
          def : RVVOutBuiltin<"Uv", "UvPCUe", type>;
        }
      }
    }
  }

  multiclass RVVVLXBuiltin<string ir, list<string> types> {
    foreach type = types in {
      // `vPCe` is type `const T * -> VectorType`
      let Name = NAME # "_v",
          IRName = ir,
          MaskedIRName = ir # "_mask" in
      def : RVVOutBuiltin<"v", "vPCe", type>;
      // `UvPCUe` is type `const unsigned T * -> unsigned VectorType`
      let Name = NAME # "u_v",
          IRName = ir # "u",
          MaskedIRName = ir # "u_mask" in
      def : RVVOutBuiltin<"Uv", "UvPCUe", type>;
    }
  }
}

let HasMaskedOffOperand = false,
    MaskedPolicyScheme = NonePolicy,
    ManualCodegen = [{
      if (IsMasked) {
        // Builtin: (mask, ptr, value, vl). Intrinsic: (value, ptr, mask, vl)
        std::swap(Ops[0], Ops[2]);
      } else {
        // Builtin: (ptr, value, vl). Intrinsic: (value, ptr, vl)
        std::swap(Ops[0], Ops[1]);
      }
      Ops[1] = Builder.CreateBitCast(Ops[1], Ops[0]->getType()->getPointerTo());
      if (IsMasked)
        IntrinsicTypes = {Ops[0]->getType(), Ops[3]->getType()};
      else
        IntrinsicTypes = {Ops[0]->getType(), Ops[2]->getType()};
    }] in {
  multiclass RVVVSEBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0Pev` is type `T * -> VectorType -> void`
        def : RVVBuiltin<"v", "0Pev", type>;
        if !not(IsFloat<type>.val) then {
          // `0PUeUv` is type `unsigned T * -> unsigned VectorType -> void`
          def : RVVBuiltin<"Uv", "0PUeUv", type>;
        }
      }
    }
  }

  multiclass RVVVSXBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0Pev` is type `T * -> VectorType -> void`
        def : RVVBuiltin<"v", "0Pev", type>;
        // `0PUeUv` is type `unsigned T * -> unsigned VectorType -> void`
        def : RVVBuiltin<"Uv", "0PUeUv", type>;
      }
    }
  }
}

// 7.1. Vector Unit-Stride Operations
defm th_vlb  : RVVVLXBuiltin<"th_vlb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlh  : RVVVLXBuiltin<"th_vlh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlw  : RVVVLXBuiltin<"th_vlw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vle8 : RVVVLEBuiltin<"th_vle", ["c"]>;     // i8
defm th_vle16: RVVVLEBuiltin<"th_vle", ["s","x"]>; // i16, f16
defm th_vle32: RVVVLEBuiltin<"th_vle", ["i","f"]>; // i32, f32
defm th_vle64: RVVVLEBuiltin<"th_vle", ["l","d"]>; // i64, f64

defm th_vsb  : RVVVSXBuiltin<"th_vsb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsh  : RVVVSXBuiltin<"th_vsh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsw  : RVVVSXBuiltin<"th_vsw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vse8 : RVVVSEBuiltin<"th_vse", ["c"]>;     // i8
defm th_vse16: RVVVSEBuiltin<"th_vse", ["s","x"]>; // i16, f16
defm th_vse32: RVVVSEBuiltin<"th_vse", ["i","f"]>; // i32, f32
defm th_vse64: RVVVSEBuiltin<"th_vse", ["l","d"]>; // i64, f64

//===----------------------------------------------------------------------===//
// 12. Vector Integer Arithmetic Operations
//===----------------------------------------------------------------------===//

let UnMaskedPolicyScheme = HasPassthruOperand in {
  defm th_vadd : RVVIntBinBuiltinSet;
}
