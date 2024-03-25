import 'package:chat_gemini/auth/domain/exceptions/reauthenticate_exception.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService {
  AuthService(this._auth, this._googleSignIn);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Stream<User?> get userChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  bool get isAuthenticated => currentUser != null;

  // sign in with email and password
  Future<User> authWithEmailAndPassword(
    String email,
    String password, {
    bool shouldCreate = true,
  }) async {
    try {
      late final UserCredential userCreds;

      if (shouldCreate) {
        userCreds = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCreds = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      if (userCreds.user == null) {
        throw Exception('User is null');
      }

      return userCreds.user!;
    } catch (e) {
      Log().e('$e');
      rethrow;
    }
  }

  Future<User> silentSignInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signInSilently();
      if (googleUser == null) throw Exception('User is null');
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCreds = await _auth.signInWithCredential(credential);

      if (userCreds.user == null) {
        throw Exception('User is null');
      }

      return userCreds.user!;
    } on Exception catch (e, stk) {
      Log().e('$e', stk);
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCreds = await _auth.signInWithCredential(
        credential,
      );

      if (userCreds.user == null) {
        throw Exception('User is null');
      }

      return userCreds.user!;
    } on Exception catch (e, stk) {
      Log().e('$e', stk);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await disconnectFromGoogleIfSignedIn();
    } catch (e, stk) {
      Log().e('$e', stk);
      rethrow;
    }
  }

  Future<void> disconnectFromGoogleIfSignedIn() async {
    final isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) await _googleSignIn.disconnect();
  }

  Future<UserCredential> reauthenticateUserWithEmail(
    String email,
    String password,
  ) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw const UserNotFoundException();
    }
    return currentUser.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: password,
      ),
    );
  }

  Future<UserCredential> reauthenticateUserWithGoogle() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw const UserNotFoundException();
    }

    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return currentUser.reauthenticateWithCredential(credential);
  }

  Future<void> deleteUser() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw const UserNotFoundException();
      }
      await currentUser.delete();
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw const ReauthenticateException();
      }
      rethrow;
    } catch (e, stk) {
      Log().e('$e', stk);
      rethrow;
    }
  }
}
