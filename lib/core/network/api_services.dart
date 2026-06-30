import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../common/error/error_handler.dart';
import '../../common/error/failure.dart';


class ApiService {
  final Dio _dio;
  final RetryOptions _retryOptions;

  ApiService(this._dio, this._retryOptions);

  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final Response response = await _retryOptions.retry(
        () => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        retryIf: (Exception e) => e is DioException && _shouldRetry(e),
      );

      return Right(
        fromJson != null ? fromJson(response.data) : response.data as T,
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  Future<Either<Failure, T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final Response response = await _retryOptions.retry(
        () => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        retryIf: (Exception e) => e is DioException && _shouldRetry(e),
      );

      return Right(
        fromJson != null ? fromJson(response.data) : response.data as T,
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  Future<Either<Failure, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final Response response = await _retryOptions.retry(
        () => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        retryIf: (Exception e) => e is DioException && _shouldRetry(e),
      );

      return Right(
        fromJson != null ? fromJson(response.data) : response.data as T,
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  Future<Either<Failure, T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final Response response = await _retryOptions.retry(
        () => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        retryIf: (Exception e) => e is DioException && _shouldRetry(e),
      );

      return Right(
        fromJson != null ? fromJson(response.data) : response.data as T,
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  Future<Either<Failure, T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final Response response = await _retryOptions.retry(
        () => _dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
        retryIf: (Exception e) => e is DioException && _shouldRetry(e),
      );

      return Right(
        fromJson != null ? fromJson(response.data) : response.data as T,
      );
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  bool _shouldRetry(DioException error) {
    return error.type != DioExceptionType.cancel &&
        (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout ||
            error.response?.statusCode == 500 ||
            error.response?.statusCode == 503);
  }
}
