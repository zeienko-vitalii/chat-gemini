import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, [String? message]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? 'An error occurred'),
      backgroundColor: Colors.redAccent,
    ),
  );
}

void showSuccessSnackbar(BuildContext context, [String? message]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? 'Success!'),
      backgroundColor: Colors.green,
    ),
  );
}
