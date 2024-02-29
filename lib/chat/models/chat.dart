import 'package:chat_gemini/chat/models/message.dart';

class Chat {
  Chat({
    this.name = 'Undefined',
    required this.authorId,
    this.messages = const [],
    this.sharedWithIds = const [],
    this.createdAt,
    this.updatedAt,
  });

  final String name;
  final String authorId;
  final List<String> sharedWithIds;
  final List<Message> messages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
