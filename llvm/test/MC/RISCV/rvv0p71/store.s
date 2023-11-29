# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:   --riscv-no-aliases | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:   | llvm-objdump -d --mattr=+xtheadvector -M no-aliases - \
# RUN:   | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:   | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

vsb.v v8, (a0), v0.t
# CHECK-INST: vsb.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x00]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 00 <unknown>

vsb.v v8, (a0)
# CHECK-INST: vsb.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x02]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 02 <unknown>

vsh.v v8, (a0), v0.t
# CHECK-INST: vsh.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x00]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 00 <unknown>

vsh.v v8, (a0)
# CHECK-INST: vsh.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x02]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 02 <unknown>

vsw.v v8, (a0), v0.t
# CHECK-INST: vsw.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x00]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 00 <unknown>

vsw.v v8, (a0)
# CHECK-INST: vsw.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x02]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 02 <unknown>

vse.v v8, (a0), v0.t
# CHECK-INST: vse.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x00]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 00 <unknown>

vse.v v8, (a0)
# CHECK-INST: vse.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x02]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 02 <unknown>

vssb.v	v8, (a0), a1
# CHECK-INST: vssb.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x0a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 0a <unknown>

vssb.v	v8, (a0), a1, v0.t
# CHECK-INST: vssb.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x08]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 08 <unknown>

vssh.v	v8, (a0), a1
# CHECK-INST: vssh.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x0a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 0a <unknown>

vssh.v	v8, (a0), a1, v0.t
# CHECK-INST: vssh.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x08]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 08 <unknown>

vssw.v	v8, (a0), a1
# CHECK-INST: vssw.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x0a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 0a <unknown>

vssw.v	v8, (a0), a1, v0.t
# CHECK-INST: vssw.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x08]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 08 <unknown>

vsse.v	v8, (a0), a1
# CHECK-INST: vsse.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x0a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 0a <unknown>

vsse.v	v8, (a0), a1, v0.t
# CHECK-INST: vsse.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x08]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 08 <unknown>

vsxb.v	v8, (a0), v4
# CHECK-INST: vsxb.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x0e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 0e <unknown>

vsxb.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxb.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x0c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 0c <unknown>

vsxh.v	v8, (a0), v4
# CHECK-INST: vsxh.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x0e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 0e <unknown>

vsxh.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxh.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x0c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 0c <unknown>

vsxw.v	v8, (a0), v4
# CHECK-INST: vsxw.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x0e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 0e <unknown>

vsxw.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxw.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x0c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 0c <unknown>

vsxe.v	v8, (a0), v4
# CHECK-INST: vsxe.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x0e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 0e <unknown>

vsxe.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxe.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x0c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 0c <unknown>

vsuxb.v	v8, (a0), v4
# CHECK-INST: vsuxb.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x1e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 1e <unknown>

vsuxb.v	v8, (a0), v4, v0.t
# CHECK-INST: vsuxb.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x1c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 1c <unknown>

vsuxh.v	v8, (a0), v4
# CHECK-INST: vsuxh.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x1e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 1e <unknown>

vsuxh.v	v8, (a0), v4, v0.t
# CHECK-INST: vsuxh.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x1c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 1c <unknown>

vsuxw.v	v8, (a0), v4
# CHECK-INST: vsuxw.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x1e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 1e <unknown>

vsuxw.v	v8, (a0), v4, v0.t
# CHECK-INST: vsuxw.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x1c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 1c <unknown>

vsuxe.v	v8, (a0), v4
# CHECK-INST: vsuxe.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x1e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 1e <unknown>

vsuxe.v	v8, (a0), v4, v0.t
# CHECK-INST: vsuxe.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x1c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 1c <unknown>
