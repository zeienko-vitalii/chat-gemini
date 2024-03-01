import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/utils/logger.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatLoading(
            chat: const Chat(
              id: '',
              authorId: '',
            ),
          ),
        );

  final _repository = ChatRepository();
  final _authService = AuthService();

  Future<void> loadChat() async {
    try {
      emit(ChatLoading(chat: state.chat));
      if (_authService.currentUser?.uid case final id?) {
        final chat = await _repository.getChatByUserId(id);
        emit(ChatUpdated(chat: chat));
      } else {
        throw Exception('User not found');
      }
    } catch (e, stk) {
      Log().e(e, stk);
      emit(
        ChatError(chat: state.chat, message: '$e'),
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
        sendMessage(message);
      }
    } catch (e) {
      emit(
        ChatError(chat: state.chat, message: '$e'),
      );
    }
  }

  Future<void> sendMessage(Message message) async {
    try {
      emit(ChatLoading(chat: state.chat));
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

      emit(ChatUpdated(chat: updatedChat));
    } catch (e) {
      emit(
        ChatError(chat: state.chat, message: '$e'),
      );
    }
  }
}
