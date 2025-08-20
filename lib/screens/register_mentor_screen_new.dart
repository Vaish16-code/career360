import 'package:flutter/material.dart';
import '../widgets/multi_choice_chip.dart';
import '../theme.dart';
import 'auth/login_screen.dart';
import '../widgets/app_logo.dart';
import '../widgets/loading_dialog.dart';

class RegisterMentorScreen extends StatefulWidget {
  const RegisterMentorScreen({super.key});
  @override
  State<RegisterMentorScreen> createState() => _RegisterMentorScreenState();
}

class _RegisterMentorScreenState extends State<RegisterMentorScreen> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final bio = TextEditingController();

  List<String> selectedExpertise = [];
  List<String> selectedAvailability = [];
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final expertise = const [
    "Technology & Programming",
    "Engineering",
    "Medicine & Healthcare",
    "Business & Finance",
    "Arts & Design",
    "Science & Research",
    "Education",
    "Marketing & Sales",
    "Law & Legal",
    "Media & Communications",
    "Social Sciences",
    "Psychology",
    "Environmental Studies",
    "Sports & Fitness",
  ];

  final availability = const [
    "Weekday Mornings",
    "Weekday Evenings",
    "Weekend Mornings",
    "Weekend Evenings",
    "Flexible Schedule",
    "By Appointment Only",
  ];

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedExpertise.isEmpty) {
      _popup("Validation Error", "Select at least one expertise.");
      return;
    }
    if (selectedAvailability.isEmpty) {
      _popup("Validation Error", "Select at least one availability slot.");
      return;
    }

    showLoadingDialog(context, message: "Creating mentor account...");

    // Simulate successful registration
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    hideLoadingDialog(context);

    Future.delayed(Duration.zero, () {
      _popup(
        "Success",
        "Mentor account created successfully! Please login.",
        onOk: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
          );
        },
      );
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
                  const Center(child: AppLogo(variant: LogoVariant.mentor)),
                  const SizedBox(height: 16),
                  const Text(
                    "Create Mentor Account",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return "Only letters allowed";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: password,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      if (!RegExp(
                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      ).hasMatch(value)) {
                        return "Min 8 chars, include upper, lower, number & special char";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmPassword,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm your password";
                      }
                      if (value != password.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: bio,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Professional Bio",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Bio is required";
                      }
                      if (value.trim().length < 20) {
                        return "Bio must be at least 20 characters long";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Expertise Domains (Select at least one)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  MultiChoiceChip(
                    options: expertise,
                    onChanged: (v) => selectedExpertise = v,
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Availability (Select at least one)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  MultiChoiceChip(
                    options: availability,
                    onChanged: (v) => selectedAvailability = v,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: gradientButtonChild("Create Mentor Account"),
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
