part of 'get_income_bloc.dart';

@freezed
abstract class GetIncomeEvent with _$GetIncomeEvent {
  const factory GetIncomeEvent.getIncome({@Default(false) bool shouldShowLoadingIndicator}) = _GetIncomeEvent;
}