import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chats/views/chat_list_tile.dart';
import 'package:chat_gemini/chats/cubit/chats_cubit.dart';
import 'package:chat_gemini/utils/date_time.utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ChatListComponent extends StatefulWidget {
  const ChatListComponent({
    super.key,
    required this.chat,
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
            final isSelected = isFirstChild
                ? false
                : state.chats.indexOf(widget.chat) == chatIndex;

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

            final prevChatUpdatedAt = state.chats[index].updatedAt;
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

    context.router.pop();
    context.router.replace(
      ChatScreenRoute(
        chat: chat ?? const Chat(),
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
      padding: const EdgeInsets.all(18.0).copyWith(
        left: 12,
        bottom: 0,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
          const Gap(12),
          Text(formatDateTime(dateTime)),
          const Gap(12),
          const Expanded(
            flex: 8,
            child: Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
