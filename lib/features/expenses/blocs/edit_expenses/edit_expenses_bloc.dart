import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../models/create_expenses.dart';
import '../../repository/expenses_repository.dart';

part 'edit_expenses_event.dart';
part 'edit_expenses_state.dart';
part 'edit_expenses_bloc.freezed.dart';

class EditExpensesBloc extends Bloc<EditExpensesEvent, EditExpensesState> {
  final ExpensesRepository _expensesRepository;
  EditExpensesBloc({required ExpensesRepository repo})
    : _expensesRepository = repo,
      super(EditExpensesState.initial()) {
    on<_EditExpenseEvent>(_onEditExpense);
  }

  Future<void> _onEditExpense(
    _EditExpenseEvent event,
    Emitter<EditExpensesState> emit,
  ) async {
    emit(EditExpensesState.loading());
    final result = await _expensesRepository.editExpense(event.expensesId, event.expensesRecordModel);
    result.fold(
      (failure) => emit(EditExpensesState.failure(failure)),
      (success) => emit(EditExpensesState.loaded(success)),
    );
  }
}
