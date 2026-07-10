// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_expenses_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditExpensesEvent {

 int get expensesId;
 ExpensesRecordModel get expensesRecordModel;
/// Create a copy of EditExpensesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditExpensesEventCopyWith<EditExpensesEvent> get copyWith => _$EditExpensesEventCopyWithImpl<EditExpensesEvent>(this as EditExpensesEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditExpensesEvent&&(identical(other.expensesId, expensesId) || other.expensesId == expensesId)&&(identical(other.expensesRecordModel, expensesRecordModel) || other.expensesRecordModel == expensesRecordModel));
}


@override
int get hashCode => Object.hash(runtimeType,expensesId,expensesRecordModel);

@override
String toString() {
  return 'EditExpensesEvent(expensesId: $expensesId, expensesRecordModel: $expensesRecordModel)';
}


}

/// @nodoc
abstract mixin class $EditExpensesEventCopyWith<$Res>  {
  factory $EditExpensesEventCopyWith(EditExpensesEvent value, $Res Function(EditExpensesEvent) _then) = _$EditExpensesEventCopyWithImpl;
@useResult
$Res call({
 int expensesId,
 ExpensesRecordModel expensesRecordModel
});




}
/// @nodoc
class _$EditExpensesEventCopyWithImpl<$Res>
    implements $EditExpensesEventCopyWith<$Res> {
  _$EditExpensesEventCopyWithImpl(this._self, this._then);

  final EditExpensesEvent _self;
  final $Res Function(EditExpensesEvent) _then;

/// Create a copy of EditExpensesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expensesId = null,Object? expensesRecordModel = null,}) {
  return _then(_self.copyWith(
expensesId: null == expensesId ? _self.expensesId : expensesId // ignore: cast_nullable_to_non_nullable
as int,expensesRecordModel: null == expensesRecordModel ? _self.expensesRecordModel : expensesRecordModel // ignore: cast_nullable_to_non_nullable
as ExpensesRecordModel,
  ));
}

}


/// Adds pattern-matching-related methods to [EditExpensesEvent].
extension EditExpensesEventPatterns on EditExpensesEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _EditExpenseEvent value)?  editExpense,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditExpenseEvent() when editExpense != null:
return editExpense(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _EditExpenseEvent value)  editExpense,}){
final _that = this;
switch (_that) {
case _EditExpenseEvent():
return editExpense(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _EditExpenseEvent value)?  editExpense,}){
final _that = this;
switch (_that) {
case _EditExpenseEvent() when editExpense != null:
return editExpense(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int expensesId, ExpensesRecordModel expensesRecordModel)?  editExpense,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditExpenseEvent() when editExpense != null:
return editExpense(_that.expensesId, _that.expensesRecordModel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int expensesId, ExpensesRecordModel expensesRecordModel)  editExpense,}) {final _that = this;
switch (_that) {
case _EditExpenseEvent():
return editExpense(_that.expensesId, _that.expensesRecordModel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int expensesId, ExpensesRecordModel expensesRecordModel)?  editExpense,}) {final _that = this;
switch (_that) {
case _EditExpenseEvent() when editExpense != null:
return editExpense(_that.expensesId, _that.expensesRecordModel);case _:
  return null;

}
}

}

/// @nodoc


class _EditExpenseEvent implements EditExpensesEvent {
  const _EditExpenseEvent(this.expensesId, this.expensesRecordModel);
  

@override final  int expensesId;
@override final  ExpensesRecordModel expensesRecordModel;

/// Create a copy of EditExpensesEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditExpenseEventCopyWith<_EditExpenseEvent> get copyWith => __$EditExpenseEventCopyWithImpl<_EditExpenseEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditExpenseEvent&&(identical(other.expensesId, expensesId) || other.expensesId == expensesId)&&(identical(other.expensesRecordModel, expensesRecordModel) || other.expensesRecordModel == expensesRecordModel));
}


@override
int get hashCode => Object.hash(runtimeType,expensesId,expensesRecordModel);

@override
String toString() {
  return 'EditExpensesEvent.editExpense(expensesId: $expensesId, expensesRecordModel: $expensesRecordModel)';
}


}

/// @nodoc
abstract mixin class _$EditExpenseEventCopyWith<$Res> implements $EditExpensesEventCopyWith<$Res> {
  factory _$EditExpenseEventCopyWith(_EditExpenseEvent value, $Res Function(_EditExpenseEvent) _then) = __$EditExpenseEventCopyWithImpl;
@override @useResult
$Res call({
 int expensesId,
 ExpensesRecordModel expensesRecordModel
});




}
/// @nodoc
class __$EditExpenseEventCopyWithImpl<$Res>
    implements _$EditExpenseEventCopyWith<$Res> {
  __$EditExpenseEventCopyWithImpl(this._self, this._then);

  final _EditExpenseEvent _self;
  final $Res Function(_EditExpenseEvent) _then;

/// Create a copy of EditExpensesEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expensesId = null,Object? expensesRecordModel = null,}) {
  return _then(_EditExpenseEvent(
null == expensesId ? _self.expensesId : expensesId // ignore: cast_nullable_to_non_nullable
as int,null == expensesRecordModel ? _self.expensesRecordModel : expensesRecordModel // ignore: cast_nullable_to_non_nullable
as ExpensesRecordModel,
  ));
}


}

// dart format on
