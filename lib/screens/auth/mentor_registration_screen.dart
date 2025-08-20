import 'package:flutter/material.dart';
import '../../theme.dart';
import '../mentor/mentor_dashboard.dart';

class MentorRegistrationScreen extends StatefulWidget {
  const MentorRegistrationScreen({super.key});

  @override
  State<MentorRegistrationScreen> createState() =>
      _MentorRegistrationScreenState();
}

class _MentorRegistrationScreenState extends State<MentorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _bioController = TextEditingController();
  final _linkedinController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _currentStep = 0;

  String? _selectedExperience;
  final List<String> _selectedExpertise = [];
  final List<String> _selectedLanguages = [];
  final List<String> _selectedAvailability = [];
  String? _selectedTimezone;

  final List<String> _experienceOptions = [
    '1-2 years',
    '3-5 years',
    '6-10 years',
    '10+ years',
  ];

  final List<String> _expertiseOptions = [
    'Software Engineering',
    'Data Science',
    'UX/UI Design',
    'Product Management',
    'Machine Learning',
    'DevOps',
    'Cybersecurity',
    'Mobile Development',
    'Web Development',
    'Business Strategy',
  ];

  final List<String> _languageOptions = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Portuguese',
    'Arabic',
    'Hindi',
    'Russian',
  ];

  final List<String> _availabilityOptions = [
    'Weekday Mornings',
    'Weekday Afternoons',
    'Weekday Evenings',
    'Weekend Mornings',
    'Weekend Afternoons',
    'Weekend Evenings',
  ];

  final List<String> _timezoneOptions = [
    'UTC-8 (PST)',
    'UTC-5 (EST)',
    'UTC+0 (GMT)',
    'UTC+1 (CET)',
    'UTC+5:30 (IST)',
    'UTC+8 (CST)',
    'UTC+9 (JST)',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    _linkedinController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submit();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _formKey.currentState?.validate() ?? false;
      case 1:
        return _selectedExperience != null &&
            _selectedExpertise.isNotEmpty &&
            _bioController.text.trim().length >= 50;
      case 2:
        return _selectedLanguages.isNotEmpty &&
            _selectedTimezone != null &&
            _selectedAvailability.isNotEmpty;
      default:
        return false;
    }
  }

  Future<void> _submit() async {
    if (!_canProceed()) return;

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
        MaterialPageRoute(builder: (_) => const MentorDashboard()),
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
        title: const Text('Mentor Registration'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                    decoration: BoxDecoration(
                      color: index <= _currentStep ? kPrimary : kSurfaceVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Page View
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentStep = index);
              },
              children: [
                _buildBasicInfoStep(),
                _buildProfessionalInfoStep(),
                _buildAvailabilityStep(),
              ],
            ),
          ),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      child: const Text('Previous'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  flex: _currentStep == 0 ? 1 : 1,
                  child: _canProceed()
                      ? gradientButton(
                          text: _currentStep == 2
                              ? 'Complete Registration'
                              : 'Next',
                          onPressed: _nextStep,
                          isLoading: _isLoading,
                        )
                      : Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: kSurfaceVariant,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              _currentStep == 2
                                  ? 'Complete Registration'
                                  : 'Next',
                              style: TextStyle(
                                color: kOnSurfaceVariant,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
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
                Icon(Icons.psychology, size: 60, color: kOnPrimary),
                const SizedBox(height: 16),
                Text(
                  'Join as a Mentor',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: kOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Share your expertise and guide the next generation',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kOnPrimary.withOpacity(0.9),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Form
          customCard(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basic Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 20),
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
                            _obscureConfirmPassword = !_obscureConfirmPassword;
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          customCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Professional Information',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                // Experience Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedExperience,
                  decoration: const InputDecoration(
                    labelText: 'Years of Experience',
                    prefixIcon: Icon(Icons.work_outlined),
                  ),
                  items: _experienceOptions.map((exp) {
                    return DropdownMenuItem(value: exp, child: Text(exp));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedExperience = value);
                  },
                ),

                const SizedBox(height: 20),

                // Expertise Areas
                Text(
                  'Areas of Expertise',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select your areas of expertise (choose multiple)',
                  style: TextStyle(color: kOnSurfaceVariant, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _expertiseOptions.map((expertise) {
                    final isSelected = _selectedExpertise.contains(expertise);
                    return FilterChip(
                      label: Text(expertise),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedExpertise.add(expertise);
                          } else {
                            _selectedExpertise.remove(expertise);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Bio
                TextFormField(
                  controller: _bioController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Professional Bio',
                    hintText:
                        'Tell students about your background and experience...',
                    helperText: 'Minimum 50 characters',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your bio';
                    }
                    if (value!.trim().length < 50) {
                      return 'Bio must be at least 50 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // LinkedIn URL
                TextFormField(
                  controller: _linkedinController,
                  decoration: const InputDecoration(
                    labelText: 'LinkedIn Profile (Optional)',
                    hintText: 'https://linkedin.com/in/yourprofile',
                    prefixIcon: Icon(Icons.link),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          customCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Availability & Preferences',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                // Languages
                Text(
                  'Languages Spoken',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select languages you can mentor in',
                  style: TextStyle(color: kOnSurfaceVariant, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _languageOptions.map((language) {
                    final isSelected = _selectedLanguages.contains(language);
                    return FilterChip(
                      label: Text(language),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedLanguages.add(language);
                          } else {
                            _selectedLanguages.remove(language);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Timezone
                DropdownButtonFormField<String>(
                  value: _selectedTimezone,
                  decoration: const InputDecoration(
                    labelText: 'Time Zone',
                    prefixIcon: Icon(Icons.schedule),
                  ),
                  items: _timezoneOptions.map((tz) {
                    return DropdownMenuItem(value: tz, child: Text(tz));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedTimezone = value);
                  },
                ),

                const SizedBox(height: 20),

                // Availability
                Text(
                  'Availability Slots',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'When are you typically available for mentoring?',
                  style: TextStyle(color: kOnSurfaceVariant, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _availabilityOptions.map((slot) {
                    final isSelected = _selectedAvailability.contains(slot);
                    return FilterChip(
                      label: Text(slot),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedAvailability.add(slot);
                          } else {
                            _selectedAvailability.remove(slot);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
