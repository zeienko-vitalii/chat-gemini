import 'package:chat_gemini/chat/models/media.dart';
import 'package:chat_gemini/types/json_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String text,
    required String authorId,
    DateTime? createdAt,
    Media? media,
  }) = _Message;

  const Message._();

  factory Message.fromJson(JsonType json) => _$MessageFromJson(json);
}
