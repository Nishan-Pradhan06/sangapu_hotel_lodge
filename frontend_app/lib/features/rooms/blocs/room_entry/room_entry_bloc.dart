import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/core/state/bloc_base_state.dart';
import '../../models/room_entry_model.dart';
import '../../repository/room_entry_repository.dart';
part 'room_entry_event.dart';
part 'room_entry_state.dart';
part 'room_entry_bloc.freezed.dart';

class RoomEntryBloc extends Bloc<RoomEntryEvent, RoomEntryState> {
  final RoomEntryRepository _roomEntryRepository;
  RoomEntryBloc({required RoomEntryRepository repo})
    : _roomEntryRepository = repo,
      super(RoomEntryState.initial()) {
    on<RoomEntryEvent>(_onRoomEntry);
  }

  Future<void> _onRoomEntry(
    RoomEntryEvent event,
    Emitter<RoomEntryState> emit,
  ) async {
    emit(RoomEntryState.loading());

    final result = await _roomEntryRepository.roomEntries(
      roomEntry: event.roomEntryModel,
    );

    result.fold(
      (failure) => emit(RoomEntryState.failure(failure)),
      (success) => emit(RoomEntryState.loaded("Room entry successful")),
    );
  }
}
