import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/auth/data/repository/user_repository.dart';
import 'package:chat_gemini/auth/models/user.dart';
import 'package:chat_gemini/chat/data/ai_chat_service.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/utils/logger.dart';

part 'chat_state.dart';

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
  final _aiChatService = AiChatService();

  Future<void> loadChat() async {
    try {
      emit(
        ChatLoading(
          chat: state.chat,
          author: state.author,
          guests: state.guests,
        ),
      );
      if (_authService.currentUser?.uid case final id?) {
        final chat = await _repository.getChatByUserId(id);

        final author = await _userRepository.getUser(id);

        final guests = await Future.wait(
          chat.sharedWithIds.map(_userRepository.getUser),
        );

        _aiChatService.init(messages: chat.messages);
        emit(
          ChatUpdated(
            chat: chat,
            author: author,
            guests: guests,
          ),
        );
      } else {
        throw Exception('User not found');
      }
    } catch (e, stk) {
      Log().e(e, stk);
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

  Future<void> sendTextMessage(String text) async {
    try {
      if (_authService.currentUser?.uid case final id?) {
        final message = Message(
          text: text,
          authorId: id,
          createdAt: DateTime.now(),
        );
        await sendMessage(message);

        await askBotTextMessage(text);
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

      late final Chat updatedChat;
      if (chatId.isEmpty) {
        final userId = _authService.currentUser?.uid;
        final chat = Chat(
          authorId: userId ?? '',
          title: 'Untitled',
          messages: [message],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        updatedChat = await _repository.addChat(chat);
      } else {
        updatedChat = await _repository.updateChat(
          chat.copyWith(
            messages: [...chat.messages, message],
            updatedAt: DateTime.now(),
          ),
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
}
