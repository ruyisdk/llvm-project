// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -std=c11 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -std=c11 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -x c++ -std=c++17 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -x c++ -std=c++17 -fsyntax-only -verify %s

#include <riscv_ztt.h>

typedef __riscv_ztt_i16_1x2_t M;
typedef __riscv_ztt_i32_accx1_t A;

// Sizeless types cannot have global storage, even in extern declarations.
extern M external_matrix; // expected-error {{non-local variable with sizeless type}}
extern A external_acc; // expected-error {{non-local variable with sizeless type}}
// Wrappers may be declared/defined, but cannot initialize a matrix object.
M wrapper(void);
M (*wrapper_pointer)(void);
static inline __attribute__((always_inline)) M inline_wrapper(void) {
  return __riscv_ztt_mclear_m_i16_1x2();
}
M __riscv_ztt_fake_intrinsic(void);

M global_default; // expected-error {{non-local variable with sizeless type}}
A global_acc_default; // expected-error {{non-local variable with sizeless type}}

#define CLEAR_M() __riscv_ztt_mclear_m_i16_1x2()
void valid(short *p, M src, A acc, __riscv_ztt_i32_1x1_t square) {
  M cleared = CLEAR_M();
  M parenthesized = ((CLEAR_M()));
  M builtin = __builtin_riscv_ztt_mclear_m((M *)0);
  const M qualified = __riscv_ztt_mclear_m_i16_1x2();
  M loaded = __riscv_ztt_mls_rm_i16_1x2(p);
  M copied = __riscv_ztt_mcopy_m2m_i16_1x2(src);
  __riscv_ztt_i16_accx2_t converted = __riscv_ztt_mcopy_m2a_i16_accx2(src);
  M restored = __riscv_ztt_mcopy_a2m_i16_1x2(converted);
  A zero = __riscv_ztt_mclear_acc_i32_accx1();
  A product = __riscv_ztt_mmulacc_2d_i32_accx1(acc, square, square);
  __riscv_ztt_i16_1x4_t joined = __riscv_ztt_mconcat_m_i16_1x4(src, src);
  __riscv_ztt_i64_1x1_t wide = __riscv_ztt_mclear_m_i64_1x1();
  __riscv_ztt_f32_1x1_t fp = __riscv_ztt_mclear_m_f32_1x1();
  __riscv_ztt_bf16_accx8_t fp_acc = __riscv_ztt_mclear_acc_bf16_accx8();
  __riscv_ztt_mss_rm(p, copied);
#ifdef __cplusplus
  M direct(CLEAR_M());
  auto deduced = CLEAR_M();
  decltype(auto) deduced_value = CLEAR_M();
  M &reference = src; // A reference binds to an existing object; no copy.
#endif
}

void invalid(M src, A acc, int cond) {
  M no_init; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  const M const_no_init; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  static M static_no_init; // expected-error {{non-local variable with sizeless type}}
  A acc_no_init; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M copy = src; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  A acc_copy = acc; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M external_copy = external_matrix; // Already rejected at the declaration.
  M from_wrapper = wrapper(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M from_inline_wrapper = inline_wrapper(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M indirect = wrapper_pointer(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M spoof = __riscv_ztt_fake_intrinsic(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M empty = {}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  A acc_empty = {}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M zero = {0}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M braced_copy = {src}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M braced_call = {CLEAR_M()}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M comma = ((void)cond, CLEAR_M()); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M conditional = cond ? CLEAR_M() : CLEAR_M(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M statement = ({ CLEAR_M(); }); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  (void)__builtin_bit_cast(M, src); // expected-error {{destination type must be trivially copyable}}
#ifdef __cplusplus
  M direct_copy(src); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M multiple(src, src); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  A acc_direct_copy(acc); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  M direct_empty{}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  auto auto_copy = src; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  auto auto_wrapper = wrapper(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  decltype(auto) decltype_copy = src; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  (void)M(); // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  (void)M(src); // expected-error {{functional-style cast}}
  (void)M{}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  (void)static_cast<M>(src); // expected-error {{static_cast}}
  (void)new M; // expected-error {{allocation of sizeless type}}
  (void)new M(src); // expected-error {{allocation of sizeless type}}
#else
  (void)(M)src; // expected-error {{where arithmetic or pointer type is required}}
  (void)(A)acc; // expected-error {{where arithmetic or pointer type is required}}
  (void)(const M)src; // expected-error {{where arithmetic or pointer type is required}}
  (void)(M){src}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
  (void)(A){}; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
#endif
}

// Aggregate storage must not provide a back door for default initialization or
// copying matrices. Pointers and references do not create matrix storage.
struct MatrixHolder;
struct MatrixHolder { M value; }; // expected-error {{field has sizeless type}}
struct NestedHolder { struct MatrixHolder value; };
union AccHolder { A value; int scalar; }; // expected-error {{field has sizeless type}}
struct MatrixPointer { M *value; };
void aggregate_storage(struct MatrixHolder src) {
  struct MatrixHolder copy = src;
  struct MatrixHolder empty;
  M array[2]; // expected-error {{array has sizeless element type}}
  M initialized_array[1] = {CLEAR_M()}; // expected-error {{array has sizeless element type}}
  struct NestedHolder nested;
  union AccHolder acc_union;
  struct MatrixPointer pointers = {0};
  struct MatrixPointer pointer_copy = pointers;
  M *pointer = 0;
}

#ifdef __cplusplus
static_assert(!__is_constructible(M));
static_assert(!__is_constructible(M, M));
static_assert(!__is_constructible(M, M, M));
static_assert(!__is_constructible(A));
static_assert(!__is_constructible(A, const A &));
static_assert(!__is_trivially_copyable(M));
static_assert(!__is_trivially_copyable(const M));
static_assert(!__is_trivially_copyable(A));
static_assert(__is_constructible(int, int));

template <class T> void template_copy(T src) {
  T copy = src; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
}
template <class T> void template_default() {
  T value; // expected-error {{must be initialized directly by a RISC-V Ztt intrinsic call}}
}
void instantiate(M m) {
  template_copy(m); // expected-note {{in instantiation of function template specialization}}
  template_default<A>(); // expected-note {{in instantiation of function template specialization}}
}
#endif

// Ordinary C/C++ objects retain their normal initialization rules.
void ordinary(int src) {
  int uninitialized;
  int copy = src;
  int zero = {0};
  __riscv_ztt_i32_scalar_t scalar = src;
  __riscv_ztt_i32_scalar_t scalar_copy = scalar;
  __riscv_ztt_i32_scalar_t scalar_uninitialized;
}

// A direct intrinsic initializer must still have a compatible result type.
void result_type_mismatch(void) {
#ifdef __cplusplus
  M wrong_result = __riscv_ztt_mclear_m_i32_1x1(); // expected-error {{cannot initialize a variable of type}}
#else
  M wrong_result = __riscv_ztt_mclear_m_i32_1x1(); // expected-error {{with an expression of incompatible type}}
#endif
}
