part of 'statements_bloc.dart';

@freezed
abstract class StatementsEvent with _$StatementsEvent {
  const factory StatementsEvent.getStatement({
    @Default(false) bool shouldShowLoadingIndicator,
    StatementFilter? filter,
  }) = _StatementEvent;
}