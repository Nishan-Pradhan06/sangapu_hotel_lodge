import 'package:dartz/dartz.dart';
import 'package:sangapu/common/typedef/either_type.dart';
import 'package:sangapu/core/network/api_services.dart';
import 'package:sangapu/features/banners/models/get_banner_model.dart';

abstract interface class BannerRepository {
  FutureEither<List<GetBannerModel>> getBanners();
}

class BannerRepositoryImpl implements BannerRepository {
  final ApiService _apiService;

  BannerRepositoryImpl({required ApiService apiService})
    : _apiService = apiService;

  @override
  FutureEither<List<GetBannerModel>> getBanners() async {
    final response = await _apiService.get('banners/');

    return response.fold((failure) => Left(failure), (data) {
      final banners = (data as List<dynamic>)
          .map((item) => GetBannerModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(banners);
    });
  }
}
