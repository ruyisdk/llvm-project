# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

vnclipu.vv v8, v4, v20, v0.t
# CHECK-INST: vnclipu.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xb8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 04 4a b8 <unknown>

vnclipu.vv v8, v4, v20
# CHECK-INST: vnclipu.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xba]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 04 4a ba <unknown>

vnclipu.vx v8, v4, a0, v0.t
# CHECK-INST: vnclipu.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xb8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 44 45 b8 <unknown>

vnclipu.vx v8, v4, a0
# CHECK-INST: vnclipu.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xba]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 44 45 ba <unknown>

vnclipu.vi v8, v4, 31, v0.t
# CHECK-INST: vnclipu.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xb8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 b4 4f b8 <unknown>

vnclipu.vi v8, v4, 31
# CHECK-INST: vnclipu.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xba]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 b4 4f ba <unknown>

vnclip.vv v8, v4, v20, v0.t
# CHECK-INST: vnclip.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xbc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 04 4a bc <unknown>

vnclip.vv v8, v4, v20
# CHECK-INST: vnclip.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xbe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 04 4a be <unknown>

vnclip.vx v8, v4, a0, v0.t
# CHECK-INST: vnclip.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xbc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 44 45 bc <unknown>

vnclip.vx v8, v4, a0
# CHECK-INST: vnclip.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0xbe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 44 45 be <unknown>

vnclip.vi v8, v4, 31, v0.t
# CHECK-INST: vnclip.vi v8, v4, 31, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xbc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 b4 4f bc <unknown>

vnclip.vi v8, v4, 31
# CHECK-INST: vnclip.vi v8, v4, 31
# CHECK-ENCODING: [0x57,0xb4,0x4f,0xbe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 b4 4f be <unknown>
