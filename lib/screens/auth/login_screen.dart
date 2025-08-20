import 'package:flutter/material.dart';
import '../../theme.dart';
import '../../widgets/app_logo.dart';
import 'forgot_password_screen.dart';
import 'student_registration_screen.dart';
import 'mentor_registration_screen.dart';
import '../../main_nav_controller.dart';
import '../mentor/mentor_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate login delay
      await Future.delayed(const Duration(seconds: 2));

      // Simple demo authentication
      if (_emailController.text.trim().isEmpty ||
          _passwordController.text.isEmpty) {
        _showError('Please enter both email and password');
        return;
      }

      if (!mounted) return;

      // Demo: Check if email contains "mentor" for mentor login
      if (_emailController.text.trim().toLowerCase().contains('mentor')) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MentorDashboard()),
          (_) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavController()),
          (_) => false,
        );
      }
    } catch (e) {
      _showError('Login failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: kError,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Logo Section
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kPrimaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: kPrimary.withOpacity(0.2),
                          offset: const Offset(0, 8),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: const AppLogo(variant: LogoVariant.app),
                  ),
                ),

                const SizedBox(height: 32),

                // Welcome Text
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: kOnBackground,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue your learning journey',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: kOnSurfaceVariant),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Login Form
                customCard(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Enter your email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value!)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock_outlined),
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
                            if (value?.isEmpty ?? true) {
                              return 'Please enter your password';
                            }
                            if (value!.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Forgot Password - Centered
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: gradientButton(
                            text: 'Sign In',
                            onPressed: _login,
                            isLoading: _isLoading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: kOnSurfaceVariant.withOpacity(0.3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'New to Career360?',
                        style: TextStyle(
                          color: kOnSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: kOnSurfaceVariant.withOpacity(0.3)),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Registration Buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StudentRegistrationScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.school_outlined),
                        label: const Text('Register as Student'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MentorRegistrationScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.psychology_outlined),
                        label: const Text('Register as Mentor'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Demo Credentials Helper
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kInfo.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kInfo.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: kInfo, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Demo Credentials',
                            style: TextStyle(
                              color: kInfo,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Student: student@test.com / Student123!\n'
                        'Mentor: mentor@test.com / Mentor123!',
                        style: TextStyle(color: kInfo, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
