import 'package:chat_gemini/chat/views/message/message_widget.dart';

class AiMessage extends MessageWidget {
  const AiMessage({
    super.key,
    required super.avatar,
    super.username = 'Gemini AI',
    required super.message,
  });
}
