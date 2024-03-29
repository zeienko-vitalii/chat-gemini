import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef OnAttachFilePressed = void Function(String fileUrl);

Future<void> showAttachMediaBottomSheet(
  BuildContext context, {
  required ImagePicker imagePicker,
  required OnAttachFilePressed onAttachFilePressed,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return AttachMediaModalBottomSheet(
        imagePicker: imagePicker,
        onAttachFilePressed: onAttachFilePressed,
      );
    },
  );
}

class AttachMediaModalBottomSheet extends StatelessWidget {
  const AttachMediaModalBottomSheet({
    required this.imagePicker,
    required this.onAttachFilePressed,
    super.key,
  });

  final ImagePicker imagePicker;
  final OnAttachFilePressed onAttachFilePressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Cancel',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => _onSelectFile(
            context,
            ImageSource.gallery,
            imagePicker,
          ),
          child: Text(
            '🖼️ Photo library',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () => _onSelectFile(
            context,
            ImageSource.camera,
            imagePicker,
          ),
          child: Text(
            '📷 Take a photo',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Future<void> _onSelectFile(
    BuildContext context,
    ImageSource source,
    ImagePicker imagePicker,
  ) async {
    try {
      final image = await imagePicker.pickImage(
        source: source,
      );
      final filePath = image?.path;

      if (filePath == null) return;

      onAttachFilePressed(filePath);
    } catch (e, stk) {
      Log().e(e, stk);

      if (!context.mounted) return;
      showSnackbarMessage(context, message: '$e');
    } finally {
      if (context.mounted) {
        unawaited(context.router.pop());
      }
    }
  }
}
