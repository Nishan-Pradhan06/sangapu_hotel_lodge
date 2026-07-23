import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/core/state/bloc_base_state.dart';
import 'package:sangapu/features/income/model/income_entry_model.dart';
import 'package:sangapu/features/income/repository/income_repository.dart';
part 'income_entry_event.dart';
part 'income_entry_state.dart';
part 'income_entry_bloc.freezed.dart';

class IncomeEntryBloc extends Bloc<IncomeEntryEvent, IncomeEntryState> {
  final IncomeRepository _incomeEntryRepository;
  IncomeEntryBloc({required IncomeRepository repo})
    : _incomeEntryRepository = repo,
      super(IncomeEntryState.initial()) {
    on<_IncomeEntryModel>(_onIncomeEntry);
  }

  Future<void> _onIncomeEntry(
    IncomeEntryEvent event,
    Emitter<IncomeEntryState> emit,
  ) async {
    emit(IncomeEntryState.loading());

    final result = await _incomeEntryRepository.incomeEntries(
      incomeEntry: event.incomeEntryModel,
    );

    result.fold(
      (failure) => emit(IncomeEntryState.failure(failure)),
      (success) => emit(IncomeEntryState.loaded("Room entry successful")),
    );
  }
}
