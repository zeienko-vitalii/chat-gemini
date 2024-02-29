import 'package:chat_gemini/chat/views/message/message_widget.dart';

class UserMessage extends MessageWidget {
  const UserMessage({
    super.key,
    super.avatar,
    required super.username,
    required super.message,
  });
}
