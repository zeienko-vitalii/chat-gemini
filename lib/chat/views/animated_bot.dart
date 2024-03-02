import 'package:chat_gemini/app/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

const animatedBotDefaultSize = 224.0;

class AnimatedBot extends StatelessWidget {
  const AnimatedBot({
    super.key,
    this.size = animatedBotDefaultSize,
    this.borderRadiusGeometry = borderRadius82,
  });

  final double size;
  final BorderRadiusGeometry borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius82,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size / 2,
          minWidth: size / 2,
          maxHeight: size,
          maxWidth: size,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: const Stack(
            fit: StackFit.passthrough,
            children: [
              _BotBackground(),
              RiveAnimation.asset(
                'assets/animations/bot.riv',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BotBackground extends Row {
  const _BotBackground()
      : super(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Expanded(
              child: ColoredBox(color: Color(0xFFFDD064)),
            ),
            Expanded(
              flex: 2,
              child: ColoredBox(color: Color(0xFF2C2C2C)),
            ),
          ],
        );
}
