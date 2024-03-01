import 'package:bloc/bloc.dart';
import 'package:chat_gemini/chat/models/chat.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatInitial(
            chat: const Chat(
              authorId: '',
            ),
          ),
        );

  void sendMessage(String message) {
    // emit(ChatMessage(message));
  }
}
