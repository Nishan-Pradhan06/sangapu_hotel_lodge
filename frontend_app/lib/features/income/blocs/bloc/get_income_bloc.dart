import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../model/income_model.dart';
import '../../repository/income_repository.dart';

part 'get_income_event.dart';
part 'get_income_state.dart';
part 'get_income_bloc.freezed.dart';

class GetIncomeBloc extends Bloc<GetIncomeEvent, GetIncomeState> {
  final IncomeRepository _incomeRepository;
  GetIncomeBloc({required IncomeRepository repo})
    : _incomeRepository = repo,
      super(GetIncomeState.initial()) {
    on<_GetIncomeEvent>(_onGetIncome);
  }
  Future<void> _onGetIncome(
    _GetIncomeEvent event,
    Emitter<GetIncomeState> emit,
  ) async {
    emit(const GetIncomeState.loading());
    final result = await _incomeRepository.getIncomeSummary();
    result.fold(
      (failure) => emit(GetIncomeState.failure(failure)),
      (income) => emit(GetIncomeState.loaded(income)),
    );
  }
}
