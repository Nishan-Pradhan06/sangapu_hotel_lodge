part of 'export_pdf_bloc.dart';

@freezed
abstract class ExportPdfEvent with _$ExportPdfEvent {
  const factory ExportPdfEvent.exportPdf({
    String? type,
    String? date,
    String? month,
    String? ordering,
  }) = _ExportPdf;
}
