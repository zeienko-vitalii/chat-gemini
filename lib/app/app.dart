import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:chat_gemini/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeMode =
            state is ThemeLight ? ThemeMode.light : ThemeMode.dark;
        return MaterialApp(
          title: 'ChatGemini',
          theme: themeData,
          darkTheme: themeDataDark,
          themeMode: themeMode,
          home: const HomeScreen(title: 'Chat'),
        );
      },
    );
  }
}
