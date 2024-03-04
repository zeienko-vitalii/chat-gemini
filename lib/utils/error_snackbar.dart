import 'package:flutter/material.dart';

enum SnackbarMessageType {
  error,
  success,
}

void showSnackbarMessage(
  BuildContext context, {
  String? message,
  SnackbarMessageType type = SnackbarMessageType.error,
}) {
  final color = switch (type) {
    SnackbarMessageType.error => Colors.redAccent,
    SnackbarMessageType.success => Colors.green,
  };
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? 'No message.'),
      backgroundColor: color,
    ),
  );
}
