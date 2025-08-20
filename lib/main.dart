import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const CareerCounsellingApp());
}

class CareerCounsellingApp extends StatelessWidget {
  const CareerCounsellingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career360',
      theme: appTheme(),
      home: const LoginScreen(),
    );
  }
}
