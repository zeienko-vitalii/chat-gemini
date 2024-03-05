import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const defaultProfileIconSize = 28.0;

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    this.photoUrl,
    this.onPressed,
    this.isLoading = false,
    this.size = defaultProfileIconSize,
  });

  final String? photoUrl;
  final bool isLoading;
  final double size;
  final VoidCallback? onPressed;

  bool get _hasAvatar => photoUrl != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: CircleAvatar(
          radius: size,
          backgroundColor: Colors.white24,
          backgroundImage: _backgroundImage(),
          child: _placeholder(context),
        ),
      ),
    );
  }

  Widget? _placeholder(BuildContext context) {
    if (isLoading) {
      return const CupertinoActivityIndicator();
    }
    if (_hasAvatar) return null;

    return Icon(
      Icons.account_circle_rounded,
      size: size,
    );
  }

  ImageProvider<Object>? _backgroundImage() {
    if (_hasAvatar && !isLoading) {
      return NetworkImage(photoUrl!);
    } else {
      return null;
    }
  }
}
