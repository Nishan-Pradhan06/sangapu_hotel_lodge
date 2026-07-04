import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../models/create_expenses.dart';
import '../../repository/expenses_repository.dart';

part 'add_expenses_record_event.dart';
part 'add_expenses_record_state.dart';
part 'add_expenses_record_bloc.freezed.dart';

class AddExpensesRecordBloc
    extends Bloc<AddExpensesRecordEvent, AddExpensesRecordState> {
  final ExpensesRepository _expensesRepository;
  AddExpensesRecordBloc({required ExpensesRepository repo})
    : _expensesRepository = repo,
      super(AddExpensesRecordState.initial()) {
    on<_AddExpensesRecordEvent>(_onAddExpensesRecord);
  }

  Future<void> _onAddExpensesRecord(
    _AddExpensesRecordEvent event,
    Emitter<AddExpensesRecordState> emit,
  ) async {
    emit(AddExpensesRecordState.loading());
    final result = await _expensesRepository.createExpense(
      event.expensesRecordModel,
    );
    result.fold(
      (failure) => emit(AddExpensesRecordState.failure(failure)),
      (success) => emit(AddExpensesRecordState.loaded(success)),
    );
  }
}
