part of 'get_expenses_bloc.dart';

@freezed
abstract class GetExpensesEvent with _$GetExpensesEvent {
  const factory GetExpensesEvent.getExpenses({@Default(false) bool shouldShowLoadingIndicator}) = _ExpensesEvent;
}