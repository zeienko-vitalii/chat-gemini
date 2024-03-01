import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final themeMode = switch (state) {
            ThemeLight() => ThemeMode.light,
            ThemeDark() => ThemeMode.dark,
            ThemeSystem() => ThemeMode.system,
          };

          return MaterialApp.router(
            title: 'ChatGemini',
            theme: themeData,
            darkTheme: themeDataDark,
            themeMode: themeMode,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
