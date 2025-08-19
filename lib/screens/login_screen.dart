import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'role_select_screen.dart';
import 'mentor/mentor_dashboard.dart';
import '../theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> _login() async {
    // show loading
    showLoadingDialog(context, message: "Signing in...");

    final res = await ApiService.login(
      email: email.text.trim(),
      password: password.text,
    );

    if (!mounted) return; // ✅ prevent context errors
    hideLoadingDialog(context);

    if (res["error"] != null) {
      _popup("Sign In Failed", res["error"]);
    } else {
      // Check user role and navigate accordingly
      final userRole = res["user"]?["role"] ?? "student";
      
      if (userRole == "mentor") {
        // Navigate to mentor dashboard
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MentorDashboard()),
          (_) => false,
        );
      } else {
        // TODO: Navigate to student home screen (waiting for friend's home page)
        _popup("Success", "Student login successful! Home page coming soon...");
      }
    }
  }

  void _popup(String title, String msg) {
    if (!mounted) return; // ✅ safe check
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

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
              const AppLogo(variant: LogoVariant.login),
              const SizedBox(height: 16),
              const Text(
                "Career360",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: kGradientStart,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Enter your email",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Enter your password",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: gradientButtonChild("Sign In"),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RoleSelectScreen(),
                      ),
                    ),
                    child: const Text(
                      "Sign up here",
                      style: TextStyle(
                        color: kGradientStart,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
