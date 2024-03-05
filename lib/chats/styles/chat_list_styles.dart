import 'package:flutter/material.dart';

const chatTileDarkColor = Colors.black87;
const chatTileLightColor = Color(0xDDFFFFFF);

Color chatListTileContentColor(
  BuildContext context, {
  bool isSelected = false,
}) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  if (isLight) {
    return isSelected ? chatTileLightColor : chatTileDarkColor;
  }
  return isSelected ? chatTileDarkColor : chatTileLightColor;
}

ButtonStyle chatListButtonStyle(
  BuildContext context, {
  bool isSelected = false,
}) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(MaterialState.pressed) || isSelected) {
          return isLight ? chatTileDarkColor : chatTileLightColor;
        }
        return Colors.transparent;
      },
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ),
  );
}

class OutlinedElevatedButtonStyle extends ButtonStyle {
  OutlinedElevatedButtonStyle(
    BuildContext context, {
    bool isSelected = false,
    bool isLightTheme = true,
    double elevation = 0,
    double borderRadius = 12,
    EdgeInsetsGeometry? padding,
  }) : super(
          elevation: MaterialStateProperty.all(elevation),
          padding: MaterialStateProperty.all(
            padding ?? const EdgeInsets.all(16),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.pressed) || isSelected) {
                return isLightTheme ? chatTileDarkColor : chatTileLightColor;
              }
              return Colors.transparent;
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        );
}
