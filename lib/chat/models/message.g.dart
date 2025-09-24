// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
      text: json['text'] as String,
      authorId: json['authorId'] as String? ?? botAuthorId,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
      'text': instance.text,
      'authorId': instance.authorId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'media': instance.media?.toJson(),
    };
