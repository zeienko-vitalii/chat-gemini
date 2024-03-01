import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/chat/cubit/chat_cubit.dart';
import 'package:chat_gemini/chat/views/chat_text_field.dart';
import 'package:chat_gemini/chat/views/chat_widget.dart';
import 'package:chat_gemini/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({super.key});

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  ChatCubit get _chatCubit => context.read<ChatCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatCubit.loadChat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        final chat = state.chat;

        return Scaffold(
          drawer: const CustomDrawer(),
          appBar: customAppBar(
            context,
            title: chat.title,
          ),
          body: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is Logout) {
                context.router.replace(const AuthScreenRoute());
              }
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ChatWidget(
                            messages: chat.messages,
                            authors: [
                              state.author,
                              ...state.guests,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ).copyWith(top: 8),
                        child: ChatTextField(
                          onSend: _chatCubit.sendTextMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
