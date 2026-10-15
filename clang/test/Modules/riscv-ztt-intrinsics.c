// REQUIRES: riscv-registered-target
// RUN: split-file %s %t
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-map-file=%t/module.modulemap -emit-module -fmodule-name=RISCVZtt -x c %t/module.modulemap -o %t.32.pcm
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-file=%t.32.pcm -fsyntax-only -verify %t/use.c
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-map-file=%t/module.modulemap -emit-module -fmodule-name=RISCVZtt -x c %t/module.modulemap -o %t.64.pcm
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-file=%t.64.pcm -fsyntax-only -verify %t/use.c
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-map-file=%t/module.modulemap -emit-module -fmodule-name=RISCVZtt -x c++ %t/module.modulemap -o %t.cpp32.pcm
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-file=%t.cpp32.pcm -x c++ -fsyntax-only -verify %t/use.c
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-map-file=%t/module.modulemap -emit-module -fmodule-name=RISCVZtt -x c++ %t/module.modulemap -o %t.cpp64.pcm
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -fmodules -fmodule-file=%t.cpp64.pcm -x c++ -fsyntax-only -verify %t/use.c

//--- module.modulemap
module RISCVZtt {
  header "intrinsics.h"
  export *
}

//--- intrinsics.h
#include <riscv_ztt.h>
static inline void cached(__riscv_ztt_i32_1x1_t a) {
  (void)__riscv_ztt_madd_ew_i32_1x1(a, a);
}

//--- use.c
// The module must restore lookup for names not used in its header.
void restored(__riscv_ztt_i32_1x1_t a, __riscv_ztt_i32_1x2_t row) {
  (void)__riscv_ztt_madd_ew_i32_1x1(a, a);
  (void)__riscv_ztt_mcopy_m2a_i32_accx1(a);
  (void)__riscv_ztt_mzero_m_i32_rne_1x1();
  (void)__riscv_ztt_madd_ew_i32_1x1(a, row); // expected-error {{madd.ew operands violate}}
}
