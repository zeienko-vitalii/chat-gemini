// ignore_for_file: lines_longer_than_80_chars

import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mocktail/mocktail.dart';

class MockitoFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockAuthCredential extends Mock implements AuthCredential {}

class MockitoGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockOAuthCredential extends Mock implements OAuthCredential {}

class MockitoUser extends Mock implements User {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {
  @override
  String? get idToken => '';

  @override
  String? get accessToken => '';
}

void main() {
  late MockitoFirebaseAuth mockitoFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockitoGoogleSignIn mockitoGoogleSignIn;
  late MockUserCredential userCreds;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;

  late AuthService authService;
  late AuthService authServiceMockGooglSignIn;
  final expectedUser = MockUser(
    uid: 'someuid',
    email: 'test@test.com',
    displayName: 'Bob',
  );

  setUp(() {
    mockitoFirebaseAuth = MockitoFirebaseAuth();
    mockitoGoogleSignIn = MockitoGoogleSignIn();
    mockGoogleSignIn = MockGoogleSignIn();
    userCreds = MockUserCredential();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    authService = AuthService(mockitoFirebaseAuth, mockGoogleSignIn);
    authServiceMockGooglSignIn = AuthService(
      mockitoFirebaseAuth,
      mockitoGoogleSignIn,
    );
    registerFallbackValue(MockOAuthCredential());
  });

  group('authWithEmailAndPassword', () {
    test(
      'returns a User when user is creating an account',
      () async {
        when(() => userCreds.user).thenReturn(expectedUser);

        when(
          () => mockitoFirebaseAuth.createUserWithEmailAndPassword(
            email: expectedUser.email!,
            password: 'password',
          ),
        ).thenAnswer((_) => Future.value(userCreds));

        final user = await authService.authWithEmailAndPassword(
          expectedUser.email!,
          'password',
        );

        expect(user, isNotNull);
        expect(user.email, expectedUser.email);
      },
    );
    test(
      'returns a User when user is authenticated',
      () async {
        when(() => userCreds.user).thenReturn(expectedUser);

        when(
          () => mockitoFirebaseAuth.signInWithEmailAndPassword(
            email: expectedUser.email!,
            password: 'password',
          ),
        ).thenAnswer((_) => Future.value(userCreds));

        final user = await authService.authWithEmailAndPassword(
          expectedUser.email!,
          'password',
          shouldCreate: false,
        );

        expect(user, isNotNull);
        expect(user.email, expectedUser.email);
      },
    );

    test(
      'throws exception when user is null',
      () async {
        when(() => userCreds.user).thenReturn(null);
        when(
          () => mockitoFirebaseAuth.signInWithEmailAndPassword(
            email: expectedUser.email!,
            password: 'password',
          ),
        ).thenAnswer((_) => Future.value(userCreds));
        expect(
          authService.authWithEmailAndPassword(
            expectedUser.email!,
            'password',
            shouldCreate: false,
          ),
          throwsException,
        );
      },
      timeout: const Timeout(Duration(seconds: 1)),
    );
    test(
      'throws exception when something went wrong during creating an account',
      () async {
        when(
          () => mockitoFirebaseAuth.createUserWithEmailAndPassword(
            email: expectedUser.email!,
            password: 'password',
          ),
        ).thenThrow(Exception());
        expect(
          authService.authWithEmailAndPassword(expectedUser.email!, 'password'),
          throwsException,
        );
      },
    );
    test(
      'throws exception when something went wrong during authenticating',
      () async {
        when(
          () => mockitoFirebaseAuth.signInWithEmailAndPassword(
            email: expectedUser.email!,
            password: 'password',
          ),
        ).thenThrow(Exception());
        expect(
          authService.authWithEmailAndPassword(
            expectedUser.email!,
            'password',
            shouldCreate: false,
          ),
          throwsException,
        );
      },
    );
  });

  group(
    'silentSignInWithGoogle',
    () {
      test('returns a User when user is authenticated', () async {
        when(() => mockitoGoogleSignIn.signInSilently()).thenAnswer(
          (_) => Future.value(mockGoogleSignInAccount),
        );
        when(() => mockGoogleSignInAccount.authentication).thenAnswer(
          (_) => Future.value(mockGoogleSignInAuthentication),
        );
        when(() => userCreds.user).thenReturn(expectedUser);
        when(
          () => mockitoFirebaseAuth.signInWithCredential(any()),
        ).thenAnswer((_) => Future.value(userCreds));
        final user = await authServiceMockGooglSignIn.silentSignInWithGoogle();

        expect(user, isNotNull);
      });

      test('throws Exception when user is null', () async {
        when(() => mockitoGoogleSignIn.signInSilently()).thenAnswer(
          (_) => Future.value(mockGoogleSignInAccount),
        );
        when(() => mockGoogleSignInAccount.authentication).thenAnswer(
          (_) => Future.value(mockGoogleSignInAuthentication),
        );
        when(() => userCreds.user).thenReturn(null);
        when(
          () => mockitoFirebaseAuth.signInWithCredential(any()),
        ).thenAnswer((_) => Future.value(userCreds));

        expect(
          () => authServiceMockGooglSignIn.silentSignInWithGoogle(),
          throwsException,
        );
      });

      test('throws Exception when GoogleSignIn.signInSilently fails', () async {
        when(
          () => mockitoGoogleSignIn.signInSilently(),
        ).thenThrow(Exception());
        expect(
          authServiceMockGooglSignIn.silentSignInWithGoogle(),
          throwsException,
        );
      });

      test('throws Exception when signInWithCredential fails', () async {
        when(() => mockitoGoogleSignIn.signInSilently()).thenAnswer(
          (_) => Future.value(mockGoogleSignInAccount),
        );
        when(() => mockGoogleSignInAccount.authentication).thenAnswer(
          (_) => Future.value(mockGoogleSignInAuthentication),
        );
        when(() => userCreds.user).thenReturn(null);
        when(
          () => mockitoFirebaseAuth.signInWithCredential(any()),
        ).thenThrow(Exception());

        expect(
          authServiceMockGooglSignIn.silentSignInWithGoogle(),
          throwsException,
        );
      });
    },
  );

  group('signInWithGoogle', () {
    test('returns a User when user is authenticated', () async {
      when(() => userCreds.user).thenReturn(expectedUser);
      when(
        () => mockitoFirebaseAuth.signInWithCredential(any()),
      ).thenAnswer((_) => Future.value(userCreds));

      final user = await authService.signInWithGoogle();

      expect(user, isNotNull);
      expect(user.email, expectedUser.email);
    });

    test('throws Exception when user is null', () async {
      when(() => userCreds.user).thenReturn(null);
      when(
        () => mockitoFirebaseAuth.signInWithCredential(any()),
      ).thenAnswer((_) => Future.value(userCreds));

      expect(
        () => authService.signInWithGoogle(),
        throwsException,
      );
    });

    test('throws Exception when GoogleSignIn.signIn fails', () async {
      whenCalling(Invocation.method(#signIn, null))
          .on(mockGoogleSignIn)
          .thenThrow(
            FirebaseAuthException(code: 'Error'),
          );
      when(
        () => mockitoFirebaseAuth.signInWithCredential(any()),
      ).thenAnswer((_) => Future.value(userCreds));

      expect(
        authService.signInWithGoogle(),
        throwsException,
      );
    });

    test('throws Exception when signInWithCredential fails', () async {
      when(
        () => mockitoFirebaseAuth.signInWithCredential(any()),
      ).thenThrow(Exception());

      expect(
        authService.signInWithGoogle(),
        throwsException,
      );
    });
  });

  group('disconnectFromGoogleIfSignedIn', () {
    test('disconnects from Google if user is signed in', () async {
      when(() => mockitoGoogleSignIn.isSignedIn())
          .thenAnswer((_) => Future.value(true));
      when(() => mockitoGoogleSignIn.disconnect())
          .thenAnswer((_) => Future.value());

      await authServiceMockGooglSignIn.disconnectFromGoogleIfSignedIn();

      verify(() => mockitoGoogleSignIn.disconnect()).called(1);
    });

    test('returns without disconnecting when user is not signed in', () async {
      when(() => mockitoGoogleSignIn.isSignedIn())
          .thenAnswer((_) => Future.value(false));
      when(() => mockitoGoogleSignIn.disconnect())
          .thenAnswer((_) => Future.value());

      await authServiceMockGooglSignIn.disconnectFromGoogleIfSignedIn();

      verifyNever(() => mockitoGoogleSignIn.disconnect());
    });

    test('throws error when GoogleSignIn.isSignedIn fails', () async {
      when(() => mockitoGoogleSignIn.isSignedIn()).thenThrow(Exception());
      expect(
        () => authServiceMockGooglSignIn.disconnectFromGoogleIfSignedIn(),
        throwsException,
      );
    });
    test(
      'throws error when user is signed in and GoogleSignIn.disconnect fails',
      () async {
        when(() => mockitoGoogleSignIn.isSignedIn())
            .thenAnswer((_) => Future.value(true));
        when(() => mockitoGoogleSignIn.disconnect()).thenThrow(Exception());

        expect(
          () => authServiceMockGooglSignIn.disconnectFromGoogleIfSignedIn(),
          throwsException,
        );
      },
    );
  });

  group('signOut', () {
    late MockitoGoogleSignIn mockitoGoogleSignIn;
    late AuthService authService;

    setUp(() {
      mockitoGoogleSignIn = MockitoGoogleSignIn();
      authService = AuthService(mockitoFirebaseAuth, mockitoGoogleSignIn);
    });

    test(
      'returns successfully if user was signed out and disconnected from Google if user was previously signed in with Google',
      () async {
        when(() => mockitoGoogleSignIn.isSignedIn())
            .thenAnswer((_) => Future.value(true));
        when(() => mockitoGoogleSignIn.disconnect())
            .thenAnswer((_) => Future.value());
        when(() => mockitoFirebaseAuth.signOut()).thenAnswer((_) {
          return Future.value();
        });

        await authService.signOut();

        verify(() => mockitoGoogleSignIn.disconnect()).called(1);
        verify(() => mockitoFirebaseAuth.signOut()).called(1);
      },
    );
    test(
      "returns successfully if user was signed out when user wasn't previously signed in with Google",
      () async {
        when(() => mockitoGoogleSignIn.isSignedIn())
            .thenAnswer((_) => Future.value(false));
        when(() => mockitoFirebaseAuth.signOut()).thenAnswer((_) {
          return Future.value();
        });

        await authService.signOut();

        verifyNever(() => mockitoGoogleSignIn.disconnect());
        verify(() => mockitoFirebaseAuth.signOut()).called(1);
      },
    );

    test(
      'throws error when FirebaseAuth.signOut or disconnectFromGoogleIfSignedIn fails',
      () async {
        when(() => mockitoGoogleSignIn.isSignedIn())
            .thenAnswer((_) => Future.value(true));
        when(() => mockitoGoogleSignIn.disconnect()).thenThrow(Exception());
        when(() => mockitoFirebaseAuth.signOut()).thenAnswer((_) {
          return Future.value();
        });

        expect(
          () => authService.signOut(),
          throwsException,
        );
      },
    );
  });

  group('deleteUser', () {
    final mockedUser = MockitoUser();

    test('returns successfully when current user is deleted', () async {
      when(() => mockitoFirebaseAuth.currentUser).thenReturn(mockedUser);
      when(mockedUser.delete).thenAnswer((_) => Future.value());

      await authServiceMockGooglSignIn.deleteUser();

      verify(mockedUser.delete).called(1);
    });

    test('throws when user is not found', () async {
      when(() => mockitoFirebaseAuth.currentUser).thenReturn(null);

      expect(
        () => authServiceMockGooglSignIn.deleteUser(),
        throwsA(isA<UserNotFoundException>()),
      );
    });
    test('throws when deleting user fails', () async {
      when(() => mockitoFirebaseAuth.currentUser).thenReturn(mockedUser);
      when(mockedUser.delete).thenThrow(Exception());

      expect(
        () => authServiceMockGooglSignIn.deleteUser(),
        throwsException,
      );
    });
  });
}
