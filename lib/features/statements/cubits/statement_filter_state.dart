part of 'statement_filter_cubit.dart';

@freezed
abstract class StatementFilterState with _$StatementFilterState {
  const factory StatementFilterState({
    DateTime? dateFrom,
    DateTime? dateTo,

    /// 'Income' | 'Expense' | null = All
    String? type,
  }) = _StatementFilterState;
}
