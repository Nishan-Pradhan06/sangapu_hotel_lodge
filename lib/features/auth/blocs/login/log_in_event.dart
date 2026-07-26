part of 'log_in_bloc.dart';

@freezed
abstract class LogInEvent with _$LogInEvent {
  const factory LogInEvent.login(LogInModel loginModel) = _LogInEvent;
}