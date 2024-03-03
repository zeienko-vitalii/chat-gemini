import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/chat/data/ai_chat_service.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/data/repository/media_storage_repository.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/media.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/utils/logger.dart';

part 'chat_state.dart';

bool isGeminiApiKeyEmpty = geminiApiKey.isEmpty;

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatLoading(
            chat: const Chat(),
            author: const User(
              uid: '',
              name: '',
              email: '',
            ),
          ),
        );

  final _repository = ChatRepository();
  final _authService = AuthService();
  final _userRepository = UserRepository();
  final _mediaStorageRepository = MediaStorageRepository();
  final _aiChatService = AiChatService();

  Future<void> loadChat(Chat chat) async {
    try {
      emit(
        ChatLoading(
          chat: chat,
          author: state.author,
          guests: state.guests,
        ),
      );

      _aiChatService.init(messages: chat.messages);

      final currentUserId = _authService.currentUser?.uid;
      if (chat.isNewChat) {
        final (author, _) = await loadAuthors(currentUserId);
        emit(
          ChatUpdated(
            chat: chat,
            author: author,
            guests: [],
          ),
        );
      } else {
        final (author, guests) = await loadAuthors(
          currentUserId,
          chat.sharedWithIds,
        );
        emit(
          ChatUpdated(
            chat: chat,
            author: author,
            guests: guests,
          ),
        );
      }
    } catch (e, stk) {
      Log().e(e, stk);
      emit(
        ChatError(
          chat: chat,
          message: '$e',
          author: state.author,
          guests: state.guests,
        ),
      );
    }
  }

  Future<(User, List<User>)> loadAuthors(
    String? currentUserId, [
    List<String> sharedWithIds = const [],
  ]) async {
    if (currentUserId == null) {
      throw Exception('User not found');
    }

    final author = await _userRepository.getUser(currentUserId);
    final guests = await Future.wait(
      sharedWithIds.map(_userRepository.getUser),
    );

    return (author, guests);
  }

  Future<void> sendTextMessage(
    String text, {
    String? mimeType,
    String? filePath,
  }) async {
    try {
      if (_authService.currentUser?.uid case final id?) {
        final isFilePathEmpty = filePath == null || filePath.isEmpty;
        final isMimeTypeEmpty = mimeType == null || mimeType.isEmpty;
        final message = Message(
          text: text,
          authorId: id,
          createdAt: DateTime.now(),
          media: isFilePathEmpty || isMimeTypeEmpty
              ? null
              : Media(
                  url: filePath,
                  mimeType: mimeType,
                ),
        );
        await sendMessage(message);

        // await askBotTextMessage(text);
      }
    } catch (e) {
      emit(
        ChatError(
          chat: state.chat,
          message: '$e',
          author: state.author,
          guests: state.guests,
        ),
      );
    }
  }

  Future<void> askBotTextMessage(String text) async {
    try {
      emit(
        ChatLoading(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
        ),
      );
      final result = await _aiChatService.sendChatMessage(text);
      final updatedChat = await _repository.updateChat(
        state.chat.copyWith(
          messages: [
            ...state.chat.messages,
            Message(
              text: result,
              createdAt: DateTime.now(),
            ),
          ],
          updatedAt: DateTime.now(),
        ),
      );

      emit(
        ChatUpdated(
          chat: updatedChat,
          author: state.author,
          guests: state.guests,
        ),
      );
    } catch (e) {
      emit(
        ChatError(
          chat: state.chat,
          message: '$e',
          author: state.author,
          guests: state.guests,
        ),
      );
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      emit(
        ChatLoading(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
        ),
      );

      final chat = state.chat;
      final chatId = chat.id;

      Chat updatedChat;
      if (chatId.isEmpty) {
        final userId = _authService.currentUser?.uid;
        final chat = Chat(
          authorId: userId ?? '',
          title: 'Untitled',
          messages: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        updatedChat = await _repository.addChat(chat);
        updatedChat = await _uploadMediaAndUpdateChat(
          chat: updatedChat,
          userId: userId ?? '',
          message: message,
        );
      } else {
        updatedChat = await _uploadMediaAndUpdateChat(
          chat: chat,
          userId: message.authorId,
          message: message,
        );
      }

      emit(
        ChatUpdated(
          chat: updatedChat,
          author: state.author,
          guests: state.guests,
        ),
      );
    } catch (e) {
      emit(
        ChatError(
          chat: state.chat,
          message: '$e',
          author: state.author,
          guests: state.guests,
        ),
      );
    }
  }

  Future<Chat> _uploadMediaAndUpdateChat({
    required Chat chat,
    required String userId,
    required Message message,
  }) async {
    if (userId.isEmpty) throw Exception('User not found');

    final isMediaEmpty = message.media == null;
    final mediaUrl = await _uploadMedia(
      chat.id,
      isMediaEmpty ? '' : message.media!.url,
    );
    final isMediaUrlEmpty = mediaUrl == null || mediaUrl.isEmpty;
    final mediaToSave = isMediaUrlEmpty
        ? null
        : message.media!.copyWith(
            url: mediaUrl,
          );
    final messageToSave = message.copyWith(media: mediaToSave);
    return _repository.updateChat(
      chat.copyWith(
        messages: [
          ...chat.messages,
          messageToSave,
        ],
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<String?> _uploadMedia(String chatId, String filePath) async {
    if (chatId.isEmpty || filePath.isEmpty) return null;

    return _mediaStorageRepository.uploadFile(
      chatId,
      filePath,
    );
  }

  Future<void> deleteChat() async {
    try {
      emit(
        ChatLoading(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
        ),
      );

      await _mediaStorageRepository.deleteChatFiles(state.chat.id);
      await _repository.deleteChat(state.chat.id);

      // start new chat
      await loadChat(const Chat());
    } catch (e) {
      Log().e(e);
      emit(
        ChatError(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
          message: '$e',
        ),
      );
    }
  }

  Future<void> renameChat(String title) async {
    try {
      emit(
        ChatLoading(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
        ),
      );

      final chat = await _repository.updateChat(
        state.chat.copyWith(
          title: title,
          updatedAt: DateTime.now(),
        ),
      );

      emit(
        ChatUpdated(
          chat: chat,
          author: state.author,
          guests: state.guests,
        ),
      );
    } catch (e) {
      Log().e(e);
      emit(
        ChatError(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
          message: '$e',
        ),
      );
    }
  }
}
