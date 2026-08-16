// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_beverage_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoomBeverageEvent {

 bool get shouldShowLoadingIndicator;
/// Create a copy of RoomBeverageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomBeverageEventCopyWith<RoomBeverageEvent> get copyWith => _$RoomBeverageEventCopyWithImpl<RoomBeverageEvent>(this as RoomBeverageEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomBeverageEvent&&(identical(other.shouldShowLoadingIndicator, shouldShowLoadingIndicator) || other.shouldShowLoadingIndicator == shouldShowLoadingIndicator));
}


@override
int get hashCode => Object.hash(runtimeType,shouldShowLoadingIndicator);

@override
String toString() {
  return 'RoomBeverageEvent(shouldShowLoadingIndicator: $shouldShowLoadingIndicator)';
}


}

/// @nodoc
abstract mixin class $RoomBeverageEventCopyWith<$Res>  {
  factory $RoomBeverageEventCopyWith(RoomBeverageEvent value, $Res Function(RoomBeverageEvent) _then) = _$RoomBeverageEventCopyWithImpl;
@useResult
$Res call({
 bool shouldShowLoadingIndicator
});




}
/// @nodoc
class _$RoomBeverageEventCopyWithImpl<$Res>
    implements $RoomBeverageEventCopyWith<$Res> {
  _$RoomBeverageEventCopyWithImpl(this._self, this._then);

  final RoomBeverageEvent _self;
  final $Res Function(RoomBeverageEvent) _then;

/// Create a copy of RoomBeverageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shouldShowLoadingIndicator = null,}) {
  return _then(_self.copyWith(
shouldShowLoadingIndicator: null == shouldShowLoadingIndicator ? _self.shouldShowLoadingIndicator : shouldShowLoadingIndicator // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomBeverageEvent].
extension RoomBeverageEventPatterns on RoomBeverageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetRoomBeverageSummary value)?  getRoomBeverageSummary,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetRoomBeverageSummary() when getRoomBeverageSummary != null:
return getRoomBeverageSummary(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetRoomBeverageSummary value)  getRoomBeverageSummary,}){
final _that = this;
switch (_that) {
case _GetRoomBeverageSummary():
return getRoomBeverageSummary(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetRoomBeverageSummary value)?  getRoomBeverageSummary,}){
final _that = this;
switch (_that) {
case _GetRoomBeverageSummary() when getRoomBeverageSummary != null:
return getRoomBeverageSummary(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool shouldShowLoadingIndicator)?  getRoomBeverageSummary,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetRoomBeverageSummary() when getRoomBeverageSummary != null:
return getRoomBeverageSummary(_that.shouldShowLoadingIndicator);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool shouldShowLoadingIndicator)  getRoomBeverageSummary,}) {final _that = this;
switch (_that) {
case _GetRoomBeverageSummary():
return getRoomBeverageSummary(_that.shouldShowLoadingIndicator);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool shouldShowLoadingIndicator)?  getRoomBeverageSummary,}) {final _that = this;
switch (_that) {
case _GetRoomBeverageSummary() when getRoomBeverageSummary != null:
return getRoomBeverageSummary(_that.shouldShowLoadingIndicator);case _:
  return null;

}
}

}

/// @nodoc


class _GetRoomBeverageSummary implements RoomBeverageEvent {
  const _GetRoomBeverageSummary({this.shouldShowLoadingIndicator = false});
  

@override@JsonKey() final  bool shouldShowLoadingIndicator;

/// Create a copy of RoomBeverageEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetRoomBeverageSummaryCopyWith<_GetRoomBeverageSummary> get copyWith => __$GetRoomBeverageSummaryCopyWithImpl<_GetRoomBeverageSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetRoomBeverageSummary&&(identical(other.shouldShowLoadingIndicator, shouldShowLoadingIndicator) || other.shouldShowLoadingIndicator == shouldShowLoadingIndicator));
}


@override
int get hashCode => Object.hash(runtimeType,shouldShowLoadingIndicator);

@override
String toString() {
  return 'RoomBeverageEvent.getRoomBeverageSummary(shouldShowLoadingIndicator: $shouldShowLoadingIndicator)';
}


}

/// @nodoc
abstract mixin class _$GetRoomBeverageSummaryCopyWith<$Res> implements $RoomBeverageEventCopyWith<$Res> {
  factory _$GetRoomBeverageSummaryCopyWith(_GetRoomBeverageSummary value, $Res Function(_GetRoomBeverageSummary) _then) = __$GetRoomBeverageSummaryCopyWithImpl;
@override @useResult
$Res call({
 bool shouldShowLoadingIndicator
});




}
/// @nodoc
class __$GetRoomBeverageSummaryCopyWithImpl<$Res>
    implements _$GetRoomBeverageSummaryCopyWith<$Res> {
  __$GetRoomBeverageSummaryCopyWithImpl(this._self, this._then);

  final _GetRoomBeverageSummary _self;
  final $Res Function(_GetRoomBeverageSummary) _then;

/// Create a copy of RoomBeverageEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shouldShowLoadingIndicator = null,}) {
  return _then(_GetRoomBeverageSummary(
shouldShowLoadingIndicator: null == shouldShowLoadingIndicator ? _self.shouldShowLoadingIndicator : shouldShowLoadingIndicator // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
