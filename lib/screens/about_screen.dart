import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_logo.dart';
import 'role_select_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(blurRadius: 24, color: Color(0x14000000)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppLogo(variant: LogoVariant.app),
              const SizedBox(height: 16),
              const Text(
                "Welcome to Career360",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: kGradientStart,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your gamified career guidance companion. Discover paths, connect with mentors, and grow together.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const RoleSelectScreen()),
                ),
                child: gradientButtonChild("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
