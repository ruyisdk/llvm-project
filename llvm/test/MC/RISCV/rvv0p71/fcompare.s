# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadv %s \
# RUN:         --mattr=+f \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadv %s \
# RUN:         --mattr=+f \
# RUN:        | llvm-objdump -d --mattr=+xtheadv --mattr=+f - \
# RUN:        | FileCheck %s --check-prefix=CHECK-INST
# RUN: llvm-mc -triple=riscv64 -filetype=obj --mattr=+xtheadv %s \
# RUN:         --mattr=+f \
# RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN

vmfeq.vv v8, v4, v20, v0.t
# CHECK-INST: vmfeq.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x60]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 60 <unknown>

vmfeq.vv v8, v4, v20
# CHECK-INST: vmfeq.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x62]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 62 <unknown>

vmfeq.vf v8, v4, fa0, v0.t
# CHECK-INST: vmfeq.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x60]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 60 <unknown>

vmfeq.vf v8, v4, fa0
# CHECK-INST: vmfeq.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x62]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 62 <unknown>

vmfne.vv v8, v4, v20, v0.t
# CHECK-INST: vmfne.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x70]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 70 <unknown>

vmfne.vv v8, v4, v20
# CHECK-INST: vmfne.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x72]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 72 <unknown>

vmfne.vf v8, v4, fa0, v0.t
# CHECK-INST: vmfne.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x70]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 70 <unknown>

vmfne.vf v8, v4, fa0
# CHECK-INST: vmfne.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x72]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 72 <unknown>

vmflt.vv v8, v4, v20, v0.t
# CHECK-INST: vmflt.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x6c]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 6c <unknown>

vmflt.vv v8, v4, v20
# CHECK-INST: vmflt.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x6e]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 6e <unknown>

vmflt.vf v8, v4, fa0, v0.t
# CHECK-INST: vmflt.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x6c]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 6c <unknown>

vmflt.vf v8, v4, fa0
# CHECK-INST: vmflt.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x6e]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 6e <unknown>

vmfle.vv v8, v4, v20, v0.t
# CHECK-INST: vmfle.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x64]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 64 <unknown>

vmfle.vv v8, v4, v20
# CHECK-INST: vmfle.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x66]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 14 4a 66 <unknown>

vmfle.vf v8, v4, fa0, v0.t
# CHECK-INST: vmfle.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x64]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 64 <unknown>

vmfle.vf v8, v4, fa0
# CHECK-INST: vmfle.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x66]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 66 <unknown>

vmfgt.vf v8, v4, fa0, v0.t
# CHECK-INST: vmfgt.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x74]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 74 <unknown>

vmfgt.vf v8, v4, fa0
# CHECK-INST: vmfgt.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x76]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 76 <unknown>

vmfge.vf v8, v4, fa0, v0.t
# CHECK-INST: vmfge.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x7c]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 7c <unknown>

vmfge.vf v8, v4, fa0
# CHECK-INST: vmfge.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x7e]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 54 45 7e <unknown>

vmford.vv v8, v4, v20, v0.t
# CHECK-INST: vmford.vv v8, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x14,0x4a,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 14 4a 68 <unknown>

vmford.vv v8, v4, v20
# CHECK-INST: vmford.vv v8, v4, v20
# CHECK-ENCODING: [0x57,0x14,0x4a,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 14 4a 6a <unknown>

vmford.vf v8, v4, fa0, v0.t
# CHECK-INST: vmford.vf v8, v4, fa0, v0.t
# CHECK-ENCODING: [0x57,0x54,0x45,0x68]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 54 45 68 <unknown>

vmford.vf v8, v4, fa0
# CHECK-INST: vmford.vf v8, v4, fa0
# CHECK-ENCODING: [0x57,0x54,0x45,0x6a]
# CHECK-ERROR: unrecognized instruction mnemonic
# CHECK-UNKNOWN: 57 54 45 6a <unknown>

vmfeq.vv v0, v4, v20, v0.t
# CHECK-INST: vmfeq.vv v0, v4, v20, v0.t
# CHECK-ENCODING: [0x57,0x10,0x4a,0x60]
# CHECK-ERROR: instruction requires the following: 'V'{{.*}}'Zve32f', 'Zve64f' or 'Zve64d' (Vector Extensions for Embedded Processors){{$}}
# CHECK-UNKNOWN: 57 10 4a 60 <unknown>
