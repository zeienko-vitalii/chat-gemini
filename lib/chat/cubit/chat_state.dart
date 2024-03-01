part of 'chat_cubit.dart';

sealed class ChatState {
  ChatState({required this.chat});
  final Chat chat;
}

final class ChatLoading extends ChatState {
  ChatLoading({required super.chat});
}

final class ChatUpdated extends ChatState {
  ChatUpdated({required super.chat});
}

final class ChatError extends ChatState {
  ChatError({
    required super.chat,
    this.message,
  });

  final String? message;
}
