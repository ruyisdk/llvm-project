# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vsll.vv v8, v4, v20, v0.t
# CHECK-INST: th.vsll.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x94]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 944a0457 <unknown>

th.vsll.vv v8, v4, v20
# CHECK-INST: th.vsll.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x96]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 964a0457 <unknown>

th.vsll.vx v8, v4, a0, v0.t
# CHECK-INST: th.vsll.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x94]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 94454457 <unknown>

th.vsll.vx v8, v4, a0
# CHECK-INST: th.vsll.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x96]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 96454457 <unknown>

th.vsll.vi v8, v4, 31, v0.t
# CHECK-INST: th.vsll.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0x94]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 944fb457 <unknown>

th.vsll.vi v8, v4, 31
# CHECK-INST: th.vsll.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0x96]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 964fb457 <unknown>

th.vsrl.vv v8, v4, v20, v0.t
# CHECK-INST: th.vsrl.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a04a0457 <unknown>

th.vsrl.vv v8, v4, v20
# CHECK-INST: th.vsrl.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a24a0457 <unknown>

th.vsrl.vx v8, v4, a0, v0.t
# CHECK-INST: th.vsrl.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0454457 <unknown>

th.vsrl.vx v8, v4, a0
# CHECK-INST: th.vsrl.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2454457 <unknown>

th.vsrl.vi v8, v4, 31, v0.t
# CHECK-INST: th.vsrl.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a04fb457 <unknown>

th.vsrl.vi v8, v4, 31
# CHECK-INST: th.vsrl.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a24fb457 <unknown>

th.vsra.vv v8, v4, v20, v0.t
# CHECK-INST: th.vsra.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xa4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a44a0457 <unknown>

th.vsra.vv v8, v4, v20
# CHECK-INST: th.vsra.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xa6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a64a0457 <unknown>

th.vsra.vx v8, v4, a0, v0.t
# CHECK-INST: th.vsra.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xa4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a4454457 <unknown>

th.vsra.vx v8, v4, a0
# CHECK-INST: th.vsra.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xa6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a6454457 <unknown>

th.vsra.vi v8, v4, 31, v0.t
# CHECK-INST: th.vsra.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xa4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a44fb457 <unknown>

th.vsra.vi v8, v4, 31
# CHECK-INST: th.vsra.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xa6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a64fb457 <unknown>

th.vnsrl.vv v8, v4, v20, v0.t
# CHECK-INST: th.vnsrl.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b04a0457 <unknown>

th.vnsrl.vv v4, v4, v20, v0.t
# CHECK-INST: th.vnsrl.vv v4, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x02,0x4a,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b04a0257 <unknown>

th.vnsrl.vv v8, v4, v20
# CHECK-INST: th.vnsrl.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xb2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b24a0457 <unknown>

th.vnsrl.vx v8, v4, a0, v0.t
# CHECK-INST: th.vnsrl.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b0454457 <unknown>

th.vnsrl.vx v8, v4, a0
# CHECK-INST: th.vnsrl.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xb2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b2454457 <unknown>

th.vnsrl.vi v8, v4, 31, v0.t
# CHECK-INST: th.vnsrl.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b04fb457 <unknown>

th.vnsrl.vi v8, v4, 31
# CHECK-INST: th.vnsrl.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xb2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b24fb457 <unknown>

th.vnsra.vv v8, v4, v20, v0.t
# CHECK-INST: th.vnsra.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xb4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b44a0457 <unknown>

th.vnsra.vv v8, v4, v20
# CHECK-INST: th.vnsra.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xb6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b64a0457 <unknown>

th.vnsra.vx v8, v4, a0, v0.t
# CHECK-INST: th.vnsra.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xb4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b4454457 <unknown>

th.vnsra.vx v8, v4, a0
# CHECK-INST: th.vnsra.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xb6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b6454457 <unknown>

th.vnsra.vi v8, v4, 31, v0.t
# CHECK-INST: th.vnsra.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xb4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b44fb457 <unknown>

th.vnsra.vi v8, v4, 31
# CHECK-INST: th.vnsra.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xb6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b64fb457 <unknown>

th.vssrl.vv v8, v4, v20, v0.t
# CHECK-INST: th.vssrl.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a84a0457 <unknown>

th.vssrl.vv v8, v4, v20
# CHECK-INST: th.vssrl.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aa4a0457 <unknown>

th.vssrl.vx v8, v4, a0, v0.t
# CHECK-INST: th.vssrl.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8454457 <unknown>

th.vssrl.vx v8, v4, a0
# CHECK-INST: th.vssrl.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aa454457 <unknown>

th.vssrl.vi v8, v4, 31, v0.t
# CHECK-INST: th.vssrl.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a84fb457 <unknown>

th.vssrl.vi v8, v4, 31
# CHECK-INST: th.vssrl.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aa4fb457 <unknown>

th.vssra.vv v8, v4, v20, v0.t
# CHECK-INST: th.vssra.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac4a0457 <unknown>

th.vssra.vv v8, v4, v20
# CHECK-INST: th.vssra.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae4a0457 <unknown>

th.vssra.vx v8, v4, a0, v0.t
# CHECK-INST: th.vssra.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac454457 <unknown>

th.vssra.vx v8, v4, a0
# CHECK-INST: th.vssra.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae454457 <unknown>

th.vssra.vi v8, v4, 31, v0.t
# CHECK-INST: th.vssra.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac4fb457 <unknown>

th.vssra.vi v8, v4, 31
# CHECK-INST: th.vssra.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae4fb457 <unknown>
