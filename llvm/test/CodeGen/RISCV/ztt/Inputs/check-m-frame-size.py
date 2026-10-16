# Validate the emitted sizing arithmetic against the mathematical layout, not
# just an assembly snapshot. AMENLEN is supplied by this small test interpreter;
# no target hardware or AME-enabled host is required.
import math
import re
import sys

path, xlen = sys.argv[1], int(sys.argv[2])
mask = (1 << xlen) - 1
functions = []
current = None
with open(path) as asm:
    for line in asm:
        line = line.split("#", 1)[0].strip()
        match = re.match(r"size_u(\d+)_c(\d+)(?:_soft|_zmmul)?:$", line)
        if match:
            current = (int(match[1]), int(match[2]), [])
            functions.append(current)
        elif current and line and not line.startswith("."):
            current[2].append(line.replace(",", " ").split())
            if line == "ret":
                current = None

assert functions, "no sizing functions found"
for uds, count, instructions in functions:
    # Keep allocations representable, including the alignment padding.
    limit = math.isqrt((mask - 2047) // (max(count, 1) * (uds // 8)))
    values = {1, 2, 3, 7, 8, 15, 16, 17, 31, limit, max(1, limit - 1)}
    for bit in range(xlen // 2):
        values.update({(1 << bit) - 1, 1 << bit, (1 << bit) + 1})
    for n in sorted(v for v in values if 0 < v <= limit):
        regs = {"zero": 0}
        for insn in instructions:
            op = insn[0]
            if op == "ret":
                break
            dst = insn[1]
            if op == "csrr":
                assert insn[2] == "amenlen"
                value = n
            elif op == "li":
                value = int(insn[2], 0)
            elif op == "mv":
                value = regs[insn[2]]
            elif op == "neg":
                value = -regs[insn[2]]
            elif op in ("addi", "andi", "slli", "srli"):
                lhs, rhs = regs[insn[2]], int(insn[3], 0)
                if op == "addi":
                    value = lhs + rhs
                elif op == "andi":
                    value = lhs & rhs
                elif op == "slli":
                    value = lhs << rhs
                else:
                    value = lhs >> rhs
            elif op in ("add", "and", "mul"):
                lhs, rhs = regs[insn[2]], regs[insn[3]]
                if op == "add":
                    value = lhs + rhs
                elif op == "and":
                    value = lhs & rhs
                else:
                    value = lhs * rhs
            else:
                raise AssertionError("unexpected sizing instruction: " + str(insn))
            regs[dst] = value & mask
        stride = n * n * (uds // 8) if count else 0
        size = ((count * stride + 15) // 16) * 16
        assert (regs["a0"], regs["a1"]) == (size, stride), (
            xlen, uds, count, n, regs, size, stride
        )
