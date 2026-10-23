; RUN: opt -mtriple=riscv32 -passes=inline -S %s | FileCheck %s --check-prefixes=CHECK,INLINE
; RUN: opt -mtriple=riscv64 -passes=inline -S %s | FileCheck %s --check-prefixes=CHECK,INLINE
; RUN: opt -mtriple=riscv32 -passes=always-inline -S %s | FileCheck %s --check-prefix=CHECK
; RUN: opt -mtriple=riscv64 -passes=always-inline -S %s | FileCheck %s --check-prefix=CHECK

define i32 @base() #0 {
  ret i32 7
}

define i32 @fixed() #4 {
  ret i32 7
}

define i32 @needs_m() #6 {
  ret i32 7
}

define i32 @plain() {
  ret i32 7
}

define i32 @forced() #0 alwaysinline {
  ret i32 7
}

; Matching profiles permit normal inlining.
; INLINE-LABEL: define i32 @same()
; INLINE-NEXT: ret i32 7
; INLINE-NEXT: }
define i32 @same() #0 {
  %r = call i32 @base()
  ret i32 %r
}

; Each profile field independently prevents inlining.
; INLINE-LABEL: define i32 @different_uds()
; INLINE-NEXT: %r = call i32 @base()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @different_uds() #1 {
  %r = call i32 @base()
  ret i32 %r
}

; INLINE-LABEL: define i32 @different_mregs()
; INLINE-NEXT: %r = call i32 @base()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @different_mregs() #2 {
  %r = call i32 @base()
  ret i32 %r
}

; INLINE-LABEL: define i32 @different_aregs()
; INLINE-NEXT: %r = call i32 @base()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @different_aregs() #3 {
  %r = call i32 @base()
  ret i32 %r
}

; INLINE-LABEL: define i32 @fixed_to_runtime()
; INLINE-NEXT: %r = call i32 @base()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @fixed_to_runtime() #4 {
  %r = call i32 @base()
  ret i32 %r
}

; INLINE-LABEL: define i32 @runtime_to_fixed()
; INLINE-NEXT: %r = call i32 @fixed()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @runtime_to_fixed() #0 {
  %r = call i32 @fixed()
  ret i32 %r
}

; INLINE-LABEL: define i32 @different_n()
; INLINE-NEXT: %r = call i32 @fixed()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @different_n() #5 {
  %r = call i32 @fixed()
  ret i32 %r
}

; Matching profiles do not bypass the existing ISA checks.
; INLINE-LABEL: define i32 @incompatible_isa()
; INLINE-NEXT: %r = call i32 @needs_m()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @incompatible_isa() #0 {
  %r = call i32 @needs_m()
  ret i32 %r
}

; A missing profile is not compatible with a configured profile in either direction.
; INLINE-LABEL: define i32 @missing_caller_profile()
; INLINE-NEXT: %r = call i32 @base()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @missing_caller_profile() {
  %r = call i32 @base()
  ret i32 %r
}

; INLINE-LABEL: define i32 @missing_callee_profile()
; INLINE-NEXT: %r = call i32 @plain()
; INLINE-NEXT: ret i32 %r
; INLINE-NEXT: }
define i32 @missing_callee_profile() #0 {
  %r = call i32 @plain()
  ret i32 %r
}

; Ordinary non-Ztt inlining is unchanged.
; INLINE-LABEL: define i32 @no_profiles()
; INLINE-NEXT: ret i32 7
; INLINE-NEXT: }
define i32 @no_profiles() {
  %r = call i32 @plain()
  ret i32 %r
}

; Both inliners must enforce the profile even with alwaysinline.
; CHECK-LABEL: define i32 @forced_same()
; CHECK-NEXT: ret i32 7
; CHECK-NEXT: }
define i32 @forced_same() #0 {
  %r = call i32 @forced()
  ret i32 %r
}

; CHECK-LABEL: define i32 @forced_different()
; CHECK-NEXT: %r = call i32 @forced()
; CHECK-NEXT: ret i32 %r
; CHECK-NEXT: }
define i32 @forced_different() #1 {
  %r = call i32 @forced()
  ret i32 %r
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a4" }
attributes #1 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m16-a4" }
attributes #2 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a4" }
attributes #3 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a8" }
attributes #4 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-n128-u32-m16-a4" }
attributes #5 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-n256-u32-m16-a4" }
attributes #6 = { "target-features"="+ztt,+m" "riscv-ztt-profile"="clang-runtime-u32-m16-a4" }
