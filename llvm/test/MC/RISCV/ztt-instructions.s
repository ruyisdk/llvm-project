# RUN: llvm-mc -triple=riscv32 -show-encoding -mattr=+ztt %s \
# RUN:   | FileCheck %s --check-prefixes=CHECK-ASM,CHECK-ENCODING
# RUN: llvm-mc -triple=riscv32 -filetype=obj -mattr=+ztt %s \
# RUN:   | llvm-objdump -d --mattr=+ztt - | FileCheck %s --check-prefix=CHECK-ASM
# RUN: not llvm-mc -triple=riscv32 -show-encoding %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=CHECK-ERROR

# RUN: llvm-mc -triple=riscv64 -show-encoding -mattr=+ztt %s \
# RUN:   | FileCheck %s --check-prefixes=CHECK-ASM,CHECK-ENCODING
# RUN: llvm-mc -triple=riscv64 -filetype=obj -mattr=+ztt %s \
# RUN:   | llvm-objdump -d --mattr=+ztt - | FileCheck %s --check-prefix=CHECK-ASM
# RUN: not llvm-mc -triple=riscv64 -show-encoding %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=CHECK-ERROR

madd.ew m0, m1, m2
# CHECK-ASM: madd.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x04]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

madd.ew m31, m30, m29
# CHECK-ASM: madd.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x05]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

madd.ew m0, m0, m0
# CHECK-ASM: madd.ew m0, m0, m0
# CHECK-ENCODING: [0x2b,0x00,0x00,0x04]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

madd.ew.x m0, a0, m2
# CHECK-ASM: madd.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x06]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

madd.ew.x m31, t6, m31
# CHECK-ASM: madd.ew.x m31, t6, m31
# CHECK-ENCODING: [0xab,0x8f,0xff,0x07]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

madd.ew.x m0, zero, m0
# CHECK-ASM: madd.ew.x m0, zero, m0
# CHECK-ENCODING: [0x2b,0x00,0x00,0x06]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

ame.acquire a1, a0
# CHECK-ASM: ame.acquire a1, a0
# CHECK-ENCODING: [0xab,0x05,0x95,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

ame.acquire a0, a0
# CHECK-ASM: ame.acquire a0, a0
# CHECK-ENCODING: [0x2b,0x05,0x95,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

ame.acquire t6, zero
# CHECK-ASM: ame.acquire t6, zero
# CHECK-ENCODING: [0xab,0x0f,0x90,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

ame.acquire zero, t6
# CHECK-ASM: ame.acquire zero, t6
# CHECK-ENCODING: [0x2b,0x80,0x9f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

ame.release
# CHECK-ASM: ame.release
# CHECK-ENCODING: [0x2b,0x00,0xa0,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m0, zero
# CHECK-ASM: mls.1r m0, zero
# CHECK-ENCODING: [0x2b,0x00,0x60,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m1, ra
# CHECK-ASM: mls.1r m1, ra
# CHECK-ENCODING: [0xab,0x80,0x60,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m2, sp
# CHECK-ASM: mls.1r m2, sp
# CHECK-ENCODING: [0x2b,0x01,0x61,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m3, gp
# CHECK-ASM: mls.1r m3, gp
# CHECK-ENCODING: [0xab,0x81,0x61,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m15, a0
# CHECK-ASM: mls.1r m15, a0
# CHECK-ENCODING: [0xab,0x07,0x65,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m16, a1
# CHECK-ASM: mls.1r m16, a1
# CHECK-ENCODING: [0x2b,0x88,0x65,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m30, t5
# CHECK-ASM: mls.1r m30, t5
# CHECK-ENCODING: [0x2b,0x0f,0x6f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.1r m31, t6
# CHECK-ASM: mls.1r m31, t6
# CHECK-ENCODING: [0xab,0x8f,0x6f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m0, zero
# CHECK-ASM: mss.1r m0, zero
# CHECK-ENCODING: [0x2b,0x00,0x90,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m1, ra
# CHECK-ASM: mss.1r m1, ra
# CHECK-ENCODING: [0xab,0x80,0x90,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m2, sp
# CHECK-ASM: mss.1r m2, sp
# CHECK-ENCODING: [0x2b,0x01,0x91,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m3, gp
# CHECK-ASM: mss.1r m3, gp
# CHECK-ENCODING: [0xab,0x81,0x91,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m15, a0
# CHECK-ASM: mss.1r m15, a0
# CHECK-ENCODING: [0xab,0x07,0x95,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m16, a1
# CHECK-ASM: mss.1r m16, a1
# CHECK-ENCODING: [0x2b,0x88,0x95,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m30, t5
# CHECK-ASM: mss.1r m30, t5
# CHECK-ENCODING: [0x2b,0x0f,0x9f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.1r m31, t6
# CHECK-ASM: mss.1r m31, t6
# CHECK-ENCODING: [0xab,0x8f,0x9f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.rm m0, a0
# CHECK-ASM: mls.rm m0, a0
# CHECK-ENCODING: [0x2b,0x00,0x85,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.cm m7, s1
# CHECK-ASM: mls.cm m7, s1
# CHECK-ENCODING: [0xab,0x83,0x74,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.rm m31, a1
# CHECK-ASM: mss.rm m31, a1
# CHECK-ENCODING: [0xab,0x8f,0xb5,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.cm m16, s2
# CHECK-ASM: mss.cm m16, s2
# CHECK-ENCODING: [0x2b,0x08,0xa9,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmov.m.m m0, m1
# CHECK-ASM: mmov.m.m m0, m1
# CHECK-ENCODING: [0x2b,0x80,0xe0,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmov.m.m m31, m16
# CHECK-ASM: mmov.m.m m31, m16
# CHECK-ENCODING: [0xab,0x0f,0xe8,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mgettyp a0, m1
# CHECK-ASM: mgettyp a0, m1
# CHECK-ENCODING: [0x2b,0x85,0x20,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msettyp m0, a0
# CHECK-ASM: msettyp m0, a0
# CHECK-ENCODING: [0x2b,0x00,0x35,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msettyp m31, t6
# CHECK-ASM: msettyp m31, t6
# CHECK-ENCODING: [0xab,0x8f,0x3f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

agettyp a0, acc1
# CHECK-ASM: agettyp a0, acc1
# CHECK-ENCODING: [0x2b,0x85,0x00,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

agettyp t6, acc15
# CHECK-ASM: agettyp t6, acc15
# CHECK-ENCODING: [0xab,0x8f,0x07,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

asettyp acc0, a0
# CHECK-ASM: asettyp acc0, a0
# CHECK-ENCODING: [0x2b,0x00,0x15,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

asettyp acc15, t6
# CHECK-ASM: asettyp acc15, t6
# CHECK-ENCODING: [0xab,0x87,0x1f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmov.m.a m0, acc1
# CHECK-ASM: mmov.m.a m0, acc1
# CHECK-ENCODING: [0x2b,0x80,0xc0,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmov.m.a m31, acc15
# CHECK-ASM: mmov.m.a m31, acc15
# CHECK-ENCODING: [0xab,0x8f,0xc7,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmov.a.m acc0, m1
# CHECK-ASM: mmov.a.m acc0, m1
# CHECK-ENCODING: [0x2b,0x80,0xd0,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmov.a.m acc15, m31
# CHECK-ASM: mmov.a.m acc15, m31
# CHECK-ENCODING: [0xab,0x87,0xdf,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulacc.2d acc0, m1, m2
# CHECK-ASM: mmulacc.2d acc0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x94]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulacc.2d acc15, m30, m31
# CHECK-ASM: mmulacc.2d acc15, m30, m31
# CHECK-ENCODING: [0xab,0x07,0xff,0x95]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mzero.2d.m m0
# CHECK-ASM: mzero.2d.m m0
# CHECK-ENCODING: [0x2b,0x80,0x00,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mzero.2d.m m17
# CHECK-ASM: mzero.2d.m m17
# CHECK-ENCODING: [0xab,0x88,0x00,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mzero.2d.m m31
# CHECK-ASM: mzero.2d.m m31
# CHECK-ENCODING: [0xab,0x8f,0x00,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mzero.2d.acc acc0
# CHECK-ASM: mzero.2d.acc acc0
# CHECK-ENCODING: [0x2b,0x00,0x00,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mzero.2d.acc acc15
# CHECK-ASM: mzero.2d.acc acc15
# CHECK-ENCODING: [0xab,0x07,0x00,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulaccneg.2d acc0, m1, m2
# CHECK-ASM: mmulaccneg.2d acc0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x96]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulaccneg.2d acc15, m30, m31
# CHECK-ASM: mmulaccneg.2d acc15, m30, m31
# CHECK-ENCODING: [0xab,0x07,0xff,0x97]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulatacc.2d acc0, m1, m2
# CHECK-ASM: mmulatacc.2d acc0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x9a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulatacc.2d acc15, m30, m31
# CHECK-ASM: mmulatacc.2d acc15, m30, m31
# CHECK-ENCODING: [0xab,0x07,0xff,0x9b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulataccneg.2d acc0, m1, m2
# CHECK-ASM: mmulataccneg.2d acc0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x9c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulataccneg.2d acc15, m30, m31
# CHECK-ASM: mmulataccneg.2d acc15, m30, m31
# CHECK-ENCODING: [0xab,0x07,0xff,0x9d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulbtacc.2d acc0, m1, m2
# CHECK-ASM: mmulbtacc.2d acc0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x9e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulbtacc.2d acc15, m30, m31
# CHECK-ASM: mmulbtacc.2d acc15, m30, m31
# CHECK-ENCODING: [0xab,0x07,0xff,0x9f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulbtaccneg.2d acc0, m1, m2
# CHECK-ASM: mmulbtaccneg.2d acc0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0xa0]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulbtaccneg.2d acc15, m30, m31
# CHECK-ASM: mmulbtaccneg.2d acc15, m30, m31
# CHECK-ENCODING: [0xab,0x07,0xff,0xa1]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)
mabsdiff.ew m0, m1, m2
# CHECK-ASM: mabsdiff.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x00]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mabsdiff.ew m31, m30, m29
# CHECK-ASM: mabsdiff.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x01]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mhdiff.ew m0, m1, m2
# CHECK-ASM: mhdiff.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x08]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mhdiff.ew m31, m30, m29
# CHECK-ASM: mhdiff.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x09]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmean.ew m0, m1, m2
# CHECK-ASM: mmean.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x10]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmean.ew m31, m30, m29
# CHECK-ASM: mmean.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x11]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmul.ew m0, m1, m2
# CHECK-ASM: mmul.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x18]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmul.ew m31, m30, m29
# CHECK-ASM: mmul.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x19]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulneg.ew m0, m1, m2
# CHECK-ASM: mmulneg.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x28]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulneg.ew m31, m30, m29
# CHECK-ASM: mmulneg.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x29]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msub.ew m0, m1, m2
# CHECK-ASM: msub.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x30]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msub.ew m31, m30, m29
# CHECK-ASM: msub.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x31]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)
mabsdiff.ew.x m0, a0, m1
# CHECK-ASM: mabsdiff.ew.x m0, a0, m1
# CHECK-ENCODING: [0x2b,0x00,0x15,0x02]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mabsdiff.ew.x m31, t6, m30
# CHECK-ASM: mabsdiff.ew.x m31, t6, m30
# CHECK-ENCODING: [0xab,0x8f,0xef,0x03]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mhdiff.ew.x m0, a0, m1
# CHECK-ASM: mhdiff.ew.x m0, a0, m1
# CHECK-ENCODING: [0x2b,0x00,0x15,0x0a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mhdiff.ew.x m31, t6, m30
# CHECK-ASM: mhdiff.ew.x m31, t6, m30
# CHECK-ENCODING: [0xab,0x8f,0xef,0x0b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmean.ew.x m0, a0, m1
# CHECK-ASM: mmean.ew.x m0, a0, m1
# CHECK-ENCODING: [0x2b,0x00,0x15,0x12]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmean.ew.x m31, t6, m30
# CHECK-ASM: mmean.ew.x m31, t6, m30
# CHECK-ENCODING: [0xab,0x8f,0xef,0x13]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmul.ew.x m0, a0, m1
# CHECK-ASM: mmul.ew.x m0, a0, m1
# CHECK-ENCODING: [0x2b,0x00,0x15,0x1a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmul.ew.x m31, t6, m30
# CHECK-ASM: mmul.ew.x m31, t6, m30
# CHECK-ENCODING: [0xab,0x8f,0xef,0x1b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulneg.ew.x m0, a0, m1
# CHECK-ASM: mmulneg.ew.x m0, a0, m1
# CHECK-ENCODING: [0x2b,0x00,0x15,0x2a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulneg.ew.x m31, t6, m30
# CHECK-ASM: mmulneg.ew.x m31, t6, m30
# CHECK-ENCODING: [0xab,0x8f,0xef,0x2b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msub.ew.x m0, a0, m1
# CHECK-ASM: msub.ew.x m0, a0, m1
# CHECK-ENCODING: [0x2b,0x00,0x15,0x32]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msub.ew.x m31, t6, m30
# CHECK-ASM: msub.ew.x m31, t6, m30
# CHECK-ENCODING: [0xab,0x8f,0xef,0x33]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)
mabs.ew m0, m1
# CHECK-ASM: mabs.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x40,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mabs.ew m31, m30
# CHECK-ASM: mabs.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x4f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mconv.ew m0, m1
# CHECK-ASM: mconv.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0xd0,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mconv.ew m31, m30
# CHECK-ASM: mconv.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0xdf,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mexp2.ew m0, m1
# CHECK-ASM: mexp2.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0xf0,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mexp2.ew m31, m30
# CHECK-ASM: mexp2.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0xff,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mlog2.ew m0, m1
# CHECK-ASM: mlog2.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x00,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mlog2.ew m31, m30
# CHECK-ASM: mlog2.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x0f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcos.ew m0, m1
# CHECK-ASM: mcos.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0xe0,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcos.ew m31, m30
# CHECK-ASM: mcos.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0xef,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msin.ew m0, m1
# CHECK-ASM: msin.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x30,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msin.ew m31, m30
# CHECK-ASM: msin.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x3f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mtanh.ew m0, m1
# CHECK-ASM: mtanh.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x50,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mtanh.ew m31, m30
# CHECK-ASM: mtanh.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x5f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrec.ew m0, m1
# CHECK-ASM: mrec.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x10,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrec.ew m31, m30
# CHECK-ASM: mrec.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x1f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrsqrt.ew m0, m1
# CHECK-ASM: mrsqrt.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x20,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrsqrt.ew m31, m30
# CHECK-ASM: mrsqrt.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x2f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msqrt.ew m0, m1
# CHECK-ASM: msqrt.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x40,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msqrt.ew m31, m30
# CHECK-ASM: msqrt.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x4f,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmax.ew m0, m1, m2
# CHECK-ASM: mmax.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x0c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmax.ew m31, m30, m29
# CHECK-ASM: mmax.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x0d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmax.ew.x m0, a0, m2
# CHECK-ASM: mmax.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x0e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmax.ew.x m31, t6, m29
# CHECK-ASM: mmax.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x0f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmin.ew m0, m1, m2
# CHECK-ASM: mmin.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x14]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmin.ew m31, m30, m29
# CHECK-ASM: mmin.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x15]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmin.ew.x m0, a0, m2
# CHECK-ASM: mmin.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x16]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmin.ew.x m31, t6, m29
# CHECK-ASM: mmin.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x17]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mand.ew m0, m1, m2
# CHECK-ASM: mand.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x34]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mand.ew m31, m30, m29
# CHECK-ASM: mand.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x35]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mand.ew.x m0, a0, m2
# CHECK-ASM: mand.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x36]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mand.ew.x m31, t6, m29
# CHECK-ASM: mand.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x37]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mandnot.ew m0, m1, m2
# CHECK-ASM: mandnot.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x38]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mandnot.ew m31, m30, m29
# CHECK-ASM: mandnot.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x39]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mandnot.ew.x m0, a0, m2
# CHECK-ASM: mandnot.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x3a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mandnot.ew.x m31, t6, m29
# CHECK-ASM: mandnot.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x3b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mor.ew m0, m1, m2
# CHECK-ASM: mor.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x3c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mor.ew m31, m30, m29
# CHECK-ASM: mor.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x3d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mor.ew.x m0, a0, m2
# CHECK-ASM: mor.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x3e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mor.ew.x m31, t6, m29
# CHECK-ASM: mor.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x3f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mornot.ew m0, m1, m2
# CHECK-ASM: mornot.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x40]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mornot.ew m31, m30, m29
# CHECK-ASM: mornot.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x41]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mornot.ew.x m0, a0, m2
# CHECK-ASM: mornot.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x42]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mornot.ew.x m31, t6, m29
# CHECK-ASM: mornot.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x43]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mxor.ew m0, m1, m2
# CHECK-ASM: mxor.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x50]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mxor.ew m31, m30, m29
# CHECK-ASM: mxor.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x51]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mxor.ew.x m0, a0, m2
# CHECK-ASM: mxor.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x52]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mxor.ew.x m31, t6, m29
# CHECK-ASM: mxor.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x53]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msll.ew m0, m1, m2
# CHECK-ASM: msll.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x44]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msll.ew m31, m30, m29
# CHECK-ASM: msll.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x45]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msll.ew.x m0, a0, m2
# CHECK-ASM: msll.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x46]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msll.ew.x m31, t6, m29
# CHECK-ASM: msll.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x47]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msrl.ew m0, m1, m2
# CHECK-ASM: msrl.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x4c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msrl.ew m31, m30, m29
# CHECK-ASM: msrl.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x4d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msrl.ew.x m0, a0, m2
# CHECK-ASM: msrl.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x4e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msrl.ew.x m31, t6, m29
# CHECK-ASM: msrl.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x4f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msra.ew m0, m1, m2
# CHECK-ASM: msra.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x48]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msra.ew m31, m30, m29
# CHECK-ASM: msra.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x49]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msra.ew.x m0, a0, m2
# CHECK-ASM: msra.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x4a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msra.ew.x m31, t6, m29
# CHECK-ASM: msra.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x4b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmpge.ew m0, m1, m2
# CHECK-ASM: mcmpge.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x58]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmpge.ew m31, m30, m29
# CHECK-ASM: mcmpge.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x59]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmpge.ew.x m0, a0, m2
# CHECK-ASM: mcmpge.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x5a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmpge.ew.x m31, t6, m29
# CHECK-ASM: mcmpge.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x5b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmplt.ew m0, m1, m2
# CHECK-ASM: mcmplt.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x5c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmplt.ew m31, m30, m29
# CHECK-ASM: mcmplt.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x5d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmplt.ew.x m0, a0, m2
# CHECK-ASM: mcmplt.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x5e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmplt.ew.x m31, t6, m29
# CHECK-ASM: mcmplt.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x5f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintm.ew m0, m1
# CHECK-ASM: mfrintm.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x50,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintm.ew m31, m30
# CHECK-ASM: mfrintm.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x5f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintn.ew m0, m1
# CHECK-ASM: mfrintn.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x60,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintn.ew m31, m30
# CHECK-ASM: mfrintn.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x6f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintp.ew m0, m1
# CHECK-ASM: mfrintp.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x70,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintp.ew m31, m30
# CHECK-ASM: mfrintp.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x7f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintz.ew m0, m1
# CHECK-ASM: mfrintz.ew m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x80,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mfrintz.ew m31, m30
# CHECK-ASM: mfrintz.ew m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x8f,0xa2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mselge.ew m0, m1, m2
# CHECK-ASM: mselge.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x60]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mselge.ew m31, m30, m29
# CHECK-ASM: mselge.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x61]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msellt.ew m0, m1, m2
# CHECK-ASM: msellt.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x62]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msellt.ew m31, m30, m29
# CHECK-ASM: msellt.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x63]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmovge.ew m0, m1, m2
# CHECK-ASM: mcmovge.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x54]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmovge.ew m31, m30, m29
# CHECK-ASM: mcmovge.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x55]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmovlt.ew m0, m1, m2
# CHECK-ASM: mcmovlt.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x56]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcmovlt.ew m31, m30, m29
# CHECK-ASM: mcmovlt.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x57]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulacc.ew m0, m1, m2
# CHECK-ASM: mmulacc.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x1c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulacc.ew m31, m30, m29
# CHECK-ASM: mmulacc.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x1d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulacc.ew.x m0, a0, m2
# CHECK-ASM: mmulacc.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x1e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulacc.ew.x m31, t6, m29
# CHECK-ASM: mmulacc.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x1f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulaccneg.ew m0, m1, m2
# CHECK-ASM: mmulaccneg.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x20]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulaccneg.ew m31, m30, m29
# CHECK-ASM: mmulaccneg.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x21]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulaccneg.ew.x m0, a0, m2
# CHECK-ASM: mmulaccneg.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x22]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulaccneg.ew.x m31, t6, m29
# CHECK-ASM: mmulaccneg.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x23]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmuladd.ew m0, m1, m2
# CHECK-ASM: mmuladd.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x24]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmuladd.ew m31, m30, m29
# CHECK-ASM: mmuladd.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x25]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmuladd.ew.x m0, a0, m2
# CHECK-ASM: mmuladd.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x26]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmuladd.ew.x m31, t6, m29
# CHECK-ASM: mmuladd.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x27]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulsub.ew m0, m1, m2
# CHECK-ASM: mmulsub.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x2c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulsub.ew m31, m30, m29
# CHECK-ASM: mmulsub.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x2d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulsub.ew.x m0, a0, m2
# CHECK-ASM: mmulsub.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x2e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mmulsub.ew.x m31, t6, m29
# CHECK-ASM: mmulsub.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x2f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexp.ew m0, m1, m2
# CHECK-ASM: mldexp.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x7e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexp.ew m31, m30, m29
# CHECK-ASM: mldexp.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x7f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexp.ew.x m0, a0, m2
# CHECK-ASM: mldexp.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x80]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexp.ew.x m31, t6, m29
# CHECK-ASM: mldexp.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x81]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexpacc.ew m0, m1, m2
# CHECK-ASM: mldexpacc.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x82]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexpacc.ew m31, m30, m29
# CHECK-ASM: mldexpacc.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x83]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexpacc.ew.x m0, a0, m2
# CHECK-ASM: mldexpacc.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x84]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mldexpacc.ew.x m31, t6, m29
# CHECK-ASM: mldexpacc.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x85]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrdexp.ew m0, m1, m2
# CHECK-ASM: mrdexp.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x8a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrdexp.ew m31, m30, m29
# CHECK-ASM: mrdexp.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x8b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrdexpacc.ew m0, m1, m2
# CHECK-ASM: mrdexpacc.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x8c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrdexpacc.ew m31, m30, m29
# CHECK-ASM: mrdexpacc.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x8d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mlog2sub.ew m0, m1, m2
# CHECK-ASM: mlog2sub.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x86]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mlog2sub.ew m31, m30, m29
# CHECK-ASM: mlog2sub.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x87]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mlog2sub.ew.x m0, a0, m2
# CHECK-ASM: mlog2sub.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x88]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mlog2sub.ew.x m31, t6, m29
# CHECK-ASM: mlog2sub.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x89]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msublog2.ew m0, m1, m2
# CHECK-ASM: msublog2.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x8e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msublog2.ew m31, m30, m29
# CHECK-ASM: msublog2.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x8f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msublog2.ew.x m0, a0, m2
# CHECK-ASM: msublog2.ew.x m0, a0, m2
# CHECK-ENCODING: [0x2b,0x00,0x25,0x90]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

msublog2.ew.x m31, t6, m29
# CHECK-ASM: msublog2.ew.x m31, t6, m29
# CHECK-ENCODING: [0xab,0x8f,0xdf,0x91]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixadd.col m0, m1
# CHECK-ASM: mprefixadd.col m0, m1
# CHECK-ENCODING: [0x2b,0x80,0xf0,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixadd.row m0, m1
# CHECK-ASM: mprefixadd.row m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x00,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixmax.col m0, m1
# CHECK-ASM: mprefixmax.col m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x10,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixmax.row m0, m1
# CHECK-ASM: mprefixmax.row m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x20,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreduceadd.col m0, m1
# CHECK-ASM: mreduceadd.col m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x30,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreduceadd.row m0, m1
# CHECK-ASM: mreduceadd.row m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x40,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemax.col m0, m1
# CHECK-ASM: mreducemax.col m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x50,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemax.row m0, m1
# CHECK-ASM: mreducemax.row m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x60,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemin.col m0, m1
# CHECK-ASM: mreducemin.col m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x70,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemin.row m0, m1
# CHECK-ASM: mreducemin.row m0, m1
# CHECK-ENCODING: [0x2b,0x80,0x80,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixadd.col m31, m30
# CHECK-ASM: mprefixadd.col m31, m30
# CHECK-ENCODING: [0xab,0x0f,0xff,0xa3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixadd.row m31, m30
# CHECK-ASM: mprefixadd.row m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x0f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixmax.col m31, m30
# CHECK-ASM: mprefixmax.col m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x1f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mprefixmax.row m31, m30
# CHECK-ASM: mprefixmax.row m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x2f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreduceadd.col m31, m30
# CHECK-ASM: mreduceadd.col m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x3f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreduceadd.row m31, m30
# CHECK-ASM: mreduceadd.row m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x4f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemax.col m31, m30
# CHECK-ASM: mreducemax.col m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x5f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemax.row m31, m30
# CHECK-ASM: mreducemax.row m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x6f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemin.col m31, m30
# CHECK-ASM: mreducemin.col m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x7f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mreducemin.row m31, m30
# CHECK-ASM: mreducemin.row m31, m30
# CHECK-ENCODING: [0xab,0x0f,0x8f,0xa4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolbcast.ew.x m0, a1, m2
# CHECK-ASM: mcolbcast.ew.x m0, a1, m2
# CHECK-ENCODING: [0x2b,0x80,0x25,0x64]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowbcast.ew.x m0, a1, m2
# CHECK-ASM: mrowbcast.ew.x m0, a1, m2
# CHECK-ENCODING: [0x2b,0x80,0x25,0x6a]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolshift.ew.x m0, a1, m2
# CHECK-ASM: mcolshift.ew.x m0, a1, m2
# CHECK-ENCODING: [0x2b,0x80,0x25,0x68]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowshift.ew.x m0, a1, m2
# CHECK-ASM: mrowshift.ew.x m0, a1, m2
# CHECK-ENCODING: [0x2b,0x80,0x25,0x6e]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolgather.ew m0, m1, m2
# CHECK-ASM: mcolgather.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x66]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowgather.ew m0, m1, m2
# CHECK-ASM: mrowgather.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x6c]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolscatadd.ew m0, m1, m2
# CHECK-ASM: mcolscatadd.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x74]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowscatadd.ew m0, m1, m2
# CHECK-ASM: mrowscatadd.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x72]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolscatmax.ew m0, m1, m2
# CHECK-ASM: mcolscatmax.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x78]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowscatmax.ew m0, m1, m2
# CHECK-ASM: mrowscatmax.ew m0, m1, m2
# CHECK-ENCODING: [0x2b,0x80,0x20,0x76]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolbcast.ew.x m31, t5, m29
# CHECK-ASM: mcolbcast.ew.x m31, t5, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x65]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowbcast.ew.x m31, t5, m29
# CHECK-ASM: mrowbcast.ew.x m31, t5, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x6b]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolshift.ew.x m31, t5, m29
# CHECK-ASM: mcolshift.ew.x m31, t5, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x69]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowshift.ew.x m31, t5, m29
# CHECK-ASM: mrowshift.ew.x m31, t5, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x6f]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolgather.ew m31, m30, m29
# CHECK-ASM: mcolgather.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x67]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowgather.ew m31, m30, m29
# CHECK-ASM: mrowgather.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x6d]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolscatadd.ew m31, m30, m29
# CHECK-ASM: mcolscatadd.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x75]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowscatadd.ew m31, m30, m29
# CHECK-ASM: mrowscatadd.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x73]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolscatmax.ew m31, m30, m29
# CHECK-ASM: mcolscatmax.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x79]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowscatmax.ew m31, m30, m29
# CHECK-ASM: mrowscatmax.ew m31, m30, m29
# CHECK-ENCODING: [0xab,0x0f,0xdf,0x77]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mbcast.m.x m0, a1, a2
# CHECK-ASM: mbcast.m.x m0, a1, a2
# CHECK-ENCODING: [0x2b,0x80,0xc5,0xb0]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowid.ew m0
# CHECK-ASM: mrowid.ew m0
# CHECK-ENCODING: [0x2b,0x80,0x01,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolid.ew m0
# CHECK-ASM: mcolid.ew m0
# CHECK-ENCODING: [0x2b,0x00,0x01,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mbcast.m.x m31, t5, t4
# CHECK-ASM: mbcast.m.x m31, t5, t4
# CHECK-ENCODING: [0xab,0x0f,0xdf,0xb1]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowid.ew m31
# CHECK-ASM: mrowid.ew m31
# CHECK-ENCODING: [0xab,0x8f,0x01,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolid.ew m31
# CHECK-ASM: mcolid.ew m31
# CHECK-ENCODING: [0xab,0x0f,0x01,0xa6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.st m0, (a1), a2
# CHECK-ASM: mls.st m0, (a1), a2
# CHECK-ENCODING: [0x2b,0x80,0xc5,0xa8]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.tst m0, (a1), a2
# CHECK-ASM: mls.tst m0, (a1), a2
# CHECK-ENCODING: [0x2b,0x80,0xc5,0xaa]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.st m0, (a1), a2
# CHECK-ASM: mss.st m0, (a1), a2
# CHECK-ENCODING: [0x2b,0x80,0xc5,0xac]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.tst m0, (a1), a2
# CHECK-ASM: mss.tst m0, (a1), a2
# CHECK-ENCODING: [0x2b,0x80,0xc5,0xae]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.st m31, (t6), zero
# CHECK-ASM: mls.st m31, (t6), zero
# CHECK-ENCODING: [0xab,0x8f,0x0f,0xa8]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mls.tst m31, (t6), zero
# CHECK-ASM: mls.tst m31, (t6), zero
# CHECK-ENCODING: [0xab,0x8f,0x0f,0xaa]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.st m31, (t6), zero
# CHECK-ASM: mss.st m31, (t6), zero
# CHECK-ENCODING: [0xab,0x8f,0x0f,0xac]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mss.tst m31, (t6), zero
# CHECK-ASM: mss.tst m31, (t6), zero
# CHECK-ENCODING: [0xab,0x8f,0x0f,0xae]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolunzip.ew m0, m31
# CHECK-ASM: mcolunzip.ew m0, m31
# CHECK-ENCODING: [0x2b,0x00,0xf0,0xc3]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolunzip.ew m30, m1
# CHECK-ASM: mcolunzip.ew m30, m1
# CHECK-ENCODING: [0x2b,0x00,0x1f,0xc2]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolzip.ew m0, m31
# CHECK-ASM: mcolzip.ew m0, m31
# CHECK-ENCODING: [0x2b,0x00,0xf0,0xc5]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mcolzip.ew m30, m1
# CHECK-ASM: mcolzip.ew m30, m1
# CHECK-ENCODING: [0x2b,0x00,0x1f,0xc4]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowunzip.ew m0, m31
# CHECK-ASM: mrowunzip.ew m0, m31
# CHECK-ENCODING: [0x2b,0x00,0xf0,0xc7]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowunzip.ew m30, m1
# CHECK-ASM: mrowunzip.ew m30, m1
# CHECK-ENCODING: [0x2b,0x00,0x1f,0xc6]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowzip.ew m0, m31
# CHECK-ASM: mrowzip.ew m0, m31
# CHECK-ENCODING: [0x2b,0x00,0xf0,0x71]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)

mrowzip.ew m30, m1
# CHECK-ASM: mrowzip.ew m30, m1
# CHECK-ENCODING: [0x2b,0x00,0x1f,0x70]
# CHECK-ERROR: instruction requires the following: 'Ztt' (Attached Matrix Extension)
