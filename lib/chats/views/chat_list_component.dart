import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chats/cubit/chats_cubit.dart';
import 'package:chat_gemini/chats/styles/chat_list_styles.dart';
import 'package:chat_gemini/chats/views/chat_list_tile.dart';
import 'package:chat_gemini/utils/date_time.utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChatListComponent extends StatefulWidget {
  const ChatListComponent({
    required this.chat,
    super.key,
  });

  final Chat chat;

  @override
  State<ChatListComponent> createState() => _ChatListComponentState();
}

class _ChatListComponentState extends State<ChatListComponent> {
  ChatsCubit get _chatsCubit => context.read<ChatsCubit>();

  @override
  void initState() {
    super.initState();
    _chatsCubit.loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (context, state) {
        final isLoading = state is ChatsLoading;
        final hasError = state is ChatsError;

        if (isLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (hasError) {
          return const SizedBox();
        }
        return ListView.separated(
          itemCount: state.chats.length + 1,
          itemBuilder: (context, index) {
            final isFirstChild = index == 0;
            final chatIndex = index - 1;

            final isPassedChat = state.chats.indexOf(widget.chat) == chatIndex;
            final isSelected = !isFirstChild && isPassedChat;

            final chat = isFirstChild ? null : state.chats[chatIndex];
            return ChatListTile(
              title: isFirstChild ? 'New chat' : chat!.title,
              isAddButton: isFirstChild,
              isSelected: isSelected,
              onPressed: () => _onPressed(
                context,
                index: chatIndex,
                chat: chat,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            final isFirstChild = index == 0;
            final chatUpdatedAt = state.chats[index].updatedAt;

            if (isFirstChild) {
              return _DateDivider(
                dateTime: chatUpdatedAt ?? DateTime.now(),
              );
            }

            final prevChatUpdatedAt = state.chats[index - 1].updatedAt;

            final isDiffMoreThanOneDay = isDifferenceMoreThanOneDay(
              chatUpdatedAt ?? DateTime.now(),
              prevChatUpdatedAt ?? DateTime.now(),
            );

            if (isDiffMoreThanOneDay) {
              return _DateDivider(
                dateTime: chatUpdatedAt ?? DateTime.now(),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }

  Future<void> _onPressed(
    BuildContext context, {
    int index = 0,
    Chat? chat,
  }) async {
    context.read<ChatsCubit>().updateSelectedChatIndex(index);

    unawaited(context.router.pop());
    unawaited(
      context.router.replace(
        ChatScreenRoute(
          chat: chat ?? const Chat(),
        ),
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  const _DateDivider({
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18).copyWith(
        left: 12,
        bottom: 0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              height: 1,
              color: chatListTileContentColor(context),
            ),
          ),
          const Gap(12),
          Text(
            formatDateTime(dateTime),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: chatListTileContentColor(context),
                ),
          ),
          const Gap(12),
          Expanded(
            flex: 8,
            child: Divider(
              height: 1,
              color: chatListTileContentColor(context),
            ),
          ),
        ],
      ),
    );
  }
}
