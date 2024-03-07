// ignore_for_file: lines_longer_than_80_chars

import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mockito/mockito.dart';

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthService authService;
  final expectedUser = MockUser(
    uid: 'someuid',
    email: 'test@test.com',
    displayName: 'Bob',
  );

  setUp(() {
    // mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseAuth = MockFirebaseAuth(mockUser: MockUser());
    mockGoogleSignIn = MockGoogleSignIn();
    authService = AuthService(mockFirebaseAuth, mockGoogleSignIn);
  });

  group('authWithEmailAndPassword', () {
    test(
      'returns a User when user is creating an account',
      () async {
        final user = await authService.authWithEmailAndPassword(
          'test@test.com',
          'password',
        );

        expect(user, isNotNull);
        expect(user.email, expectedUser.email);
      },
    );
    test(
      'returns a User when user is authenticated',
      () async {
        final user = await authService.authWithEmailAndPassword(
          'test@test.com',
          'password',
          shouldCreate: false,
        );

        expect(user, isNull);
      },
    );

    test(
      'throws exception when something went wrong during creating an account',
      () async {
        whenCalling(Invocation.method(#createUserWithEmailAndPassword, null))
            .on(mockFirebaseAuth)
            .thenThrow(
              FirebaseAuthException(code: 'Error'),
            );
        expect(
          () => authService.authWithEmailAndPassword(
            'test@test.com',
            'password',
          ),
          throwsException,
        );
      },
    );
    test(
      'throws exception when something went wrong during authenticating',
      () async {
        whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
            .on(mockFirebaseAuth)
            .thenThrow(
              FirebaseAuthException(code: 'Error'),
            );
        expect(
          () => authService.authWithEmailAndPassword(
            'test@test.com',
            'password',
          ),
          throwsException,
        );
      },
    );
  });

  group('signInWithGoogle', () {
    test('returns a User when user is authenticated', () async {
      final user = authService.signInWithGoogle();

      expect(user, isNotNull);
    });

    test('throws when signInWithCredential fails', () async {
      whenCalling(Invocation.method(#signInWithCredential, null))
          .on(mockFirebaseAuth)
          .thenThrow(
            FirebaseAuthException(code: 'Error'),
          );
      expect(
        () => authService.signInWithGoogle(),
        throwsException,
      );
    });

    test('throws when GoogleSignIn.signIn fails', () async {
      whenCalling(Invocation.method(#signIn, null))
          .on(mockGoogleSignIn)
          .thenThrow(
            FirebaseAuthException(code: 'Error'),
          );
      expect(
        () => authService.signInWithGoogle(),
        throwsException,
      );
    });
  });

  // group('signOut', () {
  //   test('returns true when sign out is successful', () async {
  //     when(mockFirebaseAuth.signOut()).thenAnswer((_) async => {});

  //     final result = await authService.signOut();

  //     expect(result, true);
  //   });

  //   test('throws when sign out fails', () async {
  //     when(mockFirebaseAuth.signOut())
  //         .thenThrow(Exception('Failed to sign out'));

  //     expect(() async => await authService.signOut(), throwsException);
  //   });
  // });

  // group('deleteUser', () {
  //   test('returns void when user is deleted', () async {
  //     when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

  //     await authService.deleteUser();

  //     verify(mockFirebaseAuth.currentUser!.delete()).called(1);
  //   });

  //   test('throws when user is not found', () async {
  //     when(mockFirebaseAuth.currentUser).thenReturn(null);

  //     expect(() async => await authService.deleteUser(), throwsException);
  //   });
  // });
}
