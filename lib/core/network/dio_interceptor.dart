import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:sangapu/core/config/env_config.dart';
import '../../../../common/logger.dart';
import '../services/cache_service.dart';

class AppDioInterceptor extends Interceptor {
  final List<String> _noAuthPaths = [
    "auth/login/",
    "auth/signup/",
    "auth/forgot-password/",
  ];

  Completer<String?>? _refreshCompleter;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String path = options.uri.path;

    // Skip adding token for auth endpoints
    if (_noAuthPaths.any((e) => path.contains(e))) {
      return handler.next(options);
    }

    // Add token for all other endpoints
    final String? token = await CacheServices.instance.getAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final int? statusCode = err.response?.statusCode;
    final String path = err.requestOptions.uri.path;

    dLog.d("[Error] ${statusCode ?? 'Unknown Status'} on $path");

    if (statusCode == 401 && _refreshCompleter == null) {
      final Dio newDio = Dio();

      _refreshCompleter = Completer<String?>();
      final refreshToken = await CacheServices.instance.getAuthRefreshToken();

      try {
        final response = await newDio.post(
          "${EnvConfig.instance.apiBaseUrl}auth/refresh/",
          data: {"refresh": refreshToken},
        );

        final accessToken = response.data['access'];
        await CacheServices.instance.setAuthToken(
          access: accessToken,
          refresh: refreshToken!,
        );
        _refreshCompleter?.complete(accessToken);
      } catch (e) {
        _refreshCompleter?.complete(null);
      }
    }

    log("Hello thi si serror ${err.message}");

    return handler.reject(err);
  }
}
