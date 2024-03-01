import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnMessageSend = void Function(String message);

class ChatTextField extends StatelessWidget {
  ChatTextField({
    super.key,
    this.onSend,
    required this.isLoading,
  }) : _controller = TextEditingController();

  final bool isLoading;
  final OnMessageSend? onSend;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
