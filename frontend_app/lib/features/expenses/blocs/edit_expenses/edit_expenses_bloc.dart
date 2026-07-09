import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../repository/expenses_repository.dart';

part 'edit_expenses_event.dart';
part 'edit_expenses_state.dart';
part 'edit_expenses_bloc.freezed.dart';

class EditExpensesBloc extends Bloc<EditExpensesEvent, EditExpensesState> {
  final ExpensesRepository _expensesRepository;
  EditExpensesBloc({required ExpensesRepository repo})
    : _expensesRepository = repo,
      super(EditExpensesState.initial()) {
    on<EditExpensesEvent>(_onEditExpense);
  }

  Future<void> _onEditExpense(
    EditExpensesEvent event,
    Emitter<EditExpensesState> emit,
  ) async {
    emit(EditExpensesState.loading());
    final result = await _expensesRepository.editExpense(event.expensesId);
    result.fold(
      (failure) => emit(EditExpensesState.failure(failure)),
      (success) => emit(EditExpensesState.loaded(success)),
    );
  }
}
