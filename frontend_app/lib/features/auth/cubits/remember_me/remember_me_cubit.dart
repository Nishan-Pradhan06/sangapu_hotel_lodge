import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangapu/core/services/cache_service.dart';
import 'package:sangapu/core/state/bloc_base_state.dart';

part 'remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeState> {
  RememberMeCubit() : super(const BaseState.initial());

  /// Loads saved state and returns cached email/password if available
  Future<Map<String, String?>> loadRememberMe() async {
    final bool isRemembered = CacheServices.instance.getRememberMe();
    emit(BaseState.loaded(isRemembered));

    if (isRemembered) {
      return await CacheServices.instance.getRememberedCredentials();
    }
    return {'email': null, 'password': null};
  }

  /// Toggle checkbox state and save to cache
  Future<void> toggleRememberMe(bool value) async {
    await CacheServices.instance.setRememberMe(value);
    emit(BaseState.loaded(value));
  }

  /// Call this on successful login to persist or wipe saved credentials
  Future<void> handleLoginSuccess({
    required String email,
    required String password,
  }) async {
    final isRemembered = state.maybeWhen(
      loaded: (value) => value,
      orElse: () => false,
    );

    await CacheServices.instance.saveCredentials(
      rememberMe: isRemembered,
      email: email,
      password: password,
    );
  }
}
