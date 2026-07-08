import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../repository/export_statement_repository.dart';

part 'export_pdf_event.dart';
part 'export_pdf_state.dart';
part 'export_pdf_bloc.freezed.dart';

class ExportPdfBloc extends Bloc<ExportPdfEvent, ExportPdfState> {
  final ExportStatementRepository _repository;

  ExportPdfBloc({required ExportStatementRepository repo})
    : _repository = repo,
      super(ExportPdfState.initial()) {
    on<_ExportPdf>(_onExportPdf);
  }

  Future<void> _onExportPdf(
    _ExportPdf event,
    Emitter<ExportPdfState> emit,
  ) async {
    emit(ExportPdfState.loading());
    final result = await _repository.exportStatementPdf(
      type: event.type,
      date: event.date,
      month: event.month,
      ordering: event.ordering,
    );
    result.fold(
      (failure) => emit(ExportPdfState.failure(failure)),
      (bytes) => emit(ExportPdfState.loaded(bytes)),
    );
  }
}
