// RUN: clang-tblgen -gen-riscv-ztt -I %p/../../include -I %p/../../../llvm/include %s -o %t
// RUN: FileCheck %s < %t
// RUN: FileCheck %s --check-prefix=COUNT < %t

include "clang/Basic/BuiltinsRISCVZtt.td"

// Each operation has one Sema entry, shared by all result types.
// COUNT: #ifdef GET_RISCV_ZTT_SEMA_TABLE
// COUNT-COUNT-133: {{^  \{RISCVZttSemaArgCheckKind::}}
// COUNT-NEXT: #endif

// CHECK-LABEL: #ifdef GET_RISCV_ZTT_SEMA_ARG_CHECK_KINDS
// CHECK-NEXT: Compute,
// CHECK-NEXT: Copy,
// CHECK-NEXT: LoadStore,
// CHECK-NEXT: Matmul,
// CHECK-NEXT: None,
// CHECK-NEXT: Special,
// CHECK-NEXT: #endif

// CHECK-LABEL: #ifdef GET_RISCV_ZTT_SEMA_TABLE
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Special, "ame.acquire", 0, 1, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::None, "ame.release", 0, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Compute, "madd.ew", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "madd.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::Any, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "mand.ew", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::AllSameIntAsRes},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "mand.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::Int, RISCVZttComputeMatrixArgRule::AllSameIntAsRes},
// CHECK: {RISCVZttSemaArgCheckKind::Compute, "mcolbcast.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::ControlSize, RISCVZttComputeMatrixArgRule::AllSameAsRes},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "mcolgather.ew", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Gather},
// CHECK: {RISCVZttSemaArgCheckKind::Special, "mcolunzip.ew", 0, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Special, "mcolzip.ew", 0, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Special, "mconcat.m", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Copy, "mcopy.m2m", 1, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Special, "mextract", 1, 1, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Compute, "mldexp.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::ControlLong, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::LoadStore, "mls.rm", 0, 1, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::LoadStore, "mls.st", 0, 2, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Matmul, "mmulacc.2d", 2, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "mmulacc.ew", 2, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "mmulacc.ew.x", 1, 1, true, RISCVZttComputeScalarArgRule::Any, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Matmul, "mmulatacc.2d", 2, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Matmul, "mmulataccneg.2d", 2, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Matmul, "mmulbtacc.2d", 2, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Matmul, "mmulbtaccneg.2d", 2, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Special, "mrowunzip.ew", 0, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Special, "mrowzip.ew", 0, 0, true, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},
// CHECK: {RISCVZttSemaArgCheckKind::Compute, "msll.ew", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::AllInt},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "msll.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::ControlSize, RISCVZttComputeMatrixArgRule::AllInt},
// CHECK: {RISCVZttSemaArgCheckKind::Compute, "msra.ew", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::AllInt},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "msra.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::ControlSize, RISCVZttComputeMatrixArgRule::AllInt},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "msrl.ew", 2, 0, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::AllInt},
// CHECK-NEXT: {RISCVZttSemaArgCheckKind::Compute, "msrl.ew.x", 1, 1, false, RISCVZttComputeScalarArgRule::ControlSize, RISCVZttComputeMatrixArgRule::AllInt},
// CHECK: {RISCVZttSemaArgCheckKind::LoadStore, "mss.st", 1, 2, false, RISCVZttComputeScalarArgRule::None, RISCVZttComputeMatrixArgRule::Any},

foreach Op = !instances<RISCVZttOperation>() in
{
  assert !not(!empty(!filter(Value,
      ["None", "LoadStore", "Compute", "Copy", "Matmul", "Special"],
      !eq(Value, Op.SemaArgCheckKind)))), "unknown Sema argument check kind";
  assert !not(!empty(!filter(Value,
      ["Any", "FirstFP", "Select", "SecondInt", "AllSameAsRes", "Gather",
       "AllInt", "AllSameIntAsRes"],
      !eq(Value, Op.ComputeMatrixArgRule)))), "unknown matrix argument rule";
  assert !not(!empty(!filter(Value,
      ["None", "Any", "Int", "ControlSize", "ControlInt", "ControlLong"],
      !eq(Value, Op.ComputeScalarArgRule)))), "unknown scalar argument rule";
  assert !or(!eq(Op.SemaArgCheckKind, "Compute"),
             !eq(Op.ComputeMatrixArgRule, "Any")),
      "matrix argument rules are only used by Compute";
  assert !or(!eq(Op.SemaArgCheckKind, "Compute"),
             !eq(Op.ComputeScalarArgRule, "None")),
      "scalar argument rules are only used by Compute";
}

foreach Op = [riscv_ztt_op_mand_ew_x, riscv_ztt_op_mandnot_ew_x,
              riscv_ztt_op_mor_ew_x, riscv_ztt_op_mornot_ew_x,
              riscv_ztt_op_mxor_ew_x] in
{
  assert !eq(Op.ComputeScalarArgRule, "Int"), "bitwise scalars must be integer";
}

assert !eq(riscv_ztt_op_mreduceadd_row.ComputeMatrixArgRule, "Any"),
       "reduction allows different source and result datatypes";
assert !eq(riscv_ztt_op_mrowid_ew.SemaArgCheckKind, "None"),
       "row IDs have no input constraints";
