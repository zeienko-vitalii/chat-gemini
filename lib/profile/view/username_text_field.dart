import 'package:chat_gemini/utils/validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
  UsernameTextField({
    super.key,
    this.onEdit,
    this.hint,
    this.isLoading = false,
    this.formKey,
    TextEditingController? controller,
  }) : _controller = controller ?? TextEditingController();

  final Key? formKey;
  final bool isLoading;
  final ValueChanged<String>? onEdit;
  final String? hint;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Form(
            key: formKey,
            child: TextFormField(
              enabled: !isLoading,
              controller: _controller,
              cursorColor: Colors.grey.shade500,
              validator: usernameValidation,
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
              onFieldSubmitted: (text) {
                if (isLoading) return;

                if (text.trim().isNotEmpty) {
                  onEdit?.call(text);
                  _controller.clear();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
