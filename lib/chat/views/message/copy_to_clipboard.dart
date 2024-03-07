import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class CopyToClipboardButton extends StatefulWidget {
  const CopyToClipboardButton({
    required this.text,
    super.key,
  });

  final String text;

  @override
  State<CopyToClipboardButton> createState() => _CopyToClipboardButtonState();
}

class _CopyToClipboardButtonState extends State<CopyToClipboardButton> {
  bool _isCopied = false;

  @override
  Widget build(BuildContext context) {
    final corssFadeState =
        _isCopied ? CrossFadeState.showSecond : CrossFadeState.showFirst;
    return AnimatedCrossFade(
      firstChild: IconButton(
        icon: const Icon(Icons.copy_rounded),
        onPressed: copyToClipboardCallback,
      ),
      secondChild: IconButton(
        onPressed: () {
          _isCopied = !_isCopied;
          setState(() {});
        },
        icon: const Icon(
          Icons.done_rounded,
          color: Colors.green,
        ),
      ),
      crossFadeState: corssFadeState,
      duration: const Duration(milliseconds: 300),
    );
  }

  void copyToClipboardCallback() {
    if (widget.text.isEmpty) return;
    FlutterClipboard.copy(widget.text);

    _isCopied = !_isCopied;
    setState(() {});
  }
}
