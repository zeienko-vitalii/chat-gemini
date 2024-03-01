part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.signIn(auth.User user) = SignIn;
  const factory AuthState.logOut() = Logout;
  const factory AuthState.error([String? message]) = AuthError;
}
