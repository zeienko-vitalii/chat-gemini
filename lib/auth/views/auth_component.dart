import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/views/already_have_account/already_have_account.dart';
import 'package:chat_gemini/auth/views/auth_horizontal_line/auth_horizontal_divider.dart';
import 'package:chat_gemini/auth/views/email_auth_form.dart';
import 'package:chat_gemini/auth/views/sign_in_button/sign_in_button.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AuthComponent extends StatefulWidget {
  const AuthComponent({super.key});

  @override
  State<AuthComponent> createState() => _AuthComponentState();
}

class _AuthComponentState extends State<AuthComponent> {
  AuthCubit get _authCubit => context.read<AuthCubit>();
  bool _isSignIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.checkUserAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        key: const Key('signin_appbar'),
        title: titleByIsSignIn(isSignIn: _isSignIn),
        leading: const SizedBox(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: onAuthListener,
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              children: [
                const Gap(64),
                const Icon(Icons.lock, size: 100),
                EmailAuthForm(
                  isSignIn: _isSignIn,
                  isLoading: isLoading,
                  onPressed: _authWithEmail,
                ),
                AlreadyHaveAccount(
                  isSignIn: _isSignIn,
                  onPressed: _changeSignInUpScreen,
                ),
                const AuthHorizontalDivider(),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: SignInButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: borderRadius32,
                            side: BorderSide(color: Colors.grey),
                          ),
                          onPressed: _authCubit.signInWithGoogle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _authWithEmail({
    required String email,
    required String password,
  }) {
    _authCubit.emailSignIn(
      email: email,
      password: password,
      shouldCreate: !_isSignIn,
    );
  }

  void _changeSignInUpScreen() {
    _isSignIn = !_isSignIn;
    setState(() {});
  }
}

String titleByIsSignIn({required bool isSignIn}) {
  return isSignIn ? 'Sign In' : 'Sign Up';
}

@visibleForTesting
void onAuthListener(BuildContext context, AuthState state) {
  if (state is AuthError) {
    showSnackbarMessage(context, message: state.message);
  } else if (state is SignedInComplete) {
    context.router.replace(ChatScreenRoute());
  } else if (state is SignedInIncomplete) {
    context.router.replace(ProfileScreenRoute(toCompleteProfile: true));
  } else if (state is LogOut && kIsWeb) {
    context.read<AuthCubit>().silentSignInWithGoogle();
  }
}
