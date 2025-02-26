# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:         --mattr=+f --riscv-no-aliases \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:         --mattr=+f \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex --mattr=+f \
# RUN:        -M no-aliases - | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:         --mattr=+f \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vfredosum.vs v8, v4, v20, v0.t
# CHECK-INST: th.vfredosum.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x0c]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c4a1457 <unknown>

th.vfredosum.vs v8, v4, v20
# CHECK-INST: th.vfredosum.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x0e]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0e4a1457 <unknown>

th.vfredsum.vs v8, v4, v20, v0.t
# CHECK-INST: th.vfredsum.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x04]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 044a1457 <unknown>

th.vfredsum.vs v8, v4, v20
# CHECK-INST: th.vfredsum.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x06]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 064a1457 <unknown>

th.vfredmax.vs v8, v4, v20, v0.t
# CHECK-INST: th.vfredmax.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x1c]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c4a1457 <unknown>

th.vfredmax.vs v8, v4, v20
# CHECK-INST: th.vfredmax.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x1e]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e4a1457 <unknown>

th.vfredmin.vs v8, v4, v20, v0.t
# CHECK-INST: th.vfredmin.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x14]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 144a1457 <unknown>

th.vfredmin.vs v8, v4, v20
# CHECK-INST: th.vfredmin.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x16]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 164a1457 <unknown>

th.vfwredosum.vs v8, v4, v20, v0.t
# CHECK-INST: th.vfwredosum.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xcc]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc4a1457 <unknown>

th.vfwredosum.vs v8, v4, v20
# CHECK-INST: th.vfwredosum.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0xce]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce4a1457 <unknown>

th.vfwredsum.vs v8, v4, v20, v0.t
# CHECK-INST: th.vfwredsum.vs v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0xc4]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c44a1457 <unknown>

th.vfwredsum.vs v8, v4, v20
# CHECK-INST: th.vfwredsum.vs v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0xc6]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c64a1457 <unknown>

th.vfredosum.vs v0, v4, v20, v0.t
# CHECK-INST: th.vfredosum.vs v0, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x10,0x4a,0x0c]
# CHECK-ERROR: instruction requires the following: 'F' (Single-Precision Floating-Point), 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c4a1057 <unknown>
