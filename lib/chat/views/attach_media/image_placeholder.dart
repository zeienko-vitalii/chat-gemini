import 'dart:io';

import 'package:chat_gemini/app/styles/theme.dart';
import 'package:chat_gemini/chat/views/attach_media/attach_media_button.dart';
import 'package:flutter/material.dart';

const placeholderSize = 80.0;

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    required this.file,
    required this.onDeletePressed,
    super.key,
  });

  final File file;
  final OnRemovePressed onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: placeholderSize,
      height: placeholderSize,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: placeholderSize * 0.93,
              height: placeholderSize * 0.95,
              padding: const EdgeInsets.all(4),
              decoration: _getDecoration(context),
              child: ClipRRect(
                borderRadius: borderRadius16 - BorderRadius.circular(4),
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: _RemoveIcon(
              onPressed: () => onDeletePressed(file),
            ),
          ),
        ],
      ),
    );
  }

  Decoration _getDecoration(BuildContext context) => BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: borderRadius16,
        border: Border.all(
          color: Theme.of(context).textTheme.labelLarge?.color ??
              Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      );
}

class _RemoveIcon extends StatelessWidget {
  const _RemoveIcon({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        icon: const Center(
          child: Icon(
            Icons.remove_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
