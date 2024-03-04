import 'dart:io';

import 'package:chat_gemini/chat/views/attach_media/attach_media_modal_bottom_sheet.dart';
import 'package:chat_gemini/chat/views/attach_media/image_placeholder.dart';
import 'package:chat_gemini/chats/styles/chat_list_styles.dart';
import 'package:chat_gemini/utils/error_snackbar.dart';
import 'package:chat_gemini/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

typedef OnAttachFilePressed = void Function(String fileUrl);
typedef OnRemovePressed = void Function(File file);

class AttachButton extends StatefulWidget {
  const AttachButton({
    super.key,
    this.files = const [],
    required this.onRemovePressed,
    required this.onAttachFilePressed,
  });

  final List<File> files;
  final OnRemovePressed onRemovePressed;
  final OnAttachFilePressed onAttachFilePressed;

  @override
  State<AttachButton> createState() => _AttachButtonState();
}

class _AttachButtonState extends State<AttachButton>
    with SingleTickerProviderStateMixin {
  final GlobalKey _iconGlobalKey = GlobalKey();

  final _imagePicker = ImagePicker();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linearToEaseOut,
    ),
  );

  OverlayEntry? _overlayEntry;
  bool _isExpanded = false;

  int get _filesLength => widget.files.length;
  bool get _hasAnyAttachment => _filesLength > 0;

  @override
  void initState() {
    super.initState();
    _getLostData(context);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _closeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _iconGlobalKey,
      children: [
        if (_hasAnyAttachment && !_isExpanded)
          Positioned(
            right: 0,
            child: _Badge('$_filesLength'),
          ),
        IconButton(
          onPressed: _onPressedCallback,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isExpanded
                ? const Icon(Icons.close_rounded)
                : const Icon(Icons.attach_file_rounded),
          ),
        ),
      ],
    );
  }

  Future<void> _getLostData(BuildContext context) async {
    try {
      final LostDataResponse response = await _imagePicker.retrieveLostData();
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
        throw 'Unknown error';
      }
    } catch (e, stk) {
      Log().e(e, stk);

      if (!context.mounted) return;
      showErrorSnackbar(context, '$e');
    }
  }

  void _onPressedCallback() {
    if (!_hasAnyAttachment) {
      showAttachMediaBottomSheet(
        context,
        imagePicker: _imagePicker,
        onAttachFilePressed: widget.onAttachFilePressed,
      );
      return;
    }
    _updateIsExpanded();
    _openCloseCallback();
  }

  void _updateIsExpanded() {
    _isExpanded = !_isExpanded;
    setState(() {});
  }

  void _openCloseCallback() {
    if (_isExpanded) {
      final file = widget.files.first;
      _showOverlay(
        context,
        file,
        () {
          showAttachMediaBottomSheet(
            context,
            imagePicker: _imagePicker,
            onAttachFilePressed: widget.onAttachFilePressed,
          );
        },
      );
    } else {
      _reverseAnimation();
    }
  }

  void _showOverlay(
    BuildContext context,
    File file,
    VoidCallback onAttachPressed,
  ) {
    final position = _getAttachMediaPosition(_iconGlobalKey);

    _overlayEntry = OverlayEntry(
      builder: (context) => _AttachMediaPlaceholder(
        file: file,
        position: position,
        animation: _animation,
        onDeletePressed: (file) {
          _updateIsExpanded();
          _openCloseCallback();
          widget.onRemovePressed(file);
        },
        onAttachPressed: () {
          _updateIsExpanded();
          _openCloseCallback();
          onAttachPressed();
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _forwardAnimation();
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _forwardAnimation() {
    _controller.forward();
  }

  void _reverseAnimation() {
    _controller.reverse();
  }

  Offset _getAttachMediaPosition(GlobalKey iconGlobalKey) {
    final renderBox =
        iconGlobalKey.currentContext?.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }
}

class _AttachMediaPlaceholder extends StatelessWidget {
  const _AttachMediaPlaceholder({
    required this.position,
    required this.animation,
    required this.file,
    required this.onDeletePressed,
    required this.onAttachPressed,
  });

  final Offset position;
  final Animation<Offset> animation;

  final File file;
  final OnRemovePressed onDeletePressed;
  final VoidCallback onAttachPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 25,
      top: position.dy - 150,
      child: SlideTransition(
        position: animation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImagePlaceholder(
              file: file,
              onDeletePressed: onDeletePressed,
            ),
            const Gap(12),
            ElevatedButton(
              style: OutlinedElevatedButtonStyle(
                context,
                padding: EdgeInsets.zero,
                borderRadius: 12,
              ),
              onPressed: onAttachPressed,
              child: Row(
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: chatListTileContentColor(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
      ),
    );
  }
}
