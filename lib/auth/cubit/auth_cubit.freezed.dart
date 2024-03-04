// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
          _$AuthLoadingImpl value, $Res Function(_$AuthLoadingImpl) then) =
      __$$AuthLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
      _$AuthLoadingImpl _value, $Res Function(_$AuthLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthLoadingImpl implements AuthLoading {
  const _$AuthLoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading() = _$AuthLoadingImpl;
}

/// @nodoc
abstract class _$$SignedInCompleteImplCopyWith<$Res> {
  factory _$$SignedInCompleteImplCopyWith(_$SignedInCompleteImpl value,
          $Res Function(_$SignedInCompleteImpl) then) =
      __$$SignedInCompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$SignedInCompleteImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SignedInCompleteImpl>
    implements _$$SignedInCompleteImplCopyWith<$Res> {
  __$$SignedInCompleteImplCopyWithImpl(_$SignedInCompleteImpl _value,
      $Res Function(_$SignedInCompleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SignedInCompleteImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$SignedInCompleteImpl implements SignedInComplete {
  const _$SignedInCompleteImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.signedInComplete(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedInCompleteImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedInCompleteImplCopyWith<_$SignedInCompleteImpl> get copyWith =>
      __$$SignedInCompleteImplCopyWithImpl<_$SignedInCompleteImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) {
    return signedInComplete(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) {
    return signedInComplete?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (signedInComplete != null) {
      return signedInComplete(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) {
    return signedInComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) {
    return signedInComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (signedInComplete != null) {
      return signedInComplete(this);
    }
    return orElse();
  }
}

abstract class SignedInComplete implements AuthState {
  const factory SignedInComplete(final User user) = _$SignedInCompleteImpl;

  User get user;
  @JsonKey(ignore: true)
  _$$SignedInCompleteImplCopyWith<_$SignedInCompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignedInIncompleteImplCopyWith<$Res> {
  factory _$$SignedInIncompleteImplCopyWith(_$SignedInIncompleteImpl value,
          $Res Function(_$SignedInIncompleteImpl) then) =
      __$$SignedInIncompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$SignedInIncompleteImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SignedInIncompleteImpl>
    implements _$$SignedInIncompleteImplCopyWith<$Res> {
  __$$SignedInIncompleteImplCopyWithImpl(_$SignedInIncompleteImpl _value,
      $Res Function(_$SignedInIncompleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SignedInIncompleteImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$SignedInIncompleteImpl implements SignedInIncomplete {
  const _$SignedInIncompleteImpl(this.user);

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.signedInIncomplete(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedInIncompleteImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedInIncompleteImplCopyWith<_$SignedInIncompleteImpl> get copyWith =>
      __$$SignedInIncompleteImplCopyWithImpl<_$SignedInIncompleteImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) {
    return signedInIncomplete(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) {
    return signedInIncomplete?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (signedInIncomplete != null) {
      return signedInIncomplete(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) {
    return signedInIncomplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) {
    return signedInIncomplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (signedInIncomplete != null) {
      return signedInIncomplete(this);
    }
    return orElse();
  }
}

abstract class SignedInIncomplete implements AuthState {
  const factory SignedInIncomplete(final User user) = _$SignedInIncompleteImpl;

  User get user;
  @JsonKey(ignore: true)
  _$$SignedInIncompleteImplCopyWith<_$SignedInIncompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogOutImplCopyWith<$Res> {
  factory _$$LogOutImplCopyWith(
          _$LogOutImpl value, $Res Function(_$LogOutImpl) then) =
      __$$LogOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogOutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LogOutImpl>
    implements _$$LogOutImplCopyWith<$Res> {
  __$$LogOutImplCopyWithImpl(
      _$LogOutImpl _value, $Res Function(_$LogOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LogOutImpl implements LogOut {
  const _$LogOutImpl();

  @override
  String toString() {
    return 'AuthState.logOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) {
    return logOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) {
    return logOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) {
    return logOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) {
    return logOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (logOut != null) {
      return logOut(this);
    }
    return orElse();
  }
}

abstract class LogOut implements AuthState {
  const factory LogOut() = _$LogOutImpl;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AuthErrorImpl(
      freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError([final String? message]) = _$AuthErrorImpl;

  String? get message;
  @JsonKey(ignore: true)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
