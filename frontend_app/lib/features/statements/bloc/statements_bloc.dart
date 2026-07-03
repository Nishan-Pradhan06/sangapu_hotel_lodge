import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/state/bloc_base_state.dart';
import '../models/transcations_model.dart';
import '../repository/transcation_repository.dart';

part 'statements_event.dart';
part 'statements_state.dart';
part 'statements_bloc.freezed.dart';

class StatementsBloc extends Bloc<StatementsEvent, StatementsState> {
  final TransactionRepository _transactionRepository;
  StatementsBloc({required TransactionRepository repo})
    : _transactionRepository = repo,
      super(StatementsState.initial()) {
    on<StatementsEvent>(_onGetStatements);
  }
  Future<void> _onGetStatements(
    StatementsEvent event,
    Emitter<StatementsState> emit,
  ) async {
    emit(StatementsState.loading());
    final result = await _transactionRepository.getTransactions();
    result.fold(
      (failure) => emit(StatementsState.failure(failure)),
      (success) => emit(StatementsState.loaded(success)),
    );
  }
}
