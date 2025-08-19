import 'package:flutter/material.dart';

const kPurple = Color(0xFF7C4DFF); // close to your screenshots
const kGradientStart = Color(0xFF6C63FF);
const kGradientEnd = Color(0xFFB388FF);

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF7F5FF),
    colorScheme: ColorScheme.fromSeed(seedColor: kPurple),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E0FF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE5E0FF)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: kGradientStart,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

Widget gradientButtonChild(String text) => Container(
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    gradient: LinearGradient(colors: [kGradientStart, kGradientEnd]),
    borderRadius: BorderRadius.all(Radius.circular(14)),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  ),
);
