part of 'chat_cubit.dart';

sealed class ChatState {
  const ChatState({
    required this.chat,
    required this.author,
    this.guests = const [],
  });
  final Chat chat;
  final User author;
  final List<User> guests;
}

final class ChatLoading extends ChatState {
  ChatLoading({
    required super.chat,
    required super.author,
    super.guests = const [],
  });
}

final class ChatUpdated extends ChatState {
  ChatUpdated({
    required super.chat,
    required super.author,
    super.guests = const [],
  });
}

final class ChatError extends ChatState {
  ChatError({
    required super.chat,
    required super.author,
    super.guests = const [],
    this.message,
    this.isUnsupportedLocation = false,
  });

  final String? message;
  final bool isUnsupportedLocation;
}
