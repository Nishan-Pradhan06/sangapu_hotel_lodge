import 'package:dartz/dartz.dart';
import 'package:sangapu/features/income/model/income_entry_model.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';
import '../model/income_model.dart';

abstract interface class IncomeRepository {
  FutureEither<IncomeSummaryResponse> getIncomeSummary();
  FutureEither<IncomeEntryModel> incomeEntries({
    required IncomeEntryModel incomeEntry,
  });

  FutureEither<String> editIncomeEntries(
    int incomeId,
    IncomeEntryModel incomeEntry,
  );
}

class IncomeRepositoryImpl implements IncomeRepository {
  final ApiService _apiService;

  IncomeRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<IncomeSummaryResponse> getIncomeSummary() async {
    final response = await _apiService.get<Map<String, dynamic>>('income/');

    return response.fold(
      (failure) => Left(failure),
      (success) => Right(IncomeSummaryResponse.fromJson(success)),
    );
  }

  @override
  FutureEither<IncomeEntryModel> incomeEntries({
    required IncomeEntryModel incomeEntry,
  }) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      'income/',
      data: incomeEntry.toMap(),
    );

    return response.fold((failure) => Left(failure), (success) async {
      return Right(IncomeEntryModel.fromMap(success));
    });
  }

  @override
  FutureEither<String> editIncomeEntries(
    int incomeId,
    IncomeEntryModel incomeEntry,
  ) async {
    final response = await _apiService.patch<Map<String, dynamic>>(
      'income/$incomeId/',
      data: incomeEntry.toMap(),
    );

    return response.fold((failure) => Left(failure), (success) {
      return Right("Entry Updated Successfully");
    });
  }
}
