import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/state/bloc_base_state.dart';
import '../../repository/auth_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepository _authRepository;
  LogoutCubit({required AuthRepository repo})
    : _authRepository = repo,
      super(LogoutState.initial());

  Future<void> logout() async {
    emit(LogoutState.loading());

    final result = await _authRepository.logOut();
    result.fold(
      (failure) => emit(LogoutState.failure(failure)),
      (success) => emit(LogoutState.loaded(success)),
    );
  }
}
