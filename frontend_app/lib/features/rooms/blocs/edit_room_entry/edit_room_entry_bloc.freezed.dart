// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_room_entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditRoomEntryEvent {

 int get roomEntryId; RoomEntryModel get roomModel;
/// Create a copy of EditRoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditRoomEntryEventCopyWith<EditRoomEntryEvent> get copyWith => _$EditRoomEntryEventCopyWithImpl<EditRoomEntryEvent>(this as EditRoomEntryEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditRoomEntryEvent&&(identical(other.roomEntryId, roomEntryId) || other.roomEntryId == roomEntryId)&&(identical(other.roomModel, roomModel) || other.roomModel == roomModel));
}


@override
int get hashCode => Object.hash(runtimeType,roomEntryId,roomModel);

@override
String toString() {
  return 'EditRoomEntryEvent(roomEntryId: $roomEntryId, roomModel: $roomModel)';
}


}

/// @nodoc
abstract mixin class $EditRoomEntryEventCopyWith<$Res>  {
  factory $EditRoomEntryEventCopyWith(EditRoomEntryEvent value, $Res Function(EditRoomEntryEvent) _then) = _$EditRoomEntryEventCopyWithImpl;
@useResult
$Res call({
 int roomEntryId, RoomEntryModel roomModel
});




}
/// @nodoc
class _$EditRoomEntryEventCopyWithImpl<$Res>
    implements $EditRoomEntryEventCopyWith<$Res> {
  _$EditRoomEntryEventCopyWithImpl(this._self, this._then);

  final EditRoomEntryEvent _self;
  final $Res Function(EditRoomEntryEvent) _then;

/// Create a copy of EditRoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomEntryId = null,Object? roomModel = null,}) {
  return _then(_self.copyWith(
roomEntryId: null == roomEntryId ? _self.roomEntryId : roomEntryId // ignore: cast_nullable_to_non_nullable
as int,roomModel: null == roomModel ? _self.roomModel : roomModel // ignore: cast_nullable_to_non_nullable
as RoomEntryModel,
  ));
}

}


/// Adds pattern-matching-related methods to [EditRoomEntryEvent].
extension EditRoomEntryEventPatterns on EditRoomEntryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _EditRoomEntryEvent value)?  editRoomEntry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditRoomEntryEvent() when editRoomEntry != null:
return editRoomEntry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _EditRoomEntryEvent value)  editRoomEntry,}){
final _that = this;
switch (_that) {
case _EditRoomEntryEvent():
return editRoomEntry(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _EditRoomEntryEvent value)?  editRoomEntry,}){
final _that = this;
switch (_that) {
case _EditRoomEntryEvent() when editRoomEntry != null:
return editRoomEntry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int roomEntryId,  RoomEntryModel roomModel)?  editRoomEntry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditRoomEntryEvent() when editRoomEntry != null:
return editRoomEntry(_that.roomEntryId,_that.roomModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int roomEntryId,  RoomEntryModel roomModel)  editRoomEntry,}) {final _that = this;
switch (_that) {
case _EditRoomEntryEvent():
return editRoomEntry(_that.roomEntryId,_that.roomModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int roomEntryId,  RoomEntryModel roomModel)?  editRoomEntry,}) {final _that = this;
switch (_that) {
case _EditRoomEntryEvent() when editRoomEntry != null:
return editRoomEntry(_that.roomEntryId,_that.roomModel);case _:
  return null;

}
}

}

/// @nodoc


class _EditRoomEntryEvent implements EditRoomEntryEvent {
  const _EditRoomEntryEvent(this.roomEntryId, this.roomModel);
  

@override final  int roomEntryId;
@override final  RoomEntryModel roomModel;

/// Create a copy of EditRoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditRoomEntryEventCopyWith<_EditRoomEntryEvent> get copyWith => __$EditRoomEntryEventCopyWithImpl<_EditRoomEntryEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditRoomEntryEvent&&(identical(other.roomEntryId, roomEntryId) || other.roomEntryId == roomEntryId)&&(identical(other.roomModel, roomModel) || other.roomModel == roomModel));
}


@override
int get hashCode => Object.hash(runtimeType,roomEntryId,roomModel);

@override
String toString() {
  return 'EditRoomEntryEvent.editRoomEntry(roomEntryId: $roomEntryId, roomModel: $roomModel)';
}


}

/// @nodoc
abstract mixin class _$EditRoomEntryEventCopyWith<$Res> implements $EditRoomEntryEventCopyWith<$Res> {
  factory _$EditRoomEntryEventCopyWith(_EditRoomEntryEvent value, $Res Function(_EditRoomEntryEvent) _then) = __$EditRoomEntryEventCopyWithImpl;
@override @useResult
$Res call({
 int roomEntryId, RoomEntryModel roomModel
});




}
/// @nodoc
class __$EditRoomEntryEventCopyWithImpl<$Res>
    implements _$EditRoomEntryEventCopyWith<$Res> {
  __$EditRoomEntryEventCopyWithImpl(this._self, this._then);

  final _EditRoomEntryEvent _self;
  final $Res Function(_EditRoomEntryEvent) _then;

/// Create a copy of EditRoomEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomEntryId = null,Object? roomModel = null,}) {
  return _then(_EditRoomEntryEvent(
null == roomEntryId ? _self.roomEntryId : roomEntryId // ignore: cast_nullable_to_non_nullable
as int,null == roomModel ? _self.roomModel : roomModel // ignore: cast_nullable_to_non_nullable
as RoomEntryModel,
  ));
}


}

// dart format on
