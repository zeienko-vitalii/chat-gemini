import 'dart:typed_data';

import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/utils/image/supported_image_mime_types.dart';

abstract interface class AIChatInterface {
  void init({List<Message> messages = const []});
  Future<String> sendSingleTextPromt(String message, {bool persist = false});
  Future<String> sendMessage(
    String text, {
    SupportedMimeTypes? mimeType,
    Uint8List? fileBytes,
  });
}
