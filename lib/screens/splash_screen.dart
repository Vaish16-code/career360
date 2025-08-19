import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_logo.dart';
import 'about_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return; // ✅ prevents context error
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AboutScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppLogo(variant: LogoVariant.app, size: 86),
            SizedBox(height: 12),
            Text(
              "Career360",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: kGradientStart,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Connect, Learn, Grow Together",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
