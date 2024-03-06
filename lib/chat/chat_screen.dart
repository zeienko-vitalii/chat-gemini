import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/chat/cubit/chat_cubit.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/views/chat_component.dart';
import 'package:chat_gemini/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    this.chat = const Chat(),
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatCubit>(),
      child: ChatComponent(chat: chat),
    );
  }
}
