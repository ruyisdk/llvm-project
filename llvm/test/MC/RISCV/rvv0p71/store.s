# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:   --riscv-no-aliases | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:   | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex -M no-aliases - \
# RUN:   | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:   | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vsb.v v8, (a0), v0.t
# CHECK-INST: th.vsb.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 00050427 <unknown>

th.vsb.v v8, (a0)
# CHECK-INST: th.vsb.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 02050427 <unknown>

th.vsh.v v8, (a0), v0.t
# CHECK-INST: th.vsh.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 00055427 <unknown>

th.vsh.v v8, (a0)
# CHECK-INST: th.vsh.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 02055427 <unknown>

th.vsw.v v8, (a0), v0.t
# CHECK-INST: th.vsw.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 00056427 <unknown>

th.vsw.v v8, (a0)
# CHECK-INST: th.vsw.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 02056427 <unknown>

th.vse.v v8, (a0), v0.t
# CHECK-INST: th.vse.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x00]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 00057427 <unknown>

th.vse.v v8, (a0)
# CHECK-INST: th.vse.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x02]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 02057427 <unknown>

th.vssb.v	v8, (a0), a1
# CHECK-INST: th.vssb.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x0a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0ab50427 <unknown>

th.vssb.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssb.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x08]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 08b50427 <unknown>

th.vssh.v	v8, (a0), a1
# CHECK-INST: th.vssh.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x0a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0ab55427 <unknown>

th.vssh.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssh.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x08]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 08b55427 <unknown>

th.vssw.v	v8, (a0), a1
# CHECK-INST: th.vssw.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x0a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0ab56427 <unknown>

th.vssw.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssw.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x08]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 08b56427 <unknown>

th.vsse.v	v8, (a0), a1
# CHECK-INST: th.vsse.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x0a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0ab57427 <unknown>

th.vsse.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vsse.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x08]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 08b57427 <unknown>

th.vsxb.v	v8, (a0), v4
# CHECK-INST: th.vsxb.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x0e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0e450427 <unknown>

th.vsxb.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxb.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x0c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c450427 <unknown>

th.vsxh.v	v8, (a0), v4
# CHECK-INST: th.vsxh.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x0e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0e455427 <unknown>

th.vsxh.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxh.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x0c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c455427 <unknown>

th.vsxw.v	v8, (a0), v4
# CHECK-INST: th.vsxw.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x0e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0e456427 <unknown>

th.vsxw.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxw.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x0c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c456427 <unknown>

th.vsxe.v	v8, (a0), v4
# CHECK-INST: th.vsxe.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x0e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0e457427 <unknown>

th.vsxe.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxe.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x0c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 0c457427 <unknown>

th.vsuxb.v	v8, (a0), v4
# CHECK-INST: th.vsuxb.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e450427 <unknown>

th.vsuxb.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsuxb.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c450427 <unknown>

th.vsuxh.v	v8, (a0), v4
# CHECK-INST: th.vsuxh.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e455427 <unknown>

th.vsuxh.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsuxh.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c455427 <unknown>

th.vsuxw.v	v8, (a0), v4
# CHECK-INST: th.vsuxw.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e456427 <unknown>

th.vsuxw.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsuxw.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c456427 <unknown>

th.vsuxe.v	v8, (a0), v4
# CHECK-INST: th.vsuxe.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x1e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1e457427 <unknown>

th.vsuxe.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsuxe.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x1c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 1c457427 <unknown>
