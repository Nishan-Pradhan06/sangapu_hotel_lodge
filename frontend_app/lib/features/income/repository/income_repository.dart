import 'package:dartz/dartz.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../model/income_model.dart';

abstract interface class IncomeRepository {
  FutureEither<IncomeSummaryResponse> getIncomeSummary();
}

class IncomeRepositoryImpl implements IncomeRepository {
  final ApiService _apiService;

  IncomeRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<IncomeSummaryResponse> getIncomeSummary() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      'income/',
    );

    return response.fold(
      (failure) => Left(failure),
      (success) => Right(IncomeSummaryResponse.fromJson(success)),
    );
  }

 
}
