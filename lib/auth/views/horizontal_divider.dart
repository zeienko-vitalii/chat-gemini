import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).iconTheme.color,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
    );
  }
}
