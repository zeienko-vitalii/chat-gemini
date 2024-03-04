// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>(
          orElse: () => const ChatScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatScreen(
          key: args.key,
          chat: args.chat,
        ),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileScreenRouteArgs>(
          orElse: () => ProfileScreenRouteArgs(
                  toCompleteProfile: pathParams.getBool(
                'complete-profile',
                false,
              )));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileScreen(
          key: args.key,
          toCompleteProfile: args.toCompleteProfile,
        ),
      );
    },
    SplashViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
  };
}

/// generated route for
/// [AuthScreen]
class AuthScreenRoute extends PageRouteInfo<void> {
  const AuthScreenRoute({List<PageRouteInfo>? children})
      : super(
          AuthScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
          args: ChatScreenRouteArgs(
            key: key,
            chat: chat,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatScreenRoute';

  static const PageInfo<ChatScreenRouteArgs> page =
      PageInfo<ChatScreenRouteArgs>(name);
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({
    this.key,
    this.chat = const Chat(),
  });

  final Key? key;

  final Chat chat;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, chat: $chat}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute({List<PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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

  static const PageInfo<ProfileScreenRouteArgs> page =
      PageInfo<ProfileScreenRouteArgs>(name);
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({
    this.key,
    this.toCompleteProfile = false,
  });

  final Key? key;

  final bool toCompleteProfile;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{key: $key, toCompleteProfile: $toCompleteProfile}';
  }
}

/// generated route for
/// [SplashView]
class SplashViewRoute extends PageRouteInfo<void> {
  const SplashViewRoute({List<PageRouteInfo>? children})
      : super(
          SplashViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
