/*===---- riscv_ztt.h - RISC-V Ztt intrinsics -----------------------------===
 *
 * Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
 * See https://llvm.org/LICENSE.txt for license information.
 * SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 *
 *===----------------------------------------------------------------------===
 */

#ifndef __RISCV_ZTT_H
#define __RISCV_ZTT_H

#ifndef __riscv_ztt
#error "RISC-V Ztt intrinsics require the Ztt extension."
#endif

#include <stddef.h>

#pragma clang riscv intrinsic ztt

#endif /* __RISCV_ZTT_H */
