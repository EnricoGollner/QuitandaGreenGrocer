import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/home/components/app_name_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Get.find<AuthController>().validateToken(),
      builder: (context, snapshot) {
        return Material(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  CustomColors.customSwatchColor,
                  CustomColors.customSwatchColor.shade700,
                ],
              ),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppNameWidget(
                  greenTitleColor: Colors.white,
                  textSize: 40,
                ),
                SizedBox(height: 10),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
