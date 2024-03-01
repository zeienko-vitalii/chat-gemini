import 'package:chat_gemini/types/json_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String uid,
    @Default(10) int credits,
  }) = _User;

  const User._();

  factory User.fromJson(JsonType json) => _$UserFromJson(json);
}
