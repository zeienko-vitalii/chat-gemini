import 'dart:io';

import 'package:chat_gemini/chat/views/attach_media/attach_media_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef OnMessageSend = void Function(String message);

class ChatTextField extends StatelessWidget {
  ChatTextField({
    required this.isLoading,
    required this.files,
    required this.onRemovePressed,
    required this.onAttachFilePressed,
    super.key,
    this.onSend,
  }) : _controller = TextEditingController();

  final bool isLoading;
  final OnMessageSend? onSend;
  final TextEditingController _controller;

  final List<File> files;
  final OnRemovePressed onRemovePressed;
  final OnAttachFilePressed onAttachFilePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: !isLoading,
            controller: _controller,
            cursorColor: Colors.grey.shade500,
            decoration: InputDecoration(
              hintText: 'Type a message',
              contentPadding: const EdgeInsets.all(12),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color!
                        .withOpacity(0.5),
                  ),
              suffixIcon: isLoading
                  ? const _Loader()
                  : _SendButton(
                      onPressed: () {
                        final text = _controller.text.trim();
                        if (text.isNotEmpty) {
                          onSend?.call(text);
                          _controller.clear();
                        }
                      },
                    ),
            ),
            onSubmitted: (text) {
              if (isLoading) return;

              if (text.trim().isNotEmpty) {
                onSend?.call(text);
                _controller.clear();
              }
            },
          ),
        ),
        if(!kIsWeb) AttachButton(
          files: files,
          onRemovePressed: onRemovePressed,
          onAttachFilePressed: onAttachFilePressed,
        ),
      ],
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.send),
      onPressed: onPressed,
    );
  }
}

class _Loader extends CupertinoActivityIndicator {
  const _Loader();
}
