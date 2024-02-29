import 'package:chat_gemini/app/app.dart';
import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const App(),
    ),
  );
}
