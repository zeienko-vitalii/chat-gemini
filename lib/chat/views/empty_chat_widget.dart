import 'package:chat_gemini/chat/views/animated_bot.dart';
import 'package:chat_gemini/chat/views/chat_text_field.dart';
import 'package:chat_gemini/chats/styles/chat_list_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({super.key, this.onSend});

  final OnMessageSend? onSend;

  static const _suggestedButtons = [
    [
      {
        'title': 'Create a charter',
        'content': 'to start a film club',
      },
      {
        'title': 'Plan a trip',
        'content': 'to explore the Madagascar island on a budget',
      },
    ],
    [
      {
        'title': 'Brainstrop content ideas',
        'content': 'for my new podcast on urban design',
      },
      {
        'title': 'Tell me a fun fact',
        'content': 'about the Roman Empire',
      },
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constrains,
      ) {
        final isSmallScreen = constrains.maxWidth < 600;
        final isMedHeight = constrains.maxHeight < 500;
        final isMidSmHeight = constrains.maxHeight < 380;
        final isSmallHeight = constrains.maxHeight < 150;
        // final isMedHeight = ;

        if (isSmallHeight) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isMidSmHeight)
                const Expanded(
                  flex: 2,
                  child: Center(child: AnimatedBot()),
                ),
              if (!isMedHeight) ...[
                const Gap(20),
                Text(
                  'Hi, there 👋',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Text(
                  'Start the conversation by typing a message below',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ..._suggestedButtons
                        .take(
                      isSmallScreen ? 1 : _suggestedButtons.length,
                    )
                        .map((buttons) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: buttons.map((button) {
                              final title = button['title'] as String;
                              final content = button['content'] as String;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SuggestedConversationButton(
                                    onPressed: () {
                                      onSend?.call('$title $content');
                                    },
                                    title: title,
                                    content: content,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SuggestedConversationButton extends StatelessWidget {
  const SuggestedConversationButton({
    required this.title,
    required this.content,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String content;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: chatListButtonStyle(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
