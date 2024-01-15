# The XTHeadVector extension in LLVM

This repository is a fork of the LLVM project, with the addition of the [T-Head Vector (`XTHeadVector`) extension](https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadvector.adoc).

Currently, the work is still in progress.
We listed features that have been implemented or are being worked on in the following itemized table,
as of the date of this commit.
An item marked as `(Done)` means that it has been fully implemented and tested according to the specification,
while the one marked as `(WIP)` means that only part of it has been implemented and may not be fully tested.
Any feature not listed below but present in the specification should be considered as a `(TODO)`.

- (Done) LLVM MC instruction definitions, assembly and disassembly.
- (WIP) LLVM intrinsics related to the `XTHeadVector` extension:
  - (WIP) `6. Configuration-Setting and Utility`
    - (Done) `6.1. Set vl and vtype`
    - (Done) `6.2. Set vl to VLMAX with specific vtype`
    - (Done) `6.6. Read/Write URW vector CSRs`
  - (WIP) `7. Vector Load/Store`
    - (Done) `7.1. Vector Unit-Stride Operations`
    - (Done) `7.2. Vector Strided Load/Store Operations`
    - (Done) `7.3. Vector Indexed Load/Store Operations`
    - (Done) `7.4. Unit-stride Fault-Only-First Loads Operations`
    - (Done) `7.5. Vector Load/Store Segment Operations (Zvlsseg)`, which is an essential part of `XTHeadVector`
  - (Done) `8. Vector AMO Operations (Zvamo)`, which is `XTHeadZvamo` [regarding the `XTHeadVector` extension](https://github.com/T-head-Semi/thead-extension-spec/blob/24349e6df223e8b268ba9672297018f508670acb/xtheadvector.adoc?plain=1#L27).
  - (WIP) `12. Vector Integer Arithmetic Operations`
    - (Done) `12.1. Vector Single-Width Integer Add and Subtract`
      - (Done) `vadd.{vv,vx,vi}`
      - (Done) `vsub.{vv,vx}`
      - (Done) `vrsub.{vx,vi}`
    - (Done) `12.2. Vector Widening Integer Add/Subtract`
      - (Done) `vwadd{u}.{vv,vx,wv,wx}`
      - (Done) `vwsub{u}.{vv,vx,wv,wx}`
    - (Done) `12.3. Vector Integer Add-with-Carry / Subtract-with-Borrow Instructions`
      - (Done) `vadc.{vvm,vxm,vim}`
      - (Done) `vmadc.{vvm,vxm,vim}`
      - (Done) `vsbc.{vvm,vxm}`
      - (Done) `vmsbc.{vvm,vxm}`
- (WIP) Clang intrinsics related to the `XTHeadVector` extension:
  - (WIP) `6. Configuration-Setting and Utility`
    - (Done) `6.1. Set vl and vtype`
    - (Done) `6.2. Set vl to VLMAX with specific vtype`
  - (WIP) `7. Vector Load/Store`
    - (Done) `7.1. Vector Unit-Stride Operations`
    - (Done) `7.2. Vector Strided Load/Store Operations`
    - (Done) `7.4 Unit-stride Fault-Only-First Loads Operations`

## Q & A

#### How to build LLVM with the `XTHeadVector` extension?

Build it as you are building the official LLVM project, but remember to enable the `RISCV` target.
We provide a configuration used during development:

```shell
cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DLLVM_TARGETS_TO_BUILD="RISCV" \
    -DBUILD_SHARED_LIBS=true \
    -DLLVM_USE_LINKER=mold \
    -DDEFAULT_SYSROOT="/opt/riscv/sysroot" \
    -DLLVM_DEFAULT_TARGET_TRIPLE="riscv64-unknown-linux-gnu"
```

Where `/opt/riscv/sysroot` is a directory containing the headers and libraries of the target system.
For details, please refer to the [RISC-V GNU toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain).

We also recommend [mold](https://github.com/rui314/mold) as the linker, as it is unbelievably fast and memory-efficient.

### How to use the `XTHeadVector` extension?

This is an example of how to use the `XTHeadVector` extension in C code:

```c
// memcpy_v.c
#include <riscv_vector.h>
#include <stdint.h>
#include <stdio.h>

void memcpy_v(uint8_t *dst, const uint8_t *src, size_t n) {
  for (size_t vl; n > 0; n -= vl, src += vl, dst += vl) {
    vl = __riscv_vsetvl_e8m4(n);
    vuint8m4_t vec_src = __riscv_th_vle8_v_u8m4(src, vl);
    __riscv_th_vse8_v_u8m4(dst, vec_src, vl);
  }
}

/* main() function omitted */
```

The code implements a vectorized version of `memcpy()`. To compile it:

```bash
clang -march=rv64gc_xtheadvector memcpy_v.c -o memcpy_v
```

To inspect the LLVM IR generated, use the `-S` option:

```bash
clang -march=rv64gc_xtheadvector memcpy_v.c -o memcpy_v.ll -S -emit-llvm
```

To compile the LLVM IR to an executable binary, use the `llc` tool:

```bash
llc -mtriple=riscv64 -mattr=+xtheadvector memcpy_v.ll
```

You may encounter some errors about missing libraries when using sysroot from GCC, lik
```
/opt/riscv/bin/riscv64-unknown-linux-gnu-ld: cannot find crtbeginS.o: No such file or directory
/opt/riscv/bin/riscv64-unknown-linux-gnu-ld: cannot find -lgcc: No such file or directory
/opt/riscv/bin/riscv64-unknown-linux-gnu-ld: cannot find -lgcc: No such file or directory
```

Here's a workaround, where `/opt/riscv` should be replaced with the path to your
[RISC-V GNU toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain) mentioned above:

```bash
cd <path-to-the-build-directory>
ln -s /opt/riscv/lib/gcc lib/gcc
```

### I would like to contribute to this project. How can I help?

Sure! Please feel free to open an issue or a pull request for any questions or suggestions.

We prioritize work based on "easiest to see results" and "most frequently used" by the compiler,
but **any kind of contribution** is always welcomed.

### Any plan to merge this project into the official LLVM project?

Yes! We are working on it. 
We will start to submit pull requests to the official LLVM project once one of the following conditions is met:

1. The `XTHeadVector` extension is fully implemented and tested, and the code is clean and well-documented.
   Currently, the code in this repo is still far from "elegant."
   There are copy-pasted functions, duplicated code segments, or hard-coded values,
   which are not acceptable in the upstream project.
   We also have a plan about reusing the existing RVV 1.0 implementation in LLVM, 
   but it takes time to figure out the correct way, as our priority is to make the compiler work first.
2. There are people in the GCC community who are also working on the same extension.
   We plan to reach out to the LLVM community once GCC has merged their first patch.
3. The `XTHeadVector` extension is still supported and used by T-Head boards when any of the above conditions is met.

-----

Here's the original README.md from the LLVM project:

# The LLVM Compiler Infrastructure

Welcome to the LLVM project!

This repository contains the source code for LLVM, a toolkit for the
construction of highly optimized compilers, optimizers, and run-time
environments.

The LLVM project has multiple components. The core of the project is
itself called "LLVM". This contains all of the tools, libraries, and header
files needed to process intermediate representations and convert them into
object files. Tools include an assembler, disassembler, bitcode analyzer, and
bitcode optimizer.

C-like languages use the [Clang](http://clang.llvm.org/) frontend. This
component compiles C, C++, Objective-C, and Objective-C++ code into LLVM bitcode
-- and from there into object files, using LLVM.

Other components include:
the [libc++ C++ standard library](https://libcxx.llvm.org),
the [LLD linker](https://lld.llvm.org), and more.

## Getting the Source Code and Building LLVM

Consult the
[Getting Started with LLVM](https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm)
page for information on building and running LLVM.

For information on how to contribute to the LLVM project, please take a look at
the [Contributing to LLVM](https://llvm.org/docs/Contributing.html) guide.

## Getting in touch

Join the [LLVM Discourse forums](https://discourse.llvm.org/), [Discord
chat](https://discord.gg/xS7Z362), or #llvm IRC channel on
[OFTC](https://oftc.net/).

The LLVM project has adopted a [code of conduct](https://llvm.org/docs/CodeOfConduct.html) for
participants to all modes of communication within the project.
