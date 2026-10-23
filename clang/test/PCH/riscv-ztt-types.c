// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DHEADER -emit-pch -o %t.64 %s
// RUN: %clang_cc1 -triple riscv64 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -include-pch %t.64 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -DHEADER -emit-pch -o %t.32 %s
// RUN: %clang_cc1 -triple riscv32 -target-feature +ztt -target-feature +ztt-profile=clang-runtime-u32-m32-a16 -include-pch %t.32 -emit-llvm -o - %s | FileCheck %s

#ifdef HEADER
__riscv_ztt_i16_1x2_t pch_i16_1x2(__riscv_ztt_i16_1x2_t);
__riscv_ztt_i32_32x1_t pch_i32_32x1(__riscv_ztt_i32_32x1_t);
__riscv_ztt_i16_accx4_t pch_i16_accx4(__riscv_ztt_i16_accx4_t);
__riscv_ztt_u128_1x32_t pch_u128_1x32(__riscv_ztt_u128_1x32_t);
__riscv_ztt_bf16_accx8_t pch_bf16_accx8(__riscv_ztt_bf16_accx8_t);
typedef __riscv_ztt_i4_1x8_t PackedM;
PackedM pch_i4_1x8(PackedM);
typedef __riscv_ztt_i16_rod_sat_1x2_t IntWithOptions;
typedef __riscv_ztt_f32_rno_accx4_t FloatWithOptions;
IntWithOptions pch_int_options(IntWithOptions);
FloatWithOptions pch_float_options(FloatWithOptions);
typedef __riscv_ztt_i16_rnu_sat_1x2_t IntDefaultRounding;
typedef __riscv_ztt_f32_rne_accx4_t FloatDefaultRounding;
IntDefaultRounding pch_int_default(IntDefaultRounding);
FloatDefaultRounding pch_float_default(FloatDefaultRounding);
#undef HEADER
#else
__riscv_ztt_i16_1x2_t pch_i16_1x2(__riscv_ztt_i16_1x2_t x) { return x; }
__riscv_ztt_i32_32x1_t pch_i32_32x1(__riscv_ztt_i32_32x1_t x) { return x; }
__riscv_ztt_i16_accx4_t pch_i16_accx4(__riscv_ztt_i16_accx4_t x) {
  return x;
}
__riscv_ztt_u128_1x32_t pch_u128_1x32(__riscv_ztt_u128_1x32_t x) {
  return x;
}
__riscv_ztt_bf16_accx8_t pch_bf16_accx8(__riscv_ztt_bf16_accx8_t x) {
  return x;
}
_Static_assert(__builtin_types_compatible_p(PackedM, __riscv_ztt_i4_1x8_t),
               "PCH typedef identity");
PackedM pch_i4_1x8(__riscv_ztt_i4_1x8_t x) { return x; }
_Static_assert(__builtin_types_compatible_p(IntWithOptions,
                                           __riscv_ztt_i16_rod_sat_1x2_t),
               "PCH integer options");
_Static_assert(__builtin_types_compatible_p(FloatWithOptions,
                                           __riscv_ztt_f32_rno_accx4_t),
               "PCH floating-point options");
IntWithOptions pch_int_options(IntWithOptions x) { return x; }
FloatWithOptions pch_float_options(FloatWithOptions x) { return x; }
_Static_assert(__builtin_types_compatible_p(IntDefaultRounding,
                                           __riscv_ztt_i16_sat_1x2_t),
               "PCH integer default alias");
_Static_assert(__builtin_types_compatible_p(FloatDefaultRounding,
                                           __riscv_ztt_f32_accx4_t),
               "PCH floating-point default alias");
__riscv_ztt_i16_sat_1x2_t pch_int_default(__riscv_ztt_i16_sat_1x2_t x) {
  return x;
}
__riscv_ztt_f32_accx4_t pch_float_default(__riscv_ztt_f32_accx4_t x) {
  return x;
}
#endif

// CHECK: define{{.*}} target("riscv.ztt.m.i16", i16, 16, 1, 2) @pch_i16_1x2(target("riscv.ztt.m.i16", i16, 16, 1, 2)
// CHECK: define{{.*}} target("riscv.ztt.m.i32", i32, 32, 32, 1) @pch_i32_32x1(target("riscv.ztt.m.i32", i32, 32, 32, 1)
// CHECK: define{{.*}} target("riscv.ztt.acc.i16", i16, 16, 4) @pch_i16_accx4(target("riscv.ztt.acc.i16", i16, 16, 4)
// CHECK: define{{.*}} target("riscv.ztt.m.u128", i128, 128, 1, 32) @pch_u128_1x32(target("riscv.ztt.m.u128", i128, 128, 1, 32)
// CHECK: define{{.*}} target("riscv.ztt.acc.bf16", bfloat, 16, 8) @pch_bf16_accx8(target("riscv.ztt.acc.bf16", bfloat, 16, 8)
// CHECK: define{{.*}} target("riscv.ztt.m.i4", i4, 4, 1, 8) @pch_i4_1x8(target("riscv.ztt.m.i4", i4, 4, 1, 8)
// CHECK: define{{.*}} target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 2) @pch_int_options(target("riscv.ztt.m.i16_rod_sat", i16, 16, 1, 2)
// CHECK: define{{.*}} target("riscv.ztt.acc.f32_rno", float, 32, 4) @pch_float_options(target("riscv.ztt.acc.f32_rno", float, 32, 4)
// CHECK: define{{.*}} target("riscv.ztt.m.i16_sat", i16, 16, 1, 2) @pch_int_default(target("riscv.ztt.m.i16_sat", i16, 16, 1, 2)
// CHECK: define{{.*}} target("riscv.ztt.acc.f32", float, 32, 4) @pch_float_default(target("riscv.ztt.acc.f32", float, 32, 4)
