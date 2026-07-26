import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final dynamic exception;
  const Failure({required this.message, this.statusCode, this.exception});
  @override
  List<Object?> get props => [message, statusCode, exception];
}

class DirectionRouteFailure extends Failure {
  const DirectionRouteFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Network related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Server related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Authentication related failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Input validation failures
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.statusCode,
    super.exception,
  });
}

/// Cache related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Payment related failures
class PaymentFailure extends Failure {
  const PaymentFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Permission related failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Unexpected failures that don't fit other categories
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

/// Timeout failures
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Operation timed out',
    super.statusCode,
    super.exception,
  });
}

/// Database related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

class MethodNotAllowedFailure extends Failure {
  const MethodNotAllowedFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}

///Just for testing
class TestFailure extends Failure {
  const TestFailure({
    required super.message,
    super.statusCode,
    super.exception,
  });
}
