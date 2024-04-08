import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/domain/models/user.dart';
import 'package:chat_gemini/chat/cubit/chat_cubit.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/chat/views/attach_media/attach_media_button.dart';
import 'package:chat_gemini/chat/views/chat_controls/chat_controls_widget.dart';
import 'package:chat_gemini/chat/views/chat_controls/dialogs/rename_alert_chat_dialog.dart';
import 'package:chat_gemini/chat/views/chat_text_field.dart';
import 'package:chat_gemini/chat/views/chat_widget.dart';
import 'package:chat_gemini/chat/views/placeholders/empty_chat_widget.dart';
import 'package:chat_gemini/chat/views/placeholders/invalid_api_key_widget.dart';
import 'package:chat_gemini/chat/views/placeholders/unsupported_location_widget.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:chat_gemini/utils/image/get_file_extension.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:chat_gemini/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({required this.chat, super.key});

  final Chat chat;

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final ScrollController _scrollController = ScrollController();

  (String mimeType, String filePath)? _imageFile;

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

    var currentChat = oldWidget.chat;
    if (context.mounted) {
      currentChat = context.read<ChatCubit>().state.chat;
    }
    if (widget.chat != currentChat) {
      _chatCubit.loadChat(widget.chat);
    }
    // if (oldWidget.chat != currentChat) {
    //   _chatCubit.loadChat(widget.chat);
    // }
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

          final isUnsupportedLocation =
              state is ChatError && state.isUnsupportedLocation;

          return Scaffold(
            appBar: CustomAppBar(
              context,
              title: _getAppBarTitle(
                title: chat.title,
                isNewChat: chat.isNewChat,
              ),
              action: _getChatControls(
                isNewChat: chat.isNewChat,
                chatTitle: chat.title,
                onConfirmDelete: _confirmDelete,
                onConfirmRename: _confirmRename,
                onGenerateName: _generateRename,
              ),
            ),
            drawer: CustomDrawer(chat: chat),
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
                  hasApiKey: isGeminiApiKeyEmpty,
                  isUnsupportedLocation: isUnsupportedLocation,
                  onSend: (String text) {
                    _chatCubit.sendTextMessage(
                      text,
                      mimeType: _imageFile?.$1,
                      filePath: _imageFile?.$2,
                    );

                    if (_imageFile == null) return;
                    _removeFile(File(_imageFile!.$2));
                  },
                  files: [
                    if (_imageFile != null) File(_imageFile!.$2),
                  ],
                  onRemovePressed: _removeFile,
                  onAttachFilePressed: _selectFile,
                  onReload: () {
                    _chatCubit.loadChat(widget.chat);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // TODO(V): implement deleting specific file, when multiple files are attached
  void _removeFile(File _) {
    Log().d('Removing file');
    _imageFile = null;
    setState(() {});
  }

  void _selectFile(String fileUrl) {
    final mimeType = imageMimeTypeByFilePath(fileUrl);
    Log().d('Add file: $fileUrl, mimeType: $mimeType');
    _imageFile = (mimeType, fileUrl);
    setState(() {});
  }

  Widget? _getChatControls({
    required bool isNewChat,
    required String chatTitle,
    required VoidCallback onConfirmDelete,
    required RenameChatAlertDialogCallback onConfirmRename,
    required GenerateNameChatAlertDialogCallback onGenerateName,
  }) {
    if (isNewChat) return null;

    return ChatControlsWidget(
      chatTitle: chatTitle,
      onConfirmDelete: () {
        onConfirmDelete();
        context.router.pop();
      },
      onConfirmRename: (newName) {
        onConfirmRename(newName);
        context.router.pop();
      },
      onGenerateName: onGenerateName,
    );
  }

  void _confirmDelete() {
    _chatCubit.deleteChat();
    context.router.pop();
  }

  void _confirmRename(String newName) {
    _chatCubit.renameChat(newName);
    context.router.pop();
  }

  Future<String?> _generateRename() {
    return _chatCubit.generateChatNameByFirstMessage();
  }

  String _getAppBarTitle({
    required String title,
    required bool isNewChat,
  }) {
    return isNewChat ? 'New chat' : title;
  }

  void _chatStateListener(BuildContext context, ChatState state) {
    if (state is ChatUpdated && state.chat.messages.isNotEmpty) {
      _scrollDown();
    } else if (state is ChatError) {
      showSnackbarMessage(context, message: state.message);
    }
  }

  void _authStateListener(BuildContext context, AuthState state) {
    if (state is LogOut) {
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
    required this.isUnsupportedLocation,
    required this.messages,
    required this.files,
    required this.onRemovePressed,
    required this.onAttachFilePressed,
    this.onSend,
    this.onReload,
  });

  final ScrollController scrollController;
  final List<User> authors;
  final List<Message> messages;
  final bool isLoading;
  final bool hasApiKey;
  final bool isUnsupportedLocation;
  final OnMessageSend? onSend;
  final VoidCallback? onReload;
  final List<File> files;
  final OnRemovePressed onRemovePressed;
  final OnAttachFilePressed onAttachFilePressed;

  @override
  Widget build(BuildContext context) {
    if (hasApiKey) {
      return const InvalidApiKeyWidget();
    } else if (isUnsupportedLocation) {
      return UnsupportedLocationWidget(onReload: onReload);
    } else if (messages.isEmpty && isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    final isAndroid = kIsWeb || Platform.isAndroid;
    final bottomPadding = isAndroid ? 16.0 : 0.0;
    return ColoredBox(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          if (messages.isEmpty)
            EmptyChatWidget(onSend: onSend)
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChatWidget(
                scrollController: scrollController,
                messages: messages,
                authors: authors,
              ),
            ),
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ).copyWith(top: 8, bottom: bottomPadding),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 60,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: const ColoredBox(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ).copyWith(top: 8, bottom: bottomPadding),
                  child: ChatTextField(
                    isLoading: isLoading,
                    onSend: onSend,
                    files: files,
                    onRemovePressed: onRemovePressed,
                    onAttachFilePressed: onAttachFilePressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
