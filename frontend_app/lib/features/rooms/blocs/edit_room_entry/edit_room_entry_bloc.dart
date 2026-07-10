import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/features/rooms/models/room_entry_model.dart';
import 'package:sangapu/features/rooms/repository/room_entry_repository.dart';

import '../../../../core/state/bloc_base_state.dart';

part 'edit_room_entry_event.dart';
part 'edit_room_entry_state.dart';
part 'edit_room_entry_bloc.freezed.dart';

class EditRoomEntryBloc extends Bloc<EditRoomEntryEvent, EditRoomEntryState> {
  final RoomEntryRepository _roomEntryRepository;
  EditRoomEntryBloc({required RoomEntryRepository repo})
    : _roomEntryRepository = repo,
      super(EditRoomEntryState.initial()) {
    on<_EditRoomEntryEvent>(_onEditRoomEntry);
  }

  Future<void> _onEditRoomEntry(
    EditRoomEntryEvent event,
    Emitter<EditRoomEntryState> emit,
  ) async {
    emit(EditRoomEntryState.loading());

    final result = await _roomEntryRepository.editRoomEntries(
      event.roomEntryId,
      event.roomModel,
    );

    result.fold(
      (failure) => emit(EditRoomEntryState.failure(failure)),
      (data) => emit(EditRoomEntryState.loaded(data)),
    );
  }
}
