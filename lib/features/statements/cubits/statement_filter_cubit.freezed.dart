// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statement_filter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatementFilterState {

 DateTime? get dateFrom; DateTime? get dateTo;/// 'Income' | 'Expense' | null = All
 String? get type;
/// Create a copy of StatementFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatementFilterStateCopyWith<StatementFilterState> get copyWith => _$StatementFilterStateCopyWithImpl<StatementFilterState>(this as StatementFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatementFilterState&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,dateFrom,dateTo,type);

@override
String toString() {
  return 'StatementFilterState(dateFrom: $dateFrom, dateTo: $dateTo, type: $type)';
}


}

/// @nodoc
abstract mixin class $StatementFilterStateCopyWith<$Res>  {
  factory $StatementFilterStateCopyWith(StatementFilterState value, $Res Function(StatementFilterState) _then) = _$StatementFilterStateCopyWithImpl;
@useResult
$Res call({
 DateTime? dateFrom, DateTime? dateTo, String? type
});




}
/// @nodoc
class _$StatementFilterStateCopyWithImpl<$Res>
    implements $StatementFilterStateCopyWith<$Res> {
  _$StatementFilterStateCopyWithImpl(this._self, this._then);

  final StatementFilterState _self;
  final $Res Function(StatementFilterState) _then;

/// Create a copy of StatementFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateFrom = freezed,Object? dateTo = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatementFilterState].
extension StatementFilterStatePatterns on StatementFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatementFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatementFilterState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatementFilterState value)  $default,){
final _that = this;
switch (_that) {
case _StatementFilterState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatementFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _StatementFilterState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? dateFrom,  DateTime? dateTo,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatementFilterState() when $default != null:
return $default(_that.dateFrom,_that.dateTo,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? dateFrom,  DateTime? dateTo,  String? type)  $default,) {final _that = this;
switch (_that) {
case _StatementFilterState():
return $default(_that.dateFrom,_that.dateTo,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? dateFrom,  DateTime? dateTo,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _StatementFilterState() when $default != null:
return $default(_that.dateFrom,_that.dateTo,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _StatementFilterState implements StatementFilterState {
  const _StatementFilterState({this.dateFrom, this.dateTo, this.type});
  

@override final  DateTime? dateFrom;
@override final  DateTime? dateTo;
/// 'Income' | 'Expense' | null = All
@override final  String? type;

/// Create a copy of StatementFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatementFilterStateCopyWith<_StatementFilterState> get copyWith => __$StatementFilterStateCopyWithImpl<_StatementFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatementFilterState&&(identical(other.dateFrom, dateFrom) || other.dateFrom == dateFrom)&&(identical(other.dateTo, dateTo) || other.dateTo == dateTo)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,dateFrom,dateTo,type);

@override
String toString() {
  return 'StatementFilterState(dateFrom: $dateFrom, dateTo: $dateTo, type: $type)';
}


}

/// @nodoc
abstract mixin class _$StatementFilterStateCopyWith<$Res> implements $StatementFilterStateCopyWith<$Res> {
  factory _$StatementFilterStateCopyWith(_StatementFilterState value, $Res Function(_StatementFilterState) _then) = __$StatementFilterStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? dateFrom, DateTime? dateTo, String? type
});




}
/// @nodoc
class __$StatementFilterStateCopyWithImpl<$Res>
    implements _$StatementFilterStateCopyWith<$Res> {
  __$StatementFilterStateCopyWithImpl(this._self, this._then);

  final _StatementFilterState _self;
  final $Res Function(_StatementFilterState) _then;

/// Create a copy of StatementFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateFrom = freezed,Object? dateTo = freezed,Object? type = freezed,}) {
  return _then(_StatementFilterState(
dateFrom: freezed == dateFrom ? _self.dateFrom : dateFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,dateTo: freezed == dateTo ? _self.dateTo : dateTo // ignore: cast_nullable_to_non_nullable
as DateTime?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
