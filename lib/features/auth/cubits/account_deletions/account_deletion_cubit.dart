import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/state/bloc_base_state.dart';
import '../../repository/auth_repository.dart';

part 'account_deletion_state.dart';

class AccountDeletionCubit extends Cubit<AccountDeletionState> {
  final AuthRepository _authRepository;

  AccountDeletionCubit({required AuthRepository repo})
      : _authRepository = repo,
        super(AccountDeletionState.initial());

  Future<void> deleteAccount({String? password}) async {
    emit(AccountDeletionState.loading());

    final result = await _authRepository.deleteAccount(password: password);
    result.fold(
      (failure) => emit(AccountDeletionState.failure(failure)),
      (success) => emit(AccountDeletionState.loaded(success)),
    );
  }

  void reset() {
    emit(AccountDeletionState.initial());
  }
}
