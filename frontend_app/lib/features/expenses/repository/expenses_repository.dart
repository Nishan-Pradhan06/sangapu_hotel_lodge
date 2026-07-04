import 'package:dartz/dartz.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../models/expenses_response.dart';

abstract interface class ExpensesRepository {
  FutureEither<ExpenseResponse> getExpenses();
}

class ExpensesRepositoryImpl implements ExpensesRepository {
  final ApiService _apiService;

  ExpensesRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<ExpenseResponse> getExpenses() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      'expenses/entries/',
    );

    return response.fold(
      (failure) => Left(failure),
      (success) => Right(ExpenseResponse.fromJson(success)),
    );
  }
}
