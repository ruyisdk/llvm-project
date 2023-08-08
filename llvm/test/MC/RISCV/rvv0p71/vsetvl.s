# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadv %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadv %s \
# RUN:        | llvm-objdump -d --mattr=+xtheadv - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadv %s \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

# reserved filed: vsew[2:0]=0b1xx, non-zero bits 8/9/10.
vsetvli a2, a0, 0x224
# CHECK-INST: vsetvli a2, a0, 548
# CHECK-ENCODING: [0x57,0x76,0x45,0x22]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 45 22 <unknown>

vsetvli a2, a0, 0x8
# CHECK-INST: vsetvli a2, a0, e32, m1, d1
# CHECK-ENCODING: [0x57,0x76,0x85,0x00]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 85 00 <unknown>

vsetvli a2, a0, 0x29
# CHECK-INST: vsetvli a2, a0, e32, m2, d2
# CHECK-ENCODING: [0x57,0x76,0x95,0x02]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 95 02 <unknown>

vsetvli a2, a0, 0x4a
# CHECK-INST: vsetvli a2, a0, e32, m4, d4
# CHECK-ENCODING: [0x57,0x76,0xa5,0x04]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 a5 04 <unknown>

vsetvli a2, a0, 0x6b
# CHECK-INST: vsetvli a2, a0, e32, m8, d8
# CHECK-ENCODING: [0x57,0x76,0xb5,0x06]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 b5 06 <unknown>

vsetvli a2, a0, 104
# CHECK-INST: vsetvli a2, a0, e32, m1, d8
# CHECK-ENCODING: [0x57,0x76,0x85,0x06]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 85 06 <unknown>

vsetvli a2, a0, e32, m1, d1
# CHECK-INST: vsetvli a2, a0, e32, m1, d1
# CHECK-ENCODING: [0x57,0x76,0x85,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 85 00 <unknown>

vsetvli a2, a0, e32, m2, d2
# CHECK-INST: vsetvli a2, a0, e32, m2, d2
# CHECK-ENCODING: [0x57,0x76,0x95,0x02]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 95 02 <unknown>

vsetvli a2, a0, e32, m4, d4
# CHECK-INST: vsetvli a2, a0, e32, m4, d4
# CHECK-ENCODING: [0x57,0x76,0xa5,0x04]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 a5 04 <unknown>

vsetvli a2, a0, e32, m8, d8
# CHECK-INST: vsetvli a2, a0, e32, m8, d8
# CHECK-ENCODING: [0x57,0x76,0xb5,0x06]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 b5 06 <unknown>

vsetvli a2, a0, e32, m2, d1
# CHECK-INST: vsetvli a2, a0, e32, m2, d1
# CHECK-ENCODING: [0x57,0x76,0x95,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 95 00 <unknown>

vsetvli a2, a0, e32, m4, d1
# CHECK-INST: vsetvli a2, a0, e32, m4, d1
# CHECK-ENCODING: [0x57,0x76,0xa5,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 a5 00 <unknown>

vsetvli a2, a0, e32, m8, d1
# CHECK-INST: vsetvli a2, a0, e32, m8, d1
# CHECK-ENCODING: [0x57,0x76,0xb5,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 b5 00 <unknown>

vsetvli a2, a0, e8, m1, d1
# CHECK-INST: vsetvli a2, a0, e8, m1, d1
# CHECK-ENCODING: [0x57,0x76,0x05,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 05 00 <unknown>

vsetvli a2, a0, e16, m1, d1
# CHECK-INST: vsetvli a2, a0, e16, m1, d1
# CHECK-ENCODING: [0x57,0x76,0x45,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 45 00 <unknown>

vsetvli a2, a0, e32, m1, d1
# CHECK-INST: vsetvli a2, a0, e32, m1, d1
# CHECK-ENCODING: [0x57,0x76,0x85,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 85 00 <unknown>

vsetvli a2, a0, e64, m1, d1
# CHECK-INST: vsetvli a2, a0, e64, m1, d1
# CHECK-ENCODING: [0x57,0x76,0xc5,0x00]
# CHECK-ERROR: invalid operand for instruction
# CHECK-UNKNOWN: 57 76 c5 00 <unknown>

vsetvl a2, a0, a1
# CHECK-INST: vsetvl a2, a0, a1
# CHECK-ENCODING: [0x57,0x76,0xb5,0x80]
# CHECK-ERROR: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 76 b5 80 <unknown>
