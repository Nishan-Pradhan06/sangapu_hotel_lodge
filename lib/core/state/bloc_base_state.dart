import 'package:freezed_annotation/freezed_annotation.dart';
import '../../common/error/failure.dart';
part 'bloc_base_state.old_freezed.dart';

@freezed
class BaseState<T> with _$BaseState<T> {
  const factory BaseState.initial() = _Initial;
  const factory BaseState.loading() = _Loading;
  const factory BaseState.loaded(T data) = _Loaded;
  const factory BaseState.failure(Failure failure) = _Failure;
}
