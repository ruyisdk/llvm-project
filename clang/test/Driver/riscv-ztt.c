// RUN: %clang --target=riscv32 -march=rv32i_ztt -### -c %s 2>&1 \
// RUN:   | FileCheck %s --check-prefix=FEATURE
// RUN: %clang --target=riscv64 -march=rv64gc_ztt -### -c %s 2>&1 \
// RUN:   | FileCheck %s --check-prefix=FEATURE
// RUN: %clang --target=riscv32 -march=rv32i_ztt -dM -E %s \
// RUN:   | FileCheck %s --check-prefix=MACRO
// RUN: %clang --target=riscv64 -march=rv64gc_ztt0p6 -dM -E %s \
// RUN:   | FileCheck %s --check-prefix=MACRO

// FEATURE: "-target-feature" "+ztt"
// MACRO: #define __riscv_ztt 6000
