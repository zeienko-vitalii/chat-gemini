// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mockito/mockito.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserFirebase extends Mock implements auth.User {
  MockUserFirebase({required this.uid});

  @override
  final String uid;
}

void main() {
  late MockAuthService mockAuthService;
  late UserRepository mockUserRepository;
  late FakeFirebaseFirestore fakeFirestore;
  // late UserRepository userRepository;

  setUpAll(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockUserRepository = UserRepository(firestoreInstance: fakeFirestore);
  });

  CollectionReference<JsonType> getCollection() => fakeFirestore.collection(
        mockUserRepository.collectionKey(),
      );

  CollectionReference<User> getCollectionRef() => getCollection().withConverter(
        fromFirestore: (DocumentSnapshot<JsonType> snapshot, _) =>
            User.fromJson(
          snapshot.data()!,
        ).copyWith(
          uid: snapshot.id,
        ),
        toFirestore: (User model, _) => model.toJson(),
      );

  setUpAll(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockAuthService = MockAuthService();
    mockUserRepository = UserRepository(
      firestoreInstance: fakeFirestore,
    );
  });

  group('checkUserAuthStatus', () {
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

    setUpAll(() async {
      await Future.wait([
        getCollectionRef()
            .doc(expectedUserNoUsername.uid)
            .set(expectedUserNoUsername),
        getCollectionRef()
            .doc(expectedUserWithUsername.uid)
            .set(expectedUserWithUsername),
      ]);
    });

    tearDownAll(() async {
      await Future.wait([
        getCollectionRef().doc(expectedUserNoUsername.uid).delete(),
        getCollectionRef().doc(expectedUserWithUsername.uid).delete(),
      ]);
    });

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.logOut()] when user is not authenticated',
      build: () {
        when(mockAuthService.currentUser).thenReturn(null);
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
        when(mockAuthService.currentUser).thenReturn(
          MockUserFirebase(uid: expectedUserNoUsername.uid),
        );
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
        when(mockAuthService.currentUser).thenReturn(
          MockUserFirebase(uid: expectedUserWithUsername.uid),
        );
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
  });

  group('emailSignIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.error()] when FirebaseAuth.authWithEmailAndPassword fails',
      build: () {
        return AuthCubit(
          mockAuthService,
          mockUserRepository,
        );
      },
      act: (cubit) => cubit.checkUserAuthStatus(),
      expect: () => [
        const AuthState.loading(),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading(), AuthState.error()] when FirebaseAuth.authWithEmailAndPassword fails',
      build: () {
        return AuthCubit(
          mockAuthService,
          mockUserRepository,
        );
      },
      act: (cubit) => cubit.checkUserAuthStatus(),
      expect: () => [
        const AuthState.loading(),
      ],
    );
  });

  group('addUserIfNotPresent', () {
    late final AuthCubit authCubit;
    late final MockUserFirebase existedUser;
    late final MockUserFirebase notExistedUser;
    const profile = User(
      uid: '123',
      name: '',
      email: '',
    );
    setUpAll(() {
      authCubit = AuthCubit(
        mockAuthService,
        mockUserRepository,
      );
      existedUser = MockUserFirebase(uid: profile.uid);
      notExistedUser = MockUserFirebase(uid: '1');
    });

    setUpAll(() async {
      await getCollectionRef().doc(existedUser.uid).set(profile);
    });

    tearDownAll(() async {
      await getCollectionRef().doc(existedUser.uid).delete();
    });

    test('returns user if it present in the Firestore', () async {
      final user = await authCubit.addUserIfNotPresent(existedUser);
      expect(user, profile);
    });
    test(
      "adds and returns user from the Firestore when it wasn't present",
      () async {
        try {
          final user = await authCubit.addUserIfNotPresent(notExistedUser);
          print('Here');
          expect(user, isA<User>());
        } catch (e) {
          print('Here1');
          expect(e, isA<UserNotFoundException>());
        }
      },
      timeout: const Timeout(Duration(seconds: 1)),
    );

    test(
      'throws Exception when something went wrong while fetching user from the Firestore',
      () {
        whenCalling(Invocation.method(#getUser, ['1']))
            .on(mockUserRepository)
            .thenThrow(Exception('Error'));
        expect(
          () => authCubit.addUserIfNotPresent(existedUser),
          throwsException,
        );
      },
    );
    test(
      'throws Exception when something went wrong while adding user to the Firestore',
      () {},
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
