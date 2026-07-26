part of 'edit_income_entry_bloc.dart';

@freezed
abstract class EditIncomeEntryEvent with _$EditIncomeEntryEvent {
  const factory EditIncomeEntryEvent.editIncomeEntry(
    int incomeId,
    IncomeEntryModel incomeEntry,
  ) = _EditIncomeEntryEvent;
}
