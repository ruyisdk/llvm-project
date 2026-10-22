; RUN: llc -mtriple=riscv64 -verify-machineinstrs -stop-after=greedy < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s --check-prefix=ASM
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s --check-prefix=ASM

declare target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_4t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_8t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i32_i32_32_1_8t(i32 immarg, i32 immarg)
declare target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i128_i128_128_1_1t(i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_1t(i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_2t(i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_4t(i32 immarg, i32 immarg)
declare target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_8t(i32 immarg, i32 immarg)

define target("riscv.ztt.acc.i16", i16, 16, 16) @acc_i16_x16() nounwind "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m16-a16" {
; CHECK-LABEL: name: acc_i16_x16
; CHECK: %{{[0-9]+}}:zttarm16 = PseudoZTTAClearA16
; CHECK: $ztta0m16 = COPY
; ASM-LABEL: acc_i16_x16:
; ASM-NEXT:    # %bb.0:
; ASM-NEXT:    lui a0, 262144
; ASM-NEXT:    addi a0, a0, 16
; ASM-NEXT:    asettyp acc0, a0
; ASM-NEXT:    asettyp acc1, a0
; ASM-NEXT:    asettyp acc2, a0
; ASM-NEXT:    asettyp acc3, a0
; ASM-NEXT:    asettyp acc4, a0
; ASM-NEXT:    asettyp acc5, a0
; ASM-NEXT:    asettyp acc6, a0
; ASM-NEXT:    asettyp acc7, a0
; ASM-NEXT:    asettyp acc8, a0
; ASM-NEXT:    asettyp acc9, a0
; ASM-NEXT:    asettyp acc10, a0
; ASM-NEXT:    asettyp acc11, a0
; ASM-NEXT:    asettyp acc12, a0
; ASM-NEXT:    asettyp acc13, a0
; ASM-NEXT:    asettyp acc14, a0
; ASM-NEXT:    asettyp acc15, a0
; ASM-NEXT:    ret
  %v = call target("riscv.ztt.acc.i16", i16, 16, 16) @llvm.riscv.ztt.mclear.acc.a16(i32 1073741840, i32 16)
  ret target("riscv.ztt.acc.i16", i16, 16, 16) %v
}
declare target("riscv.ztt.acc.i16", i16, 16, 16) @llvm.riscv.ztt.mclear.acc.a16(i32, i32 immarg)

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @mclear_uds8() #0 {
; CHECK-LABEL: name: mclear_uds8
; CHECK: %{{[0-9]+}}:zttmrm4 = PseudoZTTMSetTypM4
; CHECK: $zttm0m4 = COPY
; ASM-LABEL: mclear_uds8:
; ASM: msettyp m0, a0
; ASM-NEXT: msettyp m2, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %res
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @mclear_uds16() #1 {
; CHECK-LABEL: name: mclear_uds16
; CHECK: %{{[0-9]+}}:zttmrm2 = PseudoZTTMSetTypM2
; CHECK: $zttm0m2 = COPY
; ASM-LABEL: mclear_uds16:
; ASM: msettyp m0, a0
; ASM-NEXT: msettyp m1, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %res
}

define target("riscv.ztt.m.i16", i16, 16, 1, 2) @mclear_uds32() #2 {
; CHECK-LABEL: name: mclear_uds32
; CHECK: %{{[0-9]+}}:zttmr = PseudoZTTMSetTypM1
; CHECK: $zttm0 = COPY
; ASM-LABEL: mclear_uds32:
; ASM: msettyp m0, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 2) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_2t(i32 1073741840, i32 2)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 2) %res
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @mclear_m8() #0 {
; CHECK-LABEL: name: mclear_m8
; CHECK: %{{[0-9]+}}:zttmrm8 = PseudoZTTMSetTypM8
; CHECK: $zttm0m8 = COPY
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %res
}

define target("riscv.ztt.m.i16", i16, 16, 1, 8) @mclear_m16() #0 {
; CHECK-LABEL: name: mclear_m16
; CHECK: %{{[0-9]+}}:zttmrm16 = PseudoZTTMSetTypM16
; CHECK: $zttm0m16 = COPY
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 8) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_8t(i32 1073741840, i32 8)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 8) %res
}

define target("riscv.ztt.m.i32", i32, 32, 1, 8) @mclear_m32() #0 {
; CHECK-LABEL: name: mclear_m32
; CHECK: %{{[0-9]+}}:zttmrm32 = PseudoZTTMSetTypM32
; CHECK: $zttm0m32 = COPY
  %res = call target("riscv.ztt.m.i32", i32, 32, 1, 8) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i32_i32_32_1_8t(i32 1073741856, i32 8)
  ret target("riscv.ztt.m.i32", i32, 32, 1, 8) %res
}

define target("riscv.ztt.m.i16", i16, 16, 1, 4) @mclear_uds64() #3 {
; CHECK-LABEL: name: mclear_uds64
; CHECK: %{{[0-9]+}}:zttmr = PseudoZTTMSetTypM1
; CHECK: $zttm0 = COPY
  %res = call target("riscv.ztt.m.i16", i16, 16, 1, 4) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i16_i16_16_1_4t(i32 1073741840, i32 4)
  ret target("riscv.ztt.m.i16", i16, 16, 1, 4) %res
}

attributes #0 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u8-m32-a16" }
define target("riscv.ztt.m.i128", i128, 128, 1, 1) @mclear_uds128() #4 {
; CHECK-LABEL: name: mclear_uds128
; CHECK: %{{[0-9]+}}:zttmr = PseudoZTTMSetTypM1
; CHECK: $zttm0 = COPY
; ASM-LABEL: mclear_uds128:
; ASM: msettyp m0, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.m.i128", i128, 128, 1, 1) @llvm.riscv.ztt.mclear.m.triscv.ztt.m.i128_i128_128_1_1t(i32 1073741952, i32 1)
  ret target("riscv.ztt.m.i128", i128, 128, 1, 1) %res
}

define target("riscv.ztt.acc.i32", i32, 32, 1) @mclear_accx1() #2 {
; CHECK-LABEL: name: mclear_accx1
; CHECK: %{{[0-9]+}}:zttar = PseudoZTTAClearA1
; ASM-LABEL: mclear_accx1:
; ASM: asettyp acc0, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.acc.i32", i32, 32, 1) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_1t(i32 1073741856, i32 1)
  ret target("riscv.ztt.acc.i32", i32, 32, 1) %res
}

define target("riscv.ztt.acc.i32", i32, 32, 2) @mclear_accx2() #2 {
; CHECK-LABEL: name: mclear_accx2
; CHECK: %{{[0-9]+}}:zttarm2 = PseudoZTTAClearA2
; ASM-LABEL: mclear_accx2:
; ASM: asettyp acc0, a0
; ASM-NEXT: asettyp acc1, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.acc.i32", i32, 32, 2) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_2t(i32 1073741856, i32 2)
  ret target("riscv.ztt.acc.i32", i32, 32, 2) %res
}

define target("riscv.ztt.acc.i32", i32, 32, 4) @mclear_accx4() #2 {
; CHECK-LABEL: name: mclear_accx4
; CHECK: %{{[0-9]+}}:zttarm4 = PseudoZTTAClearA4
; ASM-LABEL: mclear_accx4:
; ASM: asettyp acc0, a0
; ASM-NEXT: asettyp acc1, a0
; ASM-NEXT: asettyp acc2, a0
; ASM-NEXT: asettyp acc3, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.acc.i32", i32, 32, 4) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_4t(i32 1073741856, i32 4)
  ret target("riscv.ztt.acc.i32", i32, 32, 4) %res
}

define target("riscv.ztt.acc.i32", i32, 32, 8) @mclear_accx8() #2 {
; CHECK-LABEL: name: mclear_accx8
; CHECK: %{{[0-9]+}}:zttarm8 = PseudoZTTAClearA8
; ASM-LABEL: mclear_accx8:
; ASM: asettyp acc0, a0
; ASM-NEXT: asettyp acc1, a0
; ASM-NEXT: asettyp acc2, a0
; ASM-NEXT: asettyp acc3, a0
; ASM-NEXT: asettyp acc4, a0
; ASM-NEXT: asettyp acc5, a0
; ASM-NEXT: asettyp acc6, a0
; ASM-NEXT: asettyp acc7, a0
; ASM-NEXT: ret
  %res = call target("riscv.ztt.acc.i32", i32, 32, 8) @llvm.riscv.ztt.mclear.acc.triscv.ztt.acc.i32_i32_32_8t(i32 1073741856, i32 8)
  ret target("riscv.ztt.acc.i32", i32, 32, 8) %res
}

attributes #1 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u16-m32-a16" }
attributes #2 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u32-m32-a16" }
attributes #3 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u64-m32-a16" }
attributes #4 = { "target-features"="+ztt" "riscv-ztt-profile"="clang-runtime-u128-m32-a16" }
