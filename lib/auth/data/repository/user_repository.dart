import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:chat_gemini/utils/base_firestore.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserRepository extends BaseFirestore {
  UserRepository({required super.firestoreInstance});

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

  Future<void> deleteUser(String uid) async {
    try {
      await _getCollectionRef().doc(uid).delete();
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }
}
