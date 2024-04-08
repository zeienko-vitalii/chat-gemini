import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/chat/views/chat_controls/dialogs/delete_chat_alert_dialog.dart';
import 'package:chat_gemini/chat/views/chat_controls/dialogs/rename_alert_chat_dialog.dart';
import 'package:flutter/material.dart';

typedef ChatControlsActionCallback = void Function(ChatControlsAction);

enum ChatControlsAction {
  rename,
  share(isHidden: true),
  delete;

  const ChatControlsAction({this.isHidden = false});

  final bool isHidden;
}

class ChatControlsWidget extends StatelessWidget {
  const ChatControlsWidget({
    required this.chatTitle,
    required this.onConfirmDelete,
    required this.onConfirmRename,
    required this.onGenerateName,
    super.key,
  });

  final String chatTitle;
  final VoidCallback onConfirmDelete;
  final RenameChatAlertDialogCallback onConfirmRename;
  final GenerateNameChatAlertDialogCallback onGenerateName;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(
        borderRadius: borderRadius16,
        side: BorderSide(
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

  Future<void> _onActionPressedByType(
    BuildContext context,
    ChatControlsAction type,
  ) {
    // onActionSelected(type);
    if (type == ChatControlsAction.delete) {
      return showDialog(
        context: context,
        builder: (context) => DeleteChatAlertDialog(
          onConfirmDelete: onConfirmDelete,
          // onConfirmDelete: () => onActionSelected(type),
        ),
      );
    } else if (type == ChatControlsAction.rename) {
      return showDialog(
        context: context,
        builder: (context) => RenameChatAlertDialog(
          title: chatTitle,
          onConfirmRename: onConfirmRename,
          onGenerateName: onGenerateName,
        ),
      );
    } else if (type == ChatControlsAction.share) {
      throw UnimplementedError('Share action is not implemented');
    } else {
      throw UnimplementedError('Unknown action type');
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
