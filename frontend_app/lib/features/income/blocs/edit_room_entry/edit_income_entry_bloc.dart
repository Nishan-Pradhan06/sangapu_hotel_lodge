import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/features/income/model/income_entry_model.dart';
import 'package:sangapu/features/income/repository/income_repository.dart';
import '../../../../core/state/bloc_base_state.dart';

part 'edit_income_entry_event.dart';
part 'edit_income_entry_state.dart';
part 'edit_income_entry_bloc.freezed.dart';

class EditIncomeEntryBloc
    extends Bloc<EditIncomeEntryEvent, EditIncomeEntryState> {
  final IncomeRepository _incomeRepository;
  EditIncomeEntryBloc({required IncomeRepository repo})
    : _incomeRepository = repo,
      super(EditIncomeEntryState.initial()) {
    on<_EditIncomeEntryEvent>(_onEditIncomeEntry);
  }

  Future<void> _onEditIncomeEntry(
    EditIncomeEntryEvent event,
    Emitter<EditIncomeEntryState> emit,
  ) async {
    emit(EditIncomeEntryState.loading());

    final result = await _incomeRepository.editIncomeEntries(
      event.incomeId,
      event.incomeEntry,
    );

    result.fold(
      (failure) => emit(EditIncomeEntryState.failure(failure)),
      (data) => emit(EditIncomeEntryState.loaded(data)),
    );
  }
}
