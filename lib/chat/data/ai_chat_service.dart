import 'dart:typed_data';

import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/utils/image/supported_image_mime_types.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const _supportedModels = ['gemini-pro', 'gemini-pro-vision'];
const geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');

enum _ContentSupportedRoles { user, model }

class AiChatService {
  factory AiChatService() => instance;
  AiChatService._();

  static final AiChatService instance = AiChatService._();

  final GenerativeModel _model = GenerativeModel(
    model: _supportedModels[0],
    apiKey: geminiApiKey,
  );
  final GenerativeModel _visionModel = GenerativeModel(
    model: _supportedModels[1],
    apiKey: geminiApiKey,
  );

  ChatSession? _chat;

  void init({List<Message> messages = const []}) {
    _chat = _model.startChat(
      history: messages
          .map(
            (Message e) => Content(
              e.isBot
                  ? _ContentSupportedRoles.model.name
                  : _ContentSupportedRoles.user.name,
              [
                TextPart(e.text),
                // TODO(V): Include bytes into media type
                // e.media != null
                //     ? DataPart(e.media!.mimeType, e.media!.bytes)
                //     : TextPart(''),
              ],
            ),
          )
          .toList(),
    );
  }

  Future<String> sendMessage(
    String text, {
    SupportedMimeTypes? mimeType,
    Uint8List? fileBytes,
  }) async {
    if (_chat == null) {
      throw Exception('Chat not initialized. Run init() first.');
    }
    if (geminiApiKey.isEmpty) throw Exception('API key is empty');

    if (mimeType != null && fileBytes != null) {
      return sendImagePrompt(text, mimeType, fileBytes);
    } else {
      return sendSingleTextPromt(text);
    }
  }

  Future<String> sendSingleTextPromt(String message) async {
    try {
      if (_chat == null) {
        throw Exception('Chat not initialized. Run init() first.');
      }
      if (geminiApiKey.isEmpty) throw Exception('API key is empty');

      final response = await _chat!.sendMessage(
        Content.text(message),
      );
      Log().d('Text response: $response');
      final text = response.text;

      if (text == null) {
        throw Exception('No response from API.');
      }
      return text;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }

  Future<String> sendImagePrompt(
    String message,
    SupportedMimeTypes mimeType,
    Uint8List fileBytes,
  ) async {
    try {
      if (_chat == null) {
        throw Exception('Chat not initialized. Run init() first.');
      }
      if (geminiApiKey.isEmpty) throw Exception('API key is empty');

      final content = [
        Content.multi([
          TextPart(message),
          // The only accepted mime types are image/*.
          DataPart(mimeType.name, fileBytes),
        ]),
      ];

      final response = await _visionModel.generateContent(content);
      final text = response.text;
      // final image = response.candidates.first.content;
      Log().d('Image response: $response');

      if (text == null) {
        throw Exception('No response from API.');
      }
      return text;
    } catch (e, stk) {
      Log().e(e, stk);
      rethrow;
    }
  }
}
