import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/chat/chat_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ChatScreen();
  }
}
