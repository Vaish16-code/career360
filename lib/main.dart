import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';
import 'screens/mentor/mentor_dashboard.dart'; // Temporary import for testing

void main() {
  runApp(const Career360App());
}

class Career360App extends StatelessWidget {
  const Career360App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career360',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      // Temporarily go directly to mentor dashboard for testing
      //home: const MentorDashboard(),
      home: const SplashScreen(), // Original - commented out temporarily
    );
  }
}
