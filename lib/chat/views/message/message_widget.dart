import 'package:chat_gemini/chat/models/message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.username,
    this.avatar,
  });

  final Message message;
  final String? avatar;
  final String username;

  String get _message => message.text;

  bool get hasAvatar => avatar != null;
  bool get assetAvatar => avatar != null && avatar!.startsWith('assets');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,

            // issue: https://github.com/flutter/flutter/issues/77782
            backgroundImage: assetAvatar
                ? ExactAssetImage(avatar!) as ImageProvider
                : NetworkImage(avatar!),
            child: hasAvatar
                ? const SizedBox()
                : Text(
                    _shortUsername(avatar, username),
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  username,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.15,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(_message),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _shortUsername(String? avatar, String username) {
    if (avatar == null && username.length > 2) {
      return username.substring(0, 2).toUpperCase();
    }
    return username.toUpperCase();
  }
}
