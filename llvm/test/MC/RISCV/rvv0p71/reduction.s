# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vredsum.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredsum.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 004a2457 <unknown>

th.vredsum.vs v8, v4, v20
# CHECK-INST: th.vredsum.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 024a2457 <unknown>

th.vredmaxu.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredmaxu.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x18]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 184a2457 <unknown>

th.vredmaxu.vs v8, v4, v20
# CHECK-INST: th.vredmaxu.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x1a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1a4a2457 <unknown>

th.vredmax.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredmax.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c4a2457 <unknown>

th.vredmax.vs v8, v4, v20
# CHECK-INST: th.vredmax.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e4a2457 <unknown>

th.vredminu.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredminu.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x10]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 104a2457 <unknown>

th.vredminu.vs v8, v4, v20
# CHECK-INST: th.vredminu.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x12]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 124a2457 <unknown>

th.vredmin.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredmin.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x14]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 144a2457 <unknown>

th.vredmin.vs v8, v4, v20
# CHECK-INST: th.vredmin.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x16]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 164a2457 <unknown>

th.vredand.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredand.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x04]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 044a2457 <unknown>

th.vredand.vs v8, v4, v20
# CHECK-INST: th.vredand.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x06]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 064a2457 <unknown>

th.vredor.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredor.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x08]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 084a2457 <unknown>

th.vredor.vs v8, v4, v20
# CHECK-INST: th.vredor.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x0a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0a4a2457 <unknown>

th.vredxor.vs v8, v4, v20, v0.t
# CHECK-INST: th.vredxor.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x24,0x4a,0x0c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c4a2457 <unknown>

th.vredxor.vs v8, v4, v20
# CHECK-INST: th.vredxor.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x0e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0e4a2457 <unknown>

th.vwredsumu.vs v8, v4, v20, v0.t
# CHECK-INST: th.vwredsumu.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c04a0457 <unknown>

th.vwredsumu.vs v8, v4, v20
# CHECK-INST: th.vwredsumu.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c24a0457 <unknown>

th.vwredsum.vs v8, v4, v20, v0.t
# CHECK-INST: th.vwredsum.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x04,0x4a,0xc4]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c44a0457 <unknown>

th.vwredsum.vs v8, v4, v20
# CHECK-INST: th.vwredsum.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x04,0x4a,0xc6]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c64a0457 <unknown>

th.vredsum.vs v0, v4, v20, v0.t
# CHECK-INST: th.vredsum.vs v0, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x20,0x4a,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 004a2057 <unknown>
