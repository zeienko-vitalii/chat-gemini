import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chats/chat_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Drawer(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is! SignIn) {
            return const SizedBox();
          }

          final avatar = state.user.photoURL;

          return SafeArea(
            child: Column(
              children: <Widget>[
                _ProfileItem(
                  avatar: avatar,
                  onPressed: () => _logout(context, authCubit),
                ),
                Expanded(
                  child: ChatListWidget(chat: chat),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _logout(BuildContext context, AuthCubit authCubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Would you like to logout?'),
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(
            onPressed: authCubit.signOut,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.onPressed,
    this.avatar,
  });

  final VoidCallback onPressed;
  final String? avatar;

  bool get hasAvatar => avatar != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: CircleAvatar(
              radius: 28,
              backgroundImage: hasAvatar ? NetworkImage(avatar!) : null,
              child: hasAvatar
                  ? null
                  : const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
            ),
          ),
          const Spacer(),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) => switch (state) {
              ThemeLight() => _iconButton(context, Icons.nightlight_round),
              ThemeDark() => _iconButton(context, Icons.wb_sunny_rounded),
              ThemeSystem() => _iconButton(context, Icons.auto_awesome_rounded),
            },
          ),
        ],
      ),
    );
  }

  IconButton _iconButton(BuildContext context, IconData data) => IconButton(
        icon: Icon(data),
        onPressed: context.read<ThemeCubit>().changeTheme,
      );
}
