part of 'edit_expenses_bloc.dart';

@freezed
class EditExpensesEvent with _$EditExpensesEvent {
  const factory EditExpensesEvent.started() = _Started;
}