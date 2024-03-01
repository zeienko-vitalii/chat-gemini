import 'package:chat_gemini/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  factory AuthService() => _instance;
  AuthService._();

  static final AuthService _instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => FirebaseAuth.instance.authStateChanges();

  User? get currentUser => _auth.currentUser;

  bool get isAuthenticated => currentUser != null;

  // sign in with email and password
  Future<User?> authWithEmailAndPassword(
    String email,
    String password, {
    bool shouldCreate = true,
  }) async {
    try {
      late final UserCredential userCreds;

      Log().i('shouldCreate: $shouldCreate, email: $email, password: $password');
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

      return userCreds.user;
    } catch (e) {
      Log().e('$e');
      rethrow;
    }
  }

  // google sign in
  // Future signInWithGoogle() async {
  //   try {
  //     final GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //     final UserCredential userCredential =
  //         await _auth.signInWithPopup(googleProvider);
  //     return userCredential;
  //   } catch (e) {
  //     Log().e('$e');
  //     rethrow;
  //   }
  // }

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCreds = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      return userCreds.user;
    } on Exception catch (e, stk) {
      Log().e('$e', stk);
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e, stk) {
      Log().e('$e', stk);
      rethrow;
    }
  }
}
