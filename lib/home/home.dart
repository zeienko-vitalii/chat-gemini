import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/chat/chat_screen.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:chat_gemini/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: customAppBar(
        context,
        title: 'ChatGemini',
        leading: BlocBuilder(
          bloc: context.read<AuthCubit>(),
          builder: (context, state) {
            if (state is! SignIn) {
              return const SizedBox();
            }

            final avatar = state.user.photoURL;
            final hasAvatar = avatar != null;

            Log().i('Avatar: $avatar');
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
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
                          },
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
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Logout) {
            context.router.replace(const AuthScreenRoute());
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: const Center(
            child: ChatScreen(),
          ),
        ),
      ),
    );
  }
}
