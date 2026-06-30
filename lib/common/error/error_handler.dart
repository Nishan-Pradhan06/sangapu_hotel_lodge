import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorHandler {
  /// Handles exceptions and converts them to appropriate Failure types
  static Failure handleException(dynamic exception) {
    if (exception is DioException) {
      return _handleDioException(exception);
    } else if (exception is SocketException || exception is HttpException) {
      return NetworkFailure(
        message:
            'Network connection error. Please check your internet connection.',
        exception: exception,
      );
    } else if (exception is TimeoutException) {
      return TimeoutFailure(
        message: 'Request timed out. Please try again.',
        exception: exception,
      );
    } else if (exception is FormatException) {
      return ServerFailure(
        message: 'Invalid data format received from server.',
        exception: exception,
      );
    } else {
      return UnexpectedFailure(
        message: exception?.toString() ?? 'An unexpected error occurred.',
        exception: exception,
      );
    }
  }

  /// Handles Dio specific exceptions
  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          message: 'Connection timed out. Please try again.',
          exception: exception,
        );

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final responseData = exception.response?.data;

        if (statusCode == 401 || statusCode == 403) {
          return AuthFailure(
            message:
                _extractErrorMessage(responseData) ??
                'Authentication failed. Please login again.',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 404) {
          return ServerFailure(
            message: 'Resource not found.',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 409) {
          return ServerFailure(
            message: _extractErrorMessage(responseData) ?? 'Conflict.',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 405) {
          return MethodNotAllowedFailure(
            message: 'Method not allowed',
            statusCode: statusCode,
            exception: exception,
          );
        } else if (statusCode == 422 || statusCode == 400) {
          final errorMessage = _extractErrorMessage(responseData);
          final fieldErrors = _extractFieldErrors(responseData);

          return ValidationFailure(
            message: errorMessage ??
                (fieldErrors != null && fieldErrors.isNotEmpty
                    ? fieldErrors.values.first
                    : 'Validation Failed!'),
            fieldErrors: fieldErrors,
            exception: exception,
          );
        } else if (statusCode == 500 || statusCode == 503) {
          return ServerFailure(
            message: 'Server error. Please try again later.',
            statusCode: statusCode,
            exception: exception,
          );
        } else {
          return ServerFailure(
            message:
                _extractErrorMessage(responseData) ?? 'Server error occurred.',
            statusCode: statusCode,
            exception: exception,
          );
        }

      case DioExceptionType.cancel:
        return NetworkFailure(
          message: 'Request was cancelled.',
          exception: exception,
        );

      case DioExceptionType.connectionError:
        return NetworkFailure(
          message: 'Connection error. Please check your internet connection.',
          exception: exception,
        );

      case DioExceptionType.badCertificate:
        return NetworkFailure(
          message:
              'Invalid SSL certificate. Cannot establish secure connection.',
          exception: exception,
        );

      case DioExceptionType.unknown:
        return UnexpectedFailure(
          message: exception.message ?? 'An unexpected error occurred.',
          exception: exception,
        );
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  /// Extracts error message from response data
  static String? _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return null;

    try {
      if (responseData is Map) {
        // Try common error message fields
        return responseData['message'] ??
            responseData['detail'] ??
            responseData['error'] ??
            responseData['error_message'] ??
            responseData['error_description'] ??
            (responseData['non_field_errors'] is List
                ? (responseData['non_field_errors'] as List).first.toString()
                : responseData['non_field_errors']?.toString());
      } else if (responseData is String) {
        return responseData;
      }
    } catch (_) {
      // If parsing fails, return null
    }

    return null;
  }

  /// Extracts field-specific validation errors (dynamic keys)
  static Map<String, String>? _extractFieldErrors(dynamic responseData) {
    if (responseData == null || responseData is! Map) return null;

    try {
      final Map<String, dynamic> errorsSource;
      if (responseData.containsKey('errors') && responseData['errors'] is Map) {
        errorsSource = responseData['errors'];
      } else {
        // Assume the entire response might be a field error map
        errorsSource = Map<String, dynamic>.from(responseData);
      }

      final Map<String, String> extractedErrors = {};

      errorsSource.forEach((key, value) {
        // Skip common general message keys so they aren't treated as field names
        if ([
          'message',
          'detail',
          'error',
          'error_message',
          'error_description',
          'non_field_errors',
          'status_code',
          'success',
          'data'
        ].contains(key)) {
          return;
        }

        if (value is List && value.isNotEmpty) {
          extractedErrors[key.toString()] = value.first.toString();
        } else if (value is String) {
          extractedErrors[key.toString()] = value;
        } else if (value is Map) {
          // Nested errors
          final nested = _extractFieldErrors(value);
          if (nested != null && nested.isNotEmpty) {
            extractedErrors[key.toString()] = nested.values.first;
          }
        }
      });

      return extractedErrors.isNotEmpty ? extractedErrors : null;
    } catch (_) {
      return null;
    }
  }
}
