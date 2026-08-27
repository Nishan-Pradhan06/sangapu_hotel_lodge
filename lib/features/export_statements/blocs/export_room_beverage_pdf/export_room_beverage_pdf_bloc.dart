import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../repository/export_statement_repository.dart';

part 'export_room_beverage_pdf_event.dart';
part 'export_room_beverage_pdf_state.dart';
part 'export_room_beverage_pdf_bloc.freezed.dart';

class ExportRoomBeveragePdfBloc
    extends Bloc<ExportRoomBeveragePdfEvent, ExportRoomBeveragePdfState> {
  final ExportStatementRepository _repository;

  ExportRoomBeveragePdfBloc({required ExportStatementRepository repo})
    : _repository = repo,
      super(ExportRoomBeveragePdfState.initial()) {
    on<_ExportPdf>(_onExportPdf);
  }

  Future<void> _onExportPdf(
    _ExportPdf event,
    Emitter<ExportRoomBeveragePdfState> emit,
  ) async {
    emit(ExportRoomBeveragePdfState.loading());
    final result = await _repository.exportRoomBeveragePdf(
      date: event.date,
      month: event.month,
      startDate: event.startDate,
      endDate: event.endDate,
    );
    result.fold(
      (failure) => emit(ExportRoomBeveragePdfState.failure(failure)),
      (bytes) => emit(ExportRoomBeveragePdfState.loaded(bytes)),
    );
  }
}
