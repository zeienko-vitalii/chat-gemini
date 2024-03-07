import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late UserRepository userRepository;

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
    const expectedUser = User(
      uid: '123',
      name: 'John Doe',
      email: 'email@email.com',
    );

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

    test('throws when user does not exist', () async {
      await expectLater(
        () => userRepository.getUser('123'),
        throwsException,
      );
    });
  });

  group('addUser', () {
    const expectedUser = User(
      uid: '123',
      name: 'John Doe',
      email: 'email@email.com',
    );

    test('adds a User and returns the same User', () async {
      final addedUser = await userRepository.addUser(expectedUser);

      expect(addedUser, expectedUser);
    });

    // test('throws when there is an error', () async {
    //   const user = User(uid: '123', name: 'John Doe', email: '');

    //   when(
    //     () => fakeFirestore
    //         .collection('users')
    //         .doc('123')
    //         .set(<String, dynamic>{}),
    //   ).thenThrow(
    //     Exception('Failed to add user'),
    //   );

    //   expect(
    //     () async => userRepository.addUser(user),
    //     throwsException,
    //   );
    // });
  });

  group('updateUser', () {
    const expectedUser = User(
      uid: '123',
      name: 'John Doe',
      email: 'email@email.com',
    );

    test('updates a User and returns the same User', () async {
      final addedUser = await userRepository.updateUser(expectedUser);

      expect(addedUser, expectedUser);
    });
  });

  group('deleteUser', () {
    const expectedUser = User(
      uid: '123',
      name: 'John Doe',
      email: 'email@email.com',
    );

    test('deletes user by id, completes successfully', () async {
      // arrange
      await getCollectionRef().doc('123').set(expectedUser);

      await userRepository.deleteUser(expectedUser.uid);

      await expectLater(
        () => userRepository.getUser('123'),
        throwsException,
      );
    });
  });
}
