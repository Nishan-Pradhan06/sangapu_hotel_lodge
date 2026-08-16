part of 'room_beverage_bloc.dart';

@freezed
abstract class RoomBeverageEvent with _$RoomBeverageEvent {
  const factory RoomBeverageEvent.getRoomBeverageSummary({
    @Default(false) bool shouldShowLoadingIndicator,
  }) = _GetRoomBeverageSummary;
}