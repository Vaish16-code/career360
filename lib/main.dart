import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart'; // 👈 your teammate's login screen
import 'profile_page.dart';         // 👈 your ProfilePage

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
      theme: appTheme(), // Keep your original theme
      home: const SplashScreen(), // Keep your splash screen flow
    );
  }
}
