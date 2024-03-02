part of 'chats_cubit.dart';

sealed class ChatsState {
  ChatsState({
    this.chats = const [],
    this.selectedChatIndex = -1,
  });

  final int selectedChatIndex;
  final List<Chat> chats;
}

final class ChatsLoading extends ChatsState {
  ChatsLoading({
    super.chats = const [],
    super.selectedChatIndex = -1,
  });
}

final class ChatsLoaded extends ChatsState {
  ChatsLoaded({
    super.chats = const [],
    super.selectedChatIndex = -1,
  });
}

final class ChatsError extends ChatsState {
  ChatsError({
    this.message,
    super.chats = const [],
    super.selectedChatIndex = -1,
  });

  final String? message;
}
