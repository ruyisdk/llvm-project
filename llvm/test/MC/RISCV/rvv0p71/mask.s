# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vmand.mm v8, v4, v20
# CHECK-INST: th.vmand.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x66]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 664a2457 <unknown>

th.vmnand.mm v8, v4, v20
# CHECK-INST: th.vmnand.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x76]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 764a2457 <unknown>

th.vmandnot.mm v8, v4, v20
# CHECK-INST: th.vmandnot.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 624a2457 <unknown>

th.vmxor.mm v8, v4, v20
# CHECK-INST: th.vmxor.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e4a2457 <unknown>

th.vmor.mm v8, v4, v20
# CHECK-INST: th.vmor.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6a4a2457 <unknown>

th.vmnor.mm v8, v4, v20
# CHECK-INST: th.vmnor.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x7a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7a4a2457 <unknown>

th.vmornot.mm v8, v4, v20
# CHECK-INST: th.vmornot.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x72]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 724a2457 <unknown>

th.vmxnor.mm v8, v4, v20
# CHECK-INST: th.vmxnor.mm v8, v4, v20
# CHECK-ENCODING: [0x57,0x24,0x4a,0x7e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7e4a2457 <unknown>

th.vmpopc.m a2, v4, v0.t
# CHECK-INST: th.vmpopc.m a2, v4, v0.t
# CHECK-ENCODING: [0x57,0x26,0x40,0x50]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 50402657 <unknown>

th.vmpopc.m a2, v4
# CHECK-INST: th.vmpopc.m a2, v4
# CHECK-ENCODING: [0x57,0x26,0x40,0x52]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 52402657 <unknown>

th.vmfirst.m a2, v4, v0.t
# CHECK-INST: th.vmfirst.m a2, v4, v0.t
# CHECK-ENCODING: [0x57,0x26,0x40,0x54]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 54402657 <unknown>

th.vmfirst.m a2, v4
# CHECK-INST: th.vmfirst.m a2, v4
# CHECK-ENCODING: [0x57,0x26,0x40,0x56]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 56402657 <unknown>

th.vmsbf.m v8, v4, v0.t
# CHECK-INST: th.vmsbf.m v8, v4, v0.t
# CHECK-ENCODING: [0x57,0xa4,0x40,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5840a457 <unknown>

th.vmsbf.m v8, v4
# CHECK-INST: th.vmsbf.m v8, v4
# CHECK-ENCODING: [0x57,0xa4,0x40,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5a40a457 <unknown>

th.vmsif.m v8, v4, v0.t
# CHECK-INST: th.vmsif.m v8, v4, v0.t
# CHECK-ENCODING: [0x57,0xa4,0x41,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5841a457 <unknown>

th.vmsif.m v8, v4
# CHECK-INST: th.vmsif.m v8, v4
# CHECK-ENCODING: [0x57,0xa4,0x41,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5a41a457 <unknown>

th.vmsof.m v8, v4, v0.t
# CHECK-INST: th.vmsof.m v8, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x41,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 58412457 <unknown>

th.vmsof.m v8, v4
# CHECK-INST: th.vmsof.m v8, v4
# CHECK-ENCODING: [0x57,0x24,0x41,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5a412457 <unknown>

th.viota.m v8, v4, v0.t
# CHECK-INST: th.viota.m v8, v4, v0.t
# CHECK-ENCODING: [0x57,0x24,0x48,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 58482457 <unknown>

th.viota.m v8, v4
# CHECK-INST: th.viota.m v8, v4
# CHECK-ENCODING: [0x57,0x24,0x48,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5a482457 <unknown>

th.vid.v v8, v0.t
# CHECK-INST: th.vid.v v8, v0.t
# CHECK-ENCODING: [0x57,0xa4,0x08,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5808a457 <unknown>

th.vid.v v8
# CHECK-INST: th.vid.v v8
# CHECK-ENCODING: [0x57,0xa4,0x08,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5a08a457 <unknown>
