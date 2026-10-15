// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -fsyntax-only \
// RUN: -verify=expected,RV32 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 \
// RUN: -fsyntax-only \
// RUN: -verify=expected,RV64 %s

#include <riscv_ztt.h>

void valid_packed_and_concatenated_stores(
    short *p16, int *p32, __riscv_ztt_i16_1x2_t packed,
    __riscv_ztt_i32_1x2_t concatenated) {
  __riscv_ztt_mss_rm(p16, packed);
  __riscv_ztt_mss_cm(p32, concatenated);
}

typedef int int_alias;
typedef __INT64_TYPE__ target_int64_t;
typedef __UINT64_TYPE__ target_uint64_t;
struct Incomplete;

void load_i32_base_type(void *v, short *s, int *i, unsigned *u, float *f,
                        long *l, int_alias *alias,
                        struct Incomplete *incomplete) {
  __riscv_ztt_mls_rm_i32_1x1(v); // expected-error {{Ztt memory base pointee type 'void' does not match matrix element type 'int'}}
  __riscv_ztt_mls_rm_i32_1x1(s); // expected-error {{Ztt memory base pointee type 'short' does not match matrix element type 'int'}}
  __riscv_ztt_mls_rm_i32_1x1(u); // expected-error {{Ztt memory base pointee type 'unsigned int' does not match matrix element type 'int'}}
  __riscv_ztt_mls_rm_i32_1x1(f); // expected-error {{Ztt memory base pointee type 'float' does not match matrix element type 'int'}}
  __riscv_ztt_mls_rm_i32_1x1(l); // expected-error {{Ztt memory base pointee type 'long' does not match matrix element type 'int'}}
  __riscv_ztt_mls_rm_i32_1x1(incomplete); // expected-error {{Ztt memory base pointee type 'struct Incomplete' does not match matrix element type 'int'}}

  __riscv_ztt_mls_rm_i32_1x1(i);
  __riscv_ztt_mls_cm_i32_1x1(alias);
}

void signedness_is_part_of_the_datatype(
    int *i, unsigned *u, __riscv_ztt_i32_1x1_t si,
    __riscv_ztt_u32_1x1_t ui) {
  __riscv_ztt_mss_rm(i, si);
  __riscv_ztt_mss_rm(u, ui);
  __riscv_ztt_mss_rm(u, si); // expected-error {{Ztt memory base pointee type 'unsigned int' does not match matrix element type 'int'}}
  __riscv_ztt_mss_rm(i, ui); // expected-error {{Ztt memory base pointee type 'int' does not match matrix element type 'unsigned int'}}
}

void pointer_qualifiers(int *p, const int *cp, volatile int *vp,
                        const volatile int *cvp,
                        __riscv_ztt_i32_1x1_t value) {
  __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_mls_cm_i32_1x1(cp);
  __riscv_ztt_mls_rm_i32_1x1(vp); // expected-error {{Ztt load base pointee type 'volatile int' has invalid qualifiers; only const is permitted}}
  __riscv_ztt_mls_cm_i32_1x1(cvp); // expected-error {{Ztt load base pointee type 'const volatile int' has invalid qualifiers; only const is permitted}}

  __riscv_ztt_mss_rm(p, value);
  __riscv_ztt_mss_cm(cp, value); // expected-error {{Ztt store base pointee type 'const int' has invalid qualifiers; the store destination must be writable and non-volatile}}
  __riscv_ztt_mss_rm(vp, value); // expected-error {{Ztt store base pointee type 'volatile int' has invalid qualifiers; the store destination must be writable and non-volatile}}
  __riscv_ztt_mss_cm(cvp, value); // expected-error {{Ztt store base pointee type 'const volatile int' has invalid qualifiers; the store destination must be writable and non-volatile}}
}

// The canonical 64-bit C integer type is ABI-dependent: long long on RV32
// ILP32 and long on RV64 LP64. Raw C types must follow that distinction,
// while the compiler-provided width typedefs work on both targets.
void target_dependent_i64_pointer_type(
    long *l, unsigned long *ul, long long *ll, unsigned long long *ull,
    target_int64_t *portable_i64, target_uint64_t *portable_u64,
    __riscv_ztt_i64_1x1_t mi64, __riscv_ztt_u64_1x1_t mu64) {
  __riscv_ztt_mls_rm_i64_1x1(l); // RV32-error {{Ztt memory base pointee type 'long' does not match matrix element type 'long long'}}
  __riscv_ztt_mls_cm_i64_1x1(ll); // RV64-error {{Ztt memory base pointee type 'long long' does not match matrix element type 'long'}}
  __riscv_ztt_mss_rm(ul, mu64); // RV32-error {{Ztt memory base pointee type 'unsigned long' does not match matrix element type 'unsigned long long'}}
  __riscv_ztt_mss_cm(ull, mu64); // RV64-error {{Ztt memory base pointee type 'unsigned long long' does not match matrix element type 'unsigned long'}}

  __riscv_ztt_mls_rm_i64_1x1(portable_i64);
  __riscv_ztt_mls_cm_u64_1x1(portable_u64);
  __riscv_ztt_mss_rm(portable_i64, mi64);
  __riscv_ztt_mss_cm(portable_u64, mu64);
}

void byte_and_four_bit_types(signed char *i8, unsigned char *u8,
                             signed _BitInt(4) *i4,
                             unsigned _BitInt(4) *u4,
                             __riscv_ztt_i8_1x4_t mi8,
                             __riscv_ztt_u4_1x8_t mu4) {
  __riscv_ztt_mls_rm_i8_1x4(i8);
  __riscv_ztt_mls_rm_u8_1x4(u8);
  __riscv_ztt_mls_rm_i4_1x8(i4); // expected-error {{call to undeclared function '__riscv_ztt_mls_rm_i4_1x8'}}
  __riscv_ztt_mss_cm(u4, mu4); // expected-error {{sub-byte datatypes have no public C element carrier}}
  __riscv_ztt_mss_cm(u8, mi8); // expected-error {{Ztt memory base pointee type 'unsigned char' does not match matrix element type 'signed char'}}
}

void non_pointer(int value, __riscv_ztt_i32_1x1_t matrix) {
  __riscv_ztt_mls_rm_i32_1x1(value); // expected-error {{first argument to RISC-V Ztt memory intrinsic must be a pointer (was 'int')}}
  __riscv_ztt_mss_rm(value, matrix); // expected-error {{first argument to RISC-V Ztt memory intrinsic must be a pointer (was 'int')}}
}
