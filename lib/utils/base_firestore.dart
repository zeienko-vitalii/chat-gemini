import 'package:chat_gemini/types/json_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseFirestore {
  BaseFirestore({required this.firestoreInstance});

  /// Create a CollectionReference called users
  /// that references the firestore collection
  late final CollectionReference<JsonType> collectionRef =
      firestoreInstance.collection(
    collectionKey(),
  );
  String collectionKey();
  final FirebaseFirestore firestoreInstance;
}
