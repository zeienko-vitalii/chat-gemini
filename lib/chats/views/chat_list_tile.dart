import 'package:chat_gemini/app/utils/ui_utils.dart';
import 'package:chat_gemini/chats/styles/chat_list_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    required this.title,
    super.key,
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
    final contentColor = chatListTileContentColor(
      isSelected: isSelected,
      isLightTheme: isLightTheme(context),
    );

    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: contentColor,
        );
    return Padding(
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
      child: ElevatedButton(
        style: OutlinedElevatedButtonStyle(
          context,
          isSelected: isSelected,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            if (isAddButton) ...[
              Icon(
                Icons.add_rounded,
                color: contentColor,
              ),
              const Gap(10),
            ],
            Text(
              title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
