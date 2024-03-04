part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.signedInComplete(User user) = SignedInComplete;
  const factory AuthState.signedInIncomplete(User user) = SignedInIncomplete;
  const factory AuthState.logOut() = LogOut;
  const factory AuthState.error([String? message]) = AuthError;
}
