import 'package:flutter/material.dart';

const borderRadius82 = BorderRadius.all(Radius.circular(82));
const borderRadius32 = BorderRadius.all(Radius.circular(32));
const borderRadius16 = BorderRadius.all(Radius.circular(16));

const lightTextColorStyle = Color(0xFF1d1d1d);
const darkTextColorStyle = Colors.white;

const _border = OutlineInputBorder(
  borderRadius: borderRadius32,
  borderSide: BorderSide(color: Colors.grey),
);

final themeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF494949),
    onPrimary: Color(0xFF494949),
    inversePrimary: Color(0xFF494949),
    background: Colors.white,
    onBackground: Colors.white,
    secondary: Colors.black87,
    onSecondary: Colors.black87,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black87),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: borderRadius32,
        ),
      ),
    ),
  ),
  cardTheme: const CardTheme(
    elevation: 0,
    color: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black87),
    focusedBorder: _border,
    disabledBorder: _border,
    border: _border,
    errorBorder: _border,
    enabledBorder: _border,
    focusedErrorBorder: _border,
    suffixIconColor: Color(0xFF0a0a0a),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.black87),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: lightTextColorStyle, fontSize: 14),
    bodyMedium: TextStyle(color: lightTextColorStyle, fontSize: 16),
    bodyLarge: TextStyle(color: lightTextColorStyle, fontSize: 18),
    headlineSmall: TextStyle(color: lightTextColorStyle, fontSize: 20),
    headlineMedium: TextStyle(color: lightTextColorStyle, fontSize: 24),
    headlineLarge: TextStyle(color: lightTextColorStyle, fontSize: 28),
    labelSmall: TextStyle(color: lightTextColorStyle, fontSize: 12),
    labelMedium: TextStyle(color: lightTextColorStyle, fontSize: 16),
    labelLarge: TextStyle(color: lightTextColorStyle, fontSize: 18),
    titleSmall: TextStyle(color: lightTextColorStyle, fontSize: 20),
    titleMedium: TextStyle(color: lightTextColorStyle, fontSize: 24),
    titleLarge: TextStyle(color: lightTextColorStyle, fontSize: 28),
    displaySmall: TextStyle(color: lightTextColorStyle, fontSize: 20),
    displayMedium: TextStyle(color: lightTextColorStyle, fontSize: 24),
    displayLarge: TextStyle(color: lightTextColorStyle, fontSize: 28),
  ),
  useMaterial3: true,
);

final themeDataDark = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF0a0a0a),
    onPrimary: Color(0xFF0a0a0a),
    inversePrimary: Color(0xFF0a0a0a),
    background: Color(0xFF1d1d1d),
    onBackground: Color(0xFF1d1d1d),
    secondary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.black87),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: borderRadius32,
        ),
      ),
    ),
  ),
  drawerTheme: const DrawerThemeData(
    elevation: 0,
    backgroundColor: Color(0xFF1d1d1d),
  ),
  cardTheme: const CardTheme(
    elevation: 0,
    color: Color(0xFF1d1d1d),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    focusedBorder: _border,
    disabledBorder: _border,
    border: _border,
    errorBorder: _border,
    enabledBorder: _border,
    focusedErrorBorder: _border,
    suffixIconColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: darkTextColorStyle, fontSize: 14),
    bodyMedium: TextStyle(color: darkTextColorStyle, fontSize: 16),
    bodyLarge: TextStyle(color: darkTextColorStyle, fontSize: 18),
    headlineSmall: TextStyle(color: darkTextColorStyle, fontSize: 20),
    headlineMedium: TextStyle(color: darkTextColorStyle, fontSize: 24),
    headlineLarge: TextStyle(color: darkTextColorStyle, fontSize: 28),
    labelSmall: TextStyle(color: darkTextColorStyle, fontSize: 12),
    labelMedium: TextStyle(color: darkTextColorStyle, fontSize: 16),
    labelLarge: TextStyle(color: darkTextColorStyle, fontSize: 18),
    titleSmall: TextStyle(color: darkTextColorStyle, fontSize: 20),
    titleMedium: TextStyle(color: darkTextColorStyle, fontSize: 24),
    titleLarge: TextStyle(color: darkTextColorStyle, fontSize: 28),
    displaySmall: TextStyle(color: darkTextColorStyle, fontSize: 20),
    displayMedium: TextStyle(color: darkTextColorStyle, fontSize: 24),
    displayLarge: TextStyle(color: darkTextColorStyle, fontSize: 28),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
