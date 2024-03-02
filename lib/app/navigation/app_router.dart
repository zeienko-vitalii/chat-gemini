import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/auth/auth_screen.dart';
import 'package:chat_gemini/chat/chat_screen.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/home/home.dart';
import 'package:chat_gemini/splash/splash_view.dart';
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
          keepHistory: false,
          page: ChatScreenRoute.page,
        ),
      ];
}
