import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    @Default('Undefined') String name,
    required String authorId,
    @Default([]) List<String> messages,
    @Default([]) List<Message> sharedWithIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Chat;

  const Chat._();

  factory Chat.fromJson(JsonType json) => _$ChatFromJson(json);
}
