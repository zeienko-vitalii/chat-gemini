import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    BuildContext context, {
    required String title,
    super.key,
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
