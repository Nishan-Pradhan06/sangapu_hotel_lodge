part of 'edit_room_entry_bloc.dart';

@freezed
abstract class EditRoomEntryEvent with _$EditRoomEntryEvent {
  const factory EditRoomEntryEvent.editRoomEntry(int roomEntryId, RoomEntryModel roomModel) = _EditRoomEntryEvent;
}