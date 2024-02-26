import 'package:flutter/material.dart';
import 'package:quitanda_app/src/auth/screens/sign_in_screen.dart';
import 'package:quitanda_app/src/core/theme/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quitanda App',
      theme: Styles.setMaterial3Theme(),
      home: const SignInScreen(),
    );
  }
}


