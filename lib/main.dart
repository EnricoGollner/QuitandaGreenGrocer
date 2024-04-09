import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/app_pages.dart';
import 'package:quitanda_app/src/core/theme/styles.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/base/controllers/navigation_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());  
  Get.put<NavigationController>(NavigationController());
  
  runApp(const QuitandaApp());
}

class QuitandaApp extends StatelessWidget {
  const QuitandaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenGrocer',
      theme: Styles.setMaterial3Theme(),
      initialRoute: PagesRoutes.splashScreen,
      getPages: AppPages.pages, // Onde definimos as GetPages com Name e widget
    );
  }
}
