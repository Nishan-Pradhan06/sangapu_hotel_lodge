import 'package:dartz/dartz.dart';
import 'package:sangapu/features/statements/models/transcations_model.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';

abstract interface class TransactionRepository {
  FutureEither<TransactionResponse> getTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  final ApiService _apiService;

  TransactionRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<TransactionResponse> getTransactions() async {
    final response = await _apiService.get<Map<String, dynamic>>('statement/');

    return response.fold(
      (failure) => Left(failure),
      (success) => Right(TransactionResponse.fromJson(success)),
    );
  }
}
