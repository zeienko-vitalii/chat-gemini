import 'package:chat_gemini/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

Future<void> logout(BuildContext context, AuthCubit authCubit) {
  return showDialog(
    context: context,
    builder: (context) => ConfirmationAlertDialog(
      title: 'Would you like to logout?',
      onPressed: authCubit.signOut,
    ),
  );
}

class ConfirmationAlertDialog extends StatelessWidget {
  const ConfirmationAlertDialog({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text(
            'No',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
