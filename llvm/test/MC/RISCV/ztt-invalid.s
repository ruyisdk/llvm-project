# RUN: not llvm-mc -triple=riscv32 -mattr=+ztt,+f,+v %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=INVALID
# RUN: not llvm-mc -triple=riscv64 -mattr=+ztt,+f,+v %s 2>&1 \
# RUN:   | FileCheck %s --check-prefix=INVALID

ame.acquire a0
# INVALID: error: too few operands for instruction
# INVALID-NEXT: ame.acquire a0

ame.acquire a0, f0
# INVALID: error: register must be a GPR
# INVALID-NEXT: ame.acquire a0, f0

ame.release a0
# INVALID: error: unexpected extra operand for instruction
# INVALID-NEXT: ame.release a0

mcolunzip.ew m1, m1
# INVALID: error: zip/unzip operands must be distinct M registers
# INVALID-NEXT: mcolunzip.ew m1, m1

mcolzip.ew m1, m1
# INVALID: error: zip/unzip operands must be distinct M registers
# INVALID-NEXT: mcolzip.ew m1, m1

mrowunzip.ew m1, m1
# INVALID: error: zip/unzip operands must be distinct M registers
# INVALID-NEXT: mrowunzip.ew m1, m1

mrowzip.ew m1, m1
# INVALID: error: zip/unzip operands must be distinct M registers
# INVALID-NEXT: mrowzip.ew m1, m1

mcolzip.ew m0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mcolzip.ew m0, acc0

mcolzip.ew m32, m0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mcolzip.ew m32, m0

mcolzip.ew m0
# INVALID: error: too few operands for instruction
# INVALID-NEXT: mcolzip.ew m0

mcolzip.ew m0, m1, m2
# INVALID: error: unexpected extra operand for instruction
# INVALID-NEXT: mcolzip.ew m0, m1, m2

mls.1r acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.1r acc0, a0

mls.1r a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.1r a0, a0

mls.1r f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.1r f0, a0

mls.1r v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.1r v0, a0

mls.1r 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.1r 0, a0

mls.1r m32, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.1r m32, a0

mls.1r m0, m0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mls.1r m0, m0

mls.1r m0, acc0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mls.1r m0, acc0

mls.1r m0, f0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mls.1r m0, f0

mls.1r m0, v0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mls.1r m0, v0

mls.1r m0, 0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mls.1r m0, 0

mls.1r m0
# INVALID: error: too few operands for instruction
# INVALID-NEXT: mls.1r m0

mls.1r m0, a0, a1
# INVALID: error: unexpected extra operand for instruction
# INVALID-NEXT: mls.1r m0, a0, a1

mss.1r acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.1r acc0, a0

mss.1r a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.1r a0, a0

mss.1r f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.1r f0, a0

mss.1r v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.1r v0, a0

mss.1r 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.1r 0, a0

mss.1r m32, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.1r m32, a0

mss.1r m0, m0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mss.1r m0, m0

mss.1r m0, acc0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mss.1r m0, acc0

mss.1r m0, f0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mss.1r m0, f0

mss.1r m0, v0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mss.1r m0, v0

mss.1r m0, 0
# INVALID: error: register must be a GPR
# INVALID-NEXT: mss.1r m0, 0

mss.1r m0
# INVALID: error: too few operands for instruction
# INVALID-NEXT: mss.1r m0

mss.1r m0, a0, a1
# INVALID: error: unexpected extra operand for instruction
# INVALID-NEXT: mss.1r m0, a0, a1

madd.ew acc0, m1, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew acc0, m1, m2

madd.ew a0, m1, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew a0, m1, m2

madd.ew f0, m1, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew f0, m1, m2

madd.ew v0, m1, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew v0, m1, m2

madd.ew 0, m1, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew 0, m1, m2

madd.ew m0, acc0, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, acc0, m2

madd.ew m0, a0, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, a0, m2

madd.ew m0, f0, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, f0, m2

madd.ew m0, v0, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, v0, m2

madd.ew m0, 0, m2
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, 0, m2

madd.ew m0, m1, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, m1, acc0

madd.ew m0, m1, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, m1, a0

madd.ew m0, m1, f0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, m1, f0

madd.ew m0, m1, v0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, m1, v0

madd.ew m0, m1, 0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew m0, m1, 0

msettyp acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: msettyp acc0, a0

msettyp a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: msettyp a0, a0

msettyp f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: msettyp f0, a0

msettyp v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: msettyp v0, a0

msettyp 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: msettyp 0, a0

mgettyp a0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mgettyp a0, acc0

mgettyp a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mgettyp a0, a0

mgettyp a0, f0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mgettyp a0, f0

mgettyp a0, v0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mgettyp a0, v0

mgettyp a0, 0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mgettyp a0, 0

asettyp m0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: asettyp m0, a0

asettyp a0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: asettyp a0, a0

asettyp f0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: asettyp f0, a0

asettyp v0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: asettyp v0, a0

asettyp 0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: asettyp 0, a0

agettyp a0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: agettyp a0, m0

agettyp a0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: agettyp a0, a0

agettyp a0, f0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: agettyp a0, f0

agettyp a0, v0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: agettyp a0, v0

agettyp a0, 0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: agettyp a0, 0

mls.rm acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.rm acc0, a0

mls.rm a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.rm a0, a0

mls.rm f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.rm f0, a0

mls.rm v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.rm v0, a0

mls.rm 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.rm 0, a0

mls.cm acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.cm acc0, a0

mls.cm a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.cm a0, a0

mls.cm f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.cm f0, a0

mls.cm v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.cm v0, a0

mls.cm 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mls.cm 0, a0

mss.rm acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.rm acc0, a0

mss.rm a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.rm a0, a0

mss.rm f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.rm f0, a0

mss.rm v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.rm v0, a0

mss.rm 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.rm 0, a0

mss.cm acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.cm acc0, a0

mss.cm a0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.cm a0, a0

mss.cm f0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.cm f0, a0

mss.cm v0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.cm v0, a0

mss.cm 0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mss.cm 0, a0

mmov.m.m acc0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m acc0, m1

mmov.m.m a0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m a0, m1

mmov.m.m f0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m f0, m1

mmov.m.m v0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m v0, m1

mmov.m.m 0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m 0, m1

mmov.m.m m0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m m0, acc0

mmov.m.m m0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m m0, a0

mmov.m.m m0, f0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m m0, f0

mmov.m.m m0, v0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m m0, v0

mmov.m.m m0, 0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.m m0, 0

mmov.m.a acc0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.a acc0, acc0

mmov.m.a a0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.a a0, acc0

mmov.m.a f0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.a f0, acc0

mmov.m.a v0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.a v0, acc0

mmov.m.a 0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.m.a 0, acc0

mmov.m.a m0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.m.a m0, m0

mmov.m.a m0, a0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.m.a m0, a0

mmov.m.a m0, f0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.m.a m0, f0

mmov.m.a m0, v0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.m.a m0, v0

mmov.m.a m0, 0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.m.a m0, 0

mmov.a.m m0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.a.m m0, m0

mmov.a.m a0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.a.m a0, m0

mmov.a.m f0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.a.m f0, m0

mmov.a.m v0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.a.m v0, m0

mmov.a.m 0, m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmov.a.m 0, m0

mmov.a.m acc0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.a.m acc0, acc0

mmov.a.m acc0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.a.m acc0, a0

mmov.a.m acc0, f0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.a.m acc0, f0

mmov.a.m acc0, v0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.a.m acc0, v0

mmov.a.m acc0, 0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmov.a.m acc0, 0

mmulacc.2d m0, m0, m1
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmulacc.2d m0, m0, m1

mmulacc.2d a0, m0, m1
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmulacc.2d a0, m0, m1

mmulacc.2d f0, m0, m1
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmulacc.2d f0, m0, m1

mmulacc.2d v0, m0, m1
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmulacc.2d v0, m0, m1

mmulacc.2d 0, m0, m1
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mmulacc.2d 0, m0, m1

mmulacc.2d acc0, acc0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, acc0, m1

mmulacc.2d acc0, a0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, a0, m1

mmulacc.2d acc0, f0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, f0, m1

mmulacc.2d acc0, v0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, v0, m1

mmulacc.2d acc0, 0, m1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, 0, m1

mmulacc.2d acc0, m0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, m0, acc0

mmulacc.2d acc0, m0, a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, m0, a0

mmulacc.2d acc0, m0, f0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, m0, f0

mmulacc.2d acc0, m0, v0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, m0, v0

mmulacc.2d acc0, m0, 0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mmulacc.2d acc0, m0, 0

mzero.2d.m acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mzero.2d.m acc0

mzero.2d.acc m0
# INVALID: error: operand must be a Ztt accumulator register acc0-acc15
# INVALID-NEXT: mzero.2d.acc m0

mzero.2d.m a0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mzero.2d.m a0

mzero.2d.m f0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mzero.2d.m f0

mzero.2d.m v0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mzero.2d.m v0

mzero.2d.m 0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: mzero.2d.m 0

madd.ew.x acc0, a0, m0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew.x acc0, a0, m0

madd.ew.x m0, m1, m0
# INVALID: error: register must be a GPR
# INVALID-NEXT: madd.ew.x m0, m1, m0

madd.ew.x m0, f0, m0
# INVALID: error: register must be a GPR
# INVALID-NEXT: madd.ew.x m0, f0, m0

madd.ew.x m0, 0, m0
# INVALID: error: register must be a GPR
# INVALID-NEXT: madd.ew.x m0, 0, m0

madd.ew.x m0, a0, acc0
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew.x m0, a0, acc0

madd.ew.x m0, a0, a1
# INVALID: error: operand must be a Ztt matrix register m0-m31
# INVALID-NEXT: madd.ew.x m0, a0, a1

madd.ew.x m0, a0
# INVALID: error: too few operands for instruction
# INVALID-NEXT: madd.ew.x m0, a0

madd.ew.x m0, a0, m0, m1
# INVALID: error: unexpected extra operand for instruction
# INVALID-NEXT: madd.ew.x m0, a0, m0, m1
