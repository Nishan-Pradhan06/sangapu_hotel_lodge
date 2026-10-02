import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/cache_service.dart';
import '../../../../core/state/bloc_base_state.dart';
import '../../models/user_profile_model.dart';
import '../../repository/auth_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepository;

  ProfileCubit({required AuthRepository repo})
    : _authRepository = repo,
      super(const BaseState.initial());

  Future<void> fetchProfile({bool forceRefresh = false}) async {
    final token = await CacheServices.instance.getAuthToken();
    if (token == null || token.isEmpty) {
      emit(const BaseState.initial());
      return;
    }

    // If already loaded and not forcing refresh, preserve state
    final isLoaded = state.maybeWhen(loaded: (_) => true, orElse: () => false);
    if (!forceRefresh && !isLoaded) {
      emit(const BaseState.loading());
    }

    final result = await _authRepository.getProfile();
    result.fold(
      (failure) => emit(BaseState.failure(failure)),
      (profile) => emit(BaseState.loaded(profile)),
    );
  }

  void reset() {
    emit(const BaseState.initial());
  }
}
