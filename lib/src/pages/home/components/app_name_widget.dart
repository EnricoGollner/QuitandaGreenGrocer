import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';

class AppNameWidget extends StatelessWidget {
  final Color? greenTitleColor;
  final double textSize;

  const AppNameWidget({
    super.key,
    this.greenTitleColor,
    this.textSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: textSize),
        children: [
          TextSpan(
            text: 'Green',
            style: TextStyle(
                color: greenTitleColor ?? CustomColors.customSwatchColor),
          ),
          TextSpan(
            text: 'Grocer',
            style: TextStyle(color: CustomColors.customContrastColor),
          ),
        ],
      ),
    );
  }
}
