part of 'statements_bloc.dart';

@freezed
class StatementsEvent with _$StatementsEvent {
  const factory StatementsEvent.getStatement() = _StatementEvent;
}