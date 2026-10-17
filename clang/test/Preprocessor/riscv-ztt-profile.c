// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-n128-u32-m16-a4 -E -dM %s | FileCheck %s --check-prefixes=FIXED,COMMON --implicit-check-not=__riscv_ztt_runtime_n
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -E -dM %s | FileCheck %s --check-prefixes=RUNTIME,COMMON --implicit-check-not=__riscv_ztt_n
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a1 -E -dM %s | FileCheck %s --check-prefix=A1
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a2 -E -dM %s | FileCheck %s --check-prefix=A2
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -E -dM %s | FileCheck %s --check-prefix=NONE
// COMMON-DAG: #define __riscv_ztt 6000
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a2 -target-feature +ztt-profile=clang-n128-u32-m16-a4 -E -dM %s | FileCheck %s --check-prefixes=FIXED,COMMON --implicit-check-not=__riscv_ztt_runtime_n
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=bad -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -E -dM %s | FileCheck %s --check-prefixes=RUNTIME,COMMON --implicit-check-not=__riscv_ztt_n
// COMMON-DAG: #define __riscv_ztt_accregs 4
// COMMON-DAG: #define __riscv_ztt_mregs 16
// COMMON-DAG: #define __riscv_ztt_uds 32
// FIXED-DAG: #define __riscv_ztt_n 128
// FIXED-DAG: #define __riscv_ztt_nelem 16384
// RUNTIME-DAG: #define __riscv_ztt_runtime_n 1
// A1-DAG: #define __riscv_ztt_accregs 1
// A1-DAG: #define __riscv_ztt_mregs 32
// A1-DAG: #define __riscv_ztt_uds 8
// A2-DAG: #define __riscv_ztt_accregs 2
// A2-DAG: #define __riscv_ztt_uds 128
// NONE: #define __riscv_ztt 6000
// NONE-NOT: #define __riscv_ztt_

// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=bad -E %s 2>&1 | FileCheck %s --check-prefix=INVALID
// INVALID: error: invalid feature combination: invalid Ztt profile 'bad'
// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -E %s 2>&1 | FileCheck %s --check-prefix=NOZTT
// NOZTT: error: invalid feature combination: -mztt-profile requires the Ztt extension
// RUN: not %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile= -E %s 2>&1 | FileCheck %s --check-prefix=EMPTY
// EMPTY: error: invalid value '' in '-mztt-profile='
