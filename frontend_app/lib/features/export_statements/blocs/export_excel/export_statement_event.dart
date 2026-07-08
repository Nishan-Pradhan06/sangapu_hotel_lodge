part of 'export_statement_bloc.dart';

@freezed
abstract class ExportStatementEvent with _$ExportStatementEvent {
  const factory ExportStatementEvent.exportExcel({
    String? type,
    String? date,
    String? month,
    String? ordering,
  }) = _ExportExcel;
}
