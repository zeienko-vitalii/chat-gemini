import 'package:chat_gemini/types/json_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin FirestoreMixin {
  /// Create a CollectionReference called users that references the firestore collection
  late final CollectionReference<JsonType> collectionRef =
      FirebaseFirestore.instance.collection(collectionKey());
  String collectionKey();
}
