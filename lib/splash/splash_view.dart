import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/splash/cubit/splash_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashCubit>().checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, SplashState state) {
        if (state is SplashProfileIncomplete) {
          context.router.replace(ProfileScreenRoute(toCompleteProfile: true));
        } else if (state is SplashSuccessful) {
          context.router.replace(ChatScreenRoute());
        } else if (state is SplashLoggedOut) {
          context.router.replace(const AuthScreenRoute());
        }
      },
      child: const Material(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
