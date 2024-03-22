import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._authService,
    this._userRepository,
  ) : super(const AuthState.loading());

  final UserRepository _userRepository;
  final AuthService _authService;

  Future<void> checkUserAuthStatus() async {
    try {
      emit(const AuthState.loading());
      final currentUser = _authService.currentUser;
      final isUserNotAuthenticated = currentUser == null;
      Log().i(
        'User is: ${isUserNotAuthenticated ? 'not' : ''} authenticated',
      );
      if (isUserNotAuthenticated) {
        emit(const AuthState.logOut());
        return;
      }

      final profile = await _userRepository.getUser(currentUser.uid);

      checkProfileCompletionAndEmitState(profile);
    } catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> silentSignInWithGoogle() async {
    try {
      final user = await _authService.silentSignInWithGoogle();
      final profile = await addUserIfNotPresent(user);

      checkProfileCompletionAndEmitState(profile);
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> emailSignIn({
    required String email,
    required String password,
    bool shouldCreate = true,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authService.authWithEmailAndPassword(
        email,
        password,
        shouldCreate: shouldCreate,
      );

      late final User profile;
      if (shouldCreate) {
        profile = await _userRepository.addUser(
          User(
            uid: user.uid,
            email: user.email!,
            name: user.displayName ?? '',
            photoUrl: user.photoURL,
          ),
        );
      } else {
        profile = await addUserIfNotPresent(user);
      }
      checkProfileCompletionAndEmitState(profile);
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthState.loading());
      final user = await _authService.signInWithGoogle();
      final profile = await addUserIfNotPresent(user);

      checkProfileCompletionAndEmitState(profile);
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<User> addUserIfNotPresent(auth.User user) async {
    try {
      final profile = await _userRepository.getUser(user.uid);
      return profile;
    } on UserNotFoundException catch (_) {
      final profile = await _userRepository.addUser(
        User(
          uid: user.uid,
          email: user.email!,
          name: user.displayName ?? '',
          photoUrl: user.photoURL,
        ),
      );

      return profile;
    } catch (e) {
      rethrow;
    }
  }

  void checkProfileCompletionAndEmitState(User user) {
    if (isProfileComplete(user.name)) {
      emit(AuthState.signedInComplete(user));
    } else {
      emit(AuthState.signedInIncomplete(user));
    }
  }

  Future<void> signOut() async {
    try {
      emit(const AuthState.loading());
      await _authService.signOut();
      emit(const AuthState.logOut());
    } catch (e) {
      emit(AuthState.error('$e'));
    }
  }
}

bool isProfileComplete(String username) {
  return username.isNotEmpty;
}
