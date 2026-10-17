// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -debug-info-kind=standalone -dwarf-version=5 -emit-llvm -o - %s | FileCheck %s --check-prefix=DEBUG
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -debug-info-kind=standalone -dwarf-version=5 -emit-llvm -o - %s | FileCheck %s --check-prefix=DEBUG

// Test type mapping only; this does not define a matrix calling convention.

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 1) @i16_1x1(
__riscv_ztt_i16_1x1_t i16_1x1(__riscv_ztt_i16_1x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 2) @i16_1x2(
__riscv_ztt_i16_1x2_t i16_1x2(__riscv_ztt_i16_1x2_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 4) @i16_1x4(
__riscv_ztt_i16_1x4_t i16_1x4(__riscv_ztt_i16_1x4_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 8) @i16_1x8(
__riscv_ztt_i16_1x8_t i16_1x8(__riscv_ztt_i16_1x8_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 16) @i16_1x16(
__riscv_ztt_i16_1x16_t i16_1x16(__riscv_ztt_i16_1x16_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 32) @i16_1x32(
__riscv_ztt_i16_1x32_t i16_1x32(__riscv_ztt_i16_1x32_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 2, 1) @i16_2x1(
__riscv_ztt_i16_2x1_t i16_2x1(__riscv_ztt_i16_2x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 4, 1) @i16_4x1(
__riscv_ztt_i16_4x1_t i16_4x1(__riscv_ztt_i16_4x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 8, 1) @i16_8x1(
__riscv_ztt_i16_8x1_t i16_8x1(__riscv_ztt_i16_8x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 16, 1) @i16_16x1(
__riscv_ztt_i16_16x1_t i16_16x1(__riscv_ztt_i16_16x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 32, 1) @i16_32x1(
__riscv_ztt_i16_32x1_t i16_32x1(__riscv_ztt_i16_32x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 1) @i32_1x1(
__riscv_ztt_i32_1x1_t i32_1x1(__riscv_ztt_i32_1x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 1, 32) @i32_1x32(
__riscv_ztt_i32_1x32_t i32_1x32(__riscv_ztt_i32_1x32_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 32, 1) @i32_32x1(
__riscv_ztt_i32_32x1_t i32_32x1(__riscv_ztt_i32_32x1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 1) @i16_accx1(
__riscv_ztt_i16_accx1_t i16_accx1(__riscv_ztt_i16_accx1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 2) @i16_accx2(
__riscv_ztt_i16_accx2_t i16_accx2(__riscv_ztt_i16_accx2_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 4) @i16_accx4(
__riscv_ztt_i16_accx4_t i16_accx4(__riscv_ztt_i16_accx4_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 8) @i16_accx8(
__riscv_ztt_i16_accx8_t i16_accx8(__riscv_ztt_i16_accx8_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i32", i32, 32, 1) @i32_accx1(
__riscv_ztt_i32_accx1_t i32_accx1(__riscv_ztt_i32_accx1_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i32", i32, 32, 2) @i32_accx2(
__riscv_ztt_i32_accx2_t i32_accx2(__riscv_ztt_i32_accx2_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i32", i32, 32, 4) @i32_accx4(
__riscv_ztt_i32_accx4_t i32_accx4(__riscv_ztt_i32_accx4_t value) {
  return value;
}

// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i32", i32, 32, 8) @i32_accx8(
__riscv_ztt_i32_accx8_t i32_accx8(__riscv_ztt_i32_accx8_t value) {
  return value;
}

#define TEST_RISCV_ZTT_TYPES(TYPE)                                         \
  __riscv_ztt_##TYPE##_1x1_t TYPE##_m(__riscv_ztt_##TYPE##_1x1_t value) {    \
    return value;                                                        \
  }                                                                      \
  __riscv_ztt_##TYPE##_accx1_t TYPE##_acc(                                 \
      __riscv_ztt_##TYPE##_accx1_t value) {                                \
    return value;                                                        \
  }

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i4", i4, 4, 1, 1) @i4_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i4", i4, 4, 1) @i4_acc(
TEST_RISCV_ZTT_TYPES(i4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u4", i4, 4, 1, 1) @u4_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u4", i4, 4, 1) @u4_acc(
TEST_RISCV_ZTT_TYPES(u4)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i8", i8, 8, 1, 1) @i8_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i8", i8, 8, 1) @i8_acc(
TEST_RISCV_ZTT_TYPES(i8)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u8", i8, 8, 1, 1) @u8_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u8", i8, 8, 1) @u8_acc(
TEST_RISCV_ZTT_TYPES(u8)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u16", i16, 16, 1, 1) @u16_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u16", i16, 16, 1) @u16_acc(
TEST_RISCV_ZTT_TYPES(u16)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u32", i32, 32, 1, 1) @u32_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u32", i32, 32, 1) @u32_acc(
TEST_RISCV_ZTT_TYPES(u32)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i64", i64, 64, 1, 1) @i64_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i64", i64, 64, 1) @i64_acc(
TEST_RISCV_ZTT_TYPES(i64)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u64", i64, 64, 1, 1) @u64_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u64", i64, 64, 1) @u64_acc(
TEST_RISCV_ZTT_TYPES(u64)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i128", i128, 128, 1, 1) @i128_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i128", i128, 128, 1) @i128_acc(
TEST_RISCV_ZTT_TYPES(i128)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u128", i128, 128, 1, 1) @u128_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u128", i128, 128, 1) @u128_acc(
TEST_RISCV_ZTT_TYPES(u128)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f16", half, 16, 1, 1) @f16_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f16", half, 16, 1) @f16_acc(
TEST_RISCV_ZTT_TYPES(f16)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.bf16", bfloat, 16, 1, 1) @bf16_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.bf16", bfloat, 16, 1) @bf16_acc(
TEST_RISCV_ZTT_TYPES(bf16)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 1) @f32_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32", float, 32, 1) @f32_acc(
TEST_RISCV_ZTT_TYPES(f32)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f64", double, 64, 1, 1) @f64_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f64", double, 64, 1) @f64_acc(
TEST_RISCV_ZTT_TYPES(f64)

// Explicit default rounding uses the same IR type as the unsuffixed name.
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 1) @i16_rnu_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 1) @i16_rnu_acc(
TEST_RISCV_ZTT_TYPES(i16_rnu)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_sat", i16, 16, 1, 1) @i16_rnu_sat_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_sat", i16, 16, 1) @i16_rnu_sat_acc(
TEST_RISCV_ZTT_TYPES(i16_rnu_sat)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_rne", i16, 16, 1, 1) @i16_rne_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_rne", i16, 16, 1) @i16_rne_acc(
TEST_RISCV_ZTT_TYPES(i16_rne)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_rdn", i16, 16, 1, 1) @i16_rdn_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_rdn", i16, 16, 1) @i16_rdn_acc(
TEST_RISCV_ZTT_TYPES(i16_rdn)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_rod", i16, 16, 1, 1) @i16_rod_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_rod", i16, 16, 1) @i16_rod_acc(
TEST_RISCV_ZTT_TYPES(i16_rod)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_sat", i16, 16, 1, 1) @i16_sat_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_sat", i16, 16, 1) @i16_sat_acc(
TEST_RISCV_ZTT_TYPES(i16_sat)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_rne_sat", i16, 16, 1, 1) @i16_rne_sat_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_rne_sat", i16, 16, 1) @i16_rne_sat_acc(
TEST_RISCV_ZTT_TYPES(i16_rne_sat)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_rdn_sat", i16, 16, 1, 1) @i16_rdn_sat_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_rdn_sat", i16, 16, 1) @i16_rdn_sat_acc(
TEST_RISCV_ZTT_TYPES(i16_rdn_sat)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 1) @i16_rod_sat_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.i16_rod_sat", i16, 16, 1) @i16_rod_sat_acc(
TEST_RISCV_ZTT_TYPES(i16_rod_sat)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.u16_rne_sat", i16, 16, 1, 1) @u16_rne_sat_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.u16_rne_sat", i16, 16, 1) @u16_rne_sat_acc(
TEST_RISCV_ZTT_TYPES(u16_rne_sat)

// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32", float, 32, 1, 1) @f32_rne_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32", float, 32, 1) @f32_rne_acc(
TEST_RISCV_ZTT_TYPES(f32_rne)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32_rtz", float, 32, 1, 1) @f32_rtz_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32_rtz", float, 32, 1) @f32_rtz_acc(
TEST_RISCV_ZTT_TYPES(f32_rtz)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32_rdn", float, 32, 1, 1) @f32_rdn_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32_rdn", float, 32, 1) @f32_rdn_acc(
TEST_RISCV_ZTT_TYPES(f32_rdn)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32_rup", float, 32, 1, 1) @f32_rup_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32_rup", float, 32, 1) @f32_rup_acc(
TEST_RISCV_ZTT_TYPES(f32_rup)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32_rmm", float, 32, 1, 1) @f32_rmm_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32_rmm", float, 32, 1) @f32_rmm_acc(
TEST_RISCV_ZTT_TYPES(f32_rmm)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.f32_rno", float, 32, 1, 1) @f32_rno_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.f32_rno", float, 32, 1) @f32_rno_acc(
TEST_RISCV_ZTT_TYPES(f32_rno)
// CHECK-LABEL: define{{.*}} target("riscv.ztt.m.bf16_rno", bfloat, 16, 1, 1) @bf16_rno_m(
// CHECK-LABEL: define{{.*}} target("riscv.ztt.acc.bf16_rno", bfloat, 16, 1) @bf16_rno_acc(
TEST_RISCV_ZTT_TYPES(bf16_rno)

// RISC-V Ztt debug types keep their names without claiming a fixed layout.
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_i16_1x2_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_i16_2x1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_i16_accx4_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_i4_1x1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_u128_1x1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_f16_1x1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_bf16_1x1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_f32_accx1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_i16_sat_1x1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_i16_rod_sat_accx1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_f32_rno_accx1_t")
// DEBUG-DAG: !DIBasicType(tag: DW_TAG_unspecified_type, name: "__riscv_ztt_bf16_rno_1x1_t")
