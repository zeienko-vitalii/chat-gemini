import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

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
      final user = await _userRepository.getUser(currentUser.uid);

      if (user.name.isEmpty) {
        emit(AuthState.signedInIncomplete(user));
      } else {
        emit(AuthState.signedInComplete(user));
      }
    } catch (e) {
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
        try {
          // TODO(V): Add custom exceptions
          // it will fail if user is not present
          profile = await _userRepository.getUser(user.uid);
        } catch (e) {
          profile = await _userRepository.addUser(
            User(
              uid: user.uid,
              email: user.email!,
              name: user.displayName ?? '',
              photoUrl: user.photoURL,
            ),
          );
        }
      }
      if (profile.photoUrl?.isEmpty ?? true) {
        emit(AuthState.signedInIncomplete(profile));
      } else {
        emit(AuthState.signedInComplete(profile));
      }
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthState.loading());
      final user = await _authService.signInWithGoogle();
      final profile = await _userRepository.addUser(
        User(
          uid: user.uid,
          email: user.email!,
          name: user.displayName!,
          photoUrl: user.photoURL,
        ),
      );
      if (profile.photoUrl?.isEmpty ?? true) {
        emit(AuthState.signedInIncomplete(profile));
      } else {
        emit(AuthState.signedInComplete(profile));
      }
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> signOut() async {
    try {
      emit(const AuthState.loading());
      final result = await _authService.signOut();
      if (result) {
        emit(const AuthState.logOut());
      } else {
        throw Exception('Sign out failed');
      }
    } catch (e) {
      emit(AuthState.error('$e'));
    }
  }
}
