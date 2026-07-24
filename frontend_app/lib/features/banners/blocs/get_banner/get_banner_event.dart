part of 'get_banner_bloc.dart';

@freezed
abstract class GetBannerEvent with _$GetBannerEvent {
  const factory GetBannerEvent.getBanner({
    @Default(false) bool shouldShowLoadingIndicator,
  }) = _GetBannerEvent;
}