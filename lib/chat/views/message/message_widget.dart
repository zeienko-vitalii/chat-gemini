import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/chat/models/message.dart';
import 'package:chat_gemini/chat/views/message/copy_to_clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    required this.message,
    required this.username,
    super.key,
    this.avatar,
  });

  final Message message;
  final String? avatar;
  final String username;

  String get _textMessage => message.text;

  bool get hasAvatar => avatar != null;
  bool get assetAvatar => avatar != null && avatar!.startsWith('assets');
  bool get isBot => message.isBot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            // issue: https://github.com/flutter/flutter/issues/77782
            backgroundImage: assetAvatar
                ? ExactAssetImage(avatar!) as ImageProvider
                : hasAvatar
                    ? NetworkImage(avatar!)
                    : null,
            child: hasAvatar
                ? const SizedBox()
                : Text(
                    _shortUsername(avatar, username),
                  ),
          ),
          const Gap(8),
          Expanded(
            child: Stack(
              children: [
                if (isBot)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CopyToClipboardButton(text: _textMessage),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      username,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.15,
                        height: 1,
                      ),
                    ),
                    const Gap(4),
                    MarkdownBody(
                      data: _textMessage,
                      selectable: true,
                      styleSheet: MarkdownStyleSheet.fromTheme(
                        Theme.of(context),
                      ).copyWith(
                        strong:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
                    ),
                    if (message.hasMedia) ...[
                      const Gap(4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _ImageAttachment(message.media!.url),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _shortUsername(String? avatar, String username) {
    if (avatar == null && username.length > 2) {
      return username.substring(0, 2).toUpperCase();
    }
    return username.toUpperCase();
  }
}

class _ImageAttachment extends StatelessWidget {
  const _ImageAttachment(this.fileUrl);

  final String fileUrl;

  static const size = 200.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: ClipRRect(
        borderRadius: borderRadius16,
        child: Image.network(
          fileUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
