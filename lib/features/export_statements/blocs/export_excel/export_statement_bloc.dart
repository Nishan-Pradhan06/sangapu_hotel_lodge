import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../repository/export_statement_repository.dart';

part 'export_statement_event.dart';
part 'export_statement_state.dart';
part 'export_statement_bloc.freezed.dart';

class ExportStatementBloc
    extends Bloc<ExportStatementEvent, ExportStatementState> {
  final ExportStatementRepository _repository;

  ExportStatementBloc({required ExportStatementRepository repo})
    : _repository = repo,
      super(ExportStatementState.initial()) {
    on<_ExportExcel>(_onExportExcel);
  }

  Future<void> _onExportExcel(
    _ExportExcel event,
    Emitter<ExportStatementState> emit,
  ) async {
    emit(ExportStatementState.loading());
    final result = await _repository.exportStatementExcel(
      type: event.type,
      date: event.date,
      month: event.month,
      ordering: event.ordering,
      startDate: event.startDate,
      endDate: event.endDate,
    );
    result.fold(
      (failure) => emit(ExportStatementState.failure(failure)),
      (bytes) => emit(ExportStatementState.loaded(bytes)),
    );
  }
}
