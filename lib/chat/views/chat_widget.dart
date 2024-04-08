import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/chat/views/message/message_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    required this.messages,
    required this.authors,
    required this.scrollController,
    super.key,
    this.listPadding = const EdgeInsets.only(bottom: 60),
  });

  final ScrollController scrollController;
  final List<User> authors;
  final List<Message> messages;
  final EdgeInsetsGeometry listPadding;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: listPadding,
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isBot = message.isBot;

        if (isBot) {
          return MessageWidget(
            message: messages[index],
            username: 'Gemini',
            avatar: 'assets/images/launcher_icon.png',
          );
        }

        final author = authors.firstWhereOrNull(
          (element) => element.uid == message.authorId,
        );

        return MessageWidget(
          message: messages[index],
          username: author?.name ?? message.authorId,
          avatar: author?.photoUrl,
        );
      },
    );
  }
}
