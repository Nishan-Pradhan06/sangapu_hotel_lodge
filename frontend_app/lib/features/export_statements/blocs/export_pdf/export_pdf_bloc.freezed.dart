// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_pdf_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExportPdfEvent {

 String? get type; String? get date; String? get month; String? get ordering;
/// Create a copy of ExportPdfEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportPdfEventCopyWith<ExportPdfEvent> get copyWith => _$ExportPdfEventCopyWithImpl<ExportPdfEvent>(this as ExportPdfEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportPdfEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.month, month) || other.month == month)&&(identical(other.ordering, ordering) || other.ordering == ordering));
}


@override
int get hashCode => Object.hash(runtimeType,type,date,month,ordering);

@override
String toString() {
  return 'ExportPdfEvent(type: $type, date: $date, month: $month, ordering: $ordering)';
}


}

/// @nodoc
abstract mixin class $ExportPdfEventCopyWith<$Res>  {
  factory $ExportPdfEventCopyWith(ExportPdfEvent value, $Res Function(ExportPdfEvent) _then) = _$ExportPdfEventCopyWithImpl;
@useResult
$Res call({
 String? type, String? date, String? month, String? ordering
});




}
/// @nodoc
class _$ExportPdfEventCopyWithImpl<$Res>
    implements $ExportPdfEventCopyWith<$Res> {
  _$ExportPdfEventCopyWithImpl(this._self, this._then);

  final ExportPdfEvent _self;
  final $Res Function(ExportPdfEvent) _then;

/// Create a copy of ExportPdfEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? date = freezed,Object? month = freezed,Object? ordering = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,ordering: freezed == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExportPdfEvent].
extension ExportPdfEventPatterns on ExportPdfEvent {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? type,  String? date,  String? month,  String? ordering)?  exportPdf,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExportPdf() when exportPdf != null:
return exportPdf(_that.type,_that.date,_that.month,_that.ordering);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? type,  String? date,  String? month,  String? ordering)  exportPdf,}) {final _that = this;
switch (_that) {
case _ExportPdf():
return exportPdf(_that.type,_that.date,_that.month,_that.ordering);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? type,  String? date,  String? month,  String? ordering)?  exportPdf,}) {final _that = this;
switch (_that) {
case _ExportPdf() when exportPdf != null:
return exportPdf(_that.type,_that.date,_that.month,_that.ordering);case _:
  return null;

}
}

}

/// @nodoc


class _ExportPdf implements ExportPdfEvent {
  const _ExportPdf({this.type, this.date, this.month, this.ordering});
  

@override final  String? type;
@override final  String? date;
@override final  String? month;
@override final  String? ordering;

/// Create a copy of ExportPdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportPdfCopyWith<_ExportPdf> get copyWith => __$ExportPdfCopyWithImpl<_ExportPdf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportPdf&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.month, month) || other.month == month)&&(identical(other.ordering, ordering) || other.ordering == ordering));
}


@override
int get hashCode => Object.hash(runtimeType,type,date,month,ordering);

@override
String toString() {
  return 'ExportPdfEvent.exportPdf(type: $type, date: $date, month: $month, ordering: $ordering)';
}


}

/// @nodoc
abstract mixin class _$ExportPdfCopyWith<$Res> implements $ExportPdfEventCopyWith<$Res> {
  factory _$ExportPdfCopyWith(_ExportPdf value, $Res Function(_ExportPdf) _then) = __$ExportPdfCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? date, String? month, String? ordering
});




}
/// @nodoc
class __$ExportPdfCopyWithImpl<$Res>
    implements _$ExportPdfCopyWith<$Res> {
  __$ExportPdfCopyWithImpl(this._self, this._then);

  final _ExportPdf _self;
  final $Res Function(_ExportPdf) _then;

/// Create a copy of ExportPdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? date = freezed,Object? month = freezed,Object? ordering = freezed,}) {
  return _then(_ExportPdf(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,ordering: freezed == ordering ? _self.ordering : ordering // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
