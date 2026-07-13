import 'package:dartz/dartz.dart';
import 'package:sangapu/features/statements/models/transcations_model.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';

// ---------------------------------------------------------------------------
// Plain filter model — no Freezed (plain class rule)
// ---------------------------------------------------------------------------

class StatementFilter {
  /// ISO date string yyyy-MM-dd — lower bound (inclusive)
  final String? dateFrom;

  /// ISO date string yyyy-MM-dd — upper bound (inclusive)
  final String? dateTo;

  /// 'Income' | 'Expense' | null (= all)
  final String? type;

  /// API ordering value, e.g. '-created_at' (newest first)
  final String? ordering;

  const StatementFilter({
    this.dateFrom,
    this.dateTo,
    this.type,
    this.ordering,
  });

  bool get isEmpty =>
      dateFrom == null && dateTo == null && type == null && ordering == null;

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (dateFrom != null) params['date_from'] = dateFrom;
    if (dateTo != null) params['date_to'] = dateTo;
    if (type != null) params['type'] = type;
    if (ordering != null) params['ordering'] = ordering;
    return params;
  }
}

// ---------------------------------------------------------------------------
// Repository
// ---------------------------------------------------------------------------

abstract interface class TransactionRepository {
  FutureEither<TransactionResponse> getTransactions({
    StatementFilter? filter,
  });
}

class TransactionRepositoryImpl implements TransactionRepository {
  final ApiService _apiService;

  TransactionRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<TransactionResponse> getTransactions({
    StatementFilter? filter,
  }) async {
    final queryParams =
        (filter != null && !filter.isEmpty) ? filter.toQueryParams() : null;

    final response = await _apiService.get<Map<String, dynamic>>(
      'statement/',
      queryParameters: queryParams,
    );

    return response.fold(
      (failure) => Left(failure),
      (success) => Right(TransactionResponse.fromJson(success)),
    );
  }
}
