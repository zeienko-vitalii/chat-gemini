import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key, this.onSend});

  final VoidCallback? onSend;

  // static const _borderRadius = BorderRadius.all(Radius.circular(32));
  // static const _border = OutlineInputBorder(
  //   borderRadius: _borderRadius,
  //   borderSide: BorderSide(color: Colors.grey),
  // );

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.grey.shade500,
      decoration: InputDecoration(
        hintText: 'Type a message',
        contentPadding: const EdgeInsets.all(12),
        // focusedBorder: _border,
        // disabledBorder: _border,
        // border: _border,
        // errorBorder: _border,
        // enabledBorder: _border,
        // focusedErrorBorder: _border,
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {},
        ),
      ),
    );
  }
}
