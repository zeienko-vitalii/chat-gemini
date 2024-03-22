import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/exceptions/user_not_found_exception.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late UserRepository userRepository;
  const expectedUser = User(
    uid: '123',
    name: 'John Doe',
    email: 'email@email.com',
  );

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    userRepository = UserRepository(firestoreInstance: fakeFirestore);
  });

  CollectionReference<JsonType> getCollection() => fakeFirestore.collection(
        userRepository.collectionKey(),
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

  group('getUser', () {
    test('returns a User when user exists', () async {
      // arrange
      await getCollectionRef().doc('123').set(expectedUser);

      // act
      final user = await userRepository.getUser('123');

      // assert
      expect(user, isNotNull);
      expect(user.uid, expectedUser.uid);
      expect(user.name, expectedUser.name);
      expect(user.email, expectedUser.email);
    });

    test('throws UserNotFoundException when user does', () async {
      await expectLater(
        () => userRepository.getUser('123'),
        throwsA(isA<UserNotFoundException>()),
      );
    });

    test('throws when fetching user fails', () async {
      whenCalling(Invocation.method(#collection, null))
          .on(fakeFirestore)
          .thenThrow(Exception('Error'));

      await expectLater(
        () => userRepository.getUser('123'),
        throwsException,
      );
    });
  });

  group('addUser', () {
    test('adds a User and returns the same User', () async {
      final data = await userRepository.addUser(expectedUser);

      expect(data, expectedUser);
      expect(data.email, expectedUser.email);
    });
  });

  group('updateUser', () {
    const expectedUser = User(
      uid: '123',
      name: 'John Doe',
      email: 'email@email.com',
    );

    test('updates/creates a user and returns the same User', () async {
      final data = await userRepository.updateUser(expectedUser);

      expect(data, expectedUser);
      expect(data.email, expectedUser.email);
    });
  });

  group('deleteUser', () {
    test('deletes user by id, completes successfully', () async {
      // arrange
      await getCollectionRef().doc('123').set(expectedUser);

      // act
      await userRepository.deleteUser('123');

      // assert
      final user = await getCollectionRef().doc('123').get();
      expect(user.exists, isFalse);
    });
  });
}
