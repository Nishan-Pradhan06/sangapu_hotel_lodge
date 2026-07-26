// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_income_entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditIncomeEntryEvent {

 int get incomeId; IncomeEntryModel get incomeEntry;
/// Create a copy of EditIncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditIncomeEntryEventCopyWith<EditIncomeEntryEvent> get copyWith => _$EditIncomeEntryEventCopyWithImpl<EditIncomeEntryEvent>(this as EditIncomeEntryEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditIncomeEntryEvent&&(identical(other.incomeId, incomeId) || other.incomeId == incomeId)&&(identical(other.incomeEntry, incomeEntry) || other.incomeEntry == incomeEntry));
}


@override
int get hashCode => Object.hash(runtimeType,incomeId,incomeEntry);

@override
String toString() {
  return 'EditIncomeEntryEvent(incomeId: $incomeId, incomeEntry: $incomeEntry)';
}


}

/// @nodoc
abstract mixin class $EditIncomeEntryEventCopyWith<$Res>  {
  factory $EditIncomeEntryEventCopyWith(EditIncomeEntryEvent value, $Res Function(EditIncomeEntryEvent) _then) = _$EditIncomeEntryEventCopyWithImpl;
@useResult
$Res call({
 int incomeId, IncomeEntryModel incomeEntry
});




}
/// @nodoc
class _$EditIncomeEntryEventCopyWithImpl<$Res>
    implements $EditIncomeEntryEventCopyWith<$Res> {
  _$EditIncomeEntryEventCopyWithImpl(this._self, this._then);

  final EditIncomeEntryEvent _self;
  final $Res Function(EditIncomeEntryEvent) _then;

/// Create a copy of EditIncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? incomeId = null,Object? incomeEntry = null,}) {
  return _then(_self.copyWith(
incomeId: null == incomeId ? _self.incomeId : incomeId // ignore: cast_nullable_to_non_nullable
as int,incomeEntry: null == incomeEntry ? _self.incomeEntry : incomeEntry // ignore: cast_nullable_to_non_nullable
as IncomeEntryModel,
  ));
}

}


/// Adds pattern-matching-related methods to [EditIncomeEntryEvent].
extension EditIncomeEntryEventPatterns on EditIncomeEntryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _EditIncomeEntryEvent value)?  editIncomeEntry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditIncomeEntryEvent() when editIncomeEntry != null:
return editIncomeEntry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _EditIncomeEntryEvent value)  editIncomeEntry,}){
final _that = this;
switch (_that) {
case _EditIncomeEntryEvent():
return editIncomeEntry(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _EditIncomeEntryEvent value)?  editIncomeEntry,}){
final _that = this;
switch (_that) {
case _EditIncomeEntryEvent() when editIncomeEntry != null:
return editIncomeEntry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int incomeId,  IncomeEntryModel incomeEntry)?  editIncomeEntry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditIncomeEntryEvent() when editIncomeEntry != null:
return editIncomeEntry(_that.incomeId,_that.incomeEntry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int incomeId,  IncomeEntryModel incomeEntry)  editIncomeEntry,}) {final _that = this;
switch (_that) {
case _EditIncomeEntryEvent():
return editIncomeEntry(_that.incomeId,_that.incomeEntry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int incomeId,  IncomeEntryModel incomeEntry)?  editIncomeEntry,}) {final _that = this;
switch (_that) {
case _EditIncomeEntryEvent() when editIncomeEntry != null:
return editIncomeEntry(_that.incomeId,_that.incomeEntry);case _:
  return null;

}
}

}

/// @nodoc


class _EditIncomeEntryEvent implements EditIncomeEntryEvent {
  const _EditIncomeEntryEvent(this.incomeId, this.incomeEntry);
  

@override final  int incomeId;
@override final  IncomeEntryModel incomeEntry;

/// Create a copy of EditIncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditIncomeEntryEventCopyWith<_EditIncomeEntryEvent> get copyWith => __$EditIncomeEntryEventCopyWithImpl<_EditIncomeEntryEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditIncomeEntryEvent&&(identical(other.incomeId, incomeId) || other.incomeId == incomeId)&&(identical(other.incomeEntry, incomeEntry) || other.incomeEntry == incomeEntry));
}


@override
int get hashCode => Object.hash(runtimeType,incomeId,incomeEntry);

@override
String toString() {
  return 'EditIncomeEntryEvent.editIncomeEntry(incomeId: $incomeId, incomeEntry: $incomeEntry)';
}


}

/// @nodoc
abstract mixin class _$EditIncomeEntryEventCopyWith<$Res> implements $EditIncomeEntryEventCopyWith<$Res> {
  factory _$EditIncomeEntryEventCopyWith(_EditIncomeEntryEvent value, $Res Function(_EditIncomeEntryEvent) _then) = __$EditIncomeEntryEventCopyWithImpl;
@override @useResult
$Res call({
 int incomeId, IncomeEntryModel incomeEntry
});




}
/// @nodoc
class __$EditIncomeEntryEventCopyWithImpl<$Res>
    implements _$EditIncomeEntryEventCopyWith<$Res> {
  __$EditIncomeEntryEventCopyWithImpl(this._self, this._then);

  final _EditIncomeEntryEvent _self;
  final $Res Function(_EditIncomeEntryEvent) _then;

/// Create a copy of EditIncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? incomeId = null,Object? incomeEntry = null,}) {
  return _then(_EditIncomeEntryEvent(
null == incomeId ? _self.incomeId : incomeId // ignore: cast_nullable_to_non_nullable
as int,null == incomeEntry ? _self.incomeEntry : incomeEntry // ignore: cast_nullable_to_non_nullable
as IncomeEntryModel,
  ));
}


}

// dart format on
