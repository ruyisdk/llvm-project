# RUN: not llvm-mc -triple=riscv32 -show-encoding --mattr=+xtheadv %s 2>&1 | FileCheck %s
# RUN: not llvm-mc -triple=riscv64 -show-encoding --mattr=+xtheadv %s 2>&1 | FileCheck %s

vsetvli a2, a1, e8
# CHECK: error: operand must be e[8|16|32|64|128|256|512|1024],m[1|2|4|8|f2|f4|f8],[ta|tu],[ma|mu]

vsetivli a2, 15, 208
# CHECK: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}

vsetivli a2, 0, e32, m1, ta, ma
# CHECK: instruction requires the following: 'V' (Vector Extension for Application Processors), 'Zve32x' or 'Zve64x' (Vector Extensions for Embedded Processors){{$}}

vsetivli a2, 0, e32, m1, d1
# CHECK: error: operand must be e[8|16|32|64|128|256|512|1024],m[1|2|4|8|f2|f4|f8],[ta|tu],[ma|mu]

