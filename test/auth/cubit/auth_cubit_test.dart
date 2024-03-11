// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserRepository extends Mock implements UserRepository {}

class MockUserFirebase extends Mock implements auth.User {
  MockUserFirebase({required this.uid, this.email = ''});

  @override
  final String uid;

  @override
  final String email;
}

void main() {
  late MockAuthService mockAuthService;
  late MockUserRepository mockUserRepository;
  const expectedUserNoUsername = User(
    uid: '1',
    email: '',
    name: '',
  );
  const expectedUserWithUsername = User(
    uid: '2',
    name: 'John Doe',
    email: '',
  );

  setUpAll(() {
    mockUserRepository = MockUserRepository();
    mockAuthService = MockAuthService();
    mockUserRepository = MockUserRepository();
    registerFallbackValue(expectedUserWithUsername);
  });

  group('checkUserAuthStatus', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.logOut()] when user is not authenticated',
      build: () {
        when(() => mockAuthService.currentUser).thenReturn(null);
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.checkUserAuthStatus(),
      expect: () => const [
        AuthState.loading(),
        AuthState.logOut(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      "emits [AuthState.loading(), AuthState.signedInIncomplete()] when user is authenticated but doesn't have a username",
      build: () {
        when(() => mockAuthService.currentUser).thenReturn(
          MockUserFirebase(uid: expectedUserNoUsername.uid),
        );
        when(() => mockUserRepository.getUser(expectedUserNoUsername.uid))
            .thenAnswer((_) async => expectedUserNoUsername);

        return AuthCubit(
          mockAuthService,
          mockUserRepository,
        );
      },
      act: (cubit) => cubit.checkUserAuthStatus(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.signedInIncomplete(expectedUserNoUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInComplete()] when user is authenticated and has a username',
      build: () {
        when(() => mockAuthService.currentUser).thenReturn(
          MockUserFirebase(uid: expectedUserWithUsername.uid),
        );

        when(() => mockUserRepository.getUser(expectedUserWithUsername.uid))
            .thenAnswer((_) async => expectedUserWithUsername);

        return AuthCubit(
          mockAuthService,
          mockUserRepository,
        );
      },
      act: (cubit) => cubit.checkUserAuthStatus(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.signedInComplete(expectedUserWithUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.error()] when something fails',
      build: () {
        when(() => mockAuthService.currentUser).thenThrow(Exception('Error'));

        return AuthCubit(
          mockAuthService,
          mockUserRepository,
        );
      },
      act: (cubit) => cubit.checkUserAuthStatus(),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Exception: Error'),
      ],
    );
  });

  group('addUserIfNotPresent', () {
    late AuthCubit authCubit;
    late MockUserFirebase mockUserFirebase;

    setUp(() {
      authCubit = AuthCubit(mockAuthService, mockUserRepository);
      mockUserFirebase = MockUserFirebase(
        uid: expectedUserWithUsername.uid,
      );
    });

    test('returns user if there is a record in the Firestore', () {
      when(() => mockUserRepository.getUser(mockUserFirebase.uid))
          .thenAnswer((_) async => expectedUserWithUsername);

      expect(
        authCubit.addUserIfNotPresent(mockUserFirebase),
        completion(expectedUserWithUsername),
      );
    });

    test(
        'returns user after adding him to the Firestore when UserNotFoundException was thrown',
        () async {
      when(() => mockUserRepository.getUser(mockUserFirebase.uid))
          .thenThrow(const UserNotFoundException());
      when(
        () => mockUserRepository.addUser(any()),
      ).thenAnswer((_) async => expectedUserWithUsername);

      final profile = await authCubit.addUserIfNotPresent(mockUserFirebase);

      verify(
        () => mockUserRepository.addUser(any()),
      ).called(1);
      expect(profile, expectedUserWithUsername);
    });
    test(
        'throws an error if something went wrong and the error is not UserNotFoundException',
        () {
      when(() => mockUserRepository.getUser(mockUserFirebase.uid))
          .thenThrow(Exception('Error'));

      expect(
        authCubit.addUserIfNotPresent(mockUserFirebase),
        throwsException,
      );
    });
  });

  group('silentSignInWithGoogle', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.signedInComplete()] when user authenticated and profile is completed',
      build: () {
        when(() => mockAuthService.silentSignInWithGoogle()).thenAnswer(
          (_) async => MockUserFirebase(uid: expectedUserWithUsername.uid),
        );
        when(() => mockUserRepository.getUser(expectedUserWithUsername.uid))
            .thenAnswer(
          (_) async => expectedUserWithUsername,
        );
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.silentSignInWithGoogle(),
      expect: () => const [
        AuthState.signedInComplete(expectedUserWithUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.signedInIncomplete()] when user authenticated and profile is incompleted',
      build: () {
        when(() => mockAuthService.silentSignInWithGoogle()).thenAnswer(
          (_) async => MockUserFirebase(uid: expectedUserNoUsername.uid),
        );
        when(() => mockUserRepository.getUser(expectedUserNoUsername.uid))
            .thenAnswer(
          (_) async => expectedUserNoUsername,
        );
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.silentSignInWithGoogle(),
      expect: () => const [
        AuthState.signedInIncomplete(expectedUserNoUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.error()] when something fails',
      build: () {
        when(() => mockAuthService.silentSignInWithGoogle()).thenThrow(
          Exception(),
        );
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.silentSignInWithGoogle(),
      expect: () => const [
        AuthState.error('Exception'),
      ],
    );
  });

  group('emailSignIn', () {
    const password = 'password';

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInComplete()] when sign in succeeds and completed profile',
      build: () {
        when(
          () => mockAuthService.authWithEmailAndPassword(
            expectedUserWithUsername.email,
            password,
          ),
        ).thenAnswer(
          (_) async => MockUserFirebase(
            uid: expectedUserWithUsername.uid,
            email: expectedUserWithUsername.email,
          ),
        );
        when(() => mockUserRepository.addUser(any())).thenAnswer(
          (_) async => expectedUserWithUsername,
        );

        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.emailSignIn(
        email: expectedUserWithUsername.email,
        password: password,
      ),
      expect: () => const [
        AuthState.loading(),
        AuthState.signedInComplete(expectedUserWithUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInIncomplete()] when sign in succeeds and incompleted profile',
      build: () {
        when(
          () => mockAuthService.authWithEmailAndPassword(
            expectedUserNoUsername.email,
            password,
          ),
        ).thenAnswer(
          (_) async => MockUserFirebase(
            uid: expectedUserNoUsername.uid,
            email: expectedUserNoUsername.email,
          ),
        );
        when(() => mockUserRepository.addUser(any())).thenAnswer(
          (_) async => expectedUserNoUsername,
        );

        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.emailSignIn(
        email: expectedUserNoUsername.email,
        password: password,
      ),
      expect: () => const [
        AuthState.loading(),
        AuthState.signedInIncomplete(expectedUserNoUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.error()] when sign-in fails',
      build: () {
        when(
          () => mockAuthService.authWithEmailAndPassword(
            expectedUserNoUsername.email,
            password,
          ),
        ).thenThrow(Exception('Invalid credentials'));

        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.emailSignIn(
        email: expectedUserNoUsername.email,
        password: password,
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Exception: Invalid credentials'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInComplete()] when user exists and shouldCreate is false',
      build: () {
        when(
          () => mockAuthService.authWithEmailAndPassword(
            expectedUserWithUsername.email,
            password,
            shouldCreate: false,
          ),
        ).thenAnswer(
          (_) async => MockUserFirebase(
            uid: expectedUserWithUsername.uid,
            email: expectedUserWithUsername.email,
          ),
        );
        when(
          () => mockUserRepository.getUser(expectedUserWithUsername.uid),
        ).thenAnswer(
          (_) async => expectedUserWithUsername,
        );

        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.emailSignIn(
        email: expectedUserWithUsername.email,
        password: password,
        shouldCreate: false,
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.signedInComplete(expectedUserWithUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInIncomplete()] when user exists and shouldCreate is false and profile is incompleted',
      build: () {
        when(
          () => mockAuthService.authWithEmailAndPassword(
            expectedUserNoUsername.email,
            password,
            shouldCreate: false,
          ),
        ).thenAnswer(
          (_) async => MockUserFirebase(
            uid: expectedUserNoUsername.uid,
            email: expectedUserNoUsername.email,
          ),
        );
        when(
          () => mockUserRepository.getUser(expectedUserNoUsername.uid),
        ).thenAnswer(
          (_) async => expectedUserNoUsername,
        );

        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.emailSignIn(
        email: expectedUserNoUsername.email,
        password: password,
        shouldCreate: false,
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.signedInIncomplete(expectedUserNoUsername),
      ],
    );
  });

  group('signInWithGoogle', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInComplete()] when user authenticated and profile is completed',
      build: () {
        when(() => mockAuthService.signInWithGoogle()).thenAnswer(
          (_) async => MockUserFirebase(uid: expectedUserWithUsername.uid),
        );
        when(() => mockUserRepository.getUser(expectedUserWithUsername.uid))
            .thenAnswer(
          (_) async => expectedUserWithUsername,
        );
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => const [
        AuthState.loading(),
        AuthState.signedInComplete(expectedUserWithUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.signedInIncomplete()] when user authenticated and profile is incompleted',
      build: () {
        when(() => mockAuthService.signInWithGoogle()).thenAnswer(
          (_) async => MockUserFirebase(uid: expectedUserNoUsername.uid),
        );
        when(() => mockUserRepository.getUser(expectedUserNoUsername.uid))
            .thenAnswer(
          (_) async => expectedUserNoUsername,
        );
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => const [
        AuthState.loading(),
        AuthState.signedInIncomplete(expectedUserNoUsername),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.error()] when something fails',
      build: () {
        when(() => mockAuthService.signInWithGoogle()).thenThrow(
          Exception(),
        );
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => const [
        AuthState.loading(),
        AuthState.error('Exception'),
      ],
    );
  });

  group('checkProfileCompletionAndEmitState', () {
    const incompletedProfile = User(
      uid: '1',
      name: '',
      email: '',
    );

    const completedProfile = User(
      uid: '2',
      name: 'John Doe',
      email: '',
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.signedInComplete(user)] when profile is complete',
      build: () => AuthCubit(
        mockAuthService,
        mockUserRepository,
      ),
      act: (cubit) => cubit.checkProfileCompletionAndEmitState(
        completedProfile,
      ),
      expect: () => [const AuthState.signedInComplete(completedProfile)],
    );
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.signedInIncomplete(user)] when profile is incomplete',
      build: () => AuthCubit(
        mockAuthService,
        mockUserRepository,
      ),
      act: (cubit) => cubit.checkProfileCompletionAndEmitState(
        incompletedProfile,
      ),
      expect: () => [const AuthState.signedInIncomplete(incompletedProfile)],
    );
  });

  group('signOut', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.logOut()] when sign out succeeds',
      build: () {
        when(() => mockAuthService.signOut()).thenAnswer((_) async {});
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.signOut(),
      expect: () => const [
        AuthState.loading(),
        AuthState.logOut(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.error()] when sign out fails',
      build: () {
        when(() => mockAuthService.signOut()).thenThrow(Exception('Error'));
        return AuthCubit(mockAuthService, mockUserRepository);
      },
      act: (cubit) => cubit.signOut(),
      expect: () => const [
        AuthState.loading(),
        AuthState.error('Exception: Error'),
      ],
    );
  });

  group('isProfileComplete', () {
    test('returns true if passed username is not empty', () {
      const username = 'John Doe';
      expect(isProfileComplete(username), isTrue);
    });
    test('returns false if passed username is empty', () {
      const username = '';
      expect(isProfileComplete(username), isFalse);
    });
  });
}
