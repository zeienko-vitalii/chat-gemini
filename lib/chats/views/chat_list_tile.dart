import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.title,
    this.isSelected = false,
    this.isAddButton = false,
    this.onPressed,
  });

  final String title;
  final bool isSelected;
  final bool isAddButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: isSelected ? Colors.black87 : Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: secondary,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            if (isAddButton) ...[
              Icon(
                Icons.add_rounded,
                color: isSelected ? Colors.white : secondary,
              ),
              const Gap(10),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isSelected ? Colors.white : secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
