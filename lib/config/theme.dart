import 'package:flutter/material.dart';

class Theme {
  Theme({required this.appTheme});

  final AppTheme appTheme;
}

enum AppTheme {
  Dark,
  Light,
}

extension AppThemeExtension on AppTheme {
  LayoutColors getLayoutColors() {
    switch (this) {
      case AppTheme.Dark:
        return _getDarkLayoutColors();
      case AppTheme.Light:
        return _getLightLayoutColors();
      default:
        return _getLightLayoutColors();
    }
  }
}

class LayoutColors {
  LayoutColors(
      {required this.backgroundColor,
      required this.primarySwatch,
      required this.primaryTextColor,
      required this.navbarBackground});
  final Color backgroundColor;
  final MaterialColor primarySwatch;
  final Color primaryTextColor;
  final Color navbarBackground;
}

LayoutColors _getLightLayoutColors() {
  return LayoutColors(
      backgroundColor: Colors.white,
      primarySwatch: Colors.deepPurple,
      primaryTextColor: Colors.black,
      navbarBackground: Colors.deepPurple);
}

LayoutColors _getDarkLayoutColors() {
  return LayoutColors(
      backgroundColor: Colors.black,
      primarySwatch: Colors.blueGrey,
      primaryTextColor: Colors.grey.shade400,
      navbarBackground: Colors.black);
}
