import 'package:flutter/material.dart';

class DeleteChatAlertDialog extends StatelessWidget {
  const DeleteChatAlertDialog({
    required this.onConfirmDelete,
    super.key,
  });

  final VoidCallback onConfirmDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure you'd like to delete this chat?"),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text(
            'No',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: onConfirmDelete,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
