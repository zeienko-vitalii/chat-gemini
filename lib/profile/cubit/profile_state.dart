part of 'profile_cubit.dart';

sealed class ProfileState {
  ProfileState({required this.profile});

  final User? profile;
}

class ProfileInitial extends ProfileState {
  ProfileInitial({super.profile});
}

class ProfileLoading extends ProfileState {
  ProfileLoading({super.profile});
}

class ProfileUpdated extends ProfileState {
  ProfileUpdated({required super.profile});
}

class ProfileDeleted extends ProfileState {
  ProfileDeleted({super.profile});
}

class ProfileError extends ProfileState {
  ProfileError({this.error, super.profile});

  final String? error;
}
