import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: BlocBuilder(
              bloc: authCubit,
              builder: (context, state) {
                if (state is! SignIn) {
                  return const SizedBox();
                }

                final avatar = state.user.photoURL;
                final hasAvatar = avatar != null;

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
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
                    },
                    child: CircleAvatar(
                      backgroundImage: hasAvatar ? NetworkImage(avatar) : null,
                      child: const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const ListTile(
            title: Text('Item 1'),
            onTap: null,
          ),
          const ListTile(
            title: Text('Item 2'),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
