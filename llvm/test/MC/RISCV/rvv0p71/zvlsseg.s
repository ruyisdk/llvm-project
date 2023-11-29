# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector,+xtheadvlsseg %s \
# RUN:   --riscv-no-aliases \
# RUN:   | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector,+xtheadvlsseg %s \
# RUN:   | llvm-objdump -d --mattr=+xtheadvector,+xtheadvlsseg -M no-aliases - \
# RUN:   | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector,+xtheadvlsseg %s \
# RUN:   | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

vlseg2b.v v8, (a0), v0.t
# CHECK-INST: vlseg2b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x30]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 30 <unknown>

vlseg2b.v v8, (a0)
# CHECK-INST: vlseg2b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x32]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 32 <unknown>

vlseg2h.v v8, (a0), v0.t
# CHECK-INST: vlseg2h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x30]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 30 <unknown>

vlseg2h.v v8, (a0)
# CHECK-INST: vlseg2h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x32]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 32 <unknown>

vlseg2w.v v8, (a0), v0.t
# CHECK-INST: vlseg2w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x30]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 30 <unknown>

vlseg2w.v v8, (a0)
# CHECK-INST: vlseg2w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x32]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 32 <unknown>

vlseg2bu.v v8, (a0), v0.t
# CHECK-INST: vlseg2bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 20 <unknown>

vlseg2bu.v v8, (a0)
# CHECK-INST: vlseg2bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 22 <unknown>

vlseg2hu.v v8, (a0), v0.t
# CHECK-INST: vlseg2hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 20 <unknown>

vlseg2hu.v v8, (a0)
# CHECK-INST: vlseg2hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 22 <unknown>

vlseg2wu.v v8, (a0), v0.t
# CHECK-INST: vlseg2wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 20 <unknown>

vlseg2wu.v v8, (a0)
# CHECK-INST: vlseg2wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 22 <unknown>

vlseg2e.v v8, (a0), v0.t
# CHECK-INST: vlseg2e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 20 <unknown>

vlseg2e.v v8, (a0)
# CHECK-INST: vlseg2e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 22 <unknown>

vsseg2b.v v8, (a0), v0.t
# CHECK-INST: vsseg2b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 20 <unknown>

vsseg2b.v v8, (a0)
# CHECK-INST: vsseg2b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 22 <unknown>

vsseg2h.v v8, (a0), v0.t
# CHECK-INST: vsseg2h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 20 <unknown>

vsseg2h.v v8, (a0)
# CHECK-INST: vsseg2h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 22 <unknown>

vsseg2w.v v8, (a0), v0.t
# CHECK-INST: vsseg2w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 20 <unknown>

vsseg2w.v v8, (a0)
# CHECK-INST: vsseg2w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 22 <unknown>

vsseg2e.v v8, (a0), v0.t
# CHECK-INST: vsseg2e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x20]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 20 <unknown>

vsseg2e.v v8, (a0)
# CHECK-INST: vsseg2e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x22]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 22 <unknown>

vlseg2bff.v	v8, (a0)
# CHECK-INST: vlseg2bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x33]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 33 <unknown>

vlseg2bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg2bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x31]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 31 <unknown>

vlseg2hff.v	v8, (a0)
# CHECK-INST: vlseg2hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x33]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 33 <unknown>

vlseg2hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg2hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x31]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 31 <unknown>

vlseg2wff.v	v8, (a0)
# CHECK-INST: vlseg2wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x33]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 33 <unknown>

vlseg2wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg2wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x31]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 31 <unknown>

vlseg2buff.v v8, (a0)
# CHECK-INST: vlseg2buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x23]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 23 <unknown>

vlseg2buff.v v8, (a0), v0.t
# CHECK-INST: vlseg2buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x21]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 21 <unknown>

vlseg2huff.v v8, (a0)
# CHECK-INST: vlseg2huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x23]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 23 <unknown>

vlseg2huff.v v8, (a0), v0.t
# CHECK-INST: vlseg2huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x21]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 21 <unknown>

vlseg2wuff.v v8, (a0)
# CHECK-INST: vlseg2wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x23]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 23 <unknown>

vlseg2wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg2wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x21]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 21 <unknown>

vlseg2eff.v	v8, (a0)
# CHECK-INST: vlseg2eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x23]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 23 <unknown>

vlseg2eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg2eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x21]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 21 <unknown>

vlsseg2b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x38]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 38 <unknown>

vlsseg2b.v v8, (a0), a1
# CHECK-INST: vlsseg2b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x3a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 3a <unknown>

vlsseg2h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x38]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 38 <unknown>

vlsseg2h.v v8, (a0), a1
# CHECK-INST: vlsseg2h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x3a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 3a <unknown>

vlsseg2w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x38]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 38 <unknown>

vlsseg2w.v v8, (a0), a1
# CHECK-INST: vlsseg2w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x3a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 3a <unknown>

vlsseg2bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 28 <unknown>

vlsseg2bu.v v8, (a0), a1
# CHECK-INST: vlsseg2bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 2a <unknown>

vlsseg2hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 28 <unknown>

vlsseg2hu.v v8, (a0), a1
# CHECK-INST: vlsseg2hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 2a <unknown>

vlsseg2wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 28 <unknown>

vlsseg2wu.v v8, (a0), a1
# CHECK-INST: vlsseg2wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 2a <unknown>

vlsseg2e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg2e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 28 <unknown>

vlsseg2e.v v8, (a0), a1
# CHECK-INST: vlsseg2e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 2a <unknown>

vssseg2b.v	v8, (a0), a1
# CHECK-INST: vssseg2b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 2a <unknown>

vssseg2b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg2b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 28 <unknown>

vssseg2h.v	v8, (a0), a1
# CHECK-INST: vssseg2h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 2a <unknown>

vssseg2h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg2h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 28 <unknown>

vssseg2w.v	v8, (a0), a1
# CHECK-INST: vssseg2w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 2a <unknown>

vssseg2w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg2w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 28 <unknown>

vssseg2e.v	v8, (a0), a1
# CHECK-INST: vssseg2e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x2a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 2a <unknown>

vssseg2e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg2e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x28]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 28 <unknown>

vlxseg2b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x3c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 3c <unknown>

vlxseg2b.v v8, (a0), v4
# CHECK-INST: vlxseg2b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x3e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 3e <unknown>

vlxseg2h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x3c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 3c <unknown>

vlxseg2h.v v8, (a0), v4
# CHECK-INST: vlxseg2h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x3e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 3e <unknown>

vlxseg2w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x3c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 3c <unknown>

vlxseg2w.v v8, (a0), v4
# CHECK-INST: vlxseg2w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x3e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 3e <unknown>

vlxseg2bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 2c <unknown>

vlxseg2bu.v v8, (a0), v4
# CHECK-INST: vlxseg2bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 2e <unknown>

vlxseg2hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 2c <unknown>

vlxseg2hu.v v8, (a0), v4
# CHECK-INST: vlxseg2hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 2e <unknown>

vlxseg2wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 2c <unknown>

vlxseg2wu.v v8, (a0), v4
# CHECK-INST: vlxseg2wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 2e <unknown>

vlxseg2e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg2e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 2c <unknown>

vlxseg2e.v v8, (a0), v4
# CHECK-INST: vlxseg2e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 2e <unknown>

vsxseg2b.v	v8, (a0), v4
# CHECK-INST: vsxseg2b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 2e <unknown>

vsxseg2b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg2b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 2c <unknown>

vsxseg2h.v	v8, (a0), v4
# CHECK-INST: vsxseg2h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 2e <unknown>

vsxseg2h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg2h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 2c <unknown>

vsxseg2w.v	v8, (a0), v4
# CHECK-INST: vsxseg2w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 2e <unknown>

vsxseg2w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg2w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 2c <unknown>

vsxseg2e.v	v8, (a0), v4
# CHECK-INST: vsxseg2e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x2e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 2e <unknown>

vsxseg2e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg2e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x2c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 2c <unknown>

vlseg3b.v v8, (a0), v0.t
# CHECK-INST: vlseg3b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x50]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 50 <unknown>

vlseg3b.v v8, (a0)
# CHECK-INST: vlseg3b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x52]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 52 <unknown>

vlseg3h.v v8, (a0), v0.t
# CHECK-INST: vlseg3h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x50]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 50 <unknown>

vlseg3h.v v8, (a0)
# CHECK-INST: vlseg3h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x52]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 52 <unknown>

vlseg3w.v v8, (a0), v0.t
# CHECK-INST: vlseg3w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x50]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 50 <unknown>

vlseg3w.v v8, (a0)
# CHECK-INST: vlseg3w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x52]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 52 <unknown>

vlseg3bu.v v8, (a0), v0.t
# CHECK-INST: vlseg3bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 40 <unknown>

vlseg3bu.v v8, (a0)
# CHECK-INST: vlseg3bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 42 <unknown>

vlseg3hu.v v8, (a0), v0.t
# CHECK-INST: vlseg3hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 40 <unknown>

vlseg3hu.v v8, (a0)
# CHECK-INST: vlseg3hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 42 <unknown>

vlseg3wu.v v8, (a0), v0.t
# CHECK-INST: vlseg3wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 40 <unknown>

vlseg3wu.v v8, (a0)
# CHECK-INST: vlseg3wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 42 <unknown>

vlseg3e.v v8, (a0), v0.t
# CHECK-INST: vlseg3e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 40 <unknown>

vlseg3e.v v8, (a0)
# CHECK-INST: vlseg3e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 42 <unknown>

vsseg3b.v v8, (a0), v0.t
# CHECK-INST: vsseg3b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 40 <unknown>

vsseg3b.v v8, (a0)
# CHECK-INST: vsseg3b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 42 <unknown>

vsseg3h.v v8, (a0), v0.t
# CHECK-INST: vsseg3h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 40 <unknown>

vsseg3h.v v8, (a0)
# CHECK-INST: vsseg3h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 42 <unknown>

vsseg3w.v v8, (a0), v0.t
# CHECK-INST: vsseg3w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 40 <unknown>

vsseg3w.v v8, (a0)
# CHECK-INST: vsseg3w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 42 <unknown>

vsseg3e.v v8, (a0), v0.t
# CHECK-INST: vsseg3e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x40]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 40 <unknown>

vsseg3e.v v8, (a0)
# CHECK-INST: vsseg3e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x42]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 42 <unknown>

vlseg3bff.v	v8, (a0)
# CHECK-INST: vlseg3bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x53]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 53 <unknown>

vlseg3bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg3bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x51]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 51 <unknown>

vlseg3hff.v	v8, (a0)
# CHECK-INST: vlseg3hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x53]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 53 <unknown>

vlseg3hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg3hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x51]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 51 <unknown>

vlseg3wff.v	v8, (a0)
# CHECK-INST: vlseg3wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x53]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 53 <unknown>

vlseg3wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg3wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x51]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 51 <unknown>

vlseg3buff.v v8, (a0)
# CHECK-INST: vlseg3buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x43]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 43 <unknown>

vlseg3buff.v v8, (a0), v0.t
# CHECK-INST: vlseg3buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x41]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 41 <unknown>

vlseg3huff.v v8, (a0)
# CHECK-INST: vlseg3huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x43]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 43 <unknown>

vlseg3huff.v v8, (a0), v0.t
# CHECK-INST: vlseg3huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x41]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 41 <unknown>

vlseg3wuff.v v8, (a0)
# CHECK-INST: vlseg3wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x43]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 43 <unknown>

vlseg3wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg3wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x41]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 41 <unknown>

vlseg3eff.v	v8, (a0)
# CHECK-INST: vlseg3eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x43]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 43 <unknown>

vlseg3eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg3eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x41]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 41 <unknown>

vlsseg3b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x58]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 58 <unknown>

vlsseg3b.v v8, (a0), a1
# CHECK-INST: vlsseg3b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x5a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 5a <unknown>

vlsseg3h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x58]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 58 <unknown>

vlsseg3h.v v8, (a0), a1
# CHECK-INST: vlsseg3h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x5a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 5a <unknown>

vlsseg3w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x58]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 58 <unknown>

vlsseg3w.v v8, (a0), a1
# CHECK-INST: vlsseg3w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x5a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 5a <unknown>

vlsseg3bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 48 <unknown>

vlsseg3bu.v v8, (a0), a1
# CHECK-INST: vlsseg3bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 4a <unknown>

vlsseg3hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 48 <unknown>

vlsseg3hu.v v8, (a0), a1
# CHECK-INST: vlsseg3hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 4a <unknown>

vlsseg3wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 48 <unknown>

vlsseg3wu.v v8, (a0), a1
# CHECK-INST: vlsseg3wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 4a <unknown>

vlsseg3e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg3e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 48 <unknown>

vlsseg3e.v v8, (a0), a1
# CHECK-INST: vlsseg3e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 4a <unknown>

vssseg3b.v	v8, (a0), a1
# CHECK-INST: vssseg3b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 4a <unknown>

vssseg3b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg3b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 48 <unknown>

vssseg3h.v	v8, (a0), a1
# CHECK-INST: vssseg3h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 4a <unknown>

vssseg3h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg3h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 48 <unknown>

vssseg3w.v	v8, (a0), a1
# CHECK-INST: vssseg3w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 4a <unknown>

vssseg3w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg3w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 48 <unknown>

vssseg3e.v	v8, (a0), a1
# CHECK-INST: vssseg3e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x4a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 4a <unknown>

vssseg3e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg3e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x48]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 48 <unknown>

vlxseg3b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x5c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 5c <unknown>

vlxseg3b.v v8, (a0), v4
# CHECK-INST: vlxseg3b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x5e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 5e <unknown>

vlxseg3h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x5c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 5c <unknown>

vlxseg3h.v v8, (a0), v4
# CHECK-INST: vlxseg3h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x5e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 5e <unknown>

vlxseg3w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x5c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 5c <unknown>

vlxseg3w.v v8, (a0), v4
# CHECK-INST: vlxseg3w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x5e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 5e <unknown>

vlxseg3bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 4c <unknown>

vlxseg3bu.v v8, (a0), v4
# CHECK-INST: vlxseg3bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 4e <unknown>

vlxseg3hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 4c <unknown>

vlxseg3hu.v v8, (a0), v4
# CHECK-INST: vlxseg3hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 4e <unknown>

vlxseg3wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 4c <unknown>

vlxseg3wu.v v8, (a0), v4
# CHECK-INST: vlxseg3wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 4e <unknown>

vlxseg3e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg3e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 4c <unknown>

vlxseg3e.v v8, (a0), v4
# CHECK-INST: vlxseg3e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 4e <unknown>

vsxseg3b.v	v8, (a0), v4
# CHECK-INST: vsxseg3b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 4e <unknown>

vsxseg3b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg3b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 4c <unknown>

vsxseg3h.v	v8, (a0), v4
# CHECK-INST: vsxseg3h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 4e <unknown>

vsxseg3h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg3h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 4c <unknown>

vsxseg3w.v	v8, (a0), v4
# CHECK-INST: vsxseg3w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 4e <unknown>

vsxseg3w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg3w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 4c <unknown>

vsxseg3e.v	v8, (a0), v4
# CHECK-INST: vsxseg3e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x4e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 4e <unknown>

vsxseg3e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg3e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x4c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 4c <unknown>

vlseg4b.v v8, (a0), v0.t
# CHECK-INST: vlseg4b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x70]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 70 <unknown>

vlseg4b.v v8, (a0)
# CHECK-INST: vlseg4b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x72]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 72 <unknown>

vlseg4h.v v8, (a0), v0.t
# CHECK-INST: vlseg4h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x70]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 70 <unknown>

vlseg4h.v v8, (a0)
# CHECK-INST: vlseg4h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x72]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 72 <unknown>

vlseg4w.v v8, (a0), v0.t
# CHECK-INST: vlseg4w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x70]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 70 <unknown>

vlseg4w.v v8, (a0)
# CHECK-INST: vlseg4w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x72]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 72 <unknown>

vlseg4bu.v v8, (a0), v0.t
# CHECK-INST: vlseg4bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 60 <unknown>

vlseg4bu.v v8, (a0)
# CHECK-INST: vlseg4bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 62 <unknown>

vlseg4hu.v v8, (a0), v0.t
# CHECK-INST: vlseg4hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 60 <unknown>

vlseg4hu.v v8, (a0)
# CHECK-INST: vlseg4hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 62 <unknown>

vlseg4wu.v v8, (a0), v0.t
# CHECK-INST: vlseg4wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 60 <unknown>

vlseg4wu.v v8, (a0)
# CHECK-INST: vlseg4wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 62 <unknown>

vlseg4e.v v8, (a0), v0.t
# CHECK-INST: vlseg4e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 60 <unknown>

vlseg4e.v v8, (a0)
# CHECK-INST: vlseg4e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 62 <unknown>

vsseg4b.v v8, (a0), v0.t
# CHECK-INST: vsseg4b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 60 <unknown>

vsseg4b.v v8, (a0)
# CHECK-INST: vsseg4b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 62 <unknown>

vsseg4h.v v8, (a0), v0.t
# CHECK-INST: vsseg4h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 60 <unknown>

vsseg4h.v v8, (a0)
# CHECK-INST: vsseg4h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 62 <unknown>

vsseg4w.v v8, (a0), v0.t
# CHECK-INST: vsseg4w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 60 <unknown>

vsseg4w.v v8, (a0)
# CHECK-INST: vsseg4w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 62 <unknown>

vsseg4e.v v8, (a0), v0.t
# CHECK-INST: vsseg4e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x60]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 60 <unknown>

vsseg4e.v v8, (a0)
# CHECK-INST: vsseg4e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x62]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 62 <unknown>

vlseg4bff.v	v8, (a0)
# CHECK-INST: vlseg4bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x73]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 73 <unknown>

vlseg4bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg4bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x71]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 71 <unknown>

vlseg4hff.v	v8, (a0)
# CHECK-INST: vlseg4hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x73]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 73 <unknown>

vlseg4hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg4hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x71]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 71 <unknown>

vlseg4wff.v	v8, (a0)
# CHECK-INST: vlseg4wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x73]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 73 <unknown>

vlseg4wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg4wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x71]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 71 <unknown>

vlseg4buff.v v8, (a0)
# CHECK-INST: vlseg4buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x63]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 63 <unknown>

vlseg4buff.v v8, (a0), v0.t
# CHECK-INST: vlseg4buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x61]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 61 <unknown>

vlseg4huff.v v8, (a0)
# CHECK-INST: vlseg4huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x63]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 63 <unknown>

vlseg4huff.v v8, (a0), v0.t
# CHECK-INST: vlseg4huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x61]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 61 <unknown>

vlseg4wuff.v v8, (a0)
# CHECK-INST: vlseg4wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x63]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 63 <unknown>

vlseg4wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg4wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x61]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 61 <unknown>

vlseg4eff.v	v8, (a0)
# CHECK-INST: vlseg4eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x63]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 63 <unknown>

vlseg4eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg4eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x61]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 61 <unknown>

vlsseg4b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x78]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 78 <unknown>

vlsseg4b.v v8, (a0), a1
# CHECK-INST: vlsseg4b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x7a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 7a <unknown>

vlsseg4h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x78]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 78 <unknown>

vlsseg4h.v v8, (a0), a1
# CHECK-INST: vlsseg4h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x7a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 7a <unknown>

vlsseg4w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x78]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 78 <unknown>

vlsseg4w.v v8, (a0), a1
# CHECK-INST: vlsseg4w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x7a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 7a <unknown>

vlsseg4bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 68 <unknown>

vlsseg4bu.v v8, (a0), a1
# CHECK-INST: vlsseg4bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 6a <unknown>

vlsseg4hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 68 <unknown>

vlsseg4hu.v v8, (a0), a1
# CHECK-INST: vlsseg4hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 6a <unknown>

vlsseg4wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 68 <unknown>

vlsseg4wu.v v8, (a0), a1
# CHECK-INST: vlsseg4wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 6a <unknown>

vlsseg4e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg4e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 68 <unknown>

vlsseg4e.v v8, (a0), a1
# CHECK-INST: vlsseg4e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 6a <unknown>

vssseg4b.v	v8, (a0), a1
# CHECK-INST: vssseg4b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 6a <unknown>

vssseg4b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg4b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 68 <unknown>

vssseg4h.v	v8, (a0), a1
# CHECK-INST: vssseg4h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 6a <unknown>

vssseg4h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg4h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 68 <unknown>

vssseg4w.v	v8, (a0), a1
# CHECK-INST: vssseg4w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 6a <unknown>

vssseg4w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg4w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 68 <unknown>

vssseg4e.v	v8, (a0), a1
# CHECK-INST: vssseg4e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 6a <unknown>

vssseg4e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg4e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 68 <unknown>

vlxseg4b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x7c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 7c <unknown>

vlxseg4b.v v8, (a0), v4
# CHECK-INST: vlxseg4b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x7e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 7e <unknown>

vlxseg4h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x7c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 7c <unknown>

vlxseg4h.v v8, (a0), v4
# CHECK-INST: vlxseg4h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x7e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 7e <unknown>

vlxseg4w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x7c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 7c <unknown>

vlxseg4w.v v8, (a0), v4
# CHECK-INST: vlxseg4w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x7e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 7e <unknown>

vlxseg4bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 6c <unknown>

vlxseg4bu.v v8, (a0), v4
# CHECK-INST: vlxseg4bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 6e <unknown>

vlxseg4hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 6c <unknown>

vlxseg4hu.v v8, (a0), v4
# CHECK-INST: vlxseg4hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 6e <unknown>

vlxseg4wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 6c <unknown>

vlxseg4wu.v v8, (a0), v4
# CHECK-INST: vlxseg4wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 6e <unknown>

vlxseg4e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg4e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 6c <unknown>

vlxseg4e.v v8, (a0), v4
# CHECK-INST: vlxseg4e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 6e <unknown>

vsxseg4b.v	v8, (a0), v4
# CHECK-INST: vsxseg4b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 6e <unknown>

vsxseg4b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg4b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 6c <unknown>

vsxseg4h.v	v8, (a0), v4
# CHECK-INST: vsxseg4h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 6e <unknown>

vsxseg4h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg4h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 6c <unknown>

vsxseg4w.v	v8, (a0), v4
# CHECK-INST: vsxseg4w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 6e <unknown>

vsxseg4w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg4w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 6c <unknown>

vsxseg4e.v	v8, (a0), v4
# CHECK-INST: vsxseg4e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x6e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 6e <unknown>

vsxseg4e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg4e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x6c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 6c <unknown>

vlseg5b.v v8, (a0), v0.t
# CHECK-INST: vlseg5b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x90]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 90 <unknown>

vlseg5b.v v8, (a0)
# CHECK-INST: vlseg5b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x92]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 92 <unknown>

vlseg5h.v v8, (a0), v0.t
# CHECK-INST: vlseg5h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x90]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 90 <unknown>

vlseg5h.v v8, (a0)
# CHECK-INST: vlseg5h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x92]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 92 <unknown>

vlseg5w.v v8, (a0), v0.t
# CHECK-INST: vlseg5w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x90]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 90 <unknown>

vlseg5w.v v8, (a0)
# CHECK-INST: vlseg5w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x92]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 92 <unknown>

vlseg5bu.v v8, (a0), v0.t
# CHECK-INST: vlseg5bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 80 <unknown>

vlseg5bu.v v8, (a0)
# CHECK-INST: vlseg5bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 82 <unknown>

vlseg5hu.v v8, (a0), v0.t
# CHECK-INST: vlseg5hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 80 <unknown>

vlseg5hu.v v8, (a0)
# CHECK-INST: vlseg5hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 82 <unknown>

vlseg5wu.v v8, (a0), v0.t
# CHECK-INST: vlseg5wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 80 <unknown>

vlseg5wu.v v8, (a0)
# CHECK-INST: vlseg5wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 82 <unknown>

vlseg5e.v v8, (a0), v0.t
# CHECK-INST: vlseg5e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 80 <unknown>

vlseg5e.v v8, (a0)
# CHECK-INST: vlseg5e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 82 <unknown>

vsseg5b.v v8, (a0), v0.t
# CHECK-INST: vsseg5b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 80 <unknown>

vsseg5b.v v8, (a0)
# CHECK-INST: vsseg5b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 82 <unknown>

vsseg5h.v v8, (a0), v0.t
# CHECK-INST: vsseg5h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 80 <unknown>

vsseg5h.v v8, (a0)
# CHECK-INST: vsseg5h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 82 <unknown>

vsseg5w.v v8, (a0), v0.t
# CHECK-INST: vsseg5w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 80 <unknown>

vsseg5w.v v8, (a0)
# CHECK-INST: vsseg5w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 82 <unknown>

vsseg5e.v v8, (a0), v0.t
# CHECK-INST: vsseg5e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x80]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 80 <unknown>

vsseg5e.v v8, (a0)
# CHECK-INST: vsseg5e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x82]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 82 <unknown>

vlseg5bff.v	v8, (a0)
# CHECK-INST: vlseg5bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x93]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 93 <unknown>

vlseg5bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg5bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x91]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 91 <unknown>

vlseg5hff.v	v8, (a0)
# CHECK-INST: vlseg5hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x93]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 93 <unknown>

vlseg5hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg5hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x91]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 91 <unknown>

vlseg5wff.v	v8, (a0)
# CHECK-INST: vlseg5wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x93]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 93 <unknown>

vlseg5wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg5wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x91]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 91 <unknown>

vlseg5buff.v v8, (a0)
# CHECK-INST: vlseg5buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x83]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 83 <unknown>

vlseg5buff.v v8, (a0), v0.t
# CHECK-INST: vlseg5buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x81]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 81 <unknown>

vlseg5huff.v v8, (a0)
# CHECK-INST: vlseg5huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x83]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 83 <unknown>

vlseg5huff.v v8, (a0), v0.t
# CHECK-INST: vlseg5huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x81]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 81 <unknown>

vlseg5wuff.v v8, (a0)
# CHECK-INST: vlseg5wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x83]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 83 <unknown>

vlseg5wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg5wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x81]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 81 <unknown>

vlseg5eff.v	v8, (a0)
# CHECK-INST: vlseg5eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x83]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 83 <unknown>

vlseg5eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg5eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x81]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 81 <unknown>

vlsseg5b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x98]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 98 <unknown>

vlsseg5b.v v8, (a0), a1
# CHECK-INST: vlsseg5b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x9a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 9a <unknown>

vlsseg5h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x98]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 98 <unknown>

vlsseg5h.v v8, (a0), a1
# CHECK-INST: vlsseg5h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x9a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 9a <unknown>

vlsseg5w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x98]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 98 <unknown>

vlsseg5w.v v8, (a0), a1
# CHECK-INST: vlsseg5w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x9a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 9a <unknown>

vlsseg5bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 88 <unknown>

vlsseg5bu.v v8, (a0), a1
# CHECK-INST: vlsseg5bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 8a <unknown>

vlsseg5hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 88 <unknown>

vlsseg5hu.v v8, (a0), a1
# CHECK-INST: vlsseg5hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 8a <unknown>

vlsseg5wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 88 <unknown>

vlsseg5wu.v v8, (a0), a1
# CHECK-INST: vlsseg5wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 8a <unknown>

vlsseg5e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg5e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 88 <unknown>

vlsseg5e.v v8, (a0), a1
# CHECK-INST: vlsseg5e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 8a <unknown>

vssseg5b.v	v8, (a0), a1
# CHECK-INST: vssseg5b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 8a <unknown>

vssseg5b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg5b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 88 <unknown>

vssseg5h.v	v8, (a0), a1
# CHECK-INST: vssseg5h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 8a <unknown>

vssseg5h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg5h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 88 <unknown>

vssseg5w.v	v8, (a0), a1
# CHECK-INST: vssseg5w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 8a <unknown>

vssseg5w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg5w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 88 <unknown>

vssseg5e.v	v8, (a0), a1
# CHECK-INST: vssseg5e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x8a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 8a <unknown>

vssseg5e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg5e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x88]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 88 <unknown>

vlxseg5b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x9c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 9c <unknown>

vlxseg5b.v v8, (a0), v4
# CHECK-INST: vlxseg5b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x9e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 9e <unknown>

vlxseg5h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x9c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 9c <unknown>

vlxseg5h.v v8, (a0), v4
# CHECK-INST: vlxseg5h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x9e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 9e <unknown>

vlxseg5w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x9c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 9c <unknown>

vlxseg5w.v v8, (a0), v4
# CHECK-INST: vlxseg5w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x9e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 9e <unknown>

vlxseg5bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 8c <unknown>

vlxseg5bu.v v8, (a0), v4
# CHECK-INST: vlxseg5bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 8e <unknown>

vlxseg5hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 8c <unknown>

vlxseg5hu.v v8, (a0), v4
# CHECK-INST: vlxseg5hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 8e <unknown>

vlxseg5wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 8c <unknown>

vlxseg5wu.v v8, (a0), v4
# CHECK-INST: vlxseg5wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 8e <unknown>

vlxseg5e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg5e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 8c <unknown>

vlxseg5e.v v8, (a0), v4
# CHECK-INST: vlxseg5e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 8e <unknown>

vsxseg5b.v	v8, (a0), v4
# CHECK-INST: vsxseg5b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 8e <unknown>

vsxseg5b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg5b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 8c <unknown>

vsxseg5h.v	v8, (a0), v4
# CHECK-INST: vsxseg5h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 8e <unknown>

vsxseg5h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg5h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 8c <unknown>

vsxseg5w.v	v8, (a0), v4
# CHECK-INST: vsxseg5w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 8e <unknown>

vsxseg5w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg5w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 8c <unknown>

vsxseg5e.v	v8, (a0), v4
# CHECK-INST: vsxseg5e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x8e]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 8e <unknown>

vsxseg5e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg5e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x8c]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 8c <unknown>

vlseg6b.v v8, (a0), v0.t
# CHECK-INST: vlseg6b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xb0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 b0 <unknown>

vlseg6b.v v8, (a0)
# CHECK-INST: vlseg6b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xb2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 b2 <unknown>

vlseg6h.v v8, (a0), v0.t
# CHECK-INST: vlseg6h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xb0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 b0 <unknown>

vlseg6h.v v8, (a0)
# CHECK-INST: vlseg6h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xb2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 b2 <unknown>

vlseg6w.v v8, (a0), v0.t
# CHECK-INST: vlseg6w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xb0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 b0 <unknown>

vlseg6w.v v8, (a0)
# CHECK-INST: vlseg6w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xb2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 b2 <unknown>

vlseg6bu.v v8, (a0), v0.t
# CHECK-INST: vlseg6bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 a0 <unknown>

vlseg6bu.v v8, (a0)
# CHECK-INST: vlseg6bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 a2 <unknown>

vlseg6hu.v v8, (a0), v0.t
# CHECK-INST: vlseg6hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 a0 <unknown>

vlseg6hu.v v8, (a0)
# CHECK-INST: vlseg6hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 a2 <unknown>

vlseg6wu.v v8, (a0), v0.t
# CHECK-INST: vlseg6wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 a0 <unknown>

vlseg6wu.v v8, (a0)
# CHECK-INST: vlseg6wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 a2 <unknown>

vlseg6e.v v8, (a0), v0.t
# CHECK-INST: vlseg6e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 a0 <unknown>

vlseg6e.v v8, (a0)
# CHECK-INST: vlseg6e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 a2 <unknown>

vsseg6b.v v8, (a0), v0.t
# CHECK-INST: vsseg6b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 a0 <unknown>

vsseg6b.v v8, (a0)
# CHECK-INST: vsseg6b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 a2 <unknown>

vsseg6h.v v8, (a0), v0.t
# CHECK-INST: vsseg6h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 a0 <unknown>

vsseg6h.v v8, (a0)
# CHECK-INST: vsseg6h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 a2 <unknown>

vsseg6w.v v8, (a0), v0.t
# CHECK-INST: vsseg6w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 a0 <unknown>

vsseg6w.v v8, (a0)
# CHECK-INST: vsseg6w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 a2 <unknown>

vsseg6e.v v8, (a0), v0.t
# CHECK-INST: vsseg6e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0xa0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 a0 <unknown>

vsseg6e.v v8, (a0)
# CHECK-INST: vsseg6e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0xa2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 a2 <unknown>

vlseg6bff.v	v8, (a0)
# CHECK-INST: vlseg6bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xb3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 b3 <unknown>

vlseg6bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg6bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xb1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 b1 <unknown>

vlseg6hff.v	v8, (a0)
# CHECK-INST: vlseg6hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xb3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 b3 <unknown>

vlseg6hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg6hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xb1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 b1 <unknown>

vlseg6wff.v	v8, (a0)
# CHECK-INST: vlseg6wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xb3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 b3 <unknown>

vlseg6wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg6wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xb1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 b1 <unknown>

vlseg6buff.v v8, (a0)
# CHECK-INST: vlseg6buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xa3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 a3 <unknown>

vlseg6buff.v v8, (a0), v0.t
# CHECK-INST: vlseg6buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xa1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 a1 <unknown>

vlseg6huff.v v8, (a0)
# CHECK-INST: vlseg6huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xa3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 a3 <unknown>

vlseg6huff.v v8, (a0), v0.t
# CHECK-INST: vlseg6huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xa1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 a1 <unknown>

vlseg6wuff.v v8, (a0)
# CHECK-INST: vlseg6wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xa3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 a3 <unknown>

vlseg6wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg6wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xa1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 a1 <unknown>

vlseg6eff.v	v8, (a0)
# CHECK-INST: vlseg6eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xa3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 a3 <unknown>

vlseg6eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg6eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xa1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 a1 <unknown>

vlsseg6b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xb8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 b8 <unknown>

vlsseg6b.v v8, (a0), a1
# CHECK-INST: vlsseg6b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xba]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 ba <unknown>

vlsseg6h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xb8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 b8 <unknown>

vlsseg6h.v v8, (a0), a1
# CHECK-INST: vlsseg6h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xba]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 ba <unknown>

vlsseg6w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xb8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 b8 <unknown>

vlsseg6w.v v8, (a0), a1
# CHECK-INST: vlsseg6w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xba]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 ba <unknown>

vlsseg6bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 a8 <unknown>

vlsseg6bu.v v8, (a0), a1
# CHECK-INST: vlsseg6bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 aa <unknown>

vlsseg6hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 a8 <unknown>

vlsseg6hu.v v8, (a0), a1
# CHECK-INST: vlsseg6hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 aa <unknown>

vlsseg6wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 a8 <unknown>

vlsseg6wu.v v8, (a0), a1
# CHECK-INST: vlsseg6wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 aa <unknown>

vlsseg6e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg6e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 a8 <unknown>

vlsseg6e.v v8, (a0), a1
# CHECK-INST: vlsseg6e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 aa <unknown>

vssseg6b.v	v8, (a0), a1
# CHECK-INST: vssseg6b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 aa <unknown>

vssseg6b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg6b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 a8 <unknown>

vssseg6h.v	v8, (a0), a1
# CHECK-INST: vssseg6h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 aa <unknown>

vssseg6h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg6h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 a8 <unknown>

vssseg6w.v	v8, (a0), a1
# CHECK-INST: vssseg6w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 aa <unknown>

vssseg6w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg6w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 a8 <unknown>

vssseg6e.v	v8, (a0), a1
# CHECK-INST: vssseg6e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0xaa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 aa <unknown>

vssseg6e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg6e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0xa8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 a8 <unknown>

vlxseg6b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xbc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 bc <unknown>

vlxseg6b.v v8, (a0), v4
# CHECK-INST: vlxseg6b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xbe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 be <unknown>

vlxseg6h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xbc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 bc <unknown>

vlxseg6h.v v8, (a0), v4
# CHECK-INST: vlxseg6h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xbe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 be <unknown>

vlxseg6w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xbc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 bc <unknown>

vlxseg6w.v v8, (a0), v4
# CHECK-INST: vlxseg6w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xbe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 be <unknown>

vlxseg6bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 ac <unknown>

vlxseg6bu.v v8, (a0), v4
# CHECK-INST: vlxseg6bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 ae <unknown>

vlxseg6hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 ac <unknown>

vlxseg6hu.v v8, (a0), v4
# CHECK-INST: vlxseg6hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 ae <unknown>

vlxseg6wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 ac <unknown>

vlxseg6wu.v v8, (a0), v4
# CHECK-INST: vlxseg6wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 ae <unknown>

vlxseg6e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg6e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 ac <unknown>

vlxseg6e.v v8, (a0), v4
# CHECK-INST: vlxseg6e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 ae <unknown>

vsxseg6b.v	v8, (a0), v4
# CHECK-INST: vsxseg6b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 ae <unknown>

vsxseg6b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg6b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 ac <unknown>

vsxseg6h.v	v8, (a0), v4
# CHECK-INST: vsxseg6h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 ae <unknown>

vsxseg6h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg6h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 ac <unknown>

vsxseg6w.v	v8, (a0), v4
# CHECK-INST: vsxseg6w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 ae <unknown>

vsxseg6w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg6w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 ac <unknown>

vsxseg6e.v	v8, (a0), v4
# CHECK-INST: vsxseg6e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0xae]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 ae <unknown>

vsxseg6e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg6e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0xac]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 ac <unknown>

vlseg7b.v v8, (a0), v0.t
# CHECK-INST: vlseg7b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xd0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 d0 <unknown>

vlseg7b.v v8, (a0)
# CHECK-INST: vlseg7b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xd2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 d2 <unknown>

vlseg7h.v v8, (a0), v0.t
# CHECK-INST: vlseg7h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xd0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 d0 <unknown>

vlseg7h.v v8, (a0)
# CHECK-INST: vlseg7h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xd2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 d2 <unknown>

vlseg7w.v v8, (a0), v0.t
# CHECK-INST: vlseg7w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xd0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 d0 <unknown>

vlseg7w.v v8, (a0)
# CHECK-INST: vlseg7w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xd2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 d2 <unknown>

vlseg7bu.v v8, (a0), v0.t
# CHECK-INST: vlseg7bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 c0 <unknown>

vlseg7bu.v v8, (a0)
# CHECK-INST: vlseg7bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 c2 <unknown>

vlseg7hu.v v8, (a0), v0.t
# CHECK-INST: vlseg7hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 c0 <unknown>

vlseg7hu.v v8, (a0)
# CHECK-INST: vlseg7hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 c2 <unknown>

vlseg7wu.v v8, (a0), v0.t
# CHECK-INST: vlseg7wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 c0 <unknown>

vlseg7wu.v v8, (a0)
# CHECK-INST: vlseg7wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 c2 <unknown>

vlseg7e.v v8, (a0), v0.t
# CHECK-INST: vlseg7e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 c0 <unknown>

vlseg7e.v v8, (a0)
# CHECK-INST: vlseg7e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 c2 <unknown>

vsseg7b.v v8, (a0), v0.t
# CHECK-INST: vsseg7b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 c0 <unknown>

vsseg7b.v v8, (a0)
# CHECK-INST: vsseg7b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 c2 <unknown>

vsseg7h.v v8, (a0), v0.t
# CHECK-INST: vsseg7h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 c0 <unknown>

vsseg7h.v v8, (a0)
# CHECK-INST: vsseg7h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 c2 <unknown>

vsseg7w.v v8, (a0), v0.t
# CHECK-INST: vsseg7w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 c0 <unknown>

vsseg7w.v v8, (a0)
# CHECK-INST: vsseg7w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 c2 <unknown>

vsseg7e.v v8, (a0), v0.t
# CHECK-INST: vsseg7e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0xc0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 c0 <unknown>

vsseg7e.v v8, (a0)
# CHECK-INST: vsseg7e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0xc2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 c2 <unknown>

vlseg7bff.v	v8, (a0)
# CHECK-INST: vlseg7bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xd3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 d3 <unknown>

vlseg7bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg7bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xd1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 d1 <unknown>

vlseg7hff.v	v8, (a0)
# CHECK-INST: vlseg7hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xd3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 d3 <unknown>

vlseg7hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg7hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xd1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 d1 <unknown>

vlseg7wff.v	v8, (a0)
# CHECK-INST: vlseg7wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xd3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 d3 <unknown>

vlseg7wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg7wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xd1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 d1 <unknown>

vlseg7buff.v v8, (a0)
# CHECK-INST: vlseg7buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xc3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 c3 <unknown>

vlseg7buff.v v8, (a0), v0.t
# CHECK-INST: vlseg7buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xc1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 c1 <unknown>

vlseg7huff.v v8, (a0)
# CHECK-INST: vlseg7huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xc3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 c3 <unknown>

vlseg7huff.v v8, (a0), v0.t
# CHECK-INST: vlseg7huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xc1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 c1 <unknown>

vlseg7wuff.v v8, (a0)
# CHECK-INST: vlseg7wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xc3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 c3 <unknown>

vlseg7wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg7wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xc1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 c1 <unknown>

vlseg7eff.v	v8, (a0)
# CHECK-INST: vlseg7eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xc3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 c3 <unknown>

vlseg7eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg7eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xc1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 c1 <unknown>

vlsseg7b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xd8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 d8 <unknown>

vlsseg7b.v v8, (a0), a1
# CHECK-INST: vlsseg7b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xda]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 da <unknown>

vlsseg7h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xd8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 d8 <unknown>

vlsseg7h.v v8, (a0), a1
# CHECK-INST: vlsseg7h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xda]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 da <unknown>

vlsseg7w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xd8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 d8 <unknown>

vlsseg7w.v v8, (a0), a1
# CHECK-INST: vlsseg7w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xda]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 da <unknown>

vlsseg7bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 c8 <unknown>

vlsseg7bu.v v8, (a0), a1
# CHECK-INST: vlsseg7bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 ca <unknown>

vlsseg7hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 c8 <unknown>

vlsseg7hu.v v8, (a0), a1
# CHECK-INST: vlsseg7hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 ca <unknown>

vlsseg7wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 c8 <unknown>

vlsseg7wu.v v8, (a0), a1
# CHECK-INST: vlsseg7wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 ca <unknown>

vlsseg7e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg7e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 c8 <unknown>

vlsseg7e.v v8, (a0), a1
# CHECK-INST: vlsseg7e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 ca <unknown>

vssseg7b.v	v8, (a0), a1
# CHECK-INST: vssseg7b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 ca <unknown>

vssseg7b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg7b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 c8 <unknown>

vssseg7h.v	v8, (a0), a1
# CHECK-INST: vssseg7h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 ca <unknown>

vssseg7h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg7h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 c8 <unknown>

vssseg7w.v	v8, (a0), a1
# CHECK-INST: vssseg7w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 ca <unknown>

vssseg7w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg7w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 c8 <unknown>

vssseg7e.v	v8, (a0), a1
# CHECK-INST: vssseg7e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0xca]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 ca <unknown>

vssseg7e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg7e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0xc8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 c8 <unknown>

vlxseg7b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xdc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 dc <unknown>

vlxseg7b.v v8, (a0), v4
# CHECK-INST: vlxseg7b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xde]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 de <unknown>

vlxseg7h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xdc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 dc <unknown>

vlxseg7h.v v8, (a0), v4
# CHECK-INST: vlxseg7h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xde]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 de <unknown>

vlxseg7w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xdc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 dc <unknown>

vlxseg7w.v v8, (a0), v4
# CHECK-INST: vlxseg7w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xde]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 de <unknown>

vlxseg7bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 cc <unknown>

vlxseg7bu.v v8, (a0), v4
# CHECK-INST: vlxseg7bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 ce <unknown>

vlxseg7hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 cc <unknown>

vlxseg7hu.v v8, (a0), v4
# CHECK-INST: vlxseg7hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 ce <unknown>

vlxseg7wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 cc <unknown>

vlxseg7wu.v v8, (a0), v4
# CHECK-INST: vlxseg7wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 ce <unknown>

vlxseg7e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg7e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 cc <unknown>

vlxseg7e.v v8, (a0), v4
# CHECK-INST: vlxseg7e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 ce <unknown>

vsxseg7b.v	v8, (a0), v4
# CHECK-INST: vsxseg7b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 ce <unknown>

vsxseg7b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg7b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 cc <unknown>

vsxseg7h.v	v8, (a0), v4
# CHECK-INST: vsxseg7h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 ce <unknown>

vsxseg7h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg7h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 cc <unknown>

vsxseg7w.v	v8, (a0), v4
# CHECK-INST: vsxseg7w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 ce <unknown>

vsxseg7w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg7w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 cc <unknown>

vsxseg7e.v	v8, (a0), v4
# CHECK-INST: vsxseg7e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0xce]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 ce <unknown>

vsxseg7e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg7e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0xcc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 cc <unknown>

vlseg8b.v v8, (a0), v0.t
# CHECK-INST: vlseg8b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xf0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 f0 <unknown>

vlseg8b.v v8, (a0)
# CHECK-INST: vlseg8b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xf2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 f2 <unknown>

vlseg8h.v v8, (a0), v0.t
# CHECK-INST: vlseg8h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xf0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 f0 <unknown>

vlseg8h.v v8, (a0)
# CHECK-INST: vlseg8h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xf2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 f2 <unknown>

vlseg8w.v v8, (a0), v0.t
# CHECK-INST: vlseg8w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xf0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 f0 <unknown>

vlseg8w.v v8, (a0)
# CHECK-INST: vlseg8w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xf2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 f2 <unknown>

vlseg8bu.v v8, (a0), v0.t
# CHECK-INST: vlseg8bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 e0 <unknown>

vlseg8bu.v v8, (a0)
# CHECK-INST: vlseg8bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 e2 <unknown>

vlseg8hu.v v8, (a0), v0.t
# CHECK-INST: vlseg8hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 e0 <unknown>

vlseg8hu.v v8, (a0)
# CHECK-INST: vlseg8hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 e2 <unknown>

vlseg8wu.v v8, (a0), v0.t
# CHECK-INST: vlseg8wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 e0 <unknown>

vlseg8wu.v v8, (a0)
# CHECK-INST: vlseg8wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 e2 <unknown>

vlseg8e.v v8, (a0), v0.t
# CHECK-INST: vlseg8e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 e0 <unknown>

vlseg8e.v v8, (a0)
# CHECK-INST: vlseg8e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 e2 <unknown>

vsseg8b.v v8, (a0), v0.t
# CHECK-INST: vsseg8b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 e0 <unknown>

vsseg8b.v v8, (a0)
# CHECK-INST: vsseg8b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 05 e2 <unknown>

vsseg8h.v v8, (a0), v0.t
# CHECK-INST: vsseg8h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 e0 <unknown>

vsseg8h.v v8, (a0)
# CHECK-INST: vsseg8h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 05 e2 <unknown>

vsseg8w.v v8, (a0), v0.t
# CHECK-INST: vsseg8w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 e0 <unknown>

vsseg8w.v v8, (a0)
# CHECK-INST: vsseg8w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 05 e2 <unknown>

vsseg8e.v v8, (a0), v0.t
# CHECK-INST: vsseg8e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0xe0]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 e0 <unknown>

vsseg8e.v v8, (a0)
# CHECK-INST: vsseg8e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0xe2]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 05 e2 <unknown>

vlseg8bff.v	v8, (a0)
# CHECK-INST: vlseg8bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xf3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 f3 <unknown>

vlseg8bff.v	v8, (a0), v0.t
# CHECK-INST: vlseg8bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xf1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 f1 <unknown>

vlseg8hff.v	v8, (a0)
# CHECK-INST: vlseg8hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xf3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 f3 <unknown>

vlseg8hff.v	v8, (a0), v0.t
# CHECK-INST: vlseg8hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xf1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 f1 <unknown>

vlseg8wff.v	v8, (a0)
# CHECK-INST: vlseg8wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xf3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 f3 <unknown>

vlseg8wff.v	v8, (a0), v0.t
# CHECK-INST: vlseg8wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xf1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 f1 <unknown>

vlseg8buff.v v8, (a0)
# CHECK-INST: vlseg8buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xe3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 e3 <unknown>

vlseg8buff.v v8, (a0), v0.t
# CHECK-INST: vlseg8buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xe1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 05 e1 <unknown>

vlseg8huff.v v8, (a0)
# CHECK-INST: vlseg8huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xe3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 e3 <unknown>

vlseg8huff.v v8, (a0), v0.t
# CHECK-INST: vlseg8huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xe1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 05 e1 <unknown>

vlseg8wuff.v v8, (a0)
# CHECK-INST: vlseg8wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xe3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 e3 <unknown>

vlseg8wuff.v v8, (a0), v0.t
# CHECK-INST: vlseg8wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xe1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 05 e1 <unknown>

vlseg8eff.v	v8, (a0)
# CHECK-INST: vlseg8eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xe3]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 e3 <unknown>

vlseg8eff.v	v8, (a0), v0.t
# CHECK-INST: vlseg8eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xe1]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 05 e1 <unknown>

vlsseg8b.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xf8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 f8 <unknown>

vlsseg8b.v v8, (a0), a1
# CHECK-INST: vlsseg8b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xfa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 fa <unknown>

vlsseg8h.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xf8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 f8 <unknown>

vlsseg8h.v v8, (a0), a1
# CHECK-INST: vlsseg8h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xfa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 fa <unknown>

vlsseg8w.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xf8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 f8 <unknown>

vlsseg8w.v v8, (a0), a1
# CHECK-INST: vlsseg8w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xfa]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 fa <unknown>

vlsseg8bu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 e8 <unknown>

vlsseg8bu.v v8, (a0), a1
# CHECK-INST: vlsseg8bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 b5 ea <unknown>

vlsseg8hu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 e8 <unknown>

vlsseg8hu.v v8, (a0), a1
# CHECK-INST: vlsseg8hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 b5 ea <unknown>

vlsseg8wu.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 e8 <unknown>

vlsseg8wu.v v8, (a0), a1
# CHECK-INST: vlsseg8wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 b5 ea <unknown>

vlsseg8e.v v8, (a0), a1, v0.t
# CHECK-INST: vlsseg8e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 e8 <unknown>

vlsseg8e.v v8, (a0), a1
# CHECK-INST: vlsseg8e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 b5 ea <unknown>

vssseg8b.v	v8, (a0), a1
# CHECK-INST: vssseg8b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 ea <unknown>

vssseg8b.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg8b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 b5 e8 <unknown>

vssseg8h.v	v8, (a0), a1
# CHECK-INST: vssseg8h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 ea <unknown>

vssseg8h.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg8h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 b5 e8 <unknown>

vssseg8w.v	v8, (a0), a1
# CHECK-INST: vssseg8w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 ea <unknown>

vssseg8w.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg8w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 b5 e8 <unknown>

vssseg8e.v	v8, (a0), a1
# CHECK-INST: vssseg8e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0xea]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 ea <unknown>

vssseg8e.v	v8, (a0), a1, v0.t
# CHECK-INST: vssseg8e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0xe8]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 b5 e8 <unknown>

vlxseg8b.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xfc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 fc <unknown>

vlxseg8b.v v8, (a0), v4
# CHECK-INST: vlxseg8b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xfe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 fe <unknown>

vlxseg8h.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xfc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 fc <unknown>

vlxseg8h.v v8, (a0), v4
# CHECK-INST: vlxseg8h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xfe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 fe <unknown>

vlxseg8w.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xfc]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 fc <unknown>

vlxseg8w.v v8, (a0), v4
# CHECK-INST: vlxseg8w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xfe]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 fe <unknown>

vlxseg8bu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 ec <unknown>

vlxseg8bu.v v8, (a0), v4
# CHECK-INST: vlxseg8bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 04 45 ee <unknown>

vlxseg8hu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 ec <unknown>

vlxseg8hu.v v8, (a0), v4
# CHECK-INST: vlxseg8hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 54 45 ee <unknown>

vlxseg8wu.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 ec <unknown>

vlxseg8wu.v v8, (a0), v4
# CHECK-INST: vlxseg8wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 64 45 ee <unknown>

vlxseg8e.v v8, (a0), v4, v0.t
# CHECK-INST: vlxseg8e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 ec <unknown>

vlxseg8e.v v8, (a0), v4
# CHECK-INST: vlxseg8e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 07 74 45 ee <unknown>

vsxseg8b.v	v8, (a0), v4
# CHECK-INST: vsxseg8b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 ee <unknown>

vsxseg8b.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg8b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 04 45 ec <unknown>

vsxseg8h.v	v8, (a0), v4
# CHECK-INST: vsxseg8h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 ee <unknown>

vsxseg8h.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg8h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 54 45 ec <unknown>

vsxseg8w.v	v8, (a0), v4
# CHECK-INST: vsxseg8w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 ee <unknown>

vsxseg8w.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg8w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 64 45 ec <unknown>

vsxseg8e.v	v8, (a0), v4
# CHECK-INST: vsxseg8e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0xee]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 ee <unknown>

vsxseg8e.v	v8, (a0), v4, v0.t
# CHECK-INST: vsxseg8e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0xec]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 27 74 45 ec <unknown>
