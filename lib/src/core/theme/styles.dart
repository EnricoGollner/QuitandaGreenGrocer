import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';

class Styles {
  static ThemeData setMaterial3Theme() {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: CustomColors.customSwatchColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: CustomColors.customSwatchColor,
        background: Colors.white.withAlpha(190)
      ),
      useMaterial3: true,
    );
  }
}
