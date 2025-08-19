import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/multi_choice_chip.dart';
import '../theme.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import '../widgets/app_logo.dart';
import '../widgets/loading_dialog.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({super.key});
  @override
  State<RegisterStudentScreen> createState() => _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final age = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String? selectedClass;
  List<String> selectedInterests = [];

  final classes = const ["Class 10", "Class 12"];
  final interests = const [
    "Technology",
    "Science",
    "Mathematics",
    "Arts & Design",
    "Music",
    "Sports",
    "Literature",
    "Business",
    "Medicine",
    "Engineering",
    "Psychology",
    "Social Work",
    "Environment",
    "Media",
    "Gaming",
  ];

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedClass == null) {
      _popup("Validation Error", "Please select a class.");
      return;
    }
    if (selectedInterests.length < 3) {
      _popup("Validation Error", "Please select at least 3 interests.");
      return;
    }

    showLoadingDialog(context, message: "Creating student account...");

    final res = await ApiService.registerStudent(
      name: name.text.trim(),
      email: email.text.trim(),
      password: password.text,
      education: selectedClass!,
      bio: "Age: ${age.text.trim()}",
      interests: selectedInterests,
    );

    if (!mounted) return;
    hideLoadingDialog(context);

    Future.delayed(Duration.zero, () {
      if (res["error"] != null) {
        _popup("Registration Failed", res["error"]);
      } else {
        _popup(
          "Success",
          "Student account created!",
          onOk: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (_) => false,
            );
          },
        );
      }
    });
  }

  void _popup(String title, String msg, {VoidCallback? onOk}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (onOk != null) onOk();
              },
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
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(blurRadius: 24, color: Color(0x14000000)),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: AppLogo(variant: LogoVariant.student)),
                  const SizedBox(height: 16),
                  const Text(
                    "Create Student Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    validator: (val) => val == null || val.trim().isEmpty
                        ? "Enter your name"
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Age"),
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Enter your age";
                      final n = int.tryParse(val);
                      if (n == null || n <= 5 || n > 100) {
                        return "Enter a valid age";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Class"),
                    value: selectedClass,
                    items: classes
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (val) => setState(() => selectedClass = val),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Enter email";
                      }
                      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!regex.hasMatch(val)) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                    validator: (val) {
                      if (val == null || val.isEmpty) return "Enter password";
                      if (!RegExp(
                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
                      ).hasMatch(val)) {
                        return "Min 8 chars, upper, lower, number & special char";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                    ),
                    validator: (val) =>
                        val != password.text ? "Passwords don’t match" : null,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "✨ What interests you? (Select at least 3)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  MultiChoiceChip(
                    options: interests,
                    onChanged: (v) => selectedInterests = v,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: gradientButtonChild("Create Student Account"),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      child: const Text("Back to Login"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
