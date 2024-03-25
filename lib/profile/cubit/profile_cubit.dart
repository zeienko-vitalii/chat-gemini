import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/exceptions/reauthenticate_exception.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/data/repository/media_storage_repository.dart';
import 'package:chat_gemini/profile/data/repository/user_media_storage_repository.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._authService,
    this._userRepository,
    this._userMediaStorageRepository,
    this._repository,
    this._mediaStorageRepository,
  ) : super(ProfileInitial());

  final AuthService _authService;
  final UserRepository _userRepository;
  final UserMediaStorageRepository _userMediaStorageRepository;
  final ChatRepository _repository;
  final MediaStorageRepository _mediaStorageRepository;

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoading(profile: state.profile));

      final currentUser = _authService.currentUser;
      final id = currentUser?.uid;

      if (id == null) throw const UserNotFoundException();

      final user = await _userRepository.getUser(id);

      emit(ProfileUpdated(profile: user));
    } catch (e, stk) {
      Log().e(e, stk);
      emit(ProfileError(error: '$e', profile: state.profile));
    }
  }

  Future<void> reauthenticateAndDeleteUser({
    bool isGoogleSignIn = false,
    String? email,
    String? password,
  }) async {
    final isEmailEmpty = email == null || email.isEmpty;
    final isPasswordEmpty = password == null || password.isEmpty;

    // return if email or password is empty and not google sign in
    if (!isGoogleSignIn && (isEmailEmpty || isPasswordEmpty)) {
      return;
    }

    auth.UserCredential? userCredential;
    if (isGoogleSignIn) {
      userCredential = await _authService.reauthenticateUserWithGoogle();
    } else if (!isEmailEmpty && !isPasswordEmpty) {
      userCredential = await _authService.reauthenticateUserWithEmail(
        email,
        password,
      );
    }

    if (userCredential == null) {
      throw const UserNotFoundException('User credential is null');
    } else {
      await _authService.deleteUser();
    }
  }

  Future<void> reauthenticateUserWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(ProfileLoading(profile: state.profile));

      final currentUser = await _authService.reauthenticateUserWithEmail(
        email,
        password,
      );

      final uid = currentUser.user?.uid;
      if (uid == null) throw const UserNotFoundException();

      final user = await _userRepository.getUser(uid);

      emit(ProfileUpdated(profile: user));
    } catch (e, stk) {
      Log().e(e, stk);

      emit(
        ProfileError(
          profile: state.profile,
          error: '$e',
        ),
      );
    }
  }

  Future<void> reauthenticateUserWithGoogle() async {
    try {
      emit(ProfileLoading(profile: state.profile));

      final currentUser = await _authService.reauthenticateUserWithGoogle();

      final uid = currentUser.user?.uid;
      if (uid == null) throw const UserNotFoundException();

      final user = await _userRepository.getUser(uid);

      emit(ProfileUpdated(profile: user));
    } catch (e, stk) {
      Log().e(e, stk);

      emit(
        ProfileError(
          profile: state.profile,
          error: '$e',
        ),
      );
    }
  }

  Future<void> updateProfilePhoto(String localFileUri) async {
    try {
      emit(
        ProfileLoading(profile: state.profile),
      );

      final currentUser = _authService.currentUser;
      final id = currentUser?.uid;
      if (id == null) throw const UserNotFoundException();

      final user = await _userRepository.getUser(id);
      final url = await _userMediaStorageRepository.uploadFile(
        id,
        localFileUri,
      );

      final updatedUser = await _userRepository.updateUser(
        user.copyWith(photoUrl: url),
      );

      emit(ProfileUpdated(profile: updatedUser));
    } catch (e, stk) {
      Log().e(e, stk);

      emit(
        ProfileError(
          profile: state.profile,
          error: '$e',
        ),
      );
    }
  }

  Future<void> updateUsername(String username) async {
    try {
      if (state.profile?.name == username) return;

      emit(ProfileLoading(profile: state.profile));

      final currentUser = _authService.currentUser;
      final id = currentUser?.uid;

      final profile = state.profile;
      if (id == null || profile == null) throw const UserNotFoundException();

      final updatedUser = await _userRepository.updateUser(
        profile.copyWith(name: username),
      );

      emit(ProfileUpdated(profile: updatedUser));
    } catch (e, stk) {
      Log().e(e, stk);

      emit(
        ProfileError(
          profile: state.profile,
          error: '$e',
        ),
      );
    }
  }

  Future<void> deleteAccount({
    Future<void> Function()? deleteRelatedChats,
  }) async {
    try {
      emit(ProfileLoading(profile: state.profile));

      final currentUser = _authService.currentUser;
      final id = currentUser?.uid;
      if (id == null) throw const UserNotFoundException();

      // delete all chats
      await deleteAllChats(id);

      // delete uploaded avatars
      await _userMediaStorageRepository.deleteFiles(id);

      // delete user record
      await _userRepository.deleteUser(id);

      // delete user account
      await _authService.deleteUser();

      await _authService.signOut();

      emit(ProfileDeleted());
    } catch (e, stk) {
      Log().e(e, stk);

      final needToReathenticate = e is ReauthenticateException;

      emit(
        ProfileError(
          profile: state.profile,
          error: '$e',
          needToReathenticate: needToReathenticate,
        ),
      );
    }
  }

  Future<void> deleteAllChats(String userId) async {
    final chats = await _repository.getChatsByUserId(userId);

    // await _repository.deleteAllChatsByAuthor(userId);
    for (final chat in chats) {
      await _repository.deleteChat(chat.id);
      await _mediaStorageRepository.deleteChatFiles(chat.id);
    }
  }
}
