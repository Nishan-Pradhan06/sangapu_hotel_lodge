part of 'export_room_beverage_pdf_bloc.dart';

@freezed
abstract class ExportRoomBeveragePdfEvent with _$ExportRoomBeveragePdfEvent {
  const factory ExportRoomBeveragePdfEvent.exportPdf({
    String? date,
    String? month,
    String? startDate,
    String? endDate,
  }) = _ExportPdf;
}
