import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/chat/views/message/message_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.messages,
    required this.authors,
  });

  final List<User> authors;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final author = authors.firstWhereOrNull(
          (element) => element.uid == message.authorId,
        );
        return MessageWidget(
          message: messages[index],
          username: author?.name ?? 'Unknown',
          avatar: author?.photoUrl,
        );
      },
    );
  }
}
