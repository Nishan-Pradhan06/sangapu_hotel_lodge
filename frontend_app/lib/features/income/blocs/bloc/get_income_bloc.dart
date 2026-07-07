import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_income_event.dart';
part 'get_income_state.dart';
part 'get_income_bloc.freezed.dart';

class GetIncomeBloc extends Bloc<GetIncomeEvent, GetIncomeState> {
  GetIncomeBloc() : super(_Initial()) {
    on<GetIncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
