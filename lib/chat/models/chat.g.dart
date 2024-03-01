// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      authorId: json['authorId'] as String? ?? '',
      title: json['title'] as String? ?? 'Untitled',
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sharedWithIds: (json['sharedWithIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'authorId': instance.authorId,
      'title': instance.title,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'sharedWithIds': instance.sharedWithIds,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
