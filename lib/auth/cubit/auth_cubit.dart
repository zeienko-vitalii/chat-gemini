import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.loading());

  void isUserSignIn() {
    final user = AuthService().currentUser;
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
      final auth.User? user = await AuthService().authWithEmailAndPassword(
        email,
        password,
        shouldCreate: shouldCreate,
      );
      if (user case final user?) {
        emit(AuthState.signIn(user));
      } else {
        throw Exception('User is null');
      }
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const AuthState.loading());
      final auth.User? user = await AuthService().signInWithGoogle();
      if (user case final user?) {
        emit(AuthState.signIn(user));
      } else {
        throw Exception('User is null');
      }
    } on Exception catch (e) {
      emit(AuthState.error('$e'));
    }
  }

  Future<void> signOut() async {
    try {
      emit(const AuthState.loading());
      final result = await AuthService().signOut();
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
