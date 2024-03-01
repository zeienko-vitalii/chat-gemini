import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.loading());

  final _userRepository = UserRepository();
  final _authService = AuthService();

  void isUserSignIn() {
    final user = _authService.currentUser;
    Log().i('User is: ${user == null ? 'not authenticated' : 'authenticated'}');
    if (user != null) {
      emit(AuthState.signIn(user));
    } else {
      emit(const AuthState.logOut());
    }
  }

  Future<void> emailSignIn({
    required String email,
    required String password,
    bool shouldCreate = true,
  }) async {
    try {
      emit(const AuthState.loading());
      final auth.User user = await _authService.authWithEmailAndPassword(
        email,
        password,
        shouldCreate: shouldCreate,
      );
      if (shouldCreate) {
        await _userRepository.addUser(
          User(
            uid: user.uid,
            email: user.email!,
            name: user.displayName!,
            photoUrl: user.photoURL,
          ),
        );
      }
      emit(AuthState.signIn(user));
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthState.loading());
      final auth.User user = await _authService.signInWithGoogle();
      await _userRepository.addUser(
        User(
          uid: user.uid,
          email: user.email!,
          name: user.displayName!,
          photoUrl: user.photoURL,
        ),
      );
      emit(AuthState.signIn(user));
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
