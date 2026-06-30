import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../config/env_config.dart';
import 'dio_interceptor.dart';

class DioClient {
  late final Dio _dio;

  final BaseOptions _baseOptions = BaseOptions(
    baseUrl: EnvConfig.instance.apiBaseUrl,
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: <String, dynamic>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  DioClient() {
    _setupDio();
  }

  Dio get dio => _dio;

  void _setupDio() {
    _dio = Dio(_baseOptions);

    _addInterceptors();
  }

  void _addInterceptors() {
    if (EnvConfig.instance.enableLogging) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
      );
    }
    _dio.interceptors.add(AppDioInterceptor());
  }
}
