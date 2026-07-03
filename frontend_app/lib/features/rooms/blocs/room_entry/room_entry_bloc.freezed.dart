// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoomEntryEvent {

 RoomEntryModel get roomEntryModel;
/// Create a copy of RoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomEntryEventCopyWith<RoomEntryEvent> get copyWith => _$RoomEntryEventCopyWithImpl<RoomEntryEvent>(this as RoomEntryEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomEntryEvent&&(identical(other.roomEntryModel, roomEntryModel) || other.roomEntryModel == roomEntryModel));
}


@override
int get hashCode => Object.hash(runtimeType,roomEntryModel);

@override
String toString() {
  return 'RoomEntryEvent(roomEntryModel: $roomEntryModel)';
}


}

/// @nodoc
abstract mixin class $RoomEntryEventCopyWith<$Res>  {
  factory $RoomEntryEventCopyWith(RoomEntryEvent value, $Res Function(RoomEntryEvent) _then) = _$RoomEntryEventCopyWithImpl;
@useResult
$Res call({
 RoomEntryModel roomEntryModel
});




}
/// @nodoc
class _$RoomEntryEventCopyWithImpl<$Res>
    implements $RoomEntryEventCopyWith<$Res> {
  _$RoomEntryEventCopyWithImpl(this._self, this._then);

  final RoomEntryEvent _self;
  final $Res Function(RoomEntryEvent) _then;

/// Create a copy of RoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomEntryModel = null,}) {
  return _then(_self.copyWith(
roomEntryModel: null == roomEntryModel ? _self.roomEntryModel : roomEntryModel // ignore: cast_nullable_to_non_nullable
as RoomEntryModel,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomEntryEvent].
extension RoomEntryEventPatterns on RoomEntryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RoomEntryModel value)?  roomEntry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomEntryModel() when roomEntry != null:
return roomEntry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RoomEntryModel value)  roomEntry,}){
final _that = this;
switch (_that) {
case _RoomEntryModel():
return roomEntry(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RoomEntryModel value)?  roomEntry,}){
final _that = this;
switch (_that) {
case _RoomEntryModel() when roomEntry != null:
return roomEntry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( RoomEntryModel roomEntryModel)?  roomEntry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomEntryModel() when roomEntry != null:
return roomEntry(_that.roomEntryModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( RoomEntryModel roomEntryModel)  roomEntry,}) {final _that = this;
switch (_that) {
case _RoomEntryModel():
return roomEntry(_that.roomEntryModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( RoomEntryModel roomEntryModel)?  roomEntry,}) {final _that = this;
switch (_that) {
case _RoomEntryModel() when roomEntry != null:
return roomEntry(_that.roomEntryModel);case _:
  return null;

}
}

}

/// @nodoc


class _RoomEntryModel implements RoomEntryEvent {
  const _RoomEntryModel(this.roomEntryModel);
  

@override final  RoomEntryModel roomEntryModel;

/// Create a copy of RoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomEntryModelCopyWith<_RoomEntryModel> get copyWith => __$RoomEntryModelCopyWithImpl<_RoomEntryModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomEntryModel&&(identical(other.roomEntryModel, roomEntryModel) || other.roomEntryModel == roomEntryModel));
}


@override
int get hashCode => Object.hash(runtimeType,roomEntryModel);

@override
String toString() {
  return 'RoomEntryEvent.roomEntry(roomEntryModel: $roomEntryModel)';
}


}

/// @nodoc
abstract mixin class _$RoomEntryModelCopyWith<$Res> implements $RoomEntryEventCopyWith<$Res> {
  factory _$RoomEntryModelCopyWith(_RoomEntryModel value, $Res Function(_RoomEntryModel) _then) = __$RoomEntryModelCopyWithImpl;
@override @useResult
$Res call({
 RoomEntryModel roomEntryModel
});




}
/// @nodoc
class __$RoomEntryModelCopyWithImpl<$Res>
    implements _$RoomEntryModelCopyWith<$Res> {
  __$RoomEntryModelCopyWithImpl(this._self, this._then);

  final _RoomEntryModel _self;
  final $Res Function(_RoomEntryModel) _then;

/// Create a copy of RoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomEntryModel = null,}) {
  return _then(_RoomEntryModel(
null == roomEntryModel ? _self.roomEntryModel : roomEntryModel // ignore: cast_nullable_to_non_nullable
as RoomEntryModel,
  ));
}


}

// dart format on
