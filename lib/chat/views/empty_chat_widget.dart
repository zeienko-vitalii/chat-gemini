import 'package:chat_gemini/chat/views/animated_bot.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if (!isKeyboardVisible) ...[
            const Expanded(
              flex: 2,
              child: Center(child: AnimatedBot()),
            ),
            const Gap(20),
          ],
          Text(
            'No messages yet',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Text(
            'Start the conversation by typing a message below',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
