
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/state/bloc_base_state.dart';
import '../../model/income_model.dart';

part 'get_income_event.dart';
part 'get_income_state.dart';
part 'get_income_bloc.freezed.dart';

class GetIncomeBloc extends Bloc<GetIncomeEvent, GetIncomeState> {
  GetIncomeBloc() : super(GetIncomeState.initial()) {
    on<GetIncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
