part of 'edit_expenses_bloc.dart';

@freezed
abstract class EditExpensesEvent with _$EditExpensesEvent {
  const factory EditExpensesEvent.editExpense(int expensesId) = _EditExpenseEvent;
}