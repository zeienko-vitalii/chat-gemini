import 'package:chat_gemini/utils/base_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

// Mocking the necessary classes
class MockBaseFirestore extends BaseFirestore {
  MockBaseFirestore({required super.firestoreInstance});

  @override
  String collectionKey() => 'users';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BaseFirestore', () {
    late MockBaseFirestore mockFirestoreMixin;

    setUp(() {
      mockFirestoreMixin = MockBaseFirestore(
        firestoreInstance: FakeFirebaseFirestore(),
      );
    });

    test('collectionRef is correctly initialized', () {
      expect(mockFirestoreMixin.collectionRef, isNotNull);
      expect(mockFirestoreMixin.collectionRef.id, 'users');
    });

    test('firestoreInstance is correctly initialized', () {
      expect(mockFirestoreMixin.firestoreInstance, isNotNull);
      expect(
        mockFirestoreMixin.firestoreInstance,
        isA<FakeFirebaseFirestore>(),
      );
    });
  });
}
