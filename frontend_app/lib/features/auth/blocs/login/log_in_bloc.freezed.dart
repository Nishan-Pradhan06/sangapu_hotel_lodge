// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_in_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogInEvent {

 LogInModel get loginModel;
/// Create a copy of LogInEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogInEventCopyWith<LogInEvent> get copyWith => _$LogInEventCopyWithImpl<LogInEvent>(this as LogInEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogInEvent&&(identical(other.loginModel, loginModel) || other.loginModel == loginModel));
}


@override
int get hashCode => Object.hash(runtimeType,loginModel);

@override
String toString() {
  return 'LogInEvent(loginModel: $loginModel)';
}


}

/// @nodoc
abstract mixin class $LogInEventCopyWith<$Res>  {
  factory $LogInEventCopyWith(LogInEvent value, $Res Function(LogInEvent) _then) = _$LogInEventCopyWithImpl;
@useResult
$Res call({
 LogInModel loginModel
});




}
/// @nodoc
class _$LogInEventCopyWithImpl<$Res>
    implements $LogInEventCopyWith<$Res> {
  _$LogInEventCopyWithImpl(this._self, this._then);

  final LogInEvent _self;
  final $Res Function(LogInEvent) _then;

/// Create a copy of LogInEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginModel = null,}) {
  return _then(_self.copyWith(
loginModel: null == loginModel ? _self.loginModel : loginModel // ignore: cast_nullable_to_non_nullable
as LogInModel,
  ));
}

}


/// Adds pattern-matching-related methods to [LogInEvent].
extension LogInEventPatterns on LogInEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LogInEvent value)?  login,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LogInEvent() when login != null:
return login(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LogInEvent value)  login,}){
final _that = this;
switch (_that) {
case _LogInEvent():
return login(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LogInEvent value)?  login,}){
final _that = this;
switch (_that) {
case _LogInEvent() when login != null:
return login(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( LogInModel loginModel)?  login,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LogInEvent() when login != null:
return login(_that.loginModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( LogInModel loginModel)  login,}) {final _that = this;
switch (_that) {
case _LogInEvent():
return login(_that.loginModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( LogInModel loginModel)?  login,}) {final _that = this;
switch (_that) {
case _LogInEvent() when login != null:
return login(_that.loginModel);case _:
  return null;

}
}

}

/// @nodoc


class _LogInEvent implements LogInEvent {
  const _LogInEvent(this.loginModel);
  

@override final  LogInModel loginModel;

/// Create a copy of LogInEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LogInEventCopyWith<_LogInEvent> get copyWith => __$LogInEventCopyWithImpl<_LogInEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LogInEvent&&(identical(other.loginModel, loginModel) || other.loginModel == loginModel));
}


@override
int get hashCode => Object.hash(runtimeType,loginModel);

@override
String toString() {
  return 'LogInEvent.login(loginModel: $loginModel)';
}


}

/// @nodoc
abstract mixin class _$LogInEventCopyWith<$Res> implements $LogInEventCopyWith<$Res> {
  factory _$LogInEventCopyWith(_LogInEvent value, $Res Function(_LogInEvent) _then) = __$LogInEventCopyWithImpl;
@override @useResult
$Res call({
 LogInModel loginModel
});




}
/// @nodoc
class __$LogInEventCopyWithImpl<$Res>
    implements _$LogInEventCopyWith<$Res> {
  __$LogInEventCopyWithImpl(this._self, this._then);

  final _LogInEvent _self;
  final $Res Function(_LogInEvent) _then;

/// Create a copy of LogInEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginModel = null,}) {
  return _then(_LogInEvent(
null == loginModel ? _self.loginModel : loginModel // ignore: cast_nullable_to_non_nullable
as LogInModel,
  ));
}


}

// dart format on
