import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/di/di.dart';
import 'package:chat_gemini/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<SplashCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final themeMode = switch (state) {
            ThemeLight() => ThemeMode.light,
            ThemeDark() => ThemeMode.dark,
            // ThemeSystem() => ThemeMode.system,
          };

          final brightness = switch (state) {
            ThemeLight() => Brightness.light,
            ThemeDark() => Brightness.dark,
            // ThemeSystem() => MediaQuery.platformBrightnessOf(context),
          };

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarBrightness: brightness,
              statusBarIconBrightness: brightness,
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: brightness,
            ),
            child: MaterialApp.router(
              title: 'ChatGemini',
              theme: themeData,
              darkTheme: themeDataDark,
              themeMode: themeMode,
              routerConfig: _appRouter.config(),
            ),
          );
        },
      ),
    );
  }
}
