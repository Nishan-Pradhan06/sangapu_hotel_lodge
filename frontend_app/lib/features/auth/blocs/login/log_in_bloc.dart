import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../models/login_model.dart';
import '../../repository/auth_repository.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';
part 'log_in_bloc.freezed.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final AuthRepository _authRepository;
  LogInBloc({required AuthRepository repo})
    : _authRepository = repo,
      super(LogInState.initial()) {
    on<LogInEvent>(_onLogin);
  }

  Future<void> _onLogin(LogInEvent event, Emitter<LogInState> emit) async {
    emit(LogInState.loading());

    final result = await _authRepository.logIn(logIn: event.loginModel);

    result.fold(
      (failure) => emit(LogInState.failure(failure)),
      (success) => emit(LogInState.loaded(success)),
    );
  }
}
