import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';

class Styles {
  static ThemeData setMaterial3Theme() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
      ),
      colorScheme: ColorScheme.light(
        primary: CustomColors.customSwatchColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: CustomColors.customSwatchColor,
        background: Colors.white.withAlpha(190),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }
}
