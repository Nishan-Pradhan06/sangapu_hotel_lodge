// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_statement_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportStatementEvent {

 String? get type; String? get date; String? get month; String? get ordering; String? get startDate; String? get endDate;
/// Create a copy of ExportStatementEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportStatementEventCopyWith<ExportStatementEvent> get copyWith => _$ExportStatementEventCopyWithImpl<ExportStatementEvent>(this as ExportStatementEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportStatementEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.month, month) || other.month == month)&&(identical(other.ordering, ordering) || other.ordering == ordering)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,type,date,month,ordering,startDate,endDate);

@override
String toString() {
  return 'ExportStatementEvent(type: $type, date: $date, month: $month, ordering: $ordering, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ExportStatementEventCopyWith<$Res>  {
  factory $ExportStatementEventCopyWith(ExportStatementEvent value, $Res Function(ExportStatementEvent) _then) = _$ExportStatementEventCopyWithImpl;
@useResult
$Res call({
 String? type, String? date, String? month, String? ordering, String? startDate, String? endDate
});




}
/// @nodoc
class _$ExportStatementEventCopyWithImpl<$Res>
    implements $ExportStatementEventCopyWith<$Res> {
  _$ExportStatementEventCopyWithImpl(this._self, this._then);

  final ExportStatementEvent _self;
  final $Res Function(ExportStatementEvent) _then;

/// Create a copy of ExportStatementEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? date = freezed,Object? month = freezed,Object? ordering = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,ordering: freezed == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportStatementEvent].
extension ExportStatementEventPatterns on ExportStatementEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ExportExcel value)?  exportExcel,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportExcel() when exportExcel != null:
return exportExcel(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ExportExcel value)  exportExcel,}){
final _that = this;
switch (_that) {
case _ExportExcel():
return exportExcel(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ExportExcel value)?  exportExcel,}){
final _that = this;
switch (_that) {
case _ExportExcel() when exportExcel != null:
return exportExcel(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? type,  String? date,  String? month,  String? ordering,  String? startDate,  String? endDate)?  exportExcel,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportExcel() when exportExcel != null:
return exportExcel(_that.type,_that.date,_that.month,_that.ordering,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? type,  String? date,  String? month,  String? ordering,  String? startDate,  String? endDate)  exportExcel,}) {final _that = this;
switch (_that) {
case _ExportExcel():
return exportExcel(_that.type,_that.date,_that.month,_that.ordering,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? type,  String? date,  String? month,  String? ordering,  String? startDate,  String? endDate)?  exportExcel,}) {final _that = this;
switch (_that) {
case _ExportExcel() when exportExcel != null:
return exportExcel(_that.type,_that.date,_that.month,_that.ordering,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class _ExportExcel implements ExportStatementEvent {
  const _ExportExcel({this.type, this.date, this.month, this.ordering, this.startDate, this.endDate});
  

@override final  String? type;
@override final  String? date;
@override final  String? month;
@override final  String? ordering;
@override final  String? startDate;
@override final  String? endDate;

/// Create a copy of ExportStatementEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportExcelCopyWith<_ExportExcel> get copyWith => __$ExportExcelCopyWithImpl<_ExportExcel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportExcel&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.month, month) || other.month == month)&&(identical(other.ordering, ordering) || other.ordering == ordering)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,type,date,month,ordering,startDate,endDate);

@override
String toString() {
  return 'ExportStatementEvent.exportExcel(type: $type, date: $date, month: $month, ordering: $ordering, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ExportExcelCopyWith<$Res> implements $ExportStatementEventCopyWith<$Res> {
  factory _$ExportExcelCopyWith(_ExportExcel value, $Res Function(_ExportExcel) _then) = __$ExportExcelCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? date, String? month, String? ordering, String? startDate, String? endDate
});




}
/// @nodoc
class __$ExportExcelCopyWithImpl<$Res>
    implements _$ExportExcelCopyWith<$Res> {
  __$ExportExcelCopyWithImpl(this._self, this._then);

  final _ExportExcel _self;
  final $Res Function(_ExportExcel) _then;

/// Create a copy of ExportStatementEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? date = freezed,Object? month = freezed,Object? ordering = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_ExportExcel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,ordering: freezed == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
