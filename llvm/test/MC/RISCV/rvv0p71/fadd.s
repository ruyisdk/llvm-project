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

th.vfadd.vv v8, v4, v20, v0.t
# CHECK-INST: th.vfadd.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x00]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 004a1457 <unknown>

th.vfadd.vv v8, v4, v20
# CHECK-INST: th.vfadd.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x02]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 024a1457 <unknown>

th.vfadd.vf v8, v4, fa0, v0.t
# CHECK-INST: th.vfadd.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x00]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 00455457 <unknown>

th.vfadd.vf v8, v4, fa0
# CHECK-INST: th.vfadd.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x02]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 02455457 <unknown>

th.vfwadd.vv v8, v4, v20, v0.t
# CHECK-INST: th.vfwadd.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xc0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c04a1457 <unknown>

th.vfwadd.vv v8, v4, v20
# CHECK-INST: th.vfwadd.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0xc2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c24a1457 <unknown>

th.vfwadd.vf v8, v4, fa0, v0.t
# CHECK-INST: th.vfwadd.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xc0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0455457 <unknown>

th.vfwadd.vf v8, v4, fa0
# CHECK-INST: th.vfwadd.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0xc2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2455457 <unknown>

th.vfwadd.wv v8, v4, v20, v0.t
# CHECK-INST: th.vfwadd.wv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xd0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d04a1457 <unknown>

th.vfwadd.wv v8, v4, v20
# CHECK-INST: th.vfwadd.wv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0xd2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d24a1457 <unknown>

th.vfwadd.wf v8, v4, fa0, v0.t
# CHECK-INST: th.vfwadd.wf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0xd0]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d0455457 <unknown>

th.vfwadd.wf v8, v4, fa0
# CHECK-INST: th.vfwadd.wf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0xd2]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d2455457 <unknown>
