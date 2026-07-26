// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_income_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetIncomeEvent {

 bool get shouldShowLoadingIndicator;
/// Create a copy of GetIncomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetIncomeEventCopyWith<GetIncomeEvent> get copyWith => _$GetIncomeEventCopyWithImpl<GetIncomeEvent>(this as GetIncomeEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetIncomeEvent&&(identical(other.shouldShowLoadingIndicator, shouldShowLoadingIndicator) || other.shouldShowLoadingIndicator == shouldShowLoadingIndicator));
}


@override
int get hashCode => Object.hash(runtimeType,shouldShowLoadingIndicator);

@override
String toString() {
  return 'GetIncomeEvent(shouldShowLoadingIndicator: $shouldShowLoadingIndicator)';
}


}

/// @nodoc
abstract mixin class $GetIncomeEventCopyWith<$Res>  {
  factory $GetIncomeEventCopyWith(GetIncomeEvent value, $Res Function(GetIncomeEvent) _then) = _$GetIncomeEventCopyWithImpl;
@useResult
$Res call({
 bool shouldShowLoadingIndicator
});




}
/// @nodoc
class _$GetIncomeEventCopyWithImpl<$Res>
    implements $GetIncomeEventCopyWith<$Res> {
  _$GetIncomeEventCopyWithImpl(this._self, this._then);

  final GetIncomeEvent _self;
  final $Res Function(GetIncomeEvent) _then;

/// Create a copy of GetIncomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shouldShowLoadingIndicator = null,}) {
  return _then(_self.copyWith(
shouldShowLoadingIndicator: null == shouldShowLoadingIndicator ? _self.shouldShowLoadingIndicator : shouldShowLoadingIndicator // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GetIncomeEvent].
extension GetIncomeEventPatterns on GetIncomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetIncomeEvent value)?  getIncome,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetIncomeEvent() when getIncome != null:
return getIncome(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetIncomeEvent value)  getIncome,}){
final _that = this;
switch (_that) {
case _GetIncomeEvent():
return getIncome(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetIncomeEvent value)?  getIncome,}){
final _that = this;
switch (_that) {
case _GetIncomeEvent() when getIncome != null:
return getIncome(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool shouldShowLoadingIndicator)?  getIncome,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetIncomeEvent() when getIncome != null:
return getIncome(_that.shouldShowLoadingIndicator);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool shouldShowLoadingIndicator)  getIncome,}) {final _that = this;
switch (_that) {
case _GetIncomeEvent():
return getIncome(_that.shouldShowLoadingIndicator);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool shouldShowLoadingIndicator)?  getIncome,}) {final _that = this;
switch (_that) {
case _GetIncomeEvent() when getIncome != null:
return getIncome(_that.shouldShowLoadingIndicator);case _:
  return null;

}
}

}

/// @nodoc


class _GetIncomeEvent implements GetIncomeEvent {
  const _GetIncomeEvent({this.shouldShowLoadingIndicator = false});
  

@override@JsonKey() final  bool shouldShowLoadingIndicator;

/// Create a copy of GetIncomeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetIncomeEventCopyWith<_GetIncomeEvent> get copyWith => __$GetIncomeEventCopyWithImpl<_GetIncomeEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetIncomeEvent&&(identical(other.shouldShowLoadingIndicator, shouldShowLoadingIndicator) || other.shouldShowLoadingIndicator == shouldShowLoadingIndicator));
}


@override
int get hashCode => Object.hash(runtimeType,shouldShowLoadingIndicator);

@override
String toString() {
  return 'GetIncomeEvent.getIncome(shouldShowLoadingIndicator: $shouldShowLoadingIndicator)';
}


}

/// @nodoc
abstract mixin class _$GetIncomeEventCopyWith<$Res> implements $GetIncomeEventCopyWith<$Res> {
  factory _$GetIncomeEventCopyWith(_GetIncomeEvent value, $Res Function(_GetIncomeEvent) _then) = __$GetIncomeEventCopyWithImpl;
@override @useResult
$Res call({
 bool shouldShowLoadingIndicator
});




}
/// @nodoc
class __$GetIncomeEventCopyWithImpl<$Res>
    implements _$GetIncomeEventCopyWith<$Res> {
  __$GetIncomeEventCopyWithImpl(this._self, this._then);

  final _GetIncomeEvent _self;
  final $Res Function(_GetIncomeEvent) _then;

/// Create a copy of GetIncomeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shouldShowLoadingIndicator = null,}) {
  return _then(_GetIncomeEvent(
shouldShowLoadingIndicator: null == shouldShowLoadingIndicator ? _self.shouldShowLoadingIndicator : shouldShowLoadingIndicator // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
