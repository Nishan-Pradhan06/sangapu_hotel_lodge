part of 'room_entry_bloc.dart';

@freezed
abstract class RoomEntryEvent with _$RoomEntryEvent {
  const factory RoomEntryEvent.roomEntry(RoomEntryModel roomEntryModel) = _RoomEntryModel;
}