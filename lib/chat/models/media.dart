import 'package:chat_gemini/types/json_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  const factory Media({
    required String url,
    required String mimeType,
  }) = _Media;

  const Media._();

  factory Media.fromJson(JsonType json) => _$MediaFromJson(json);
}
