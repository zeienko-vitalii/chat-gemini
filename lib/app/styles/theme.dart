import 'package:flutter/material.dart';

const borderRadius82 = BorderRadius.all(Radius.circular(82));
const borderRadius32 = BorderRadius.all(Radius.circular(32));
const borderRadius16 = BorderRadius.all(Radius.circular(16));

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
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black, fontSize: 14),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
    headlineSmall: TextStyle(color: Colors.black, fontSize: 20),
    headlineMedium: TextStyle(color: Colors.black, fontSize: 24),
    headlineLarge: TextStyle(color: Colors.black, fontSize: 28),
    labelSmall: TextStyle(color: Colors.black, fontSize: 12),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelLarge: TextStyle(color: Colors.black, fontSize: 18),
    titleSmall: TextStyle(color: Colors.black, fontSize: 20),
    titleMedium: TextStyle(color: Colors.black, fontSize: 24),
    titleLarge: TextStyle(color: Colors.black, fontSize: 28),
    displaySmall: TextStyle(color: Colors.black, fontSize: 20),
    displayMedium: TextStyle(color: Colors.black, fontSize: 24),
    displayLarge: TextStyle(color: Colors.black, fontSize: 28),
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
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white, fontSize: 14),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
    headlineSmall: TextStyle(color: Colors.white, fontSize: 20),
    headlineMedium: TextStyle(color: Colors.white, fontSize: 24),
    headlineLarge: TextStyle(color: Colors.white, fontSize: 28),
    labelSmall: TextStyle(color: Colors.white, fontSize: 12),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    labelLarge: TextStyle(color: Colors.white, fontSize: 18),
    titleSmall: TextStyle(color: Colors.white, fontSize: 20),
    titleMedium: TextStyle(color: Colors.white, fontSize: 24),
    titleLarge: TextStyle(color: Colors.white, fontSize: 28),
    displaySmall: TextStyle(color: Colors.white, fontSize: 20),
    displayMedium: TextStyle(color: Colors.white, fontSize: 24),
    displayLarge: TextStyle(color: Colors.white, fontSize: 28),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
