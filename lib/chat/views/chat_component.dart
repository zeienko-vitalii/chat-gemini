import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/chat/cubit/chat_cubit.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/chat/views/chat_text_field.dart';
import 'package:chat_gemini/chat/views/chat_widget.dart';
import 'package:chat_gemini/chat/views/empty_chat_widget.dart';
import 'package:chat_gemini/chat/views/invalid_api_key_widget.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:chat_gemini/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({super.key, required this.chat});

  final Chat chat;

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final ScrollController _scrollController = ScrollController();

  ChatCubit get _chatCubit => context.read<ChatCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatCubit.loadChat(widget.chat);
    });
  }

  @override
  void didUpdateWidget(covariant ChatComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chat != widget.chat) {
      _chatCubit.loadChat(widget.chat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: _authStateListener,
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: _chatStateListener,
        builder: (context, state) {
          final chat = state.chat;
          final isLoading = state is ChatLoading;

          final apiKeyError =
              state is ChatError && (state.message?.contains('API') ?? false);
          const noApiKey = String.fromEnvironment('GEMINI_API_KEY') == '';
          return Scaffold(
            drawer: CustomDrawer(chat: chat),
            appBar: customAppBar(
              context,
              title: chat.title,
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: FocusScope.of(context).unfocus,
                child: _ChatBody(
                  scrollController: _scrollController,
                  messages: chat.messages,
                  authors: [
                    state.author,
                    ...state.guests,
                  ],
                  isLoading: isLoading,
                  hasApiKey: apiKeyError || noApiKey,
                  onSend: _chatCubit.sendTextMessage,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _chatStateListener(BuildContext context, ChatState state) {
    if (state is ChatUpdated && state.chat.messages.isNotEmpty) {
      _scrollDown();
    } else if (state is ChatError) {
      showErrorSnackBar(context, state.message);
    }
  }

  void _authStateListener(BuildContext context, AuthState state) {
    if (state is Logout) {
      context.router.replace(const AuthScreenRoute());
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }
}

class _ChatBody extends StatelessWidget {
  const _ChatBody({
    required this.scrollController,
    required this.authors,
    required this.isLoading,
    required this.hasApiKey,
    required this.messages,
    this.onSend,
  });

  final ScrollController scrollController;
  final List<User> authors;
  final List<Message> messages;
  final bool isLoading;
  final bool hasApiKey;
  final OnMessageSend? onSend;

  @override
  Widget build(BuildContext context) {
    if (hasApiKey) {
      return const InvalidApiKeyWidget();
    } else if (messages.isEmpty && isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Expanded(
            child: messages.isEmpty
                ? const EmptyChatWidget()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ChatWidget(
                      scrollController: scrollController,
                      messages: messages,
                      authors: authors,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ).copyWith(top: 8),
            child: ChatTextField(
              isLoading: isLoading,
              onSend: onSend,
            ),
          ),
        ],
      ),
    );
  }
}
