import 'package:chat_gemini/chat/views/message/user_message.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return UserMessage(
          avatar: index % 2 == 0
              ? 'assets/images/icon_1_no_bg.png'
              : 'https://via.placeholder.com/150',
          username: 'User',
          message: 'Hello, Gemini!',
        );
      },
    );
  }
}
