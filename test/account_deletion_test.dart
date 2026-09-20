import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sangapu/common/error/failure.dart';
import 'package:sangapu/common/typedef/either_type.dart';
import 'package:sangapu/features/auth/cubits/account_deletions/account_deletion_cubit.dart';
import 'package:sangapu/features/auth/models/login_model.dart';
import 'package:sangapu/features/auth/repository/auth_repository.dart';
import 'package:sangapu/routers/app_routes_names.dart';

class MockSuccessAuthRepository implements AuthRepository {
  @override
  FutureEither<String> deleteAccount({String? password}) async {
    return const Right('Account deleted successfully');
  }

  @override
  FutureEither<String> logIn({required LogInModel logIn}) async {
    return const Right('Login successful');
  }

  @override
  FutureEither<String> logOut() async {
    return const Right('Logout successful');
  }
}

class MockFailureAuthRepository implements AuthRepository {
  @override
  FutureEither<String> deleteAccount({String? password}) async {
    return const Left(AuthFailure(message: 'Invalid password'));
  }

  @override
  FutureEither<String> logIn({required LogInModel logIn}) async {
    return const Left(AuthFailure(message: 'Login failed'));
  }

  @override
  FutureEither<String> logOut() async {
    return const Left(AuthFailure(message: 'Logout failed'));
  }
}

void main() {
  group('Account Deletion Tests', () {
    test('AppRoutesName has deleteAccount route name configured', () {
      expect(AppRoutesName.deleteAccount, 'deleteAccount');
    });

    test('AccountDeletionCubit emits loaded on successful deletion', () async {
      final repo = MockSuccessAuthRepository();
      final cubit = AccountDeletionCubit(repo: repo);

      expect(cubit.state, const AccountDeletionState.initial());

      final expectedStates = [
        const AccountDeletionState.loading(),
        const AccountDeletionState.loaded('Account deleted successfully'),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.deleteAccount(password: 'secret123');
      await cubit.close();
    });

    test('AccountDeletionCubit emits failure on failed deletion', () async {
      final repo = MockFailureAuthRepository();
      final cubit = AccountDeletionCubit(repo: repo);

      final expectedStates = [
        const AccountDeletionState.loading(),
        const AccountDeletionState.failure(AuthFailure(message: 'Invalid password')),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.deleteAccount(password: 'wrongpassword');
      await cubit.close();
    });
  });
}
