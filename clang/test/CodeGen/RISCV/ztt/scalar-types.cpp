// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -O1 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u16-m32-a16 -debug-info-kind=limited -emit-llvm -o - %s | FileCheck %s --check-prefix=DEBUG

// Distinct canonical identities survive overload resolution and mangling.
void overload(int) {}
void overload(__riscv_ztt_i32_scalar_t) {}
void overload(__riscv_ztt_u32_scalar_t) {}
void overload(__riscv_ztt_f32_scalar_t) {}
// CHECK: define{{.*}} @_Z8overloadi(
// CHECK: define{{.*}} @_Z8overloadu24__riscv_ztt_i32_scalar_t(
// CHECK: define{{.*}} @_Z8overloadu24__riscv_ztt_u32_scalar_t(
// CHECK: define{{.*}} @_Z8overloadu24__riscv_ztt_f32_scalar_t(

__riscv_ztt_i32_scalar_t gi = (int)7;
__riscv_ztt_f32_scalar_t gf = (float)-1.0f;

extern "C" int int_roundtrip(int x) {
  __riscv_ztt_i32_scalar_t value = x;
  return (int)value;
}
// CHECK-LABEL: define{{.*}} @int_roundtrip(
// CHECK: ret i32 %{{.*}}

extern "C" float float_roundtrip(float x) {
  __riscv_ztt_f32_scalar_t value = x;
  return static_cast<float>(value);
}
// CHECK-LABEL: define{{.*}} @float_roundtrip(
// CHECK: ret float %{{.*}}

extern "C" __riscv_ztt_i8_scalar_t signed_scalar(__riscv_ztt_i8_scalar_t x) {
  return x;
}
// CHECK-LABEL: define{{.*}} signext i8 @signed_scalar(i8{{.*}} signext
// CHECK: ret i8 %{{.*}}

extern "C" __riscv_ztt_u8_scalar_t unsigned_scalar(__riscv_ztt_u8_scalar_t x) {
  return x;
}
// CHECK-LABEL: define{{.*}} zeroext i8 @unsigned_scalar(i8{{.*}} zeroext
// CHECK: ret i8 %{{.*}}

// DEBUG-DAG: !DIDerivedType(tag: DW_TAG_typedef, name: "__riscv_ztt_i32_scalar_t"
// DEBUG-DAG: !DIDerivedType(tag: DW_TAG_typedef, name: "__riscv_ztt_f32_scalar_t"
