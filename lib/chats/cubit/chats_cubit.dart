import 'package:bloc/bloc.dart';
import 'package:chat_gemini/auth/data/auth_service.dart';
import 'package:chat_gemini/chat/data/repository/chat_repository.dart';
import 'package:chat_gemini/chat/models/chat.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsLoading());

  final _chatRepository = ChatRepository();
  final _authService = AuthService();

  void updateSelectedChatIndex(int index) {
    emit(
      ChatsLoaded(
        chats: state.chats,
        selectedChatIndex: index,
      ),
    );
  }

  Future<void> loadChats() async {
    try {
      emit(
        ChatsLoading(
          chats: state.chats,
          selectedChatIndex: state.selectedChatIndex,
        ),
      );
      if (_authService.currentUser?.uid case final id?) {
        final chats = await _chatRepository.getChatsByUserId(id);
        final chartsSortedByUpdatedAt = chats
          ..sort(
            (a, b) => sortByUpdatedAt(a.updatedAt, b.updatedAt),
          );
        emit(
          ChatsLoaded(
            chats: chartsSortedByUpdatedAt,
            selectedChatIndex: state.selectedChatIndex,
          ),
        );
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      emit(
        ChatsError(
          message: '$e',
          chats: state.chats,
          selectedChatIndex: state.selectedChatIndex,
        ),
      );
    }
  }
}

int sortByUpdatedAt(DateTime? a, DateTime? b) {
  if (a == null || b == null) return 0;
  return b.compareTo(a);
}
