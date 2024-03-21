import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/pages_routes/app_pages.dart';
import 'package:quitanda_app/src/core/theme/styles.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<AuthController>(() => AuthController());
  
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
