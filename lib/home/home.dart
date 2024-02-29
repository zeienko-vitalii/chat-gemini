import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:chat_gemini/chat/chat_screen.dart';
import 'package:chat_gemini/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return switch (state) {
                ThemeLight() => IconButton(
                    icon: const Icon(Icons.nightlight_round),
                    onPressed: () {
                      context.read<ThemeCubit>().changeTheme();
                    },
                  ),
                ThemeDark() => IconButton(
                    icon: const Icon(Icons.wb_sunny_rounded),
                    onPressed: () {
                      context.read<ThemeCubit>().changeTheme();
                    },
                  ),
                ThemeSystem() => IconButton(
                    icon: const Icon(Icons.auto_awesome_rounded),
                    onPressed: () {
                      context.read<ThemeCubit>().changeTheme();
                    },
                  ),
              };
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: ChatScreen(),
        ),
      ),
    );
  }
}
