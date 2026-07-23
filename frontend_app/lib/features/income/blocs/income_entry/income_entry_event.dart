part of 'income_entry_bloc.dart';

@freezed
abstract class IncomeEntryEvent with _$IncomeEntryEvent {
  const factory IncomeEntryEvent.incomeEntry(IncomeEntryModel incomeEntryModel) =
      _IncomeEntryModel;
}
