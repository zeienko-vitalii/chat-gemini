import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:chat_gemini/utils/base_firestore.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class ChatRepository extends BaseFirestore {
  ChatRepository({required super.firestoreInstance});

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

  Future<Chat> getChatById(String chatId) async {
    try {
      final result = await _getCollectionRef().doc(chatId).get();
      final chat = result.data();

      if (chat == null) throw Exception('Chat not found');
      return chat;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<Chat> getChatByUserId(String userId) async {
    try {
      final chats = await getChatsByUserId(userId);
      if (chats.isEmpty) return const Chat();
      return chats.first;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<List<Chat>> getChatsByUserId(String userId) async {
    try {
      final res = await _getCollectionRef()
          .where(
            'authorId',
            isEqualTo: userId,
          )
          .get();

      final chats = res.docs;
      return [
        ...chats.map((e) => e.data()),
      ];
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

  Future<bool> deleteAllChatsByAuthor(String id) async {
    try {
      final chats = await _getCollectionRef()
          .where(
            'authorId',
            isEqualTo: id,
          )
          .get();

      for (final chat in chats.docs) {
        await chat.reference.delete();
      }
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
