import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/chat/views/message/message_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.messages,
  });

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageWidget(
          message: messages[index],
        );
      },
    );
  }
}
