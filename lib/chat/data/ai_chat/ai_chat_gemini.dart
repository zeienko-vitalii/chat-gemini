import 'dart:typed_data';

import 'package:chat_gemini/chat/data/ai_chat/ai_chat_interface.dart';
import 'package:chat_gemini/chat/data/exceptions/invalid_api_exception.dart';
import 'package:chat_gemini/chat/data/exceptions/unsupported_location_exception.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/env/env.dart';
import 'package:chat_gemini/utils/image/supported_image_mime_types.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

const _supportedModels = ['gemini-pro', 'gemini-pro-vision'];
const geminiApiKey = Env.geminiApiKey;

enum _ContentSupportedRoles { user, model }

@Named('AiChatGemini')
@Singleton(as: AIChatInterface)
class AiChatService implements AIChatInterface {
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

  @override
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

  @override
  Future<String> sendMessage(
    String text, {
    SupportedMimeTypes? mimeType,
    Uint8List? fileBytes,
  }) async {
    try {
      if (_chat == null) {
        throw Exception('Chat not initialized. Run init() first.');
      }
      if (geminiApiKey.isEmpty) throw InvalidApiException();

      if (mimeType != null && fileBytes != null) {
        return sendImagePrompt(text, mimeType, fileBytes);
      } else {
        return sendSingleTextPromt(text);
      }
    } on UnsupportedUserLocation catch (_) {
      throw UnsupportedLocationException();
    } catch (e, stk) {
      Log().e(e, stk);
      if (e is UnsupportedUserLocation) {
        throw UnsupportedLocationException();
      }
      rethrow;
    }
  }

  @override
  Future<String> sendSingleTextPromt(
    String message, {
    bool persist = false,
  }) async {
    try {
      if (_chat == null) {
        throw Exception('Chat not initialized. Run init() first.');
      }
      if (geminiApiKey.isEmpty) throw InvalidApiException();

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
      if (e is UnsupportedUserLocation) {
        throw UnsupportedLocationException();
      }
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
      if (geminiApiKey.isEmpty) throw InvalidApiException();

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
      if (e is UnsupportedUserLocation) {
        throw UnsupportedLocationException();
      }
      rethrow;
    }
  }
}
