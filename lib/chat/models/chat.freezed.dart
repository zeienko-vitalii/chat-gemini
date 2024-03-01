// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
mixin _$Chat {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get id => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  List<String> get sharedWithIds => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res, Chat>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String id,
      String authorId,
      String title,
      List<Message> messages,
      List<String> sharedWithIds,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res, $Val extends Chat>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? title = null,
    Object? messages = null,
    Object? sharedWithIds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      sharedWithIds: null == sharedWithIds
          ? _value.sharedWithIds
          : sharedWithIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatImplCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$$ChatImplCopyWith(
          _$ChatImpl value, $Res Function(_$ChatImpl) then) =
      __$$ChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false) String id,
      String authorId,
      String title,
      List<Message> messages,
      List<String> sharedWithIds,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ChatImplCopyWithImpl<$Res>
    extends _$ChatCopyWithImpl<$Res, _$ChatImpl>
    implements _$$ChatImplCopyWith<$Res> {
  __$$ChatImplCopyWithImpl(_$ChatImpl _value, $Res Function(_$ChatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? title = null,
    Object? messages = null,
    Object? sharedWithIds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChatImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      sharedWithIds: null == sharedWithIds
          ? _value._sharedWithIds
          : sharedWithIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatImpl extends _Chat {
  const _$ChatImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false) this.id = '',
      this.authorId = '',
      this.title = 'Untitled',
      final List<Message> messages = const [],
      final List<String> sharedWithIds = const [],
      this.createdAt,
      this.updatedAt})
      : _messages = messages,
        _sharedWithIds = sharedWithIds,
        super._();

  factory _$ChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatImplFromJson(json);

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String id;
  @override
  @JsonKey()
  final String authorId;
  @override
  @JsonKey()
  final String title;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final List<String> _sharedWithIds;
  @override
  @JsonKey()
  List<String> get sharedWithIds {
    if (_sharedWithIds is EqualUnmodifiableListView) return _sharedWithIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sharedWithIds);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Chat(id: $id, authorId: $authorId, title: $title, messages: $messages, sharedWithIds: $sharedWithIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality()
                .equals(other._sharedWithIds, _sharedWithIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      title,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_sharedWithIds),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      __$$ChatImplCopyWithImpl<_$ChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatImplToJson(
      this,
    );
  }
}

abstract class _Chat extends Chat {
  const factory _Chat(
      {@JsonKey(includeFromJson: false, includeToJson: false) final String id,
      final String authorId,
      final String title,
      final List<Message> messages,
      final List<String> sharedWithIds,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ChatImpl;
  const _Chat._() : super._();

  factory _Chat.fromJson(Map<String, dynamic> json) = _$ChatImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get id;
  @override
  String get authorId;
  @override
  String get title;
  @override
  List<Message> get messages;
  @override
  List<String> get sharedWithIds;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ChatImplCopyWith<_$ChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
