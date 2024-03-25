import 'package:flutter/material.dart';

const chatTileDarkColor = Colors.black87;
const chatTileLightColor = Color(0xDDFFFFFF);

Color chatListTileContentColor({
  required bool isLightTheme,
  bool isSelected = false,
}) {
  if (isLightTheme) {
    return selectedTileColor(isSelected: isSelected);
  } else {
    return chatTileLightColor;
  }
}

Color selectedTileColor({required bool isSelected}) {
  return isSelected ? chatTileLightColor : chatTileDarkColor;
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
              if (states.contains(MaterialState.pressed)) {
                return Colors.black38;
              }
              if (isSelected) {
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
