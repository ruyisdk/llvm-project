; RUN: llvm-as < %s | llvm-dis | FileCheck %s --check-prefix=VALID

define target("riscv.ztt.m.i16", i16, 16, 1, 1) @valid() {
; VALID: define target("riscv.ztt.m.i16", i16, 16, 1, 1) @valid()
  ret target("riscv.ztt.m.i16", i16, 16, 1, 1) zeroinitializer
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @valid_1x2() {
; VALID: define target("riscv.ztt.m.i16", i16, 16, 1, 2) @valid_1x2()
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) zeroinitializer
}

define target("riscv.ztt.m.f32", float, 32, 2, 1) @valid_f32() {
; VALID: define target("riscv.ztt.m.f32", float, 32, 2, 1) @valid_f32()
  ret target("riscv.ztt.m.f32", float, 32, 2, 1) zeroinitializer
}

define target("riscv.ztt.m.u4", i4, 4, 1, 32) @valid_u4() {
; VALID: define target("riscv.ztt.m.u4", i4, 4, 1, 32) @valid_u4()
  ret target("riscv.ztt.m.u4", i4, 4, 1, 32) zeroinitializer
}

define target("riscv.ztt.m.i128", i128, 128, 32, 1) @valid_i128_max() {
; VALID: define target("riscv.ztt.m.i128", i128, 128, 32, 1) @valid_i128_max()
  ret target("riscv.ztt.m.i128", i128, 128, 32, 1) zeroinitializer
}

define target("riscv.ztt.acc.i16", i16, 16, 1) @valid_accx1() {
; VALID: define target("riscv.ztt.acc.i16", i16, 16, 1) @valid_accx1()
  ret target("riscv.ztt.acc.i16", i16, 16, 1) zeroinitializer
}

define target("riscv.ztt.acc.i32", i32, 32, 8) @valid_accx8() {
; VALID: define target("riscv.ztt.acc.i32", i32, 32, 8) @valid_accx8()
  ret target("riscv.ztt.acc.i32", i32, 32, 8) zeroinitializer
}

define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @valid_bf16_accx8() {
; VALID: define target("riscv.ztt.acc.bf16", bfloat, 16, 8) @valid_bf16_accx8()
  ret target("riscv.ztt.acc.bf16", bfloat, 16, 8) zeroinitializer
}

; Clang emits local temporaries before mem2reg. This checks IR legality, not
; backend stack allocation or the matrix spill ABI.
define void @local_temporaries() {
; VALID-LABEL: define void @local_temporaries()
; VALID: %m = alloca target("riscv.ztt.m.i16", i16, 16, 1, 2), align 2
; VALID: %acc = alloca target("riscv.ztt.acc.i32", i32, 32, 8), align 4
  %m = alloca target("riscv.ztt.m.i16", i16, 16, 1, 2), align 2
  %acc = alloca target("riscv.ztt.acc.i32", i32, 32, 8), align 4
  ret void
}

define target("riscv.ztt.acc.i16", i16, 16, 16) @valid_accx16() {
; VALID: define target("riscv.ztt.acc.i16", i16, 16, 16) @valid_accx16()
  ret target("riscv.ztt.acc.i16", i16, 16, 16) zeroinitializer
}
