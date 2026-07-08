import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../common/typedef/either_type.dart';
import '../../../core/network/api_services.dart';

abstract interface class ExportStatementRepository {
  FutureEither<Uint8List> exportStatementExcel({
    String? type,
    String? date,
    String? month,
    String? ordering,
  });
}

class ExportStatementRepositoryImpl implements ExportStatementRepository {
  final ApiService _apiService;

  ExportStatementRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<Uint8List> exportStatementExcel({
    String? type,
    String? date,
    String? month,
    String? ordering,
  }) async {
    final queryParams = <String, dynamic>{};
    if (type != null) queryParams['type'] = type;
    if (date != null) queryParams['date'] = date;
    if (month != null) queryParams['month'] = month;
    if (ordering != null) queryParams['ordering'] = ordering;

    final response = await _apiService.get<List<int>>(
      'statement/export/excel/',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      options: Options(responseType: ResponseType.bytes),
    );

    return response.fold(
      (failure) => Left(failure),
      (bytes) => Right(Uint8List.fromList(bytes)),
    );
  }
}
