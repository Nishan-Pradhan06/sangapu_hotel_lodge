import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/features/banners/repository/banner_repository.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../models/get_banner_model.dart';

part 'get_banner_event.dart';
part 'get_banner_state.dart';
part 'get_banner_bloc.freezed.dart';

class GetBannerBloc extends Bloc<GetBannerEvent, GetBannerState> {
  final BannerRepository _bannerRepository;
  GetBannerBloc({required BannerRepository repo})
    : _bannerRepository = repo,
      super(GetBannerState.initial()) {
    on<_GetBannerEvent>(_onGetBanner);
  }

  Future<void> _onGetBanner(
    _GetBannerEvent event,
    Emitter<GetBannerState> emit,
  ) async {
    if (event.shouldShowLoadingIndicator) {
      emit(GetBannerState.loading());
    }

    final result = await _bannerRepository.getBanners();

    result.fold(
      (failure) => emit(GetBannerState.failure(failure)),
      (data) => emit(GetBannerState.loaded(data)),
    );
  }
}
