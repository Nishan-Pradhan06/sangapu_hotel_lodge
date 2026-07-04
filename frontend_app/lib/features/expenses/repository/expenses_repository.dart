import 'package:dartz/dartz.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../models/create_expenses.dart';
import '../models/expenses_response.dart';

abstract interface class ExpensesRepository {
  FutureEither<ExpenseResponse> getExpenses();
  FutureEither<String> createExpense(ExpensesRecordModel expensesRecordModel);
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

  @override
  FutureEither<String> createExpense(
    ExpensesRecordModel expensesRecordModel,
  ) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      'expenses/entries/',
      data: expensesRecordModel.toJson(),
    );

    return response.fold(
      (failure) => Left(failure),
      (_) => const Right('Expense created successfully'),
    );
  }
}
