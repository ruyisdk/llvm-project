# RUN: llvm-mc -triple=riscv32 -show-encoding -mattr=+ztt %s \
# RUN:   | FileCheck %s --check-prefixes=CHECK-ASM,CHECK-ENCODING
# RUN: llvm-mc -triple=riscv64 -show-encoding -mattr=+ztt %s \
# RUN:   | FileCheck %s --check-prefixes=CHECK-ASM,CHECK-ENCODING
# RUN: llvm-mc -triple=riscv32 -filetype=obj -mattr=+ztt %s \
# RUN:   | llvm-objdump -d --mattr=+ztt - \
# RUN:   | FileCheck %s --check-prefix=CHECK-ASM
# RUN: llvm-mc -triple=riscv64 -filetype=obj -mattr=+ztt %s \
# RUN:   | llvm-objdump -d --mattr=+ztt - \
# RUN:   | FileCheck %s --check-prefix=CHECK-ASM

csrr a0, ameown
# CHECK-ASM: csrr a0, ameown
# CHECK-ENCODING: [0x73,0x25,0x30,0xcc]

csrr a0, amestype
# CHECK-ASM: csrr a0, amestype
# CHECK-ENCODING: [0x73,0x25,0x00,0x81]

csrr a0, amenlen
# CHECK-ASM: csrr a0, amenlen
# CHECK-ENCODING: [0x73,0x25,0x00,0xcc]

csrr a0, ameudsz
# CHECK-ASM: csrr a0, ameudsz
# CHECK-ENCODING: [0x73,0x25,0x10,0xcc]

csrr a0, amefflags
# CHECK-ASM: csrr a0, amefflags
# CHECK-ENCODING: [0x73,0x25,0x10,0x81]

csrr a0, amexsat
# CHECK-ASM: csrr a0, amexsat
# CHECK-ENCODING: [0x73,0x25,0x20,0x81]

csrw amestype, a0
# CHECK-ASM: csrw amestype, a0
# CHECK-ENCODING: [0x73,0x10,0x05,0x81]

csrw amefflags, a0
# CHECK-ASM: csrw amefflags, a0
# CHECK-ENCODING: [0x73,0x10,0x15,0x81]

csrw amexsat, a0
# CHECK-ASM: csrw amexsat, a0
# CHECK-ENCODING: [0x73,0x10,0x25,0x81]

csrr a0, amestatus
# CHECK-ASM: csrr a0, amestatus
# CHECK-ENCODING: [0x73,0x25,0x00,0x80]
