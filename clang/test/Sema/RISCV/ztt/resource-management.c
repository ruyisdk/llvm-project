// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m16-a4 -fsyntax-only -verify %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -fsyntax-only -verify %s

#include <riscv_ztt.h>

_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_ame_acquire(0)), size_t), "size_t result");
_Static_assert(__builtin_types_compatible_p(__typeof__(__riscv_ztt_ame_release()), void), "void result");

enum WaitMode { TRY, BOUNDED_WAIT };
void integer_controls(size_t n, int i, unsigned u, long l, unsigned long ul,
                      long long ll, unsigned long long ull, short s,
                      _Bool b, enum WaitMode mode, _Atomic(int) *a) {
  __riscv_ztt_ame_acquire(n);
  __riscv_ztt_ame_acquire(i);
  __riscv_ztt_ame_acquire(u);
  __riscv_ztt_ame_acquire(l);
  __riscv_ztt_ame_acquire(ul);
  __riscv_ztt_ame_acquire(ll);
  __riscv_ztt_ame_acquire(ull);
  __riscv_ztt_ame_acquire(s);
  __riscv_ztt_ame_acquire(b);
  __riscv_ztt_ame_acquire(mode);
  __riscv_ztt_ame_acquire(*a);
  __riscv_ztt_ame_acquire(0);
  __riscv_ztt_ame_acquire(0x1);
  // Reserved descriptor encodings are legal C arguments: hardware returns
  // BAD_DESC. Do not add an immediate-only or descriptor-range restriction.
  __riscv_ztt_ame_acquire(3);
  __riscv_ztt_ame_acquire(64);
  __riscv_ztt_ame_acquire(-1);
  __riscv_ztt_ame_release();
}

void bad_controls(float f, double d, void *p) {
  __riscv_ztt_ame_acquire(f); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type, not 'float'}}
  __riscv_ztt_ame_acquire(d); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type, not 'double'}}
  __riscv_ztt_ame_acquire(1.0); // expected-error {{control argument to RISC-V Ztt intrinsic must have integer type, not 'double'}}
  __riscv_ztt_ame_acquire(p); // expected-error {{incompatible pointer to integer conversion passing 'void *' to parameter of type}}
  // expected-error@-1 {{control argument to RISC-V Ztt intrinsic must have integer type, not 'void *'}}
  // Explicit integer conversions are allowed and remain the user's choice.
  __riscv_ztt_ame_acquire((size_t)f);
  __riscv_ztt_ame_acquire((size_t)p);
  __riscv_ztt_ame_acquire(); // expected-error {{too few arguments to function call, expected 1, have 0}}
  __riscv_ztt_ame_acquire(0, 1); // expected-error {{too many arguments to function call, expected 1, have 2}}
  __riscv_ztt_ame_release(0); // expected-error {{too many arguments to function call, expected 0, have 1}}
}
