import 'package:chat_gemini/auth/views/sign_in_button/base_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    this.type = SignInButtonType.google,
    this.onPressed,
    super.key,
    this.shape,
    this.color,
    this.title,
    this.circle = false,
    this.size,
  });

  final SignInButtonType type;
  final HandleSignInFn? onPressed;
  final OutlinedBorder? shape;
  final Color? color;
  final String? title;
  final bool circle;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size ?? const Size.fromHeight(50),
      child: BaseSignInButton(
        key: keyBySignInType(type),
        title: title ?? titleBySignInType(type),
        imagePath: imagePathBySignInType(type),
        onPressed: onPressed,
        shape: shape,
        color: color,
        circle: circle,
      ),
    );
  }
}

Key keyBySignInType(SignInButtonType type) {
  switch (type) {
    case SignInButtonType.google:
      return const Key('google_sign_in_button');
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
