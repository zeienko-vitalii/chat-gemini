import 'dart:async';

import 'package:chat_gemini/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef RenameChatAlertDialogCallback = void Function(String newName);
typedef GenerateNameChatAlertDialogCallback = Future<String?> Function();

class RenameChatAlertDialog extends StatefulWidget {
  const RenameChatAlertDialog({
    required this.title,
    required this.onConfirmRename,
    required this.onGenerateName,
    super.key,
  });

  final String title;
  final RenameChatAlertDialogCallback onConfirmRename;
  final GenerateNameChatAlertDialogCallback onGenerateName;

  @override
  State<RenameChatAlertDialog> createState() => _RenameChatAlertDialogState();
}

class _RenameChatAlertDialogState extends State<RenameChatAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rename chat'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          cursorColor: Colors.grey.shade500,
          validator: chatNameValidation,
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
          onPressed: () => _onSave(_controller.text),
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () async {
            await widget.onGenerateName().then((value) {
              if (value != null) {
                _controller.text = value;
              }
            });

            _onSave(_controller.text);
          },
          child: Row(
            children: [
              Icon(
                Icons.grain_rounded,
                color: Colors.grey.shade500,
              ),
              const Gap(8),
              const Text('Generate name'),
            ],
          ),
        ),
      ],
    );
  }

  void _onSave(String text) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      widget.onConfirmRename(text);
    }
  }
}
