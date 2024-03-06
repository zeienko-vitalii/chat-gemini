import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/data/repository/media_storage_repository.dart';
import 'package:chat_gemini/profile/data/repository/user_media_storage_repository.dart';
import 'package:chat_gemini/utils/logger.dart';
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

  final AuthService _authService;// = AuthService();
  final UserRepository _userRepository;// = UserRepository();
  final UserMediaStorageRepository _userMediaStorageRepository;// = UserMediaStorageRepository();

  final ChatRepository _repository;// = ChatRepository();
  final MediaStorageRepository _mediaStorageRepository;// = MediaStorageRepository();

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoading(profile: state.profile));

      final currentUser = _authService.currentUser;
      final id = currentUser?.uid;

      if (id == null) throw Exception('User not found');

      final user = await _userRepository.getUser(id);

      emit(ProfileUpdated(profile: user));
    } catch (e, stk) {
      Log().e(e, stk);
      emit(ProfileError(error: '$e', profile: state.profile));
    }
  }

  Future<void> updateProfilePhoto(String localFileUri) async {
    try {
      emit(
        ProfileLoading(profile: state.profile),
      );

      final currentUser = _authService.currentUser;
      final id = currentUser?.uid;
      if (id == null) throw Exception('User not found');

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
      if (id == null || profile == null) throw Exception('User not found');

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
      if (id == null) throw Exception('User not found');

      await deleteAllChats(id);
      await _userMediaStorageRepository.deleteFiles(id);
      await _userRepository.deleteUser(id);
      await _authService.signOut();
      emit(ProfileDeleted());
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

  Future<void> deleteAllChats(String userId) async {
    final chats = await _repository.getChatsByUserId(userId);

    for (final chat in chats) {
      await _repository.deleteChat(chat.id);
      await _mediaStorageRepository.deleteChatFiles(chat.id);
    }
  }
}
