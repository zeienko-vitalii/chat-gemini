import 'package:flutter/material.dart';

typedef HandleSignInFn = void Function();

enum SignInButtonType { google }

class BaseSignInButton extends StatelessWidget {
  const BaseSignInButton({
    required this.title,
    super.key,
    this.imagePath,
    this.onPressed,
    this.shape,
    this.color,
    this.circle = false,
  });

  final bool circle;
  final String title;
  final String? imagePath;
  final HandleSignInFn? onPressed;
  final OutlinedBorder? shape;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shape,
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (shouldShowImage(imagePath)) ...[
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Image.asset(
                imagePath!,
                height: 28,
                width: 28,
              ),
            ),
            if (!circle) const SizedBox(width: 12),
          ],
          if (!circle)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(title),
            ),
        ],
      ),
    );
  }
}

bool shouldShowImage(String? imagePath) {
  return imagePath != null && imagePath.isNotEmpty;
}
