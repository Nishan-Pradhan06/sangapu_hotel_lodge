import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangapu/features/statements/repository/transcation_repository.dart';

part 'statement_filter_state.dart';
part 'statement_filter_cubit.freezed.dart';

class StatementFilterCubit extends Cubit<StatementFilterState> {
  StatementFilterCubit() : super(const StatementFilterState());

  void setDateRange(DateTime from, DateTime to) {
    emit(state.copyWith(dateFrom: from, dateTo: to));
  }

  void setType(String? type) {
    emit(state.copyWith(type: type));
  }

  void clearDateRange() {
    emit(StatementFilterState(type: state.type));
  }

  void clearType() {
    emit(StatementFilterState(dateFrom: state.dateFrom, dateTo: state.dateTo));
  }

  void clearAll() {
    emit(const StatementFilterState());
  }

  bool get hasActiveFilter =>
      state.dateFrom != null || state.dateTo != null || state.type != null;

  /// Convert current state → a StatementFilter for the Bloc
  StatementFilter toFilter() {
    return StatementFilter(
      dateFrom: state.dateFrom != null
          ? _formatDate(state.dateFrom!)
          : null,
      dateTo: state.dateTo != null
          ? _formatDate(state.dateTo!)
          : null,
      type: state.type,
      ordering: '-created_at',
    );
  }

  String _formatDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
