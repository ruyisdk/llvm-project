// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DUDS=8 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -DUDS=16 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u64-m32-a16 -DUDS=64 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u128-m32-a16 -DUDS=128 -fsyntax-only -verify %s
// RUN: %clang_cc1 -x c++ -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DUDS=32 -fsyntax-only -verify %s

#include <riscv_ztt.h>

// Standard and wide are legal; packed squares are not.
#define VALID(T) \
  void valid_##T(__riscv_ztt_##T##_1x2_t src) { \
    __riscv_ztt_mrowzip_ew_##T##_1x2(src); \
  }
VALID(i128)
VALID(u128)
#if UDS <= 64
VALID(i64)
VALID(u64)
VALID(f64)
#endif
#if UDS <= 32
VALID(i32)
VALID(u32)
VALID(f32)
#endif
#if UDS <= 16
VALID(i16)
VALID(u16)
VALID(f16)
VALID(bf16)
#endif
#if UDS == 8
VALID(i8)
VALID(u8)
#endif

// Each value occupies a full physical register, but each square is packed.
#if UDS == 8
#define PACKED i4
#elif UDS == 16
#define PACKED i8
#elif UDS == 32
#define PACKED i16
#elif UDS == 64
#define PACKED i32
#else
#define PACKED i64
#endif
#define BAD_PACKED(T) \
  void packed(__riscv_ztt_##T##_1x2_t src) { \
    __riscv_ztt_mrowzip_ew_##T##_1x2(src); \
  }
#define EXPAND_BAD_PACKED(T) BAD_PACKED(T)
EXPAND_BAD_PACKED(PACKED) // expected-error {{element width at least UDS}}

#if UDS == 32
void invalid(__riscv_ztt_i32_1x2_t src, __riscv_ztt_f32_1x2_t fp,
             __riscv_ztt_i32_1x1_t one, __riscv_ztt_i32_2x1_t col,
             __riscv_ztt_i32_1x4_t four, __riscv_ztt_i32_accx2_t acc,
             __riscv_ztt_i32_1x2_t *ptr,
             __riscv_ztt_i32_rdn_1x2_t rounded) {
  __riscv_ztt_mrowzip_ew_i32_1x2(fp); // expected-error {{requires identical M source and result types}}
  __riscv_ztt_mrowzip_ew_i32_1x2(one); // expected-error {{requires identical M source and result types}}
  __riscv_ztt_mrowzip_ew_i32_1x2(col); // expected-error {{requires identical M source and result types}}
  __riscv_ztt_mrowzip_ew_i32_2x1(col); // expected-error {{undeclared}}
  __riscv_ztt_mrowzip_ew_i32_1x4(four); // expected-error {{undeclared}}
  __riscv_ztt_mrowzip_ew_i32_1x2(ptr); // expected-error {{requires identical M source and result types}}
  __riscv_ztt_mrowzip_ew_i32_1x2(acc); // expected-error {{requires identical M source and result types}}
  __riscv_ztt_mrowzip_ew_i32_1x2(rounded); // expected-error {{requires identical M source and result types}}
  __riscv_ztt_mrowzip_ew_i32_1x2(); // expected-error {{too few arguments}}
  __riscv_ztt_mrowzip_ew_i32_1x2(src, src); // expected-error {{too many arguments}}
}
#endif
