import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/guards/user_authenticated_guard.dart';
import 'package:chat_gemini/auth/auth_screen.dart';
import 'package:chat_gemini/chat/chat_screen.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/privacy_policy/privacy_policy_view.dart';
import 'package:chat_gemini/profile/profile_screen.dart';
import 'package:chat_gemini/splash/splash_view.dart';
import 'package:chat_gemini/terms_of_use/terms_of_use_view.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page, Screen, Route, View')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashViewRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: AuthScreenRoute.page,
        ),
        AutoRoute(
          path: '/privacy-policy',
          page: Privacy.page,
        ),
        AutoRoute(
          path: '/terms-of-use',
          page: Terms.page,
        ),
        AutoRoute(
          page: ChatScreenRoute.page,
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: ProfileScreenRoute.page,
          guards: [AuthGuard()],
        ),
      ];
}
