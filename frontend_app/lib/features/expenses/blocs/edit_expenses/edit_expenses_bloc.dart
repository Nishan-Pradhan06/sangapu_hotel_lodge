import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_expenses_event.dart';
part 'edit_expenses_state.dart';
part '../bloc/edit_expenses_bloc.freezed.dart';

class EditExpensesBloc extends Bloc<EditExpensesEvent, EditExpensesState> {
  EditExpensesBloc() : super(_Initial()) {
    on<EditExpensesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
