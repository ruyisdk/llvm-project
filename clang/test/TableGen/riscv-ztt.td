// RUN: clang-tblgen -gen-riscv-ztt -I %p/../../include -I %p/../../../llvm/include %s -o %t
// RUN: FileCheck %s < %t
// RUN: FileCheck %s --check-prefix=COUNT < %t
// RUN: FileCheck %s --check-prefix=REGISTRATION < %t
// RUN: FileCheck %s --check-prefix=CODEGEN < %t
// RUN: FileCheck %s --check-prefix=CGCOUNT < %t

include "clang/Basic/BuiltinsRISCVZtt.td"

// Each operation has one builtin ID, registration, operation ID and mapping.
// COUNT: #ifdef GET_BUILTIN_ENUMERATORS
// COUNT-COUNT-133: {{^    BI__builtin_riscv_ztt_[a-z0-9_]+,$}}
// COUNT-EMPTY:
// COUNT-NEXT: #endif // GET_BUILTIN_ENUMERATORS
// COUNT: #ifdef GET_BUILTIN_INFOS
// COUNT-COUNT-133: {{^    Builtin::Info\{}}
// COUNT-EMPTY:
// COUNT-NEXT: #endif // GET_BUILTIN_INFOS
// COUNT: #ifdef GET_RISCV_ZTT_OPERATION_ENUM
// COUNT-COUNT-133: {{^  riscv_ztt_op_[a-z0-9_]+,$}}
// COUNT-NEXT: #endif

// CODEGEN-LABEL: #ifdef GET_RISCV_ZTT_CODEGEN_TABLE
// CODEGEN-NEXT: {Intrinsic::riscv_ztt_ame_acquire, RISCVZttCodeGenKind::State},
// CODEGEN-NEXT: {Intrinsic::riscv_ztt_ame_release, RISCVZttCodeGenKind::State},
// CODEGEN: {Intrinsic::riscv_ztt_madd_ew, RISCVZttCodeGenKind::Slice},
// CODEGEN-NEXT: {Intrinsic::riscv_ztt_madd_ew_x, RISCVZttCodeGenKind::Slice},
// CODEGEN: {Intrinsic::riscv_ztt_mconcat_m, RISCVZttCodeGenKind::Transfer},
// CODEGEN: {Intrinsic::riscv_ztt_mcopy_m2a, RISCVZttCodeGenKind::Transfer},
// CODEGEN: {Intrinsic::riscv_ztt_mextract, RISCVZttCodeGenKind::Transfer},
// CODEGEN: {Intrinsic::riscv_ztt_mls_rm, RISCVZttCodeGenKind::Memory},
// CODEGEN: {Intrinsic::riscv_ztt_mmulacc_2d, RISCVZttCodeGenKind::Matmul},
// CODEGEN: {Intrinsic::riscv_ztt_mss_st, RISCVZttCodeGenKind::Memory},
// CODEGEN: {Intrinsic::riscv_ztt_mzero_acc, RISCVZttCodeGenKind::Slice},
// CODEGEN-NEXT: {Intrinsic::riscv_ztt_mzero_m, RISCVZttCodeGenKind::Slice},
// CODEGEN-NEXT: #endif

// Each operation also has one code generation entry.
// CGCOUNT-LABEL: #ifdef GET_RISCV_ZTT_CODEGEN_TABLE
// CGCOUNT-COUNT-133: {{^  \{Intrinsic::riscv_ztt_}}
// CGCOUNT-NEXT: #endif
// COUNT: #ifdef GET_RISCV_ZTT_BUILTIN_TABLE
// COUNT-COUNT-133: {{^  \{BI__builtin_riscv_ztt_}}
// COUNT-NEXT: #endif

// REGISTRATION-LABEL: #ifdef GET_BUILTIN_ENUMERATORS
// REGISTRATION-NEXT:    BI__builtin_riscv_ztt_ame_acquire,
// REGISTRATION-NEXT:    BI__builtin_riscv_ztt_ame_release,
// REGISTRATION-NEXT:    BI__builtin_riscv_ztt_get_amefflags,
// REGISTRATION:         BI__builtin_riscv_ztt_mzero_acc,
// REGISTRATION-NEXT:    BI__builtin_riscv_ztt_mzero_m,
// REGISTRATION-EMPTY:
// REGISTRATION-NEXT: #endif // GET_BUILTIN_ENUMERATORS

// REGISTRATION-LABEL: #ifdef GET_BUILTIN_STR_TABLE
// REGISTRATION: "__builtin_riscv_ztt_ame_acquire\0"
// REGISTRATION: "__builtin_riscv_ztt_madd_ew\0"
// REGISTRATION: "__builtin_riscv_ztt_mzero_m\0"

// REGISTRATION-LABEL: #ifdef GET_BUILTIN_INFOS
// REGISTRATION-NEXT: Builtin::Info{Builtin::Info::StrOffsets{[[#]] /* __builtin_riscv_ztt_ame_acquire */, [[#]] /* zz */, [[#]] /* n */, [[#]] /* ztt */}, HeaderDesc::NO_HEADER, ALL_LANGUAGES},
// REGISTRATION-NEXT: Builtin::Info{Builtin::Info::StrOffsets{[[#]] /* __builtin_riscv_ztt_ame_release */, [[#]] /* v */, [[#]] /* n */, [[#]] /* ztt */}, HeaderDesc::NO_HEADER, ALL_LANGUAGES},
// REGISTRATION:      Builtin::Info{Builtin::Info::StrOffsets{[[#]] /* __builtin_riscv_ztt_get_amenlen */, [[#]] /* z */, [[#]] /* n */, [[#]] /* ztt */}, HeaderDesc::NO_HEADER, ALL_LANGUAGES},
// REGISTRATION:      Builtin::Info{Builtin::Info::StrOffsets{[[#]] /* __builtin_riscv_ztt_madd_ew */, [[#]] /* v. */, [[#]] /* nt */, [[#]] /* ztt */}, HeaderDesc::NO_HEADER, ALL_LANGUAGES},

// CHECK-LABEL: #ifdef GET_RISCV_ZTT_OPERATION_ENUM
// CHECK-NEXT:   riscv_ztt_op_ame_acquire,
// CHECK-NEXT:   riscv_ztt_op_ame_release,
// CHECK-NEXT:   riscv_ztt_op_get_amefflags,
// CHECK:        riscv_ztt_op_mzero_acc,
// CHECK-NEXT:   riscv_ztt_op_mzero_m,
// CHECK-NEXT: #endif

// CHECK-LABEL: #ifdef GET_RISCV_ZTT_BUILTIN_TABLE
// CHECK-NEXT:   {BI__builtin_riscv_ztt_ame_acquire, RISCVZttOperation::riscv_ztt_op_ame_acquire, "ame_acquire", RISCVZttResultKind::NonMatrix, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_ame_release, RISCVZttOperation::riscv_ztt_op_ame_release, "ame_release", RISCVZttResultKind::NonMatrix, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_get_amefflags, RISCVZttOperation::riscv_ztt_op_get_amefflags, "get_amefflags", RISCVZttResultKind::NonMatrix, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK:        {BI__builtin_riscv_ztt_madd_ew, RISCVZttOperation::riscv_ztt_op_madd_ew, "madd_ew", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_madd_ew_x, RISCVZttOperation::riscv_ztt_op_madd_ew_x, "madd_ew_x", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK:        {BI__builtin_riscv_ztt_mcolbcast_ew_x, RISCVZttOperation::riscv_ztt_op_mcolbcast_ew_x, "mcolbcast_ew_x", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 1, 1},
// CHECK:        {BI__builtin_riscv_ztt_mcolid_ew, RISCVZttOperation::riscv_ztt_op_mcolid_ew, "mcolid_ew", RISCVZttResultKind::M, RISCVZttResultTypeKind::Integer, 1, 1},
// CHECK:        {BI__builtin_riscv_ztt_mconcat_m, RISCVZttOperation::riscv_ztt_op_mconcat_m, "mconcat_m", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 2},
// CHECK:        {BI__builtin_riscv_ztt_mcopy_m2a, RISCVZttOperation::riscv_ztt_op_mcopy_m2a, "mcopy_m2a", RISCVZttResultKind::ACC, RISCVZttResultTypeKind::Numeric, 8, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_mcopy_m2m, RISCVZttOperation::riscv_ztt_op_mcopy_m2m, "mcopy_m2m", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK:        {BI__builtin_riscv_ztt_mextract, RISCVZttOperation::riscv_ztt_op_mextract, "mextract", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 16, 1},
// CHECK:        {BI__builtin_riscv_ztt_mls_cm, RISCVZttOperation::riscv_ztt_op_mls_cm, "mls_cm", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_mls_rm, RISCVZttOperation::riscv_ztt_op_mls_rm, "mls_rm", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK:        {BI__builtin_riscv_ztt_mmulacc_2d, RISCVZttOperation::riscv_ztt_op_mmulacc_2d, "mmulacc_2d", RISCVZttResultKind::ACC, RISCVZttResultTypeKind::Numeric, 8, 1},
// CHECK:        {BI__builtin_riscv_ztt_mrowid_ew, RISCVZttOperation::riscv_ztt_op_mrowid_ew, "mrowid_ew", RISCVZttResultKind::M, RISCVZttResultTypeKind::Integer, 1, 1},
// CHECK:        {BI__builtin_riscv_ztt_mrowzip_ew, RISCVZttOperation::riscv_ztt_op_mrowzip_ew, "mrowzip_ew", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 2, 2},
// CHECK:        {BI__builtin_riscv_ztt_mss_cm, RISCVZttOperation::riscv_ztt_op_mss_cm, "mss_cm", RISCVZttResultKind::NonMatrix, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_mss_rm, RISCVZttOperation::riscv_ztt_op_mss_rm, "mss_rm", RISCVZttResultKind::NonMatrix, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK:        {BI__builtin_riscv_ztt_mzero_acc, RISCVZttOperation::riscv_ztt_op_mzero_acc, "mzero_acc", RISCVZttResultKind::ACC, RISCVZttResultTypeKind::Numeric, 8, 1},
// CHECK-NEXT:   {BI__builtin_riscv_ztt_mzero_m, RISCVZttOperation::riscv_ztt_op_mzero_m, "mzero_m", RISCVZttResultKind::M, RISCVZttResultTypeKind::Numeric, 32, 1},
// CHECK-NEXT: #endif
