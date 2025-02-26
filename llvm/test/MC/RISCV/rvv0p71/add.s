# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vadd.vv v8, v4, v20, v0.t
# CHECK-INST: th.vadd.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 004a0457 <unknown>

th.vadd.vv v8, v4, v20
# CHECK-INST: th.vadd.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 024a0457 <unknown>

th.vadd.vx v8, v4, a0, v0.t
# CHECK-INST: th.vadd.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 00454457 <unknown>

th.vadd.vx v8, v4, a0
# CHECK-INST: th.vadd.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 02454457 <unknown>

th.vadd.vi v8, v4, 15, v0.t
# CHECK-INST: th.vadd.vi v8, v4, 15, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x47,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0047b457 <unknown>

th.vadd.vi v8, v4, 15
# CHECK-INST: th.vadd.vi v8, v4, 15
# CHECK-ENCODING: [0x57,0xb4,0x47,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0247b457 <unknown>

th.vwaddu.vv v8, v4, v20, v0.t
# CHECK-INST: th.vwaddu.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c04a2457 <unknown>

th.vwaddu.vv v8, v4, v20
# CHECK-INST: th.vwaddu.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c24a2457 <unknown>

th.vwaddu.vx v8, v4, a0, v0.t
# CHECK-INST: th.vwaddu.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0456457 <unknown>

th.vwaddu.vx v8, v4, a0
# CHECK-INST: th.vwaddu.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x64,0x45,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2456457 <unknown>

th.vwadd.vv v8, v4, v20, v0.t
# CHECK-INST: th.vwadd.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xc4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c44a2457 <unknown>

th.vwadd.vv v8, v4, v20
# CHECK-INST: th.vwadd.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0xc6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c64a2457 <unknown>

th.vwadd.vx v8, v4, a0, v0.t
# CHECK-INST: th.vwadd.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xc4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c4456457 <unknown>

th.vwadd.vx v8, v4, a0
# CHECK-INST: th.vwadd.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x64,0x45,0xc6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c6456457 <unknown>

th.vwaddu.wv v8, v4, v20, v0.t
# CHECK-INST: th.vwaddu.wv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xd0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d04a2457 <unknown>

th.vwaddu.wv v8, v4, v20
# CHECK-INST: th.vwaddu.wv v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0xd2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d24a2457 <unknown>

th.vwaddu.wx v8, v4, a0, v0.t
# CHECK-INST: th.vwaddu.wx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xd0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d0456457 <unknown>

th.vwaddu.wx v8, v4, a0
# CHECK-INST: th.vwaddu.wx v8, v4, a0
# CHECK-ENCODING: [0x57,0x64,0x45,0xd2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d2456457 <unknown>

th.vwadd.wv v8, v4, v20, v0.t
# CHECK-INST: th.vwadd.wv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0xd4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d44a2457 <unknown>

th.vwadd.wv v8, v4, v20
# CHECK-INST: th.vwadd.wv v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0xd6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d64a2457 <unknown>

th.vwadd.wx v8, v4, a0, v0.t
# CHECK-INST: th.vwadd.wx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x64,0x45,0xd4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d4456457 <unknown>

th.vwadd.wx v8, v4, a0
# CHECK-INST: th.vwadd.wx v8, v4, a0
# CHECK-ENCODING: [0x57,0x64,0x45,0xd6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d6456457 <unknown>

th.vadc.vvm v8, v4, v20, v0
# CHECK-INST: th.vadc.vvm v8, v4, v20, v0
# CHECK-ENCODING: [0x57,0x04,0x4a,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 424a0457 <unknown>

th.vadc.vvm v4, v4, v20, v0
# CHECK-INST: th.vadc.vvm v4, v4, v20, v0
# CHECK-ENCODING: [0x57,0x02,0x4a,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 424a0257 <unknown>

th.vadc.vvm v8, v4, v8, v0
# CHECK-INST: th.vadc.vvm v8, v4, v8, v0
# CHECK-ENCODING: [0x57,0x04,0x44,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42440457 <unknown>

th.vadc.vxm v8, v4, a0, v0
# CHECK-INST: th.vadc.vxm v8, v4, a0, v0
# CHECK-ENCODING: [0x57,0x44,0x45,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42454457 <unknown>

th.vadc.vim v8, v4, 15, v0
# CHECK-INST: th.vadc.vim v8, v4, 15, v0
# CHECK-ENCODING: [0x57,0xb4,0x47,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4247b457 <unknown>

th.vmadc.vvm v8, v4, v20, v0
# CHECK-INST: th.vmadc.vvm v8, v4, v20, v0
# CHECK-ENCODING: [0x57,0x04,0x4a,0x46]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 464a0457 <unknown>

th.vmadc.vvm v4, v4, v20, v0
# CHECK-INST: th.vmadc.vvm v4, v4, v20, v0
# CHECK-ENCODING: [0x57,0x02,0x4a,0x46]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 464a0257 <unknown>

th.vmadc.vvm v8, v4, v8, v0
# CHECK-INST: th.vmadc.vvm v8, v4, v8, v0
# CHECK-ENCODING: [0x57,0x04,0x44,0x46]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 46440457 <unknown>

th.vmadc.vxm v8, v4, a0, v0
# CHECK-INST: th.vmadc.vxm v8, v4, a0, v0
# CHECK-ENCODING: [0x57,0x44,0x45,0x46]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 46454457 <unknown>

th.vmadc.vim v8, v4, 15, v0
# CHECK-INST: th.vmadc.vim v8, v4, 15, v0
# CHECK-ENCODING: [0x57,0xb4,0x47,0x46]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4647b457 <unknown>

th.vsaddu.vv v8, v4, v20, v0.t
# CHECK-INST: th.vsaddu.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 804a0457 <unknown>

th.vsaddu.vv v8, v4, v20
# CHECK-INST: th.vsaddu.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 824a0457 <unknown>

th.vsaddu.vx v8, v4, a0, v0.t
# CHECK-INST: th.vsaddu.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80454457 <unknown>

th.vsaddu.vx v8, v4, a0
# CHECK-INST: th.vsaddu.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82454457 <unknown>

th.vsaddu.vi v8, v4, 15, v0.t
# CHECK-INST: th.vsaddu.vi v8, v4, 15, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x47,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8047b457 <unknown>

th.vsaddu.vi v8, v4, 15
# CHECK-INST: th.vsaddu.vi v8, v4, 15
# CHECK-ENCODING: [0x57,0xb4,0x47,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8247b457 <unknown>

th.vsadd.vv v8, v4, v20, v0.t
# CHECK-INST: th.vsadd.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x84]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 844a0457 <unknown>

th.vsadd.vv v8, v4, v20
# CHECK-INST: th.vsadd.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x86]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 864a0457 <unknown>

th.vsadd.vx v8, v4, a0, v0.t
# CHECK-INST: th.vsadd.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x84]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 84454457 <unknown>

th.vsadd.vx v8, v4, a0
# CHECK-INST: th.vsadd.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x86]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 86454457 <unknown>

th.vsadd.vi v8, v4, 15, v0.t
# CHECK-INST: th.vsadd.vi v8, v4, 15, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x47,0x84]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8447b457 <unknown>

th.vsadd.vi v8, v4, 15
# CHECK-INST: th.vsadd.vi v8, v4, 15
# CHECK-ENCODING: [0x57,0xb4,0x47,0x86]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8647b457 <unknown>

th.vaadd.vv v8, v4, v20, v0.t
# CHECK-INST: th.vaadd.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0x90]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 904a0457 <unknown>

th.vaadd.vv v8, v4, v20
# CHECK-INST: th.vaadd.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0x92]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 924a0457 <unknown>

th.vaadd.vx v8, v4, a0, v0.t
# CHECK-INST: th.vaadd.vx v8, v4, a0, v0.t
# CHECK-ENCODING: [0x57,0x44,0x45,0x90]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 90454457 <unknown>

th.vaadd.vx v8, v4, a0
# CHECK-INST: th.vaadd.vx v8, v4, a0
# CHECK-ENCODING: [0x57,0x44,0x45,0x92]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 92454457 <unknown>

th.vaadd.vi v8, v4, 15, v0.t
# CHECK-INST: th.vaadd.vi v8, v4, 15, v0.t
# CHECK-ENCODING: [0x57,0xb4,0x47,0x90]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9047b457 <unknown>

th.vaadd.vi v8, v4, 15
# CHECK-INST: th.vaadd.vi v8, v4, 15
# CHECK-ENCODING: [0x57,0xb4,0x47,0x92]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9247b457 <unknown>
