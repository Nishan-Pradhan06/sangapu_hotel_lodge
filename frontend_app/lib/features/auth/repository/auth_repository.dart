import 'package:dartz/dartz.dart';
import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../../../core/services/cache_service.dart';
import '../models/login_model.dart';

abstract interface class AuthRepository {
  FutureEither<String> logIn({required LogInModel logIn});
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  AuthRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<String> logIn({required LogInModel logIn}) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      'auth/login/',
      data: logIn.toMap(),
    );

    return response.fold((failure) => Left(failure), (success) async {
      final accessToken = success['access'] as String;
      // final refreshToken = success['refresh'] as String;
      // final email = success['email'] as String;

      await CacheServices.instance.setAuthToken(accessToken);
      // await CacheServices.instance.setRefreshToken(refreshToken);
      // await CacheServices.instance.setEmail(email);

      return const Right('Login successful');
    });
  }
}
