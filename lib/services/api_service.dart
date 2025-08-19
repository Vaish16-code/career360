import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL for backend (use 10.0.2.2 for Android emulator)
  static const base = "http://10.0.2.2:5000/api/auth";

  // ========== DUMMY CREDENTIALS FOR TESTING ==========
  // Remove this section when connecting to real database
  static const Map<String, Map<String, dynamic>> dummyUsers = {
    // Student credentials
    'student@test.com': {
      'password': 'Student123!',
      'role': 'student',
      'name': 'John Student',
      'email': 'student@test.com',
    },
    // Mentor credentials
    'mentor@test.com': {
      'password': 'Mentor123!',
      'role': 'mentor',
      'name': 'Dr. Sarah Mentor',
      'email': 'mentor@test.com',
    },
  };

  // Helper method to check dummy credentials
  static Map<String, dynamic>? _checkDummyLogin(String email, String password) {
    if (dummyUsers.containsKey(email)) {
      final user = dummyUsers[email]!;
      if (user['password'] == password) {
        return {
          'user': {
            'role': user['role'],
            'name': user['name'],
            'email': user['email'],
          },
        };
      }
    }
    return null;
  }
  // ========== END DUMMY CREDENTIALS ==========

  /// Student Registration
  static Future<Map<String, dynamic>> registerStudent({
    required String name,
    required String email,
    required String password,
    required String bio,
    required String education,
    required List<String> interests,
  }) async {
    final res = await http.post(
      Uri.parse("$base/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "role": "student",
        "name": name,
        "email": email,
        "password": password,
        "bio": bio,
        "education": education,
        "interests": interests,
      }),
    );
    return _json(res);
  }

  /// Mentor Registration
  static Future<Map<String, dynamic>> registerMentor({
    required String name,
    required String email,
    required String password,
    required String bio,
    required List<String> expertise,
    required List<String> availability,
  }) async {
    final res = await http.post(
      Uri.parse("$base/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "role": "mentor",
        "name": name,
        "email": email,
        "password": password,
        "bio": bio,
        "expertise": expertise,
        "availability": availability,
      }),
    );
    return _json(res);
  }

  /// Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    // Check dummy credentials first (remove when using real DB)
    final dummyResult = _checkDummyLogin(email, password);
    if (dummyResult != null) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return dummyResult;
    }

    // If dummy credentials don't match, proceed with real API call
    final res = await http.post(
      Uri.parse("$base/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    return _json(res);
  }

  /// Handle JSON + Errors
  static Map<String, dynamic> _json(http.Response r) {
    final body = r.body.isEmpty ? {} : jsonDecode(r.body);
    if (r.statusCode >= 200 && r.statusCode < 300) return body;
    return {"error": body["error"] ?? "Unknown error (${r.statusCode})"};
  }
}
