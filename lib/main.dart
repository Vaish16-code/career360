import 'package:flutter/material.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // ✅ Start app with login screen
    );
  }
}
