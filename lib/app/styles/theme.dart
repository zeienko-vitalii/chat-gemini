import 'package:flutter/material.dart';

const _borderRadius = BorderRadius.all(Radius.circular(32));

const _border = OutlineInputBorder(
  borderRadius: _borderRadius,
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
    secondary: Colors.white10,
    onSecondary: Colors.white10,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  drawerTheme: const DrawerThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: _border,
    disabledBorder: _border,
    border: _border,
    errorBorder: _border,
    enabledBorder: _border,
    focusedErrorBorder: _border,
    suffixIconColor: Color(0xFF0a0a0a),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
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
    secondary: Colors.white10,
    onSecondary: Colors.white10,
    error: Colors.redAccent,
    onError: Colors.redAccent,
    surface: Colors.white,
    onSurface: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  drawerTheme: const DrawerThemeData(
    elevation: 0,
    backgroundColor: Color(0xFF1d1d1d),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: _border,
    disabledBorder: _border,
    border: _border,
    errorBorder: _border,
    enabledBorder: _border,
    focusedErrorBorder: _border,
    suffixIconColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  useMaterial3: true,
);
