# RISC-V Ztt tests

Use a Ztt-enabled RISC-V Clang and QEMU on `PATH`. From the repository root:

```sh
cd llvm/examples/RISCV/Ztt
```

## Integer end-to-end test

```sh
clang -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 \
  -mabi=lp64d -O2 -fno-unwind-tables -fno-asynchronous-unwind-tables \
  -static e2e-int.c -o a.out
qemu-riscv64 -cpu rv64,x-ztt=true,amenlen=32,ameudsz=32,ame-num-mregs=16,ame-num-accregs=4 a.out
```

## Floating-point end-to-end test

```sh
clang -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 \
  -mabi=lp64d -O2 -fno-unwind-tables -fno-asynchronous-unwind-tables \
  -static e2e-float.c -lm -o a.out
qemu-riscv64 -cpu rv64,x-ztt=true,amenlen=32,ameudsz=32,ame-num-mregs=16,ame-num-accregs=4 a.out
```

## One smoke test

```sh
clang -march=rv64gc_ztt -mztt-profile=clang-runtime-u32-m16-a4 \
  -mabi=lp64d -O2 -fno-unwind-tables -fno-asynchronous-unwind-tables \
  -static arithmetic/test.c -lm -o a.out
qemu-riscv64 -cpu rv64,x-ztt=true,amenlen=4,ameudsz=32,ame-num-mregs=16,ame-num-accregs=4 a.out
```

## All tests: UDS32, UDS16 and UDS8

```sh
set -eu
for uds in 32 16 8; do
  for source in e2e-int.c e2e-float.c */test.c; do
    clang -march=rv64gc_ztt -mztt-profile=clang-runtime-u${uds}-m16-a4 \
      -mabi=lp64d -O2 -fno-unwind-tables -fno-asynchronous-unwind-tables \
      -static "$source" -lm -o a.out
    qemu-riscv64 -cpu rv64,x-ztt=true,amenlen=4,ameudsz=${uds},ame-num-mregs=16,ame-num-accregs=4 a.out
  done
done
```
