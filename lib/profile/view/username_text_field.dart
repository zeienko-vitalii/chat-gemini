import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
  UsernameTextField({
    super.key,
    this.onEdit,
    this.hint,
    this.isLoading = false,
    TextEditingController? controller,
  }) : _controller = controller ?? TextEditingController();

  final bool isLoading;
  final ValueChanged<String>? onEdit;
  final String? hint;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: !isLoading,
            controller: _controller,
            cursorColor: Colors.grey.shade500,
            decoration: InputDecoration(
              hintText: hint ?? 'Enter username',
              contentPadding: const EdgeInsets.all(12),
              labelStyle: Theme.of(context).textTheme.labelSmall,
              hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .color!
                        .withOpacity(0.5),
                  ),
              suffixIcon: isLoading
                  ? const CupertinoActivityIndicator()
                  : IconButton(
                      onPressed: () {
                        if (isLoading) return;
                        final text = _controller.text.trim();

                        if (text.isNotEmpty) {
                          onEdit?.call(text);
                          _controller.clear();
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
            ),
            onSubmitted: (text) {
              if (isLoading) return;

              if (text.trim().isNotEmpty) {
                onEdit?.call(text);
                _controller.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
