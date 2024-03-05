import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/chat/views/chat_controls/dialogs/delete_chat_alert_dialog.dart';
import 'package:chat_gemini/chat/views/chat_controls/dialogs/rename_alert_chat_dialog.dart';
import 'package:flutter/material.dart';

typedef ChatControlsActionCallback = void Function(ChatControlsAction);

enum ChatControlsAction {
  rename,
  share(true),
  delete;

  final bool isHidden;

  const ChatControlsAction([this.isHidden = false]);
}

class ChatControlsWidget extends StatelessWidget {
  const ChatControlsWidget({
    required this.chatTitle,
    required this.onConfirmDelete,
    required this.onConfirmRename,
    super.key,
  });

  final String chatTitle;
  final VoidCallback onConfirmDelete;
  final RenameChatAlertDialogCallback onConfirmRename;
  // final ChatControlsActionCallback onActionSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius16,
        side: BorderSide(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      color: Theme.of(context).colorScheme.background,
      onSelected: (ChatControlsAction action) => _onActionPressedByType(
        context,
        action,
      ),
      itemBuilder: (context) => ChatControlsAction.values
          .where((el) => !el.isHidden)
          .map(
            (e) => PopupMenuItem<ChatControlsAction>(
              value: e,
              child: Text(
                _titleByChatControlsActionType(e),
                style: _styleByType(context, e),
              ),
            ),
          )
          .toList(),
    );
  }

  void _onActionPressedByType(BuildContext context, ChatControlsAction type) {
    // onActionSelected(type);
    if (type == ChatControlsAction.delete) {
      showDialog(
        context: context,
        builder: (context) => DeleteChatAlertDialog(
          onConfirmDelete: () => onConfirmDelete(),
          // onConfirmDelete: () => onActionSelected(type),
        ),
      );
    } else if (type == ChatControlsAction.rename) {
      showDialog(
        context: context,
        builder: (context) => RenameChatAlertDialog(
          title: chatTitle,
          onConfirmRename: onConfirmRename,
        ),
      );
    } else if (type == ChatControlsAction.share) {
      UnimplementedError('Share action is not implemented');
    }
  }

  String _titleByChatControlsActionType(
    ChatControlsAction type,
  ) =>
      switch (type) {
        ChatControlsAction.rename => 'Rename',
        ChatControlsAction.share => 'Share',
        ChatControlsAction.delete => 'Delete',
      };

  TextStyle _styleByType(BuildContext context, ChatControlsAction type) {
    final isDelete = type == ChatControlsAction.delete;
    final bodyTextColor = Theme.of(context).textTheme.bodyLarge!.color;
    final color = isDelete ? Colors.redAccent : bodyTextColor;
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
    );
  }
}
