#!/usr/bin/env python3
"""Execute the pressure test's scalar/frame and M/ACC-image operations.

This deliberately models destructive msettyp and one-physical-register .1r
transfers independently of instruction selection. Small power-of-two N values
exercise runtime alignment and header/scratch overlap; no simulator dependency
is needed. Spec section 3.2.3 requires N to be a power of two.
"""
import re
import sys

function = sys.argv[3] if len(sys.argv) > 3 else "pressure"
bits, columns, uds = map(int, sys.argv[4:7]) if len(sys.argv) > 3 else (32, 1, 8)
is_call = function not in ("pressure", "acc_pressure")
is_acc_image = function.startswith("acc_image")
acc_image_dst = 5 if function == "acc_image_unaligned" else 8
is_acc_busy = function.startswith("acc_busy")
is_busy = function == "busy" or is_acc_busy or is_acc_image
is_loop = function in ("loop", "acc_loop")
is_large_call = function.startswith("cross_large_")
fixed_regs = set(sys.argv[8].split(",")) if len(sys.argv) > 8 else set()
# The large-frame tests execute both physical return paths independently.
branch_input = int(sys.argv[9]) if len(sys.argv) > 9 else 0
asm = open(sys.argv[1]).read().split(function + ":", 1)[1].split(".Lfunc_end", 1)[0]
xlen = int(sys.argv[2])
mask = (1 << xlen) - 1
names = ["zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2", "s0", "s1"]
names += ["a" + str(i) for i in range(8)]
names += ["s" + str(i) for i in range(2, 12)]
names += ["t" + str(i) for i in range(3, 7)]

for n in (1, 2, 4, 8, 16, 32):
    regs = {r: 0x123400 + i for i, r in enumerate(names)}
    regs["zero"] = 0
    initial_sp = 0x1000000 + (int(sys.argv[7]) if len(sys.argv) > 7 else 0)
    regs["sp"] = initial_sp
    pointers = [0x10000 * (i + 1) for i in range(5)]
    if not is_busy:
        for i, p in enumerate(pointers):
            regs["a" + str(i)] = p
    if is_loop:
        regs["a2"] = 3
    if is_large_call:
        regs["a2"] = branch_input
    saved = {r: regs[r] for r in names
             if is_busy or r.startswith("s") or r == "ra"}
    memory = {}
    stride = n * n * uds // 8
    width = max(1, bits // uds)
    data_size = bits * columns * n * n // 8
    dtype_value = 1073741824 + bits
    if function == "acc_image_unsigned":
        dtype_value = bits
    # Distinguish physical-register chunks even when stride is a multiple of
    # 256; a repeating byte ramp alone can hide a swapped/missing chunk.
    inputs = [bytes((i * 31 + j + (j // 256) * 17) % 256 for j in range(data_size))
              for i in range(5)]
    matrix, md = {}, {}
    accum, ad = {}, {}
    if is_busy:
        md[0] = dtype_value
        for j in range(width):
            matrix[j] = inputs[0][j * stride:(j + 1) * stride]
    if is_acc_busy:
        for j in range(32 if function == "acc_busy32" else 16):
            matrix[j] = bytes((j * 29 + k + k // 256 * 17) % 256
                              for k in range(stride))
            if j % width == 0:
                md[j] = dtype_value
        for a in range(2):
            ad[a] = dtype_value
            accum[a] = int.from_bytes(inputs[a][:width * stride], "little")
        saved_m = dict(matrix)
        saved_md = dict(md)
        saved_acc = dict(accum)
    if is_acc_image:
        # Standalone allocator-image tests have no public memory operations.
        # Their source is an already-live logical ACC group, not a C ABI.
        for a in range(columns):
            ad[a] = dtype_value
            accum[a] = (int.from_bytes(inputs[a % 5][:width * stride], "little")
                        & ((1 << (n * n * bits)) - 1))
        saved_acc = dict(accum)
        # Unrelated ACC neighbours must not be cleared by packed transfers.
        for a in range(columns, 16):
            ad[a] = dtype_value
            accum[a] = 123 + a
    csr_reads = 0
    calls = 0
    image_stores, image_loads = [], []
    # Derive the complete public-store trace from the IR, independently of
    # physical register allocation. Later stores must not hide earlier errors.
    stores = ([(1, 0)] * 3 if is_loop else
              [] if is_busy else
              [(1, 0), (0, 1)] if is_call else
              [(1, 0), (0, 1), (1, 2), (0, 3), (1, 4)])
    expected_stores = [(pointers[dst] + j, value)
                       for dst, src in stores
                       for j, value in enumerate(inputs[src])]
    store_index = 0

    def check_access(address, size, alignment):
        assert address % alignment == 0, ("unaligned access", address, alignment)
        assert 0 <= address <= mask and size <= mask + 1 - address
        if address >= 0x800000:
            assert regs["sp"] <= address and address + size <= initial_sp, (
                "dead stack access", address, size)
        else:
            assert any(p <= address and address + size <= p + data_size
                       for p in pointers), ("outside input buffer", address, size)

    def write(address, data):
        check_access(address, len(data), 1)
        for j, b in enumerate(data):
            memory[address + j] = b

    def read(address, size):
        check_access(address, size, 1)
        return bytes(memory[address + j] for j in range(size))

    for p, data in zip(pointers, inputs):
        write(p, data)

    def address(operand):
        match = re.fullmatch(r"(-?\d+)\((\w+)\)", operand)
        return regs[match[2]] + int(match[1])

    code = [line.split("#", 1)[0].strip() for line in asm.splitlines()]
    labels = {line[:-1]: i for i, line in enumerate(code) if line.endswith(":")}
    pc, steps = 0, 0
    while pc < len(code):
        line = code[pc]
        pc += 1
        steps += 1
        assert steps < 5000, "execution did not terminate"
        if not line or line.startswith(".") or line.endswith(":"):
            continue
        assert not fixed_regs.intersection(re.findall(r"\b[a-z][a-z0-9]*\b", line)), (
            "fixed GPR used", line)
        op, *args = re.split(r"[\s,]+", line)
        if op == "ret":
            break
        if op == "li":
            regs[args[0]] = int(args[1]) & mask
        elif op == "lui":
            regs[args[0]] = (int(args[1]) << 12) & mask
        elif op == "mv":
            regs[args[0]] = regs[args[1]]
        elif op == "neg":
            regs[args[0]] = -regs[args[1]] & mask
        elif op == "csrr":
            assert args[1] == "amenlen"
            regs[args[0]] = n
            csr_reads += 1
        elif op in ("bnez", "beqz"):
            if (regs[args[0]] == 0) == (op == "beqz"):
                pc = labels[args[1]]
        elif op == "sext.w":
            value = regs[args[1]] & 0xffffffff
            regs[args[0]] = (value if value < (1 << 31) else value - (1 << 32)) & mask
        elif op in ("add", "sub", "mul", "and", "addi", "addiw", "andi", "slli", "srli"):
            a = regs[args[1]]
            b = int(args[2]) if op.endswith(("i", "iw")) else regs[args[2]]
            value = {"add": lambda: a + b, "addi": lambda: a + b,
                     "addiw": lambda: ((a + b + (1 << 31)) % (1 << 32)) - (1 << 31),
                     "sub": lambda: a - b, "mul": lambda: a * b,
                     "and": lambda: a & b, "andi": lambda: a & b,
                     "slli": lambda: a << b, "srli": lambda: a >> b}[op]()
            regs[args[0]] = value & mask
        elif op in ("sd", "sw"):
            size = 8 if op == "sd" else 4
            check_access(address(args[1]), size, size)
            write(address(args[1]), (regs[args[0]] & ((1 << (8 * size)) - 1))
                  .to_bytes(size, "little"))
        elif op in ("ld", "lw"):
            size = 8 if op == "ld" else 4
            check_access(address(args[1]), size, size)
            regs[args[0]] = int.from_bytes(read(address(args[1]), size),
                                          "little", signed=True) & mask
        elif op == "msettyp":
            base = int(args[0][1:])
            dtype = regs[args[1]]
            assert dtype == dtype_value, "matrix datatype mismatch"
            assert base % width == 0
            md[base] = dtype
            for j in range(width):
                matrix[base + j] = bytes(stride)
        elif op == "mgettyp":
            base = int(args[1][1:])
            assert base % width == 0, "continuation Md must not be saved"
            regs[args[0]] = md[base]
        elif op == "asettyp":
            a = int(args[0][3:])
            ad[a] = regs[args[1]] & 0xffffffff
            accum[a] = 0
        elif op == "mmulacc.2d":
            # The loop fixture deliberately uses two zero matrices: the exact
            # expected result is the unchanged input ACC, including its tail.
            a, l, r = int(args[0][3:]), int(args[1][1:]), int(args[2][1:])
            assert ad[a] == md[l] == md[r] == dtype_value
            assert not any(b"".join(matrix[l + j] for j in range(width)))
            assert not any(b"".join(matrix[r + j] for j in range(width)))
        elif op == "agettyp":
            regs[args[0]] = ad[int(args[1][3:])]
        elif op in ("mmov.m.a", "mmov.a.m"):
            to_acc = op == "mmov.a.m"
            a = int(args[0 if to_acc else 1][3:])
            m = int(args[1 if to_acc else 0][1:])
            assert ad[a] == md[m] == dtype_value, "ACC/M datatype mismatch"
            assert m % width == 0
            pack = max(1, uds // bits)
            square_bits = n * n * bits
            if to_acc:
                value = int.from_bytes(b"".join(matrix[m + j]
                                               for j in range(width)), "little")
                for j in range(pack):
                    accum[a + j] = (value >> (j * square_bits)) & ((1 << square_bits) - 1)
            else:
                value = sum(accum[a + j] << (j * square_bits) for j in range(pack))
                data = value.to_bytes(width * stride, "little")
                for j in range(width):
                    matrix[m + j] = data[j * stride:(j + 1) * stride]
        elif op in ("mls.rm", "mss.rm", "mls.1r", "mss.1r"):
            base, addr = int(args[0][1:]), regs[args[1]]
            count = 1 if op.endswith("1r") else width
            check_access(addr, count * stride,
                         uds // 8 if op.endswith("1r") else bits // 8)
            if op == "mss.1r":
                image_stores.append(addr)
            elif op == "mls.1r":
                image_loads.append(addr)
            if not op.endswith("1r"):
                assert md[base] == dtype_value
            for j in range(count):
                if op.startswith("mls"):
                    matrix[base + j] = read(addr + j * stride, stride)
                else:
                    if op == "mss.rm":
                        for k, value in enumerate(matrix[base + j]):
                            assert store_index < len(expected_stores), "extra public store"
                            actual = (addr + j * stride + k, value)
                            assert actual == expected_stores[store_index], (
                                "public store mismatch", n, store_index,
                                actual, expected_stores[store_index])
                            store_index += 1
                    write(addr + j * stride, matrix[base + j])
        elif op == "call":
            assert args[0] in ("clobber", "__muldi3", "__mulsi3")
            product = regs["a0"] * regs["a1"] & mask
            assert regs["sp"] % 16 == 0, "misaligned SP at call"
            if is_large_call:
                # The IR passes its 8192-byte local buffer. Its boundary words
                # must survive both pre-call matrix spills without overlap.
                buf = regs["a0"]
                check_access(buf, 8192, 16)
                assert read(buf, 4) == (17).to_bytes(4, "little")
                assert read(buf + 8188, 4) == (23).to_bytes(4, "little")
                assert len(image_stores) == 8 and len(set(image_stores)) == 8
                assert all(a + stride <= buf or a >= buf + 8192
                           for a in image_stores), "spill overlaps local buffer"
            calls += 1
            matrix.clear()
            md.clear()
            accum.clear()
            ad.clear()
            for r in names:
                if r.startswith(("a", "t")) or r == "ra":
                    regs[r] = 0x987600 + names.index(r)
            if args[0] != "clobber":
                regs["a0"] = product
        else:
            raise AssertionError("unhandled instruction: " + line)
        assert regs["zero"] == 0
    if not is_call or is_busy or is_loop or is_large_call:
        assert csr_reads == 1, "size must be computed once, not for every spill"
    assert regs["sp"] == initial_sp
    assert store_index == len(expected_stores), "missing public store"
    assert all(regs[r] == v for r, v in saved.items())
    if is_large_call:
        assert calls == 1
        assert regs["a0"] == (17 if branch_input == 0 else 23)
        assert sorted(image_loads) == sorted(image_stores)
        assert sum(line == "ret" for line in code) == 2, "expected two physical epilogues"
    if is_busy:
        if is_acc_busy:
            assert all(matrix[j] == v for j, v in saved_m.items()), "borrowed M corrupted"
            assert all(md[j] == v for j, v in saved_md.items()), "leader Md corrupted"
            assert all(accum[j + 2] == v for j, v in saved_acc.items()), "ACC image corrupted"
            assert all(accum[j] == v for j, v in saved_acc.items()), "ACC source corrupted"
            assert ad[2] == ad[3] == dtype_value
        elif is_acc_image:
            assert all(accum[j + acc_image_dst] == v for j, v in saved_acc.items()), "ACC payload corrupted"
            assert all(ad[j + acc_image_dst] == dtype_value for j in range(columns))
            assert all(accum[j] == v for j, v in saved_acc.items())
            assert all(accum[j] == 123 + j and ad[j] == dtype_value
                       for j in range(columns, 16)
                       if not acc_image_dst <= j < acc_image_dst + columns), "ACC neighbour corrupted"
        else:
            assert b"".join(matrix[j] for j in range(width)) == inputs[0]
            assert md[0] == dtype_value
    elif is_loop:
        assert calls == 3
        assert read(pointers[1], data_size) == inputs[0]
    else:
        assert read(pointers[0], data_size) == inputs[1 if is_call else 3]
        assert read(pointers[1], data_size) == inputs[0 if is_call else 4]
