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

class RVVOutOp1Builtin<string suffix, string prototype, string type_range>
    : RVVBuiltin<suffix, prototype, type_range> {
  let IntrinsicTypes = [-1, 1];
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

defvar NFList = [2, 3, 4, 5, 6, 7, 8];
defvar TypeList = ["c", "s", "i", "l", "x", "f", "d"];
defvar EEWList = [["8", "(Log2EEW:3)"],
                  ["16", "(Log2EEW:4)"],
                  ["32", "(Log2EEW:5)"],
                  ["64", "(Log2EEW:6)"]];

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

let SupportOverloading = false,
    UnMaskedPolicyScheme = HasPassthruOperand in {
  // 7.1 Unit-stride load: vle8/16/32/64
  multiclass RVVVLEBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `vPCe` is type `const T * -> {VL} -> VectorType`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVOutBuiltin<"v", "vPCe", type>;
        if !not(IsFloat<type>.val) then {
          // `UvPCUe` is type `const unsigned T * -> {VL} -> unsigned VectorType`
          def : RVVOutBuiltin<"Uv", "UvPCUe", type>;
        }
      }
    }
  }

  // 7.1 Unit-stride load: vlb/h/w/bu/hu/wu
  multiclass RVVVLBHWBuiltin<string ir, list<string> types> {
    foreach type = types in {
      // `vPCe` is type `const T * -> {VL} -> VectorType`
      // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
      let Name = NAME # "_v",
          IRName = ir,
          MaskedIRName = ir # "_mask" in
      def : RVVOutBuiltin<"v", "vPCe", type>;
      // `UvPCUe` is type `const unsigned T * -> {VL} -> unsigned VectorType`
      let Name = NAME # "u_v",
          IRName = ir # "u",
          MaskedIRName = ir # "u_mask" in
      def : RVVOutBuiltin<"Uv", "UvPCUe", type>;
    }
  }

  // 7.2 Strided load: vlse8/16/32/64
  multiclass RVVVLSEBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `vPCet` is type `const T * -> PtrDiffT -> {VL} -> VectorType`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVOutBuiltin<"v", "vPCet", type>;
        if !not(IsFloat<type>.val) then {
          // `UvPCUet` is type `const unsigned T * -> PtrDiffT -> {VL} -> unsigned VectorType`
          def : RVVOutBuiltin<"Uv", "UvPCUet", type>;
        }
      }
    }
  }

  // 7.2 Strided load: vlsb/h/w/bu/hu/wu
  multiclass RVVVLSBHWBuiltin<string ir, list<string> types> {
    foreach type = types in {
      // `vPCez` is type `const T * -> SizeT -> {VL} -> VectorType`
      // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
      let Name = NAME # "_v",
          IRName = ir,
          MaskedIRName = ir # "_mask" in
      def : RVVOutBuiltin<"v", "vPCez", type>;
      // `UvPCUez` is type `const unsigned T * -> SizeT -> {VL} -> unsigned VectorType`
      let Name = NAME # "u_v",
          IRName = ir # "u",
          MaskedIRName = ir # "u_mask" in
      def : RVVOutBuiltin<"Uv", "UvPCUez", type>;
    }
  }


  // 7.3 Indexed Load Operations: vlxb/h/w/bu/hu/wu
  multiclass RVVVLXBHWBuiltin<string ir, list<string> types> {
    foreach type = types in {
      // `vPCeUv` is type `const T * -> unsigned VectorType -> {VL} -> VectorType`
      // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
      let Name = NAME # "_v",
          IRName = ir,
          MaskedIRName = ir # "_mask" in
      def : RVVOutOp1Builtin<"v", "vPCeUv", type>;
      // `UvPCUeUv` is type `const unsigned T * -> unsigned VectorType -> {VL} -> unsigned VectorType`
      let Name = NAME # "u_v",
          IRName = ir # "u",
          MaskedIRName = ir # "u_mask" in
      def : RVVOutOp1Builtin<"Uv", "UvPCUeUv", type>;
    }
  }

  // 7.4. Unit-stride Fault-Only-First Loads Operations
  multiclass RVVVLEFFBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask",
        ManualCodegen = [{
        {
          if (IsMasked) {
            // Move mask to right before vl.
            std::rotate(Ops.begin(), Ops.begin() + 1, Ops.end() - 1);
            if ((PolicyAttrs & RVV_VTA) && (PolicyAttrs & RVV_VMA))
              Ops.insert(Ops.begin(), llvm::PoisonValue::get(ResultType));
            Ops.push_back(ConstantInt::get(Ops.back()->getType(), PolicyAttrs));
            IntrinsicTypes = {ResultType, Ops[4]->getType()};
          } else {
            if (PolicyAttrs & RVV_VTA)
              Ops.insert(Ops.begin(), llvm::PoisonValue::get(ResultType));
            IntrinsicTypes = {ResultType, Ops[3]->getType()};
          }
          Ops[1] = Builder.CreateBitCast(Ops[1], ResultType->getPointerTo());
          Value *NewVL = Ops[2];
          Ops.erase(Ops.begin() + 2);
          llvm::Function *F = CGM.getIntrinsic(ID, IntrinsicTypes);
          llvm::Value *LoadValue = Builder.CreateCall(F, Ops, "");
          llvm::Value *V = Builder.CreateExtractValue(LoadValue, {0});
          // Store new_vl.
          clang::CharUnits Align;
          if (IsMasked)
            Align = CGM.getNaturalPointeeTypeAlignment(E->getArg(E->getNumArgs()-2)->getType());
          else
            Align = CGM.getNaturalPointeeTypeAlignment(E->getArg(1)->getType());
          llvm::Value *Val = Builder.CreateExtractValue(LoadValue, {1});
          Builder.CreateStore(Val, Address(NewVL, Val->getType(), Align));
          return V;
        }
    }] in {
      foreach type = types in {
        // `vPCePz` is type `const T * -> SizeT * -> {VL} -> VectorType`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVBuiltin<"v", "vPCePz", type>;
        if !not(IsFloat<type>.val) then {
          // `UvPCUePz` is type `const unsigned T * -> SizeT * -> {VL} -> unsigned VectorType`
          def : RVVBuiltin<"Uv", "UvPCUePz", type>;
        }
      }
    }
  }
}

// 7.3 Indexed Load Operations: vlxei<eew>
multiclass RVVVLXEEWBuiltin<string ir, list<string> types> {
  let UnMaskedPolicyScheme = HasPassthruOperand in {
    foreach type = types in {
      foreach eew_list = EEWList in {
        defvar eew = eew_list[0];
        defvar eew_type = eew_list[1];
        let Name = NAME # eew # "_v", 
            IRName = ir, 
            MaskedIRName = ir # "_mask" in {
          // Compare the following two signatures of vloxei:
          // vint8m1_t vloxei8_v_i8m1 (const int8_t *base,  vuint8m1_t bindex, size_t vl);
          // vint8m1_t vloxei16_v_i8m1 (const int8_t *base, vuint16m2_t bindex, size_t vl);
          // The type of `bindex` should not be computed from `type` (aka, i8m1, i8m2, etc.),
          // which is not the same as what we do in other intirnsics.

          // `vPCe<eew>Uv` is type `const T * -> unsigned <EEW> VectorType -> {VL} -> VectorType`
          // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
          def: RVVOutOp1Builtin<"v", "vPCe" # eew_type # "Uv", type>;
          if !not(IsFloat<type>.val) then {
            // `UvPCUe<eew>Uv` is type `const unsigned T * -> unsigned <EEW> VectorType -> {VL} -> unsigned VectorType`
            def: RVVOutOp1Builtin<"Uv", "UvPCUe" # eew_type # "Uv", type>;
          }
        }
      }
    }
  }
}

// 7.1 Unit-strided Store Operations
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
  // 7.1 Unit-stride store: vse8/16/32/64
  multiclass RVVVSEBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0Pev` is type `T * -> VectorType -> {VL} -> void`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVBuiltin<"v", "0Pev", type>;
        if !not(IsFloat<type>.val) then {
          // `0PUeUv` is type `unsigned T * -> unsigned VectorType -> {VL} -> void`
          def : RVVBuiltin<"Uv", "0PUeUv", type>;
        }
      }
    }
  }

  // 7.1 Unit-stride store: vsb/h/w/bu/hu/wu
  multiclass RVVVSBHWBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0Pev` is type `T * -> VectorType -> {VL} -> void`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVBuiltin<"v", "0Pev", type>;
        // `0PUeUv` is type `unsigned T * -> unsigned VectorType -> {VL} -> void`
        def : RVVBuiltin<"Uv", "0PUeUv", type>;
      }
    }
  }
}

// 7.2 Strided Store Operations
let HasMaskedOffOperand = false,
    MaskedPolicyScheme = NonePolicy,
    ManualCodegen = [{
      if (IsMasked) {
        // Builtin: (mask, ptr, stride, value, vl). Intrinsic: (value, ptr, stride, mask, vl)
        std::swap(Ops[0], Ops[3]);
      } else {
        // Builtin: (ptr, stride, value, vl). Intrinsic: (value, ptr, stride, vl)
        std::rotate(Ops.begin(), Ops.begin() + 2, Ops.begin() + 3);
      }
      Ops[1] = Builder.CreateBitCast(Ops[1], Ops[0]->getType()->getPointerTo());
      if (IsMasked)
        IntrinsicTypes = {Ops[0]->getType(), Ops[4]->getType()};
      else
        IntrinsicTypes = {Ops[0]->getType(), Ops[3]->getType()};
    }] in {
  // 7.2 Strided store: vsse8/16/32/64
  multiclass RVVVSSEBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0Petv` is type `T * -> -> PtrDiffT -> VectorType -> {VL} -> void`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVBuiltin<"v", "0Petv", type>;
        if !not(IsFloat<type>.val) then {
          // `0PUetUv` is type `unsigned T * -> PtrDiffT -> unsigned VectorType -> {VL} -> void`
          def : RVVBuiltin<"Uv", "0PUetUv", type>;
        }
      }
    }
  }

  // 7.2 Strided store: vssb/h/w/bu/hu/wu
  multiclass RVVVSSBHWBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0Pezv` is type `T * -> SizeT -> VectorType -> {VL} -> void`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVBuiltin<"v", "0Pezv", type>;
        // `0PUezUv` is type `unsigned T * -> SizeT -> unsigned VectorType -> {VL} -> void`
        def : RVVBuiltin<"Uv", "0PUezUv", type>;
      }
    }
  }
}

// 7.3 Indexed Store Operations
let HasMaskedOffOperand = false,
    MaskedPolicyScheme = NonePolicy,
    ManualCodegen = [{
      if (IsMasked) {
        // Builtin: (mask, ptr, index, value, vl). Intrinsic: (value, ptr, index, mask, vl)
        std::swap(Ops[0], Ops[3]);
      } else {
        // Builtin: (ptr, index, value, vl). Intrinsic: (value, ptr, index, vl)
        std::rotate(Ops.begin(), Ops.begin() + 2, Ops.begin() + 3);
      }
      Ops[1] = Builder.CreateBitCast(Ops[1], Ops[0]->getType()->getPointerTo());
      if (IsMasked)
        IntrinsicTypes = {Ops[0]->getType(), Ops[2]->getType(), Ops[4]->getType()};
      else
        IntrinsicTypes = {Ops[0]->getType(), Ops[2]->getType(), Ops[3]->getType()};
    }] in {
  multiclass RVVVSXEEWBuiltin<string ir, list<string> types> {
    // 7.3 Indexed store: vsxei<eew>
    foreach type = types in {
      foreach eew_list = EEWList in {
        defvar eew = eew_list[0];
        defvar eew_type = eew_list[1];
        let Name = NAME # eew # "_v",
            IRName = ir,
            MaskedIRName = ir # "_mask" in  {
          // `0Pe<eew>Uvv` is type `T * -> unsigned <EEW> VectorType -> VectorType -> {VL} -> void`
          // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
          def : RVVBuiltin<"v", "0Pe" # eew_type # "Uvv", type>;
          if !not(IsFloat<type>.val) then {
            // `0PUe<eew>UvUv` is type `unsigned T * -> unsigned <EEW> VectorType -> unsigned VectorType -> {VL} -> void`
            def : RVVBuiltin<"Uv", "0PUe" # eew_type # "UvUv", type>;
          }
        }
      }
    }
  }

  // 7.3 Indexed store: vsxb/h/w/bu/hu/wu
  multiclass RVVVSXBHWBuiltin<string ir, list<string> types> {
    let Name = NAME # "_v",
        IRName = ir,
        MaskedIRName = ir # "_mask" in {
      foreach type = types in {
        // `0PeUvv` is type `T * -> unsigned VectorType -> VectorType -> {VL} -> void`
        // Note: the last operand {VL} is inserted by `RVVIntrinsic::computeBuiltinTypes`
        def : RVVBuiltin<"v", "0PeUvv", type>;
        // `0PUeUvUv` is type `unsigned T * -> unsigned VectorType -> unsigned VectorType -> {VL} -> void`
        def : RVVBuiltin<"Uv", "0PUeUvUv", type>;
      }
    }
  }
}

// 7.1. Vector Unit-Stride Operations
defm th_vlb  : RVVVLBHWBuiltin<"th_vlb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlh  : RVVVLBHWBuiltin<"th_vlh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlw  : RVVVLBHWBuiltin<"th_vlw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vle8 : RVVVLEBuiltin<"th_vle", ["c"]>;     // i8
defm th_vle16: RVVVLEBuiltin<"th_vle", ["s","x"]>; // i16, f16
defm th_vle32: RVVVLEBuiltin<"th_vle", ["i","f"]>; // i32, f32
defm th_vle64: RVVVLEBuiltin<"th_vle", ["l","d"]>; // i64, f64

defm th_vsb  : RVVVSBHWBuiltin<"th_vsb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsh  : RVVVSBHWBuiltin<"th_vsh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsw  : RVVVSBHWBuiltin<"th_vsw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vse8 : RVVVSEBuiltin<"th_vse", ["c"]>;     // i8
defm th_vse16: RVVVSEBuiltin<"th_vse", ["s","x"]>; // i16, f16
defm th_vse32: RVVVSEBuiltin<"th_vse", ["i","f"]>; // i32, f32
defm th_vse64: RVVVSEBuiltin<"th_vse", ["l","d"]>; // i64, f64

// 7.2. Vector Strided Load/Store Operations
defm th_vlsb  : RVVVLSBHWBuiltin<"th_vlsb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlsh  : RVVVLSBHWBuiltin<"th_vlsh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlsw  : RVVVLSBHWBuiltin<"th_vlsw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlse8 : RVVVLSEBuiltin<"th_vlse", ["c"]>;     // i8
defm th_vlse16: RVVVLSEBuiltin<"th_vlse", ["s","x"]>; // i16, f16
defm th_vlse32: RVVVLSEBuiltin<"th_vlse", ["i","f"]>; // i32, f32
defm th_vlse64: RVVVLSEBuiltin<"th_vlse", ["l","d"]>; // i64, f64

defm th_vssb  : RVVVSSBHWBuiltin<"th_vssb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vssh  : RVVVSSBHWBuiltin<"th_vssh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vssw  : RVVVSSBHWBuiltin<"th_vssw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsse8 : RVVVSSEBuiltin<"th_vsse", ["c"]>;     // i8
defm th_vsse16: RVVVSSEBuiltin<"th_vsse", ["s","x"]>; // i16, f16
defm th_vsse32: RVVVSSEBuiltin<"th_vsse", ["i","f"]>; // i32, f32
defm th_vsse64: RVVVSSEBuiltin<"th_vsse", ["l","d"]>; // i64, f64

// 7.3 Vector Indexed Load/Store Operations
defm th_vlxb   : RVVVLXBHWBuiltin<"th_vlxb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlxh   : RVVVLXBHWBuiltin<"th_vlxh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vlxw   : RVVVLXBHWBuiltin<"th_vlxw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vloxei : RVVVLXEEWBuiltin<"th_vlxe", TypeList>;             // all types

defm th_vsxb   : RVVVSXBHWBuiltin<"th_vsxb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsxh   : RVVVSXBHWBuiltin<"th_vsxh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsxw   : RVVVSXBHWBuiltin<"th_vsxw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
defm th_vsoxei : RVVVSXEEWBuiltin<"th_vsxe", TypeList>;             // all types

// TODO: LLVM intrinsic th_vsuxb, th_vsuxh, th_vsuxw, th_xsuxei for the following:
//defm th_vsuxb   : RVVVSXBHWBuiltin<"th_vsuxb", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
//defm th_vsuxh   : RVVVSXBHWBuiltin<"th_vsuxh", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
//defm th_vsuxw   : RVVVSXBHWBuiltin<"th_vsuxw", ["c", "s", "i", "l"]>; // i8, i16, i32, i64
//defm th_vsuxei : RVVVSXEEWBuiltin<"th_vsuxe", TypeList>;             // all types

// 7.4. Unit-stride Fault-Only-First Loads Operations
defm th_vle8ff : RVVVLEFFBuiltin<"th_vleff", ["c"]>;      // i8
defm th_vle16ff: RVVVLEFFBuiltin<"th_vleff", ["s","x"]>;  // i16, f16
defm th_vle32ff: RVVVLEFFBuiltin<"th_vleff", ["i", "f"]>; // i32, f32
defm th_vle64ff: RVVVLEFFBuiltin<"th_vleff", ["l", "d"]>; // i64, f64

// 7.5.1 Vector Unit-stride Segment Loads (Zvlsseg)
multiclass RVVUSSegLoadEEW<string ir, list<string> types> {
  foreach type = types in {
    defvar eew = !cond(!eq(type, "c") : "8",
                       !eq(type, "s") : "16",
                       !eq(type, "i") : "32",
                       !eq(type, "l") : "64",
                       !eq(type, "x") : "16",
                       !eq(type, "f") : "32",
                       !eq(type, "d") : "64");
      foreach nf = NFList in {
        let Name = ir # nf # "e" # eew # "_v",
            IRName = ir # nf # "e",
            MaskedIRName = ir # nf # "e" # "_mask",
            NF = nf,
            ManualCodegen = [{
    {
      llvm::Type *ElementVectorType = cast<StructType>(ResultType)->elements()[0];
      IntrinsicTypes = {ElementVectorType, Ops.back()->getType()};
      SmallVector<llvm::Value*, 12> Operands;

      bool NoPassthru =
        (IsMasked && (PolicyAttrs & RVV_VTA) && (PolicyAttrs & RVV_VMA)) |
        (!IsMasked && (PolicyAttrs & RVV_VTA));
      unsigned Offset = IsMasked ? NoPassthru ? 1 : 2 : NoPassthru ? 0 : 1;

      if (NoPassthru) { // Push poison into passthru
        Operands.append(NF, llvm::PoisonValue::get(ElementVectorType));
      } else { // Push intrinsics operands into passthru
        llvm::Value *PassthruOperand = IsMasked ? Ops[1] : Ops[0];
        for (unsigned I = 0; I < NF; ++I)
          Operands.push_back(Builder.CreateExtractValue(PassthruOperand, {I}));
      }

      Operands.push_back(Ops[Offset]); // Ptr
      if (IsMasked)
        Operands.push_back(Ops[0]);
      Operands.push_back(Ops[Offset + 1]); // VL
      if (IsMasked)
        Operands.push_back(ConstantInt::get(Ops.back()->getType(), PolicyAttrs));

      llvm::Function *F = CGM.getIntrinsic(ID, IntrinsicTypes);

      llvm::Value *LoadValue = Builder.CreateCall(F, Operands, "");
      if (ReturnValue.isNull())
        return LoadValue;
      else
        return Builder.CreateStore(LoadValue, ReturnValue.getValue());
    }
    }] in {
        defvar T = "(Tuple:" # nf # ")";
        def : RVVBuiltin<T # "v", T # "vPCe", type>;
        if !not(IsFloat<type>.val) then {
          def : RVVBuiltin<T # "Uv", T # "UvPCUe", type>;
        }
      }
    }
  }
}

// 7.5.1 Vector Unit-stride Segment Stores (Zvlsseg)
multiclass RVVUSSegStoreEEW<string ir, list<string> types> {
  foreach type = types in {
    defvar eew = !cond(!eq(type, "c") : "8",
                       !eq(type, "s") : "16",
                       !eq(type, "i") : "32",
                       !eq(type, "l") : "64",
                       !eq(type, "x") : "16",
                       !eq(type, "f") : "32",
                       !eq(type, "d") : "64");
      foreach nf = NFList in {
      let Name = ir # nf # "e" # eew # "_v",
          IRName = ir # nf # "e",
          MaskedIRName = ir # nf # "e" # "_mask",
          NF = nf,
          HasMaskedOffOperand = false,
          ManualCodegen = [{
    {
      // Masked
      // Builtin: (mask, ptr, v_tuple, vl)
      // Intrinsic: (val0, val1, ..., ptr, mask, vl)
      // Unmasked
      // Builtin: (ptr, v_tuple, vl)
      // Intrinsic: (val0, val1, ..., ptr, vl)
      unsigned Offset = IsMasked ? 1 : 0;
      llvm::Value *VTupleOperand = Ops[Offset + 1];

      SmallVector<llvm::Value*, 12> Operands;
      for (unsigned I = 0; I < NF; ++I) {
        llvm::Value *V = Builder.CreateExtractValue(VTupleOperand, {I});
        Operands.push_back(V);
      }
      Operands.push_back(Ops[Offset]); // Ptr
      if (IsMasked)
        Operands.push_back(Ops[0]);
      Operands.push_back(Ops[Offset + 2]); // VL

      IntrinsicTypes = {Operands[0]->getType(), Operands.back()->getType()};
      llvm::Function *F = CGM.getIntrinsic(ID, IntrinsicTypes);
      return Builder.CreateCall(F, Operands, "");
   }
      }] in {
        defvar T = "(Tuple:" # nf # ")";
        def : RVVBuiltin<T # "v", "0Pe" # T # "v", type>;
        if !not(IsFloat<type>.val) then {
          def : RVVBuiltin<T # "Uv", "0PUe" # T # "Uv", type>;
        }
      }
    }
  }
}

// 7.5.1 Vector Unit-stride Segment Loads Fault-Only-First  (Zvlsseg)
multiclass RVVUSSegLoadEEWFF<string ir, list<string> types> {
  foreach type = types in {
    defvar eew = !cond(!eq(type, "c") : "8",
                       !eq(type, "s") : "16",
                       !eq(type, "i") : "32",
                       !eq(type, "l") : "64",
                       !eq(type, "x") : "16",
                       !eq(type, "f") : "32",
                       !eq(type, "d") : "64");
      foreach nf = NFList in {
        let Name = ir # nf # "e" # eew # "ff_v",
            IRName = ir # nf # "eff",
            MaskedIRName = ir # nf # "eff_mask",
            NF = nf,
            ManualCodegen = [{
    {
      llvm::Type *ElementVectorType = cast<StructType>(ResultType)->elements()[0];
      IntrinsicTypes = {ElementVectorType, Ops.back()->getType()};
      SmallVector<llvm::Value*, 12> Operands;

      bool NoPassthru =
        (IsMasked && (PolicyAttrs & RVV_VTA) && (PolicyAttrs & RVV_VMA)) |
        (!IsMasked && (PolicyAttrs & RVV_VTA));
      unsigned Offset = IsMasked ? NoPassthru ? 1 : 2 : NoPassthru ? 0 : 1;

      if (NoPassthru) { // Push poison into passthru
        Operands.append(NF, llvm::PoisonValue::get(ElementVectorType));
      } else { // Push intrinsics operands into passthru
        llvm::Value *PassthruOperand = IsMasked ? Ops[1] : Ops[0];
        for (unsigned I = 0; I < NF; ++I)
          Operands.push_back(Builder.CreateExtractValue(PassthruOperand, {I}));
      }

      Operands.push_back(Ops[Offset]); // Ptr
      if (IsMasked)
        Operands.push_back(Ops[0]);
      Operands.push_back(Ops[Offset + 2]); // vl
      if (IsMasked)
        Operands.push_back(ConstantInt::get(Ops.back()->getType(), PolicyAttrs));

      llvm::Function *F = CGM.getIntrinsic(ID, IntrinsicTypes);

      llvm::Value *LoadValue = Builder.CreateCall(F, Operands, "");
      // Get alignment from the new vl operand
      clang::CharUnits Align =
          CGM.getNaturalPointeeTypeAlignment(E->getArg(Offset + 1)->getType());

      llvm::Value *ReturnTuple = llvm::PoisonValue::get(ResultType);
      for (unsigned I = 0; I < NF; ++I) {
        llvm::Value *V = Builder.CreateExtractValue(LoadValue, {I});
        ReturnTuple = Builder.CreateInsertValue(ReturnTuple, V, {I});
      }

      // Store new_vl
      llvm::Value *V = Builder.CreateExtractValue(LoadValue, {NF});
      Builder.CreateStore(V, Address(Ops[Offset + 1], V->getType(), Align));

      if (ReturnValue.isNull())
        return ReturnTuple;
      else
        return Builder.CreateStore(ReturnTuple, ReturnValue.getValue());
    }
    }] in {
        defvar T = "(Tuple:" # nf # ")";
        def : RVVBuiltin<T # "v", T # "vPCePz", type>;
        if !not(IsFloat<type>.val) then {
          def : RVVBuiltin<T # "Uv", T # "UvPCUePz", type>;
        }
      }
    }
  }
}

// 7.5. Vector Load/Store Segment Operations (Zvlsseg)

let UnMaskedPolicyScheme = HasPassthruOperand,
    IsTuple = true in {
  defm : RVVUSSegLoadEEW<"th_vlseg", TypeList>;
  defm : RVVUSSegLoadEEWFF<"th_vlseg", TypeList>;

  // TODO: indexed segment load
  // defm : RVVSSegLoadEEW<"th_vlsseg", TypeList>;
}

let UnMaskedPolicyScheme = NonePolicy,
    MaskedPolicyScheme = NonePolicy,
    IsTuple = true in {
  defm : RVVUSSegStoreEEW<"th_vsseg", TypeList>;

  // TODO: indexed segment store
  // defm : RVVSSegStoreEEW<"th_vssseg", TypeList>;
}

//===----------------------------------------------------------------------===//
// 12. Vector Integer Arithmetic Operations
//===----------------------------------------------------------------------===//

let UnMaskedPolicyScheme = HasPassthruOperand in {
  defm th_vadd : RVVIntBinBuiltinSet;
}

include "riscv_vector_xtheadv_wrappers.td"
