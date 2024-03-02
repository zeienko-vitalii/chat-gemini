import 'package:chat_gemini/chats/styles/chat_list_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.title,
    this.isSelected = false,
    this.isAddButton = false,
    this.onPressed,
  });

  final String title;
  final bool isSelected;
  final bool isAddButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
      child: ElevatedButton(
        style: chatListButtonStyle(context, isSelected),
        onPressed: onPressed,
        child: Row(
          children: [
            if (isAddButton) ...[
              Icon(
                Icons.add_rounded,
                color: chatListTileContentColor(
                  context,
                  isSelected,
                ),
              ),
              const Gap(10),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: chatListTileContentColor(context, isSelected),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
