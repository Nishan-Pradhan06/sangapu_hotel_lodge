// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_entry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IncomeEntryEvent {

 IncomeEntryModel get incomeEntryModel;
/// Create a copy of IncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeEntryEventCopyWith<IncomeEntryEvent> get copyWith => _$IncomeEntryEventCopyWithImpl<IncomeEntryEvent>(this as IncomeEntryEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeEntryEvent&&(identical(other.incomeEntryModel, incomeEntryModel) || other.incomeEntryModel == incomeEntryModel));
}


@override
int get hashCode => Object.hash(runtimeType,incomeEntryModel);

@override
String toString() {
  return 'IncomeEntryEvent(incomeEntryModel: $incomeEntryModel)';
}


}

/// @nodoc
abstract mixin class $IncomeEntryEventCopyWith<$Res>  {
  factory $IncomeEntryEventCopyWith(IncomeEntryEvent value, $Res Function(IncomeEntryEvent) _then) = _$IncomeEntryEventCopyWithImpl;
@useResult
$Res call({
 IncomeEntryModel incomeEntryModel
});




}
/// @nodoc
class _$IncomeEntryEventCopyWithImpl<$Res>
    implements $IncomeEntryEventCopyWith<$Res> {
  _$IncomeEntryEventCopyWithImpl(this._self, this._then);

  final IncomeEntryEvent _self;
  final $Res Function(IncomeEntryEvent) _then;

/// Create a copy of IncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? incomeEntryModel = null,}) {
  return _then(_self.copyWith(
incomeEntryModel: null == incomeEntryModel ? _self.incomeEntryModel : incomeEntryModel // ignore: cast_nullable_to_non_nullable
as IncomeEntryModel,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeEntryEvent].
extension IncomeEntryEventPatterns on IncomeEntryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _IncomeEntryModel value)?  incomeEntry,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeEntryModel() when incomeEntry != null:
return incomeEntry(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _IncomeEntryModel value)  incomeEntry,}){
final _that = this;
switch (_that) {
case _IncomeEntryModel():
return incomeEntry(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _IncomeEntryModel value)?  incomeEntry,}){
final _that = this;
switch (_that) {
case _IncomeEntryModel() when incomeEntry != null:
return incomeEntry(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( IncomeEntryModel incomeEntryModel)?  incomeEntry,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeEntryModel() when incomeEntry != null:
return incomeEntry(_that.incomeEntryModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( IncomeEntryModel incomeEntryModel)  incomeEntry,}) {final _that = this;
switch (_that) {
case _IncomeEntryModel():
return incomeEntry(_that.incomeEntryModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( IncomeEntryModel incomeEntryModel)?  incomeEntry,}) {final _that = this;
switch (_that) {
case _IncomeEntryModel() when incomeEntry != null:
return incomeEntry(_that.incomeEntryModel);case _:
  return null;

}
}

}

/// @nodoc


class _IncomeEntryModel implements IncomeEntryEvent {
  const _IncomeEntryModel(this.incomeEntryModel);
  

@override final  IncomeEntryModel incomeEntryModel;

/// Create a copy of IncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeEntryModelCopyWith<_IncomeEntryModel> get copyWith => __$IncomeEntryModelCopyWithImpl<_IncomeEntryModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeEntryModel&&(identical(other.incomeEntryModel, incomeEntryModel) || other.incomeEntryModel == incomeEntryModel));
}


@override
int get hashCode => Object.hash(runtimeType,incomeEntryModel);

@override
String toString() {
  return 'IncomeEntryEvent.incomeEntry(incomeEntryModel: $incomeEntryModel)';
}


}

/// @nodoc
abstract mixin class _$IncomeEntryModelCopyWith<$Res> implements $IncomeEntryEventCopyWith<$Res> {
  factory _$IncomeEntryModelCopyWith(_IncomeEntryModel value, $Res Function(_IncomeEntryModel) _then) = __$IncomeEntryModelCopyWithImpl;
@override @useResult
$Res call({
 IncomeEntryModel incomeEntryModel
});




}
/// @nodoc
class __$IncomeEntryModelCopyWithImpl<$Res>
    implements _$IncomeEntryModelCopyWith<$Res> {
  __$IncomeEntryModelCopyWithImpl(this._self, this._then);

  final _IncomeEntryModel _self;
  final $Res Function(_IncomeEntryModel) _then;

/// Create a copy of IncomeEntryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? incomeEntryModel = null,}) {
  return _then(_IncomeEntryModel(
null == incomeEntryModel ? _self.incomeEntryModel : incomeEntryModel // ignore: cast_nullable_to_non_nullable
as IncomeEntryModel,
  ));
}


}

// dart format on
