# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:         --mattr=+f \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:         --mattr=+f \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex --mattr=+f - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:         --mattr=+f \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vfmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xb0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b04a1457 <unknown>

th.vfmacc.vv v8, v20, v4
# CHECK-INST: th.vfmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xb2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b24a1457 <unknown>

th.vfmacc.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfmacc.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xb0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b0455457 <unknown>

th.vfmacc.vf v8, fa0, v4
# CHECK-INST: th.vfmacc.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xb2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b2455457 <unknown>

th.vfnmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfnmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xb4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b44a1457 <unknown>

th.vfnmacc.vv v8, v20, v4
# CHECK-INST: th.vfnmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xb6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b64a1457 <unknown>

th.vfnmacc.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfnmacc.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xb4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b4455457 <unknown>

th.vfnmacc.vf v8, fa0, v4
# CHECK-INST: th.vfnmacc.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xb6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b6455457 <unknown>

th.vfmsac.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfmsac.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xb8]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b84a1457 <unknown>

th.vfmsac.vv v8, v20, v4
# CHECK-INST: th.vfmsac.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xba]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ba4a1457 <unknown>

th.vfmsac.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfmsac.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xb8]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b8455457 <unknown>

th.vfmsac.vf v8, fa0, v4
# CHECK-INST: th.vfmsac.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xba]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ba455457 <unknown>

th.vfnmsac.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfnmsac.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xbc]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc4a1457 <unknown>

th.vfnmsac.vv v8, v20, v4
# CHECK-INST: th.vfnmsac.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xbe]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be4a1457 <unknown>

th.vfnmsac.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfnmsac.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xbc]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc455457 <unknown>

th.vfnmsac.vf v8, fa0, v4
# CHECK-INST: th.vfnmsac.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xbe]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be455457 <unknown>

th.vfmadd.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfmadd.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xa0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a04a1457 <unknown>

th.vfmadd.vv v8, v20, v4
# CHECK-INST: th.vfmadd.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xa2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a24a1457 <unknown>

th.vfmadd.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfmadd.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xa0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0455457 <unknown>

th.vfmadd.vf v8, fa0, v4
# CHECK-INST: th.vfmadd.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xa2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2455457 <unknown>

th.vfnmadd.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfnmadd.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xa4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a44a1457 <unknown>

th.vfnmadd.vv v8, v20, v4
# CHECK-INST: th.vfnmadd.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xa6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a64a1457 <unknown>

th.vfnmadd.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfnmadd.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xa4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a4455457 <unknown>

th.vfnmadd.vf v8, fa0, v4
# CHECK-INST: th.vfnmadd.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xa6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a6455457 <unknown>

th.vfmsub.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfmsub.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xa8]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a84a1457 <unknown>

th.vfmsub.vv v8, v20, v4
# CHECK-INST: th.vfmsub.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xaa]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aa4a1457 <unknown>

th.vfmsub.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfmsub.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xa8]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8455457 <unknown>

th.vfmsub.vf v8, fa0, v4
# CHECK-INST: th.vfmsub.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xaa]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aa455457 <unknown>

th.vfnmsub.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfnmsub.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xac]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac4a1457 <unknown>

th.vfnmsub.vv v8, v20, v4
# CHECK-INST: th.vfnmsub.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xae]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae4a1457 <unknown>

th.vfnmsub.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfnmsub.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac455457 <unknown>

th.vfnmsub.vf v8, fa0, v4
# CHECK-INST: th.vfnmsub.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae455457 <unknown>

th.vfwmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfwmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xf0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f04a1457 <unknown>

th.vfwmacc.vv v8, v20, v4
# CHECK-INST: th.vfwmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xf2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f24a1457 <unknown>

th.vfwmacc.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfwmacc.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xf0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f0455457 <unknown>

th.vfwmacc.vf v8, fa0, v4
# CHECK-INST: th.vfwmacc.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xf2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f2455457 <unknown>

th.vfwnmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfwnmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xf4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f44a1457 <unknown>

th.vfwnmacc.vv v8, v20, v4
# CHECK-INST: th.vfwnmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xf6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f64a1457 <unknown>

th.vfwnmacc.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfwnmacc.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xf4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f4455457 <unknown>

th.vfwnmacc.vf v8, fa0, v4
# CHECK-INST: th.vfwnmacc.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xf6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f6455457 <unknown>

th.vfwmsac.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfwmsac.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xf8]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f84a1457 <unknown>

th.vfwmsac.vv v8, v20, v4
# CHECK-INST: th.vfwmsac.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xfa]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fa4a1457 <unknown>

th.vfwmsac.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfwmsac.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xf8]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f8455457 <unknown>

th.vfwmsac.vf v8, fa0, v4
# CHECK-INST: th.vfwmsac.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xfa]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fa455457 <unknown>

th.vfwnmsac.vv v8, v20, v4, v0.t
# CHECK-INST: th.vfwnmsac.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xfc]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc4a1457 <unknown>

th.vfwnmsac.vv v8, v20, v4
# CHECK-INST: th.vfwnmsac.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x14,0x4a,0xfe]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe4a1457 <unknown>

th.vfwnmsac.vf v8, fa0, v4, v0.t
# CHECK-INST: th.vfwnmsac.vf v8, fa0, v4, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xfc]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc455457 <unknown>

th.vfwnmsac.vf v8, fa0, v4
# CHECK-INST: th.vfwnmsac.vf v8, fa0, v4
# CHECK-ENCODING: [0x57,0x54,0x45,0xfe]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe455457 <unknown>
