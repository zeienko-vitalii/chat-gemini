// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthScreen]
class AuthScreenRoute extends PageRouteInfo<void> {
  const AuthScreenRoute({List<PageRouteInfo>? children})
      : super(AuthScreenRoute.name, initialChildren: children);

  static const String name = 'AuthScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

/// generated route for
/// [ChatScreen]
class ChatScreenRoute extends PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({
    Key? key,
    Chat chat = const Chat(),
    List<PageRouteInfo>? children,
  }) : super(
          ChatScreenRoute.name,
          args: ChatScreenRouteArgs(key: key, chat: chat),
          initialChildren: children,
        );

  static const String name = 'ChatScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatScreenRouteArgs>(
        orElse: () => const ChatScreenRouteArgs(),
      );
      return ChatScreen(key: args.key, chat: args.chat);
    },
  );
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({this.key, this.chat = const Chat()});

  final Key? key;

  final Chat chat;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, chat: $chat}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatScreenRouteArgs) return false;
    return key == other.key && chat == other.chat;
  }

  @override
  int get hashCode => key.hashCode ^ chat.hashCode;
}

/// generated route for
/// [PrivacyPolicyView]
class Privacy extends PageRouteInfo<void> {
  const Privacy({List<PageRouteInfo>? children})
      : super(Privacy.name, initialChildren: children);

  static const String name = 'Privacy';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PrivacyPolicyView();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileScreenRoute extends PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute({
    Key? key,
    bool toCompleteProfile = false,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileScreenRoute.name,
          args: ProfileScreenRouteArgs(
            key: key,
            toCompleteProfile: toCompleteProfile,
          ),
          rawPathParams: {'complete-profile': toCompleteProfile},
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProfileScreenRouteArgs>(
        orElse: () => ProfileScreenRouteArgs(
          toCompleteProfile: pathParams.getBool('complete-profile', false),
        ),
      );
      return ProfileScreen(
        key: args.key,
        toCompleteProfile: args.toCompleteProfile,
      );
    },
  );
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({this.key, this.toCompleteProfile = false});

  final Key? key;

  final bool toCompleteProfile;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{key: $key, toCompleteProfile: $toCompleteProfile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileScreenRouteArgs) return false;
    return key == other.key && toCompleteProfile == other.toCompleteProfile;
  }

  @override
  int get hashCode => key.hashCode ^ toCompleteProfile.hashCode;
}

/// generated route for
/// [SplashView]
class SplashViewRoute extends PageRouteInfo<void> {
  const SplashViewRoute({List<PageRouteInfo>? children})
      : super(SplashViewRoute.name, initialChildren: children);

  static const String name = 'SplashViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}

/// generated route for
/// [TermsOfUseView]
class Terms extends PageRouteInfo<void> {
  const Terms({List<PageRouteInfo>? children})
      : super(Terms.name, initialChildren: children);

  static const String name = 'Terms';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TermsOfUseView();
    },
  );
}
