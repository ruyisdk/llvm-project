# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xb4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b44a2457 <unknown>

th.vmacc.vv v8, v20, v4
# CHECK-INST: th.vmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xb6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b64a2457 <unknown>

th.vmacc.vx v8, a0, v4, v0.t
# CHECK-INST: th.vmacc.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xb4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b4456457 <unknown>

th.vmacc.vx v8, a0, v4
# CHECK-INST: th.vmacc.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xb6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b6456457 <unknown>

th.vnmsac.vv v8, v20, v4, v0.t
# CHECK-INST: th.vnmsac.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc4a2457 <unknown>

th.vnmsac.vv v8, v20, v4
# CHECK-INST: th.vnmsac.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be4a2457 <unknown>

th.vnmsac.vx v8, a0, v4, v0.t
# CHECK-INST: th.vnmsac.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc456457 <unknown>

th.vnmsac.vx v8, a0, v4
# CHECK-INST: th.vnmsac.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be456457 <unknown>

th.vmadd.vv v8, v20, v4, v0.t
# CHECK-INST: th.vmadd.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xa4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a44a2457 <unknown>

th.vmadd.vv v8, v20, v4
# CHECK-INST: th.vmadd.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xa6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a64a2457 <unknown>

th.vmadd.vx v8, a0, v4, v0.t
# CHECK-INST: th.vmadd.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xa4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a4456457 <unknown>

th.vmadd.vx v8, a0, v4
# CHECK-INST: th.vmadd.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xa6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a6456457 <unknown>

th.vnmsub.vv v8, v20, v4, v0.t
# CHECK-INST: th.vnmsub.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac4a2457 <unknown>

th.vnmsub.vv v8, v20, v4
# CHECK-INST: th.vnmsub.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae4a2457 <unknown>

th.vnmsub.vx v8, a0, v4, v0.t
# CHECK-INST: th.vnmsub.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac456457 <unknown>

th.vnmsub.vx v8, a0, v4
# CHECK-INST: th.vnmsub.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae456457 <unknown>

th.vwmaccu.vv v8, v20, v4, v0.t
# CHECK-INST: th.vwmaccu.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f04a2457 <unknown>

th.vwmaccu.vv v8, v20, v4
# CHECK-INST: th.vwmaccu.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f24a2457 <unknown>

th.vwmaccu.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwmaccu.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f0456457 <unknown>

th.vwmaccu.vx v8, a0, v4
# CHECK-INST: th.vwmaccu.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f2456457 <unknown>

th.vwmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vwmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xf4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f44a2457 <unknown>

th.vwmacc.vv v8, v20, v4
# CHECK-INST: th.vwmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xf6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f64a2457 <unknown>

th.vwmacc.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwmacc.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xf4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f4456457 <unknown>

th.vwmacc.vx v8, a0, v4
# CHECK-INST: th.vwmacc.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xf6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f6456457 <unknown>

th.vwmaccsu.vv v8, v20, v4, v0.t
# CHECK-INST: th.vwmaccsu.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f84a2457 <unknown>

th.vwmaccsu.vv v8, v20, v4
# CHECK-INST: th.vwmaccsu.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x24,0x4a,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fa4a2457 <unknown>

th.vwmaccsu.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwmaccsu.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f8456457 <unknown>

th.vwmaccsu.vx v8, a0, v4
# CHECK-INST: th.vwmaccsu.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fa456457 <unknown>

th.vwmaccus.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwmaccus.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xfc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc456457 <unknown>

th.vwmaccus.vx v8, a0, v4
# CHECK-INST: th.vwmaccus.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x64,0x45,0xfe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe456457 <unknown>

th.vwsmaccu.vv v8, v20, v4, v0.t
# CHECK-INST: th.vwsmaccu.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f04a0457 <unknown>

th.vwsmaccu.vv v8, v20, v4
# CHECK-INST: th.vwsmaccu.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x04,0x4a,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f24a0457 <unknown>

th.vwsmaccu.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwsmaccu.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f0454457 <unknown>

th.vwsmaccu.vx v8, a0, v4
# CHECK-INST: th.vwsmaccu.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x44,0x45,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f2454457 <unknown>

th.vwsmacc.vv v8, v20, v4, v0.t
# CHECK-INST: th.vwsmacc.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xf4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f44a0457 <unknown>

th.vwsmacc.vv v8, v20, v4
# CHECK-INST: th.vwsmacc.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x04,0x4a,0xf6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f64a0457 <unknown>

th.vwsmacc.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwsmacc.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xf4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f4454457 <unknown>

th.vwsmacc.vx v8, a0, v4
# CHECK-INST: th.vwsmacc.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x44,0x45,0xf6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f6454457 <unknown>

th.vwsmaccsu.vv v8, v20, v4, v0.t
# CHECK-INST: th.vwsmaccsu.vv v8, v20, v4, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f84a0457 <unknown>

th.vwsmaccsu.vv v8, v20, v4
# CHECK-INST: th.vwsmaccsu.vv v8, v20, v4
# CHECK-ENCODING: [0x57,0x04,0x4a,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fa4a0457 <unknown>

th.vwsmaccsu.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwsmaccsu.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f8454457 <unknown>

th.vwsmaccsu.vx v8, a0, v4
# CHECK-INST: th.vwsmaccsu.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x44,0x45,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fa454457 <unknown>

th.vwsmaccus.vx v8, a0, v4, v0.t
# CHECK-INST: th.vwsmaccus.vx v8, a0, v4, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0xfc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc454457 <unknown>

th.vwsmaccus.vx v8, a0, v4
# CHECK-INST: th.vwsmaccus.vx v8, a0, v4
# CHECK-ENCODING: [0x57,0x44,0x45,0xfe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe454457 <unknown>