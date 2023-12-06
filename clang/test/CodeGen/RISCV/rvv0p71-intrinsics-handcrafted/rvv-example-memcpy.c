// RUN: %clang_cc1 -triple riscv64 -target-feature +xtheadvector \
// RUN: -O0 -emit-llvm %s -o - | FileCheck %s

#include <riscv_vector.h>

typedef unsigned char uint8_t;

// CHECK-LABEL: define dso_local void @memcpy_v(ptr noundef %dst, ptr noundef %src, i32 noundef signext %n) #0 {
// CHECK-NEXT: entry:
// CHECK-NEXT:   %dst.addr = alloca ptr, align 8
// CHECK-NEXT:   %src.addr = alloca ptr, align 8
// CHECK-NEXT:   %n.addr = alloca i32, align 4
// CHECK-NEXT:   %vl = alloca i32, align 4
// CHECK-NEXT:   %vec_src = alloca <vscale x 32 x i8>, align 1
// CHECK-NEXT:   store ptr %dst, ptr %dst.addr, align 8
// CHECK-NEXT:   store ptr %src, ptr %src.addr, align 8
// CHECK-NEXT:   store i32 %n, ptr %n.addr, align 4
// CHECK-NEXT:   br label %for.cond
//
// CHECK-LABEL: for.cond:                                         ; preds = %for.inc, %entry
// CHECK-NEXT:   %0 = load i32, ptr %n.addr, align 4
// CHECK-NEXT:   %cmp = icmp sgt i32 %0, 0
// CHECK-NEXT:   br i1 %cmp, label %for.body, label %for.end
//
// CHECK-LABEL: for.body:                                         ; preds = %for.cond
// CHECK-NEXT:   %1 = load i32, ptr %n.addr, align 4
// CHECK-NEXT:   %conv = sext i32 %1 to i64
// CHECK-NEXT:   %2 = call i64 @llvm.riscv.th.vsetvl.i64(i64 %conv, i64 0, i64 2)
// CHECK-NEXT:   %conv1 = trunc i64 %2 to i32
// CHECK-NEXT:   store i32 %conv1, ptr %vl, align 4
// CHECK-NEXT:   %3 = load ptr, ptr %src.addr, align 8
// CHECK-NEXT:   %4 = load i32, ptr %vl, align 4
// CHECK-NEXT:   %conv2 = sext i32 %4 to i64
// CHECK-NEXT:   %5 = call <vscale x 32 x i8> @llvm.riscv.th.vle.nxv32i8.i64(<vscale x 32 x i8> poison, ptr %3, i64 %conv2)
// CHECK-NEXT:   store <vscale x 32 x i8> %5, ptr %vec_src, align 1
// CHECK-NEXT:   %6 = load ptr, ptr %dst.addr, align 8
// CHECK-NEXT:   %7 = load <vscale x 32 x i8>, ptr %vec_src, align 1
// CHECK-NEXT:   %8 = load i32, ptr %vl, align 4
// CHECK-NEXT:   %conv3 = sext i32 %8 to i64
// CHECK-NEXT:   call void @llvm.riscv.th.vse.nxv32i8.i64(<vscale x 32 x i8> %7, ptr %6, i64 %conv3)
// CHECK-NEXT:   br label %for.inc
//
// CHECK-LABEL: for.inc:                                          ; preds = %for.body
// CHECK-NEXT:   %9 = load i32, ptr %vl, align 4
// CHECK-NEXT:   %10 = load i32, ptr %n.addr, align 4
// CHECK-NEXT:   %sub = sub nsw i32 %10, %9
// CHECK-NEXT:   store i32 %sub, ptr %n.addr, align 4
// CHECK-NEXT:   %11 = load i32, ptr %vl, align 4
// CHECK-NEXT:   %12 = load ptr, ptr %src.addr, align 8
// CHECK-NEXT:   %idx.ext = sext i32 %11 to i64
// CHECK-NEXT:   %add.ptr = getelementptr inbounds i8, ptr %12, i64 %idx.ext
// CHECK-NEXT:   store ptr %add.ptr, ptr %src.addr, align 8
// CHECK-NEXT:   %13 = load i32, ptr %vl, align 4
// CHECK-NEXT:   %14 = load ptr, ptr %dst.addr, align 8
// CHECK-NEXT:   %idx.ext4 = sext i32 %13 to i64
// CHECK-NEXT:   %add.ptr5 = getelementptr inbounds i8, ptr %14, i64 %idx.ext4
// CHECK-NEXT:   store ptr %add.ptr5, ptr %dst.addr, align 8
// CHECK-NEXT:   br label %for.cond, !llvm.loop !4
//
// CHECK-LABEL: for.end:                                          ; preds = %for.cond
// CHECK-NEXT:   ret void
// CHECK-NEXT: }

void memcpy_v(uint8_t *dst, const uint8_t *src, int n) {
  for (int vl; n > 0; n -= vl, src += vl, dst += vl) {
    vl = __riscv_vsetvl_e8m4(n);
    vuint8m4_t vec_src = __riscv_th_vle8_v_u8m4(src, vl);
    __riscv_th_vse8_v_u8m4(dst, vec_src, vl);
  }
}
