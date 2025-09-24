// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState()';
  }
}

/// @nodoc
class $AuthStateCopyWith<$Res> {
  $AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}

/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthLoading value)? loading,
    TResult Function(SignedInComplete value)? signedInComplete,
    TResult Function(SignedInIncomplete value)? signedInIncomplete,
    TResult Function(LogOut value)? logOut,
    TResult Function(AuthError value)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthLoading() when loading != null:
        return loading(_that);
      case SignedInComplete() when signedInComplete != null:
        return signedInComplete(_that);
      case SignedInIncomplete() when signedInIncomplete != null:
        return signedInIncomplete(_that);
      case LogOut() when logOut != null:
        return logOut(_that);
      case AuthError() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthLoading value) loading,
    required TResult Function(SignedInComplete value) signedInComplete,
    required TResult Function(SignedInIncomplete value) signedInIncomplete,
    required TResult Function(LogOut value) logOut,
    required TResult Function(AuthError value) error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthLoading():
        return loading(_that);
      case SignedInComplete():
        return signedInComplete(_that);
      case SignedInIncomplete():
        return signedInIncomplete(_that);
      case LogOut():
        return logOut(_that);
      case AuthError():
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(SignedInComplete value)? signedInComplete,
    TResult? Function(SignedInIncomplete value)? signedInIncomplete,
    TResult? Function(LogOut value)? logOut,
    TResult? Function(AuthError value)? error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthLoading() when loading != null:
        return loading(_that);
      case SignedInComplete() when signedInComplete != null:
        return signedInComplete(_that);
      case SignedInIncomplete() when signedInIncomplete != null:
        return signedInIncomplete(_that);
      case LogOut() when logOut != null:
        return logOut(_that);
      case AuthError() when error != null:
        return error(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(User user)? signedInComplete,
    TResult Function(User user)? signedInIncomplete,
    TResult Function()? logOut,
    TResult Function(String? message)? error,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthLoading() when loading != null:
        return loading();
      case SignedInComplete() when signedInComplete != null:
        return signedInComplete(_that.user);
      case SignedInIncomplete() when signedInIncomplete != null:
        return signedInIncomplete(_that.user);
      case LogOut() when logOut != null:
        return logOut();
      case AuthError() when error != null:
        return error(_that.message);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(User user) signedInComplete,
    required TResult Function(User user) signedInIncomplete,
    required TResult Function() logOut,
    required TResult Function(String? message) error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthLoading():
        return loading();
      case SignedInComplete():
        return signedInComplete(_that.user);
      case SignedInIncomplete():
        return signedInIncomplete(_that.user);
      case LogOut():
        return logOut();
      case AuthError():
        return error(_that.message);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(User user)? signedInComplete,
    TResult? Function(User user)? signedInIncomplete,
    TResult? Function()? logOut,
    TResult? Function(String? message)? error,
  }) {
    final _that = this;
    switch (_that) {
      case AuthLoading() when loading != null:
        return loading();
      case SignedInComplete() when signedInComplete != null:
        return signedInComplete(_that.user);
      case SignedInIncomplete() when signedInIncomplete != null:
        return signedInIncomplete(_that.user);
      case LogOut() when logOut != null:
        return logOut();
      case AuthError() when error != null:
        return error(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AuthLoading implements AuthState {
  const AuthLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.loading()';
  }
}

/// @nodoc

class SignedInComplete implements AuthState {
  const SignedInComplete(this.user);

  final User user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedInCompleteCopyWith<SignedInComplete> get copyWith =>
      _$SignedInCompleteCopyWithImpl<SignedInComplete>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedInComplete &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthState.signedInComplete(user: $user)';
  }
}

/// @nodoc
abstract mixin class $SignedInCompleteCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $SignedInCompleteCopyWith(
          SignedInComplete value, $Res Function(SignedInComplete) _then) =
      _$SignedInCompleteCopyWithImpl;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$SignedInCompleteCopyWithImpl<$Res>
    implements $SignedInCompleteCopyWith<$Res> {
  _$SignedInCompleteCopyWithImpl(this._self, this._then);

  final SignedInComplete _self;
  final $Res Function(SignedInComplete) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
  }) {
    return _then(SignedInComplete(
      null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc

class SignedInIncomplete implements AuthState {
  const SignedInIncomplete(this.user);

  final User user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedInIncompleteCopyWith<SignedInIncomplete> get copyWith =>
      _$SignedInIncompleteCopyWithImpl<SignedInIncomplete>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedInIncomplete &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthState.signedInIncomplete(user: $user)';
  }
}

/// @nodoc
abstract mixin class $SignedInIncompleteCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $SignedInIncompleteCopyWith(
          SignedInIncomplete value, $Res Function(SignedInIncomplete) _then) =
      _$SignedInIncompleteCopyWithImpl;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$SignedInIncompleteCopyWithImpl<$Res>
    implements $SignedInIncompleteCopyWith<$Res> {
  _$SignedInIncompleteCopyWithImpl(this._self, this._then);

  final SignedInIncomplete _self;
  final $Res Function(SignedInIncomplete) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
  }) {
    return _then(SignedInIncomplete(
      null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc

class LogOut implements AuthState {
  const LogOut();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LogOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.logOut()';
  }
}

/// @nodoc

class AuthError implements AuthState {
  const AuthError([this.message]);

  final String? message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthErrorCopyWith<AuthError> get copyWith =>
      _$AuthErrorCopyWithImpl<AuthError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $AuthErrorCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $AuthErrorCopyWith(AuthError value, $Res Function(AuthError) _then) =
      _$AuthErrorCopyWithImpl;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$AuthErrorCopyWithImpl<$Res> implements $AuthErrorCopyWith<$Res> {
  _$AuthErrorCopyWithImpl(this._self, this._then);

  final AuthError _self;
  final $Res Function(AuthError) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(AuthError(
      freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
