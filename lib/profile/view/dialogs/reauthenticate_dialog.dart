import 'package:chat_gemini/auth/views/email_auth_form.dart';
import 'package:chat_gemini/auth/views/sign_in_button/sign_in_button.dart';
import 'package:chat_gemini/profile/cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

typedef OnReauthenticate = void Function();

class ReauthenticateDialog extends StatelessWidget {
  ReauthenticateDialog({
    required this.onGoogleReauthenticate,
    required this.onEmailReauthenticate,
    this.isLoading = false,
    super.key,
  })  : _emailController = TextEditingController(),
        _passwordController = TextEditingController();

  final bool isLoading;
  final OnReauthenticate onGoogleReauthenticate;
  final EmailAuthFormCallback onEmailReauthenticate;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final isLoading = state is ProfileLoading;

        return GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Reauthenticate'),
            content: SizedBox(
              height: 320,
              child: isLoading
                  ? const SizedBox(
                      width: 400,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('You need to reauthenticate to continue'),
                        EmailAuthForm(
                          isSignIn: true,
                          isLoading: isLoading,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: Navigator.of(context).pop,
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SignInButton(
                                circle: true,
                                shape: const CircleBorder(
                                  side: BorderSide(color: Colors.grey),
                                ),
                                onPressed: onGoogleReauthenticate,
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => onEmailReauthenticate(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
