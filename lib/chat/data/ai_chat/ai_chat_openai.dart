import 'dart:typed_data';

import 'package:chat_gemini/chat/data/ai_chat/ai_chat_interface.dart';
import 'package:chat_gemini/chat/data/exceptions/invalid_api_exception.dart';
import 'package:chat_gemini/chat/data/exceptions/unsupported_location_exception.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/env/env.dart';
import 'package:chat_gemini/utils/image/supported_image_mime_types.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

const _openaiKey = Env.openaiApiKey;

@Named('AiChatOpenAi')
@Singleton(as: AIChatInterface)
class AiChatOpenai implements AIChatInterface {
  factory AiChatOpenai() => instance;

  AiChatOpenai._();

  static final AiChatOpenai instance = AiChatOpenai._();

  final List<OpenAIChatCompletionChoiceMessageModel> _chatHistory = [];

  @override
  void init({List<Message> messages = const []}) {
    OpenAI.apiKey = _openaiKey;
    OpenAI.organization = Env.openaiOrganisationId;
    _chatHistory.addAll(
      [
        for (final message in messages)
          OpenAIChatCompletionChoiceMessageModel(
            role: message.isBot
                ? OpenAIChatMessageRole.system
                : OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                message.text,
              ),
            ],
          ),
      ],
    );
  }

  @override
  Future<String> sendMessage(
    String text, {
    SupportedMimeTypes? mimeType,
    Uint8List? fileBytes,
  }) async {
    try {
      if (_openaiKey.isEmpty) throw InvalidApiException();

      if (mimeType != null && fileBytes != null) {
        return sendImagePrompt(text, mimeType, fileBytes);
      } else {
        return sendSingleTextPromt(text, persist: true);
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
      if (_openaiKey.isEmpty) throw InvalidApiException();

      final openAiMessage = OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            message,
          ),
        ],
      );

      if (persist) {
        _chatHistory.add(openAiMessage);
      }

      final chat = await OpenAI.instance.chat.create(
        model: 'gpt-3.5-turbo-1106',
        seed: 6,
        messages: persist ? _chatHistory : [openAiMessage],
        temperature: 0.2,
        maxTokens: 500,
      );

      final text = chat.choices.first.message.content?.first.text;

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
      throw UnsupportedUserLocation();
    } catch (e, stk) {
      Log().e(e, stk);
      if (e is UnsupportedUserLocation) {
        throw UnsupportedLocationException();
      }
      rethrow;
    }
  }
}
