// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_PRESSURE -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=PRESSURE
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u8-m32-a16 -DTEST_PRESSURE -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=PRESSURE
// RUN: %clang_cc1 -triple riscv32 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O0 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv32 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O1 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv32 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O0 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv32 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O1 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv64 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O0 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv64 -x c -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O1 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv64 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O0 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap
// RUN: %clang_cc1 -triple riscv64 -x c++ -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -Werror -O1 -emit-llvm -o - %s | FileCheck %s --implicit-check-not=llvm.trap

#include <riscv_ztt.h>

#ifndef TEST_PRESSURE
#ifdef __cplusplus
extern "C"
#endif
void matrix_operands(int *out, const int *in) {
  const __riscv_ztt_i32_1x1_t m = __riscv_ztt_mls_rm_i32_1x1(in);
  __riscv_ztt_i32_1x1_t n = __riscv_ztt_mls_cm_i32_1x1(in);
  const __riscv_ztt_i32_1x2_t joined = __riscv_ztt_mconcat_m_i32_1x2(m, n);
  const __riscv_ztt_i32_accx2_t a = __riscv_ztt_mcopy_m2a_i32_accx2(joined);
  const __riscv_ztt_i32_accx2_t b = __riscv_ztt_mmulacc_2d_i32_accx2(a, m, n);
  const __riscv_ztt_i32_1x2_t back = __riscv_ztt_mcopy_a2m_i32_1x2(b);
  __riscv_ztt_mss_rm(out, back);
  __riscv_ztt_mss_cm(out, __riscv_ztt_mcopy_m2m_i32_1x1(m));
}

// CHECK-LABEL: define{{.*}} @matrix_operands(
// CHECK: call {{.*}}@llvm.riscv.ztt.mls.rm
// CHECK: call {{.*}}@llvm.riscv.ztt.mls.cm
// CHECK: call {{.*}}@llvm.riscv.ztt.mconcat.m
// CHECK: call {{.*}}@llvm.riscv.ztt.mcopy.m2a
// CHECK: call {{.*}}@llvm.riscv.ztt.mmulacc.2d
// CHECK: call {{.*}}@llvm.riscv.ztt.mcopy.a2m
// CHECK: call void @llvm.riscv.ztt.mss.rm
// CHECK: call {{.*}}@llvm.riscv.ztt.mcopy.m2m
// CHECK: call void @llvm.riscv.ztt.mss.cm
// CHECK: ret void

#ifdef __cplusplus
extern "C"
#endif
void prvalue_operands(int *out) {
  __riscv_ztt_mss_rm(out, __riscv_ztt_mcopy_a2m_i32_1x2(
      __riscv_ztt_mmulacc_2d_i32_accx2(
          __riscv_ztt_mcopy_m2a_i32_accx2(
              __riscv_ztt_mconcat_m_i32_1x2(
                  __riscv_ztt_mclear_m_i32_1x1(),
                  __riscv_ztt_mclear_m_i32_1x1())),
          __riscv_ztt_mclear_m_i32_1x1(),
          __riscv_ztt_mclear_m_i32_1x1())));
}

// CHECK-LABEL: define{{.*}} @prvalue_operands(
// CHECK: call {{.*}}@llvm.riscv.ztt.mconcat.m
// CHECK: call {{.*}}@llvm.riscv.ztt.mcopy.m2a
// CHECK: call {{.*}}@llvm.riscv.ztt.mmulacc.2d
// CHECK: call {{.*}}@llvm.riscv.ztt.mcopy.a2m
// CHECK: call void @llvm.riscv.ztt.mss.rm
// CHECK: ret void
#else
// Preserve five simultaneously live matrix values through C-to-IR emission.
// Physical spilling and frame code are tested in LLVM's spill.ll.
// PRESSURE-LABEL: define{{.*}} void @pressure(
// PRESSURE-SAME: ptr{{[^%]*}}[[P:%[^, )]+]], ptr{{[^%]*}}[[Q:%[^, )]+]], ptr{{[^%]*}}[[R:%[^, )]+]], ptr{{[^%]*}}[[S:%[^, )]+]], ptr{{[^%]*}}[[T:%[^, )]+]])
// PRESSURE: [[A:%.*]] = {{.*}}call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[P]], i32 1073741856, i32 1)
// PRESSURE-NEXT: [[B:%.*]] = {{.*}}call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[Q]], i32 1073741856, i32 1)
// PRESSURE-NEXT: [[C:%.*]] = {{.*}}call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[R]], i32 1073741856, i32 1)
// PRESSURE-NEXT: [[D:%.*]] = {{.*}}call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[S]], i32 1073741856, i32 1)
// PRESSURE-NEXT: [[E:%.*]] = {{.*}}call target("riscv.ztt.m.i32", i32, 32, 1, 1) @llvm.riscv.ztt.mls.rm{{.*}}(ptr [[T]], i32 1073741856, i32 1)
// PRESSURE-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[Q]], target("riscv.ztt.m.i32", i32, 32, 1, 1) [[A]], i32 1073741856, i32 1)
// PRESSURE-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[P]], target("riscv.ztt.m.i32", i32, 32, 1, 1) [[B]], i32 1073741856, i32 1)
// PRESSURE-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[Q]], target("riscv.ztt.m.i32", i32, 32, 1, 1) [[C]], i32 1073741856, i32 1)
// PRESSURE-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[P]], target("riscv.ztt.m.i32", i32, 32, 1, 1) [[D]], i32 1073741856, i32 1)
// PRESSURE-NEXT: {{.*}}call void @llvm.riscv.ztt.mss.rm{{.*}}(ptr [[Q]], target("riscv.ztt.m.i32", i32, 32, 1, 1) [[E]], i32 1073741856, i32 1)
// PRESSURE-NEXT: ret void
void pressure(int *p, int *q, int *r, int *s, int *t) {
  __riscv_ztt_i32_1x1_t a = __riscv_ztt_mls_rm_i32_1x1(p);
  __riscv_ztt_i32_1x1_t b = __riscv_ztt_mls_rm_i32_1x1(q);
  __riscv_ztt_i32_1x1_t c = __riscv_ztt_mls_rm_i32_1x1(r);
  __riscv_ztt_i32_1x1_t d = __riscv_ztt_mls_rm_i32_1x1(s);
  __riscv_ztt_i32_1x1_t e = __riscv_ztt_mls_rm_i32_1x1(t);
  __riscv_ztt_mss_rm(q, a);
  __riscv_ztt_mss_rm(p, b);
  __riscv_ztt_mss_rm(q, c);
  __riscv_ztt_mss_rm(p, d);
  __riscv_ztt_mss_rm(q, e);
}
#endif
