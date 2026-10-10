// RUN: %clang --target=riscv64 -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=RUNTIME
// RUN: %clang --target=riscv32 -march=rv32i_ztt -mztt-profile=clang-n128-u32-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=FIXED
// RUN: %clang --target=riscv64 -march=rv64i_ztt -mztt-profile=invalid -mztt-profile=clang-runtime-u32-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=RUNTIME
// RUNTIME: "-target-feature" "+ztt-profile=clang-runtime-u32-m16-a4"
// RUNTIME-NOT: error:
// FIXED: "-target-feature" "+ztt-profile=clang-n128-u32-m16-a4"
// FIXED-NOT: error:

// RUN: not %clang --target=riscv64 -march=rv64i_ztt -mztt-profile=gcc-runtime-u32-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=INVALID
// RUN: not %clang --target=riscv64 -march=rv64i_ztt -mztt-profile= -### -c %s 2>&1 | FileCheck %s --check-prefix=INVALID
// RUN: not %clang --target=riscv64 -march=rv64i_ztt -mztt-profile=clang-runtime-u24-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=INVALID
// INVALID: error: invalid feature combination: invalid Ztt profile
// RUN: not %clang --target=riscv64 -march=rv64i -mztt-profile=clang-runtime-u32-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=NOZTT
// NOZTT: error: invalid feature combination: -mztt-profile requires the Ztt extension
// RUN: not %clang --target=x86_64 -mztt-profile=clang-runtime-u32-m16-a4 -### -c %s 2>&1 | FileCheck %s --check-prefix=TARGET
// TARGET: error: unsupported option '-mztt-profile=' for target 'x86_64'

// Old compiler configuration names are no longer ISA extensions.
// RUN: not %clang --target=riscv64 -march=rv64i_zttuds32b -### -c %s 2>&1 | FileCheck %s --check-prefix=OLD
// RUN: not %clang --target=riscv64 -march=rv64i_zttm16 -### -c %s 2>&1 | FileCheck %s --check-prefix=OLD
// RUN: not %clang --target=riscv64 -march=rv64i_ztta4 -### -c %s 2>&1 | FileCheck %s --check-prefix=OLD
// OLD: error: invalid arch name

// Validate and consume the profile in the driver without forwarding it to cc1as.
// RUN: echo 'ret' > %t.s
// RUN: %clang --target=riscv64 -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 -### -c %t.s 2>&1 | FileCheck %s --check-prefix=ASM-ARGS --implicit-check-not='ztt-profile=' --implicit-check-not='"-mztt-profile=' --implicit-check-not=warning: --implicit-check-not=error:
// ASM-ARGS: "-cc1as"
// RUN: not %clang --target=riscv64 -march=rv64gc_ztt -mztt-profile=clang-runtime-u24-m16-a4 -c %t.s -o %t.o 2>&1 | FileCheck %s --check-prefix=INVALID
// RUN: not %clang --target=riscv64 -march=rv64gc_ztt -mztt-profile= -c %t.s -o %t.o 2>&1 | FileCheck %s --check-prefix=INVALID
// RUN: not %clang --target=riscv64 -march=rv64gc -mztt-profile=clang-runtime-u32-m16-a4 -c %t.s -o %t.o 2>&1 | FileCheck %s --check-prefix=NOZTT
// RUN: %clang --target=riscv64 -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 -c %t.s -o %t.o 2>&1 | FileCheck %s --check-prefix=ASM --allow-empty
// ASM-NOT: warning:
// ASM-NOT: error:
// RUN: llvm-readobj --arch-specific %t.o | FileCheck %s --check-prefix=ARCH --implicit-check-not='Value:{{.*}}ztt-profile'
// ARCH: Value: rv64{{.*}}_ztt0p6
