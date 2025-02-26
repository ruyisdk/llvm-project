# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vminu.vv v8, v4, v20, v0.t
# CHECK-INST: th.vminu.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x10]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 104a0457 <unknown>

th.vminu.vv v8, v4, v20
# CHECK-INST: th.vminu.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x12]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 124a0457 <unknown>

th.vminu.vx v8, v4, a0, v0.t
# CHECK-INST: th.vminu.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x10]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 10454457 <unknown>

th.vminu.vx v8, v4, a0
# CHECK-INST: th.vminu.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x12]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 12454457 <unknown>

th.vmin.vv v8, v4, v20, v0.t
# CHECK-INST: th.vmin.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x14]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 144a0457 <unknown>

th.vmin.vv v8, v4, v20
# CHECK-INST: th.vmin.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x16]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 164a0457 <unknown>

th.vmin.vx v8, v4, a0, v0.t
# CHECK-INST: th.vmin.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x14]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 14454457 <unknown>

th.vmin.vx v8, v4, a0
# CHECK-INST: th.vmin.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x16]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 16454457 <unknown>

th.vmaxu.vv v8, v4, v20, v0.t
# CHECK-INST: th.vmaxu.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x18]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 184a0457 <unknown>

th.vmaxu.vv v8, v4, v20
# CHECK-INST: th.vmaxu.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x1a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1a4a0457 <unknown>

th.vmaxu.vx v8, v4, a0, v0.t
# CHECK-INST: th.vmaxu.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x18]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 18454457 <unknown>

th.vmaxu.vx v8, v4, a0
# CHECK-INST: th.vmaxu.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x1a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1a454457 <unknown>

th.vmax.vv v8, v4, v20, v0.t
# CHECK-INST: th.vmax.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c4a0457 <unknown>

th.vmax.vv v8, v4, v20
# CHECK-INST: th.vmax.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e4a0457 <unknown>

th.vmax.vx v8, v4, a0, v0.t
# CHECK-INST: th.vmax.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c454457 <unknown>

th.vmax.vx v8, v4, a0
# CHECK-INST: th.vmax.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e454457 <unknown>
