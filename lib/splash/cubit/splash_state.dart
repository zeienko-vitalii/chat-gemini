part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashLoading extends SplashState {}

final class SplashProfileIncomplete extends SplashState {}

final class SplashSuccessful extends SplashState {}

final class SplashLoggedOut extends SplashState {}
