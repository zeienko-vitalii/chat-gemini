import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:chat_gemini/utils/firestore_mixin.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository with FirestoreMixin {
  factory ChatRepository() => _instance;
  ChatRepository._();

  static final ChatRepository _instance = ChatRepository._();

  @override
  String collectionKey() => 'chats';

  CollectionReference<Chat> _getCollectionRef() => collectionRef.withConverter(
        fromFirestore: (DocumentSnapshot<JsonType> snapshot, _) =>
            Chat.fromJson(
          snapshot.data()!,
        ).copyWith(
          id: snapshot.id,
        ),
        toFirestore: (Chat model, _) => model.toJson(),
      );

  Future<Chat> getChatByUserId(String userId) async {
    try {
      final res =
          await _getCollectionRef().where('authorId', isEqualTo: userId).get();
      return res.docs.first.data();
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<Chat> addChat(Chat chat) async {
    try {
      final res = await _getCollectionRef().add(chat);
      return chat.copyWith(id: res.id);
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<Chat> updateChat(Chat chat) async {
    try {
      await _getCollectionRef().doc(chat.id).update(
            chat.toJson(),
          );
      return chat;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<bool> deleteChat(String id) async {
    try {
      await _getCollectionRef().doc(id).delete();
      return true;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<bool> addMessage(String chatId, Message message) async {
    try {
      await _getCollectionRef().doc(chatId).update(
        {
          'messages': FieldValue.arrayUnion([message.toJson()]),
        },
      );
      return true;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  // Future<bool> addMessages() async {}
}
