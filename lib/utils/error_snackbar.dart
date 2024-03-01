import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, [String? message]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? 'An error occurred'),
      backgroundColor: Colors.redAccent,
    ),
  );
}
