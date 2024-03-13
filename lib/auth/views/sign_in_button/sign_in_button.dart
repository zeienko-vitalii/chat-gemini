import 'package:chat_gemini/auth/views/sign_in_button/base_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    this.type = SignInButtonType.google,
    this.onPressed,
    super.key,
    this.shape,
    this.color,
  });

  final SignInButtonType type;
  final HandleSignInFn? onPressed;
  final OutlinedBorder? shape;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BaseSignInButton(
      title: titleBySignInType(type),
      imagePath: imagePathBySignInType(type),
      onPressed: onPressed,
      shape: shape,
      color: color,
    );
  }
}

String titleBySignInType(SignInButtonType type) {
  switch (type) {
    case SignInButtonType.google:
      return 'Sign in with Google';
  }
}

String imagePathBySignInType(SignInButtonType type) {
  switch (type) {
    case SignInButtonType.google:
      return 'assets/images/google_logo.png';
  }
}
