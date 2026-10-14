// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +f -target-feature +d -target-abi ilp32d -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV32
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +f -target-feature +d -target-abi lp64d -target-feature +ztt-profile=clang-runtime-u32-m16-a4 -O1 -emit-llvm -o - %s | FileCheck %s --check-prefixes=CHECK,RV64

// Values and storage match the exact C type, independently of datatype options.
// CHECK-DAG: @signed_value = {{.*}}global i16 -7, align 2
// CHECK-DAG: @unsigned_value = {{.*}}global i32 -1, align 4
// CHECK-DAG: @float_value = {{.*}}global float 1.500000e+00, align 4
// CHECK-DAG: @double_value = {{.*}}global double -2.500000e+00, align 8
// CHECK-DAG: @half_value = {{.*}}global half 1.500000e+00, align 2
// CHECK-DAG: @bfloat_value = {{.*}}global bfloat 1.500000e+00, align 2
// CHECK-DAG: @zero_float = {{.*}}global float 0.000000e+00, align 4
// CHECK-DAG: @zero_int = {{.*}}global i32 0, align 4
__riscv_ztt_i16_scalar_t signed_value = (short)-7;
__riscv_ztt_u32_sat_scalar_t unsigned_value = 0xffffffffU;
__riscv_ztt_f32_rup_scalar_t float_value = 1.5f;
__riscv_ztt_f64_scalar_t double_value = -2.5;
__riscv_ztt_f16_scalar_t half_value = (_Float16)1.5;
__riscv_ztt_bf16_scalar_t bfloat_value = (__bf16)1.5;
__riscv_ztt_f32_scalar_t zero_float;
__riscv_ztt_i32_scalar_t zero_int;

// CHECK-LABEL: define{{.*}} signext i8 @roundtrip_i8(
// CHECK-SAME: i8{{.*}} signext [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret i8 [[X]]
signed char roundtrip_i8(signed char x) {
  __riscv_ztt_i8_scalar_t s = x;
  return (signed char)s;
}

// CHECK-LABEL: define{{.*}} zeroext i8 @roundtrip_u8(
// CHECK-SAME: i8{{.*}} zeroext [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret i8 [[X]]
unsigned char roundtrip_u8(unsigned char x) {
  __riscv_ztt_u8_scalar_t s = x;
  return (unsigned char)s;
}

// CHECK-LABEL: define{{.*}} bfloat @roundtrip_bf16(
// CHECK-SAME: bfloat{{.*}} [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret bfloat [[X]]
__bf16 roundtrip_bf16(__bf16 x) {
  __riscv_ztt_bf16_rtz_scalar_t s = x;
  return (__bf16)s;
}

// CHECK-LABEL: define{{.*}} half @roundtrip_f16(
// CHECK-SAME: half{{.*}} [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret half [[X]]
_Float16 roundtrip_f16(_Float16 x) {
  __riscv_ztt_f16_scalar_t s = x;
  return (_Float16)s;
}

// Scalar function arguments and return values use the C ABI as well.
// CHECK-LABEL: define{{.*}} signext i16 @identity_i16(
// CHECK-SAME: i16{{.*}} signext [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret i16 [[X]]
__riscv_ztt_i16_rne_sat_scalar_t identity_i16(__riscv_ztt_i16_rne_sat_scalar_t x) {
  return x;
}

// CHECK-LABEL: define{{.*}} float @identity_f32(
// CHECK-SAME: float{{.*}} [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret float [[X]]
__riscv_ztt_f32_scalar_t identity_f32(__riscv_ztt_f32_scalar_t x) { return x; }

// CHECK-LABEL: define{{.*}} i64 @identity_i64(
// CHECK-SAME: i64{{.*}} [[X:%.*]])
// CHECK-NEXT: entry:
// CHECK-NEXT: ret i64 [[X]]
__riscv_ztt_i64_scalar_t identity_i64(__riscv_ztt_i64_scalar_t x) { return x; }

// A scalar floating field remains eligible for the hard-float struct ABI.
struct FloatPair { __riscv_ztt_f32_scalar_t x; float y; };
// CHECK-LABEL: define{{.*}} { float, float } @pair(float{{.*}}, float{{.*}})
struct FloatPair pair(struct FloatPair x) { return x; }

// A 128-bit scalar is indirect on RV32 and two GPRs on RV64, like _BitInt(128).
// RV32-LABEL: define{{.*}} void @identity_i128(ptr{{.*}} sret(i128){{.*}}, ptr{{.*}})
// RV64-LABEL: define{{.*}} signext i128 @identity_i128(i128{{.*}} signext
__riscv_ztt_i128_scalar_t identity_i128(__riscv_ztt_i128_scalar_t x) { return x; }

// RV32-LABEL: define{{.*}} void @c_i128(ptr{{.*}} sret(i128){{.*}}, ptr{{.*}})
// RV64-LABEL: define{{.*}} signext i128 @c_i128(i128{{.*}} signext
_BitInt(128) c_i128(_BitInt(128) x) { return x; }
