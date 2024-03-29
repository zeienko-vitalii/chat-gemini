import 'package:animated_text_kit/animated_text_kit.dart';
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
                child: AnimatedText(title),
              ),
            ],
          ),
          actions: [
            action ?? const SizedBox(),
          ],
        );
}

class AnimatedText extends StatefulWidget {
  const AnimatedText(
    this.title, {
    super.key,
  });

  final String title;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  bool _completed = false;

  @override
  void didUpdateWidget(covariant AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title) {
      setState(() => _completed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _completed
        ? Text(widget.title)
        : AnimatedTextKit(
            isRepeatingAnimation: false,
            onFinished: () {
              setState(() => _completed = true);
            },
            pause: const Duration(milliseconds: 100),
            animatedTexts: [
              TypewriterAnimatedText(
                widget.title,
                speed: const Duration(milliseconds: 300),
              ),
            ],
          );
  }
}
