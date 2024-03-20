import 'package:flutter/material.dart';
import 'package:quitanda_app/src/pages/auth/screens/sign_in_screen.dart';
import 'package:quitanda_app/src/core/theme/styles.dart';
import 'package:quitanda_app/src/pages/auth/screens/splash_screen.dart';

void main() {
  runApp(const QuitandaApp());
}

class QuitandaApp extends StatelessWidget {
  const QuitandaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenGrocer',
      theme: Styles.setMaterial3Theme(),
      home: const SplashScreen(),
    );
  }
}


