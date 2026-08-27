// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_room_beverage_pdf_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportRoomBeveragePdfEvent {

 String? get date; String? get month; String? get startDate; String? get endDate;
/// Create a copy of ExportRoomBeveragePdfEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportRoomBeveragePdfEventCopyWith<ExportRoomBeveragePdfEvent> get copyWith => _$ExportRoomBeveragePdfEventCopyWithImpl<ExportRoomBeveragePdfEvent>(this as ExportRoomBeveragePdfEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportRoomBeveragePdfEvent&&(identical(other.date, date) || other.date == date)&&(identical(other.month, month) || other.month == month)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,date,month,startDate,endDate);

@override
String toString() {
  return 'ExportRoomBeveragePdfEvent(date: $date, month: $month, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ExportRoomBeveragePdfEventCopyWith<$Res>  {
  factory $ExportRoomBeveragePdfEventCopyWith(ExportRoomBeveragePdfEvent value, $Res Function(ExportRoomBeveragePdfEvent) _then) = _$ExportRoomBeveragePdfEventCopyWithImpl;
@useResult
$Res call({
 String? date, String? month, String? startDate, String? endDate
});




}
/// @nodoc
class _$ExportRoomBeveragePdfEventCopyWithImpl<$Res>
    implements $ExportRoomBeveragePdfEventCopyWith<$Res> {
  _$ExportRoomBeveragePdfEventCopyWithImpl(this._self, this._then);

  final ExportRoomBeveragePdfEvent _self;
  final $Res Function(ExportRoomBeveragePdfEvent) _then;

/// Create a copy of ExportRoomBeveragePdfEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? month = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportRoomBeveragePdfEvent].
extension ExportRoomBeveragePdfEventPatterns on ExportRoomBeveragePdfEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ExportPdf value)?  exportPdf,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExportPdf() when exportPdf != null:
return exportPdf(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ExportPdf value)  exportPdf,}){
final _that = this;
switch (_that) {
case _ExportPdf():
return exportPdf(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ExportPdf value)?  exportPdf,}){
final _that = this;
switch (_that) {
case _ExportPdf() when exportPdf != null:
return exportPdf(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? date,  String? month,  String? startDate,  String? endDate)?  exportPdf,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportPdf() when exportPdf != null:
return exportPdf(_that.date,_that.month,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? date,  String? month,  String? startDate,  String? endDate)  exportPdf,}) {final _that = this;
switch (_that) {
case _ExportPdf():
return exportPdf(_that.date,_that.month,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? date,  String? month,  String? startDate,  String? endDate)?  exportPdf,}) {final _that = this;
switch (_that) {
case _ExportPdf() when exportPdf != null:
return exportPdf(_that.date,_that.month,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class _ExportPdf implements ExportRoomBeveragePdfEvent {
  const _ExportPdf({this.date, this.month, this.startDate, this.endDate});
  

@override final  String? date;
@override final  String? month;
@override final  String? startDate;
@override final  String? endDate;

/// Create a copy of ExportRoomBeveragePdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportPdfCopyWith<_ExportPdf> get copyWith => __$ExportPdfCopyWithImpl<_ExportPdf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportPdf&&(identical(other.date, date) || other.date == date)&&(identical(other.month, month) || other.month == month)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,date,month,startDate,endDate);

@override
String toString() {
  return 'ExportRoomBeveragePdfEvent.exportPdf(date: $date, month: $month, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ExportPdfCopyWith<$Res> implements $ExportRoomBeveragePdfEventCopyWith<$Res> {
  factory _$ExportPdfCopyWith(_ExportPdf value, $Res Function(_ExportPdf) _then) = __$ExportPdfCopyWithImpl;
@override @useResult
$Res call({
 String? date, String? month, String? startDate, String? endDate
});




}
/// @nodoc
class __$ExportPdfCopyWithImpl<$Res>
    implements _$ExportPdfCopyWith<$Res> {
  __$ExportPdfCopyWithImpl(this._self, this._then);

  final _ExportPdf _self;
  final $Res Function(_ExportPdf) _then;

/// Create a copy of ExportRoomBeveragePdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? month = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_ExportPdf(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
