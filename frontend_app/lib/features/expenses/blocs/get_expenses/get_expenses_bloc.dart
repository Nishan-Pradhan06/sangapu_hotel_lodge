import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../models/expenses_response.dart';
import '../../repository/expenses_repository.dart';

part 'get_expenses_event.dart';
part 'get_expenses_state.dart';
part 'get_expenses_bloc.freezed.dart';

class GetExpensesBloc extends Bloc<GetExpensesEvent, GetExpensesState> {
  final ExpensesRepository _expensesRepository;
  GetExpensesBloc({required ExpensesRepository repo})
    : _expensesRepository = repo,
      super(GetExpensesState.initial()) {
    on<_ExpensesEvent>(_onGetExpenses);
  }
  Future<void> _onGetExpenses(
    _ExpensesEvent event,
    Emitter<GetExpensesState> emit,
  ) async {
    emit(GetExpensesState.loading());
    final result = await _expensesRepository.getExpenses();
    result.fold(
      (failure) => emit(GetExpensesState.failure(failure)),
      (success) => emit(GetExpensesState.loaded(success)),
    );
  }
}
