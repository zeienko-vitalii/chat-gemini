import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                ListTile(
                  title: Text(
                    'Item 1',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: null,
                ),
                ListTile(
                  title: Text(
                    'Item 2',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: null,
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
              child: hasAvatar ? null : const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}