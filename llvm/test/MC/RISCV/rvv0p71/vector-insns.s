# Adapted from https://github.com/riscvarchive/riscv-binutils-gdb/blob/1aeeeab05f3c39e2bfc6e99384490d4c7f484ba0/gas/testsuite/gas/riscv/vector-insns.s
# Golden value for this test: https://github.com/riscvarchive/riscv-binutils-gdb/blob/1aeeeab05f3c39e2bfc6e99384490d4c7f484ba0/gas/testsuite/gas/riscv/vector-insns.d
# Generated using the script: https://gist.github.com/imkiva/05facf1a51ff8abfeeeea8fa7bc307ad#file-rvvtestgen-java

# RUN: llvm-mc -triple=riscv64 -show-encoding --mattr=+f,+a,+xtheadvector,+xtheadvlsseg,+xtheadvamo %s \
# RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST

vsetvl a0, a1, a2
# CHECK-INST: vsetvl	a0, a1, a2
# CHECK-ENCODING: [0x57,0xf5,0xc5,0x80]

vsetvli a0, a1, 0
# CHECK-INST: vsetvli	a0, a1, e8, m1, d1
# CHECK-ENCODING: [0x57,0xf5,0x05,0x00]

vsetvli a0, a1, 0x7ff
# CHECK-INST: vsetvli	a0, a1, 2047
# CHECK-ENCODING: [0x57,0xf5,0xf5,0x7f]

vsetvli a0, a1, e16,m2,d4
# CHECK-INST: vsetvli	a0, a1, e16, m2, d4
# CHECK-ENCODING: [0x57,0xf5,0x55,0x04]

vlb.v v4, (a0)
# CHECK-INST: vlb.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x12]

vlb.v v4, 0(a0)
# CHECK-INST: vlb.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x12]

vlb.v v4, (a0), v0.t
# CHECK-INST: vlb.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x10]

vlh.v v4, (a0)
# CHECK-INST: vlh.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x12]

vlh.v v4, 0(a0)
# CHECK-INST: vlh.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x12]

vlh.v v4, (a0), v0.t
# CHECK-INST: vlh.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x10]

vlw.v v4, (a0)
# CHECK-INST: vlw.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x12]

vlw.v v4, 0(a0)
# CHECK-INST: vlw.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x12]

vlw.v v4, (a0), v0.t
# CHECK-INST: vlw.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x10]

vlbu.v v4, (a0)
# CHECK-INST: vlbu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x02]

vlbu.v v4, 0(a0)
# CHECK-INST: vlbu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x02]

vlbu.v v4, (a0), v0.t
# CHECK-INST: vlbu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x00]

vlhu.v v4, (a0)
# CHECK-INST: vlhu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x02]

vlhu.v v4, 0(a0)
# CHECK-INST: vlhu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x02]

vlhu.v v4, (a0), v0.t
# CHECK-INST: vlhu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x00]

vlwu.v v4, (a0)
# CHECK-INST: vlwu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x02]

vlwu.v v4, 0(a0)
# CHECK-INST: vlwu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x02]

vlwu.v v4, (a0), v0.t
# CHECK-INST: vlwu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x00]

vle.v v4, (a0)
# CHECK-INST: vle.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x02]

vle.v v4, 0(a0)
# CHECK-INST: vle.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x02]

vle.v v4, (a0), v0.t
# CHECK-INST: vle.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x00]

vsb.v v4, (a0)
# CHECK-INST: vsb.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x02]

vsb.v v4, 0(a0)
# CHECK-INST: vsb.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x02]

vsb.v v4, (a0), v0.t
# CHECK-INST: vsb.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0x00]

vsh.v v4, (a0)
# CHECK-INST: vsh.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x02]

vsh.v v4, 0(a0)
# CHECK-INST: vsh.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x02]

vsh.v v4, (a0), v0.t
# CHECK-INST: vsh.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0x00]

vsw.v v4, (a0)
# CHECK-INST: vsw.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x02]

vsw.v v4, 0(a0)
# CHECK-INST: vsw.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x02]

vsw.v v4, (a0), v0.t
# CHECK-INST: vsw.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0x00]

vse.v v4, (a0)
# CHECK-INST: vse.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x02]

vse.v v4, 0(a0)
# CHECK-INST: vse.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x02]

vse.v v4, (a0), v0.t
# CHECK-INST: vse.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0x00]

vlsb.v v4, (a0), a1
# CHECK-INST: vlsb.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x1a]

vlsb.v v4, 0(a0), a1
# CHECK-INST: vlsb.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x1a]

vlsb.v v4, (a0), a1, v0.t
# CHECK-INST: vlsb.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x18]

vlsh.v v4, (a0), a1
# CHECK-INST: vlsh.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x1a]

vlsh.v v4, 0(a0), a1
# CHECK-INST: vlsh.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x1a]

vlsh.v v4, (a0), a1, v0.t
# CHECK-INST: vlsh.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x18]

vlsw.v v4, (a0), a1
# CHECK-INST: vlsw.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x1a]

vlsw.v v4, 0(a0), a1
# CHECK-INST: vlsw.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x1a]

vlsw.v v4, (a0), a1, v0.t
# CHECK-INST: vlsw.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x18]

vlsbu.v v4, (a0), a1
# CHECK-INST: vlsbu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x0a]

vlsbu.v v4, 0(a0), a1
# CHECK-INST: vlsbu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x0a]

vlsbu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsbu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x08]

vlshu.v v4, (a0), a1
# CHECK-INST: vlshu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x0a]

vlshu.v v4, 0(a0), a1
# CHECK-INST: vlshu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x0a]

vlshu.v v4, (a0), a1, v0.t
# CHECK-INST: vlshu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x08]

vlswu.v v4, (a0), a1
# CHECK-INST: vlswu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x0a]

vlswu.v v4, 0(a0), a1
# CHECK-INST: vlswu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x0a]

vlswu.v v4, (a0), a1, v0.t
# CHECK-INST: vlswu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x08]

vlse.v v4, (a0), a1
# CHECK-INST: vlse.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x0a]

vlse.v v4, 0(a0), a1
# CHECK-INST: vlse.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x0a]

vlse.v v4, (a0), a1, v0.t
# CHECK-INST: vlse.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0x08]

vssb.v v4, (a0), a1
# CHECK-INST: vssb.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x0a]

vssb.v v4, 0(a0), a1
# CHECK-INST: vssb.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x0a]

vssb.v v4, (a0), a1, v0.t
# CHECK-INST: vssb.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0x08]

vssh.v v4, (a0), a1
# CHECK-INST: vssh.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x0a]

vssh.v v4, 0(a0), a1
# CHECK-INST: vssh.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x0a]

vssh.v v4, (a0), a1, v0.t
# CHECK-INST: vssh.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0x08]

vssw.v v4, (a0), a1
# CHECK-INST: vssw.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x0a]

vssw.v v4, 0(a0), a1
# CHECK-INST: vssw.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x0a]

vssw.v v4, (a0), a1, v0.t
# CHECK-INST: vssw.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0x08]

vsse.v v4, (a0), a1
# CHECK-INST: vsse.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x0a]

vsse.v v4, 0(a0), a1
# CHECK-INST: vsse.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x0a]

vsse.v v4, (a0), a1, v0.t
# CHECK-INST: vsse.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0x08]

vlxb.v v4, (a0), v12
# CHECK-INST: vlxb.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x1e]

vlxb.v v4, 0(a0), v12
# CHECK-INST: vlxb.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x1e]

vlxb.v v4, (a0), v12, v0.t
# CHECK-INST: vlxb.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x1c]

vlxh.v v4, (a0), v12
# CHECK-INST: vlxh.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x1e]

vlxh.v v4, 0(a0), v12
# CHECK-INST: vlxh.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x1e]

vlxh.v v4, (a0), v12, v0.t
# CHECK-INST: vlxh.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x1c]

vlxw.v v4, (a0), v12
# CHECK-INST: vlxw.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x1e]

vlxw.v v4, 0(a0), v12
# CHECK-INST: vlxw.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x1e]

vlxw.v v4, (a0), v12, v0.t
# CHECK-INST: vlxw.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x1c]

vlxbu.v v4, (a0), v12
# CHECK-INST: vlxbu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x0e]

vlxbu.v v4, 0(a0), v12
# CHECK-INST: vlxbu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x0e]

vlxbu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxbu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x0c]

vlxhu.v v4, (a0), v12
# CHECK-INST: vlxhu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x0e]

vlxhu.v v4, 0(a0), v12
# CHECK-INST: vlxhu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x0e]

vlxhu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxhu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x0c]

vlxwu.v v4, (a0), v12
# CHECK-INST: vlxwu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x0e]

vlxwu.v v4, 0(a0), v12
# CHECK-INST: vlxwu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x0e]

vlxwu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxwu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x0c]

vlxe.v v4, (a0), v12
# CHECK-INST: vlxe.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x0e]

vlxe.v v4, 0(a0), v12
# CHECK-INST: vlxe.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x0e]

vlxe.v v4, (a0), v12, v0.t
# CHECK-INST: vlxe.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0x0c]

vsxb.v v4, (a0), v12
# CHECK-INST: vsxb.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x0e]

vsxb.v v4, 0(a0), v12
# CHECK-INST: vsxb.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x0e]

vsxb.v v4, (a0), v12, v0.t
# CHECK-INST: vsxb.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0x0c]

vsxh.v v4, (a0), v12
# CHECK-INST: vsxh.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x0e]

vsxh.v v4, 0(a0), v12
# CHECK-INST: vsxh.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x0e]

vsxh.v v4, (a0), v12, v0.t
# CHECK-INST: vsxh.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0x0c]

vsxw.v v4, (a0), v12
# CHECK-INST: vsxw.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x0e]

vsxw.v v4, 0(a0), v12
# CHECK-INST: vsxw.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x0e]

vsxw.v v4, (a0), v12, v0.t
# CHECK-INST: vsxw.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0x0c]

vsxe.v v4, (a0), v12
# CHECK-INST: vsxe.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x0e]

vsxe.v v4, 0(a0), v12
# CHECK-INST: vsxe.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x0e]

vsxe.v v4, (a0), v12, v0.t
# CHECK-INST: vsxe.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0x0c]

vsuxb.v v4, (a0), v12
# CHECK-INST: vsuxb.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x1e]

vsuxb.v v4, 0(a0), v12
# CHECK-INST: vsuxb.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x1e]

vsuxb.v v4, (a0), v12, v0.t
# CHECK-INST: vsuxb.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0x1c]

vsuxh.v v4, (a0), v12
# CHECK-INST: vsuxh.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x1e]

vsuxh.v v4, 0(a0), v12
# CHECK-INST: vsuxh.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x1e]

vsuxh.v v4, (a0), v12, v0.t
# CHECK-INST: vsuxh.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0x1c]

vsuxw.v v4, (a0), v12
# CHECK-INST: vsuxw.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x1e]

vsuxw.v v4, 0(a0), v12
# CHECK-INST: vsuxw.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x1e]

vsuxw.v v4, (a0), v12, v0.t
# CHECK-INST: vsuxw.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0x1c]

vsuxe.v v4, (a0), v12
# CHECK-INST: vsuxe.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x1e]

vsuxe.v v4, 0(a0), v12
# CHECK-INST: vsuxe.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x1e]

vsuxe.v v4, (a0), v12, v0.t
# CHECK-INST: vsuxe.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0x1c]

vlbff.v v4, (a0)
# CHECK-INST: vlbff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x13]

vlbff.v v4, 0(a0)
# CHECK-INST: vlbff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x13]

vlbff.v v4, (a0), v0.t
# CHECK-INST: vlbff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x11]

vlhff.v v4, (a0)
# CHECK-INST: vlhff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x13]

vlhff.v v4, 0(a0)
# CHECK-INST: vlhff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x13]

vlhff.v v4, (a0), v0.t
# CHECK-INST: vlhff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x11]

vlwff.v v4, (a0)
# CHECK-INST: vlwff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x13]

vlwff.v v4, 0(a0)
# CHECK-INST: vlwff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x13]

vlwff.v v4, (a0), v0.t
# CHECK-INST: vlwff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x11]

vlbuff.v v4, (a0)
# CHECK-INST: vlbuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x03]

vlbuff.v v4, 0(a0)
# CHECK-INST: vlbuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x03]

vlbuff.v v4, (a0), v0.t
# CHECK-INST: vlbuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x01]

vlhuff.v v4, (a0)
# CHECK-INST: vlhuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x03]

vlhuff.v v4, 0(a0)
# CHECK-INST: vlhuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x03]

vlhuff.v v4, (a0), v0.t
# CHECK-INST: vlhuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x01]

vlwuff.v v4, (a0)
# CHECK-INST: vlwuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x03]

vlwuff.v v4, 0(a0)
# CHECK-INST: vlwuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x03]

vlwuff.v v4, (a0), v0.t
# CHECK-INST: vlwuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x01]

vleff.v v4, (a0)
# CHECK-INST: vleff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x03]

vleff.v v4, 0(a0)
# CHECK-INST: vleff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x03]

vleff.v v4, (a0), v0.t
# CHECK-INST: vleff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x01]

vlseg2b.v v4, (a0)
# CHECK-INST: vlseg2b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x32]

vlseg2b.v v4, 0(a0)
# CHECK-INST: vlseg2b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x32]

vlseg2b.v v4, (a0), v0.t
# CHECK-INST: vlseg2b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x30]

vlseg2h.v v4, (a0)
# CHECK-INST: vlseg2h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x32]

vlseg2h.v v4, 0(a0)
# CHECK-INST: vlseg2h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x32]

vlseg2h.v v4, (a0), v0.t
# CHECK-INST: vlseg2h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x30]

vlseg2w.v v4, (a0)
# CHECK-INST: vlseg2w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x32]

vlseg2w.v v4, 0(a0)
# CHECK-INST: vlseg2w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x32]

vlseg2w.v v4, (a0), v0.t
# CHECK-INST: vlseg2w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x30]

vlseg2bu.v v4, (a0)
# CHECK-INST: vlseg2bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x22]

vlseg2bu.v v4, 0(a0)
# CHECK-INST: vlseg2bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x22]

vlseg2bu.v v4, (a0), v0.t
# CHECK-INST: vlseg2bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x20]

vlseg2hu.v v4, (a0)
# CHECK-INST: vlseg2hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x22]

vlseg2hu.v v4, 0(a0)
# CHECK-INST: vlseg2hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x22]

vlseg2hu.v v4, (a0), v0.t
# CHECK-INST: vlseg2hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x20]

vlseg2wu.v v4, (a0)
# CHECK-INST: vlseg2wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x22]

vlseg2wu.v v4, 0(a0)
# CHECK-INST: vlseg2wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x22]

vlseg2wu.v v4, (a0), v0.t
# CHECK-INST: vlseg2wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x20]

vlseg2e.v v4, (a0)
# CHECK-INST: vlseg2e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x22]

vlseg2e.v v4, 0(a0)
# CHECK-INST: vlseg2e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x22]

vlseg2e.v v4, (a0), v0.t
# CHECK-INST: vlseg2e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x20]

vsseg2b.v v4, (a0)
# CHECK-INST: vsseg2b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x22]

vsseg2b.v v4, 0(a0)
# CHECK-INST: vsseg2b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x22]

vsseg2b.v v4, (a0), v0.t
# CHECK-INST: vsseg2b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0x20]

vsseg2h.v v4, (a0)
# CHECK-INST: vsseg2h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x22]

vsseg2h.v v4, 0(a0)
# CHECK-INST: vsseg2h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x22]

vsseg2h.v v4, (a0), v0.t
# CHECK-INST: vsseg2h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0x20]

vsseg2w.v v4, (a0)
# CHECK-INST: vsseg2w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x22]

vsseg2w.v v4, 0(a0)
# CHECK-INST: vsseg2w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x22]

vsseg2w.v v4, (a0), v0.t
# CHECK-INST: vsseg2w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0x20]

vsseg2e.v v4, (a0)
# CHECK-INST: vsseg2e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x22]

vsseg2e.v v4, 0(a0)
# CHECK-INST: vsseg2e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x22]

vsseg2e.v v4, (a0), v0.t
# CHECK-INST: vsseg2e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0x20]

vlseg3b.v v4, (a0)
# CHECK-INST: vlseg3b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x52]

vlseg3b.v v4, 0(a0)
# CHECK-INST: vlseg3b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x52]

vlseg3b.v v4, (a0), v0.t
# CHECK-INST: vlseg3b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x50]

vlseg3h.v v4, (a0)
# CHECK-INST: vlseg3h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x52]

vlseg3h.v v4, 0(a0)
# CHECK-INST: vlseg3h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x52]

vlseg3h.v v4, (a0), v0.t
# CHECK-INST: vlseg3h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x50]

vlseg3w.v v4, (a0)
# CHECK-INST: vlseg3w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x52]

vlseg3w.v v4, 0(a0)
# CHECK-INST: vlseg3w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x52]

vlseg3w.v v4, (a0), v0.t
# CHECK-INST: vlseg3w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x50]

vlseg3bu.v v4, (a0)
# CHECK-INST: vlseg3bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x42]

vlseg3bu.v v4, 0(a0)
# CHECK-INST: vlseg3bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x42]

vlseg3bu.v v4, (a0), v0.t
# CHECK-INST: vlseg3bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x40]

vlseg3hu.v v4, (a0)
# CHECK-INST: vlseg3hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x42]

vlseg3hu.v v4, 0(a0)
# CHECK-INST: vlseg3hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x42]

vlseg3hu.v v4, (a0), v0.t
# CHECK-INST: vlseg3hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x40]

vlseg3wu.v v4, (a0)
# CHECK-INST: vlseg3wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x42]

vlseg3wu.v v4, 0(a0)
# CHECK-INST: vlseg3wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x42]

vlseg3wu.v v4, (a0), v0.t
# CHECK-INST: vlseg3wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x40]

vlseg3e.v v4, (a0)
# CHECK-INST: vlseg3e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x42]

vlseg3e.v v4, 0(a0)
# CHECK-INST: vlseg3e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x42]

vlseg3e.v v4, (a0), v0.t
# CHECK-INST: vlseg3e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x40]

vsseg3b.v v4, (a0)
# CHECK-INST: vsseg3b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x42]

vsseg3b.v v4, 0(a0)
# CHECK-INST: vsseg3b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x42]

vsseg3b.v v4, (a0), v0.t
# CHECK-INST: vsseg3b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0x40]

vsseg3h.v v4, (a0)
# CHECK-INST: vsseg3h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x42]

vsseg3h.v v4, 0(a0)
# CHECK-INST: vsseg3h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x42]

vsseg3h.v v4, (a0), v0.t
# CHECK-INST: vsseg3h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0x40]

vsseg3w.v v4, (a0)
# CHECK-INST: vsseg3w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x42]

vsseg3w.v v4, 0(a0)
# CHECK-INST: vsseg3w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x42]

vsseg3w.v v4, (a0), v0.t
# CHECK-INST: vsseg3w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0x40]

vsseg3e.v v4, (a0)
# CHECK-INST: vsseg3e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x42]

vsseg3e.v v4, 0(a0)
# CHECK-INST: vsseg3e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x42]

vsseg3e.v v4, (a0), v0.t
# CHECK-INST: vsseg3e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0x40]

vlseg4b.v v4, (a0)
# CHECK-INST: vlseg4b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x72]

vlseg4b.v v4, 0(a0)
# CHECK-INST: vlseg4b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x72]

vlseg4b.v v4, (a0), v0.t
# CHECK-INST: vlseg4b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x70]

vlseg4h.v v4, (a0)
# CHECK-INST: vlseg4h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x72]

vlseg4h.v v4, 0(a0)
# CHECK-INST: vlseg4h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x72]

vlseg4h.v v4, (a0), v0.t
# CHECK-INST: vlseg4h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x70]

vlseg4w.v v4, (a0)
# CHECK-INST: vlseg4w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x72]

vlseg4w.v v4, 0(a0)
# CHECK-INST: vlseg4w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x72]

vlseg4w.v v4, (a0), v0.t
# CHECK-INST: vlseg4w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x70]

vlseg4bu.v v4, (a0)
# CHECK-INST: vlseg4bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x62]

vlseg4bu.v v4, 0(a0)
# CHECK-INST: vlseg4bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x62]

vlseg4bu.v v4, (a0), v0.t
# CHECK-INST: vlseg4bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x60]

vlseg4hu.v v4, (a0)
# CHECK-INST: vlseg4hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x62]

vlseg4hu.v v4, 0(a0)
# CHECK-INST: vlseg4hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x62]

vlseg4hu.v v4, (a0), v0.t
# CHECK-INST: vlseg4hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x60]

vlseg4wu.v v4, (a0)
# CHECK-INST: vlseg4wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x62]

vlseg4wu.v v4, 0(a0)
# CHECK-INST: vlseg4wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x62]

vlseg4wu.v v4, (a0), v0.t
# CHECK-INST: vlseg4wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x60]

vlseg4e.v v4, (a0)
# CHECK-INST: vlseg4e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x62]

vlseg4e.v v4, 0(a0)
# CHECK-INST: vlseg4e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x62]

vlseg4e.v v4, (a0), v0.t
# CHECK-INST: vlseg4e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x60]

vsseg4b.v v4, (a0)
# CHECK-INST: vsseg4b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x62]

vsseg4b.v v4, 0(a0)
# CHECK-INST: vsseg4b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x62]

vsseg4b.v v4, (a0), v0.t
# CHECK-INST: vsseg4b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0x60]

vsseg4h.v v4, (a0)
# CHECK-INST: vsseg4h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x62]

vsseg4h.v v4, 0(a0)
# CHECK-INST: vsseg4h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x62]

vsseg4h.v v4, (a0), v0.t
# CHECK-INST: vsseg4h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0x60]

vsseg4w.v v4, (a0)
# CHECK-INST: vsseg4w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x62]

vsseg4w.v v4, 0(a0)
# CHECK-INST: vsseg4w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x62]

vsseg4w.v v4, (a0), v0.t
# CHECK-INST: vsseg4w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0x60]

vsseg4e.v v4, (a0)
# CHECK-INST: vsseg4e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x62]

vsseg4e.v v4, 0(a0)
# CHECK-INST: vsseg4e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x62]

vsseg4e.v v4, (a0), v0.t
# CHECK-INST: vsseg4e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0x60]

vlseg5b.v v4, (a0)
# CHECK-INST: vlseg5b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x92]

vlseg5b.v v4, 0(a0)
# CHECK-INST: vlseg5b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x92]

vlseg5b.v v4, (a0), v0.t
# CHECK-INST: vlseg5b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x90]

vlseg5h.v v4, (a0)
# CHECK-INST: vlseg5h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x92]

vlseg5h.v v4, 0(a0)
# CHECK-INST: vlseg5h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x92]

vlseg5h.v v4, (a0), v0.t
# CHECK-INST: vlseg5h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x90]

vlseg5w.v v4, (a0)
# CHECK-INST: vlseg5w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x92]

vlseg5w.v v4, 0(a0)
# CHECK-INST: vlseg5w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x92]

vlseg5w.v v4, (a0), v0.t
# CHECK-INST: vlseg5w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x90]

vlseg5bu.v v4, (a0)
# CHECK-INST: vlseg5bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x82]

vlseg5bu.v v4, 0(a0)
# CHECK-INST: vlseg5bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x82]

vlseg5bu.v v4, (a0), v0.t
# CHECK-INST: vlseg5bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x80]

vlseg5hu.v v4, (a0)
# CHECK-INST: vlseg5hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x82]

vlseg5hu.v v4, 0(a0)
# CHECK-INST: vlseg5hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x82]

vlseg5hu.v v4, (a0), v0.t
# CHECK-INST: vlseg5hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x80]

vlseg5wu.v v4, (a0)
# CHECK-INST: vlseg5wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x82]

vlseg5wu.v v4, 0(a0)
# CHECK-INST: vlseg5wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x82]

vlseg5wu.v v4, (a0), v0.t
# CHECK-INST: vlseg5wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x80]

vlseg5e.v v4, (a0)
# CHECK-INST: vlseg5e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x82]

vlseg5e.v v4, 0(a0)
# CHECK-INST: vlseg5e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x82]

vlseg5e.v v4, (a0), v0.t
# CHECK-INST: vlseg5e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x80]

vsseg5b.v v4, (a0)
# CHECK-INST: vsseg5b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x82]

vsseg5b.v v4, 0(a0)
# CHECK-INST: vsseg5b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0x82]

vsseg5b.v v4, (a0), v0.t
# CHECK-INST: vsseg5b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0x80]

vsseg5h.v v4, (a0)
# CHECK-INST: vsseg5h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x82]

vsseg5h.v v4, 0(a0)
# CHECK-INST: vsseg5h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0x82]

vsseg5h.v v4, (a0), v0.t
# CHECK-INST: vsseg5h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0x80]

vsseg5w.v v4, (a0)
# CHECK-INST: vsseg5w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x82]

vsseg5w.v v4, 0(a0)
# CHECK-INST: vsseg5w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0x82]

vsseg5w.v v4, (a0), v0.t
# CHECK-INST: vsseg5w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0x80]

vsseg5e.v v4, (a0)
# CHECK-INST: vsseg5e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x82]

vsseg5e.v v4, 0(a0)
# CHECK-INST: vsseg5e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0x82]

vsseg5e.v v4, (a0), v0.t
# CHECK-INST: vsseg5e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0x80]

vlseg6b.v v4, (a0)
# CHECK-INST: vlseg6b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xb2]

vlseg6b.v v4, 0(a0)
# CHECK-INST: vlseg6b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xb2]

vlseg6b.v v4, (a0), v0.t
# CHECK-INST: vlseg6b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xb0]

vlseg6h.v v4, (a0)
# CHECK-INST: vlseg6h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xb2]

vlseg6h.v v4, 0(a0)
# CHECK-INST: vlseg6h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xb2]

vlseg6h.v v4, (a0), v0.t
# CHECK-INST: vlseg6h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xb0]

vlseg6w.v v4, (a0)
# CHECK-INST: vlseg6w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xb2]

vlseg6w.v v4, 0(a0)
# CHECK-INST: vlseg6w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xb2]

vlseg6w.v v4, (a0), v0.t
# CHECK-INST: vlseg6w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xb0]

vlseg6bu.v v4, (a0)
# CHECK-INST: vlseg6bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xa2]

vlseg6bu.v v4, 0(a0)
# CHECK-INST: vlseg6bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xa2]

vlseg6bu.v v4, (a0), v0.t
# CHECK-INST: vlseg6bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xa0]

vlseg6hu.v v4, (a0)
# CHECK-INST: vlseg6hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xa2]

vlseg6hu.v v4, 0(a0)
# CHECK-INST: vlseg6hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xa2]

vlseg6hu.v v4, (a0), v0.t
# CHECK-INST: vlseg6hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xa0]

vlseg6wu.v v4, (a0)
# CHECK-INST: vlseg6wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xa2]

vlseg6wu.v v4, 0(a0)
# CHECK-INST: vlseg6wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xa2]

vlseg6wu.v v4, (a0), v0.t
# CHECK-INST: vlseg6wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xa0]

vlseg6e.v v4, (a0)
# CHECK-INST: vlseg6e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xa2]

vlseg6e.v v4, 0(a0)
# CHECK-INST: vlseg6e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xa2]

vlseg6e.v v4, (a0), v0.t
# CHECK-INST: vlseg6e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0xa0]

vsseg6b.v v4, (a0)
# CHECK-INST: vsseg6b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0xa2]

vsseg6b.v v4, 0(a0)
# CHECK-INST: vsseg6b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0xa2]

vsseg6b.v v4, (a0), v0.t
# CHECK-INST: vsseg6b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0xa0]

vsseg6h.v v4, (a0)
# CHECK-INST: vsseg6h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0xa2]

vsseg6h.v v4, 0(a0)
# CHECK-INST: vsseg6h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0xa2]

vsseg6h.v v4, (a0), v0.t
# CHECK-INST: vsseg6h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0xa0]

vsseg6w.v v4, (a0)
# CHECK-INST: vsseg6w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0xa2]

vsseg6w.v v4, 0(a0)
# CHECK-INST: vsseg6w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0xa2]

vsseg6w.v v4, (a0), v0.t
# CHECK-INST: vsseg6w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0xa0]

vsseg6e.v v4, (a0)
# CHECK-INST: vsseg6e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0xa2]

vsseg6e.v v4, 0(a0)
# CHECK-INST: vsseg6e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0xa2]

vsseg6e.v v4, (a0), v0.t
# CHECK-INST: vsseg6e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0xa0]

vlseg7b.v v4, (a0)
# CHECK-INST: vlseg7b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xd2]

vlseg7b.v v4, 0(a0)
# CHECK-INST: vlseg7b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xd2]

vlseg7b.v v4, (a0), v0.t
# CHECK-INST: vlseg7b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xd0]

vlseg7h.v v4, (a0)
# CHECK-INST: vlseg7h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xd2]

vlseg7h.v v4, 0(a0)
# CHECK-INST: vlseg7h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xd2]

vlseg7h.v v4, (a0), v0.t
# CHECK-INST: vlseg7h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xd0]

vlseg7w.v v4, (a0)
# CHECK-INST: vlseg7w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xd2]

vlseg7w.v v4, 0(a0)
# CHECK-INST: vlseg7w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xd2]

vlseg7w.v v4, (a0), v0.t
# CHECK-INST: vlseg7w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xd0]

vlseg7bu.v v4, (a0)
# CHECK-INST: vlseg7bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xc2]

vlseg7bu.v v4, 0(a0)
# CHECK-INST: vlseg7bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xc2]

vlseg7bu.v v4, (a0), v0.t
# CHECK-INST: vlseg7bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xc0]

vlseg7hu.v v4, (a0)
# CHECK-INST: vlseg7hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xc2]

vlseg7hu.v v4, 0(a0)
# CHECK-INST: vlseg7hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xc2]

vlseg7hu.v v4, (a0), v0.t
# CHECK-INST: vlseg7hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xc0]

vlseg7wu.v v4, (a0)
# CHECK-INST: vlseg7wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xc2]

vlseg7wu.v v4, 0(a0)
# CHECK-INST: vlseg7wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xc2]

vlseg7wu.v v4, (a0), v0.t
# CHECK-INST: vlseg7wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xc0]

vlseg7e.v v4, (a0)
# CHECK-INST: vlseg7e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xc2]

vlseg7e.v v4, 0(a0)
# CHECK-INST: vlseg7e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xc2]

vlseg7e.v v4, (a0), v0.t
# CHECK-INST: vlseg7e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0xc0]

vsseg7b.v v4, (a0)
# CHECK-INST: vsseg7b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0xc2]

vsseg7b.v v4, 0(a0)
# CHECK-INST: vsseg7b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0xc2]

vsseg7b.v v4, (a0), v0.t
# CHECK-INST: vsseg7b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0xc0]

vsseg7h.v v4, (a0)
# CHECK-INST: vsseg7h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0xc2]

vsseg7h.v v4, 0(a0)
# CHECK-INST: vsseg7h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0xc2]

vsseg7h.v v4, (a0), v0.t
# CHECK-INST: vsseg7h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0xc0]

vsseg7w.v v4, (a0)
# CHECK-INST: vsseg7w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0xc2]

vsseg7w.v v4, 0(a0)
# CHECK-INST: vsseg7w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0xc2]

vsseg7w.v v4, (a0), v0.t
# CHECK-INST: vsseg7w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0xc0]

vsseg7e.v v4, (a0)
# CHECK-INST: vsseg7e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0xc2]

vsseg7e.v v4, 0(a0)
# CHECK-INST: vsseg7e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0xc2]

vsseg7e.v v4, (a0), v0.t
# CHECK-INST: vsseg7e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0xc0]

vlseg8b.v v4, (a0)
# CHECK-INST: vlseg8b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xf2]

vlseg8b.v v4, 0(a0)
# CHECK-INST: vlseg8b.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xf2]

vlseg8b.v v4, (a0), v0.t
# CHECK-INST: vlseg8b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xf0]

vlseg8h.v v4, (a0)
# CHECK-INST: vlseg8h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xf2]

vlseg8h.v v4, 0(a0)
# CHECK-INST: vlseg8h.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xf2]

vlseg8h.v v4, (a0), v0.t
# CHECK-INST: vlseg8h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xf0]

vlseg8w.v v4, (a0)
# CHECK-INST: vlseg8w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xf2]

vlseg8w.v v4, 0(a0)
# CHECK-INST: vlseg8w.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xf2]

vlseg8w.v v4, (a0), v0.t
# CHECK-INST: vlseg8w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xf0]

vlseg8bu.v v4, (a0)
# CHECK-INST: vlseg8bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xe2]

vlseg8bu.v v4, 0(a0)
# CHECK-INST: vlseg8bu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xe2]

vlseg8bu.v v4, (a0), v0.t
# CHECK-INST: vlseg8bu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xe0]

vlseg8hu.v v4, (a0)
# CHECK-INST: vlseg8hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xe2]

vlseg8hu.v v4, 0(a0)
# CHECK-INST: vlseg8hu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xe2]

vlseg8hu.v v4, (a0), v0.t
# CHECK-INST: vlseg8hu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xe0]

vlseg8wu.v v4, (a0)
# CHECK-INST: vlseg8wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xe2]

vlseg8wu.v v4, 0(a0)
# CHECK-INST: vlseg8wu.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xe2]

vlseg8wu.v v4, (a0), v0.t
# CHECK-INST: vlseg8wu.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xe0]

vlseg8e.v v4, (a0)
# CHECK-INST: vlseg8e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xe2]

vlseg8e.v v4, 0(a0)
# CHECK-INST: vlseg8e.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xe2]

vlseg8e.v v4, (a0), v0.t
# CHECK-INST: vlseg8e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0xe0]

vsseg8b.v v4, (a0)
# CHECK-INST: vsseg8b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0xe2]

vsseg8b.v v4, 0(a0)
# CHECK-INST: vsseg8b.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x02,0x05,0xe2]

vsseg8b.v v4, (a0), v0.t
# CHECK-INST: vsseg8b.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x02,0x05,0xe0]

vsseg8h.v v4, (a0)
# CHECK-INST: vsseg8h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0xe2]

vsseg8h.v v4, 0(a0)
# CHECK-INST: vsseg8h.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x52,0x05,0xe2]

vsseg8h.v v4, (a0), v0.t
# CHECK-INST: vsseg8h.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x52,0x05,0xe0]

vsseg8w.v v4, (a0)
# CHECK-INST: vsseg8w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0xe2]

vsseg8w.v v4, 0(a0)
# CHECK-INST: vsseg8w.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x62,0x05,0xe2]

vsseg8w.v v4, (a0), v0.t
# CHECK-INST: vsseg8w.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x62,0x05,0xe0]

vsseg8e.v v4, (a0)
# CHECK-INST: vsseg8e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0xe2]

vsseg8e.v v4, 0(a0)
# CHECK-INST: vsseg8e.v	v4, (a0)
# CHECK-ENCODING: [0x27,0x72,0x05,0xe2]

vsseg8e.v v4, (a0), v0.t
# CHECK-INST: vsseg8e.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x27,0x72,0x05,0xe0]

vlsseg2b.v v4, (a0), a1
# CHECK-INST: vlsseg2b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x3a]

vlsseg2b.v v4, 0(a0), a1
# CHECK-INST: vlsseg2b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x3a]

vlsseg2b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x38]

vlsseg2h.v v4, (a0), a1
# CHECK-INST: vlsseg2h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x3a]

vlsseg2h.v v4, 0(a0), a1
# CHECK-INST: vlsseg2h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x3a]

vlsseg2h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x38]

vlsseg2w.v v4, (a0), a1
# CHECK-INST: vlsseg2w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x3a]

vlsseg2w.v v4, 0(a0), a1
# CHECK-INST: vlsseg2w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x3a]

vlsseg2w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x38]

vlsseg2bu.v v4, (a0), a1
# CHECK-INST: vlsseg2bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x2a]

vlsseg2bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg2bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x2a]

vlsseg2bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x28]

vlsseg2hu.v v4, (a0), a1
# CHECK-INST: vlsseg2hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x2a]

vlsseg2hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg2hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x2a]

vlsseg2hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x28]

vlsseg2wu.v v4, (a0), a1
# CHECK-INST: vlsseg2wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x2a]

vlsseg2wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg2wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x2a]

vlsseg2wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x28]

vlsseg2e.v v4, (a0), a1
# CHECK-INST: vlsseg2e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x2a]

vlsseg2e.v v4, 0(a0), a1
# CHECK-INST: vlsseg2e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x2a]

vlsseg2e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg2e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0x28]

vssseg2b.v v4, (a0), a1
# CHECK-INST: vssseg2b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x2a]

vssseg2b.v v4, 0(a0), a1
# CHECK-INST: vssseg2b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x2a]

vssseg2b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg2b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0x28]

vssseg2h.v v4, (a0), a1
# CHECK-INST: vssseg2h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x2a]

vssseg2h.v v4, 0(a0), a1
# CHECK-INST: vssseg2h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x2a]

vssseg2h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg2h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0x28]

vssseg2w.v v4, (a0), a1
# CHECK-INST: vssseg2w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x2a]

vssseg2w.v v4, 0(a0), a1
# CHECK-INST: vssseg2w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x2a]

vssseg2w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg2w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0x28]

vssseg2e.v v4, (a0), a1
# CHECK-INST: vssseg2e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x2a]

vssseg2e.v v4, 0(a0), a1
# CHECK-INST: vssseg2e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x2a]

vssseg2e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg2e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0x28]

vlsseg3b.v v4, (a0), a1
# CHECK-INST: vlsseg3b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x5a]

vlsseg3b.v v4, 0(a0), a1
# CHECK-INST: vlsseg3b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x5a]

vlsseg3b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x58]

vlsseg3h.v v4, (a0), a1
# CHECK-INST: vlsseg3h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x5a]

vlsseg3h.v v4, 0(a0), a1
# CHECK-INST: vlsseg3h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x5a]

vlsseg3h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x58]

vlsseg3w.v v4, (a0), a1
# CHECK-INST: vlsseg3w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x5a]

vlsseg3w.v v4, 0(a0), a1
# CHECK-INST: vlsseg3w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x5a]

vlsseg3w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x58]

vlsseg3bu.v v4, (a0), a1
# CHECK-INST: vlsseg3bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x4a]

vlsseg3bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg3bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x4a]

vlsseg3bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x48]

vlsseg3hu.v v4, (a0), a1
# CHECK-INST: vlsseg3hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x4a]

vlsseg3hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg3hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x4a]

vlsseg3hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x48]

vlsseg3wu.v v4, (a0), a1
# CHECK-INST: vlsseg3wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x4a]

vlsseg3wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg3wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x4a]

vlsseg3wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x48]

vlsseg3e.v v4, (a0), a1
# CHECK-INST: vlsseg3e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x4a]

vlsseg3e.v v4, 0(a0), a1
# CHECK-INST: vlsseg3e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x4a]

vlsseg3e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg3e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0x48]

vssseg3b.v v4, (a0), a1
# CHECK-INST: vssseg3b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x4a]

vssseg3b.v v4, 0(a0), a1
# CHECK-INST: vssseg3b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x4a]

vssseg3b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg3b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0x48]

vssseg3h.v v4, (a0), a1
# CHECK-INST: vssseg3h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x4a]

vssseg3h.v v4, 0(a0), a1
# CHECK-INST: vssseg3h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x4a]

vssseg3h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg3h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0x48]

vssseg3w.v v4, (a0), a1
# CHECK-INST: vssseg3w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x4a]

vssseg3w.v v4, 0(a0), a1
# CHECK-INST: vssseg3w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x4a]

vssseg3w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg3w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0x48]

vssseg3e.v v4, (a0), a1
# CHECK-INST: vssseg3e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x4a]

vssseg3e.v v4, 0(a0), a1
# CHECK-INST: vssseg3e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x4a]

vssseg3e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg3e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0x48]

vlsseg4b.v v4, (a0), a1
# CHECK-INST: vlsseg4b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x7a]

vlsseg4b.v v4, 0(a0), a1
# CHECK-INST: vlsseg4b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x7a]

vlsseg4b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x78]

vlsseg4h.v v4, (a0), a1
# CHECK-INST: vlsseg4h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x7a]

vlsseg4h.v v4, 0(a0), a1
# CHECK-INST: vlsseg4h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x7a]

vlsseg4h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x78]

vlsseg4w.v v4, (a0), a1
# CHECK-INST: vlsseg4w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x7a]

vlsseg4w.v v4, 0(a0), a1
# CHECK-INST: vlsseg4w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x7a]

vlsseg4w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x78]

vlsseg4bu.v v4, (a0), a1
# CHECK-INST: vlsseg4bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x6a]

vlsseg4bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg4bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x6a]

vlsseg4bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x68]

vlsseg4hu.v v4, (a0), a1
# CHECK-INST: vlsseg4hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x6a]

vlsseg4hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg4hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x6a]

vlsseg4hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x68]

vlsseg4wu.v v4, (a0), a1
# CHECK-INST: vlsseg4wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x6a]

vlsseg4wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg4wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x6a]

vlsseg4wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x68]

vlsseg4e.v v4, (a0), a1
# CHECK-INST: vlsseg4e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x6a]

vlsseg4e.v v4, 0(a0), a1
# CHECK-INST: vlsseg4e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x6a]

vlsseg4e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg4e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0x68]

vssseg4b.v v4, (a0), a1
# CHECK-INST: vssseg4b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x6a]

vssseg4b.v v4, 0(a0), a1
# CHECK-INST: vssseg4b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x6a]

vssseg4b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg4b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0x68]

vssseg4h.v v4, (a0), a1
# CHECK-INST: vssseg4h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x6a]

vssseg4h.v v4, 0(a0), a1
# CHECK-INST: vssseg4h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x6a]

vssseg4h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg4h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0x68]

vssseg4w.v v4, (a0), a1
# CHECK-INST: vssseg4w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x6a]

vssseg4w.v v4, 0(a0), a1
# CHECK-INST: vssseg4w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x6a]

vssseg4w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg4w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0x68]

vssseg4e.v v4, (a0), a1
# CHECK-INST: vssseg4e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x6a]

vssseg4e.v v4, 0(a0), a1
# CHECK-INST: vssseg4e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x6a]

vssseg4e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg4e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0x68]

vlsseg5b.v v4, (a0), a1
# CHECK-INST: vlsseg5b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x9a]

vlsseg5b.v v4, 0(a0), a1
# CHECK-INST: vlsseg5b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x9a]

vlsseg5b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x98]

vlsseg5h.v v4, (a0), a1
# CHECK-INST: vlsseg5h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x9a]

vlsseg5h.v v4, 0(a0), a1
# CHECK-INST: vlsseg5h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x9a]

vlsseg5h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x98]

vlsseg5w.v v4, (a0), a1
# CHECK-INST: vlsseg5w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x9a]

vlsseg5w.v v4, 0(a0), a1
# CHECK-INST: vlsseg5w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x9a]

vlsseg5w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x98]

vlsseg5bu.v v4, (a0), a1
# CHECK-INST: vlsseg5bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x8a]

vlsseg5bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg5bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0x8a]

vlsseg5bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0x88]

vlsseg5hu.v v4, (a0), a1
# CHECK-INST: vlsseg5hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x8a]

vlsseg5hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg5hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0x8a]

vlsseg5hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0x88]

vlsseg5wu.v v4, (a0), a1
# CHECK-INST: vlsseg5wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x8a]

vlsseg5wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg5wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0x8a]

vlsseg5wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0x88]

vlsseg5e.v v4, (a0), a1
# CHECK-INST: vlsseg5e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x8a]

vlsseg5e.v v4, 0(a0), a1
# CHECK-INST: vlsseg5e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0x8a]

vlsseg5e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg5e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0x88]

vssseg5b.v v4, (a0), a1
# CHECK-INST: vssseg5b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x8a]

vssseg5b.v v4, 0(a0), a1
# CHECK-INST: vssseg5b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0x8a]

vssseg5b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg5b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0x88]

vssseg5h.v v4, (a0), a1
# CHECK-INST: vssseg5h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x8a]

vssseg5h.v v4, 0(a0), a1
# CHECK-INST: vssseg5h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0x8a]

vssseg5h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg5h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0x88]

vssseg5w.v v4, (a0), a1
# CHECK-INST: vssseg5w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x8a]

vssseg5w.v v4, 0(a0), a1
# CHECK-INST: vssseg5w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0x8a]

vssseg5w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg5w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0x88]

vssseg5e.v v4, (a0), a1
# CHECK-INST: vssseg5e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x8a]

vssseg5e.v v4, 0(a0), a1
# CHECK-INST: vssseg5e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0x8a]

vssseg5e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg5e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0x88]

vlsseg6b.v v4, (a0), a1
# CHECK-INST: vlsseg6b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xba]

vlsseg6b.v v4, 0(a0), a1
# CHECK-INST: vlsseg6b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xba]

vlsseg6b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0xb8]

vlsseg6h.v v4, (a0), a1
# CHECK-INST: vlsseg6h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xba]

vlsseg6h.v v4, 0(a0), a1
# CHECK-INST: vlsseg6h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xba]

vlsseg6h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0xb8]

vlsseg6w.v v4, (a0), a1
# CHECK-INST: vlsseg6w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xba]

vlsseg6w.v v4, 0(a0), a1
# CHECK-INST: vlsseg6w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xba]

vlsseg6w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0xb8]

vlsseg6bu.v v4, (a0), a1
# CHECK-INST: vlsseg6bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xaa]

vlsseg6bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg6bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xaa]

vlsseg6bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0xa8]

vlsseg6hu.v v4, (a0), a1
# CHECK-INST: vlsseg6hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xaa]

vlsseg6hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg6hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xaa]

vlsseg6hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0xa8]

vlsseg6wu.v v4, (a0), a1
# CHECK-INST: vlsseg6wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xaa]

vlsseg6wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg6wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xaa]

vlsseg6wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0xa8]

vlsseg6e.v v4, (a0), a1
# CHECK-INST: vlsseg6e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0xaa]

vlsseg6e.v v4, 0(a0), a1
# CHECK-INST: vlsseg6e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0xaa]

vlsseg6e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg6e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0xa8]

vssseg6b.v v4, (a0), a1
# CHECK-INST: vssseg6b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0xaa]

vssseg6b.v v4, 0(a0), a1
# CHECK-INST: vssseg6b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0xaa]

vssseg6b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg6b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0xa8]

vssseg6h.v v4, (a0), a1
# CHECK-INST: vssseg6h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0xaa]

vssseg6h.v v4, 0(a0), a1
# CHECK-INST: vssseg6h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0xaa]

vssseg6h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg6h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0xa8]

vssseg6w.v v4, (a0), a1
# CHECK-INST: vssseg6w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0xaa]

vssseg6w.v v4, 0(a0), a1
# CHECK-INST: vssseg6w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0xaa]

vssseg6w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg6w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0xa8]

vssseg6e.v v4, (a0), a1
# CHECK-INST: vssseg6e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0xaa]

vssseg6e.v v4, 0(a0), a1
# CHECK-INST: vssseg6e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0xaa]

vssseg6e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg6e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0xa8]

vlsseg7b.v v4, (a0), a1
# CHECK-INST: vlsseg7b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xda]

vlsseg7b.v v4, 0(a0), a1
# CHECK-INST: vlsseg7b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xda]

vlsseg7b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0xd8]

vlsseg7h.v v4, (a0), a1
# CHECK-INST: vlsseg7h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xda]

vlsseg7h.v v4, 0(a0), a1
# CHECK-INST: vlsseg7h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xda]

vlsseg7h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0xd8]

vlsseg7w.v v4, (a0), a1
# CHECK-INST: vlsseg7w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xda]

vlsseg7w.v v4, 0(a0), a1
# CHECK-INST: vlsseg7w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xda]

vlsseg7w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0xd8]

vlsseg7bu.v v4, (a0), a1
# CHECK-INST: vlsseg7bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xca]

vlsseg7bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg7bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xca]

vlsseg7bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0xc8]

vlsseg7hu.v v4, (a0), a1
# CHECK-INST: vlsseg7hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xca]

vlsseg7hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg7hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xca]

vlsseg7hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0xc8]

vlsseg7wu.v v4, (a0), a1
# CHECK-INST: vlsseg7wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xca]

vlsseg7wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg7wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xca]

vlsseg7wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0xc8]

vlsseg7e.v v4, (a0), a1
# CHECK-INST: vlsseg7e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0xca]

vlsseg7e.v v4, 0(a0), a1
# CHECK-INST: vlsseg7e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0xca]

vlsseg7e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg7e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0xc8]

vssseg7b.v v4, (a0), a1
# CHECK-INST: vssseg7b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0xca]

vssseg7b.v v4, 0(a0), a1
# CHECK-INST: vssseg7b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0xca]

vssseg7b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg7b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0xc8]

vssseg7h.v v4, (a0), a1
# CHECK-INST: vssseg7h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0xca]

vssseg7h.v v4, 0(a0), a1
# CHECK-INST: vssseg7h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0xca]

vssseg7h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg7h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0xc8]

vssseg7w.v v4, (a0), a1
# CHECK-INST: vssseg7w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0xca]

vssseg7w.v v4, 0(a0), a1
# CHECK-INST: vssseg7w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0xca]

vssseg7w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg7w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0xc8]

vssseg7e.v v4, (a0), a1
# CHECK-INST: vssseg7e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0xca]

vssseg7e.v v4, 0(a0), a1
# CHECK-INST: vssseg7e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0xca]

vssseg7e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg7e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0xc8]

vlsseg8b.v v4, (a0), a1
# CHECK-INST: vlsseg8b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xfa]

vlsseg8b.v v4, 0(a0), a1
# CHECK-INST: vlsseg8b.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xfa]

vlsseg8b.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0xf8]

vlsseg8h.v v4, (a0), a1
# CHECK-INST: vlsseg8h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xfa]

vlsseg8h.v v4, 0(a0), a1
# CHECK-INST: vlsseg8h.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xfa]

vlsseg8h.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0xf8]

vlsseg8w.v v4, (a0), a1
# CHECK-INST: vlsseg8w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xfa]

vlsseg8w.v v4, 0(a0), a1
# CHECK-INST: vlsseg8w.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xfa]

vlsseg8w.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0xf8]

vlsseg8bu.v v4, (a0), a1
# CHECK-INST: vlsseg8bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xea]

vlsseg8bu.v v4, 0(a0), a1
# CHECK-INST: vlsseg8bu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x02,0xb5,0xea]

vlsseg8bu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8bu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x02,0xb5,0xe8]

vlsseg8hu.v v4, (a0), a1
# CHECK-INST: vlsseg8hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xea]

vlsseg8hu.v v4, 0(a0), a1
# CHECK-INST: vlsseg8hu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x52,0xb5,0xea]

vlsseg8hu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8hu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x52,0xb5,0xe8]

vlsseg8wu.v v4, (a0), a1
# CHECK-INST: vlsseg8wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xea]

vlsseg8wu.v v4, 0(a0), a1
# CHECK-INST: vlsseg8wu.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x62,0xb5,0xea]

vlsseg8wu.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8wu.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x62,0xb5,0xe8]

vlsseg8e.v v4, (a0), a1
# CHECK-INST: vlsseg8e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0xea]

vlsseg8e.v v4, 0(a0), a1
# CHECK-INST: vlsseg8e.v	v4, (a0), a1
# CHECK-ENCODING: [0x07,0x72,0xb5,0xea]

vlsseg8e.v v4, (a0), a1, v0.t
# CHECK-INST: vlsseg8e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x07,0x72,0xb5,0xe8]

vssseg8b.v v4, (a0), a1
# CHECK-INST: vssseg8b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0xea]

vssseg8b.v v4, 0(a0), a1
# CHECK-INST: vssseg8b.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x02,0xb5,0xea]

vssseg8b.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg8b.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x02,0xb5,0xe8]

vssseg8h.v v4, (a0), a1
# CHECK-INST: vssseg8h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0xea]

vssseg8h.v v4, 0(a0), a1
# CHECK-INST: vssseg8h.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x52,0xb5,0xea]

vssseg8h.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg8h.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x52,0xb5,0xe8]

vssseg8w.v v4, (a0), a1
# CHECK-INST: vssseg8w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0xea]

vssseg8w.v v4, 0(a0), a1
# CHECK-INST: vssseg8w.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x62,0xb5,0xea]

vssseg8w.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg8w.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x62,0xb5,0xe8]

vssseg8e.v v4, (a0), a1
# CHECK-INST: vssseg8e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0xea]

vssseg8e.v v4, 0(a0), a1
# CHECK-INST: vssseg8e.v	v4, (a0), a1
# CHECK-ENCODING: [0x27,0x72,0xb5,0xea]

vssseg8e.v v4, (a0), a1, v0.t
# CHECK-INST: vssseg8e.v	v4, (a0), a1, v0.t
# CHECK-ENCODING: [0x27,0x72,0xb5,0xe8]

vlxseg2b.v v4, (a0), v12
# CHECK-INST: vlxseg2b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x3e]

vlxseg2b.v v4, 0(a0), v12
# CHECK-INST: vlxseg2b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x3e]

vlxseg2b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x3c]

vlxseg2h.v v4, (a0), v12
# CHECK-INST: vlxseg2h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x3e]

vlxseg2h.v v4, 0(a0), v12
# CHECK-INST: vlxseg2h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x3e]

vlxseg2h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x3c]

vlxseg2w.v v4, (a0), v12
# CHECK-INST: vlxseg2w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x3e]

vlxseg2w.v v4, 0(a0), v12
# CHECK-INST: vlxseg2w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x3e]

vlxseg2w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x3c]

vlxseg2bu.v v4, (a0), v12
# CHECK-INST: vlxseg2bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x2e]

vlxseg2bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg2bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x2e]

vlxseg2bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x2c]

vlxseg2hu.v v4, (a0), v12
# CHECK-INST: vlxseg2hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x2e]

vlxseg2hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg2hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x2e]

vlxseg2hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x2c]

vlxseg2wu.v v4, (a0), v12
# CHECK-INST: vlxseg2wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x2e]

vlxseg2wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg2wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x2e]

vlxseg2wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x2c]

vlxseg2e.v v4, (a0), v12
# CHECK-INST: vlxseg2e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x2e]

vlxseg2e.v v4, 0(a0), v12
# CHECK-INST: vlxseg2e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x2e]

vlxseg2e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg2e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0x2c]

vsxseg2b.v v4, (a0), v12
# CHECK-INST: vsxseg2b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x2e]

vsxseg2b.v v4, 0(a0), v12
# CHECK-INST: vsxseg2b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x2e]

vsxseg2b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg2b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0x2c]

vsxseg2h.v v4, (a0), v12
# CHECK-INST: vsxseg2h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x2e]

vsxseg2h.v v4, 0(a0), v12
# CHECK-INST: vsxseg2h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x2e]

vsxseg2h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg2h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0x2c]

vsxseg2w.v v4, (a0), v12
# CHECK-INST: vsxseg2w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x2e]

vsxseg2w.v v4, 0(a0), v12
# CHECK-INST: vsxseg2w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x2e]

vsxseg2w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg2w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0x2c]

vsxseg2e.v v4, (a0), v12
# CHECK-INST: vsxseg2e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x2e]

vsxseg2e.v v4, 0(a0), v12
# CHECK-INST: vsxseg2e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x2e]

vsxseg2e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg2e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0x2c]

vlxseg3b.v v4, (a0), v12
# CHECK-INST: vlxseg3b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x5e]

vlxseg3b.v v4, 0(a0), v12
# CHECK-INST: vlxseg3b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x5e]

vlxseg3b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x5c]

vlxseg3h.v v4, (a0), v12
# CHECK-INST: vlxseg3h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x5e]

vlxseg3h.v v4, 0(a0), v12
# CHECK-INST: vlxseg3h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x5e]

vlxseg3h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x5c]

vlxseg3w.v v4, (a0), v12
# CHECK-INST: vlxseg3w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x5e]

vlxseg3w.v v4, 0(a0), v12
# CHECK-INST: vlxseg3w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x5e]

vlxseg3w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x5c]

vlxseg3bu.v v4, (a0), v12
# CHECK-INST: vlxseg3bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x4e]

vlxseg3bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg3bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x4e]

vlxseg3bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x4c]

vlxseg3hu.v v4, (a0), v12
# CHECK-INST: vlxseg3hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x4e]

vlxseg3hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg3hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x4e]

vlxseg3hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x4c]

vlxseg3wu.v v4, (a0), v12
# CHECK-INST: vlxseg3wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x4e]

vlxseg3wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg3wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x4e]

vlxseg3wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x4c]

vlxseg3e.v v4, (a0), v12
# CHECK-INST: vlxseg3e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x4e]

vlxseg3e.v v4, 0(a0), v12
# CHECK-INST: vlxseg3e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x4e]

vlxseg3e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg3e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0x4c]

vsxseg3b.v v4, (a0), v12
# CHECK-INST: vsxseg3b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x4e]

vsxseg3b.v v4, 0(a0), v12
# CHECK-INST: vsxseg3b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x4e]

vsxseg3b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg3b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0x4c]

vsxseg3h.v v4, (a0), v12
# CHECK-INST: vsxseg3h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x4e]

vsxseg3h.v v4, 0(a0), v12
# CHECK-INST: vsxseg3h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x4e]

vsxseg3h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg3h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0x4c]

vsxseg3w.v v4, (a0), v12
# CHECK-INST: vsxseg3w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x4e]

vsxseg3w.v v4, 0(a0), v12
# CHECK-INST: vsxseg3w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x4e]

vsxseg3w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg3w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0x4c]

vsxseg3e.v v4, (a0), v12
# CHECK-INST: vsxseg3e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x4e]

vsxseg3e.v v4, 0(a0), v12
# CHECK-INST: vsxseg3e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x4e]

vsxseg3e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg3e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0x4c]

vlxseg4b.v v4, (a0), v12
# CHECK-INST: vlxseg4b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x7e]

vlxseg4b.v v4, 0(a0), v12
# CHECK-INST: vlxseg4b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x7e]

vlxseg4b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x7c]

vlxseg4h.v v4, (a0), v12
# CHECK-INST: vlxseg4h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x7e]

vlxseg4h.v v4, 0(a0), v12
# CHECK-INST: vlxseg4h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x7e]

vlxseg4h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x7c]

vlxseg4w.v v4, (a0), v12
# CHECK-INST: vlxseg4w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x7e]

vlxseg4w.v v4, 0(a0), v12
# CHECK-INST: vlxseg4w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x7e]

vlxseg4w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x7c]

vlxseg4bu.v v4, (a0), v12
# CHECK-INST: vlxseg4bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x6e]

vlxseg4bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg4bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x6e]

vlxseg4bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x6c]

vlxseg4hu.v v4, (a0), v12
# CHECK-INST: vlxseg4hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x6e]

vlxseg4hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg4hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x6e]

vlxseg4hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x6c]

vlxseg4wu.v v4, (a0), v12
# CHECK-INST: vlxseg4wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x6e]

vlxseg4wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg4wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x6e]

vlxseg4wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x6c]

vlxseg4e.v v4, (a0), v12
# CHECK-INST: vlxseg4e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x6e]

vlxseg4e.v v4, 0(a0), v12
# CHECK-INST: vlxseg4e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x6e]

vlxseg4e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg4e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0x6c]

vsxseg4b.v v4, (a0), v12
# CHECK-INST: vsxseg4b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x6e]

vsxseg4b.v v4, 0(a0), v12
# CHECK-INST: vsxseg4b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x6e]

vsxseg4b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg4b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0x6c]

vsxseg4h.v v4, (a0), v12
# CHECK-INST: vsxseg4h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x6e]

vsxseg4h.v v4, 0(a0), v12
# CHECK-INST: vsxseg4h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x6e]

vsxseg4h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg4h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0x6c]

vsxseg4w.v v4, (a0), v12
# CHECK-INST: vsxseg4w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x6e]

vsxseg4w.v v4, 0(a0), v12
# CHECK-INST: vsxseg4w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x6e]

vsxseg4w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg4w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0x6c]

vsxseg4e.v v4, (a0), v12
# CHECK-INST: vsxseg4e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x6e]

vsxseg4e.v v4, 0(a0), v12
# CHECK-INST: vsxseg4e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x6e]

vsxseg4e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg4e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0x6c]

vlxseg5b.v v4, (a0), v12
# CHECK-INST: vlxseg5b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x9e]

vlxseg5b.v v4, 0(a0), v12
# CHECK-INST: vlxseg5b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x9e]

vlxseg5b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x9c]

vlxseg5h.v v4, (a0), v12
# CHECK-INST: vlxseg5h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x9e]

vlxseg5h.v v4, 0(a0), v12
# CHECK-INST: vlxseg5h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x9e]

vlxseg5h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x9c]

vlxseg5w.v v4, (a0), v12
# CHECK-INST: vlxseg5w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x9e]

vlxseg5w.v v4, 0(a0), v12
# CHECK-INST: vlxseg5w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x9e]

vlxseg5w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x9c]

vlxseg5bu.v v4, (a0), v12
# CHECK-INST: vlxseg5bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x8e]

vlxseg5bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg5bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0x8e]

vlxseg5bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0x8c]

vlxseg5hu.v v4, (a0), v12
# CHECK-INST: vlxseg5hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x8e]

vlxseg5hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg5hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0x8e]

vlxseg5hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0x8c]

vlxseg5wu.v v4, (a0), v12
# CHECK-INST: vlxseg5wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x8e]

vlxseg5wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg5wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0x8e]

vlxseg5wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0x8c]

vlxseg5e.v v4, (a0), v12
# CHECK-INST: vlxseg5e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x8e]

vlxseg5e.v v4, 0(a0), v12
# CHECK-INST: vlxseg5e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0x8e]

vlxseg5e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg5e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0x8c]

vsxseg5b.v v4, (a0), v12
# CHECK-INST: vsxseg5b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x8e]

vsxseg5b.v v4, 0(a0), v12
# CHECK-INST: vsxseg5b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0x8e]

vsxseg5b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg5b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0x8c]

vsxseg5h.v v4, (a0), v12
# CHECK-INST: vsxseg5h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x8e]

vsxseg5h.v v4, 0(a0), v12
# CHECK-INST: vsxseg5h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0x8e]

vsxseg5h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg5h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0x8c]

vsxseg5w.v v4, (a0), v12
# CHECK-INST: vsxseg5w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x8e]

vsxseg5w.v v4, 0(a0), v12
# CHECK-INST: vsxseg5w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0x8e]

vsxseg5w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg5w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0x8c]

vsxseg5e.v v4, (a0), v12
# CHECK-INST: vsxseg5e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x8e]

vsxseg5e.v v4, 0(a0), v12
# CHECK-INST: vsxseg5e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0x8e]

vsxseg5e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg5e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0x8c]

vlxseg6b.v v4, (a0), v12
# CHECK-INST: vlxseg6b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xbe]

vlxseg6b.v v4, 0(a0), v12
# CHECK-INST: vlxseg6b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xbe]

vlxseg6b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0xbc]

vlxseg6h.v v4, (a0), v12
# CHECK-INST: vlxseg6h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xbe]

vlxseg6h.v v4, 0(a0), v12
# CHECK-INST: vlxseg6h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xbe]

vlxseg6h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0xbc]

vlxseg6w.v v4, (a0), v12
# CHECK-INST: vlxseg6w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xbe]

vlxseg6w.v v4, 0(a0), v12
# CHECK-INST: vlxseg6w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xbe]

vlxseg6w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0xbc]

vlxseg6bu.v v4, (a0), v12
# CHECK-INST: vlxseg6bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xae]

vlxseg6bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg6bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xae]

vlxseg6bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0xac]

vlxseg6hu.v v4, (a0), v12
# CHECK-INST: vlxseg6hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xae]

vlxseg6hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg6hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xae]

vlxseg6hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0xac]

vlxseg6wu.v v4, (a0), v12
# CHECK-INST: vlxseg6wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xae]

vlxseg6wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg6wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xae]

vlxseg6wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0xac]

vlxseg6e.v v4, (a0), v12
# CHECK-INST: vlxseg6e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0xae]

vlxseg6e.v v4, 0(a0), v12
# CHECK-INST: vlxseg6e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0xae]

vlxseg6e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg6e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0xac]

vsxseg6b.v v4, (a0), v12
# CHECK-INST: vsxseg6b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0xae]

vsxseg6b.v v4, 0(a0), v12
# CHECK-INST: vsxseg6b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0xae]

vsxseg6b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg6b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0xac]

vsxseg6h.v v4, (a0), v12
# CHECK-INST: vsxseg6h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0xae]

vsxseg6h.v v4, 0(a0), v12
# CHECK-INST: vsxseg6h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0xae]

vsxseg6h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg6h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0xac]

vsxseg6w.v v4, (a0), v12
# CHECK-INST: vsxseg6w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0xae]

vsxseg6w.v v4, 0(a0), v12
# CHECK-INST: vsxseg6w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0xae]

vsxseg6w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg6w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0xac]

vsxseg6e.v v4, (a0), v12
# CHECK-INST: vsxseg6e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0xae]

vsxseg6e.v v4, 0(a0), v12
# CHECK-INST: vsxseg6e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0xae]

vsxseg6e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg6e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0xac]

vlxseg7b.v v4, (a0), v12
# CHECK-INST: vlxseg7b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xde]

vlxseg7b.v v4, 0(a0), v12
# CHECK-INST: vlxseg7b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xde]

vlxseg7b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0xdc]

vlxseg7h.v v4, (a0), v12
# CHECK-INST: vlxseg7h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xde]

vlxseg7h.v v4, 0(a0), v12
# CHECK-INST: vlxseg7h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xde]

vlxseg7h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0xdc]

vlxseg7w.v v4, (a0), v12
# CHECK-INST: vlxseg7w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xde]

vlxseg7w.v v4, 0(a0), v12
# CHECK-INST: vlxseg7w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xde]

vlxseg7w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0xdc]

vlxseg7bu.v v4, (a0), v12
# CHECK-INST: vlxseg7bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xce]

vlxseg7bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg7bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xce]

vlxseg7bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0xcc]

vlxseg7hu.v v4, (a0), v12
# CHECK-INST: vlxseg7hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xce]

vlxseg7hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg7hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xce]

vlxseg7hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0xcc]

vlxseg7wu.v v4, (a0), v12
# CHECK-INST: vlxseg7wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xce]

vlxseg7wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg7wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xce]

vlxseg7wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0xcc]

vlxseg7e.v v4, (a0), v12
# CHECK-INST: vlxseg7e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0xce]

vlxseg7e.v v4, 0(a0), v12
# CHECK-INST: vlxseg7e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0xce]

vlxseg7e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg7e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0xcc]

vsxseg7b.v v4, (a0), v12
# CHECK-INST: vsxseg7b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0xce]

vsxseg7b.v v4, 0(a0), v12
# CHECK-INST: vsxseg7b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0xce]

vsxseg7b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg7b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0xcc]

vsxseg7h.v v4, (a0), v12
# CHECK-INST: vsxseg7h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0xce]

vsxseg7h.v v4, 0(a0), v12
# CHECK-INST: vsxseg7h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0xce]

vsxseg7h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg7h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0xcc]

vsxseg7w.v v4, (a0), v12
# CHECK-INST: vsxseg7w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0xce]

vsxseg7w.v v4, 0(a0), v12
# CHECK-INST: vsxseg7w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0xce]

vsxseg7w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg7w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0xcc]

vsxseg7e.v v4, (a0), v12
# CHECK-INST: vsxseg7e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0xce]

vsxseg7e.v v4, 0(a0), v12
# CHECK-INST: vsxseg7e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0xce]

vsxseg7e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg7e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0xcc]

vlxseg8b.v v4, (a0), v12
# CHECK-INST: vlxseg8b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xfe]

vlxseg8b.v v4, 0(a0), v12
# CHECK-INST: vlxseg8b.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xfe]

vlxseg8b.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0xfc]

vlxseg8h.v v4, (a0), v12
# CHECK-INST: vlxseg8h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xfe]

vlxseg8h.v v4, 0(a0), v12
# CHECK-INST: vlxseg8h.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xfe]

vlxseg8h.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0xfc]

vlxseg8w.v v4, (a0), v12
# CHECK-INST: vlxseg8w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xfe]

vlxseg8w.v v4, 0(a0), v12
# CHECK-INST: vlxseg8w.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xfe]

vlxseg8w.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0xfc]

vlxseg8bu.v v4, (a0), v12
# CHECK-INST: vlxseg8bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xee]

vlxseg8bu.v v4, 0(a0), v12
# CHECK-INST: vlxseg8bu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x02,0xc5,0xee]

vlxseg8bu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8bu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x02,0xc5,0xec]

vlxseg8hu.v v4, (a0), v12
# CHECK-INST: vlxseg8hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xee]

vlxseg8hu.v v4, 0(a0), v12
# CHECK-INST: vlxseg8hu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x52,0xc5,0xee]

vlxseg8hu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8hu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x52,0xc5,0xec]

vlxseg8wu.v v4, (a0), v12
# CHECK-INST: vlxseg8wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xee]

vlxseg8wu.v v4, 0(a0), v12
# CHECK-INST: vlxseg8wu.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x62,0xc5,0xee]

vlxseg8wu.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8wu.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x62,0xc5,0xec]

vlxseg8e.v v4, (a0), v12
# CHECK-INST: vlxseg8e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0xee]

vlxseg8e.v v4, 0(a0), v12
# CHECK-INST: vlxseg8e.v	v4, (a0), v12
# CHECK-ENCODING: [0x07,0x72,0xc5,0xee]

vlxseg8e.v v4, (a0), v12, v0.t
# CHECK-INST: vlxseg8e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x07,0x72,0xc5,0xec]

vsxseg8b.v v4, (a0), v12
# CHECK-INST: vsxseg8b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0xee]

vsxseg8b.v v4, 0(a0), v12
# CHECK-INST: vsxseg8b.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x02,0xc5,0xee]

vsxseg8b.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg8b.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x02,0xc5,0xec]

vsxseg8h.v v4, (a0), v12
# CHECK-INST: vsxseg8h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0xee]

vsxseg8h.v v4, 0(a0), v12
# CHECK-INST: vsxseg8h.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x52,0xc5,0xee]

vsxseg8h.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg8h.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x52,0xc5,0xec]

vsxseg8w.v v4, (a0), v12
# CHECK-INST: vsxseg8w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0xee]

vsxseg8w.v v4, 0(a0), v12
# CHECK-INST: vsxseg8w.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x62,0xc5,0xee]

vsxseg8w.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg8w.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x62,0xc5,0xec]

vsxseg8e.v v4, (a0), v12
# CHECK-INST: vsxseg8e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0xee]

vsxseg8e.v v4, 0(a0), v12
# CHECK-INST: vsxseg8e.v	v4, (a0), v12
# CHECK-ENCODING: [0x27,0x72,0xc5,0xee]

vsxseg8e.v v4, (a0), v12, v0.t
# CHECK-INST: vsxseg8e.v	v4, (a0), v12, v0.t
# CHECK-ENCODING: [0x27,0x72,0xc5,0xec]

vlseg2bff.v v4, (a0)
# CHECK-INST: vlseg2bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x33]

vlseg2bff.v v4, 0(a0)
# CHECK-INST: vlseg2bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x33]

vlseg2bff.v v4, (a0), v0.t
# CHECK-INST: vlseg2bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x31]

vlseg2hff.v v4, (a0)
# CHECK-INST: vlseg2hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x33]

vlseg2hff.v v4, 0(a0)
# CHECK-INST: vlseg2hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x33]

vlseg2hff.v v4, (a0), v0.t
# CHECK-INST: vlseg2hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x31]

vlseg2wff.v v4, (a0)
# CHECK-INST: vlseg2wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x33]

vlseg2wff.v v4, 0(a0)
# CHECK-INST: vlseg2wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x33]

vlseg2wff.v v4, (a0), v0.t
# CHECK-INST: vlseg2wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x31]

vlseg2buff.v v4, (a0)
# CHECK-INST: vlseg2buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x23]

vlseg2buff.v v4, 0(a0)
# CHECK-INST: vlseg2buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x23]

vlseg2buff.v v4, (a0), v0.t
# CHECK-INST: vlseg2buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x21]

vlseg2huff.v v4, (a0)
# CHECK-INST: vlseg2huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x23]

vlseg2huff.v v4, 0(a0)
# CHECK-INST: vlseg2huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x23]

vlseg2huff.v v4, (a0), v0.t
# CHECK-INST: vlseg2huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x21]

vlseg2wuff.v v4, (a0)
# CHECK-INST: vlseg2wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x23]

vlseg2wuff.v v4, 0(a0)
# CHECK-INST: vlseg2wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x23]

vlseg2wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg2wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x21]

vlseg2eff.v v4, (a0)
# CHECK-INST: vlseg2eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x23]

vlseg2eff.v v4, 0(a0)
# CHECK-INST: vlseg2eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x23]

vlseg2eff.v v4, (a0), v0.t
# CHECK-INST: vlseg2eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x21]

vlseg3bff.v v4, (a0)
# CHECK-INST: vlseg3bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x53]

vlseg3bff.v v4, 0(a0)
# CHECK-INST: vlseg3bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x53]

vlseg3bff.v v4, (a0), v0.t
# CHECK-INST: vlseg3bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x51]

vlseg3hff.v v4, (a0)
# CHECK-INST: vlseg3hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x53]

vlseg3hff.v v4, 0(a0)
# CHECK-INST: vlseg3hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x53]

vlseg3hff.v v4, (a0), v0.t
# CHECK-INST: vlseg3hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x51]

vlseg3wff.v v4, (a0)
# CHECK-INST: vlseg3wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x53]

vlseg3wff.v v4, 0(a0)
# CHECK-INST: vlseg3wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x53]

vlseg3wff.v v4, (a0), v0.t
# CHECK-INST: vlseg3wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x51]

vlseg3buff.v v4, (a0)
# CHECK-INST: vlseg3buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x43]

vlseg3buff.v v4, 0(a0)
# CHECK-INST: vlseg3buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x43]

vlseg3buff.v v4, (a0), v0.t
# CHECK-INST: vlseg3buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x41]

vlseg3huff.v v4, (a0)
# CHECK-INST: vlseg3huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x43]

vlseg3huff.v v4, 0(a0)
# CHECK-INST: vlseg3huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x43]

vlseg3huff.v v4, (a0), v0.t
# CHECK-INST: vlseg3huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x41]

vlseg3wuff.v v4, (a0)
# CHECK-INST: vlseg3wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x43]

vlseg3wuff.v v4, 0(a0)
# CHECK-INST: vlseg3wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x43]

vlseg3wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg3wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x41]

vlseg3eff.v v4, (a0)
# CHECK-INST: vlseg3eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x43]

vlseg3eff.v v4, 0(a0)
# CHECK-INST: vlseg3eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x43]

vlseg3eff.v v4, (a0), v0.t
# CHECK-INST: vlseg3eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x41]

vlseg4bff.v v4, (a0)
# CHECK-INST: vlseg4bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x73]

vlseg4bff.v v4, 0(a0)
# CHECK-INST: vlseg4bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x73]

vlseg4bff.v v4, (a0), v0.t
# CHECK-INST: vlseg4bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x71]

vlseg4hff.v v4, (a0)
# CHECK-INST: vlseg4hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x73]

vlseg4hff.v v4, 0(a0)
# CHECK-INST: vlseg4hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x73]

vlseg4hff.v v4, (a0), v0.t
# CHECK-INST: vlseg4hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x71]

vlseg4wff.v v4, (a0)
# CHECK-INST: vlseg4wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x73]

vlseg4wff.v v4, 0(a0)
# CHECK-INST: vlseg4wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x73]

vlseg4wff.v v4, (a0), v0.t
# CHECK-INST: vlseg4wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x71]

vlseg4buff.v v4, (a0)
# CHECK-INST: vlseg4buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x63]

vlseg4buff.v v4, 0(a0)
# CHECK-INST: vlseg4buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x63]

vlseg4buff.v v4, (a0), v0.t
# CHECK-INST: vlseg4buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x61]

vlseg4huff.v v4, (a0)
# CHECK-INST: vlseg4huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x63]

vlseg4huff.v v4, 0(a0)
# CHECK-INST: vlseg4huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x63]

vlseg4huff.v v4, (a0), v0.t
# CHECK-INST: vlseg4huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x61]

vlseg4wuff.v v4, (a0)
# CHECK-INST: vlseg4wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x63]

vlseg4wuff.v v4, 0(a0)
# CHECK-INST: vlseg4wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x63]

vlseg4wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg4wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x61]

vlseg4eff.v v4, (a0)
# CHECK-INST: vlseg4eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x63]

vlseg4eff.v v4, 0(a0)
# CHECK-INST: vlseg4eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x63]

vlseg4eff.v v4, (a0), v0.t
# CHECK-INST: vlseg4eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x61]

vlseg5bff.v v4, (a0)
# CHECK-INST: vlseg5bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x93]

vlseg5bff.v v4, 0(a0)
# CHECK-INST: vlseg5bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x93]

vlseg5bff.v v4, (a0), v0.t
# CHECK-INST: vlseg5bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x91]

vlseg5hff.v v4, (a0)
# CHECK-INST: vlseg5hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x93]

vlseg5hff.v v4, 0(a0)
# CHECK-INST: vlseg5hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x93]

vlseg5hff.v v4, (a0), v0.t
# CHECK-INST: vlseg5hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x91]

vlseg5wff.v v4, (a0)
# CHECK-INST: vlseg5wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x93]

vlseg5wff.v v4, 0(a0)
# CHECK-INST: vlseg5wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x93]

vlseg5wff.v v4, (a0), v0.t
# CHECK-INST: vlseg5wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x91]

vlseg5buff.v v4, (a0)
# CHECK-INST: vlseg5buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x83]

vlseg5buff.v v4, 0(a0)
# CHECK-INST: vlseg5buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0x83]

vlseg5buff.v v4, (a0), v0.t
# CHECK-INST: vlseg5buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0x81]

vlseg5huff.v v4, (a0)
# CHECK-INST: vlseg5huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x83]

vlseg5huff.v v4, 0(a0)
# CHECK-INST: vlseg5huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0x83]

vlseg5huff.v v4, (a0), v0.t
# CHECK-INST: vlseg5huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0x81]

vlseg5wuff.v v4, (a0)
# CHECK-INST: vlseg5wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x83]

vlseg5wuff.v v4, 0(a0)
# CHECK-INST: vlseg5wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0x83]

vlseg5wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg5wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0x81]

vlseg5eff.v v4, (a0)
# CHECK-INST: vlseg5eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x83]

vlseg5eff.v v4, 0(a0)
# CHECK-INST: vlseg5eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0x83]

vlseg5eff.v v4, (a0), v0.t
# CHECK-INST: vlseg5eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0x81]

vlseg6bff.v v4, (a0)
# CHECK-INST: vlseg6bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xb3]

vlseg6bff.v v4, 0(a0)
# CHECK-INST: vlseg6bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xb3]

vlseg6bff.v v4, (a0), v0.t
# CHECK-INST: vlseg6bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xb1]

vlseg6hff.v v4, (a0)
# CHECK-INST: vlseg6hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xb3]

vlseg6hff.v v4, 0(a0)
# CHECK-INST: vlseg6hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xb3]

vlseg6hff.v v4, (a0), v0.t
# CHECK-INST: vlseg6hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xb1]

vlseg6wff.v v4, (a0)
# CHECK-INST: vlseg6wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xb3]

vlseg6wff.v v4, 0(a0)
# CHECK-INST: vlseg6wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xb3]

vlseg6wff.v v4, (a0), v0.t
# CHECK-INST: vlseg6wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xb1]

vlseg6buff.v v4, (a0)
# CHECK-INST: vlseg6buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xa3]

vlseg6buff.v v4, 0(a0)
# CHECK-INST: vlseg6buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xa3]

vlseg6buff.v v4, (a0), v0.t
# CHECK-INST: vlseg6buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xa1]

vlseg6huff.v v4, (a0)
# CHECK-INST: vlseg6huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xa3]

vlseg6huff.v v4, 0(a0)
# CHECK-INST: vlseg6huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xa3]

vlseg6huff.v v4, (a0), v0.t
# CHECK-INST: vlseg6huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xa1]

vlseg6wuff.v v4, (a0)
# CHECK-INST: vlseg6wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xa3]

vlseg6wuff.v v4, 0(a0)
# CHECK-INST: vlseg6wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xa3]

vlseg6wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg6wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xa1]

vlseg6eff.v v4, (a0)
# CHECK-INST: vlseg6eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xa3]

vlseg6eff.v v4, 0(a0)
# CHECK-INST: vlseg6eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xa3]

vlseg6eff.v v4, (a0), v0.t
# CHECK-INST: vlseg6eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0xa1]

vlseg7bff.v v4, (a0)
# CHECK-INST: vlseg7bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xd3]

vlseg7bff.v v4, 0(a0)
# CHECK-INST: vlseg7bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xd3]

vlseg7bff.v v4, (a0), v0.t
# CHECK-INST: vlseg7bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xd1]

vlseg7hff.v v4, (a0)
# CHECK-INST: vlseg7hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xd3]

vlseg7hff.v v4, 0(a0)
# CHECK-INST: vlseg7hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xd3]

vlseg7hff.v v4, (a0), v0.t
# CHECK-INST: vlseg7hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xd1]

vlseg7wff.v v4, (a0)
# CHECK-INST: vlseg7wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xd3]

vlseg7wff.v v4, 0(a0)
# CHECK-INST: vlseg7wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xd3]

vlseg7wff.v v4, (a0), v0.t
# CHECK-INST: vlseg7wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xd1]

vlseg7buff.v v4, (a0)
# CHECK-INST: vlseg7buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xc3]

vlseg7buff.v v4, 0(a0)
# CHECK-INST: vlseg7buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xc3]

vlseg7buff.v v4, (a0), v0.t
# CHECK-INST: vlseg7buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xc1]

vlseg7huff.v v4, (a0)
# CHECK-INST: vlseg7huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xc3]

vlseg7huff.v v4, 0(a0)
# CHECK-INST: vlseg7huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xc3]

vlseg7huff.v v4, (a0), v0.t
# CHECK-INST: vlseg7huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xc1]

vlseg7wuff.v v4, (a0)
# CHECK-INST: vlseg7wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xc3]

vlseg7wuff.v v4, 0(a0)
# CHECK-INST: vlseg7wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xc3]

vlseg7wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg7wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xc1]

vlseg7eff.v v4, (a0)
# CHECK-INST: vlseg7eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xc3]

vlseg7eff.v v4, 0(a0)
# CHECK-INST: vlseg7eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xc3]

vlseg7eff.v v4, (a0), v0.t
# CHECK-INST: vlseg7eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0xc1]

vlseg8bff.v v4, (a0)
# CHECK-INST: vlseg8bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xf3]

vlseg8bff.v v4, 0(a0)
# CHECK-INST: vlseg8bff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xf3]

vlseg8bff.v v4, (a0), v0.t
# CHECK-INST: vlseg8bff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xf1]

vlseg8hff.v v4, (a0)
# CHECK-INST: vlseg8hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xf3]

vlseg8hff.v v4, 0(a0)
# CHECK-INST: vlseg8hff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xf3]

vlseg8hff.v v4, (a0), v0.t
# CHECK-INST: vlseg8hff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xf1]

vlseg8wff.v v4, (a0)
# CHECK-INST: vlseg8wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xf3]

vlseg8wff.v v4, 0(a0)
# CHECK-INST: vlseg8wff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xf3]

vlseg8wff.v v4, (a0), v0.t
# CHECK-INST: vlseg8wff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xf1]

vlseg8buff.v v4, (a0)
# CHECK-INST: vlseg8buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xe3]

vlseg8buff.v v4, 0(a0)
# CHECK-INST: vlseg8buff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x02,0x05,0xe3]

vlseg8buff.v v4, (a0), v0.t
# CHECK-INST: vlseg8buff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x02,0x05,0xe1]

vlseg8huff.v v4, (a0)
# CHECK-INST: vlseg8huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xe3]

vlseg8huff.v v4, 0(a0)
# CHECK-INST: vlseg8huff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x52,0x05,0xe3]

vlseg8huff.v v4, (a0), v0.t
# CHECK-INST: vlseg8huff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x52,0x05,0xe1]

vlseg8wuff.v v4, (a0)
# CHECK-INST: vlseg8wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xe3]

vlseg8wuff.v v4, 0(a0)
# CHECK-INST: vlseg8wuff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x62,0x05,0xe3]

vlseg8wuff.v v4, (a0), v0.t
# CHECK-INST: vlseg8wuff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x62,0x05,0xe1]

vlseg8eff.v v4, (a0)
# CHECK-INST: vlseg8eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xe3]

vlseg8eff.v v4, 0(a0)
# CHECK-INST: vlseg8eff.v	v4, (a0)
# CHECK-ENCODING: [0x07,0x72,0x05,0xe3]

vlseg8eff.v v4, (a0), v0.t
# CHECK-INST: vlseg8eff.v	v4, (a0), v0.t
# CHECK-ENCODING: [0x07,0x72,0x05,0xe1]

vamoaddw.v v4, v8, (a1), v4
# CHECK-INST: vamoaddw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x06]

vamoaddw.v zero, v8, (a1), v4
# CHECK-INST: vamoaddw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x02]

vamoaddd.v v4, v8, (a1), v4
# CHECK-INST: vamoaddd.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x06]

vamoaddd.v zero, v8, (a1), v4
# CHECK-INST: vamoaddd.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x02]

vamoaddw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoaddw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x04]

vamoaddw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoaddw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x00]

vamoaddd.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoaddd.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x04]

vamoaddd.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoaddd.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x00]

vamoswapw.v v4, v8, (a1), v4
# CHECK-INST: vamoswapw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x0e]

vamoswapw.v zero, v8, (a1), v4
# CHECK-INST: vamoswapw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x0a]

vamoswapd.v v4, v8, (a1), v4
# CHECK-INST: vamoswapd.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x0e]

vamoswapd.v zero, v8, (a1), v4
# CHECK-INST: vamoswapd.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x0a]

vamoswapw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoswapw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x0c]

vamoswapw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoswapw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x08]

vamoswapd.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoswapd.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x0c]

vamoswapd.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoswapd.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x08]

vamoxorw.v v4, v8, (a1), v4
# CHECK-INST: vamoxorw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x26]

vamoxorw.v zero, v8, (a1), v4
# CHECK-INST: vamoxorw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x22]

vamoxord.v v4, v8, (a1), v4
# CHECK-INST: vamoxord.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x26]

vamoxord.v zero, v8, (a1), v4
# CHECK-INST: vamoxord.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x22]

vamoxorw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoxorw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x24]

vamoxorw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoxorw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x20]

vamoxord.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoxord.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x24]

vamoxord.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoxord.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x20]

vamoandw.v v4, v8, (a1), v4
# CHECK-INST: vamoandw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x66]

vamoandw.v zero, v8, (a1), v4
# CHECK-INST: vamoandw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x62]

vamoandd.v v4, v8, (a1), v4
# CHECK-INST: vamoandd.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x66]

vamoandd.v zero, v8, (a1), v4
# CHECK-INST: vamoandd.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x62]

vamoandw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoandw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x64]

vamoandw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoandw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x60]

vamoandd.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoandd.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x64]

vamoandd.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoandd.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x60]

vamoorw.v v4, v8, (a1), v4
# CHECK-INST: vamoorw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x46]

vamoorw.v zero, v8, (a1), v4
# CHECK-INST: vamoorw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x42]

vamoord.v v4, v8, (a1), v4
# CHECK-INST: vamoord.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x46]

vamoord.v zero, v8, (a1), v4
# CHECK-INST: vamoord.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x42]

vamoorw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoorw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x44]

vamoorw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoorw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x40]

vamoord.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamoord.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x44]

vamoord.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamoord.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x40]

vamominw.v v4, v8, (a1), v4
# CHECK-INST: vamominw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x86]

vamominw.v zero, v8, (a1), v4
# CHECK-INST: vamominw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x82]

vamomind.v v4, v8, (a1), v4
# CHECK-INST: vamomind.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x86]

vamomind.v zero, v8, (a1), v4
# CHECK-INST: vamomind.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x82]

vamominw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamominw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x84]

vamominw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamominw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0x80]

vamomind.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamomind.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x84]

vamomind.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamomind.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0x80]

vamomaxw.v v4, v8, (a1), v4
# CHECK-INST: vamomaxw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xa6]

vamomaxw.v zero, v8, (a1), v4
# CHECK-INST: vamomaxw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xa2]

vamomaxd.v v4, v8, (a1), v4
# CHECK-INST: vamomaxd.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xa6]

vamomaxd.v zero, v8, (a1), v4
# CHECK-INST: vamomaxd.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xa2]

vamomaxw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xa4]

vamomaxw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xa0]

vamomaxd.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxd.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xa4]

vamomaxd.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxd.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xa0]

vamominuw.v v4, v8, (a1), v4
# CHECK-INST: vamominuw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xc6]

vamominuw.v zero, v8, (a1), v4
# CHECK-INST: vamominuw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xc2]

vamominud.v v4, v8, (a1), v4
# CHECK-INST: vamominud.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xc6]

vamominud.v zero, v8, (a1), v4
# CHECK-INST: vamominud.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xc2]

vamominuw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamominuw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xc4]

vamominuw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamominuw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xc0]

vamominud.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamominud.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xc4]

vamominud.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamominud.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xc0]

vamomaxuw.v v4, v8, (a1), v4
# CHECK-INST: vamomaxuw.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xe6]

vamomaxuw.v zero, v8, (a1), v4
# CHECK-INST: vamomaxuw.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xe2]

vamomaxud.v v4, v8, (a1), v4
# CHECK-INST: vamomaxud.v v4, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xe6]

vamomaxud.v zero, v8, (a1), v4
# CHECK-INST: vamomaxud.v x0, v8, (a1), v4
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xe2]

vamomaxuw.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxuw.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xe4]

vamomaxuw.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxuw.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xe2,0x85,0xe0]

vamomaxud.v v4, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxud.v v4, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xe4]

vamomaxud.v zero, v8, (a1), v4, v0.t
# CHECK-INST: vamomaxud.v x0, v8, (a1), v4, v0.t
# CHECK-ENCODING: [0x2f,0xf2,0x85,0xe0]

vadd.vv v4, v8, v12
# CHECK-INST: vadd.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x02]

vadd.vx v4, v8, a1
# CHECK-INST: vadd.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x02]

vadd.vi v4, v8, 15
# CHECK-INST: vadd.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x02]

vadd.vi v4, v8, -16
# CHECK-INST: vadd.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x02]

vadd.vv v4, v8, v12, v0.t
# CHECK-INST: vadd.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x00]

vadd.vx v4, v8, a1, v0.t
# CHECK-INST: vadd.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x00]

vadd.vi v4, v8, 15, v0.t
# CHECK-INST: vadd.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x00]

vadd.vi v4, v8, -16, v0.t
# CHECK-INST: vadd.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x00]

vsub.vv v4, v8, v12
# CHECK-INST: vsub.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x0a]

vsub.vx v4, v8, a1
# CHECK-INST: vsub.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x0a]

vrsub.vx v4, v8, a1
# CHECK-INST: vrsub.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x0e]

vrsub.vi v4, v8, 15
# CHECK-INST: vrsub.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x0e]

vrsub.vi v4, v8, -16
# CHECK-INST: vrsub.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x0e]

vsub.vv v4, v8, v12, v0.t
# CHECK-INST: vsub.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x08]

vsub.vx v4, v8, a1, v0.t
# CHECK-INST: vsub.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x08]

vrsub.vx v4, v8, a1, v0.t
# CHECK-INST: vrsub.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x0c]

vrsub.vi v4, v8, 15, v0.t
# CHECK-INST: vrsub.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x0c]

vrsub.vi v4, v8, -16, v0.t
# CHECK-INST: vrsub.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x0c]

vwcvt.x.x.v v4, v8
# CHECK-INST: vwcvt.x.x.v v4, v8
# CHECK-ENCODING: [0x57,0x62,0x80,0xc6]

vwcvtu.x.x.v v4, v8
# CHECK-INST: vwcvtu.x.x.v v4, v8
# CHECK-ENCODING: [0x57,0x62,0x80,0xc2]

vwcvt.x.x.v v4, v8, v0.t
# CHECK-INST: vwcvt.x.x.v v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x62,0x80,0xc4]

vwcvtu.x.x.v v4, v8, v0.t
# CHECK-INST: vwcvtu.x.x.v v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x62,0x80,0xc0]

vwaddu.vv v4, v8, v12
# CHECK-INST: vwaddu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xc2]

vwaddu.vx v4, v8, a1
# CHECK-INST: vwaddu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xc2]

vwaddu.vv v4, v8, v12, v0.t
# CHECK-INST: vwaddu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xc0]

vwaddu.vx v4, v8, a1, v0.t
# CHECK-INST: vwaddu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xc0]

vwsubu.vv v4, v8, v12
# CHECK-INST: vwsubu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xca]

vwsubu.vx v4, v8, a1
# CHECK-INST: vwsubu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xca]

vwsubu.vv v4, v8, v12, v0.t
# CHECK-INST: vwsubu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xc8]

vwsubu.vx v4, v8, a1, v0.t
# CHECK-INST: vwsubu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xc8]

vwadd.vv v4, v8, v12
# CHECK-INST: vwadd.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xc6]

vwadd.vx v4, v8, a1
# CHECK-INST: vwadd.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xc6]

vwadd.vv v4, v8, v12, v0.t
# CHECK-INST: vwadd.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xc4]

vwadd.vx v4, v8, a1, v0.t
# CHECK-INST: vwadd.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xc4]

vwsub.vv v4, v8, v12
# CHECK-INST: vwsub.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xce]

vwsub.vx v4, v8, a1
# CHECK-INST: vwsub.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xce]

vwsub.vv v4, v8, v12, v0.t
# CHECK-INST: vwsub.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xcc]

vwsub.vx v4, v8, a1, v0.t
# CHECK-INST: vwsub.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xcc]

vwaddu.wv v4, v8, v12
# CHECK-INST: vwaddu.wv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xd2]

vwaddu.wx v4, v8, a1
# CHECK-INST: vwaddu.wx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xd2]

vwaddu.wv v4, v8, v12, v0.t
# CHECK-INST: vwaddu.wv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xd0]

vwaddu.wx v4, v8, a1, v0.t
# CHECK-INST: vwaddu.wx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xd0]

vwsubu.wv v4, v8, v12
# CHECK-INST: vwsubu.wv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xda]

vwsubu.wx v4, v8, a1
# CHECK-INST: vwsubu.wx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xda]

vwsubu.wv v4, v8, v12, v0.t
# CHECK-INST: vwsubu.wv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xd8]

vwsubu.wx v4, v8, a1, v0.t
# CHECK-INST: vwsubu.wx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xd8]

vwadd.wv v4, v8, v12
# CHECK-INST: vwadd.wv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xd6]

vwadd.wx v4, v8, a1
# CHECK-INST: vwadd.wx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xd6]

vwadd.wv v4, v8, v12, v0.t
# CHECK-INST: vwadd.wv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xd4]

vwadd.wx v4, v8, a1, v0.t
# CHECK-INST: vwadd.wx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xd4]

vwsub.wv v4, v8, v12
# CHECK-INST: vwsub.wv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xde]

vwsub.wx v4, v8, a1
# CHECK-INST: vwsub.wx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xde]

vwsub.wv v4, v8, v12, v0.t
# CHECK-INST: vwsub.wv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xdc]

vwsub.wx v4, v8, a1, v0.t
# CHECK-INST: vwsub.wx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xdc]

vadc.vvm v4, v8, v12, v0
# CHECK-INST: vadc.vvm	v4, v8, v12, v0
# CHECK-ENCODING: [0x57,0x02,0x86,0x42]

vadc.vxm v4, v8, a1, v0
# CHECK-INST: vadc.vxm	v4, v8, a1, v0
# CHECK-ENCODING: [0x57,0xc2,0x85,0x42]

vadc.vim v4, v8, 15, v0
# CHECK-INST: vadc.vim	v4, v8, 15, v0
# CHECK-ENCODING: [0x57,0xb2,0x87,0x42]

vadc.vim v4, v8, -16, v0
# CHECK-INST: vadc.vim	v4, v8, -16, v0
# CHECK-ENCODING: [0x57,0x32,0x88,0x42]

vmadc.vvm v4, v8, v12, v0
# CHECK-INST: vmadc.vvm	v4, v8, v12, v0
# CHECK-ENCODING: [0x57,0x02,0x86,0x46]

vmadc.vxm v4, v8, a1, v0
# CHECK-INST: vmadc.vxm	v4, v8, a1, v0
# CHECK-ENCODING: [0x57,0xc2,0x85,0x46]

vmadc.vim v4, v8, 15, v0
# CHECK-INST: vmadc.vim	v4, v8, 15, v0
# CHECK-ENCODING: [0x57,0xb2,0x87,0x46]

vmadc.vim v4, v8, -16, v0
# CHECK-INST: vmadc.vim	v4, v8, -16, v0
# CHECK-ENCODING: [0x57,0x32,0x88,0x46]

vsbc.vvm v4, v8, v12, v0
# CHECK-INST: vsbc.vvm	v4, v8, v12, v0
# CHECK-ENCODING: [0x57,0x02,0x86,0x4a]

vsbc.vxm v4, v8, a1, v0
# CHECK-INST: vsbc.vxm	v4, v8, a1, v0
# CHECK-ENCODING: [0x57,0xc2,0x85,0x4a]

vmsbc.vvm v4, v8, v12, v0
# CHECK-INST: vmsbc.vvm	v4, v8, v12, v0
# CHECK-ENCODING: [0x57,0x02,0x86,0x4e]

vmsbc.vxm v4, v8, a1, v0
# CHECK-INST: vmsbc.vxm	v4, v8, a1, v0
# CHECK-ENCODING: [0x57,0xc2,0x85,0x4e]

vnot.v v4, v8
# CHECK-INST: vnot.v v4, v8
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x2e]

vnot.v v4, v8, v0.t
# CHECK-INST: vnot.v v4, v8, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x2c]

vand.vv v4, v8, v12
# CHECK-INST: vand.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x26]

vand.vx v4, v8, a1
# CHECK-INST: vand.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x26]

vand.vi v4, v8, 15
# CHECK-INST: vand.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x26]

vand.vi v4, v8, -16
# CHECK-INST: vand.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x26]

vand.vv v4, v8, v12, v0.t
# CHECK-INST: vand.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x24]

vand.vx v4, v8, a1, v0.t
# CHECK-INST: vand.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x24]

vand.vi v4, v8, 15, v0.t
# CHECK-INST: vand.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x24]

vand.vi v4, v8, -16, v0.t
# CHECK-INST: vand.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x24]

vor.vv v4, v8, v12
# CHECK-INST: vor.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x2a]

vor.vx v4, v8, a1
# CHECK-INST: vor.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x2a]

vor.vi v4, v8, 15
# CHECK-INST: vor.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x2a]

vor.vi v4, v8, -16
# CHECK-INST: vor.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x2a]

vor.vv v4, v8, v12, v0.t
# CHECK-INST: vor.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x28]

vor.vx v4, v8, a1, v0.t
# CHECK-INST: vor.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x28]

vor.vi v4, v8, 15, v0.t
# CHECK-INST: vor.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x28]

vor.vi v4, v8, -16, v0.t
# CHECK-INST: vor.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x28]

vxor.vv v4, v8, v12
# CHECK-INST: vxor.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x2e]

vxor.vx v4, v8, a1
# CHECK-INST: vxor.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x2e]

vxor.vi v4, v8, 15
# CHECK-INST: vxor.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x2e]

vxor.vi v4, v8, -16
# CHECK-INST: vxor.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x2e]

vxor.vv v4, v8, v12, v0.t
# CHECK-INST: vxor.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x2c]

vxor.vx v4, v8, a1, v0.t
# CHECK-INST: vxor.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x2c]

vxor.vi v4, v8, 15, v0.t
# CHECK-INST: vxor.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x2c]

vxor.vi v4, v8, -16, v0.t
# CHECK-INST: vxor.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x2c]

vsll.vv v4, v8, v12
# CHECK-INST: vsll.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x96]

vsll.vx v4, v8, a1
# CHECK-INST: vsll.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x96]

vsll.vi v4, v8, 1
# CHECK-INST: vsll.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0x96]

vsll.vi v4, v8, 31
# CHECK-INST: vsll.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x96]

vsll.vv v4, v8, v12, v0.t
# CHECK-INST: vsll.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x94]

vsll.vx v4, v8, a1, v0.t
# CHECK-INST: vsll.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x94]

vsll.vi v4, v8, 1, v0.t
# CHECK-INST: vsll.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0x94]

vsll.vi v4, v8, 31, v0.t
# CHECK-INST: vsll.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x94]

vsrl.vv v4, v8, v12
# CHECK-INST: vsrl.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xa2]

vsrl.vx v4, v8, a1
# CHECK-INST: vsrl.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xa2]

vsrl.vi v4, v8, 1
# CHECK-INST: vsrl.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xa2]

vsrl.vi v4, v8, 31
# CHECK-INST: vsrl.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xa2]

vsrl.vv v4, v8, v12, v0.t
# CHECK-INST: vsrl.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xa0]

vsrl.vx v4, v8, a1, v0.t
# CHECK-INST: vsrl.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xa0]

vsrl.vi v4, v8, 1, v0.t
# CHECK-INST: vsrl.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xa0]

vsrl.vi v4, v8, 31, v0.t
# CHECK-INST: vsrl.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xa0]

vsra.vv v4, v8, v12
# CHECK-INST: vsra.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xa6]

vsra.vx v4, v8, a1
# CHECK-INST: vsra.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xa6]

vsra.vi v4, v8, 1
# CHECK-INST: vsra.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xa6]

vsra.vi v4, v8, 31
# CHECK-INST: vsra.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xa6]

vsra.vv v4, v8, v12, v0.t
# CHECK-INST: vsra.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xa4]

vsra.vx v4, v8, a1, v0.t
# CHECK-INST: vsra.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xa4]

vsra.vi v4, v8, 1, v0.t
# CHECK-INST: vsra.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xa4]

vsra.vi v4, v8, 31, v0.t
# CHECK-INST: vsra.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xa4]

vnsrl.vv v4, v8, v12
# CHECK-INST: vnsrl.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xb2]

vnsrl.vx v4, v8, a1
# CHECK-INST: vnsrl.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xb2]

vnsrl.vi v4, v8, 1
# CHECK-INST: vnsrl.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xb2]

vnsrl.vi v4, v8, 31
# CHECK-INST: vnsrl.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xb2]

vnsrl.vv v4, v8, v12, v0.t
# CHECK-INST: vnsrl.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xb0]

vnsrl.vx v4, v8, a1, v0.t
# CHECK-INST: vnsrl.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xb0]

vnsrl.vi v4, v8, 1, v0.t
# CHECK-INST: vnsrl.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xb0]

vnsrl.vi v4, v8, 31, v0.t
# CHECK-INST: vnsrl.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xb0]

vnsra.vv v4, v8, v12
# CHECK-INST: vnsra.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xb6]

vnsra.vx v4, v8, a1
# CHECK-INST: vnsra.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xb6]

vnsra.vi v4, v8, 1
# CHECK-INST: vnsra.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xb6]

vnsra.vi v4, v8, 31
# CHECK-INST: vnsra.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xb6]

vnsra.vv v4, v8, v12, v0.t
# CHECK-INST: vnsra.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xb4]

vnsra.vx v4, v8, a1, v0.t
# CHECK-INST: vnsra.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xb4]

vnsra.vi v4, v8, 1, v0.t
# CHECK-INST: vnsra.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xb4]

vnsra.vi v4, v8, 31, v0.t
# CHECK-INST: vnsra.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xb4]

vmsgt.vv v4, v8, v12
# CHECK-INST: vmslt.vv v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0xc4,0x6e]

vmsgtu.vv v4, v8, v12
# CHECK-INST: vmsltu.vv v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0xc4,0x6a]

vmsge.vv v4, v8, v12
# CHECK-INST: vmsle.vv v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0xc4,0x76]

vmsgeu.vv v4, v8, v12
# CHECK-INST: vmsleu.vv v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0xc4,0x72]

vmsgt.vv v4, v8, v12, v0.t
# CHECK-INST: vmslt.vv v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0xc4,0x6c]

vmsgtu.vv v4, v8, v12, v0.t
# CHECK-INST: vmsltu.vv v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0xc4,0x68]

vmsge.vv v4, v8, v12, v0.t
# CHECK-INST: vmsle.vv v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0xc4,0x74]

vmsgeu.vv v4, v8, v12, v0.t
# CHECK-INST: vmsleu.vv v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0xc4,0x70]

vmsge.vx v4, v8, a1
# CHECK-INST: vmslt.vx v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x6e]
# CHECK-INST: vmnot.m v4, v4
# CHECK-ENCODING: [0x57,0x22,0x42,0x76]

vmsgeu.vx v4, v8, a1
# CHECK-INST: vmsltu.vx v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x6a]
# CHECK-INST: vmnot.m v4, v4
# CHECK-ENCODING: [0x57,0x22,0x42,0x76]

vmsge.vx v8, v12, a2, v0.t
# CHECK-INST: vmslt.vx v8, v12, a2, v0.t
# CHECK-ENCODING: [0x57,0x44,0xc6,0x6c]
# CHECK-INST: vmxor.mm v8, v8, v0
# CHECK-ENCODING: [0x57,0x24,0x80,0x6e]

vmsgeu.vx v8, v12, a2, v0.t
# CHECK-INST: vmsltu.vx v8, v12, a2, v0.t
# CHECK-ENCODING: [0x57,0x44,0xc6,0x68]
# CHECK-INST: vmxor.mm v8, v8, v0
# CHECK-ENCODING: [0x57,0x24,0x80,0x6e]

vmsge.vx v4, v8, a1, v0.t, v12
# CHECK-INST: vmslt.vx v12, v8, a1
# TODO: GCC produces vmslt.vx v12, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc6,0x85,0x6e]
# CHECK-INST: vmandnot.mm v4, v4, v12
# CHECK-ENCODING: [0x57,0x22,0x46,0x62]

vmsgeu.vx v4, v8, a1, v0.t, v12
# CHECK-INST: vmsltu.vx v12, v8, a1
# TODO: GCC produces vmsltu.vx v12, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc6,0x85,0x6a]
# CHECK-INST: vmandnot.mm v4, v4, v12
# CHECK-ENCODING: [0x57,0x22,0x46,0x62]

vmslt.vi v4, v8, 16
# CHECK-INST: vmsle.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x76]

vmslt.vi v4, v8, -15
# CHECK-INST: vmsle.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x76]

vmsltu.vi v4, v8, 16
# CHECK-INST: vmsleu.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x72]

vmsltu.vi v4, v8, -15
# CHECK-INST: vmsleu.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x72]

vmsge.vi v4, v8, 16
# CHECK-INST: vmsgt.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x7e]

vmsge.vi v4, v8, -15
# CHECK-INST: vmsgt.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x7e]

vmsgeu.vi v4, v8, 16
# CHECK-INST: vmsgtu.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x7a]

vmsgeu.vi v4, v8, -15
# CHECK-INST: vmsgtu.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x7a]

vmslt.vi v4, v8, 16, v0.t
# CHECK-INST: vmsle.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x74]

vmslt.vi v4, v8, -15, v0.t
# CHECK-INST: vmsle.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x74]

vmsltu.vi v4, v8, 16, v0.t
# CHECK-INST: vmsleu.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x70]

vmsltu.vi v4, v8, -15, v0.t
# CHECK-INST: vmsleu.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x70]

vmsge.vi v4, v8, 16, v0.t
# CHECK-INST: vmsgt.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x7c]

vmsge.vi v4, v8, -15, v0.t
# CHECK-INST: vmsgt.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x7c]

vmsgeu.vi v4, v8, 16, v0.t
# CHECK-INST: vmsgtu.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x78]

vmsgeu.vi v4, v8, -15, v0.t
# CHECK-INST: vmsgtu.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x78]

vmseq.vv v4, v8, v12
# CHECK-INST: vmseq.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x62]

vmseq.vx v4, v8, a1
# CHECK-INST: vmseq.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x62]

vmseq.vi v4, v8, 15
# CHECK-INST: vmseq.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x62]

vmseq.vi v4, v8, -16
# CHECK-INST: vmseq.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x62]

vmseq.vv v4, v8, v12, v0.t
# CHECK-INST: vmseq.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x60]

vmseq.vx v4, v8, a1, v0.t
# CHECK-INST: vmseq.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x60]

vmseq.vi v4, v8, 15, v0.t
# CHECK-INST: vmseq.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x60]

vmseq.vi v4, v8, -16, v0.t
# CHECK-INST: vmseq.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x60]

vmsne.vv v4, v8, v12
# CHECK-INST: vmsne.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x66]

vmsne.vx v4, v8, a1
# CHECK-INST: vmsne.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x66]

vmsne.vi v4, v8, 15
# CHECK-INST: vmsne.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x66]

vmsne.vi v4, v8, -16
# CHECK-INST: vmsne.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x66]

vmsne.vv v4, v8, v12, v0.t
# CHECK-INST: vmsne.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x64]

vmsne.vx v4, v8, a1, v0.t
# CHECK-INST: vmsne.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x64]

vmsne.vi v4, v8, 15, v0.t
# CHECK-INST: vmsne.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x64]

vmsne.vi v4, v8, -16, v0.t
# CHECK-INST: vmsne.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x64]

vmsltu.vv v4, v8, v12
# CHECK-INST: vmsltu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x6a]

vmsltu.vx v4, v8, a1
# CHECK-INST: vmsltu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x6a]

vmsltu.vv v4, v8, v12, v0.t
# CHECK-INST: vmsltu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x68]

vmsltu.vx v4, v8, a1, v0.t
# CHECK-INST: vmsltu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x68]

vmslt.vv v4, v8, v12
# CHECK-INST: vmslt.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x6e]

vmslt.vx v4, v8, a1
# CHECK-INST: vmslt.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x6e]

vmslt.vv v4, v8, v12, v0.t
# CHECK-INST: vmslt.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x6c]

vmslt.vx v4, v8, a1, v0.t
# CHECK-INST: vmslt.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x6c]

vmsleu.vv v4, v8, v12
# CHECK-INST: vmsleu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x72]

vmsleu.vx v4, v8, a1
# CHECK-INST: vmsleu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x72]

vmsleu.vi v4, v8, 15
# CHECK-INST: vmsleu.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x72]

vmsleu.vi v4, v8, -16
# CHECK-INST: vmsleu.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x72]

vmsleu.vv v4, v8, v12, v0.t
# CHECK-INST: vmsleu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x70]

vmsleu.vx v4, v8, a1, v0.t
# CHECK-INST: vmsleu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x70]

vmsleu.vi v4, v8, 15, v0.t
# CHECK-INST: vmsleu.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x70]

vmsleu.vi v4, v8, -16, v0.t
# CHECK-INST: vmsleu.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x70]

vmsle.vv v4, v8, v12
# CHECK-INST: vmsle.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x76]

vmsle.vx v4, v8, a1
# CHECK-INST: vmsle.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x76]

vmsle.vi v4, v8, 15
# CHECK-INST: vmsle.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x76]

vmsle.vi v4, v8, -16
# CHECK-INST: vmsle.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x76]

vmsle.vv v4, v8, v12, v0.t
# CHECK-INST: vmsle.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x74]

vmsle.vx v4, v8, a1, v0.t
# CHECK-INST: vmsle.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x74]

vmsle.vi v4, v8, 15, v0.t
# CHECK-INST: vmsle.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x74]

vmsle.vi v4, v8, -16, v0.t
# CHECK-INST: vmsle.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x74]

vmsgtu.vx v4, v8, a1
# CHECK-INST: vmsgtu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x7a]

vmsgtu.vi v4, v8, 15
# CHECK-INST: vmsgtu.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x7a]

vmsgtu.vi v4, v8, -16
# CHECK-INST: vmsgtu.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x7a]

vmsgtu.vx v4, v8, a1, v0.t
# CHECK-INST: vmsgtu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x78]

vmsgtu.vi v4, v8, 15, v0.t
# CHECK-INST: vmsgtu.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x78]

vmsgtu.vi v4, v8, -16, v0.t
# CHECK-INST: vmsgtu.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x78]

vmsgt.vx v4, v8, a1
# CHECK-INST: vmsgt.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x7e]

vmsgt.vi v4, v8, 15
# CHECK-INST: vmsgt.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x7e]

vmsgt.vi v4, v8, -16
# CHECK-INST: vmsgt.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x7e]

vmsgt.vx v4, v8, a1, v0.t
# CHECK-INST: vmsgt.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x7c]

vmsgt.vi v4, v8, 15, v0.t
# CHECK-INST: vmsgt.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x7c]

vmsgt.vi v4, v8, -16, v0.t
# CHECK-INST: vmsgt.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x7c]

vminu.vv v4, v8, v12
# CHECK-INST: vminu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x12]

vminu.vx v4, v8, a1
# CHECK-INST: vminu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x12]

vminu.vv v4, v8, v12, v0.t
# CHECK-INST: vminu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x10]

vminu.vx v4, v8, a1, v0.t
# CHECK-INST: vminu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x10]

vmin.vv v4, v8, v12
# CHECK-INST: vmin.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x16]

vmin.vx v4, v8, a1
# CHECK-INST: vmin.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x16]

vmin.vv v4, v8, v12, v0.t
# CHECK-INST: vmin.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x14]

vmin.vx v4, v8, a1, v0.t
# CHECK-INST: vmin.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x14]

vmaxu.vv v4, v8, v12
# CHECK-INST: vmaxu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x1a]

vmaxu.vx v4, v8, a1
# CHECK-INST: vmaxu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x1a]

vmaxu.vv v4, v8, v12, v0.t
# CHECK-INST: vmaxu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x18]

vmaxu.vx v4, v8, a1, v0.t
# CHECK-INST: vmaxu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x18]

vmax.vv v4, v8, v12
# CHECK-INST: vmax.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x1e]

vmax.vx v4, v8, a1
# CHECK-INST: vmax.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x1e]

vmax.vv v4, v8, v12, v0.t
# CHECK-INST: vmax.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x1c]

vmax.vx v4, v8, a1, v0.t
# CHECK-INST: vmax.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x1c]

vmul.vv v4, v8, v12
# CHECK-INST: vmul.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x96]

vmul.vx v4, v8, a1
# CHECK-INST: vmul.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x96]

vmul.vv v4, v8, v12, v0.t
# CHECK-INST: vmul.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x94]

vmul.vx v4, v8, a1, v0.t
# CHECK-INST: vmul.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x94]

vmulh.vv v4, v8, v12
# CHECK-INST: vmulh.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x9e]

vmulh.vx v4, v8, a1
# CHECK-INST: vmulh.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x9e]

vmulh.vv v4, v8, v12, v0.t
# CHECK-INST: vmulh.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x9c]

vmulh.vx v4, v8, a1, v0.t
# CHECK-INST: vmulh.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x9c]

vmulhu.vv v4, v8, v12
# CHECK-INST: vmulhu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x92]

vmulhu.vx v4, v8, a1
# CHECK-INST: vmulhu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x92]

vmulhu.vv v4, v8, v12, v0.t
# CHECK-INST: vmulhu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x90]

vmulhu.vx v4, v8, a1, v0.t
# CHECK-INST: vmulhu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x90]

vmulhsu.vv v4, v8, v12
# CHECK-INST: vmulhsu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x9a]

vmulhsu.vx v4, v8, a1
# CHECK-INST: vmulhsu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x9a]

vmulhsu.vv v4, v8, v12, v0.t
# CHECK-INST: vmulhsu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x98]

vmulhsu.vx v4, v8, a1, v0.t
# CHECK-INST: vmulhsu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x98]

vwmul.vv v4, v8, v12
# CHECK-INST: vwmul.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xee]

vwmul.vx v4, v8, a1
# CHECK-INST: vwmul.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xee]

vwmul.vv v4, v8, v12, v0.t
# CHECK-INST: vwmul.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xec]

vwmul.vx v4, v8, a1, v0.t
# CHECK-INST: vwmul.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xec]

vwmulu.vv v4, v8, v12
# CHECK-INST: vwmulu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xe2]

vwmulu.vx v4, v8, a1
# CHECK-INST: vwmulu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xe2]

vwmulu.vv v4, v8, v12, v0.t
# CHECK-INST: vwmulu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xe0]

vwmulu.vx v4, v8, a1, v0.t
# CHECK-INST: vwmulu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xe0]

vwmulsu.vv v4, v8, v12
# CHECK-INST: vwmulsu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0xea]

vwmulsu.vx v4, v8, a1
# CHECK-INST: vwmulsu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0xea]

vwmulsu.vv v4, v8, v12, v0.t
# CHECK-INST: vwmulsu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xe8]

vwmulsu.vx v4, v8, a1, v0.t
# CHECK-INST: vwmulsu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xe8]

vmacc.vv v4, v12, v8
# CHECK-INST: vmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xb6]

vmacc.vx v4, a1, v8
# CHECK-INST: vmacc.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xb6]

vmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xb4]

vmacc.vx v4, a1, v8, v0.t
# CHECK-INST: vmacc.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xb4]

vnmsac.vv v4, v12, v8
# CHECK-INST: vnmsac.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xbe]

vnmsac.vx v4, a1, v8
# CHECK-INST: vnmsac.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xbe]

vnmsac.vv v4, v12, v8, v0.t
# CHECK-INST: vnmsac.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xbc]

vnmsac.vx v4, a1, v8, v0.t
# CHECK-INST: vnmsac.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xbc]

vmadd.vv v4, v12, v8
# CHECK-INST: vmadd.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xa6]

vmadd.vx v4, a1, v8
# CHECK-INST: vmadd.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xa6]

vmadd.vv v4, v12, v8, v0.t
# CHECK-INST: vmadd.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xa4]

vmadd.vx v4, a1, v8, v0.t
# CHECK-INST: vmadd.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xa4]

vnmsub.vv v4, v12, v8
# CHECK-INST: vnmsub.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xae]

vnmsub.vx v4, a1, v8
# CHECK-INST: vnmsub.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xae]

vnmsub.vv v4, v12, v8, v0.t
# CHECK-INST: vnmsub.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xac]

vnmsub.vx v4, a1, v8, v0.t
# CHECK-INST: vnmsub.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xac]

vwmaccu.vv v4, v12, v8
# CHECK-INST: vwmaccu.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xf2]

vwmaccu.vx v4, a1, v8
# CHECK-INST: vwmaccu.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xf2]

vwmaccu.vv v4, v12, v8, v0.t
# CHECK-INST: vwmaccu.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xf0]

vwmaccu.vx v4, a1, v8, v0.t
# CHECK-INST: vwmaccu.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xf0]

vwmacc.vv v4, v12, v8
# CHECK-INST: vwmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xf6]

vwmacc.vx v4, a1, v8
# CHECK-INST: vwmacc.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xf6]

vwmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vwmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xf4]

vwmacc.vx v4, a1, v8, v0.t
# CHECK-INST: vwmacc.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xf4]

vwmaccsu.vv v4, v12, v8
# CHECK-INST: vwmaccsu.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x22,0x86,0xfa]

vwmaccsu.vx v4, a1, v8
# CHECK-INST: vwmaccsu.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xfa]

vwmaccsu.vv v4, v12, v8, v0.t
# CHECK-INST: vwmaccsu.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0xf8]

vwmaccsu.vx v4, a1, v8, v0.t
# CHECK-INST: vwmaccsu.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xf8]

vwmaccus.vx v4, a1, v8
# CHECK-INST: vwmaccus.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xe2,0x85,0xfe]

vwmaccus.vx v4, a1, v8, v0.t
# CHECK-INST: vwmaccus.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0xfc]

vdivu.vv v4, v8, v12
# CHECK-INST: vdivu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x82]

vdivu.vx v4, v8, a1
# CHECK-INST: vdivu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x82]

vdivu.vv v4, v8, v12, v0.t
# CHECK-INST: vdivu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x80]

vdivu.vx v4, v8, a1, v0.t
# CHECK-INST: vdivu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x80]

vdiv.vv v4, v8, v12
# CHECK-INST: vdiv.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x86]

vdiv.vx v4, v8, a1
# CHECK-INST: vdiv.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x86]

vdiv.vv v4, v8, v12, v0.t
# CHECK-INST: vdiv.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x84]

vdiv.vx v4, v8, a1, v0.t
# CHECK-INST: vdiv.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x84]

vremu.vv v4, v8, v12
# CHECK-INST: vremu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x8a]

vremu.vx v4, v8, a1
# CHECK-INST: vremu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x8a]

vremu.vv v4, v8, v12, v0.t
# CHECK-INST: vremu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x88]

vremu.vx v4, v8, a1, v0.t
# CHECK-INST: vremu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x88]

vrem.vv v4, v8, v12
# CHECK-INST: vrem.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x8e]

vrem.vx v4, v8, a1
# CHECK-INST: vrem.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x8e]

vrem.vv v4, v8, v12, v0.t
# CHECK-INST: vrem.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x8c]

vrem.vx v4, v8, a1, v0.t
# CHECK-INST: vrem.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x8c]

vmerge.vvm v4, v8, v12, v0
# CHECK-INST: vmerge.vvm	v4, v8, v12, v0
# CHECK-ENCODING: [0x57,0x02,0x86,0x5c]

vmerge.vxm v4, v8, a1, v0
# CHECK-INST: vmerge.vxm	v4, v8, a1, v0
# CHECK-ENCODING: [0x57,0xc2,0x85,0x5c]

vmerge.vim v4, v8, 15, v0
# CHECK-INST: vmerge.vim	v4, v8, 15, v0
# CHECK-ENCODING: [0x57,0xb2,0x87,0x5c]

vmerge.vim v4, v8, -16, v0
# CHECK-INST: vmerge.vim	v4, v8, -16, v0
# CHECK-ENCODING: [0x57,0x32,0x88,0x5c]

vmv.v.v v8, v12
# CHECK-INST: vmv.v.v	v8, v12
# CHECK-ENCODING: [0x57,0x04,0x06,0x5e]

vmv.v.x v8, a1
# CHECK-INST: vmv.v.x	v8, a1
# CHECK-ENCODING: [0x57,0xc4,0x05,0x5e]

vmv.v.i v8, 15
# CHECK-INST: vmv.v.i	v8, 15
# CHECK-ENCODING: [0x57,0xb4,0x07,0x5e]

vmv.v.i v8, -16
# CHECK-INST: vmv.v.i	v8, -16
# CHECK-ENCODING: [0x57,0x34,0x08,0x5e]

vsaddu.vv v4, v8, v12
# CHECK-INST: vsaddu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x82]

vsaddu.vx v4, v8, a1
# CHECK-INST: vsaddu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x82]

vsaddu.vi v4, v8, 15
# CHECK-INST: vsaddu.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x82]

vsaddu.vi v4, v8, -16
# CHECK-INST: vsaddu.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x82]

vsaddu.vv v4, v8, v12, v0.t
# CHECK-INST: vsaddu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x80]

vsaddu.vx v4, v8, a1, v0.t
# CHECK-INST: vsaddu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x80]

vsaddu.vi v4, v8, 15, v0.t
# CHECK-INST: vsaddu.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x80]

vsaddu.vi v4, v8, -16, v0.t
# CHECK-INST: vsaddu.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x80]

vsadd.vv v4, v8, v12
# CHECK-INST: vsadd.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x86]

vsadd.vx v4, v8, a1
# CHECK-INST: vsadd.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x86]

vsadd.vi v4, v8, 15
# CHECK-INST: vsadd.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x86]

vsadd.vi v4, v8, -16
# CHECK-INST: vsadd.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x86]

vsadd.vv v4, v8, v12, v0.t
# CHECK-INST: vsadd.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x84]

vsadd.vx v4, v8, a1, v0.t
# CHECK-INST: vsadd.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x84]

vsadd.vi v4, v8, 15, v0.t
# CHECK-INST: vsadd.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x84]

vsadd.vi v4, v8, -16, v0.t
# CHECK-INST: vsadd.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x84]

vssubu.vv v4, v8, v12
# CHECK-INST: vssubu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x8a]

vssubu.vx v4, v8, a1
# CHECK-INST: vssubu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x8a]

vssubu.vv v4, v8, v12, v0.t
# CHECK-INST: vssubu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x88]

vssubu.vx v4, v8, a1, v0.t
# CHECK-INST: vssubu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x88]

vssub.vv v4, v8, v12
# CHECK-INST: vssub.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x8e]

vssub.vx v4, v8, a1
# CHECK-INST: vssub.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x8e]

vssub.vv v4, v8, v12, v0.t
# CHECK-INST: vssub.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x8c]

vssub.vx v4, v8, a1, v0.t
# CHECK-INST: vssub.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x8c]

vaadd.vv v4, v8, v12
# CHECK-INST: vaadd.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x92]

vaadd.vx v4, v8, a1
# CHECK-INST: vaadd.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x92]

vaadd.vi v4, v8, 15
# CHECK-INST: vaadd.vi	v4, v8, 15
# CHECK-ENCODING: [0x57,0xb2,0x87,0x92]

vaadd.vi v4, v8, -16
# CHECK-INST: vaadd.vi	v4, v8, -16
# CHECK-ENCODING: [0x57,0x32,0x88,0x92]

vaadd.vv v4, v8, v12, v0.t
# CHECK-INST: vaadd.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x90]

vaadd.vx v4, v8, a1, v0.t
# CHECK-INST: vaadd.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x90]

vaadd.vi v4, v8, 15, v0.t
# CHECK-INST: vaadd.vi	v4, v8, 15, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x87,0x90]

vaadd.vi v4, v8, -16, v0.t
# CHECK-INST: vaadd.vi	v4, v8, -16, v0.t
# CHECK-ENCODING: [0x57,0x32,0x88,0x90]

vasub.vv v4, v8, v12
# CHECK-INST: vasub.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x9a]

vasub.vx v4, v8, a1
# CHECK-INST: vasub.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x9a]

vasub.vv v4, v8, v12, v0.t
# CHECK-INST: vasub.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x98]

vasub.vx v4, v8, a1, v0.t
# CHECK-INST: vasub.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x98]

vsmul.vv v4, v8, v12
# CHECK-INST: vsmul.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x9e]

vsmul.vx v4, v8, a1
# CHECK-INST: vsmul.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x9e]

vsmul.vv v4, v8, v12, v0.t
# CHECK-INST: vsmul.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x9c]

vsmul.vx v4, v8, a1, v0.t
# CHECK-INST: vsmul.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x9c]

vwsmaccu.vv v4, v12, v8
# CHECK-INST: vwsmaccu.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0x86,0xf2]

vwsmaccu.vx v4, a1, v8
# CHECK-INST: vwsmaccu.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xc2,0x85,0xf2]

vwsmacc.vv v4, v12, v8
# CHECK-INST: vwsmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0x86,0xf6]

vwsmacc.vx v4, a1, v8
# CHECK-INST: vwsmacc.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xc2,0x85,0xf6]

vwsmaccsu.vv v4, v12, v8
# CHECK-INST: vwsmaccsu.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x02,0x86,0xfa]

vwsmaccsu.vx v4, a1, v8
# CHECK-INST: vwsmaccsu.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xc2,0x85,0xfa]

vwsmaccus.vx v4, a1, v8
# CHECK-INST: vwsmaccus.vx	v4, a1, v8
# CHECK-ENCODING: [0x57,0xc2,0x85,0xfe]

vwsmaccu.vv v4, v12, v8, v0.t
# CHECK-INST: vwsmaccu.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xf0]

vwsmaccu.vx v4, a1, v8, v0.t
# CHECK-INST: vwsmaccu.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xf0]

vwsmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vwsmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xf4]

vwsmacc.vx v4, a1, v8, v0.t
# CHECK-INST: vwsmacc.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xf4]

vwsmaccsu.vv v4, v12, v8, v0.t
# CHECK-INST: vwsmaccsu.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xf8]

vwsmaccsu.vx v4, a1, v8, v0.t
# CHECK-INST: vwsmaccsu.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xf8]

vwsmaccus.vx v4, a1, v8, v0.t
# CHECK-INST: vwsmaccus.vx	v4, a1, v8, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xfc]

vssrl.vv v4, v8, v12
# CHECK-INST: vssrl.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xaa]

vssrl.vx v4, v8, a1
# CHECK-INST: vssrl.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xaa]

vssrl.vi v4, v8, 1
# CHECK-INST: vssrl.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xaa]

vssrl.vi v4, v8, 31
# CHECK-INST: vssrl.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xaa]

vssrl.vv v4, v8, v12, v0.t
# CHECK-INST: vssrl.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xa8]

vssrl.vx v4, v8, a1, v0.t
# CHECK-INST: vssrl.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xa8]

vssrl.vi v4, v8, 1, v0.t
# CHECK-INST: vssrl.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xa8]

vssrl.vi v4, v8, 31, v0.t
# CHECK-INST: vssrl.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xa8]

vssra.vv v4, v8, v12
# CHECK-INST: vssra.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xae]

vssra.vx v4, v8, a1
# CHECK-INST: vssra.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xae]

vssra.vi v4, v8, 1
# CHECK-INST: vssra.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xae]

vssra.vi v4, v8, 31
# CHECK-INST: vssra.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xae]

vssra.vv v4, v8, v12, v0.t
# CHECK-INST: vssra.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xac]

vssra.vx v4, v8, a1, v0.t
# CHECK-INST: vssra.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xac]

vssra.vi v4, v8, 1, v0.t
# CHECK-INST: vssra.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xac]

vssra.vi v4, v8, 31, v0.t
# CHECK-INST: vssra.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xac]

vnclipu.vv v4, v8, v12
# CHECK-INST: vnclipu.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xba]

vnclipu.vx v4, v8, a1
# CHECK-INST: vnclipu.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xba]

vnclipu.vi v4, v8, 1
# CHECK-INST: vnclipu.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xba]

vnclipu.vi v4, v8, 31
# CHECK-INST: vnclipu.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xba]

vnclipu.vv v4, v8, v12, v0.t
# CHECK-INST: vnclipu.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xb8]

vnclipu.vx v4, v8, a1, v0.t
# CHECK-INST: vnclipu.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xb8]

vnclipu.vi v4, v8, 1, v0.t
# CHECK-INST: vnclipu.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xb8]

vnclipu.vi v4, v8, 31, v0.t
# CHECK-INST: vnclipu.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xb8]

vnclip.vv v4, v8, v12
# CHECK-INST: vnclip.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xbe]

vnclip.vx v4, v8, a1
# CHECK-INST: vnclip.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0xbe]

vnclip.vi v4, v8, 1
# CHECK-INST: vnclip.vi	v4, v8, 1
# CHECK-ENCODING: [0x57,0xb2,0x80,0xbe]

vnclip.vi v4, v8, 31
# CHECK-INST: vnclip.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xbe]

vnclip.vv v4, v8, v12, v0.t
# CHECK-INST: vnclip.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xbc]

vnclip.vx v4, v8, a1, v0.t
# CHECK-INST: vnclip.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0xbc]

vnclip.vi v4, v8, 1, v0.t
# CHECK-INST: vnclip.vi	v4, v8, 1, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x80,0xbc]

vnclip.vi v4, v8, 31, v0.t
# CHECK-INST: vnclip.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0xbc]

vfadd.vv v4, v8, v12
# CHECK-INST: vfadd.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x02]

vfadd.vf v4, v8, fa2
# CHECK-INST: vfadd.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x02]

vfadd.vv v4, v8, v12, v0.t
# CHECK-INST: vfadd.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x00]

vfadd.vf v4, v8, fa2, v0.t
# CHECK-INST: vfadd.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x00]

vfsub.vv v4, v8, v12
# CHECK-INST: vfsub.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x0a]

vfsub.vf v4, v8, fa2
# CHECK-INST: vfsub.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x0a]

vfsub.vv v4, v8, v12, v0.t
# CHECK-INST: vfsub.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x08]

vfsub.vf v4, v8, fa2, v0.t
# CHECK-INST: vfsub.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x08]

vfrsub.vf v4, v8, fa2
# CHECK-INST: vfrsub.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x9e]

vfrsub.vf v4, v8, fa2, v0.t
# CHECK-INST: vfrsub.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x9c]

vfwadd.vv v4, v8, v12
# CHECK-INST: vfwadd.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xc2]

vfwadd.vf v4, v8, fa2
# CHECK-INST: vfwadd.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0xc2]

vfwadd.vv v4, v8, v12, v0.t
# CHECK-INST: vfwadd.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xc0]

vfwadd.vf v4, v8, fa2, v0.t
# CHECK-INST: vfwadd.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xc0]

vfwsub.vv v4, v8, v12
# CHECK-INST: vfwsub.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xca]

vfwsub.vf v4, v8, fa2
# CHECK-INST: vfwsub.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0xca]

vfwsub.vv v4, v8, v12, v0.t
# CHECK-INST: vfwsub.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xc8]

vfwsub.vf v4, v8, fa2, v0.t
# CHECK-INST: vfwsub.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xc8]

vfwadd.wv v4, v8, v12
# CHECK-INST: vfwadd.wv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xd2]

vfwadd.wf v4, v8, fa2
# CHECK-INST: vfwadd.wf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0xd2]

vfwadd.wv v4, v8, v12, v0.t
# CHECK-INST: vfwadd.wv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xd0]

vfwadd.wf v4, v8, fa2, v0.t
# CHECK-INST: vfwadd.wf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xd0]

vfwsub.wv v4, v8, v12
# CHECK-INST: vfwsub.wv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xda]

vfwsub.wf v4, v8, fa2
# CHECK-INST: vfwsub.wf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0xda]

vfwsub.wv v4, v8, v12, v0.t
# CHECK-INST: vfwsub.wv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xd8]

vfwsub.wf v4, v8, fa2, v0.t
# CHECK-INST: vfwsub.wf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xd8]

vfmul.vv v4, v8, v12
# CHECK-INST: vfmul.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x92]

vfmul.vf v4, v8, fa2
# CHECK-INST: vfmul.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x92]

vfmul.vv v4, v8, v12, v0.t
# CHECK-INST: vfmul.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x90]

vfmul.vf v4, v8, fa2, v0.t
# CHECK-INST: vfmul.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x90]

vfdiv.vv v4, v8, v12
# CHECK-INST: vfdiv.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x82]

vfdiv.vf v4, v8, fa2
# CHECK-INST: vfdiv.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x82]

vfdiv.vv v4, v8, v12, v0.t
# CHECK-INST: vfdiv.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x80]

vfdiv.vf v4, v8, fa2, v0.t
# CHECK-INST: vfdiv.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x80]

vfrdiv.vf v4, v8, fa2
# CHECK-INST: vfrdiv.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x86]

vfrdiv.vf v4, v8, fa2, v0.t
# CHECK-INST: vfrdiv.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x84]

vfwmul.vv v4, v8, v12
# CHECK-INST: vfwmul.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xe2]

vfwmul.vf v4, v8, fa2
# CHECK-INST: vfwmul.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0xe2]

vfwmul.vv v4, v8, v12, v0.t
# CHECK-INST: vfwmul.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xe0]

vfwmul.vf v4, v8, fa2, v0.t
# CHECK-INST: vfwmul.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xe0]

vfmadd.vv v4, v12, v8
# CHECK-INST: vfmadd.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xa2]

vfmadd.vf v4, fa2, v8
# CHECK-INST: vfmadd.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xa2]

vfnmadd.vv v4, v12, v8
# CHECK-INST: vfnmadd.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xa6]

vfnmadd.vf v4, fa2, v8
# CHECK-INST: vfnmadd.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xa6]

vfmsub.vv v4, v12, v8
# CHECK-INST: vfmsub.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xaa]

vfmsub.vf v4, fa2, v8
# CHECK-INST: vfmsub.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xaa]

vfnmsub.vv v4, v12, v8
# CHECK-INST: vfnmsub.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xae]

vfnmsub.vf v4, fa2, v8
# CHECK-INST: vfnmsub.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xae]

vfmadd.vv v4, v12, v8, v0.t
# CHECK-INST: vfmadd.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xa0]

vfmadd.vf v4, fa2, v8, v0.t
# CHECK-INST: vfmadd.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xa0]

vfnmadd.vv v4, v12, v8, v0.t
# CHECK-INST: vfnmadd.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xa4]

vfnmadd.vf v4, fa2, v8, v0.t
# CHECK-INST: vfnmadd.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xa4]

vfmsub.vv v4, v12, v8, v0.t
# CHECK-INST: vfmsub.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xa8]

vfmsub.vf v4, fa2, v8, v0.t
# CHECK-INST: vfmsub.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xa8]

vfnmsub.vv v4, v12, v8, v0.t
# CHECK-INST: vfnmsub.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xac]

vfnmsub.vf v4, fa2, v8, v0.t
# CHECK-INST: vfnmsub.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xac]

vfmacc.vv v4, v12, v8
# CHECK-INST: vfmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xb2]

vfmacc.vf v4, fa2, v8
# CHECK-INST: vfmacc.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xb2]

vfnmacc.vv v4, v12, v8
# CHECK-INST: vfnmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xb6]

vfnmacc.vf v4, fa2, v8
# CHECK-INST: vfnmacc.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xb6]

vfmsac.vv v4, v12, v8
# CHECK-INST: vfmsac.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xba]

vfmsac.vf v4, fa2, v8
# CHECK-INST: vfmsac.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xba]

vfnmsac.vv v4, v12, v8
# CHECK-INST: vfnmsac.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xbe]

vfnmsac.vf v4, fa2, v8
# CHECK-INST: vfnmsac.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xbe]

vfmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vfmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xb0]

vfmacc.vf v4, fa2, v8, v0.t
# CHECK-INST: vfmacc.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xb0]

vfnmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vfnmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xb4]

vfnmacc.vf v4, fa2, v8, v0.t
# CHECK-INST: vfnmacc.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xb4]

vfmsac.vv v4, v12, v8, v0.t
# CHECK-INST: vfmsac.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xb8]

vfmsac.vf v4, fa2, v8, v0.t
# CHECK-INST: vfmsac.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xb8]

vfnmsac.vv v4, v12, v8, v0.t
# CHECK-INST: vfnmsac.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xbc]

vfnmsac.vf v4, fa2, v8, v0.t
# CHECK-INST: vfnmsac.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xbc]

vfwmacc.vv v4, v12, v8
# CHECK-INST: vfwmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xf2]

vfwmacc.vf v4, fa2, v8
# CHECK-INST: vfwmacc.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xf2]

vfwnmacc.vv v4, v12, v8
# CHECK-INST: vfwnmacc.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xf6]

vfwnmacc.vf v4, fa2, v8
# CHECK-INST: vfwnmacc.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xf6]

vfwmsac.vv v4, v12, v8
# CHECK-INST: vfwmsac.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xfa]

vfwmsac.vf v4, fa2, v8
# CHECK-INST: vfwmsac.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xfa]

vfwnmsac.vv v4, v12, v8
# CHECK-INST: vfwnmsac.vv	v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0xfe]

vfwnmsac.vf v4, fa2, v8
# CHECK-INST: vfwnmsac.vf	v4, fa2, v8
# CHECK-ENCODING: [0x57,0x52,0x86,0xfe]

vfwmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vfwmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xf0]

vfwmacc.vf v4, fa2, v8, v0.t
# CHECK-INST: vfwmacc.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xf0]

vfwnmacc.vv v4, v12, v8, v0.t
# CHECK-INST: vfwnmacc.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xf4]

vfwnmacc.vf v4, fa2, v8, v0.t
# CHECK-INST: vfwnmacc.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xf4]

vfwmsac.vv v4, v12, v8, v0.t
# CHECK-INST: vfwmsac.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xf8]

vfwmsac.vf v4, fa2, v8, v0.t
# CHECK-INST: vfwmsac.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xf8]

vfwnmsac.vv v4, v12, v8, v0.t
# CHECK-INST: vfwnmsac.vv	v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xfc]

vfwnmsac.vf v4, fa2, v8, v0.t
# CHECK-INST: vfwnmsac.vf	v4, fa2, v8, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0xfc]

vfsqrt.v v4, v8
# CHECK-INST: vfsqrt.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x80,0x8e]

vfsqrt.v v4, v8, v0.t
# CHECK-INST: vfsqrt.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x80,0x8c]

vfmin.vv v4, v8, v12
# CHECK-INST: vfmin.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x12]

vfmin.vf v4, v8, fa2
# CHECK-INST: vfmin.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x12]

vfmax.vv v4, v8, v12
# CHECK-INST: vfmax.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x1a]

vfmax.vf v4, v8, fa2
# CHECK-INST: vfmax.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x1a]

vfmin.vv v4, v8, v12, v0.t
# CHECK-INST: vfmin.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x10]

vfmin.vf v4, v8, fa2, v0.t
# CHECK-INST: vfmin.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x10]

vfmax.vv v4, v8, v12, v0.t
# CHECK-INST: vfmax.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x18]

vfmax.vf v4, v8, fa2, v0.t
# CHECK-INST: vfmax.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x18]

vfsgnj.vv v4, v8, v12
# CHECK-INST: vfsgnj.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x22]

vfsgnj.vf v4, v8, fa2
# CHECK-INST: vfsgnj.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x22]

vfsgnjn.vv v4, v8, v12
# CHECK-INST: vfsgnjn.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x26]

vfsgnjn.vf v4, v8, fa2
# CHECK-INST: vfsgnjn.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x26]

vfsgnjx.vv v4, v8, v12
# CHECK-INST: vfsgnjx.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x2a]

vfsgnjx.vf v4, v8, fa2
# CHECK-INST: vfsgnjx.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x2a]

vfsgnj.vv v4, v8, v12, v0.t
# CHECK-INST: vfsgnj.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x20]

vfsgnj.vf v4, v8, fa2, v0.t
# CHECK-INST: vfsgnj.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x20]

vfsgnjn.vv v4, v8, v12, v0.t
# CHECK-INST: vfsgnjn.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x24]

vfsgnjn.vf v4, v8, fa2, v0.t
# CHECK-INST: vfsgnjn.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x24]

vfsgnjx.vv v4, v8, v12, v0.t
# CHECK-INST: vfsgnjx.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x28]

vfsgnjx.vf v4, v8, fa2, v0.t
# CHECK-INST: vfsgnjx.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x28]

vmfgt.vv v4, v8, v12
# CHECK-INST: vmflt.vv v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0xc4,0x6e]

vmfge.vv v4, v8, v12
# CHECK-INST: vmfle.vv v4, v12, v8
# CHECK-ENCODING: [0x57,0x12,0xc4,0x66]

vmfgt.vv v4, v8, v12, v0.t
# CHECK-INST: vmflt.vv v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0xc4,0x6c]

vmfge.vv v4, v8, v12, v0.t
# CHECK-INST: vmfle.vv v4, v12, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0xc4,0x64]

vmfeq.vv v4, v8, v12
# CHECK-INST: vmfeq.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x62]

vmfeq.vf v4, v8, fa2
# CHECK-INST: vmfeq.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x62]

vmfne.vv v4, v8, v12
# CHECK-INST: vmfne.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x72]

vmfne.vf v4, v8, fa2
# CHECK-INST: vmfne.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x72]

vmflt.vv v4, v8, v12
# CHECK-INST: vmflt.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x6e]

vmflt.vf v4, v8, fa2
# CHECK-INST: vmflt.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x6e]

vmfle.vv v4, v8, v12
# CHECK-INST: vmfle.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x66]

vmfle.vf v4, v8, fa2
# CHECK-INST: vmfle.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x66]

vmfgt.vf v4, v8, fa2
# CHECK-INST: vmfgt.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x76]

vmfge.vf v4, v8, fa2
# CHECK-INST: vmfge.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x7e]

vmfeq.vv v4, v8, v12, v0.t
# CHECK-INST: vmfeq.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x60]

vmfeq.vf v4, v8, fa2, v0.t
# CHECK-INST: vmfeq.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x60]

vmfne.vv v4, v8, v12, v0.t
# CHECK-INST: vmfne.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x70]

vmfne.vf v4, v8, fa2, v0.t
# CHECK-INST: vmfne.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x70]

vmflt.vv v4, v8, v12, v0.t
# CHECK-INST: vmflt.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x6c]

vmflt.vf v4, v8, fa2, v0.t
# CHECK-INST: vmflt.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x6c]

vmfle.vv v4, v8, v12, v0.t
# CHECK-INST: vmfle.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x64]

vmfle.vf v4, v8, fa2, v0.t
# CHECK-INST: vmfle.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x64]

vmfgt.vf v4, v8, fa2, v0.t
# CHECK-INST: vmfgt.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x74]

vmfge.vf v4, v8, fa2, v0.t
# CHECK-INST: vmfge.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x7c]

vmford.vv v4, v8, v12
# CHECK-INST: vmford.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x6a]

vmford.vf v4, v8, fa2
# CHECK-INST: vmford.vf	v4, v8, fa2
# CHECK-ENCODING: [0x57,0x52,0x86,0x6a]

vmford.vv v4, v8, v12, v0.t
# CHECK-INST: vmford.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x68]

vmford.vf v4, v8, fa2, v0.t
# CHECK-INST: vmford.vf	v4, v8, fa2, v0.t
# CHECK-ENCODING: [0x57,0x52,0x86,0x68]

vfclass.v v4, v8
# CHECK-INST: vfclass.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x88,0x8e]

vfclass.v v4, v8, v0.t
# CHECK-INST: vfclass.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x88,0x8c]

vfmerge.vfm v4, v8, fa2, v0
# CHECK-INST: vfmerge.vfm	v4, v8, fa2, v0
# CHECK-ENCODING: [0x57,0x52,0x86,0x5c]

vfmv.v.f v4, fa1
# CHECK-INST: vfmv.v.f	v4, fa1
# CHECK-ENCODING: [0x57,0xd2,0x05,0x5e]

vfcvt.xu.f.v v4, v8
# CHECK-INST: vfcvt.xu.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x80,0x8a]

vfcvt.x.f.v v4, v8
# CHECK-INST: vfcvt.x.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x92,0x80,0x8a]

vfcvt.f.xu.v v4, v8
# CHECK-INST: vfcvt.f.xu.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x81,0x8a]

vfcvt.f.x.v v4, v8
# CHECK-INST: vfcvt.f.x.v	v4, v8
# CHECK-ENCODING: [0x57,0x92,0x81,0x8a]

vfcvt.xu.f.v v4, v8, v0.t
# CHECK-INST: vfcvt.xu.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x80,0x88]

vfcvt.x.f.v v4, v8, v0.t
# CHECK-INST: vfcvt.x.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x92,0x80,0x88]

vfcvt.f.xu.v v4, v8, v0.t
# CHECK-INST: vfcvt.f.xu.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x81,0x88]

vfcvt.f.x.v v4, v8, v0.t
# CHECK-INST: vfcvt.f.x.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x92,0x81,0x88]

vfwcvt.xu.f.v v4, v8
# CHECK-INST: vfwcvt.xu.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x84,0x8a]

vfwcvt.x.f.v v4, v8
# CHECK-INST: vfwcvt.x.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x92,0x84,0x8a]

vfwcvt.f.xu.v v4, v8
# CHECK-INST: vfwcvt.f.xu.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x85,0x8a]

vfwcvt.f.x.v v4, v8
# CHECK-INST: vfwcvt.f.x.v	v4, v8
# CHECK-ENCODING: [0x57,0x92,0x85,0x8a]

vfwcvt.f.f.v v4, v8
# CHECK-INST: vfwcvt.f.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x86,0x8a]

vfwcvt.xu.f.v v4, v8, v0.t
# CHECK-INST: vfwcvt.xu.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x84,0x88]

vfwcvt.x.f.v v4, v8, v0.t
# CHECK-INST: vfwcvt.x.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x92,0x84,0x88]

vfwcvt.f.xu.v v4, v8, v0.t
# CHECK-INST: vfwcvt.f.xu.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x85,0x88]

vfwcvt.f.x.v v4, v8, v0.t
# CHECK-INST: vfwcvt.f.x.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x92,0x85,0x88]

vfwcvt.f.f.v v4, v8, v0.t
# CHECK-INST: vfwcvt.f.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x88]

vfncvt.xu.f.v v4, v8
# CHECK-INST: vfncvt.xu.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x88,0x8a]

vfncvt.x.f.v v4, v8
# CHECK-INST: vfncvt.x.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x92,0x88,0x8a]

vfncvt.f.xu.v v4, v8
# CHECK-INST: vfncvt.f.xu.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x89,0x8a]

vfncvt.f.x.v v4, v8
# CHECK-INST: vfncvt.f.x.v	v4, v8
# CHECK-ENCODING: [0x57,0x92,0x89,0x8a]

vfncvt.f.f.v v4, v8
# CHECK-INST: vfncvt.f.f.v	v4, v8
# CHECK-ENCODING: [0x57,0x12,0x8a,0x8a]

vfncvt.xu.f.v v4, v8, v0.t
# CHECK-INST: vfncvt.xu.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x88,0x88]

vfncvt.x.f.v v4, v8, v0.t
# CHECK-INST: vfncvt.x.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x92,0x88,0x88]

vfncvt.f.xu.v v4, v8, v0.t
# CHECK-INST: vfncvt.f.xu.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x89,0x88]

vfncvt.f.x.v v4, v8, v0.t
# CHECK-INST: vfncvt.f.x.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x92,0x89,0x88]

vfncvt.f.f.v v4, v8, v0.t
# CHECK-INST: vfncvt.f.f.v	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x12,0x8a,0x88]

vredsum.vs v4, v8, v12
# CHECK-INST: vredsum.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x02]

vredmaxu.vs v4, v8, v8
# CHECK-INST: vredmaxu.vs	v4, v8, v8
# CHECK-ENCODING: [0x57,0x22,0x84,0x1a]

vredmax.vs v4, v8, v8
# CHECK-INST: vredmax.vs	v4, v8, v8
# CHECK-ENCODING: [0x57,0x22,0x84,0x1e]

vredminu.vs v4, v8, v8
# CHECK-INST: vredminu.vs	v4, v8, v8
# CHECK-ENCODING: [0x57,0x22,0x84,0x12]

vredmin.vs v4, v8, v8
# CHECK-INST: vredmin.vs	v4, v8, v8
# CHECK-ENCODING: [0x57,0x22,0x84,0x16]

vredand.vs v4, v8, v12
# CHECK-INST: vredand.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x06]

vredor.vs v4, v8, v12
# CHECK-INST: vredor.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x0a]

vredxor.vs v4, v8, v12
# CHECK-INST: vredxor.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x0e]

vredsum.vs v4, v8, v12, v0.t
# CHECK-INST: vredsum.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x00]

vredmaxu.vs v4, v8, v8, v0.t
# CHECK-INST: vredmaxu.vs	v4, v8, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x84,0x18]

vredmax.vs v4, v8, v8, v0.t
# CHECK-INST: vredmax.vs	v4, v8, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x84,0x1c]

vredminu.vs v4, v8, v8, v0.t
# CHECK-INST: vredminu.vs	v4, v8, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x84,0x10]

vredmin.vs v4, v8, v8, v0.t
# CHECK-INST: vredmin.vs	v4, v8, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x84,0x14]

vredand.vs v4, v8, v12, v0.t
# CHECK-INST: vredand.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x04]

vredor.vs v4, v8, v12, v0.t
# CHECK-INST: vredor.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x08]

vredxor.vs v4, v8, v12, v0.t
# CHECK-INST: vredxor.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x22,0x86,0x0c]

vwredsumu.vs v4, v8, v12
# CHECK-INST: vwredsumu.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xc2]

vwredsum.vs v4, v8, v12
# CHECK-INST: vwredsum.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0xc6]

vwredsumu.vs v4, v8, v12, v0.t
# CHECK-INST: vwredsumu.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xc0]

vwredsum.vs v4, v8, v12, v0.t
# CHECK-INST: vwredsum.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0xc4]

vfredosum.vs v4, v8, v12
# CHECK-INST: vfredosum.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x0e]

vfredsum.vs v4, v8, v12
# CHECK-INST: vfredsum.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x06]

vfredmax.vs v4, v8, v12
# CHECK-INST: vfredmax.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x1e]

vfredmin.vs v4, v8, v12
# CHECK-INST: vfredmin.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0x16]

vfredosum.vs v4, v8, v12, v0.t
# CHECK-INST: vfredosum.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x0c]

vfredsum.vs v4, v8, v12, v0.t
# CHECK-INST: vfredsum.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x04]

vfredmax.vs v4, v8, v12, v0.t
# CHECK-INST: vfredmax.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x1c]

vfredmin.vs v4, v8, v12, v0.t
# CHECK-INST: vfredmin.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0x14]

vfwredosum.vs v4, v8, v12
# CHECK-INST: vfwredosum.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xce]

vfwredsum.vs v4, v8, v12
# CHECK-INST: vfwredsum.vs	v4, v8, v12
# CHECK-ENCODING: [0x57,0x12,0x86,0xc6]

vfwredosum.vs v4, v8, v12, v0.t
# CHECK-INST: vfwredosum.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xcc]

vfwredsum.vs v4, v8, v12, v0.t
# CHECK-INST: vfwredsum.vs	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x12,0x86,0xc4]

vmcpy.m v4, v8
# CHECK-INST: vmcpy.m v4, v8
# CHECK-ENCODING: [0x57,0x22,0x84,0x66]

vmclr.m v4
# CHECK-INST: vmclr.m v4
# CHECK-ENCODING: [0x57,0x22,0x42,0x6e]

vmset.m v4
# CHECK-INST: vmset.m v4
# CHECK-ENCODING: [0x57,0x22,0x42,0x7e]

vmnot.m v4, v8
# CHECK-INST: vmnot.m v4, v8
# CHECK-ENCODING: [0x57,0x22,0x84,0x76]

vmand.mm v4, v8, v12
# CHECK-INST: vmand.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x66]

vmnand.mm v4, v8, v12
# CHECK-INST: vmnand.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x76]

vmandnot.mm v4, v8, v12
# CHECK-INST: vmandnot.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x62]

vmxor.mm v4, v8, v12
# CHECK-INST: vmxor.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x6e]

vmor.mm v4, v8, v12
# CHECK-INST: vmor.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x6a]

vmnor.mm v4, v8, v12
# CHECK-INST: vmnor.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x7a]

vmornot.mm v4, v8, v12
# CHECK-INST: vmornot.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x72]

vmxnor.mm v4, v8, v12
# CHECK-INST: vmxnor.mm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x7e]

vmpopc.m a0, v12
# CHECK-INST: vmpopc.m	a0, v12
# CHECK-ENCODING: [0x57,0x25,0xc0,0x52]

vmfirst.m a0, v12
# CHECK-INST: vmfirst.m	a0, v12
# CHECK-ENCODING: [0x57,0x25,0xc0,0x56]

vmsbf.m v4, v8
# CHECK-INST: vmsbf.m	v4, v8
# CHECK-ENCODING: [0x57,0xa2,0x80,0x5a]

vmsif.m v4, v8
# CHECK-INST: vmsif.m	v4, v8
# CHECK-ENCODING: [0x57,0xa2,0x81,0x5a]

vmsof.m v4, v8
# CHECK-INST: vmsof.m	v4, v8
# CHECK-ENCODING: [0x57,0x22,0x81,0x5a]

viota.m v4, v8
# CHECK-INST: viota.m	v4, v8
# CHECK-ENCODING: [0x57,0x22,0x88,0x5a]

vid.v v4
# CHECK-INST: vid.v	v4
# CHECK-ENCODING: [0x57,0xa2,0x08,0x5a]

vmpopc.m a0, v12, v0.t
# CHECK-INST: vmpopc.m	a0, v12, v0.t
# CHECK-ENCODING: [0x57,0x25,0xc0,0x50]

vmfirst.m a0, v12, v0.t
# CHECK-INST: vmfirst.m	a0, v12, v0.t
# CHECK-ENCODING: [0x57,0x25,0xc0,0x54]

vmsbf.m v4, v8, v0.t
# CHECK-INST: vmsbf.m	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0xa2,0x80,0x58]

vmsif.m v4, v8, v0.t
# CHECK-INST: vmsif.m	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0xa2,0x81,0x58]

vmsof.m v4, v8, v0.t
# CHECK-INST: vmsof.m	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x81,0x58]

viota.m v4, v8, v0.t
# CHECK-INST: viota.m	v4, v8, v0.t
# CHECK-ENCODING: [0x57,0x22,0x88,0x58]

vid.v v4, v0.t
# CHECK-INST: vid.v	v4, v0.t
# CHECK-ENCODING: [0x57,0xa2,0x08,0x58]

vmv.x.s a0, v12
# CHECK-INST: vmv.x.s a0, v12
# CHECK-ENCODING: [0x57,0x25,0xc0,0x32]

vext.x.v a0, v12, a2
# CHECK-INST: vext.x.v	a0, v12, a2
# CHECK-ENCODING: [0x57,0x25,0xc6,0x32]

vmv.s.x v4, a0
# CHECK-INST: vmv.s.x	v4, a0
# CHECK-ENCODING: [0x57,0x62,0x05,0x36]

vfmv.f.s fa0, v8
# CHECK-INST: vfmv.f.s	fa0, v8
# CHECK-ENCODING: [0x57,0x15,0x80,0x32]

vfmv.s.f v4, fa1
# CHECK-INST: vfmv.s.f	v4, fa1
# CHECK-ENCODING: [0x57,0xd2,0x05,0x36]

vslideup.vx v4, v8, a1
# CHECK-INST: vslideup.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x3a]

vslideup.vi v4, v8, 0
# CHECK-INST: vslideup.vi	v4, v8, 0
# CHECK-ENCODING: [0x57,0x32,0x80,0x3a]

vslideup.vi v4, v8, 31
# CHECK-INST: vslideup.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x3a]

vslidedown.vx v4, v8, a1
# CHECK-INST: vslidedown.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x3e]

vslidedown.vi v4, v8, 0
# CHECK-INST: vslidedown.vi	v4, v8, 0
# CHECK-ENCODING: [0x57,0x32,0x80,0x3e]

vslidedown.vi v4, v8, 31
# CHECK-INST: vslidedown.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x3e]

vslideup.vx v4, v8, a1, v0.t
# CHECK-INST: vslideup.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x38]

vslideup.vi v4, v8, 0, v0.t
# CHECK-INST: vslideup.vi	v4, v8, 0, v0.t
# CHECK-ENCODING: [0x57,0x32,0x80,0x38]

vslideup.vi v4, v8, 31, v0.t
# CHECK-INST: vslideup.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x38]

vslidedown.vx v4, v8, a1, v0.t
# CHECK-INST: vslidedown.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x3c]

vslidedown.vi v4, v8, 0, v0.t
# CHECK-INST: vslidedown.vi	v4, v8, 0, v0.t
# CHECK-ENCODING: [0x57,0x32,0x80,0x3c]

vslidedown.vi v4, v8, 31, v0.t
# CHECK-INST: vslidedown.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x3c]

vslide1up.vx v4, v8, a1
# CHECK-INST: vslide1up.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x3a]

vslide1down.vx v4, v8, a1
# CHECK-INST: vslide1down.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xe2,0x85,0x3e]

vslide1up.vx v4, v8, a1, v0.t
# CHECK-INST: vslide1up.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x38]

vslide1down.vx v4, v8, a1, v0.t
# CHECK-INST: vslide1down.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xe2,0x85,0x3c]

vrgather.vv v4, v8, v12
# CHECK-INST: vrgather.vv	v4, v8, v12
# CHECK-ENCODING: [0x57,0x02,0x86,0x32]

vrgather.vx v4, v8, a1
# CHECK-INST: vrgather.vx	v4, v8, a1
# CHECK-ENCODING: [0x57,0xc2,0x85,0x32]

vrgather.vi v4, v8, 0
# CHECK-INST: vrgather.vi	v4, v8, 0
# CHECK-ENCODING: [0x57,0x32,0x80,0x32]

vrgather.vi v4, v8, 31
# CHECK-INST: vrgather.vi	v4, v8, 31
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x32]

vrgather.vv v4, v8, v12, v0.t
# CHECK-INST: vrgather.vv	v4, v8, v12, v0.t
# CHECK-ENCODING: [0x57,0x02,0x86,0x30]

vrgather.vx v4, v8, a1, v0.t
# CHECK-INST: vrgather.vx	v4, v8, a1, v0.t
# CHECK-ENCODING: [0x57,0xc2,0x85,0x30]

vrgather.vi v4, v8, 0, v0.t
# CHECK-INST: vrgather.vi	v4, v8, 0, v0.t
# CHECK-ENCODING: [0x57,0x32,0x80,0x30]

vrgather.vi v4, v8, 31, v0.t
# CHECK-INST: vrgather.vi	v4, v8, 31, v0.t
# CHECK-ENCODING: [0x57,0xb2,0x8f,0x30]

vcompress.vm v4, v8, v12
# CHECK-INST: vcompress.vm	v4, v8, v12
# CHECK-ENCODING: [0x57,0x22,0x86,0x5e]

csrr a0, vstart
# CHECK-INST: csrr	a0, vstart
# CHECK-ENCODING: [0x73,0x25,0x80,0x00]

csrr a0, vxsat
# CHECK-INST: csrr	a0, vxsat
# CHECK-ENCODING: [0x73,0x25,0x90,0x00]

csrr a0, vxrm
# CHECK-INST: csrr	a0, vxrm
# CHECK-ENCODING: [0x73,0x25,0xa0,0x00]

csrr a0, vl
# CHECK-INST: csrr	a0, vl
# CHECK-ENCODING: [0x73,0x25,0x00,0xc2]

csrr a0, vtype
# CHECK-INST: csrr	a0, vtype
# CHECK-ENCODING: [0x73,0x25,0x10,0xc2]
