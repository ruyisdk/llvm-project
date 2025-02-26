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

th.vfmin.vv v8, v4, v20, v0.t
# CHECK-INST: th.vfmin.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x10]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 104a1457 <unknown>

th.vfmin.vv v8, v4, v20
# CHECK-INST: th.vfmin.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x12]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 124a1457 <unknown>

th.vfmin.vf v8, v4, fa0, v0.t
# CHECK-INST: th.vfmin.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x10]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 10455457 <unknown>

th.vfmin.vf v8, v4, fa0
# CHECK-INST: th.vfmin.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x12]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 12455457 <unknown>

th.vfmax.vv v8, v4, v20, v0.t
# CHECK-INST: th.vfmax.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x18]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 184a1457 <unknown>

th.vfmax.vv v8, v4, v20
# CHECK-INST: th.vfmax.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x1a]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1a4a1457 <unknown>

th.vfmax.vf v8, v4, fa0, v0.t
# CHECK-INST: th.vfmax.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x18]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 18455457 <unknown>

th.vfmax.vf v8, v4, fa0
# CHECK-INST: th.vfmax.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x1a]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1a455457 <unknown>
