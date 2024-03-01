import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    @Default('')
    // ignore: invalid_annotation_target
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    String id,
    @Default('') String authorId,
    @Default('Untitled') String title,
    @Default([]) List<Message> messages,
    @Default([]) List<String> sharedWithIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Chat;

  const Chat._();

  factory Chat.fromJson(JsonType json) => _$ChatFromJson(json);
}
