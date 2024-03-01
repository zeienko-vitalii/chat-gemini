import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppBar customAppBar(
  BuildContext context, {
  required String title,
  Widget? leading,
}) {
  iconButton(IconData data) => IconButton(
        icon: Icon(data),
        onPressed: () {
          context.read<ThemeCubit>().changeTheme();
        },
      );

  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: Text(title),
    leading: leading ?? const SizedBox(),
    actions: [
      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => switch (state) {
          ThemeLight() => iconButton(Icons.nightlight_round),
          ThemeDark() => iconButton(Icons.wb_sunny_rounded),
          ThemeSystem() => iconButton(Icons.auto_awesome_rounded),
        },
      ),
    ],
  );
}
