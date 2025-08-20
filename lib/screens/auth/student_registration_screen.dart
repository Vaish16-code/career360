import 'package:flutter/material.dart';
import '../../theme.dart';
import '../student/student_home.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? _selectedAcademicLevel;
  String? _selectedInterestArea;

  final List<String> _academicLevels = [
    'High School',
    'Undergraduate',
    'Graduate',
    'Postgraduate',
    'PhD',
    'Working Professional',
  ];

  final List<String> _interestAreas = [
    'Technology',
    'Design',
    'Medicine',
    'Engineering',
    'Business',
    'Arts',
    'Science',
    'Education',
    'Law',
    'Finance',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedAcademicLevel == null) {
      _showError('Please select your academic level');
      return;
    }

    if (_selectedInterestArea == null) {
      _showError('Please select your area of interest');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate registration delay
      await Future.delayed(const Duration(seconds: 2));

      // Simple validation for demo
      if (_nameController.text.trim().isEmpty ||
          _emailController.text.trim().isEmpty ||
          _passwordController.text.isEmpty) {
        _showError('Please fill in all required fields');
        return;
      }

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const StudentHome()),
        (_) => false,
      );
    } catch (e) {
      _showError('Registration failed. Please try again.');
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
      appBar: AppBar(
        title: const Text('Student Registration'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kGradientStart, kGradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Icon(Icons.school, size: 60, color: kOnPrimary),
                    const SizedBox(height: 16),
                    Text(
                      'Join as a Student',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: kOnPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start your learning journey with expert mentors',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: kOnPrimary.withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Registration Form
              customCard(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          prefixIcon: Icon(Icons.person_outlined),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Email
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

                      // Academic Level Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedAcademicLevel,
                        decoration: const InputDecoration(
                          labelText: 'Academic Level',
                          prefixIcon: Icon(Icons.school_outlined),
                        ),
                        items: _academicLevels.map((level) {
                          return DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedAcademicLevel = value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select your academic level';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Interest Area Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedInterestArea,
                        decoration: const InputDecoration(
                          labelText: 'Area of Interest',
                          prefixIcon: Icon(Icons.interests_outlined),
                        ),
                        items: _interestAreas.map((area) {
                          return DropdownMenuItem(
                            value: area,
                            child: Text(area),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedInterestArea = value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select your area of interest';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Create a password',
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
                            return 'Please enter a password';
                          }
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm your password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: gradientButton(
                          text: 'Create Student Account',
                          onPressed: _register,
                          isLoading: _isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Back to Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: kOnSurfaceVariant),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Sign In'),
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
