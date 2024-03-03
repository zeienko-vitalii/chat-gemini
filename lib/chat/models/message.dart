import 'package:chat_gemini/chat/models/media.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

const String botAuthorId = 'ai-bot';

@freezed
class Message with _$Message {
  const factory Message({
    required String text,
    @Default(botAuthorId) String authorId,
    DateTime? createdAt,
    Media? media,
  }) = _Message;

  const Message._();

  factory Message.fromJson(JsonType json) => _$MessageFromJson(json);

  bool get isBot => authorId == botAuthorId;

  bool get hasMedia => media != null;
}
