
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/core/state/bloc_base_state.dart';

import '../../models/room_entry_model.dart';

part 'room_entry_event.dart';
part 'room_entry_state.dart';
part 'room_entry_bloc.freezed.dart';

class RoomEntryBloc extends Bloc<RoomEntryEvent, RoomEntryState> {
  RoomEntryBloc() : super(RoomEntryState.initial()) {
    on<RoomEntryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
