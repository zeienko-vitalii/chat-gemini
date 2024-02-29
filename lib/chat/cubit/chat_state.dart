part of 'chat_cubit.dart';

sealed class ChatState {
  ChatState({required this.chat});
  final Chat chat;
}

final class ChatInitial extends ChatState {
  ChatInitial({required super.chat});
}

final class ChatUpdated extends ChatState {
  ChatUpdated({required super.chat});
}
