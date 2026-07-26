// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_expenses_record_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddExpensesRecordEvent {

 ExpensesRecordModel get expensesRecordModel;
/// Create a copy of AddExpensesRecordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpensesRecordEventCopyWith<AddExpensesRecordEvent> get copyWith => _$AddExpensesRecordEventCopyWithImpl<AddExpensesRecordEvent>(this as AddExpensesRecordEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpensesRecordEvent&&(identical(other.expensesRecordModel, expensesRecordModel) || other.expensesRecordModel == expensesRecordModel));
}


@override
int get hashCode => Object.hash(runtimeType,expensesRecordModel);

@override
String toString() {
  return 'AddExpensesRecordEvent(expensesRecordModel: $expensesRecordModel)';
}


}

/// @nodoc
abstract mixin class $AddExpensesRecordEventCopyWith<$Res>  {
  factory $AddExpensesRecordEventCopyWith(AddExpensesRecordEvent value, $Res Function(AddExpensesRecordEvent) _then) = _$AddExpensesRecordEventCopyWithImpl;
@useResult
$Res call({
 ExpensesRecordModel expensesRecordModel
});




}
/// @nodoc
class _$AddExpensesRecordEventCopyWithImpl<$Res>
    implements $AddExpensesRecordEventCopyWith<$Res> {
  _$AddExpensesRecordEventCopyWithImpl(this._self, this._then);

  final AddExpensesRecordEvent _self;
  final $Res Function(AddExpensesRecordEvent) _then;

/// Create a copy of AddExpensesRecordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expensesRecordModel = null,}) {
  return _then(_self.copyWith(
expensesRecordModel: null == expensesRecordModel ? _self.expensesRecordModel : expensesRecordModel // ignore: cast_nullable_to_non_nullable
as ExpensesRecordModel,
  ));
}

}


/// Adds pattern-matching-related methods to [AddExpensesRecordEvent].
extension AddExpensesRecordEventPatterns on AddExpensesRecordEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AddExpensesRecordEvent value)?  addExpensesRecord,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddExpensesRecordEvent() when addExpensesRecord != null:
return addExpensesRecord(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AddExpensesRecordEvent value)  addExpensesRecord,}){
final _that = this;
switch (_that) {
case _AddExpensesRecordEvent():
return addExpensesRecord(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AddExpensesRecordEvent value)?  addExpensesRecord,}){
final _that = this;
switch (_that) {
case _AddExpensesRecordEvent() when addExpensesRecord != null:
return addExpensesRecord(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ExpensesRecordModel expensesRecordModel)?  addExpensesRecord,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddExpensesRecordEvent() when addExpensesRecord != null:
return addExpensesRecord(_that.expensesRecordModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ExpensesRecordModel expensesRecordModel)  addExpensesRecord,}) {final _that = this;
switch (_that) {
case _AddExpensesRecordEvent():
return addExpensesRecord(_that.expensesRecordModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ExpensesRecordModel expensesRecordModel)?  addExpensesRecord,}) {final _that = this;
switch (_that) {
case _AddExpensesRecordEvent() when addExpensesRecord != null:
return addExpensesRecord(_that.expensesRecordModel);case _:
  return null;

}
}

}

/// @nodoc


class _AddExpensesRecordEvent implements AddExpensesRecordEvent {
  const _AddExpensesRecordEvent(this.expensesRecordModel);
  

@override final  ExpensesRecordModel expensesRecordModel;

/// Create a copy of AddExpensesRecordEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddExpensesRecordEventCopyWith<_AddExpensesRecordEvent> get copyWith => __$AddExpensesRecordEventCopyWithImpl<_AddExpensesRecordEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddExpensesRecordEvent&&(identical(other.expensesRecordModel, expensesRecordModel) || other.expensesRecordModel == expensesRecordModel));
}


@override
int get hashCode => Object.hash(runtimeType,expensesRecordModel);

@override
String toString() {
  return 'AddExpensesRecordEvent.addExpensesRecord(expensesRecordModel: $expensesRecordModel)';
}


}

/// @nodoc
abstract mixin class _$AddExpensesRecordEventCopyWith<$Res> implements $AddExpensesRecordEventCopyWith<$Res> {
  factory _$AddExpensesRecordEventCopyWith(_AddExpensesRecordEvent value, $Res Function(_AddExpensesRecordEvent) _then) = __$AddExpensesRecordEventCopyWithImpl;
@override @useResult
$Res call({
 ExpensesRecordModel expensesRecordModel
});




}
/// @nodoc
class __$AddExpensesRecordEventCopyWithImpl<$Res>
    implements _$AddExpensesRecordEventCopyWith<$Res> {
  __$AddExpensesRecordEventCopyWithImpl(this._self, this._then);

  final _AddExpensesRecordEvent _self;
  final $Res Function(_AddExpensesRecordEvent) _then;

/// Create a copy of AddExpensesRecordEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expensesRecordModel = null,}) {
  return _then(_AddExpensesRecordEvent(
null == expensesRecordModel ? _self.expensesRecordModel : expensesRecordModel // ignore: cast_nullable_to_non_nullable
as ExpensesRecordModel,
  ));
}


}

// dart format on
