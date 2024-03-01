import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/app/navigation/app_router.dart';
import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/app/views/custom_app_bar.dart';
import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:chat_gemini/auth/views/email_auth_form.dart';
import 'package:chat_gemini/auth/views/horizontal_divider.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
      _authCubit.isUserSignIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Sign In',
        leading: const SizedBox(),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: _onAuthListener,
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Column(
                children: [
                  const Icon(Icons.lock, size: 100),
                  EmailAuthForm(
                    isSignIn: _isSignIn,
                    isLoading: isLoading,
                    onPressed: _authWithEmail,
                  ),
                  _AlreadyHaveAccount(
                    isSignIn: _isSignIn,
                    onPressed: _changeSignInUpScreen,
                  ),
                  const _AuthHorizontalDivider(),
                  const Gap(20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: SignInButton(
                      Buttons.Google,
                      elevation: 8,
                      shape: const RoundedRectangleBorder(
                        borderRadius: borderRadius32,
                      ),
                      onPressed: _authCubit.signInWithGoogle,
                    ),
                  ),
                ],
              ),
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

  void _onAuthListener(BuildContext context, AuthState state) {
    if (state is AuthError) {
      showErrorSnackBar(context, state.message);
    } else if (state is SignIn) {
      context.router.replace(const HomeScreenRoute());
    }
  }

  void _changeSignInUpScreen() {
    _isSignIn = !_isSignIn;
    setState(() {});
  }
}

class _AlreadyHaveAccount extends StatelessWidget {
  const _AlreadyHaveAccount({
    required this.onPressed,
    required this.isSignIn,
  });

  final VoidCallback onPressed;
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        isSignIn
            ? 'Need an account? Sign Up'
            : 'Already have an account? Sign In',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class _AuthHorizontalDivider extends Row {
  const _AuthHorizontalDivider()
      : super(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Flexible(
              flex: 2,
              child: HorizontalDivider(),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'OR',
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: HorizontalDivider(),
            ),
          ],
        );
}
