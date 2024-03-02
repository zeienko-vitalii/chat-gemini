import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const _supportedModels = ['gemini-pro', 'gemini-pro-vision'];
const geminiApiKey = String.fromEnvironment('GEMENI_API_KEY');

enum _ContentSupportedRoles { user, model }

class AiChatService {
  factory AiChatService() => instance;
  AiChatService._();

  static final AiChatService instance = AiChatService._();

  final GenerativeModel _model = GenerativeModel(
    model: _supportedModels[0],
    apiKey: geminiApiKey,
  );
  // ignore: unused_field
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

  Future<String> sendChatMessage(String message) async {
    try {
      if (_chat == null) {
        throw Exception('Chat not initialized. Run init() first.');
      }
      if (geminiApiKey.isEmpty) throw Exception('API key is empty');

      final response = await _chat!.sendMessage(
        Content.text(message),
      );
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

  Future<void> _sendImagePrompt(String message) async {
    // setState(() {
    //   _loading = true;
    // });
    // try {
    //   ByteData catBytes = await rootBundle.load('assets/images/cat.jpg');
    //   ByteData sconeBytes = await rootBundle.load('assets/images/scones.jpg');
    //   final content = [
    //     Content.multi([
    //       TextPart(message),
    //       // The only accepted mime types are image/*.
    //       DataPart('image/jpeg', catBytes.buffer.asUint8List()),
    //       DataPart('image/jpeg', sconeBytes.buffer.asUint8List()),
    //     ])
    //   ];
    //   _generatedContent.add((
    //     image: Image.asset("assets/images/cat.jpg"),
    //     text: message,
    //     fromUser: true
    //   ));
    //   _generatedContent.add((
    //     image: Image.asset("assets/images/scones.jpg"),
    //     text: null,
    //     fromUser: true
    //   ));

    //   var response = await _visionModel.generateContent(content);
    //   var text = response.text;
    //   _generatedContent.add((image: null, text: text, fromUser: false));

    //   if (text == null) {
    //     _showError('No response from API.');
    //     return;
    //   } else {
    //     setState(() {
    //       _loading = false;
    //       _scrollDown();
    //     });
    //   }
    // } catch (e) {
    //   _showError(e.toString());
    //   setState(() {
    //     _loading = false;
    //   });
    // } finally {
    //   _textController.clear();
    //   setState(() {
    //     _loading = false;
    //   });
    //   _textFieldFocus.requestFocus();
    // }
  }
}
