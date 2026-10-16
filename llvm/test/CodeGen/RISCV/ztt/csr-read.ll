; RUN: split-file %s %t
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-ll/input.ll > %t.ztt-profile-0.ll
; RUN: llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs < %t.ztt-profile-0.ll | FileCheck %t/csr-read-ll/input.ll
; RUN: sed 's/i64/i32/g' %t/csr-read-ll/input.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs | FileCheck %t/csr-read-ll/input.ll
; RUN: opt -passes='default<O2>' -S %t/csr-read-ll/input.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs | FileCheck %t/csr-read-ll/input.ll
; RUN: sed 's/i64/i32/g' %t/csr-read-ll/input.ll | opt -passes='default<O2>' -S | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs | FileCheck %t/csr-read-ll/input.ll
; RUN: not --crash llc -mtriple=riscv64 -verify-machineinstrs %t/csr-read-invalid-ll/tmp/no-ztt.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=FEATURE
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/no-ztt.ll | not --crash llc -mtriple=riscv32 -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=FEATURE
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/ameown.ll > %t.ztt-profile-1.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-1.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=ameown
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/ameown.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=ameown
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/amestype.ll > %t.ztt-profile-2.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-2.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=amestype
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/amestype.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=amestype
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/amenlen.ll > %t.ztt-profile-3.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-3.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=amenlen
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/amenlen.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=amenlen
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/ameudsz.ll > %t.ztt-profile-4.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-4.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=ameudsz
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/ameudsz.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=ameudsz
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/amefflags.ll > %t.ztt-profile-5.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-5.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=amefflags
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/amefflags.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=amefflags
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/amexsat.ll > %t.ztt-profile-6.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-6.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=amexsat
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/amexsat.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=amexsat
; RUN: sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' %t/csr-read-invalid-ll/tmp/amestatus.ll > %t.ztt-profile-7.ll
; RUN: not --crash llc -mtriple=riscv32 -mattr=+ztt -verify-machineinstrs %t.ztt-profile-7.ll -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV32 -DCSR=amestatus
; RUN: sed 's/i64/i32/g' %t/csr-read-invalid-ll/tmp/amestatus.ll | sed 's/ZTT_PROFILE/clang-runtime-u16-m32-a16/g' | not --crash llc -mtriple=riscv64 -mattr=+ztt -verify-machineinstrs -o /dev/null 2>&1 | FileCheck %t/csr-read-invalid-ll/checks.txt --check-prefix=RV64 -DCSR=amestatus

; Sections keep distinct IR/MIR inputs and their original check prefixes.
; Positive assembly checks and negative contracts remain independently runnable.

;--- csr-read-ll/input.ll
; Design section 3.2: one read of the named CSR, no ownership/datatype changes.
; Scalar CSR reads require the same complete Ztt profile as matrix operations.

define i64 @read_ameown() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_ameown:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, ameown
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.ameown.i64()
  ret i64 %value
}

define i64 @read_amestype() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_amestype:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amestype
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.amestype.i64()
  ret i64 %value
}

define i64 @read_amenlen() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_amenlen:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amenlen
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.amenlen.i64()
  ret i64 %value
}

define i64 @read_ameudsz() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_ameudsz:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, ameudsz
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.ameudsz.i64()
  ret i64 %value
}

define i64 @read_amefflags() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_amefflags:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amefflags
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.amefflags.i64()
  ret i64 %value
}

define i64 @read_amexsat() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_amexsat:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amexsat
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.amexsat.i64()
  ret i64 %value
}

define i64 @read_amestatus() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_amestatus:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amestatus
; CHECK-NEXT: ret
  %value = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  ret i64 %value
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_ameown() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_ameown:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, ameown
; CHECK-NEXT: csrr a1, ameown
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.ameown.i64()
  %second = call i64 @llvm.riscv.ztt.get.ameown.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_amestype() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_amestype:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amestype
; CHECK-NEXT: csrr a1, amestype
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.amestype.i64()
  %second = call i64 @llvm.riscv.ztt.get.amestype.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_amenlen() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_amenlen:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amenlen
; CHECK-NEXT: csrr a1, amenlen
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.amenlen.i64()
  %second = call i64 @llvm.riscv.ztt.get.amenlen.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_ameudsz() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_ameudsz:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, ameudsz
; CHECK-NEXT: csrr a1, ameudsz
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.ameudsz.i64()
  %second = call i64 @llvm.riscv.ztt.get.ameudsz.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_amefflags() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_amefflags:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amefflags
; CHECK-NEXT: csrr a1, amefflags
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.amefflags.i64()
  %second = call i64 @llvm.riscv.ztt.get.amefflags.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_amexsat() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_amexsat:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amexsat
; CHECK-NEXT: csrr a1, amexsat
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.amexsat.i64()
  %second = call i64 @llvm.riscv.ztt.get.amexsat.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Reads observe state and must not be commoned, even for capability CSRs.
define i64 @repeat_amestatus() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: repeat_amestatus:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amestatus
; CHECK-NEXT: csrr a1, amestatus
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  %second = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

; Even unused reads can trap; preserve all seven in program order. CSRRS still
; reads the CSR with rd=x0: discarding its result must not suppress the access.
define void @discard_reads() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: discard_reads:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr zero, ameown
; CHECK-NEXT: csrr zero, amestype
; CHECK-NEXT: csrr zero, amenlen
; CHECK-NEXT: csrr zero, ameudsz
; CHECK-NEXT: csrr zero, amefflags
; CHECK-NEXT: csrr zero, amexsat
; CHECK-NEXT: csrr zero, amestatus
; CHECK-NEXT: ret
  %ameown = call i64 @llvm.riscv.ztt.get.ameown.i64()
  %amestype = call i64 @llvm.riscv.ztt.get.amestype.i64()
  %amenlen = call i64 @llvm.riscv.ztt.get.amenlen.i64()
  %ameudsz = call i64 @llvm.riscv.ztt.get.ameudsz.i64()
  %amefflags = call i64 @llvm.riscv.ztt.get.amefflags.i64()
  %amexsat = call i64 @llvm.riscv.ztt.get.amexsat.i64()
  %amestatus = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  ret void
}

; State changes must stay between the two observations. Clearing amestatus
; here is test-only inline assembly, not a new public CSR-write interface.
define i64 @read_across_status_clear() nounwind "riscv-ztt-profile"="ZTT_PROFILE" {
; CHECK-LABEL: read_across_status_clear:
; CHECK-NEXT: # %bb.0:
; CHECK-NEXT: csrr a0, amestatus
; CHECK-NEXT: #APP
; CHECK-NEXT: csrwi amestatus, 0
; CHECK-NEXT: #NO_APP
; CHECK-NEXT: csrr a1, amestatus
; CHECK-NEXT: sub a0, a0, a1
; CHECK-NEXT: ret
  %first = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  call void asm sideeffect "csrwi amestatus, 0", "~{memory}"()
  %second = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  %difference = sub i64 %first, %second
  ret i64 %difference
}

declare i64 @llvm.riscv.ztt.get.ameown.i64()
declare i64 @llvm.riscv.ztt.get.amestype.i64()
declare i64 @llvm.riscv.ztt.get.amenlen.i64()
declare i64 @llvm.riscv.ztt.get.ameudsz.i64()
declare i64 @llvm.riscv.ztt.get.amefflags.i64()
declare i64 @llvm.riscv.ztt.get.amexsat.i64()
declare i64 @llvm.riscv.ztt.get.amestatus.i64()

;--- csr-read-invalid-ll/checks.txt
; FEATURE: LLVM ERROR: Cannot select: intrinsic %llvm.riscv.ztt.get.ameown
; selection: RV32 cannot expand an i64 result and RV64 cannot promote i32.
; RV32: ExpandIntegerResult
; RV32-SAME: i64,ch = llvm.riscv.ztt.get.[[CSR]]
; RV32: LLVM ERROR: Do not know how to expand the result of this operator!
; RV64: PromoteIntegerResult
; RV64-SAME: i32,ch = llvm.riscv.ztt.get.[[CSR]]
; RV64: LLVM ERROR: Do not know how to promote this operator!

;--- csr-read-invalid-ll/tmp/no-ztt.ll
define i64 @read_without_ztt() {
  %value = call i64 @llvm.riscv.ztt.get.ameown.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.ameown.i64()

;--- csr-read-invalid-ll/tmp/ameown.ll
define i64 @wrong_width_ameown() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.ameown.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.ameown.i64()

;--- csr-read-invalid-ll/tmp/amestype.ll
define i64 @wrong_width_amestype() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.amestype.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.amestype.i64()

;--- csr-read-invalid-ll/tmp/amenlen.ll
define i64 @wrong_width_amenlen() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.amenlen.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.amenlen.i64()

;--- csr-read-invalid-ll/tmp/ameudsz.ll
define i64 @wrong_width_ameudsz() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.ameudsz.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.ameudsz.i64()

;--- csr-read-invalid-ll/tmp/amefflags.ll
define i64 @wrong_width_amefflags() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.amefflags.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.amefflags.i64()

;--- csr-read-invalid-ll/tmp/amexsat.ll
define i64 @wrong_width_amexsat() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.amexsat.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.amexsat.i64()

;--- csr-read-invalid-ll/tmp/amestatus.ll
define i64 @wrong_width_amestatus() "riscv-ztt-profile"="ZTT_PROFILE" {
  %value = call i64 @llvm.riscv.ztt.get.amestatus.i64()
  ret i64 %value
}
declare i64 @llvm.riscv.ztt.get.amestatus.i64()
