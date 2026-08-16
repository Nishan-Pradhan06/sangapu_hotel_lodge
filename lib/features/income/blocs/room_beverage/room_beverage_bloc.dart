import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/core/state/bloc_base_state.dart';
import 'package:sangapu/features/income/model/room_beverage.dart';
import 'package:sangapu/features/income/repository/income_repository.dart';

part 'room_beverage_event.dart';
part 'room_beverage_state.dart';
part 'room_beverage_bloc.freezed.dart';

class RoomBeverageBloc extends Bloc<RoomBeverageEvent, RoomBeverageState> {
  final IncomeRepository _incomeRepository;
  RoomBeverageBloc({required IncomeRepository repo})
    : _incomeRepository = repo,
      super(RoomBeverageState.initial()) {
    on<_GetRoomBeverageSummary>(_onGetRoomBeverageSummary);
  }

  Future<void> _onGetRoomBeverageSummary(
    _GetRoomBeverageSummary event,
    Emitter<RoomBeverageState> emit,
  ) async {
    if (event.shouldShowLoadingIndicator) {
      emit(RoomBeverageState.loading());
    }

    final result = await _incomeRepository.getRoomBeverageSummary();

    result.fold(
      (failure) => emit(RoomBeverageState.failure(failure)),
      (data) => emit(RoomBeverageState.loaded(data)),
    );
  }
}
