import 'package:flutter/material.dart';

typedef RenameChatAlertDialogCallback = void Function(String newName);

class RenameChatAlertDialog extends StatefulWidget {
  const RenameChatAlertDialog({
    super.key,
    required this.title,
    required this.onConfirmRename,
  });

  final String title;
  final RenameChatAlertDialogCallback onConfirmRename;

  @override
  State<RenameChatAlertDialog> createState() => _RenameChatAlertDialogState();
}

class _RenameChatAlertDialogState extends State<RenameChatAlertDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rename chat'),
      content: TextField(
        controller: _controller,
        cursorColor: Colors.grey.shade500,
        decoration: InputDecoration(
          hintText: widget.title,
          contentPadding: const EdgeInsets.all(12),
          labelStyle: Theme.of(context).textTheme.labelSmall,
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .color!
                    .withOpacity(0.5),
              ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () {
            final text = _controller.text.trim();

            if (text.isEmpty) return;

            widget.onConfirmRename(text);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
