import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/theme/theme_cubit.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/chat/models/chat.dart';
import 'package:chat_gemini/chats/chat_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    required this.chat,
    super.key,
  });

  final Chat chat;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().checkUserAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is! SignedInComplete) {
            return const Center(child: CupertinoActivityIndicator());
          }

          final avatar = state.user.photoUrl;

          return SafeArea(
            child: Column(
              children: <Widget>[
                _ProfileItem(
                  avatar: avatar,
                  onPressed: () {
                    context.router.push(ProfileScreenRoute());
                  },
                ),
                Expanded(
                  child: ChatListWidget(chat: widget.chat),
                ),
              ],
            ),
          );
        },
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      margin: const EdgeInsets.only(bottom: 8),
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
              // ThemeSystem() => _iconButton(context, Icons.auto_awesome_rounded),
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
