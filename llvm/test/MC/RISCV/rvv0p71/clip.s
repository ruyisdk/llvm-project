# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vnclipu.vv v8, v4, v20, v0.t
# CHECK-INST: th.vnclipu.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xb8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b84a0457 <unknown>

th.vnclipu.vv v8, v4, v20
# CHECK-INST: th.vnclipu.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xba]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ba4a0457 <unknown>

th.vnclipu.vx v8, v4, a0, v0.t
# CHECK-INST: th.vnclipu.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xb8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b8454457 <unknown>

th.vnclipu.vx v8, v4, a0
# CHECK-INST: th.vnclipu.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xba]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ba454457 <unknown>

th.vnclipu.vi v8, v4, 31, v0.t
# CHECK-INST: th.vnclipu.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xb8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b84fb457 <unknown>

th.vnclipu.vi v8, v4, 31
# CHECK-INST: th.vnclipu.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xba]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ba4fb457 <unknown>

th.vnclip.vv v8, v4, v20, v0.t
# CHECK-INST: th.vnclip.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc4a0457 <unknown>

th.vnclip.vv v8, v4, v20
# CHECK-INST: th.vnclip.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be4a0457 <unknown>

th.vnclip.vx v8, v4, a0, v0.t
# CHECK-INST: th.vnclip.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc454457 <unknown>

th.vnclip.vx v8, v4, a0
# CHECK-INST: th.vnclip.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be454457 <unknown>

th.vnclip.vi v8, v4, 31, v0.t
# CHECK-INST: th.vnclip.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc4fb457 <unknown>

th.vnclip.vi v8, v4, 31
# CHECK-INST: th.vnclip.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be4fb457 <unknown>
