import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    BuildContext context, {
    super.key,
    required String title,
    super.leading,
    Widget? action,
  }) : super(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Row(
            children: [
              Expanded(
                child: Text(title),
              ),
            ],
          ),
          actions: [
            action ?? const SizedBox(),
          ],
        );
}
