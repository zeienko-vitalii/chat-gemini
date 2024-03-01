// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String?,
      credits: json['credits'] as int? ?? 10,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'credits': instance.credits,
    };
