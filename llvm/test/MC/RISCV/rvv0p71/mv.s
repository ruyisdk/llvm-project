# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadvector %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadvector - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadvector %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

vmv.v.v v8, v20
# CHECK-INST: vmv.v.v v8, v20
# CHECK-ENCODING: [0x57,0x04,0x0a,0x5e]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 04 0a 5e <unknown>

vmv.v.x v8, a0
# CHECK-INST: vmv.v.x v8, a0
# CHECK-ENCODING: [0x57,0x44,0x05,0x5e]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 44 05 5e <unknown>

vmv.v.i v8, 15
# CHECK-INST: vmv.v.i v8, 15
# CHECK-ENCODING: [0x57,0xb4,0x07,0x5e]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 b4 07 5e <unknown>

vext.x.v a2, v4, a0
# CHECK-INST: vext.x.v a2, v4, a0
# CHECK-ENCODING: [0x57,0x26,0x45,0x32]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 26 45 32 <unknown>

vmv.s.x v8, a0
# CHECK-INST: vmv.s.x v8, a0
# CHECK-ENCODING: [0x57,0x64,0x05,0x36]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 64 05 36 <unknown>
