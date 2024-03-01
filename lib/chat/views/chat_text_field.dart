import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key, this.onSend});

  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey.shade500,
      decoration: InputDecoration(
        hintText: 'Type a message',
        contentPadding: const EdgeInsets.all(12),
        labelStyle: Theme.of(context).textTheme.labelSmall,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {},
        ),
      ),
    );
  }
}
