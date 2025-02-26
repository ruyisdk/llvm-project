# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:   --riscv-no-aliases \
# RUN:   | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:   | llvm-objdump -d --mattr=+xtheadvector --no-print-imm-hex -M no-aliases - \
# RUN:   | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:   | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

th.vlseg2b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x30]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 30050407 <unknown>

th.vlseg2b.v v8, (a0)
# CHECK-INST: th.vlseg2b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x32]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 32050407 <unknown>

th.vlseg2h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x30]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 30055407 <unknown>

th.vlseg2h.v v8, (a0)
# CHECK-INST: th.vlseg2h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x32]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 32055407 <unknown>

th.vlseg2w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x30]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 30056407 <unknown>

th.vlseg2w.v v8, (a0)
# CHECK-INST: th.vlseg2w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x32]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 32056407 <unknown>

th.vlseg2bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20050407 <unknown>

th.vlseg2bu.v v8, (a0)
# CHECK-INST: th.vlseg2bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22050407 <unknown>

th.vlseg2hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20055407 <unknown>

th.vlseg2hu.v v8, (a0)
# CHECK-INST: th.vlseg2hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22055407 <unknown>

th.vlseg2wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20056407 <unknown>

th.vlseg2wu.v v8, (a0)
# CHECK-INST: th.vlseg2wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22056407 <unknown>

th.vlseg2e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20057407 <unknown>

th.vlseg2e.v v8, (a0)
# CHECK-INST: th.vlseg2e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22057407 <unknown>

th.vsseg2b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg2b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20050427 <unknown>

th.vsseg2b.v v8, (a0)
# CHECK-INST: th.vsseg2b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22050427 <unknown>

th.vsseg2h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg2h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20055427 <unknown>

th.vsseg2h.v v8, (a0)
# CHECK-INST: th.vsseg2h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22055427 <unknown>

th.vsseg2w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg2w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20056427 <unknown>

th.vsseg2w.v v8, (a0)
# CHECK-INST: th.vsseg2w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22056427 <unknown>

th.vsseg2e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg2e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x20]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 20057427 <unknown>

th.vsseg2e.v v8, (a0)
# CHECK-INST: th.vsseg2e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x22]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 22057427 <unknown>

th.vlseg2bff.v	v8, (a0)
# CHECK-INST: th.vlseg2bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x33]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 33050407 <unknown>

th.vlseg2bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg2bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x31]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 31050407 <unknown>

th.vlseg2hff.v	v8, (a0)
# CHECK-INST: th.vlseg2hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x33]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 33055407 <unknown>

th.vlseg2hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg2hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x31]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 31055407 <unknown>

th.vlseg2wff.v	v8, (a0)
# CHECK-INST: th.vlseg2wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x33]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 33056407 <unknown>

th.vlseg2wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg2wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x31]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 31056407 <unknown>

th.vlseg2buff.v v8, (a0)
# CHECK-INST: th.vlseg2buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x23]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 23050407 <unknown>

th.vlseg2buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x21]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 21050407 <unknown>

th.vlseg2huff.v v8, (a0)
# CHECK-INST: th.vlseg2huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x23]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 23055407 <unknown>

th.vlseg2huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x21]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 21055407 <unknown>

th.vlseg2wuff.v v8, (a0)
# CHECK-INST: th.vlseg2wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x23]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 23056407 <unknown>

th.vlseg2wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg2wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x21]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 21056407 <unknown>

th.vlseg2eff.v	v8, (a0)
# CHECK-INST: th.vlseg2eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x23]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 23057407 <unknown>

th.vlseg2eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg2eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x21]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 21057407 <unknown>

th.vlsseg2b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x38]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 38b50407 <unknown>

th.vlsseg2b.v v8, (a0), a1
# CHECK-INST: th.vlsseg2b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x3a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3ab50407 <unknown>

th.vlsseg2h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x38]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 38b55407 <unknown>

th.vlsseg2h.v v8, (a0), a1
# CHECK-INST: th.vlsseg2h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x3a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3ab55407 <unknown>

th.vlsseg2w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x38]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 38b56407 <unknown>

th.vlsseg2w.v v8, (a0), a1
# CHECK-INST: th.vlsseg2w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x3a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3ab56407 <unknown>

th.vlsseg2bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b50407 <unknown>

th.vlsseg2bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg2bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab50407 <unknown>

th.vlsseg2hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b55407 <unknown>

th.vlsseg2hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg2hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab55407 <unknown>

th.vlsseg2wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b56407 <unknown>

th.vlsseg2wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg2wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab56407 <unknown>

th.vlsseg2e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg2e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b57407 <unknown>

th.vlsseg2e.v v8, (a0), a1
# CHECK-INST: th.vlsseg2e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab57407 <unknown>

th.vssseg2b.v	v8, (a0), a1
# CHECK-INST: th.vssseg2b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab50427 <unknown>

th.vssseg2b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg2b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b50427 <unknown>

th.vssseg2h.v	v8, (a0), a1
# CHECK-INST: th.vssseg2h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab55427 <unknown>

th.vssseg2h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg2h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b55427 <unknown>

th.vssseg2w.v	v8, (a0), a1
# CHECK-INST: th.vssseg2w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab56427 <unknown>

th.vssseg2w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg2w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b56427 <unknown>

th.vssseg2e.v	v8, (a0), a1
# CHECK-INST: th.vssseg2e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x2a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2ab57427 <unknown>

th.vssseg2e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg2e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x28]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 28b57427 <unknown>

th.vlxseg2b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x3c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3c450407 <unknown>

th.vlxseg2b.v v8, (a0), v4
# CHECK-INST: th.vlxseg2b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x3e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3e450407 <unknown>

th.vlxseg2h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x3c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3c455407 <unknown>

th.vlxseg2h.v v8, (a0), v4
# CHECK-INST: th.vlxseg2h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x3e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3e455407 <unknown>

th.vlxseg2w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x3c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3c456407 <unknown>

th.vlxseg2w.v v8, (a0), v4
# CHECK-INST: th.vlxseg2w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x3e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 3e456407 <unknown>

th.vlxseg2bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c450407 <unknown>

th.vlxseg2bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg2bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e450407 <unknown>

th.vlxseg2hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c455407 <unknown>

th.vlxseg2hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg2hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e455407 <unknown>

th.vlxseg2wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c456407 <unknown>

th.vlxseg2wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg2wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e456407 <unknown>

th.vlxseg2e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg2e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c457407 <unknown>

th.vlxseg2e.v v8, (a0), v4
# CHECK-INST: th.vlxseg2e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e457407 <unknown>

th.vsxseg2b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg2b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e450427 <unknown>

th.vsxseg2b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg2b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c450427 <unknown>

th.vsxseg2h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg2h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e455427 <unknown>

th.vsxseg2h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg2h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c455427 <unknown>

th.vsxseg2w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg2w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e456427 <unknown>

th.vsxseg2w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg2w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c456427 <unknown>

th.vsxseg2e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg2e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x2e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2e457427 <unknown>

th.vsxseg2e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg2e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x2c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 2c457427 <unknown>

th.vlseg3b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x50]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 50050407 <unknown>

th.vlseg3b.v v8, (a0)
# CHECK-INST: th.vlseg3b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x52]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 52050407 <unknown>

th.vlseg3h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x50]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 50055407 <unknown>

th.vlseg3h.v v8, (a0)
# CHECK-INST: th.vlseg3h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x52]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 52055407 <unknown>

th.vlseg3w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x50]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 50056407 <unknown>

th.vlseg3w.v v8, (a0)
# CHECK-INST: th.vlseg3w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x52]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 52056407 <unknown>

th.vlseg3bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40050407 <unknown>

th.vlseg3bu.v v8, (a0)
# CHECK-INST: th.vlseg3bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42050407 <unknown>

th.vlseg3hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40055407 <unknown>

th.vlseg3hu.v v8, (a0)
# CHECK-INST: th.vlseg3hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42055407 <unknown>

th.vlseg3wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40056407 <unknown>

th.vlseg3wu.v v8, (a0)
# CHECK-INST: th.vlseg3wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42056407 <unknown>

th.vlseg3e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40057407 <unknown>

th.vlseg3e.v v8, (a0)
# CHECK-INST: th.vlseg3e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42057407 <unknown>

th.vsseg3b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg3b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40050427 <unknown>

th.vsseg3b.v v8, (a0)
# CHECK-INST: th.vsseg3b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42050427 <unknown>

th.vsseg3h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg3h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40055427 <unknown>

th.vsseg3h.v v8, (a0)
# CHECK-INST: th.vsseg3h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42055427 <unknown>

th.vsseg3w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg3w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40056427 <unknown>

th.vsseg3w.v v8, (a0)
# CHECK-INST: th.vsseg3w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42056427 <unknown>

th.vsseg3e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg3e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x40]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 40057427 <unknown>

th.vsseg3e.v v8, (a0)
# CHECK-INST: th.vsseg3e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x42]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 42057427 <unknown>

th.vlseg3bff.v	v8, (a0)
# CHECK-INST: th.vlseg3bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x53]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 53050407 <unknown>

th.vlseg3bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg3bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x51]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 51050407 <unknown>

th.vlseg3hff.v	v8, (a0)
# CHECK-INST: th.vlseg3hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x53]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 53055407 <unknown>

th.vlseg3hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg3hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x51]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 51055407 <unknown>

th.vlseg3wff.v	v8, (a0)
# CHECK-INST: th.vlseg3wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x53]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 53056407 <unknown>

th.vlseg3wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg3wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x51]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 51056407 <unknown>

th.vlseg3buff.v v8, (a0)
# CHECK-INST: th.vlseg3buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x43]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 43050407 <unknown>

th.vlseg3buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x41]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 41050407 <unknown>

th.vlseg3huff.v v8, (a0)
# CHECK-INST: th.vlseg3huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x43]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 43055407 <unknown>

th.vlseg3huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x41]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 41055407 <unknown>

th.vlseg3wuff.v v8, (a0)
# CHECK-INST: th.vlseg3wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x43]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 43056407 <unknown>

th.vlseg3wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg3wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x41]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 41056407 <unknown>

th.vlseg3eff.v	v8, (a0)
# CHECK-INST: th.vlseg3eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x43]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 43057407 <unknown>

th.vlseg3eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg3eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x41]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 41057407 <unknown>

th.vlsseg3b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 58b50407 <unknown>

th.vlsseg3b.v v8, (a0), a1
# CHECK-INST: th.vlsseg3b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5ab50407 <unknown>

th.vlsseg3h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 58b55407 <unknown>

th.vlsseg3h.v v8, (a0), a1
# CHECK-INST: th.vlsseg3h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5ab55407 <unknown>

th.vlsseg3w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x58]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 58b56407 <unknown>

th.vlsseg3w.v v8, (a0), a1
# CHECK-INST: th.vlsseg3w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x5a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5ab56407 <unknown>

th.vlsseg3bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b50407 <unknown>

th.vlsseg3bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg3bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab50407 <unknown>

th.vlsseg3hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b55407 <unknown>

th.vlsseg3hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg3hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab55407 <unknown>

th.vlsseg3wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b56407 <unknown>

th.vlsseg3wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg3wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab56407 <unknown>

th.vlsseg3e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg3e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b57407 <unknown>

th.vlsseg3e.v v8, (a0), a1
# CHECK-INST: th.vlsseg3e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab57407 <unknown>

th.vssseg3b.v	v8, (a0), a1
# CHECK-INST: th.vssseg3b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab50427 <unknown>

th.vssseg3b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg3b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b50427 <unknown>

th.vssseg3h.v	v8, (a0), a1
# CHECK-INST: th.vssseg3h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab55427 <unknown>

th.vssseg3h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg3h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b55427 <unknown>

th.vssseg3w.v	v8, (a0), a1
# CHECK-INST: th.vssseg3w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab56427 <unknown>

th.vssseg3w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg3w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b56427 <unknown>

th.vssseg3e.v	v8, (a0), a1
# CHECK-INST: th.vssseg3e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x4a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4ab57427 <unknown>

th.vssseg3e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg3e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x48]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 48b57427 <unknown>

th.vlxseg3b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x5c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5c450407 <unknown>

th.vlxseg3b.v v8, (a0), v4
# CHECK-INST: th.vlxseg3b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x5e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5e450407 <unknown>

th.vlxseg3h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x5c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5c455407 <unknown>

th.vlxseg3h.v v8, (a0), v4
# CHECK-INST: th.vlxseg3h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x5e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5e455407 <unknown>

th.vlxseg3w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x5c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5c456407 <unknown>

th.vlxseg3w.v v8, (a0), v4
# CHECK-INST: th.vlxseg3w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x5e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 5e456407 <unknown>

th.vlxseg3bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c450407 <unknown>

th.vlxseg3bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg3bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e450407 <unknown>

th.vlxseg3hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c455407 <unknown>

th.vlxseg3hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg3hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e455407 <unknown>

th.vlxseg3wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c456407 <unknown>

th.vlxseg3wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg3wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e456407 <unknown>

th.vlxseg3e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg3e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c457407 <unknown>

th.vlxseg3e.v v8, (a0), v4
# CHECK-INST: th.vlxseg3e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e457407 <unknown>

th.vsxseg3b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg3b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e450427 <unknown>

th.vsxseg3b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg3b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c450427 <unknown>

th.vsxseg3h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg3h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e455427 <unknown>

th.vsxseg3h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg3h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c455427 <unknown>

th.vsxseg3w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg3w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e456427 <unknown>

th.vsxseg3w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg3w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c456427 <unknown>

th.vsxseg3e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg3e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x4e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4e457427 <unknown>

th.vsxseg3e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg3e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x4c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 4c457427 <unknown>

th.vlseg4b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x70]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 70050407 <unknown>

th.vlseg4b.v v8, (a0)
# CHECK-INST: th.vlseg4b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x72]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 72050407 <unknown>

th.vlseg4h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x70]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 70055407 <unknown>

th.vlseg4h.v v8, (a0)
# CHECK-INST: th.vlseg4h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x72]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 72055407 <unknown>

th.vlseg4w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x70]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 70056407 <unknown>

th.vlseg4w.v v8, (a0)
# CHECK-INST: th.vlseg4w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x72]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 72056407 <unknown>

th.vlseg4bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60050407 <unknown>

th.vlseg4bu.v v8, (a0)
# CHECK-INST: th.vlseg4bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62050407 <unknown>

th.vlseg4hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60055407 <unknown>

th.vlseg4hu.v v8, (a0)
# CHECK-INST: th.vlseg4hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62055407 <unknown>

th.vlseg4wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60056407 <unknown>

th.vlseg4wu.v v8, (a0)
# CHECK-INST: th.vlseg4wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62056407 <unknown>

th.vlseg4e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60057407 <unknown>

th.vlseg4e.v v8, (a0)
# CHECK-INST: th.vlseg4e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62057407 <unknown>

th.vsseg4b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg4b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60050427 <unknown>

th.vsseg4b.v v8, (a0)
# CHECK-INST: th.vsseg4b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62050427 <unknown>

th.vsseg4h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg4h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60055427 <unknown>

th.vsseg4h.v v8, (a0)
# CHECK-INST: th.vsseg4h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62055427 <unknown>

th.vsseg4w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg4w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60056427 <unknown>

th.vsseg4w.v v8, (a0)
# CHECK-INST: th.vsseg4w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62056427 <unknown>

th.vsseg4e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg4e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x60]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 60057427 <unknown>

th.vsseg4e.v v8, (a0)
# CHECK-INST: th.vsseg4e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x62]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 62057427 <unknown>

th.vlseg4bff.v	v8, (a0)
# CHECK-INST: th.vlseg4bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x73]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 73050407 <unknown>

th.vlseg4bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg4bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x71]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 71050407 <unknown>

th.vlseg4hff.v	v8, (a0)
# CHECK-INST: th.vlseg4hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x73]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 73055407 <unknown>

th.vlseg4hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg4hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x71]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 71055407 <unknown>

th.vlseg4wff.v	v8, (a0)
# CHECK-INST: th.vlseg4wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x73]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 73056407 <unknown>

th.vlseg4wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg4wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x71]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 71056407 <unknown>

th.vlseg4buff.v v8, (a0)
# CHECK-INST: th.vlseg4buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x63]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 63050407 <unknown>

th.vlseg4buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x61]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 61050407 <unknown>

th.vlseg4huff.v v8, (a0)
# CHECK-INST: th.vlseg4huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x63]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 63055407 <unknown>

th.vlseg4huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x61]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 61055407 <unknown>

th.vlseg4wuff.v v8, (a0)
# CHECK-INST: th.vlseg4wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x63]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 63056407 <unknown>

th.vlseg4wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg4wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x61]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 61056407 <unknown>

th.vlseg4eff.v	v8, (a0)
# CHECK-INST: th.vlseg4eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x63]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 63057407 <unknown>

th.vlseg4eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg4eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x61]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 61057407 <unknown>

th.vlsseg4b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x78]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 78b50407 <unknown>

th.vlsseg4b.v v8, (a0), a1
# CHECK-INST: th.vlsseg4b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x7a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7ab50407 <unknown>

th.vlsseg4h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x78]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 78b55407 <unknown>

th.vlsseg4h.v v8, (a0), a1
# CHECK-INST: th.vlsseg4h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x7a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7ab55407 <unknown>

th.vlsseg4w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x78]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 78b56407 <unknown>

th.vlsseg4w.v v8, (a0), a1
# CHECK-INST: th.vlsseg4w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x7a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7ab56407 <unknown>

th.vlsseg4bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b50407 <unknown>

th.vlsseg4bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg4bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab50407 <unknown>

th.vlsseg4hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b55407 <unknown>

th.vlsseg4hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg4hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab55407 <unknown>

th.vlsseg4wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b56407 <unknown>

th.vlsseg4wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg4wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab56407 <unknown>

th.vlsseg4e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg4e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b57407 <unknown>

th.vlsseg4e.v v8, (a0), a1
# CHECK-INST: th.vlsseg4e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab57407 <unknown>

th.vssseg4b.v	v8, (a0), a1
# CHECK-INST: th.vssseg4b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab50427 <unknown>

th.vssseg4b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg4b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b50427 <unknown>

th.vssseg4h.v	v8, (a0), a1
# CHECK-INST: th.vssseg4h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab55427 <unknown>

th.vssseg4h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg4h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b55427 <unknown>

th.vssseg4w.v	v8, (a0), a1
# CHECK-INST: th.vssseg4w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab56427 <unknown>

th.vssseg4w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg4w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b56427 <unknown>

th.vssseg4e.v	v8, (a0), a1
# CHECK-INST: th.vssseg4e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x6a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6ab57427 <unknown>

th.vssseg4e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg4e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x68]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 68b57427 <unknown>

th.vlxseg4b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x7c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7c450407 <unknown>

th.vlxseg4b.v v8, (a0), v4
# CHECK-INST: th.vlxseg4b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x7e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7e450407 <unknown>

th.vlxseg4h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x7c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7c455407 <unknown>

th.vlxseg4h.v v8, (a0), v4
# CHECK-INST: th.vlxseg4h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x7e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7e455407 <unknown>

th.vlxseg4w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x7c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7c456407 <unknown>

th.vlxseg4w.v v8, (a0), v4
# CHECK-INST: th.vlxseg4w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x7e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 7e456407 <unknown>

th.vlxseg4bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c450407 <unknown>

th.vlxseg4bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg4bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e450407 <unknown>

th.vlxseg4hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c455407 <unknown>

th.vlxseg4hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg4hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e455407 <unknown>

th.vlxseg4wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c456407 <unknown>

th.vlxseg4wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg4wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e456407 <unknown>

th.vlxseg4e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg4e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c457407 <unknown>

th.vlxseg4e.v v8, (a0), v4
# CHECK-INST: th.vlxseg4e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e457407 <unknown>

th.vsxseg4b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg4b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e450427 <unknown>

th.vsxseg4b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg4b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c450427 <unknown>

th.vsxseg4h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg4h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e455427 <unknown>

th.vsxseg4h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg4h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c455427 <unknown>

th.vsxseg4w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg4w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e456427 <unknown>

th.vsxseg4w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg4w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c456427 <unknown>

th.vsxseg4e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg4e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6e457427 <unknown>

th.vsxseg4e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg4e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 6c457427 <unknown>

th.vlseg5b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x90]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 90050407 <unknown>

th.vlseg5b.v v8, (a0)
# CHECK-INST: th.vlseg5b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x92]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 92050407 <unknown>

th.vlseg5h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x90]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 90055407 <unknown>

th.vlseg5h.v v8, (a0)
# CHECK-INST: th.vlseg5h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x92]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 92055407 <unknown>

th.vlseg5w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x90]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 90056407 <unknown>

th.vlseg5w.v v8, (a0)
# CHECK-INST: th.vlseg5w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x92]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 92056407 <unknown>

th.vlseg5bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80050407 <unknown>

th.vlseg5bu.v v8, (a0)
# CHECK-INST: th.vlseg5bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82050407 <unknown>

th.vlseg5hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80055407 <unknown>

th.vlseg5hu.v v8, (a0)
# CHECK-INST: th.vlseg5hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82055407 <unknown>

th.vlseg5wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80056407 <unknown>

th.vlseg5wu.v v8, (a0)
# CHECK-INST: th.vlseg5wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82056407 <unknown>

th.vlseg5e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80057407 <unknown>

th.vlseg5e.v v8, (a0)
# CHECK-INST: th.vlseg5e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82057407 <unknown>

th.vsseg5b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg5b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80050427 <unknown>

th.vsseg5b.v v8, (a0)
# CHECK-INST: th.vsseg5b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82050427 <unknown>

th.vsseg5h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg5h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80055427 <unknown>

th.vsseg5h.v v8, (a0)
# CHECK-INST: th.vsseg5h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82055427 <unknown>

th.vsseg5w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg5w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80056427 <unknown>

th.vsseg5w.v v8, (a0)
# CHECK-INST: th.vsseg5w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82056427 <unknown>

th.vsseg5e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg5e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0x80]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 80057427 <unknown>

th.vsseg5e.v v8, (a0)
# CHECK-INST: th.vsseg5e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0x82]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 82057427 <unknown>

th.vlseg5bff.v	v8, (a0)
# CHECK-INST: th.vlseg5bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x93]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 93050407 <unknown>

th.vlseg5bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg5bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x91]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 91050407 <unknown>

th.vlseg5hff.v	v8, (a0)
# CHECK-INST: th.vlseg5hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x93]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 93055407 <unknown>

th.vlseg5hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg5hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x91]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 91055407 <unknown>

th.vlseg5wff.v	v8, (a0)
# CHECK-INST: th.vlseg5wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x93]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 93056407 <unknown>

th.vlseg5wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg5wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x91]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 91056407 <unknown>

th.vlseg5buff.v v8, (a0)
# CHECK-INST: th.vlseg5buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0x83]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 83050407 <unknown>

th.vlseg5buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0x81]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 81050407 <unknown>

th.vlseg5huff.v v8, (a0)
# CHECK-INST: th.vlseg5huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0x83]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 83055407 <unknown>

th.vlseg5huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0x81]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 81055407 <unknown>

th.vlseg5wuff.v v8, (a0)
# CHECK-INST: th.vlseg5wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0x83]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 83056407 <unknown>

th.vlseg5wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg5wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0x81]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 81056407 <unknown>

th.vlseg5eff.v	v8, (a0)
# CHECK-INST: th.vlseg5eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0x83]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 83057407 <unknown>

th.vlseg5eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg5eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0x81]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 81057407 <unknown>

th.vlsseg5b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x98]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 98b50407 <unknown>

th.vlsseg5b.v v8, (a0), a1
# CHECK-INST: th.vlsseg5b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x9a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9ab50407 <unknown>

th.vlsseg5h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x98]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 98b55407 <unknown>

th.vlsseg5h.v v8, (a0), a1
# CHECK-INST: th.vlsseg5h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x9a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9ab55407 <unknown>

th.vlsseg5w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x98]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 98b56407 <unknown>

th.vlsseg5w.v v8, (a0), a1
# CHECK-INST: th.vlsseg5w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x9a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9ab56407 <unknown>

th.vlsseg5bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b50407 <unknown>

th.vlsseg5bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg5bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab50407 <unknown>

th.vlsseg5hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b55407 <unknown>

th.vlsseg5hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg5hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab55407 <unknown>

th.vlsseg5wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b56407 <unknown>

th.vlsseg5wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg5wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab56407 <unknown>

th.vlsseg5e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg5e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b57407 <unknown>

th.vlsseg5e.v v8, (a0), a1
# CHECK-INST: th.vlsseg5e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab57407 <unknown>

th.vssseg5b.v	v8, (a0), a1
# CHECK-INST: th.vssseg5b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab50427 <unknown>

th.vssseg5b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg5b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b50427 <unknown>

th.vssseg5h.v	v8, (a0), a1
# CHECK-INST: th.vssseg5h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab55427 <unknown>

th.vssseg5h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg5h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b55427 <unknown>

th.vssseg5w.v	v8, (a0), a1
# CHECK-INST: th.vssseg5w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab56427 <unknown>

th.vssseg5w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg5w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b56427 <unknown>

th.vssseg5e.v	v8, (a0), a1
# CHECK-INST: th.vssseg5e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0x8a]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8ab57427 <unknown>

th.vssseg5e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg5e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0x88]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 88b57427 <unknown>

th.vlxseg5b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x9c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9c450407 <unknown>

th.vlxseg5b.v v8, (a0), v4
# CHECK-INST: th.vlxseg5b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x9e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9e450407 <unknown>

th.vlxseg5h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x9c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9c455407 <unknown>

th.vlxseg5h.v v8, (a0), v4
# CHECK-INST: th.vlxseg5h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x9e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9e455407 <unknown>

th.vlxseg5w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x9c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9c456407 <unknown>

th.vlxseg5w.v v8, (a0), v4
# CHECK-INST: th.vlxseg5w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x9e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 9e456407 <unknown>

th.vlxseg5bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c450407 <unknown>

th.vlxseg5bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg5bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e450407 <unknown>

th.vlxseg5hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c455407 <unknown>

th.vlxseg5hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg5hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e455407 <unknown>

th.vlxseg5wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c456407 <unknown>

th.vlxseg5wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg5wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e456407 <unknown>

th.vlxseg5e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg5e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c457407 <unknown>

th.vlxseg5e.v v8, (a0), v4
# CHECK-INST: th.vlxseg5e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e457407 <unknown>

th.vsxseg5b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg5b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e450427 <unknown>

th.vsxseg5b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg5b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c450427 <unknown>

th.vsxseg5h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg5h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e455427 <unknown>

th.vsxseg5h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg5h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c455427 <unknown>

th.vsxseg5w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg5w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e456427 <unknown>

th.vsxseg5w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg5w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c456427 <unknown>

th.vsxseg5e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg5e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0x8e]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8e457427 <unknown>

th.vsxseg5e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg5e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0x8c]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: 8c457427 <unknown>

th.vlseg6b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b0050407 <unknown>

th.vlseg6b.v v8, (a0)
# CHECK-INST: th.vlseg6b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xb2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b2050407 <unknown>

th.vlseg6h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b0055407 <unknown>

th.vlseg6h.v v8, (a0)
# CHECK-INST: th.vlseg6h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xb2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b2055407 <unknown>

th.vlseg6w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xb0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b0056407 <unknown>

th.vlseg6w.v v8, (a0)
# CHECK-INST: th.vlseg6w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xb2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b2056407 <unknown>

th.vlseg6bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0050407 <unknown>

th.vlseg6bu.v v8, (a0)
# CHECK-INST: th.vlseg6bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2050407 <unknown>

th.vlseg6hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0055407 <unknown>

th.vlseg6hu.v v8, (a0)
# CHECK-INST: th.vlseg6hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2055407 <unknown>

th.vlseg6wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0056407 <unknown>

th.vlseg6wu.v v8, (a0)
# CHECK-INST: th.vlseg6wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2056407 <unknown>

th.vlseg6e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0057407 <unknown>

th.vlseg6e.v v8, (a0)
# CHECK-INST: th.vlseg6e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2057407 <unknown>

th.vsseg6b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg6b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0050427 <unknown>

th.vsseg6b.v v8, (a0)
# CHECK-INST: th.vsseg6b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2050427 <unknown>

th.vsseg6h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg6h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0055427 <unknown>

th.vsseg6h.v v8, (a0)
# CHECK-INST: th.vsseg6h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2055427 <unknown>

th.vsseg6w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg6w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0056427 <unknown>

th.vsseg6w.v v8, (a0)
# CHECK-INST: th.vsseg6w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2056427 <unknown>

th.vsseg6e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg6e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0xa0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a0057427 <unknown>

th.vsseg6e.v v8, (a0)
# CHECK-INST: th.vsseg6e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0xa2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a2057427 <unknown>

th.vlseg6bff.v	v8, (a0)
# CHECK-INST: th.vlseg6bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xb3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b3050407 <unknown>

th.vlseg6bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg6bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xb1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b1050407 <unknown>

th.vlseg6hff.v	v8, (a0)
# CHECK-INST: th.vlseg6hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xb3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b3055407 <unknown>

th.vlseg6hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg6hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xb1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b1055407 <unknown>

th.vlseg6wff.v	v8, (a0)
# CHECK-INST: th.vlseg6wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xb3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b3056407 <unknown>

th.vlseg6wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg6wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xb1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b1056407 <unknown>

th.vlseg6buff.v v8, (a0)
# CHECK-INST: th.vlseg6buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xa3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a3050407 <unknown>

th.vlseg6buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xa1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a1050407 <unknown>

th.vlseg6huff.v v8, (a0)
# CHECK-INST: th.vlseg6huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xa3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a3055407 <unknown>

th.vlseg6huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xa1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a1055407 <unknown>

th.vlseg6wuff.v v8, (a0)
# CHECK-INST: th.vlseg6wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xa3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a3056407 <unknown>

th.vlseg6wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg6wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xa1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a1056407 <unknown>

th.vlseg6eff.v	v8, (a0)
# CHECK-INST: th.vlseg6eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xa3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a3057407 <unknown>

th.vlseg6eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg6eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xa1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a1057407 <unknown>

th.vlsseg6b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xb8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b8b50407 <unknown>

th.vlsseg6b.v v8, (a0), a1
# CHECK-INST: th.vlsseg6b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xba]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bab50407 <unknown>

th.vlsseg6h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xb8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b8b55407 <unknown>

th.vlsseg6h.v v8, (a0), a1
# CHECK-INST: th.vlsseg6h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xba]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bab55407 <unknown>

th.vlsseg6w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xb8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: b8b56407 <unknown>

th.vlsseg6w.v v8, (a0), a1
# CHECK-INST: th.vlsseg6w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xba]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bab56407 <unknown>

th.vlsseg6bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b50407 <unknown>

th.vlsseg6bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg6bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab50407 <unknown>

th.vlsseg6hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b55407 <unknown>

th.vlsseg6hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg6hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab55407 <unknown>

th.vlsseg6wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b56407 <unknown>

th.vlsseg6wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg6wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab56407 <unknown>

th.vlsseg6e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg6e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b57407 <unknown>

th.vlsseg6e.v v8, (a0), a1
# CHECK-INST: th.vlsseg6e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab57407 <unknown>

th.vssseg6b.v	v8, (a0), a1
# CHECK-INST: th.vssseg6b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab50427 <unknown>

th.vssseg6b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg6b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b50427 <unknown>

th.vssseg6h.v	v8, (a0), a1
# CHECK-INST: th.vssseg6h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab55427 <unknown>

th.vssseg6h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg6h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b55427 <unknown>

th.vssseg6w.v	v8, (a0), a1
# CHECK-INST: th.vssseg6w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab56427 <unknown>

th.vssseg6w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg6w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b56427 <unknown>

th.vssseg6e.v	v8, (a0), a1
# CHECK-INST: th.vssseg6e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0xaa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: aab57427 <unknown>

th.vssseg6e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg6e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0xa8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: a8b57427 <unknown>

th.vlxseg6b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc450407 <unknown>

th.vlxseg6b.v v8, (a0), v4
# CHECK-INST: th.vlxseg6b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be450407 <unknown>

th.vlxseg6h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc455407 <unknown>

th.vlxseg6h.v v8, (a0), v4
# CHECK-INST: th.vlxseg6h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be455407 <unknown>

th.vlxseg6w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xbc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: bc456407 <unknown>

th.vlxseg6w.v v8, (a0), v4
# CHECK-INST: th.vlxseg6w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xbe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: be456407 <unknown>

th.vlxseg6bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac450407 <unknown>

th.vlxseg6bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg6bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae450407 <unknown>

th.vlxseg6hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac455407 <unknown>

th.vlxseg6hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg6hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae455407 <unknown>

th.vlxseg6wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac456407 <unknown>

th.vlxseg6wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg6wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae456407 <unknown>

th.vlxseg6e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg6e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac457407 <unknown>

th.vlxseg6e.v v8, (a0), v4
# CHECK-INST: th.vlxseg6e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae457407 <unknown>

th.vsxseg6b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg6b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae450427 <unknown>

th.vsxseg6b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg6b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac450427 <unknown>

th.vsxseg6h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg6h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae455427 <unknown>

th.vsxseg6h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg6h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac455427 <unknown>

th.vsxseg6w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg6w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae456427 <unknown>

th.vsxseg6w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg6w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac456427 <unknown>

th.vsxseg6e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg6e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0xae]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ae457427 <unknown>

th.vsxseg6e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg6e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0xac]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ac457427 <unknown>

th.vlseg7b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xd0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d0050407 <unknown>

th.vlseg7b.v v8, (a0)
# CHECK-INST: th.vlseg7b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xd2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d2050407 <unknown>

th.vlseg7h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xd0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d0055407 <unknown>

th.vlseg7h.v v8, (a0)
# CHECK-INST: th.vlseg7h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xd2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d2055407 <unknown>

th.vlseg7w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xd0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d0056407 <unknown>

th.vlseg7w.v v8, (a0)
# CHECK-INST: th.vlseg7w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xd2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d2056407 <unknown>

th.vlseg7bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0050407 <unknown>

th.vlseg7bu.v v8, (a0)
# CHECK-INST: th.vlseg7bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2050407 <unknown>

th.vlseg7hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0055407 <unknown>

th.vlseg7hu.v v8, (a0)
# CHECK-INST: th.vlseg7hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2055407 <unknown>

th.vlseg7wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0056407 <unknown>

th.vlseg7wu.v v8, (a0)
# CHECK-INST: th.vlseg7wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2056407 <unknown>

th.vlseg7e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0057407 <unknown>

th.vlseg7e.v v8, (a0)
# CHECK-INST: th.vlseg7e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2057407 <unknown>

th.vsseg7b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg7b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0050427 <unknown>

th.vsseg7b.v v8, (a0)
# CHECK-INST: th.vsseg7b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2050427 <unknown>

th.vsseg7h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg7h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0055427 <unknown>

th.vsseg7h.v v8, (a0)
# CHECK-INST: th.vsseg7h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2055427 <unknown>

th.vsseg7w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg7w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0056427 <unknown>

th.vsseg7w.v v8, (a0)
# CHECK-INST: th.vsseg7w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2056427 <unknown>

th.vsseg7e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg7e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0xc0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c0057427 <unknown>

th.vsseg7e.v v8, (a0)
# CHECK-INST: th.vsseg7e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0xc2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c2057427 <unknown>

th.vlseg7bff.v	v8, (a0)
# CHECK-INST: th.vlseg7bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xd3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d3050407 <unknown>

th.vlseg7bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg7bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xd1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d1050407 <unknown>

th.vlseg7hff.v	v8, (a0)
# CHECK-INST: th.vlseg7hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xd3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d3055407 <unknown>

th.vlseg7hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg7hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xd1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d1055407 <unknown>

th.vlseg7wff.v	v8, (a0)
# CHECK-INST: th.vlseg7wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xd3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d3056407 <unknown>

th.vlseg7wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg7wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xd1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d1056407 <unknown>

th.vlseg7buff.v v8, (a0)
# CHECK-INST: th.vlseg7buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xc3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c3050407 <unknown>

th.vlseg7buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xc1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c1050407 <unknown>

th.vlseg7huff.v v8, (a0)
# CHECK-INST: th.vlseg7huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xc3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c3055407 <unknown>

th.vlseg7huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xc1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c1055407 <unknown>

th.vlseg7wuff.v v8, (a0)
# CHECK-INST: th.vlseg7wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xc3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c3056407 <unknown>

th.vlseg7wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg7wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xc1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c1056407 <unknown>

th.vlseg7eff.v	v8, (a0)
# CHECK-INST: th.vlseg7eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xc3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c3057407 <unknown>

th.vlseg7eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg7eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xc1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c1057407 <unknown>

th.vlsseg7b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xd8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d8b50407 <unknown>

th.vlsseg7b.v v8, (a0), a1
# CHECK-INST: th.vlsseg7b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xda]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: dab50407 <unknown>

th.vlsseg7h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xd8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d8b55407 <unknown>

th.vlsseg7h.v v8, (a0), a1
# CHECK-INST: th.vlsseg7h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xda]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: dab55407 <unknown>

th.vlsseg7w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xd8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: d8b56407 <unknown>

th.vlsseg7w.v v8, (a0), a1
# CHECK-INST: th.vlsseg7w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xda]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: dab56407 <unknown>

th.vlsseg7bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b50407 <unknown>

th.vlsseg7bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg7bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab50407 <unknown>

th.vlsseg7hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b55407 <unknown>

th.vlsseg7hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg7hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab55407 <unknown>

th.vlsseg7wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b56407 <unknown>

th.vlsseg7wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg7wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab56407 <unknown>

th.vlsseg7e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg7e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b57407 <unknown>

th.vlsseg7e.v v8, (a0), a1
# CHECK-INST: th.vlsseg7e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab57407 <unknown>

th.vssseg7b.v	v8, (a0), a1
# CHECK-INST: th.vssseg7b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab50427 <unknown>

th.vssseg7b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg7b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b50427 <unknown>

th.vssseg7h.v	v8, (a0), a1
# CHECK-INST: th.vssseg7h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab55427 <unknown>

th.vssseg7h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg7h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b55427 <unknown>

th.vssseg7w.v	v8, (a0), a1
# CHECK-INST: th.vssseg7w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab56427 <unknown>

th.vssseg7w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg7w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b56427 <unknown>

th.vssseg7e.v	v8, (a0), a1
# CHECK-INST: th.vssseg7e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0xca]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cab57427 <unknown>

th.vssseg7e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg7e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0xc8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: c8b57427 <unknown>

th.vlxseg7b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xdc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: dc450407 <unknown>

th.vlxseg7b.v v8, (a0), v4
# CHECK-INST: th.vlxseg7b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xde]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: de450407 <unknown>

th.vlxseg7h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xdc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: dc455407 <unknown>

th.vlxseg7h.v v8, (a0), v4
# CHECK-INST: th.vlxseg7h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xde]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: de455407 <unknown>

th.vlxseg7w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xdc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: dc456407 <unknown>

th.vlxseg7w.v v8, (a0), v4
# CHECK-INST: th.vlxseg7w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xde]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: de456407 <unknown>

th.vlxseg7bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc450407 <unknown>

th.vlxseg7bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg7bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce450407 <unknown>

th.vlxseg7hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc455407 <unknown>

th.vlxseg7hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg7hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce455407 <unknown>

th.vlxseg7wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc456407 <unknown>

th.vlxseg7wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg7wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce456407 <unknown>

th.vlxseg7e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg7e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc457407 <unknown>

th.vlxseg7e.v v8, (a0), v4
# CHECK-INST: th.vlxseg7e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce457407 <unknown>

th.vsxseg7b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg7b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce450427 <unknown>

th.vsxseg7b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg7b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc450427 <unknown>

th.vsxseg7h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg7h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce455427 <unknown>

th.vsxseg7h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg7h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc455427 <unknown>

th.vsxseg7w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg7w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce456427 <unknown>

th.vsxseg7w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg7w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc456427 <unknown>

th.vsxseg7e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg7e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0xce]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ce457427 <unknown>

th.vsxseg7e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg7e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0xcc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: cc457427 <unknown>

th.vlseg8b.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f0050407 <unknown>

th.vlseg8b.v v8, (a0)
# CHECK-INST: th.vlseg8b.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f2050407 <unknown>

th.vlseg8h.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f0055407 <unknown>

th.vlseg8h.v v8, (a0)
# CHECK-INST: th.vlseg8h.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f2055407 <unknown>

th.vlseg8w.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xf0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f0056407 <unknown>

th.vlseg8w.v v8, (a0)
# CHECK-INST: th.vlseg8w.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xf2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f2056407 <unknown>

th.vlseg8bu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8bu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0050407 <unknown>

th.vlseg8bu.v v8, (a0)
# CHECK-INST: th.vlseg8bu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2050407 <unknown>

th.vlseg8hu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8hu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0055407 <unknown>

th.vlseg8hu.v v8, (a0)
# CHECK-INST: th.vlseg8hu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2055407 <unknown>

th.vlseg8wu.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8wu.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0056407 <unknown>

th.vlseg8wu.v v8, (a0)
# CHECK-INST: th.vlseg8wu.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2056407 <unknown>

th.vlseg8e.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0057407 <unknown>

th.vlseg8e.v v8, (a0)
# CHECK-INST: th.vlseg8e.v v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2057407 <unknown>

th.vsseg8b.v v8, (a0), v0.t
# CHECK-INST: th.vsseg8b.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x04,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0050427 <unknown>

th.vsseg8b.v v8, (a0)
# CHECK-INST: th.vsseg8b.v v8, (a0)
# CHECK-ENCODING: [0x27,0x04,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2050427 <unknown>

th.vsseg8h.v v8, (a0), v0.t
# CHECK-INST: th.vsseg8h.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x54,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0055427 <unknown>

th.vsseg8h.v v8, (a0)
# CHECK-INST: th.vsseg8h.v v8, (a0)
# CHECK-ENCODING: [0x27,0x54,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2055427 <unknown>

th.vsseg8w.v v8, (a0), v0.t
# CHECK-INST: th.vsseg8w.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x64,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0056427 <unknown>

th.vsseg8w.v v8, (a0)
# CHECK-INST: th.vsseg8w.v v8, (a0)
# CHECK-ENCODING: [0x27,0x64,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2056427 <unknown>

th.vsseg8e.v v8, (a0), v0.t
# CHECK-INST: th.vsseg8e.v v8, (a0), v0.t
# CHECK-ENCODING: [0x27,0x74,0x05,0xe0]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e0057427 <unknown>

th.vsseg8e.v v8, (a0)
# CHECK-INST: th.vsseg8e.v v8, (a0)
# CHECK-ENCODING: [0x27,0x74,0x05,0xe2]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e2057427 <unknown>

th.vlseg8bff.v	v8, (a0)
# CHECK-INST: th.vlseg8bff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xf3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f3050407 <unknown>

th.vlseg8bff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg8bff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xf1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f1050407 <unknown>

th.vlseg8hff.v	v8, (a0)
# CHECK-INST: th.vlseg8hff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xf3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f3055407 <unknown>

th.vlseg8hff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg8hff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xf1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f1055407 <unknown>

th.vlseg8wff.v	v8, (a0)
# CHECK-INST: th.vlseg8wff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xf3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f3056407 <unknown>

th.vlseg8wff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg8wff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xf1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f1056407 <unknown>

th.vlseg8buff.v v8, (a0)
# CHECK-INST: th.vlseg8buff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x04,0x05,0xe3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e3050407 <unknown>

th.vlseg8buff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8buff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x04,0x05,0xe1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e1050407 <unknown>

th.vlseg8huff.v v8, (a0)
# CHECK-INST: th.vlseg8huff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x54,0x05,0xe3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e3055407 <unknown>

th.vlseg8huff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8huff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x54,0x05,0xe1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e1055407 <unknown>

th.vlseg8wuff.v v8, (a0)
# CHECK-INST: th.vlseg8wuff.v v8, (a0)
# CHECK-ENCODING: [0x07,0x64,0x05,0xe3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e3056407 <unknown>

th.vlseg8wuff.v v8, (a0), v0.t
# CHECK-INST: th.vlseg8wuff.v v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x64,0x05,0xe1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e1056407 <unknown>

th.vlseg8eff.v	v8, (a0)
# CHECK-INST: th.vlseg8eff.v	v8, (a0)
# CHECK-ENCODING: [0x07,0x74,0x05,0xe3]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e3057407 <unknown>

th.vlseg8eff.v	v8, (a0), v0.t
# CHECK-INST: th.vlseg8eff.v	v8, (a0), v0.t
# CHECK-ENCODING: [0x07,0x74,0x05,0xe1]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e1057407 <unknown>

th.vlsseg8b.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8b.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f8b50407 <unknown>

th.vlsseg8b.v v8, (a0), a1
# CHECK-INST: th.vlsseg8b.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fab50407 <unknown>

th.vlsseg8h.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8h.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f8b55407 <unknown>

th.vlsseg8h.v v8, (a0), a1
# CHECK-INST: th.vlsseg8h.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fab55407 <unknown>

th.vlsseg8w.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8w.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xf8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: f8b56407 <unknown>

th.vlsseg8w.v v8, (a0), a1
# CHECK-INST: th.vlsseg8w.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xfa]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fab56407 <unknown>

th.vlsseg8bu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8bu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x04,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b50407 <unknown>

th.vlsseg8bu.v v8, (a0), a1
# CHECK-INST: th.vlsseg8bu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x04,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab50407 <unknown>

th.vlsseg8hu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8hu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x54,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b55407 <unknown>

th.vlsseg8hu.v v8, (a0), a1
# CHECK-INST: th.vlsseg8hu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x54,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab55407 <unknown>

th.vlsseg8wu.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8wu.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x64,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b56407 <unknown>

th.vlsseg8wu.v v8, (a0), a1
# CHECK-INST: th.vlsseg8wu.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x64,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab56407 <unknown>

th.vlsseg8e.v v8, (a0), a1, v0.t
# CHECK-INST: th.vlsseg8e.v v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x74,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b57407 <unknown>

th.vlsseg8e.v v8, (a0), a1
# CHECK-INST: th.vlsseg8e.v v8, (a0), a1
# CHECK-ENCODING: [0x07,0x74,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab57407 <unknown>

th.vssseg8b.v	v8, (a0), a1
# CHECK-INST: th.vssseg8b.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x04,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab50427 <unknown>

th.vssseg8b.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg8b.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x04,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b50427 <unknown>

th.vssseg8h.v	v8, (a0), a1
# CHECK-INST: th.vssseg8h.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x54,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab55427 <unknown>

th.vssseg8h.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg8h.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x54,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b55427 <unknown>

th.vssseg8w.v	v8, (a0), a1
# CHECK-INST: th.vssseg8w.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x64,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab56427 <unknown>

th.vssseg8w.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg8w.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x64,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b56427 <unknown>

th.vssseg8e.v	v8, (a0), a1
# CHECK-INST: th.vssseg8e.v	v8, (a0), a1
# CHECK-ENCODING: [0x27,0x74,0xb5,0xea]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: eab57427 <unknown>

th.vssseg8e.v	v8, (a0), a1, v0.t
# CHECK-INST: th.vssseg8e.v	v8, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x74,0xb5,0xe8]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: e8b57427 <unknown>

th.vlxseg8b.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8b.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xfc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc450407 <unknown>

th.vlxseg8b.v v8, (a0), v4
# CHECK-INST: th.vlxseg8b.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xfe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe450407 <unknown>

th.vlxseg8h.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8h.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xfc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc455407 <unknown>

th.vlxseg8h.v v8, (a0), v4
# CHECK-INST: th.vlxseg8h.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xfe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe455407 <unknown>

th.vlxseg8w.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8w.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xfc]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fc456407 <unknown>

th.vlxseg8w.v v8, (a0), v4
# CHECK-INST: th.vlxseg8w.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xfe]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: fe456407 <unknown>

th.vlxseg8bu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8bu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x04,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec450407 <unknown>

th.vlxseg8bu.v v8, (a0), v4
# CHECK-INST: th.vlxseg8bu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x04,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee450407 <unknown>

th.vlxseg8hu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8hu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x54,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec455407 <unknown>

th.vlxseg8hu.v v8, (a0), v4
# CHECK-INST: th.vlxseg8hu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x54,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee455407 <unknown>

th.vlxseg8wu.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8wu.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x64,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec456407 <unknown>

th.vlxseg8wu.v v8, (a0), v4
# CHECK-INST: th.vlxseg8wu.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x64,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee456407 <unknown>

th.vlxseg8e.v v8, (a0), v4, v0.t
# CHECK-INST: th.vlxseg8e.v v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x07,0x74,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec457407 <unknown>

th.vlxseg8e.v v8, (a0), v4
# CHECK-INST: th.vlxseg8e.v v8, (a0), v4
# CHECK-ENCODING: [0x07,0x74,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee457407 <unknown>

th.vsxseg8b.v	v8, (a0), v4
# CHECK-INST: th.vsxseg8b.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x04,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee450427 <unknown>

th.vsxseg8b.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg8b.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x04,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec450427 <unknown>

th.vsxseg8h.v	v8, (a0), v4
# CHECK-INST: th.vsxseg8h.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x54,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee455427 <unknown>

th.vsxseg8h.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg8h.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x54,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec455427 <unknown>

th.vsxseg8w.v	v8, (a0), v4
# CHECK-INST: th.vsxseg8w.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x64,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee456427 <unknown>

th.vsxseg8w.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg8w.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x64,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec456427 <unknown>

th.vsxseg8e.v	v8, (a0), v4
# CHECK-INST: th.vsxseg8e.v	v8, (a0), v4
# CHECK-ENCODING: [0x27,0x74,0x45,0xee]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ee457427 <unknown>

th.vsxseg8e.v	v8, (a0), v4, v0.t
# CHECK-INST: th.vsxseg8e.v	v8, (a0), v4, v0.t
# CHECK-ENCODING: [0x27,0x74,0x45,0xec]
# CHECK-ERROR: instruction requires the following: 'xtheadvector' (T-Head Base Vector Instructions){{$}}
# CHECK-UNKNOWN: ec457427 <unknown>
