part of 'add_expenses_record_bloc.dart';

@freezed
abstract class AddExpensesRecordEvent with _$AddExpensesRecordEvent {
  const factory AddExpensesRecordEvent.addExpensesRecord(ExpensesRecordModel expensesRecordModel) = _AddExpensesRecordEvent;
}