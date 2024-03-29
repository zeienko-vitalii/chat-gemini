import 'dart:io';

import 'package:chat_gemini/chat/views/attach_media/attach_media_modal_bottom_sheet.dart';
import 'package:chat_gemini/profile/view/profile_avatar_widget.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatarSelection extends StatefulWidget {
  const ProfileAvatarSelection({
    required this.onAttachFilePressed,
    super.key,
    this.avatar,
    this.isLoading = false,
  });

  final String? avatar;
  final bool isLoading;
  final OnAttachFilePressed onAttachFilePressed;

  @override
  State<ProfileAvatarSelection> createState() => _ProfileAvatarSelectionState();
}

class _ProfileAvatarSelectionState extends State<ProfileAvatarSelection> {
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getLostData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: ProfileAvatarWidget(
            size: 100,
            photoUrl: widget.avatar,
            isLoading: widget.isLoading,
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () {
              showAttachMediaBottomSheet(
                context,
                imagePicker: _imagePicker,
                onAttachFilePressed: widget.onAttachFilePressed,
              );
            },
            child: const Text('Change photo'),
          ),
        ),
      ],
    );
  }

  Future<void> _getLostData(BuildContext context) async {
    try {
      if (kIsWeb || !Platform.isAndroid) return;
      final response = await _imagePicker.retrieveLostData();
      if (response.isEmpty) {
        Log().d('No lost data');
        return;
      }
      final files = response.files;

      if (files != null && files.isNotEmpty) {
        final first = files.first;
        final filePath = first.path;

        Log().d('Lost data found, length: ${files.length}');
        widget.onAttachFilePressed(filePath);
      } else if (response.exception != null) {
        throw response.exception!;
      } else {
        throw Exception('Unknown error');
      }
    } catch (e, stk) {
      Log().e(e, stk);

      if (!context.mounted) return;
      showSnackbarMessage(context, message: '$e');
    }
  }
}
