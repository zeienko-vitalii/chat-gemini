import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({
    required this.onPressed,
    required this.isSignIn,
    super.key,
  });

  final VoidCallback onPressed;
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('already_have_account_button'),
      onPressed: onPressed,
      child: Text(
        getTitleByIsSignIn(isSignIn: isSignIn),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

String getTitleByIsSignIn({required bool isSignIn}) {
  return isSignIn
      ? 'Need an account? Sign Up'
      : 'Already have an account? Sign In';
}
