import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import '../../../common/error/failure.dart';
import '../../../core/network/api_services.dart';
import '../../../core/services/cache_policy_service.dart';
import '../models/app_version_info.dart';

abstract interface class AppUpdateRepository {
  Future<Either<Failure, AppVersionInfo>> checkAppVersion();
}

class AppUpdateRepositoryImpl implements AppUpdateRepository {
  final ApiService _apiService;

  AppUpdateRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Failure, AppVersionInfo>> checkAppVersion() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      'app/version/',
      options: Options(
        extra: cacheOptions.copyWith(policy: CachePolicy.noCache).toExtra(),
      ),
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response.fold(
      (failure) => Left(failure),
      (data) => Right(AppVersionInfo.fromJson(data)),
    );
  }
}
