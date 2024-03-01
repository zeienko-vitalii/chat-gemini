import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:chat_gemini/utils/firestore_mixin.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository with FirestoreMixin {
  factory UserRepository() => _instance;
  UserRepository._();

  static final UserRepository _instance = UserRepository._();

  @override
  String collectionKey() => 'users';

  CollectionReference<User> _getCollectionRef() => collectionRef.withConverter(
        fromFirestore: (DocumentSnapshot<JsonType> snapshot, _) =>
            User.fromJson(
          snapshot.data()!,
        ).copyWith(
          uid: snapshot.id,
        ),
        toFirestore: (User model, _) => model.toJson(),
      );

  Future<User> getUser(String uid) async {
    try {
      final res = await _getCollectionRef().doc(uid).get();
      return res.data()!;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<User> addUser(User user) async {
    try {
      await _getCollectionRef().doc(user.uid).set(user);
      return user;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<User> updateUser(User user) async {
    try {
      await _getCollectionRef().doc(user.uid).set(user);
      return user;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }
}
