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

    if (statusCode == 401) {
      try {
        if (_refreshCompleter == null || _refreshCompleter!.isCompleted) {
          _refreshCompleter = Completer<String?>();

          // You said you do not have a refresh token flow, so this only retries the request
          final currentToken = await CacheServices.instance.getAuthToken();
          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = 'Bearer $currentToken';

          final Dio retryDio = Dio(
            BaseOptions(
              baseUrl: EnvConfig.instance.apiBaseUrl,
              headers: requestOptions.headers,
            ),
          );

          final response = await retryDio.fetch(requestOptions);
          _refreshCompleter!.complete(response.statusCode?.toString());
          return handler.resolve(response);
        }

        await _refreshCompleter!.future;
      } catch (e) {
        dLog.e("Retry failed: $e");
      }
    }

    log("SERVER ERROR ${err.message}");

    return handler.reject(err);
  }
}
