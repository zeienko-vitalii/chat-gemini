import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chats/views/chat_list_component.dart';
import 'package:chat_gemini/chats/cubit/chats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit(),
      lazy: true,
      child: ChatListComponent(chat: chat),
    );
  }
}
